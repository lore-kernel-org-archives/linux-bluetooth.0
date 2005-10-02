Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Hartmut Schimmel <BlueZ@schimmelnetz.de>
To: bluez-users@lists.sourceforge.net, bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_nODQDbie4WOphng"
Message-Id: <200510022123.19715.BlueZ@schimmelnetz.de>
Subject: [Bluez-devel] [PATCH] rctest DUMP mode with data dump
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
Date: Sun, 2 Oct 2005 21:23:19 +0200

--Boundary-00=_nODQDbie4WOphng
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

the attached patch extendes rctest.c with a cmd line switch -D, which writes 
the data recived in DUMP mode to stdout.

Install:
cd bluez-utils-2.21
patch -p0 < rcdump_2.21.patch
make distclean
./configure --enable-test
make

Why I made it:
For me it is usefull as a very simple client program, which waits for incoming 
connections and dumps the incoming data. It can be used from script languages 
like perl.

In real I receive mesurements from a sensor (bluetooth equiped with PicoPlug) 
out there, which wake up from time to time, send measure value via SPP to the 
host, where the pachted rctest runs and sleeps again.

sml@Amadeus:~> rctest -P 5 -d -D
rctest[12071]: Waiting for connection on channel 5 ...
rctest[12072]: Can't get RFCOMM connection information: Protocol not available 
(92)
rctest[12072]: Connect from 00:80:37:15:1A:A9 [handle 0, class 0x000000]
rctest[12072]: Receiving ...
this is line the data payload
rctest[12072]: Disconnect: Connection timed out

Please give me feedback, if this is usefull for anybody else.


Hartmut



--Boundary-00=_nODQDbie4WOphng
Content-Type: text/x-diff;
  charset="us-ascii";
  name="rcdump_2.21.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rcdump_2.21.patch"

diff -Naur ../bluez-utils-2.21/test/rctest.c ./test/rctest.c
--- ../bluez-utils-2.21/test/rctest.c	2005-02-01 01:13:02.000000000 +0100
+++ ./test/rctest.c	2005-10-02 20:32:08.164841032 +0200
@@ -75,6 +75,7 @@
 static int secure = 0;
 static int socktype = SOCK_STREAM;
 static int linger = 0;
+static int dump_data = 0;
 
 static float tv2fl(struct timeval tv)
 {
@@ -265,11 +266,23 @@
 
 static void dump_mode(int sk)
 {
-	int len;
+	int len, count;
 
 	syslog(LOG_INFO, "Receiving ...");
-	while ((len = read(sk, buf, data_size)) > 0)
-		syslog(LOG_INFO, "Recevied %d bytes", len);
+
+	if ( !dump_data ) {
+		count = data_size;
+	} else {
+		count = 1;
+	}
+
+	while ((len = read(sk, buf, count)) > 0) {
+		if ( !dump_data ) {
+			syslog(LOG_INFO, "Recevied %d bytes", len);
+		} else {
+			printf("%s", buf);
+		}
+	}
 }
 
 static void recv_mode(int sk)
@@ -407,7 +420,8 @@
 		"\t[-A] request authentication\n"
 		"\t[-E] request encryption\n"
 		"\t[-S] secure connection\n"
-		"\t[-M] become master\n");
+		"\t[-M] become master\n"
+		"\t[-D] dump incoming data (only in dump mode)\n");
 }
 
 int main(int argc ,char *argv[])
@@ -417,7 +431,7 @@
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt=getopt(argc,argv,"rdscuwmnb:i:P:N:MAESL:")) != EOF) {
+	while ((opt=getopt(argc,argv,"rdscuwmnb:i:P:N:MAESL:D")) != EOF) {
 		switch (opt) {
 		case 'r':
 			mode = RECV;
@@ -483,6 +497,10 @@
 			encrypt = 1;
 			break;
 
+		case 'D':
+			dump_data = 1;
+			break;
+
 		case 'S':
 			secure = 1;
 			break;

--Boundary-00=_nODQDbie4WOphng--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
