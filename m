Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <447C7ADD.1040503@palmsource.com>
Date: Tue, 30 May 2006 19:03:25 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------030006080403020105030308"
Subject: [Bluez-devel] First try
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
--------------030006080403020105030308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi brad,

I just tried to move global variables to pcm_a2dp struct... However, I=20
seem to experience a loss in quality. I'm really unsure about it. I=20
don't understand why as it is a straight forward fix. Could you please=20
review it?
It's based on the latest cvs.

I also tried a "make dist", but I got a btsco-0.2.tar.gz, which makes me=20
say configure.in is not up to date !

Thank you,
Fr=E9d=E9ric



--------------030006080403020105030308
Content-Type: text/x-patch;
 name="pcm_a2dp.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcm_a2dp.c.diff"

Index: pcm_a2dp.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/pcm_a2dp.c,v
retrieving revision 1.9
diff -r1.9 pcm_a2dp.c
52,54d51
< time_t timestamp=0;
< uint16_t seq_num=1;
< int frame_count=0;
56,66d52
< static char bufe[BUFS];
< int lenbufe=0;
< 
< unsigned long nbytes=0;
< unsigned long total_time=0;
< struct timeval t0;
< struct itimerval itimer;
< struct sigaction sa;
< struct timeval tsend;
< int fpr=0;
< 
563a550,563
> 
>    char bufe[BUFS];
>   int lenbufe;//=0;
> 
>   unsigned long nbytes;//=0;
> 
> 
> 
>   struct timeval tsend;
> 
>   time_t timestamp;//=0;
>   uint16_t seq_num;//=1;
>   int frame_count;//=0;
> 
671,673c671,673
<     	if(lenbufe<codesize && lenbufe+datatoread<sizeof(bufe)){ // if not enough data in bufe to encode and there is space in bufe
< 		memcpy(bufe+lenbufe,buf,datatoread);// we read data to bufe
< 		lenbufe+=datatoread;
---
>     	if(a2dp->lenbufe<codesize && a2dp->lenbufe+datatoread<sizeof(a2dp->bufe)){ // if not enough data in bufe to encode and there is space in bufe
> 		memcpy(a2dp->bufe+a2dp->lenbufe,buf,datatoread);// we read data to bufe
> 		a2dp->lenbufe+=datatoread;
677,682c677,682
< 	if(lenbufe>=codesize && a2dp->len + a2dp->sbc.len < 678){ // if enough data in bufe to encode and not enough frame to fill up mtu: encoding
< 		change_endian(bufe,codesize); // changing the endianness
< 		len = sbc_encode(&(a2dp->sbc), bufe, codesize); //encode
< 		memmove(bufe, bufe + len, lenbufe - len); //shift the bufe                                 
< 		lenbufe-=len;
< 		nbytes+=len;
---
> 	if(a2dp->lenbufe>=codesize && a2dp->len + a2dp->sbc.len < 678){ // if enough data in bufe to encode and not enough frame to fill up mtu: encoding
> 		change_endian(a2dp->bufe,codesize); // changing the endianness
> 		len = sbc_encode(&(a2dp->sbc), a2dp->bufe, codesize); //encode
> 		memmove(a2dp->bufe, a2dp->bufe + len, a2dp->lenbufe - len); //shift the bufe                                 
> 		a2dp->lenbufe-=len;
> 		a2dp->nbytes+=len;
686c686
< 		frame_count++;
---
> 		a2dp->frame_count++;
695c695
< 		dt.tv_usec=1000000*a2dp->sbc.subbands*a2dp->sbc.blocks*frame_count/io->rate; // time interval between transmitions
---
> 		dt.tv_usec=1000000*a2dp->sbc.subbands*a2dp->sbc.blocks*a2dp->frame_count/io->rate; // time interval between transmitions
697c697
< 		if(time_to_wait(&tsend, &dt)==0){ // time to send data
---
> 		if(time_to_wait(&a2dp->tsend, &dt)==0){ // time to send data
700c700
< 			payload_header.frame_count=frame_count;
---
> 			payload_header.frame_count=a2dp->frame_count;
703,704c703,704
< 			packet_header.sequence_number = htons(seq_num);
< 			packet_header.timestamp = htonl(timestamp);
---
> 			packet_header.sequence_number = htons(a2dp->seq_num);
> 			packet_header.timestamp = htonl(a2dp->timestamp);
706c706
< 			timestamp += (a2dp->sbc.blocks + 1)*4 * (a2dp->sbc.subbands + 1)*4;
---
> 			a2dp->timestamp += (a2dp->sbc.blocks + 1)*4 * (a2dp->sbc.subbands + 1)*4;
711c711
< 			frame_count=0;
---
> 			a2dp->frame_count=0;
713c713
< 			seq_num++;
---
> 			a2dp->seq_num++;
734d733
< 	
737a737,754
> 
> 	struct timeval timeofday;
> 	gettimeofday(&timeofday, NULL);
> 	/*
> 	DBG("(%2d%3d): %d + %d * %d (=%d)",
> 	    (timeofday.tv_sec      )%100,  // s
> 	    (timeofday.tv_usec/1000)%1000, // ms
> 	    (int)areas->first, (int)areas->step, offset, (areas->first + areas->step * offset));
> 	/*
> 	DBG("(%2d%3d): %d * %d * %d * 2 (=%d) x %d",
> 	    (timeofday.tv_sec      )%100,  // s
> 	    (timeofday.tv_usec/1000)%1000, // ms
> 	    a2dp->sbc.subbands, // 8
> 	    a2dp->sbc.blocks, // 16
> 	    a2dp->sbc.channels, // 2
> 	    codesize, // 512
> 	    datatoread); // 512
> 	*/
739,741c756,758
<     	if(lenbufe<codesize){
< 		memcpy(bufe+lenbufe,buf,datatoread);
< 		lenbufe+=datatoread;
---
>     	if(a2dp->lenbufe<codesize){
> 		memcpy(a2dp->bufe+a2dp->lenbufe,buf,datatoread);
> 		a2dp->lenbufe+=datatoread;
745,750c762,767
< 	if(lenbufe>=codesize){ //enough data to encode
< 		change_endian(bufe,codesize); // changing the endianness
< 		len = sbc_encode(&(a2dp->sbc), bufe, codesize); //encode
< 		memmove(bufe, bufe + len, lenbufe - len); //shift the bufe                                 
< 		lenbufe-=len;
< 		nbytes+=len;
---
> 	if(a2dp->lenbufe>=codesize){ //enough data to encode
> 		change_endian(a2dp->bufe,codesize); // changing the endianness
> 		len = sbc_encode(&(a2dp->sbc), a2dp->bufe, codesize); //encode
> 		memmove(a2dp->bufe, a2dp->bufe + len, a2dp->lenbufe - len); //shift the bufe                                 
> 		a2dp->lenbufe-=len;
> 		a2dp->nbytes+=len;
756c773
< 			dt.tv_usec=1000000*a2dp->sbc.subbands*a2dp->sbc.blocks*frame_count/io->rate;
---
> 			dt.tv_usec=1000000*a2dp->sbc.subbands*a2dp->sbc.blocks*a2dp->frame_count/io->rate;
759c776
< 			payload_header.frame_count=frame_count;
---
> 			payload_header.frame_count=a2dp->frame_count;
762,763c779,780
< 			packet_header.sequence_number = htons(seq_num);
< 			packet_header.timestamp = htonl(timestamp);
---
> 			packet_header.sequence_number = htons(a2dp->seq_num);
> 			packet_header.timestamp = htonl(a2dp->timestamp);
765c782
< 			timestamp += (a2dp->sbc.blocks + 1)*4 * (a2dp->sbc.subbands + 1)*4;
---
> 			a2dp->timestamp += (a2dp->sbc.blocks + 1)*4 * (a2dp->sbc.subbands + 1)*4;
768c785
< 			sleeptill(&tsend, &dt);
---
> 			sleeptill(&a2dp->tsend, &dt);
774c791
< 			frame_count=0;
---
> 			a2dp->frame_count=0;
776c793
< 			seq_num++;
---
> 			a2dp->seq_num++;
778c795
< 		frame_count++;
---
> 		a2dp->frame_count++;
974c991
< 	DBG("a2dp %p", a2dp);
---
> 	DBG("TEST a2dp %p", a2dp);
1042a1060
> 	a2dp->seq_num = 1;

--------------030006080403020105030308
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030006080403020105030308
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------030006080403020105030308--
