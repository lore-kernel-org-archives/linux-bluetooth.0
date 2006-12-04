Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <457403C1.7010801@palmsource.com>
Date: Mon, 04 Dec 2006 12:17:21 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------040206030307000801090904"
Subject: [Bluez-devel] [PATCH] authentification, encryption,
	and secure connection for rfcomm
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
--------------040206030307000801090904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

This patch adds command line options to rfcomm (--auth, --encrypt,=20
--secure, --master) as in pand. It also updates the man page.

best regards,
Fr=E9d=E9ric


--------------040206030307000801090904
Content-Type: text/x-patch;
 name="patch_bluez_rfcomm_encrypt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_bluez_rfcomm_encrypt.patch"

? Doxyfile
? Makefile.in
? aclocal.m4
? autom4te.cache
? bluezutils.kdevelop
? bluezutils.kdevelop.pcs
? bluezutils.kdevses
? config.guess
? config.h.in
? config.sub
? configure
? debug
? depcomp
? install-sh
? ltmain.sh
? missing
? stamp-h.in
? alsa/Makefile.in
? audio/Makefile.in
? common/Makefile.in
? cups/Makefile.in
? daemon/Makefile.in
? daemon/bt.echod
? daemon/service-agent-glue.h
? dund/Makefile.in
? fuse/Makefile.in
? hcid/Makefile.in
? hidd/Makefile.in
? input/Makefile.in
? network/Makefile.in
? pand/Makefile.in
? rfcomm/Makefile.in
? rfcomm/cvs
? rfcomm/main.c.modified
? rfcomm/main.patch
? scripts/Makefile.in
? sdpd/Makefile.in
? sync/Makefile.in
? test/Makefile.in
? tools/Makefile.in
Index: rfcomm/main.c
===================================================================
RCS file: /cvsroot/bluez/utils/rfcomm/main.c,v
retrieving revision 1.25
diff -u -r1.25 main.c
--- rfcomm/main.c	10 Nov 2006 23:18:53 -0000	1.25
+++ rfcomm/main.c	4 Dec 2006 11:09:55 -0000
@@ -54,7 +54,11 @@
 #endif
 
 static char *rfcomm_config_file = NULL;
-static int rfcomm_raw_tty = 0;
+static int  rfcomm_raw_tty = 0;
+static int  auth = 0;
+static int  encryption = 0;
+static int  secure = 0;
+static int  master = 0;
 
 extern int optind, opterr, optopt;
 extern char *optarg;
@@ -468,7 +472,7 @@
 	sigset_t sigs;
 	socklen_t alen;
 	char dst[18], devname[MAXPATHLEN];
-	int sk, nsk, fd, try = 30;
+	int sk, nsk, fd, lm, try = 30;
 
 	laddr.rc_family = AF_BLUETOOTH;
 	bacpy(&laddr.rc_bdaddr, bdaddr);
@@ -480,6 +484,22 @@
 		return;
 	}
 
+	lm = 0;
+	if (master)
+		lm |= RFCOMM_LM_MASTER;
+	if (auth)
+		lm |= RFCOMM_LM_AUTH;
+	if (encryption)
+		lm |= RFCOMM_LM_ENCRYPT;
+	if (secure)
+		lm |= RFCOMM_LM_SECURE;
+
+	if (lm && setsockopt(sk, SOL_RFCOMM, RFCOMM_LM, &lm, sizeof(lm)) < 0) {
+		perror("Can't set RFCOMM socket link mode");
+		return;
+	}
+
+
 	if (bind(sk, (struct sockaddr *)&laddr, sizeof(laddr)) < 0) {
 		perror("Can't bind RFCOMM socket");
 		close(sk);
@@ -660,6 +680,10 @@
 		"\t-i [hciX|bdaddr]      Local HCI device or BD Address\n"
 		"\t-h, --help            Display help\n"
 		"\t-r, --raw             Switch TTY into raw mode\n"
+		"\t-A, --auth            Enable authentication\n"
+		"\t-E, --encrypt         Enable encryption\n"
+		"\t-S, --secure          Secure connection\n"
+		"\t-M, --master          Become the master of a piconet\n"
 		"\t-f, --config [file]   Specify alternate config file\n" 
 		"\t-a                    Show all devices (default)\n"
 		"\n");
@@ -679,6 +703,10 @@
 	{ "device",	1, 0, 'i' },
 	{ "config",	1, 0, 'f' },
 	{ "raw",	0, 0, 'r' },
+	{ "auth",	0, 0, 'A' },
+	{ "encrypt",	0, 0, 'E' },
+	{ "secure",	0, 0, 'S' },
+	{ "master",	0, 0, 'M' },
 	{ 0, 0, 0, 0 }
 };
 
@@ -690,7 +718,7 @@
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt = getopt_long(argc, argv, "+i:f:rah", main_options, NULL)) != -1) {
+	while ((opt = getopt_long(argc, argv, "+i:f:rahAESM", main_options, NULL)) != -1) {
 		switch(opt) {
 		case 'i':
 			if (strncmp(optarg, "hci", 3) == 0)
@@ -714,6 +742,22 @@
 			usage();
 			exit(0);
 
+		case 'A':
+			auth = 1;
+			break;
+
+		case 'E':
+			encryption = 1;
+			break;
+
+		case 'S':
+			secure = 1;
+			break;
+
+		case 'M':
+			master = 1;
+			break;
+
 		default:
 			exit(0);
 		}
Index: rfcomm/rfcomm.1
===================================================================
RCS file: /cvsroot/bluez/utils/rfcomm/rfcomm.1,v
retrieving revision 1.5
diff -u -r1.5 rfcomm.1
--- rfcomm/rfcomm.1	10 Aug 2006 09:48:13 -0000	1.5
+++ rfcomm/rfcomm.1	4 Dec 2006 11:09:55 -0000
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
@@ -70,10 +78,22 @@
 tries to read the data from the config file. This command can
 be terminated with the key sequence CTRL-C.
 .TP 
-.BI listen " <dev> [channel]"
+.BI listen " <dev> [channel] [cmd]"
 Listen on a specified RFCOMM channel for incoming connections.
-If no channel is specified, it will use the channel number 1.
-This command can be terminated with the key sequence CTRL-C.
+If no channel is specified, it will use the channel number 1, but
+a channel must be specified before cmd. If cmd is given, it will be
+executed as soon as a client connects. When the child process 
+terminates or the client disconnect, the command will terminate.
+Occurences of {} in cmd will be replaced by the name of the device
+used by the connection. This command can be terminated with the key
+sequence CTRL-C.
+.TP
+.BI watch " <dev> [channel] [cmd]"
+Watch is identical to
+.B listen
+except that when the child process terminates or the client
+disconnect, the command will restart listening with the same 
+parameters.
 .TP
 .BI bind " <dev> [bdaddr] [channel]"
 This binds the RFCOMM device to a remote Bluetooth device. The

--------------040206030307000801090904
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------040206030307000801090904
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------040206030307000801090904--
