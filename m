Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: "'Max Krasnyansky'" <maxk@qualcomm.com>, "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
Date: Wed, 14 May 2003 15:35:29 -0700
Message-ID: <001901c31a69$2163c220$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1052951229.4609.71.camel@pegasus.local>
List-ID: <bluez-devel.lists.sourceforge.net>

Here you go (sorry about that):

--- /home/daryl/bluez/bluez-utils-2.3/test/l2test.c	Wed May 14 15:11:32
2003
+++ l2test.c	Wed May 14 15:10:58 2003
@@ -71,6 +71,9 @@
 bdaddr_t bdaddr;
 unsigned short psm = 10;
 
+/* Default number of blocks to send */
+int num_blocks = -1; // Infinite
+
 int master = 0;
 int auth = 0;
 int encrypt = 0;
@@ -324,7 +327,7 @@
 		buf[i]=0x7f;
 
 	seq = 0;
-	while (1) {
+	while ((num_blocks == -1) || (num_blocks-- > 0)) {
 		*(uint32_t *) buf = htobl(seq++);
 		*(uint16_t *)(buf+4) = htobs(data_size);
 		
@@ -386,9 +389,9 @@
 	printf("Options:\n"
 		"\t[-b bytes] [-S bdaddr] [-P psm]\n"
 	       	"\t[-I imtu] [-O omtu]\n"
+	        "\t[-N num] send num blocks (default = infinite)\n"
 		"\t[-D] use connectionless channel (datagram)\n"
 		"\t[-E] request encryption\n"
-		"\t[-E] request encryption\n"
 	       	"\t[-M] become master\n");
 }
 
@@ -402,7 +405,7 @@
 
 	mode = RECV; need_addr = 0;
 	
-	while ((opt=getopt(argc,argv,"rdscuwmnb:P:I:O:S:MAED")) != EOF) {
+	while ((opt=getopt(argc,argv,"rdscuwmnb:P:I:O:S:N:MAED")) != EOF) {
 		switch(opt) {
 		case 'r':
 			mode = RECV;
@@ -477,6 +480,10 @@
 			socktype = SOCK_DGRAM;
 			break;
 
+		case 'N':
+			num_blocks = atoi(optarg);
+			break;
+
 		default:
 			usage();
 			exit(1);

> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@rvs.uni-bielefeld.de] 
> Sent: May 14, 2003 3:27 PM
> To: Daryl Van Vorst
> Cc: 'Max Krasnyansky'; 'BlueZ Mailing List'
> Subject: RE: [Bluez-devel] Qualification Testing
> 
> 
> Hi Daryl,
> 
> > Got to it a bit quicker than expected. I haven't needed to change 
> > rctest for testing, so I haven't modified that one yet.
> > 
> > Here's the diff.
> 
> thats great, but can you please use "diff -urN". Because a 
> unified diff is much more easier to read.
> 
> Regards
> 
> Marcel
> 
> 
> 
