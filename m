Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] LIBS vs LD_FLAGS in bluez-utils makefiles
From: Marcel Holtmann <marcel@holtmann.org>
To: Franck Arnaud <franck@nenie.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1085154828.22191.3.camel@pegasus>
References: <45540213.2004.5.20.21.35.29.45662@mem.nenie.org>
	 <1085154828.22191.3.camel@pegasus>
Content-Type: multipart/mixed; boundary="=-gOrjLSrokGXfvfPpJy1T"
Message-Id: <1085157658.22191.20.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 21 May 2004 18:40:59 +0200


--=-gOrjLSrokGXfvfPpJy1T
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Franck,

> I am happy to apply your patch, but this is not what I want. Tools like
> hciattach, hid2hci or hcisecfilter don't need to link -lbluetooth. What
> is the correct way of solving this?

may you wanna check this patch first, before I am going to apply it.

Regards

Marcel


--=-gOrjLSrokGXfvfPpJy1T
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Index: cups/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/cups/Makefile.am,v
retrieving revision 1.1
diff -u -b -w -B -r1.1 Makefile.am
--- cups/Makefile.am	2 May 2004 03:37:08 -0000	1.1
+++ cups/Makefile.am	21 May 2004 16:38:47 -0000
@@ -6,7 +6,7 @@
 
 bluetooth_SOURCES = main.c sdp.c spp.c hcrp.c
 
-LDFLAGS = @BLUEZ_LIBS@
+LIBS = @BLUEZ_LIBS@
 
 INCLUDES = @BLUEZ_INCLUDES@
 
Index: dund/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/dund/Makefile.am,v
retrieving revision 1.1
diff -u -b -w -B -r1.1 Makefile.am
--- dund/Makefile.am	25 Apr 2004 22:03:22 -0000	1.1
+++ dund/Makefile.am	21 May 2004 16:38:48 -0000
@@ -6,7 +6,7 @@
 
 dund_SOURCES = main.c dun.c dund.h sdp.c lib.h msdun.c
 
-LDFLAGS = @BLUEZ_LIBS@
+LIBS = @BLUEZ_LIBS@
 
 INCLUDES = @BLUEZ_INCLUDES@
 
Index: hcid/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/Makefile.am,v
retrieving revision 1.15
diff -u -b -w -B -r1.15 Makefile.am
--- hcid/Makefile.am	7 May 2004 23:08:02 -0000	1.15
+++ hcid/Makefile.am	21 May 2004 16:38:50 -0000
@@ -6,18 +6,18 @@
 
 if DBUS
 dbus_hcid_sources = dbus.c
-dbus_hcid_ldflags = @DBUS_LIBS@
+dbus_hcid_libs    = @DBUS_LIBS@
 dbus_hcid_cflags  = -DENABLE_DBUS -DDBUS_API_SUBJECT_TO_CHANGE
 else
 dbus_hcid_sources =
-dbus_hcid_ldflags =
+dbus_hcid_libs    =
 dbus_hcid_cflags  =
 endif
 
 hcid_SOURCES = main.c security.c hcid.h lib.c lib.h parser.h parser.y lexer.l kword.h kword.c glib-ectomy.h glib-ectomy.c $(dbus_hcid_sources)
 hcid_CONFIG  = hcid.conf
 
-LDFLAGS = $(dbus_hcid_ldflags) @BLUEZ_LIBS@
+LIBS = $(dbus_hcid_libs) @BLUEZ_LIBS@
 
 INCLUDES = @BLUEZ_INCLUDES@ @DBUS_INCLUDES@ $(dbus_hcid_cflags)
 
Index: hidd/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/hidd/Makefile.am,v
retrieving revision 1.2
diff -u -b -w -B -r1.2 Makefile.am
--- hidd/Makefile.am	7 May 2004 22:34:29 -0000	1.2
+++ hidd/Makefile.am	21 May 2004 16:38:50 -0000
@@ -6,6 +6,6 @@
 
 hidd_SOURCES = main.c hidd.h sdp.c
 
