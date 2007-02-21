Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45DC6F15.8010908@access-company.com>
Date: Wed, 21 Feb 2007 17:11:01 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: bluez development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------040904070009090304060104"
Subject: [Bluez-devel] [patch]  updates rfcomm man page
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

This is a multi-part message in MIME format.
--------------040904070009090304060104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch updates rfcomm man page!

-- 
Frederic

Without the wind, the grass does not move.


--------------040904070009090304060104
Content-Type: text/x-patch;
 name="rfcomm-man.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rfcomm-man.patch"

? rfcomm/Makefile.in
? rfcomm/cvs
Index: rfcomm/rfcomm.1
===================================================================
RCS file: /cvsroot/bluez/utils/rfcomm/rfcomm.1,v
retrieving revision 1.6
diff -u -r1.6 rfcomm.1
--- rfcomm/rfcomm.1	24 Dec 2006 13:49:04 -0000	1.6
+++ rfcomm/rfcomm.1	21 Feb 2007 16:10:30 -0000
@@ -53,6 +53,14 @@
 .TP
 .BI -i " <hciX> | <bdaddr>"
 The command is applied to device
+.BI -A
+Enable authentification
+.BI -E
+Enable encryption
+.BI -S
+Secure connection
+.BI -M
+Become the master of a piconet
 .I
 hciX
 , which must be the name or the address of an installed Bluetooth

--------------040904070009090304060104
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------040904070009090304060104
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------040904070009090304060104--
