Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <447EA02C.3070703@palmsource.com>
Date: Thu, 01 Jun 2006 10:07:08 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <447C7ADD.1040503@palmsource.com> <447E951C.6040400@xmission.com>
In-Reply-To: <447E951C.6040400@xmission.com>
Content-Type: multipart/mixed; boundary="------------050501070407020201040302"
Subject: Re: [Bluez-devel] First try
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
--------------050501070407020201040302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi brad,

>could you resend as a 'diff -u' output?
>  
>

this is the command line I use is that correct?

cvs diff -u pcm_a2dp.c > pcm_a2dp.c.diff-u
Now the output has +- instead of ><

Frederic

--------------050501070407020201040302
Content-Type: text/plain;
 name="pcm_a2dp.c.diff-u"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcm_a2dp.c.diff-u"

Index: alsa-plugins/pcm_a2dp.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/pcm_a2dp.c,v
retrieving revision 1.9
diff -u -r1.9 pcm_a2dp.c
--- alsa-plugins/pcm_a2dp.c	28 Apr 2006 23:16:18 -0000	1.9
+++ alsa-plugins/pcm_a2dp.c	1 Jun 2006 08:00:56 -0000
@@ -49,21 +49,7 @@
 #include "../a2dp.h"
 
 #define NONSPECAUDIO 1
-time_t timestamp=0;
-uint16_t seq_num=1;
-int frame_count=0;
 #define BUFS 1024
-static char bufe[BUFS];
-int lenbufe=0;
-
-unsigned long nbytes=0;
-unsigned long total_time=0;
-struct timeval t0;
-struct itimerval itimer;
-struct sigaction sa;
-struct timeval tsend;
-int fpr=0;
-
 
 #define min(X, Y)  ((X) < (Y) ? (X) : (Y))
 #define DBG(fmt, arg...)  printf("DEBUG: %s: " fmt "\n" , __FUNCTION__ , ## arg)
@@ -561,6 +547,20 @@
 	unsigned int len;
 	unsigned int frame_bytes;
 	int use_rfcomm;
+
+   char bufe[BUFS];
+  int lenbufe;//=0;
+
+  unsigned long nbytes;//=0;
+
+
+
+  struct timeval tsend;
+
+  time_t timestamp;//=0;
+  uint16_t seq_num;//=1;
+  int frame_count;//=0;
+
 } snd_pcm_a2dp_t;
 
 static void inline a2dp_get(snd_pcm_a2dp_t *a2dp)
@@ -668,22 +668,22 @@
 	codesize=a2dp->sbc.subbands*a2dp->sbc.blocks*a2dp->sbc.channels*2; // size of data encoded by sbc_encode in one call
 	datatoread=min(codesize,size*a2dp->frame_bytes); // amount of data to read
 	buf = (char *) areas->addr + (areas->first + areas->step * offset) / 8;
