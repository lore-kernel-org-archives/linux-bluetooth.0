Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060603135708.GB13263@esaurito.net>
References: <20060603135708.GB13263@esaurito.net>
Content-Type: multipart/mixed; boundary="=-5NDQ2jtWD/tUFE3ZEkGZ"
Date: Sun, 04 Jun 2006 15:19:21 +0200
Message-Id: <1149427161.8053.3.camel@localhost>
Mime-Version: 1.0
Cc: bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] [PATCH] rfcomm 'anycommand' bug
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


--=-5NDQ2jtWD/tUFE3ZEkGZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Filippo,

> attached there is a new patch (using tabs, "set noet" for the vim lovers) for
> rfcomm, agreed it could be better. I hope it is clear enough.

now the patch is readable, but it is still worse. However it helped me
to understand what you tried to achieve. I fixed it with the attached
patch.

Regards

Marcel


--=-5NDQ2jtWD/tUFE3ZEkGZ
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

? .deps
? .libs
? Makefile
? Makefile.in
? lexer.c
? parser.c
? parser.h
? rfcomm
Index: main.c
===================================================================
RCS file: /cvsroot/bluez/utils/rfcomm/main.c,v
retrieving revision 1.16
diff -u -r1.16 main.c
--- main.c	3 Jan 2006 13:29:01 -0000	1.16
+++ main.c	4 Jun 2006 13:17:13 -0000
@@ -621,8 +621,13 @@
 	argv += optind;
 	optind = 0;
 
-	if (argc < 2)
-		show_all = 1;
+	if (argc < 2) {
+		if (argc != 0) {
+			usage();
+			exit(1);
+		} else
+			show_all = 1;
+	}
 
 	if ((ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_RFCOMM)) < 0 ) {
 		perror("Can't open RFCOMM control socket");

--=-5NDQ2jtWD/tUFE3ZEkGZ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-5NDQ2jtWD/tUFE3ZEkGZ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-5NDQ2jtWD/tUFE3ZEkGZ--
