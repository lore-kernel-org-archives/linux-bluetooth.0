Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Martin Leopold <mleopold@worldonline.dk>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20020526220550.GA3983@asterix>
Mime-Version: 1.0
Subject: [Bluez-devel] Biderectional l2test
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=bluez-devel>
Date: Mon, 27 May 2002 00:05:50 +0200
Content-Type: multipart/mixed; boundary="=-eeYzRsey00eDwOI64sIW"


--=-eeYzRsey00eDwOI64sIW
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; FORMAT=flowed; CHARSET=ISO-8859-1

Hi All.
Following last weeks discussion I added a bidirectional test to l2test - 
this should make it possible for me to set up symmetric multislot 
connections, right?

l2test is running out of short commandline switches, so I chose -x, -y in 
lack of anything more intuitive. Most of the code is duplicated from 
elsewhere in l2test. It's missing a commandline switch to select the 
amount of packets to receive before computing the throughput. The 
sendbuffer is the same as for the "-s" sender and the receive buffer is 
set by the "-I" option. Since I've gotten this wrong more than once, 
comments are wellcome (wether this does what I think it does or not =)..

As I'm working at home today I havn't been able to try the same devices as 
I did last week (will do tomorow), so I tried with a BrainBoxes PCMCIA 
card and a Bluefrom USB unit.

First test: Same as last week (the Bluefrog box doesn't work with 
multislot packets for some reason).

Sender (BrainBoxes):
./hciconfig hci0 ptype DM1;./l2test -b 2000 -s 00:00:00:00:20:17
...

Receiver (Bluefrog):
./hciconfig hci0 ptype DM1;./l2test -b10000 -r -I 2000
l2test[1233]: Waiting for connection on psm 10 ...
l2test[1236]: Connect from 50:C2:C0:03:C2:8F [imtu 2000, omtu 672, 
flush_to 65535]
l2test[1236]: Receiving ...
l2test[1236]: 10000 bytes in 1.24 sec, 7.87 kB/s
l2test[1236]: 10000 bytes in 0.92 sec, 10.59 kB/s
l2test[1236]: 10000 bytes in 0.91 sec, 10.74 kB/s
l2test[1236]: 10000 bytes in 0.90 sec, 10.89 kB/s
l2test[1236]: 10000 bytes in 0.87 sec, 11.25 kB/s
...

With my new patch:
One host (Bluefrog):
./hciconfig hci0 ptype DM1;./l2test -b2000 -I 2000 -x
l2test[1302]: Waiting for connection on psm 10 ...
l2test[1302]: Connect from 50:C2:C0:03:C2:8F [imtu 2000, omtu 2000, 
flush_to 65535]
l2test[1302]: Received 12000 bytes in 2.86 sec, 4.10 kB/s
l2test[1302]: Received 12000 bytes in 2.80 sec, 4.19 kB/s
l2test[1302]: Received 12000 bytes in 2.47 sec, 4.74 kB/s
l2test[1302]: Received 12000 bytes in 1.83 sec, 6.39 kB/s
...

On the other host (BrainBoxes):
./hciconfig hci0 ptype DM1;./l2test -b2000 -I 2000 -y 00:00:00:00:20:17
l2test[1592]: Connected [imtu 2000, omtu 2000, flush_to 65535]
l2test[1592]: Received 12000 bytes in 0.43 sec, 27.05 kB/s
l2test[1592]: Received 12000 bytes in 0.91 sec, 12.94 kB/s
l2test[1592]: Received 12000 bytes in 0.37 sec, 32.04 kB/s
l2test[1592]: Received 12000 bytes in 0.20 sec, 59.82 kB/s
l2test[1592]: Received 12000 bytes in 0.43 sec, 27.41 kB/s
l2test[1592]: Received 12000 bytes in 0.43 sec, 27.09 kB/s
l2test[1592]: seq missmatch: 41 -> 42
...


