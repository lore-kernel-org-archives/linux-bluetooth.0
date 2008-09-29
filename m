Return-Path: <cyrus@holtmann.org>
Message-ID: <48E05F49.7070501@dtsp.co.nz>
Date: Mon, 29 Sep 2008 17:53:29 +1300
From: David Sainty <david.sainty@dtsp.co.nz>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Minor error in BlueZ 4.8 Makefile.am can break build
Content-Type: multipart/mixed;
 boundary="------------090809020900040204000602"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------090809020900040204000602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

There's a missing backslash in the plugins/Makefile.am file in the 4.8 
release (see patches).

Cheers,

Dave

--------------090809020900040204000602
Content-Type: text/plain;
 name="patch-aa"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-aa"

$NetBSD$

Fix for missing backslash in Makefile.am.

--- plugins/Makefile.in.orig	2008-09-29 16:15:13.007562391 +1300
+++ plugins/Makefile.in	2008-09-29 16:15:41.627994124 +1300
@@ -235,7 +235,9 @@
 AM_LDFLAGS = -module -avoid-version -no-undefined \
 			-export-symbols-regex bluetooth_plugin_desc
 
-AM_CFLAGS = @BLUEZ_CFLAGS@ @DBUS_CFLAGS@ @GLIB_CFLAGS@
+AM_CFLAGS = @BLUEZ_CFLAGS@ @DBUS_CFLAGS@ @GLIB_CFLAGS@ \
+					@GDBUS_CFLAGS@ @NETLINK_CFLAGS@
+
 INCLUDES = -I$(top_srcdir)/common -I$(top_srcdir)/src
 MAINTAINERCLEANFILES = Makefile.in
 all: all-am
@@ -539,7 +541,6 @@
 	pdf pdf-am ps ps-am tags uninstall uninstall-am \
 	uninstall-pluginLTLIBRARIES
 
-					@GDBUS_CFLAGS@ @NETLINK_CFLAGS@
 
 all-local:
 	@$(LN_S) -f $(top_srcdir)/input/.libs/input.so

--------------090809020900040204000602
Content-Type: text/x-diff;
 name="gdbus.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gdbus.diff"

--- plugins/Makefile.am.orig	2008-09-29 16:09:39.972538634 +1300
+++ plugins/Makefile.am	2008-09-29 16:09:48.862672739 +1300
@@ -34,7 +34,7 @@
 AM_LDFLAGS = -module -avoid-version -no-undefined \
 			-export-symbols-regex bluetooth_plugin_desc
 
-AM_CFLAGS = @BLUEZ_CFLAGS@ @DBUS_CFLAGS@ @GLIB_CFLAGS@
+AM_CFLAGS = @BLUEZ_CFLAGS@ @DBUS_CFLAGS@ @GLIB_CFLAGS@ \
 					@GDBUS_CFLAGS@ @NETLINK_CFLAGS@
 
 INCLUDES = -I$(top_srcdir)/common -I$(top_srcdir)/src

--------------090809020900040204000602--
