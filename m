Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: Bluez-devel@lists.sourceforge.net
Date: Tue, 6 Feb 2007 15:13:32 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_85AyFUZZW/Uoyk2"
Message-Id: <200702061513.32173.denis.kenzior@trolltech.com>
Subject: [Bluez-devel] [PATCH] Minor issues with sdp-xml
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

--Boundary-00=_85AyFUZZW/Uoyk2
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Marcel,

This patch fixes up a couple of minor bugs I found.

-Denis

--Boundary-00=_85AyFUZZW/Uoyk2
Content-Type: text/x-diff;
  charset="us-ascii";
  name="sdp-xml.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sdp-xml.patch"

Index: sdp-xml.c
===================================================================
RCS file: /cvsroot/bluez/utils/common/sdp-xml.c,v
retrieving revision 1.7
diff -u -r1.7 sdp-xml.c
--- sdp-xml.c	20 Jan 2007 21:28:02 -0000	1.7
+++ sdp-xml.c	6 Feb 2007 05:12:31 -0000
@@ -265,7 +265,7 @@
 		if (hex) {
 			appender(data, "encoding=\"hex\" ");
 			strBuf = (char *) malloc(sizeof(char)
-						 * (value->unitSize * 2 + 1));
+						 * ((value->unitSize-1) * 2 + 1));
 
 			/* Unit Size seems to include the size for dtd
 			   It is thus off by 1
@@ -276,7 +276,7 @@
 					"%02x",
 					(unsigned char) value->val.str[i]);
 
-			strBuf[value->unitSize * 2] = '\0';
+			strBuf[(value->unitSize-1) * 2] = '\0';
 		}
 		else {
 			int j;
@@ -603,7 +603,7 @@
 			buf[0] = data[i];
 			buf[1] = data[i + 1];
 
-			val.data[i] = strtoul(buf, 0, 16);
+			val.data[i >> 1] = strtoul(buf, 0, 16);
 		}
 
 		ret = sdp_data_alloc(dtd, &val);

--Boundary-00=_85AyFUZZW/Uoyk2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--Boundary-00=_85AyFUZZW/Uoyk2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_85AyFUZZW/Uoyk2--
