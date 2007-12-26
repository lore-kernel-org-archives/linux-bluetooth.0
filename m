Return-Path: <cyrus@holtmann.org>
Message-ID: <47725DEF.7070302@mizi.com>
Date: Wed, 26 Dec 2007 22:58:07 +0900
From: Louis JANG <louis@mizi.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="------------030408010106040904000104"
Subject: [Bluez-devel] [PATCH] align issue of sdpd
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

This is a multi-part message in MIME format.
--------------030408010106040904000104
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit

Hi,

Because of alignment issue, sdpd couldn't handle continuation
information correctly in arm architecture. the following is patch for
this issue.

Regards,
Louis JANG


--------------030408010106040904000104
Content-Type: text/x-patch;
 name="sdpd.h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sdpd.h.patch"

--- bluez-utils-3.9/sdpd/sdpd.h.orig	2007-12-26 22:46:40.000000000 +0900
+++ bluez-utils-3.9/sdpd/sdpd.h	2007-12-26 22:47:08.000000000 +0900
@@ -47,7 +47,7 @@
 void register_public_browse_group(int public);
 void register_server_service(int public);
 
-typedef struct {
+typedef struct __attribute__((packed)) {
 	uint32_t timestamp;
 	union {
 		uint16_t maxBytesSent;

--------------030408010106040904000104
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--------------030408010106040904000104
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------030408010106040904000104--
