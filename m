Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200404171019.52523.cijoml@volny.cz>
Subject: [Bluez-users] l2ping acts like ping
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 17 Apr 2004 10:19:52 +0200

Hi Marcel,

we should possibly ping from 0 not 200 like normal ping :)

diff -urN bluez-utils-2.6-old/tools/l2ping.c bluez-utils-2.6/tools/l2ping.c
--- bluez-utils-2.6-old/tools/l2ping.c      Fri Apr  2 03:21:04 2004
+++ bluez-utils-2.6/tools/l2ping.c  Sat Apr 10 14:34:19 2004
@@ -53,7 +53,7 @@
 /* Defaults */
 bdaddr_t bdaddr;
 int size  = 20;
-int ident = 200;
+int ident = 0;
 int delay = 1;
 int count = -1;

Michal


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