So after all this trouble I still don't have clue what's going on!? If I 
reverse the "connector" (-y) and the "listener" (-x) both get about 
10kB/s. On several ocations the Bluefrog device has been shown to be ill 
in other ways, could this be it again or is there some blunder in my 
biderectional test?


-- 
Regards Martin Leopold.
Dept. of Computer Science, University of Copenhagen

--=-eeYzRsey00eDwOI64sIW
Content-Disposition: attachment; filename="bluez-utils-2.0-pre9.bidirectional.patch"
Content-Type: text/plain; CHARSET=us-ascii

--- bluez-utils-2.0-pre9.org/tools/l2test.c	Wed Mar 27 06:30:35 2002
+++ bluez-utils-2.0-pre9/tools/l2test.c	Sun May 26 23:52:43 2002
@@ -54,7 +54,9 @@
 	DUMP,
 	CONNECT,
 	CRECV,
-	LSEND
+	LSEND,
+	BILISTEN,
+	BICONNECT
 };
 
 unsigned char *buf;
@@ -74,6 +76,13 @@
 int auth = 0;
 int encrypt = 0;
 
+
+uint32_t verify_data(unsigned char *buf, int r, uint32_t seq);
+void bi_send_recv(int s);
+
+unsigned char *bi_recv_buf;
+int bi_recv_count=10000;
+
 float tv2fl(struct timeval tv)
 {
 	return (float)tv.tv_sec + (float)(tv.tv_usec/1000000.0);
@@ -246,9 +255,7 @@
 		gettimeofday(&tv_beg,NULL);
 		total = 0;
 		while (total < data_size) {
-			uint32_t sq;
-			uint16_t l;
-			int i,r;
+			int r;
 
 			if ((r = recv(s, buf, data_size, 0)) <= 0) {
 				if (r < 0)
@@ -257,26 +264,7 @@
 				return;	
 			}
 
-			/* Check sequence */
-			sq = btohl(*(uint32_t *)buf);
-			if (seq != sq) {
-				syslog(LOG_INFO, "seq missmatch: %d -> %d", seq, sq);
-				seq = sq;
-			}
-			seq++;
-			
-			/* Check length */
-			l = btohs(*(uint16_t *)(buf+4));
-			if (r != l) {
-				syslog(LOG_INFO, "size missmatch: %d -> %d", r, l);
-				continue;
-			}
-			
-			/* Verify data */	
-			for (i=6; i < r; i++) {
-				if (buf[i] != 0x7f)
-					syslog(LOG_INFO, "data missmatch: byte %d 0x%2.2x", i, buf[i]);
-			}
+			seq = verify_data(buf, r, seq);
 
 			total += r;
 		}
@@ -311,6 +299,101 @@
 	}
 }
 
