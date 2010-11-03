Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann
	<marcel@holtmann.org>, Waldemar Rymarkiewicz
	<waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH] Remove doc/bluez-docs.xml.
Date: Wed, 3 Nov 2010 16:55:02 +0100
Message-ID: <1288799702-17309-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

doc/bluez-docs.xml seems to be obsolate and not used anymore.
---
 doc/bluez-docs.xml |   97 ----------------------------------------------------
 1 files changed, 0 insertions(+), 97 deletions(-)
 delete mode 100644 doc/bluez-docs.xml

diff --git a/doc/bluez-docs.xml b/doc/bluez-docs.xml
deleted file mode 100644
index 74a8bd1..0000000
--- a/doc/bluez-docs.xml
+++ /dev/null
@@ -1,97 +0,0 @@
-<?xml version="1.0"?>
-<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
-               "http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" [
-<!ENTITY version SYSTEM "version.xml">
-]>
-<book id="index" xmlns:xi="http://www.w3.org/2003/XInclude">
-  <bookinfo>
-    <title>BlueZ Reference Manual</title>
-    <releaseinfo>Version &version;</releaseinfo>
-    <authorgroup>
-      <author>
-	<firstname>Marcel</firstname>
-	<surname>Holtmann</surname>
-	<affiliation>
-	  <address>
-	    <email>marcel@holtmann.org</email>
-	  </address>
-	</affiliation>
-      </author>
-    </authorgroup>
-
-    <copyright>
-      <year>2002-2008</year>
-      <holder>Marcel Holtmann</holder>
-    </copyright>
-
-    <legalnotice>
-      <para>
-	Permission is granted to copy, distribute and/or modify this
-	document under the terms of the <citetitle>GNU Free
-	Documentation License</citetitle>, Version 1.1 or any later
-	version published by the Free Software Foundation with no
-	Invariant Sections, no Front-Cover Texts, and no Back-Cover
-	Texts. You may obtain a copy of the <citetitle>GNU Free
-	Documentation License</citetitle> from the Free Software
-	Foundation by visiting <ulink type="http"
-	url="http://www.fsf.org">their Web site</ulink> or by writing
-	to:
-
-	<address>
-	  The Free Software Foundation, Inc.,
-	  <street>59 Temple Place</street> - Suite 330,
-	  <city>Boston</city>, <state>MA</state> <postcode>02111-1307</postcode>,
-	  <country>USA</country>
-	</address>
-      </para>
-    </legalnotice>
-  </bookinfo>
-
-  <reference id="manager">
-    <title>Manager interface</title>
-    <para>
-<programlisting><xi:include href="manager-api.txt" parse="text" /></programlisting>
-    </para>
-  </reference>
-
-  <reference id="adapter">
-    <title>Adapter interface</title>
-    <para>
-<programlisting><xi:include href="adapter-api.txt" parse="text" /></programlisting>
-    </para>
-  </reference>
-
-  <reference id="device">
-    <title>Device interface</title>
-    <para>
-<programlisting><xi:include href="device-api.txt" parse="text" /></programlisting>
-    </para>
-  </reference>
-
-  <reference id="agent">
-    <title>Agent interface</title>
-    <para>
-<programlisting><xi:include href="agent-api.txt" parse="text" /></programlisting>
-    </para>
-  </reference>
-
-  <reference id="reference">
-    <title>API Reference</title>
-    <partintro>
-      <para>
-	This part presents the function reference for BlueZ.
-      </para>
-    </partintro>
-  </reference>
-
-  <appendix id="license">
-    <title>License</title>
-    <para>
-<programlisting><xi:include href="../COPYING" parse="text" /></programlisting>
-    </para>
-  </appendix>
-
-  <index>
-    <title>Index</title>
-  </index>
-</book>
-- 
1.7.0.4
