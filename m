Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Andreas =?ISO-8859-1?Q?B=F6hler?= <andy.boehler@gmx.at>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] emporia/mega-Headset and btsco problems
Message-Id: <20050703180226.458a1bd7.andy.boehler@gmx.at>
In-Reply-To: <42C7A344.4060700@xmission.com>
References: <20050702172632.3d3b3dcd.andy.boehler@gmx.at>
	<42C70688.9050407@xmission.com>
	<20050703004746.45b60662.andy.boehler@gmx.at>
	<42C7A344.4060700@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 3 Jul 2005 18:02:26 +0200

Thank you, Brad, thank you!

> maybe something like this... i wish the whole thing wasn't such a big=20
> ugly function...

...but it works exactly the way I wanted it to! Ugly or not, it does what i=
t should, my headset is now much more comfortable to use than before!

I slightly modified your patch and added it as a command-line option "-r" t=
o force the reconnection upon lost rfcomm-channel!=20

greetings,=20

andy


diff -puN btsco.c.old btsco.c
--- btsco.c.old	2005-06-17 17:57:42.000000000 +0200
+++ btsco.c	2005-07-03 17:57:45.000000000 +0200
@@ -80,8 +80,8 @@ struct action {
 	char *cmd;
 };
=20
-static volatile int terminate =3D 0, ring =3D 0, hupped =3D 0, reconnect =
=3D 0;
-static int verbose =3D 0;
+static volatile int terminate =3D 0, ring =3D 0, hupped =3D 0, reconnect =
=3D 0, rfreconnect =3D 0;
+static int verbose =3D 0, auto_reconn =3D 0;
=20
 static void sig_term(int sig)
 {
@@ -279,6 +279,7 @@ static void usage(void)
 	printf("Usage:\n" "\tbtsco [options] <bdaddr> [channel]\n");
 	printf("Options:\n");
 	printf(" -v print verbose output\n");
+	printf(" -r automatically reconnect upon lost rfcomm channel\n");
 	printf(" -f fork and run as a daemon\n");
 	printf(" -c clear filehandle and exit\n");
 	printf(" -h print this usage and exit\n");
@@ -479,7 +480,7 @@ int main(int argc, char *argv[])
=20
 	fork =3D 0;
 	clear =3D 0;
-	while((i =3D getopt(argc, argv, "fcvh")) >=3D 0) {
+	while((i =3D getopt(argc, argv, "fcvhr")) >=3D 0) {
 		switch(i) {
 		case 'v':
 			verbose++;
@@ -489,7 +490,10 @@ int main(int argc, char *argv[])
 			break;
 		case 'c':
 			clear =3D 1;
-			break;
+		        break;
+		case 'r':
+		        auto_reconn =3D 1;
+		        break;
 		case 'h':
 		case '?':
 		case ':':
@@ -588,7 +592,8 @@ int main(int argc, char *argv[])
 	sa.sa_handler =3D SIG_IGN;
 	sigaction(SIGCHLD, &sa, NULL);
 	sigaction(SIGPIPE, &sa, NULL);
-
+    do {
+       =20
 	/* connect rfcomm control channel */
 	if ((rd =3D rfcomm_connect(&local, &bdaddr, channel)) < 0) {
 		perror("Can't connect RFCOMM channel");
@@ -682,6 +687,9 @@ int main(int argc, char *argv[])
 					fflush(stdout);
 				}
 				terminate =3D 1;
+				if(auto_reconn) {
+				  rfreconnect =3D 1;
+				}
 			}
 		=09
 			// control transmission events for volume and channel control
@@ -890,6 +898,11 @@ int main(int argc, char *argv[])
 			hupped =3D 0;
 		}
 	}
+    if(rfreconnect) {
+        rfreconnect =3D 0;
+        terminate =3D 0;
+    }
+    } while (!terminate);
=20
 	if (sco_mode =3D=3D CONNECTED) {
 		close(sd);


--=20
Andreas B=F6hler
andy (dot) boehler (at) gmx (dot) at
www.klasseonline.tk


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
