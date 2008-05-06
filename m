Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4820230F.2060306@suse.de>
References: <1210038664.15029.20.camel@violet.holtmann.net>
	<4820230F.2060306@suse.de>
Content-Type: multipart/mixed; boundary="=-r6fjwXeMWQ3Ov0ZwhO3i"
Date: Tue, 06 May 2008 10:36:28 +0100
Message-Id: <1210066588.2755.27.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [BlueZ-Announce] Release of bluez-libs-3.31
	and	bluez-utils-3.31
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-r6fjwXeMWQ3Ov0ZwhO3i
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Tue, 2008-05-06 at 11:21 +0200, Stefan Seyfried wrote:
> Marcel Holtmann wrote:
> > Hi Folks,
> > 
> > this is an update release of the new stable versions of the Bluetooth
> > library and the utilities. This release fixes various bugs from the
> > plugin transition and introduces the first attempts of creating a
> > Bluetooth helper library for GLib.
> > 
> > Currently the full service infrastructure is still available, but with
> > the next release this might change. So please prepare yourself it.
> 
> Might be an issue with my build, but i get this
> 
> hcid[32361]: Can't load plugin: /usr/lib64/bluetooth/plugins/libserial.so:
> undefined symbol: g_ascii_isxdigit
> 
> I did not change anything in the build system (apart from removing
> "--enable-glib" again).

This should make "make distcheck" barf out if there are missing symbols
in eglib that are used by plugins.

Cheers

--=-r6fjwXeMWQ3Ov0ZwhO3i
Content-Disposition: attachment; filename=bluez-utils-tighter-distflags.patch
Content-Type: text/x-patch; name=bluez-utils-tighter-distflags.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/Makefile.am,v
retrieving revision 1.41
diff -u -p -r1.41 Makefile.am
--- Makefile.am	12 Mar 2008 21:47:42 -0000	1.41
+++ Makefile.am	6 May 2008 09:32:52 -0000
@@ -7,3 +7,5 @@ SUBDIRS = doc sbc eglib common sdpd hcid
 MAINTAINERCLEANFILES = Makefile.in \
 	aclocal.m4 configure config.h.in config.sub config.guess \
 	ltmain.sh depcomp missing install-sh mkinstalldirs compile ylwrap
+
+DISTCHECK_CONFIGURE_FLAGS = --enable-glib=no
Index: audio/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/audio/Makefile.am,v
retrieving revision 1.50
diff -u -p -r1.50 Makefile.am
--- audio/Makefile.am	28 Mar 2008 20:53:12 -0000	1.50
+++ audio/Makefile.am	6 May 2008 09:32:52 -0000
@@ -11,7 +11,7 @@ libaudio_la_SOURCES = main.c \
 	sink.c sink.h avdtp.c avdtp.h \
 	a2dp.c a2dp.h control.c control.h
 
-libaudio_la_LDFLAGS = -module -avoid-version -export-symbols-regex bluetooth_plugin_desc
+libaudio_la_LDFLAGS = -no-undefined -module -avoid-version -export-symbols-regex bluetooth_plugin_desc
 
 LDADD = $(top_builddir)/common/libhelper.a \
 		@GLIB_LIBS@ @DBUS_LIBS@ @BLUEZ_LIBS@
@@ -46,7 +46,7 @@ libgstbluetooth_la_SOURCES = gstbluetoot
 				gstsbcutil.h gstsbcutil.c \
 				gstrtpsbcpay.h gstrtpsbcpay.c \
 				rtp.h ipc.h ipc.c
-libgstbluetooth_la_LDFLAGS = -module -avoid-version -export-symbols-regex gst_plugin_desc
+libgstbluetooth_la_LDFLAGS = -no-undefined -module -avoid-version -export-symbols-regex gst_plugin_desc
 libgstbluetooth_la_LIBADD = @SBC_LIBS@ @GSTREAMER_LIBS@ -lgstaudio-0.10 -lgstrtp-0.10
 libgstbluetooth_la_CFLAGS = @GSTREAMER_CFLAGS@ @SBC_CFLAGS@
 endif
Index: input/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/input/Makefile.am,v
retrieving revision 1.20
diff -u -p -r1.20 Makefile.am
--- input/Makefile.am	22 Mar 2008 15:37:36 -0000	1.20
+++ input/Makefile.am	6 May 2008 09:32:53 -0000
@@ -13,7 +13,7 @@ LDADD = $(top_builddir)/common/libhelper
 		@GLIB_LIBS@ @DBUS_LIBS@ @BLUEZ_LIBS@
 endif
 
-AM_LDFLAGS = -module -avoid-version -export-symbols-regex bluetooth_plugin_desc
+AM_LDFLAGS = -no-undefined -module -avoid-version -export-symbols-regex bluetooth_plugin_desc
 
 AM_CFLAGS = @BLUEZ_CFLAGS@ @DBUS_CFLAGS@ @GLIB_CFLAGS@
 
Index: network/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/network/Makefile.am,v
retrieving revision 1.19
diff -u -p -r1.19 Makefile.am
--- network/Makefile.am	26 Mar 2008 18:17:27 -0000	1.19
+++ network/Makefile.am	6 May 2008 09:32:53 -0000
@@ -13,7 +13,7 @@ LDADD = $(top_builddir)/common/libhelper
 		@GLIB_LIBS@ @DBUS_LIBS@ @BLUEZ_LIBS@
 endif
 
-AM_LDFLAGS = -module -avoid-version -export-symbols-regex bluetooth_plugin_desc
+AM_LDFLAGS = -no-undefined -module -avoid-version -export-symbols-regex bluetooth_plugin_desc
 
 AM_CFLAGS = @BLUEZ_CFLAGS@ @DBUS_CFLAGS@ @GLIB_CFLAGS@
 
Index: plugins/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/plugins/Makefile.am,v
retrieving revision 1.9
diff -u -p -r1.9 Makefile.am
--- plugins/Makefile.am	5 Apr 2008 06:37:08 -0000	1.9
+++ plugins/Makefile.am	6 May 2008 09:32:53 -0000
@@ -9,7 +9,7 @@ noinst_LTLIBRARIES = libecho.la
 
 libecho_la_SOURCES = echo.c
 
-AM_LDFLAGS = -module -avoid-version -export-symbols-regex bluetooth_plugin_desc
+AM_LDFLAGS = -no-undefined -module -avoid-version -export-symbols-regex bluetooth_plugin_desc
 
 AM_CFLAGS = @BLUEZ_CFLAGS@ @DBUS_CFLAGS@ @GLIB_CFLAGS@
 
Index: serial/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/serial/Makefile.am,v
retrieving revision 1.10
diff -u -p -r1.10 Makefile.am
--- serial/Makefile.am	27 Mar 2008 18:12:33 -0000	1.10
+++ serial/Makefile.am	6 May 2008 09:32:53 -0000
@@ -12,7 +12,7 @@ LDADD = $(top_builddir)/common/libhelper
 		@GLIB_LIBS@ @DBUS_LIBS@ @BLUEZ_LIBS@
 endif
 
-AM_LDFLAGS = -module -avoid-version -export-symbols-regex bluetooth_plugin_desc
+AM_LDFLAGS = -no-undefined -module -avoid-version -export-symbols-regex bluetooth_plugin_desc
 
 AM_CFLAGS = @BLUEZ_CFLAGS@ @DBUS_CFLAGS@ @GLIB_CFLAGS@
 

--=-r6fjwXeMWQ3Ov0ZwhO3i
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--=-r6fjwXeMWQ3Ov0ZwhO3i
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-r6fjwXeMWQ3Ov0ZwhO3i--
