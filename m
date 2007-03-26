Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Daniel Gollub <dgollub@suse.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Mon, 26 Mar 2007 19:35:11 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QRACGyz9Lht4/QL"
Message-Id: <200703261935.12536.dgollub@suse.de>
Subject: [Bluez-devel] Avoid install of daemon manpage if daemon is disabled
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--Boundary-00=_QRACGyz9Lht4/QL
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

simple patch for $subject is attachted.

best regards,
Daniel

--Boundary-00=_QRACGyz9Lht4/QL
Content-Type: text/x-diff; charset="us-ascii";
	name="bluez-utils-avoid-manpage-install.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bluez-utils-avoid-manpage-install.diff"

Index: hcid/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/Makefile.am,v
retrieving revision 1.73
diff -u -p -r1.73 Makefile.am
--- hcid/Makefile.am	25 Jan 2007 15:09:26 -0000	1.73
+++ hcid/Makefile.am	26 Mar 2007 17:24:49 -0000
@@ -41,7 +41,9 @@ INCLUDES = -I$(top_srcdir)/common -I$(to
 
 BUILT_SOURCES = parser.h
 
+if HCID
 man_MANS = hcid.8 hcid.conf.5
+endif
 
 AM_YFLAGS = -d
 
Index: hidd/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/hidd/Makefile.am,v
retrieving revision 1.15
diff -u -p -r1.15 Makefile.am
--- hidd/Makefile.am	13 Feb 2007 14:49:59 -0000	1.15
+++ hidd/Makefile.am	26 Mar 2007 17:24:49 -0000
@@ -11,7 +11,9 @@ AM_CFLAGS = @BLUEZ_CFLAGS@
 
 INCLUDES = -I$(top_srcdir)/common
 
+if HIDD
 man_MANS = hidd.1
+endif
 
 EXTRA_DIST = $(man_MANS) fakehid.txt
 
Index: pand/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/pand/Makefile.am,v
retrieving revision 1.8
diff -u -p -r1.8 Makefile.am
--- pand/Makefile.am	21 Mar 2007 21:33:15 -0000	1.8
+++ pand/Makefile.am	26 Mar 2007 17:24:49 -0000
@@ -11,7 +11,9 @@ AM_CFLAGS = @BLUEZ_CFLAGS@
 
 INCLUDES = -I$(top_srcdir)/common
 
+if PAND
 man_MANS = pand.1
+endif
 
 EXTRA_DIST = $(man_MANS)
 
Index: sdpd/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/sdpd/Makefile.am,v
retrieving revision 1.18
diff -u -p -r1.18 Makefile.am
--- sdpd/Makefile.am	20 Jan 2007 05:26:20 -0000	1.18
+++ sdpd/Makefile.am	26 Mar 2007 17:24:50 -0000
@@ -17,7 +17,9 @@ AM_CFLAGS = @BLUEZ_CFLAGS@ @GLIB_CFLAGS@
 
 INCLUDES = -I$(top_srcdir)/common
 
+if SDPD
 man_MANS = sdpd.8
+endif
 
 EXTRA_DIST = $(man_MANS)
 

--Boundary-00=_QRACGyz9Lht4/QL
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_QRACGyz9Lht4/QL
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_QRACGyz9Lht4/QL--
