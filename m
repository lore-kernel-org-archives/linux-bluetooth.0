Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sat, 3 Jun 2006 15:57:08 +0200
From: Filippo Giunchedi <filippo@esaurito.net>
To: bluez-devel@lists.sf.net
Message-ID: <20060603135708.GB13263@esaurito.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wq9mPyueHGvFACwf"
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


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marcel,
attached there is a new patch (using tabs, "set noet" for the vim lovers) for
rfcomm, agreed it could be better. I hope it is clear enough.

thanks,
filippo
--
Filippo Giunchedi - http://esaurito.net
PGP key: 0x6B79D401
random quote follows:

The only way to get rid of a temptation is to yield to it.
-- Oscar Wilde

--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rfcomm.patch"

diff -u -r1.16 main.c
--- main.c	3 Jan 2006 13:29:01 -0000	1.16
+++ main.c	3 Jun 2006 13:54:33 -0000
@@ -621,8 +621,19 @@
 	argv += optind;
 	optind = 0;
 
-	if (argc < 2)
+	if (argc == 0) {
 		show_all = 1;
+	} else if (argc == 1) {
+		for(i = 0; command[i].cmd; i++) {
+			if ((strncmp(command[i].cmd, argv[0], 4) == 0) && (strncmp(command[i].alt, argv[0], 4) == 0) )
+				break;
+			if (command[i+1].cmd == NULL) {
+				usage();
+				exit(0);
+			}
+		}
+		show_all = 1;
+	}
 
 	if ((ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_RFCOMM)) < 0 ) {
 		perror("Can't open RFCOMM control socket");

--wq9mPyueHGvFACwf
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--wq9mPyueHGvFACwf--
