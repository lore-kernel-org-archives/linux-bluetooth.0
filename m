Return-Path: <cyrus@holtmann.org>
Message-ID: <47754D1D.9020907@yahoo.es>
Date: Fri, 28 Dec 2007 20:23:09 +0100
From: Perki Pat <perki_pat3@yahoo.es>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] hcitool and argv syntax
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi! If I want to scan on hci0 the next sintax is bad, but hcitool
doesn't complain:
pablo@golgi:~$ hcitool hci0 scan
pablo@golgi:~$
(I better should use hcitool -i hci0 scan)

I've written a little patch to warn when an unrecognised command is given:

pablo@golgi:~/work/hcitool-patch1/utils/tools$ diff -u hcitool.c.orig
hcitool.c
--- hcitool.c.orig	2007-12-28 20:06:58.000000000 +0100
+++ hcitool.c	2007-12-28 20:04:11.000000000 +0100
@@ -2291,6 +2291,7 @@
 {
 	int opt, i, dev_id =3D -1;
 	bdaddr_t ba;
+	int unk_cmd=3D1;

 	while ((opt=3Dgetopt_long(argc, argv, "+i:h", main_options, NULL)) !=3D -=
1) {
 		switch (opt) {
@@ -2326,8 +2327,15 @@
 	for (i =3D 0; command[i].cmd; i++) {
 		if (strncmp(command[i].cmd, argv[0], 3))
 			continue;
+		unk_cmd=3D0;
 		command[i].func(dev_id, argc, argv);
 		break;
 	}
-	return 0;
+
+	if(unk_cmd) {
+	  fprintf(stderr,"\"%s\" isn't a valid command. Try --help for a list
of commands.\n",argv[0]);
+	  exit(EXIT_FAILURE);
+	}
+
+	exit(EXIT_SUCCESS);
 }


Now, when I ask for an inexistent command it complains:
pablo@golgi:~$ ./hcitool nop scan
"nop" isn't a valid command. Try --help for a list of commands.
pablo@golgi:~$

If you find it useful, feel free to commit it.

Bye.

		=

______________________________________________ =

LLama Gratis a cualquier PC del Mundo. =

Llamadas a fijos y m=F3viles desde 1 c=E9ntimo por minuto. =

http://es.voice.yahoo.com


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
