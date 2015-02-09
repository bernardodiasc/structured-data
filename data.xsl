<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="html"/>
  
  <xsl:template match="/">
    <!-- Loop through all brands -->
    <xsl:for-each select="/data/brands/brand">
      <xsl:variable name="brandid" select="id"/>
      <xsl:variable name="brandname" select="name"/>

      <!-- Get the name of the Brand -->
      <h2><xsl:value-of select="name"/></h2>

      <!-- Get the second paragraph of the text -->
      <xsl:copy-of select="text/p[position() = 2]"/>

      <!-- Loop through retailers that sells products of this brand -->
      <strong>Retailers</strong>
      <ul>
        <xsl:for-each select="/data/retailers/retailer[id = (/data/products/product[brand = $brandid]/retailers/retailer/id)]">
          <xsl:variable name="retailerid" select="id"/>
          <xsl:variable name="retailername" select="name"/>

          <li>
            <!-- Get the name of the retailer -->
            <xsl:value-of select="name"/>
            <br/>

            <!-- Count products from this brand and retail -->
            <small>
              <strong><xsl:value-of select="$brandname"/></strong>
              <xsl:text> products available on </xsl:text>
              <strong><xsl:value-of select="$retailername"/></strong>
              <xsl:text>: </xsl:text>
              (<xsl:value-of select="count(/data/products/product[retailers/retailer/id = $retailerid and brand = $brandid])"/>)
            </small>

            <!-- Loop through products from this brand and retail -->
            <ul>
              <xsl:for-each select="/data/products/product[retailers/retailer/id = $retailerid and brand = $brandid]">
                <li>

                  <!-- Get the name of the product -->
                  <xsl:value-of select="name"/>
                </li>
              </xsl:for-each>
            </ul>
            <hr/>
          </li>
        </xsl:for-each>
      </ul>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>