-    	if(lenbufe<codesize && lenbufe+datatoread<sizeof(bufe)){ // if not enough data in bufe to encode and there is space in bufe
-		memcpy(bufe+lenbufe,buf,datatoread);// we read data to bufe
-		lenbufe+=datatoread;
+    	if(a2dp->lenbufe<codesize && a2dp->lenbufe+datatoread<sizeof(a2dp->bufe)){ // if not enough data in bufe to encode and there is space in bufe
+		memcpy(a2dp->bufe+a2dp->lenbufe,buf,datatoread);// we read data to bufe
+		a2dp->lenbufe+=datatoread;
 	}
 	else{datatoread=0;}//nothing has been read
 
-	if(lenbufe>=codesize && a2dp->len + a2dp->sbc.len < 678){ // if enough data in bufe to encode and not enough frame to fill up mtu: encoding
-		change_endian(bufe,codesize); // changing the endianness
-		len = sbc_encode(&(a2dp->sbc), bufe, codesize); //encode
-		memmove(bufe, bufe + len, lenbufe - len); //shift the bufe                                 
-		lenbufe-=len;
-		nbytes+=len;
+	if(a2dp->lenbufe>=codesize && a2dp->len + a2dp->sbc.len < 678){ // if enough data in bufe to encode and not enough frame to fill up mtu: encoding
+		change_endian(a2dp->bufe,codesize); // changing the endianness
+		len = sbc_encode(&(a2dp->sbc), a2dp->bufe, codesize); //encode
+		memmove(a2dp->bufe, a2dp->bufe + len, a2dp->lenbufe - len); //shift the bufe                                 
+		a2dp->lenbufe-=len;
+		a2dp->nbytes+=len;
 		sleeptime += a2dp->sbc.duration;
 		if (len <= 0)
 			return len;
-		frame_count++;
+		a2dp->frame_count++;
 		memcpy(a2dp->buf + a2dp->len, a2dp->sbc.data, a2dp->sbc.len); // copy encoded frames into a2dp->buf
 		a2dp->len+=a2dp->sbc.len;
 		if (a2dp->state == BT_CONNECTED)
@@ -692,25 +692,25 @@
 	}		
 
 	if(a2dp->len + a2dp->sbc.len > 678){ // if packet is formed
-		dt.tv_usec=1000000*a2dp->sbc.subbands*a2dp->sbc.blocks*frame_count/io->rate; // time interval between transmitions
+		dt.tv_usec=1000000*a2dp->sbc.subbands*a2dp->sbc.blocks*a2dp->frame_count/io->rate; // time interval between transmitions
 		dt.tv_sec=0;
-		if(time_to_wait(&tsend, &dt)==0){ // time to send data
+		if(time_to_wait(&a2dp->tsend, &dt)==0){ // time to send data
 			memset(&payload_header, 0, sizeof(payload_header)); // fill up the headers
 			memset(&packet_header, 0, sizeof(packet_header)); //---
-			payload_header.frame_count=frame_count;
+			payload_header.frame_count=a2dp->frame_count;
 			packet_header.v = 2;
 			packet_header.pt = 1;
-			packet_header.sequence_number = htons(seq_num);
-			packet_header.timestamp = htonl(timestamp);
+			packet_header.sequence_number = htons(a2dp->seq_num);
+			packet_header.timestamp = htonl(a2dp->timestamp);
 			packet_header.ssrc = htonl(1);
-			timestamp += (a2dp->sbc.blocks + 1)*4 * (a2dp->sbc.subbands + 1)*4;
+			a2dp->timestamp += (a2dp->sbc.blocks + 1)*4 * (a2dp->sbc.subbands + 1)*4;
 			memcpy(a2dp->buf, &packet_header, sizeof(packet_header)); //copy the headers to buf
 			memcpy(a2dp->buf + sizeof(packet_header), &payload_header, sizeof(payload_header));//---
 			write(a2dp->sk,a2dp->buf,a2dp->len); // sending the packet
 			a2dp->len = sizeof(packet_header)+sizeof(payload_header); //inital position in buf, just after headers
-			frame_count=0;
+			a2dp->frame_count=0;
 			sleeptime=0;
-			seq_num++;
+			a2dp->seq_num++;
 		}else{usleep(1);}
 	}
 	return datatoread / a2dp->frame_bytes;
@@ -731,51 +731,68 @@
 	int written;
 	
 	struct timeval dt;
-	
 
 	codesize=a2dp->sbc.subbands*a2dp->sbc.blocks*a2dp->sbc.channels*2;
 	datatoread=min(codesize,size*a2dp->frame_bytes);
+
+	struct timeval timeofday;
+	gettimeofday(&timeofday, NULL);
+	/*
+	DBG("(%2d%3d): %d + %d * %d (=%d)",
+	    (timeofday.tv_sec      )%100,  // s
+	    (timeofday.tv_usec/1000)%1000, // ms
+	    (int)areas->first, (int)areas->step, offset, (areas->first + areas->step * offset));
+	/*
+	DBG("(%2d%3d): %d * %d * %d * 2 (=%d) x %d",
+	    (timeofday.tv_sec      )%100,  // s
+	    (timeofday.tv_usec/1000)%1000, // ms
+	    a2dp->sbc.subbands, // 8
+	    a2dp->sbc.blocks, // 16
+	    a2dp->sbc.channels, // 2
+	    codesize, // 512
+	    datatoread); // 512
+	*/
 	buf = (char *) areas->addr + (areas->first + areas->step * offset) / 8;
-    	if(lenbufe<codesize){
-		memcpy(bufe+lenbufe,buf,datatoread);
-		lenbufe+=datatoread;
+    	if(a2dp->lenbufe<codesize){
+		memcpy(a2dp->bufe+a2dp->lenbufe,buf,datatoread);
+		a2dp->lenbufe+=datatoread;
 	}  
 	else{datatoread=0;}
 
-	if(lenbufe>=codesize){ //enough data to encode
-		change_endian(bufe,codesize); // changing the endianness
-		len = sbc_encode(&(a2dp->sbc), bufe, codesize); //encode
-		memmove(bufe, bufe + len, lenbufe - len); //shift the bufe                                 
-		lenbufe-=len;
-		nbytes+=len;
+	if(a2dp->lenbufe>=codesize){ //enough data to encode
+		change_endian(a2dp->bufe,codesize); // changing the endianness
+		len = sbc_encode(&(a2dp->sbc), a2dp->bufe, codesize); //encode
+		memmove(a2dp->bufe, a2dp->bufe + len, a2dp->lenbufe - len); //shift the bufe                                 
+		a2dp->lenbufe-=len;
+		a2dp->nbytes+=len;
 		sleeptime += a2dp->sbc.duration;
 		if (len <= 0)
 			return len;
 		if(a2dp->len + a2dp->sbc.len > 678)	{ // time to prepare and send the packet
 			dt.tv_sec=0;
-			dt.tv_usec=1000000*a2dp->sbc.subbands*a2dp->sbc.blocks*frame_count/io->rate;
+			dt.tv_usec=1000000*a2dp->sbc.subbands*a2dp->sbc.blocks*a2dp->frame_count/io->rate;
 			memset(&payload_header, 0, sizeof(payload_header));
 			memset(&packet_header, 0, sizeof(packet_header));
-			payload_header.frame_count=frame_count;
+			payload_header.frame_count=a2dp->frame_count;
 			packet_header.v = 2;
 			packet_header.pt = 1;
-			packet_header.sequence_number = htons(seq_num);
-			packet_header.timestamp = htonl(timestamp);
+			packet_header.sequence_number = htons(a2dp->seq_num);
+			packet_header.timestamp = htonl(a2dp->timestamp);
 			packet_header.ssrc = htonl(1);
-			timestamp += (a2dp->sbc.blocks + 1)*4 * (a2dp->sbc.subbands + 1)*4;
+			a2dp->timestamp += (a2dp->sbc.blocks + 1)*4 * (a2dp->sbc.subbands + 1)*4;
 			memcpy(a2dp->buf, &packet_header, sizeof(packet_header));
 			memcpy(a2dp->buf + sizeof(packet_header), &payload_header, sizeof(payload_header));
-			sleeptill(&tsend, &dt);
+			sleeptill(&a2dp->tsend, &dt);
 			if((written = write(a2dp->sk,a2dp->buf,a2dp->len)) != a2dp->len) {
 				DBG("Wrote %d not %d bytes; errno %s(%d)", written, a2dp->len,
 					strerror(errno), errno);
 			}
 			a2dp->len = sizeof(packet_header)+sizeof(payload_header);
-			frame_count=0;
+			a2dp->frame_count=0;
 			sleeptime=0;
-			seq_num++;
+			a2dp->seq_num++;
 		}
-		frame_count++;
+		a2dp->frame_count++;
 		memcpy(a2dp->buf + a2dp->len, a2dp->sbc.data, a2dp->sbc.len);
 		a2dp->len+=a2dp->sbc.len;
 		if (a2dp->state == BT_CONNECTED)
@@ -971,7 +988,7 @@
 	unsigned int format[2], channel[2], rate[2];
 	int err;
 
-	DBG("a2dp %p", a2dp);
+	DBG("TEST a2dp %p", a2dp);
 
 	err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_ACCESS, 2, access_list);
 	if (err < 0)
@@ -1040,6 +1057,7 @@
 	memset(a2dp, 0, sizeof(*a2dp));
 
 	a2dp->refcnt = 1;
+	a2dp->seq_num = 1;
 
 	a2dp->state = BT_OPEN;
 

--------------050501070407020201040302
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050501070407020201040302
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------050501070407020201040302--