+void bi_connect_mode(char* svr) {
+  int s;
+  if( (s = do_connect(svr)) < 0 )
+    exit(1);
+  bi_send_recv(s);
+}
+
+void bi_send_recv(int s) {
+  int i, r;
+  long total;
+  uint32_t recv_seq, send_seq;
+  struct timeval tv_beg, tv_end, tv_diff;
+  fd_set rset, wset;
+
+  /* Incoming packets are limited by the -I option */
+  if (!(bi_recv_buf = malloc(imtu))) {
+    perror("Can't allocate data buffer");
+    exit(1);
+  }
+  for(i=6; i < imtu; i++) buf[i]=0x7f;
+
+  send_seq = 0;
+  recv_seq = 0;
+  total = 0;
+  FD_ZERO(&rset);
+  FD_ZERO(&wset); 
+  gettimeofday(&tv_beg,NULL);
+  while(1) {
+    FD_SET(s, &rset);
+    FD_SET(s, &wset);
+    if (select(s+1, &rset, &wset, NULL, NULL)<0){
+      syslog(LOG_ERR, "Select failed. %s(%d)", strerror(errno), errno);
+      exit(-1);
+    }
+
+    if(FD_ISSET(s, &wset)) {
+      *(uint32_t *)buf = htobl(send_seq++);
+      *(uint16_t *)(buf+4) = htobs(data_size);
+	
+      if( send(s, buf, data_size, 0) <= 0 ) {
+	syslog(LOG_ERR, "Send failed. %s(%d)", strerror(errno), errno);
+	exit(1);
+      }
+    }
+    if(FD_ISSET(s, &rset)) {
+      if ((r = recv(s, bi_recv_buf, imtu, 0)) < 0) {
+	if (r < 0)
+	  syslog(LOG_ERR, "Read failed. %s(%d)", strerror(errno), errno);
+	return;
+      }
+      recv_seq = verify_data(bi_recv_buf, r, recv_seq);
+      total += r;
+
+      if(total >= bi_recv_count) {
+	gettimeofday(&tv_end,NULL);
+	timersub(&tv_end,&tv_beg,&tv_diff);
+	syslog(LOG_INFO,"Received %ld bytes in %.2f sec, %.2f kB/s", total,
+	       tv2fl(tv_diff), (float)(total / tv2fl(tv_diff) ) / 1024.0);
+	tv_beg=tv_end;
+	total=0;
+      }
+    }
+  }
+}
+
+uint32_t verify_data(unsigned char* buf, int r, uint32_t seq){
+  uint32_t sq;
+  uint16_t l;
+  int i;
+
+  /* Check sequence */
+  sq = btohl(*(uint32_t *)buf);
+  if (seq != sq) {
+    printf("seq missmatch: %d -> %d", seq, sq);
+    syslog(LOG_INFO, "seq missmatch: %d -> %d", seq, sq);
+    seq = sq;
+  }
+  seq++;
+			
+  /* Check length */
+  l = btohs(*(uint16_t *)(buf+4));
+  if (r != l) {
+    syslog(LOG_INFO, "size missmatch: %d -> %d", r, l);
+    goto done;
+  }
+		
+  /* Verify data */	
+  for (i=6; i < r; i++) {
+    if (buf[i] != 0x7f)
+      syslog(LOG_INFO, "data missmatch: byte %d 0x%2.2x", i, buf[i]);
+  }
+ done:
+  return seq;
+}
+
 void reconnect_mode(char *svr)
 {
 	while(1){
@@ -361,7 +444,9 @@
 		"\t-u connect and receive\n"
 		"\t-n connect and be silent\n"
 		"\t-c connect, disconnect, connect, ...\n"
-		"\t-m multiple connects\n");
+		"\t-m multiple connects\n"
+                "\t-x biderectional send/recv - listen\n"
+                "\t-y biderectional send/recv - connect\n");
 
 	printf("Options:\n"
 		"\t[-b bytes] [-S bdaddr] [-P psm]\n"
@@ -381,7 +466,7 @@
 
 	mode = RECV; need_addr = 0;
 	
-	while ((opt=getopt(argc,argv,"rdscuwmnb:P:I:O:S:MAE")) != EOF) {
+	while ((opt=getopt(argc,argv,"rdscuwmnxyxb:P:I:O:S:MAE")) != EOF) {
 		switch(opt) {
 		case 'r':
 			mode = RECV;
@@ -424,6 +509,15 @@
 			data_size = atoi(optarg);
 			break;
 
+		case 'x':
+		        mode=BILISTEN;
+			break;
+
+		case 'y':
+		        mode=BICONNECT;
+			need_addr = 1;
+			break;
+
 		case 'S':
 			baswap(&bdaddr, strtoba(optarg));
 			break;
@@ -476,6 +570,14 @@
 	openlog("l2test", LOG_PERROR | LOG_PID, LOG_LOCAL0);
 
 	switch( mode ){
+	        case BILISTEN:
+		        do_listen(bi_send_recv);
+ 		        break;
+
+	        case BICONNECT:
+	                bi_connect_mode(argv[optind]);
+ 		        break;
+
 		case RECV:
 			do_listen(recv_mode);
 			break;

--=-eeYzRsey00eDwOI64sIW--