-LDFLAGS = @BLUEZ_LIBS@
+LIBS = @BLUEZ_LIBS@
 
 INCLUDES = @BLUEZ_INCLUDES@
Index: pand/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/pand/Makefile.am,v
retrieving revision 1.1
diff -u -b -w -B -r1.1 Makefile.am
--- pand/Makefile.am	25 Apr 2004 21:54:23 -0000	1.1
+++ pand/Makefile.am	21 May 2004 16:38:50 -0000
@@ -6,7 +6,7 @@
 
 pand_SOURCES = main.c pand.h bnep.c sdp.c
 
-LDFLAGS = @BLUEZ_LIBS@
+LIBS = @BLUEZ_LIBS@
 
 INCLUDES = @BLUEZ_INCLUDES@
 
Index: rfcomm/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/rfcomm/Makefile.am,v
retrieving revision 1.8
diff -u -b -w -B -r1.8 Makefile.am
--- rfcomm/Makefile.am	3 Apr 2004 06:05:22 -0000	1.8
+++ rfcomm/Makefile.am	21 May 2004 16:38:52 -0000
@@ -9,7 +9,7 @@
 rfcomm_SOURCES = main.c parser.h parser.y lexer.l kword.h kword.c
 rfcomm_CONFIG  = rfcomm.conf
 
-LDFLAGS = @BLUEZ_LIBS@
+LIBS = @BLUEZ_LIBS@
 
 INCLUDES = @BLUEZ_INCLUDES@
 
Index: sdpd/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/sdpd/Makefile.am,v
retrieving revision 1.5
diff -u -b -w -B -r1.5 Makefile.am
--- sdpd/Makefile.am	3 Apr 2004 06:05:08 -0000	1.5
+++ sdpd/Makefile.am	21 May 2004 16:38:52 -0000
@@ -6,7 +6,7 @@
 
 sdpd_SOURCES = main.c request.c service.c cstate.c servicedb.c sdpd.h
 
-LDFLAGS = @BLUEZ_LIBS@
+LIBS = @BLUEZ_LIBS@
 
 INCLUDES = @BLUEZ_INCLUDES@
 
Index: test/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/test/Makefile.am,v
retrieving revision 1.3
diff -u -b -w -B -r1.3 Makefile.am
--- test/Makefile.am	3 Apr 2004 06:06:03 -0000	1.3
+++ test/Makefile.am	21 May 2004 16:38:52 -0000
@@ -4,7 +4,7 @@
 
 noinst_PROGRAMS	= l2test scotest rctest attest hstest
 
-LDFLAGS = @BLUEZ_LIBS@
+LIBS = @BLUEZ_LIBS@
 
 INCLUDES = @BLUEZ_INCLUDES@
 
Index: tools/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/tools/Makefile.am,v
retrieving revision 1.16
diff -u -b -w -B -r1.16 Makefile.am
--- tools/Makefile.am	24 Apr 2004 11:22:47 -0000	1.16
+++ tools/Makefile.am	21 May 2004 16:38:54 -0000
@@ -10,17 +10,17 @@
 
 hciconfig_SOURCES = hciconfig.c csr.h csr.c
 
-hciconfig_LDFLAGS = @BLUEZ_LIBS@
+hciconfig_LDADD = @BLUEZ_LIBS@
 
-hcitool_LDFLAGS = @BLUEZ_LIBS@
+hcitool_LDADD = @BLUEZ_LIBS@
 
-l2ping_LDFLAGS = @BLUEZ_LIBS@
+l2ping_LDADD = @BLUEZ_LIBS@
 
-sdptool_LDFLAGS = @BLUEZ_LIBS@
+sdptool_LDADD = @BLUEZ_LIBS@
 
-ciptool_LDFLAGS = @BLUEZ_LIBS@
+ciptool_LDADD = @BLUEZ_LIBS@
 
-ppporc_LDFLAGS = @BLUEZ_LIBS@
+ppporc_LDADD = @BLUEZ_LIBS@
 
 INCLUDES = @BLUEZ_INCLUDES@
 

--=-gOrjLSrokGXfvfPpJy1T--



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
