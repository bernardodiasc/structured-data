<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="html"/>
  
  <xsl:template match="/">
    <xsl:for-each select="/data/brands/brand">
      <xsl:variable name="brandid" select="id"/>
      <xsl:variable name="brandname" select="name"/>
      <h2><xsl:value-of select="name"/></h2>
      <strong>Retailers</strong>
      <ul>
        <xsl:for-each select="/data/retailers/retailer[id = (/data/products/product[brand = $brandid]/retailers/retailer/id)]">
          <xsl:variable name="retailerid" select="id"/>
          <xsl:variable name="retailername" select="name"/>
          <li>
            <xsl:value-of select="name"/>
            <br/>
            <small>
              <strong><xsl:value-of select="$brandname"/></strong>
              <xsl:text> products available on </xsl:text>
              <strong><xsl:value-of select="$retailername"/></strong>
              <xsl:text>: </xsl:text>
              (<xsl:value-of select="count(/data/products/product[retailers/retailer/id = $retailerid and brand = $brandid])"/>)
            </small>
            <ul>
              <xsl:for-each select="/data/products/product[retailers/retailer/id = $retailerid and brand = $brandid]">
                <li>
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