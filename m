Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <426C62D4.80009@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] A2DP sink code finally
References: <20050424150930.71134.qmail@web8308.mail.in.yahoo.com>
In-Reply-To: <20050424150930.71134.qmail@web8308.mail.in.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Sun, 24 Apr 2005 21:24:04 -0600

Mayank,

Thanks for the submission. I corrected some warnings, disabled unused 
functions, and added it to Makefile.am.

We definitely need to do a lot of cleanup (eg now that a2play and a2snk 
have so much duplication), but first off we need to see why audio is 
being distorted...

Brad

Mayank Batra wrote:
> Hi Brad,
> 
> This is the code for the A2DP sink application.
> 
> Compilation:
> 
> gcc -o a2snk a2snk.c -lbluetooth
> 
> Running the application:
> 
> ./a2snk
> 
> Right now the following bugs exist:
> 
> 1)   Poor sound quality.
> 
> 2)   Unclean disconnection.
> 
> Help me improve the above areas.
> 
> Please add this code to the CVS.
> 
> Thanks and Regards,
> 
> Mayank
> 
> ________________________________________________________________________
> Yahoo! India Matrimony: Find your life partner online
> Go to: http://yahoo.shaadi.com/india-matrimony
> 
> 
> ------------------------------------------------------------------------
> 
> /*
>  * a2snk.c
>  * This program functions as an A2DP sink
>  * (Emulation of an A2DP headset)
>  * Mayank Batra  <mayankbatra@yahoo.co.in>
>  * Abhinav Mathur <abhinavpmathur@yahoo.com>
>  * 
>  *   This program is free software; you can redistribute it and/or modify
>  *   it under the terms of the GNU General Public License as published by
>  *   the Free Software Foundation; either version 2 of the License, or
>  *   (at your option) any later version.
>  *
>  *   This program is distributed in the hope that it will be useful,
>  *   but WITHOUT ANY WARRANTY; without even the implied warranty of
>  *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>  *   GNU General Public License for more details.
>  *
>  *   You should have received a copy of the GNU General Public License
>  *   along with this program; if not, write to the Free Software
>  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
>  *
>  */
>  
> #ifdef HAVE_CONFIG_H
> #include <config.h>
> #endif
> 
> #include <stdio.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <getopt.h>
> #include <signal.h>
> #include <string.h>
> #include <sys/socket.h>
> #include <sys/stat.h>
> #include <sys/soundcard.h>	//To play the sound on the sound card
> 
> #include "sbc/sbc.h"
> 
> #include <bluetooth/bluetooth.h>
> #include <bluetooth/hci.h>
> #include <bluetooth/hci_lib.h>
> #include <bluetooth/l2cap.h>
> #include <bluetooth/sdp.h>
> #include <bluetooth/sdp_lib.h>
> 
> #include <netinet/in.h>
> 
> /* AVDTP structures */
> 
> /* packet components */
> 
> struct avdtp_header {
> 	//uint8_t packet_type:2;
> 	uint8_t message_type:2;
> 	uint8_t packet_type:2;
> 	uint8_t transaction_label:4;
> 	uint8_t signal_id:6;
> 	uint8_t rfa0:2;
> } __attribute__ ((packed));
> 
> struct acp_seid_info {
> 	uint8_t rfa0:1;
> 	uint8_t inuse0:1;
> 	uint8_t acp_seid:6;
> 	uint8_t rfa2:3;
> 	uint8_t tsep:1;
> 	uint8_t media_type:4;
> } __attribute__ ((packed));
> 
> struct sbc_codec_specific_elements {
> 	// a2dp p. 20
> 	uint8_t channel_mode:4;
> 	uint8_t frequency:4;
> 	uint8_t allocation_method:2;
> 	uint8_t subbands:2;
> 	uint8_t block_length:4;
> 	uint8_t min_bitpool;
> 	uint8_t max_bitpool;
> } __attribute__ ((packed));
> 
> #define MAX_ADDITIONAL_CODEC 0	//Right now only SBC is supported
> #define MAX_ADDITIONAL_CODEC_OCTETS (MAX_ADDITIONAL_CODEC*sizeof(struct acp_seid_info))
> 
> /* packets */
> 
> struct sepd_req {
> 	struct avdtp_header header;
> } __attribute__ ((packed));
> 
> struct sepd_resp {
> 	struct avdtp_header header;
> 	struct acp_seid_info infos[1 + MAX_ADDITIONAL_CODEC];
> } __attribute__ ((packed));
> 
> struct getcap_req {
> 	struct avdtp_header header;
> 	uint8_t rfa1:2;
> 	uint8_t acp_seid:6;
> } __attribute__ ((packed));
> 
> struct getcap_resp {
> 	struct avdtp_header header;
> 
> 	uint8_t serv_cap;
> 	uint8_t serv_cap_len;
> 
> 	uint8_t cap_type;
> 	uint8_t length;
> 	uint8_t media_type;
> 	uint8_t media_codec_type;
> 
> 	struct sbc_codec_specific_elements sbc_elements;
> 
> } __attribute__ ((packed));
> 
> struct set_config {
> 	struct avdtp_header header;
> 
> 	uint8_t rfa0:2;
> 	uint8_t acp_seid:6;
> 	uint8_t rfa1:2;
> 	uint8_t int_seid:6;
> 
> 	uint8_t serv_cap;
> 	uint8_t serv_cap_len;
> 
> 	uint8_t cap_type;
> 	uint8_t length;
> 	uint8_t media_type;
> 	uint8_t media_codec_type;
> 
> 	struct sbc_codec_specific_elements sbc_elements;
> 
> } __attribute__ ((packed));
> 
> struct set_config_resp {
> 	struct avdtp_header header;
> 
> 	// only present for an error
> 
> 	uint8_t serv_cat;
> 	uint8_t error_code;
> } __attribute__ ((packed));
> 
> struct open_stream_cmd {
> 	struct avdtp_header header;
> 	uint8_t rfa0:2;
> 	uint8_t acp_seid:6;
> } __attribute__ ((packed));
> 
> struct open_stream_rsp {
> 	struct avdtp_header header;
> 
> 	// only present for an error
> 
> 	uint8_t error;
> } __attribute__ ((packed));
> 
> struct start_stream_cmd {
> 	struct avdtp_header header;
> 	uint8_t rfa0:2;
> 	uint8_t acp_seid:6;
> } __attribute__ ((packed));
> 
> struct start_stream_rsp {
> 	struct avdtp_header header;
> 
> 	// only present for an error
> 
> 	uint8_t rfa0:2;
> 	uint8_t acp_seid:6;
> 	uint8_t error;
> } __attribute__ ((packed));
> 
> struct close_stream_cmd {
> 	struct avdtp_header header;
> 	uint8_t rfa0:2;
> 	uint8_t acp_seid:6;
> } __attribute__ ((packed));
> 
> struct close_stream_rsp {
> 	struct avdtp_header header;
> 
> 	// only present for an error
> 
> 	uint8_t error;
> } __attribute__ ((packed));
> 
> // this is an rtp, not bluetooth header, so values are big endian
> struct media_packet_header {
> 	uint8_t cc:4;
> 	uint8_t x:1;
> 	uint8_t p:1;
> 	uint8_t v:2;
> 
> 	uint8_t pt:7;
> 	uint8_t m:1;
> 
> 	uint16_t sequence_number;
> 	uint32_t timestamp;
> 	uint32_t ssrc;
> 	uint32_t csrc[0];
> } __attribute__ ((packed));
> 
> struct media_payload_header {
> 	uint8_t frame_count:4;
> 	uint8_t rfa0:1;
> 	uint8_t is_last_fragment:1;
> 	uint8_t is_first_fragment:1;
> 	uint8_t is_fragmented:1;
> } __attribute__ ((packed));
> 
> // SBC file format header
> 
> struct sbc_frame_header {
> 	uint8_t syncword:8;	/* Sync word */
> 	uint8_t subbands:1;	/* Subbands */
> 	uint8_t allocation_method:1;	/* Allocation method */
> 	uint8_t channel_mode:2;	/* Channel mode */
> 	uint8_t blocks:2;	/* Blocks */
> 	uint8_t sampling_frequency:2;	/* Sampling frequency */
> 	uint8_t bitpool:8;	/* Bitpool */
> 	uint8_t crc_check:8;	/* CRC check */
> } __attribute__ ((packed));
> 
> //A2DP signal types
> #define AVDTP_DISCOVER 1
> #define AVDTP_GET_CAPABILITIES 2
> #define AVDTP_SET_CONFIGURATION 3
> #define AVDTP_OPEN 6
> #define AVDTP_START 7
> #define AVDTP_CLOSE 8
> 
> #define MEDIA_TRANSPORT_CATEGORY 1
> #define MEDIA_CODEC 7
> 
> #define SBC_MEDIA_CODEC_TYPE 0
> #define MPEG12_MEDIA_CODEC_TYPE 1
> #define AUDIO_MEDIA_TYPE 0
> 
> //Packet Types
> #define PACKET_TYPE_SINGLE 0
> #define PACKET_TYPE_START 4
> #define PACKET_TYPE_CONTINUE 8
> #define PACKET_TYPE_END 12
> 
> //Message Types
> #define MESSAGE_TYPE_COMMAND 0
> #define MESSAGE_TYPE_ACCEPT 2
> #define MESSAGE_TYPE_REJECT 3
> 
> #define BUFS 1024
> 
> #define MEDIA_PACKET_HEADER_LENGTH 14
> 
> #define NONSPECAUDIO 1
> 
> static volatile int terminate = 0;
> static int cmdfd;
> static struct sbc_frame_header sbc_info;
> sbc_t sbc;
> int audio_fd;
> #define BUF_SIZE 4096
> unsigned char audio_buffer[BUF_SIZE];
> int speed, channels;
> 
> 
> static void sig_term(int sig)
> {
> 	terminate = 1;
> }
> 
> static void usage()
> {
> 	fprintf(stderr, "use: ./a2snk\n");
> }
> 
> int opensound()
> {
> 	int format=AFMT_S16_BE,len,i;
> 	char c;
> 
> 	if((audio_fd=open("/dev/dsp",O_WRONLY,0))==-1) {
> 		perror("\nFile open error\n");
> 		exit(1);
> 	}
> 	if(ioctl(audio_fd,SNDCTL_DSP_SETFMT,&format)==-1) {
> 		perror("\nioctl no. 1\n");
> 		exit(1);
> 	}
> 
> 	if(ioctl(audio_fd,SNDCTL_DSP_CHANNELS,&channels)==-1) {
> 		perror("\nioctl no. 2\n");
> 		exit(1);
> 	}
> 
> 	if(ioctl(audio_fd,SNDCTL_DSP_SPEED,&speed)==-1) {
> 		perror("\nioctl no. 3\n");
> 		exit(1);
> 	}
> 
> 	return 1;
> }
> 
> int closesound()
> {
> 	if(close(audio_fd)<0) {
> 		perror("\nUnable to close the sound card");
> 		exit(1);
> 	}
> }
> 
> 
> static ssize_t __write(int fd,void *buf,size_t count)
> {
> 	ssize_t len,pos=0;
> 	while(count>0){
> 		len=write(fd,buf+pos,count);
> 		if(len<=0)
> 			return len;
> 		count -= len;
> 		pos += len;
> 	}
> 	return pos;
> }
> 
> static void decode(char *stream,int streamlen)
> {
> 	int fd, id, pos, framelen;
> 	static int turn = 1;
> 	pos = 0;
> 
> 	framelen = sbc_decode(&sbc, stream, streamlen);
> 
> 	printf("%d Hz, %d channels\n", sbc.rate, sbc.channels);
> 	channels=sbc.channels;
> 	speed=sbc.rate;
> 	if(turn == 1) {
> 		/* Open the sound card only once during the streaming */
> 		opensound();
> 		turn = 0;
> 	}
> 
> 	char c;
> 	while (framelen > 0) {
> 		//dump_packet(sbc.data,sbc.len);
> 		write(audio_fd,sbc.data,sbc.len);
> 	
> 		pos += framelen;
> 
> 		framelen = sbc_decode(&sbc, stream + pos, streamlen - pos);
> 	}
> 
> }	
> 
> 
> 
> int sk;
> static int do_listen(bdaddr_t *src, unsigned short psm, uint16_t *mtu)
> {
> 	struct sockaddr_l2 addr;
> 	struct l2cap_options opts;
> 	
> 	int opt;
> 	int nsk;
> 
> 	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
> 	if (sk < 0) {
> 		fprintf(stderr, "Can't create socket. %s(%d)\n",
> 			strerror(errno), errno);
> 		return -1;
> 	}
> 	
> 	memset(&addr, 0, sizeof(addr));
> 	addr.l2_family = AF_BLUETOOTH;
> 	bacpy(&addr.l2_bdaddr, src);
> 	addr.l2_psm=htobs(psm);
> 	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
> 		fprintf(stderr, "Can't bind socket. %s(%d)\n",
> 						strerror(errno), errno);
> 		return -1;
> 	}
> 	
> 	/* Get default options */
> 	opt = sizeof(opts);
> 	if (getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
> 		fprintf(stderr, "Can't get default L2CAP options. %s(%d)\n",
> 						strerror(errno), errno);
> 		return -1;
> 	}
> 	
> 	/* Set new options */
> 	//opts.omtu = 48;
> 	//opts.imtu = imtu;
> 	if (setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, opt) < 0) {
> 		fprintf(stderr, "Can't set L2CAP options. %s(%d)\n",
> 						strerror(errno), errno);
> 		return -1;
> 	}
> 
> 	if(listen(sk,5)<0) {
> 		fprintf(stderr,"\nCan't listen.%s(%d)\n",strerror(errno),errno);
> 		close(sk);
> 		return -1;
> 	}
> 	
> 	socklen_t addrlen;
> 	
> 	memset(&addr, 0, sizeof(addr));
> 	addrlen = sizeof(addr);
> 
> 	if ((nsk = accept(sk, (struct sockaddr *) &addr, &addrlen)) < 0)
> 		return -1;
> 	else printf("\nConnected");
> 	
> 	opt = sizeof(opts);
> 	if (getsockopt(nsk, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
> 		fprintf(stderr, "Can't get L2CAP options. %s(%d)\n",
> 						strerror(errno), errno);
> 		close(nsk);
> 		return -1;
> 	}
> 
> 	fprintf(stderr, "Connected [imtu %d, omtu %d, flush_to %d]\n",
> 					opts.imtu, opts.omtu, opts.flush_to);
> 
> 	if (mtu)
> 		*mtu = opts.omtu;
> 
> 	return nsk;
> }
> 
> #if 0
> static void dump_packet(void *p, int size)
> {
> 	uint8_t *c = (uint8_t *) p;
> 	while (size-- > 0)
> 		printf(" %02x\n", *c++);
> 	printf("\n");
> }
> #endif
> 
> static void init_request(struct avdtp_header * header, int request_id)
> {
> 	static int transaction = 0;
> 
> 	header->packet_type = PACKET_TYPE_SINGLE;
> 	header->message_type = MESSAGE_TYPE_ACCEPT;
> 	header->transaction_label = transaction;
> 	header->signal_id = request_id;
> 
> 	// clear rfa bits
> 	header->rfa0 = 0;
> 	if(header->signal_id!=AVDTP_OPEN)
> 		transaction = (transaction + 1) & 0xf;
> 	else transaction = (transaction + 2) & 0xf;
> }
> 
> 
> static int calc_frame_len(struct sbc_frame_header *hdr)
> {
> 	int tmp, nrof_subbands, nrof_blocks;
> 
> 	nrof_subbands = (hdr->subbands + 1) * 4;
> 	nrof_blocks = (hdr->blocks + 1) * 4;
> 
> 	switch (hdr->channel_mode) {
> 	case 0x00:
> 		nrof_subbands /= 2;
> 		tmp = nrof_blocks * hdr->bitpool;
> 		break;
> 	case 0x01:
> 		tmp = nrof_blocks * hdr->bitpool * 2;
> 		break;
> 	case 0x02:
> 		tmp = nrof_blocks * hdr->bitpool;
> 		break;
> 	case 0x03:
> 		tmp = nrof_blocks * hdr->bitpool + nrof_subbands;
> 		break;
> 	default:
> 		return 0;
> 	}
> 
> 	return (nrof_subbands + ((tmp + 7) / 8));
> }
> 
> static int read_header(int fd, struct sbc_frame_header *sbc_info) {
> 	if (read(fd, sbc_info, sizeof(*sbc_info)) < sizeof(*sbc_info)) {
> 		fprintf(stderr, "reached end of file?\n");
> 		return -1;
> 	}
> 
> 	if (sbc_info->syncword != 0x9c) {
> 		printf("out of sync (0x%02x)\n", sbc_info->syncword);
> 		return -1;
> 	}
> 
> 	return calc_frame_len(sbc_info);
> }
> 
> int main(int argc, char *argv[])
> {
> 	struct sigaction sa;
> 	int streamfd;
> 
> 	bdaddr_t src, dst;
> 	unsigned short psm_cmd, psm_stream;
> 	unsigned long flags;
> 	int frame_len;
> 	time_t timestamp;
> 	uint16_t mtu, seq_num;
> 	int fd;
> 
> 	bacpy(&src, BDADDR_ANY);
> 
> 	psm_cmd=25;
> 	cmdfd = do_listen(&src, psm_cmd, NULL);
> 	if (cmdfd < 0) {
> 		fprintf(stderr, "cannot open psm_cmd = %d\n", psm_cmd);
> 		exit(-1);
> 	}
> 	// avdtp discover request
> 
>  	//Reading the discover request
> 	struct sepd_req get_resp;
> 	int size;
> 	size = read(cmdfd, &get_resp, sizeof(get_resp));
> 	if(get_resp.header.signal_id!=AVDTP_DISCOVER) {
> 		fprintf(stderr,"Couldn't get avdtp_discover\n");
> 		close(cmdfd);
> 		exit(-1);
> 	}
> 	else printf("\nGot Stream End Point Discovery Request");
>  	
> 	
> 	//Writing the discover response
> 
> 	struct sepd_resp send_resp;
> 	//Fill in the values in send_resp
> 	memset(&send_resp,0,sizeof(send_resp));
> 	init_request(&send_resp.header,AVDTP_DISCOVER);
> 	send_resp.infos[0].rfa0=0;
> 	send_resp.infos[0].inuse0=0;
> 	send_resp.infos[0].acp_seid=1;
> 	send_resp.infos[0].rfa2=2;
> 	send_resp.infos[0].tsep=1;
> 	send_resp.infos[0].media_type=0;
> 	
> 	if(write(cmdfd,&send_resp,sizeof(send_resp))!=sizeof(send_resp)) {
> 		fprintf(stderr,"\nCould not send discover response\n");
> 		close(cmdfd);
> 		exit(-1);
> 	}
> 	else printf("\nSent Stream End Point Discovery Response\n");
> 
> 	
> 	//Now read the get capablities request from the source
> 
> 	struct getcap_req get_req;
> 	memset(&get_req,0,sizeof(get_req));
> 	if(read(cmdfd,&get_req,sizeof(get_req))!=sizeof(get_req) || (get_req.header.signal_id!=AVDTP_GET_CAPABILITIES)) {
> 		fprintf(stderr,"\nDidn't get a get cap req");
> 	}
> 	else printf("\nGot a get capabilities request\n");
> 	
> 	//Send a get cap resp
> 	struct getcap_resp cap_resp;
> 	memset(&cap_resp,0,sizeof(cap_resp));
> 	init_request(&cap_resp.header,AVDTP_GET_CAPABILITIES);
> 	//Fill in the values of the structure
> 	cap_resp.serv_cap=MEDIA_TRANSPORT_CATEGORY;
> 	cap_resp.serv_cap_len=0;
> 	cap_resp.cap_type=MEDIA_CODEC;
> 	cap_resp.media_type=AUDIO_MEDIA_TYPE;
> 	cap_resp.length=6;
> 	cap_resp.media_codec_type=SBC_MEDIA_CODEC_TYPE;
> 	cap_resp.sbc_elements.channel_mode=15;
> 	cap_resp.sbc_elements.frequency=15;
> 	cap_resp.sbc_elements.allocation_method=3;
> 	cap_resp.sbc_elements.subbands=3;  
> 	cap_resp.sbc_elements.min_bitpool=2;
> 	cap_resp.sbc_elements.max_bitpool=250;
> 	cap_resp.sbc_elements.block_length=15;
> 	
> 	if(write(cmdfd,&cap_resp,sizeof(cap_resp))<sizeof(cap_resp)) {
> 		fprintf(stderr,"couldn't reply the caps\n");
> 	}
> 	else printf("\nSent the get capabilities response");
> 	
> 	//Now read the set config req
> 
> 	struct set_config s_config;
> 
> 	if(read(cmdfd,&s_config,sizeof(s_config))!=sizeof(s_config) || (s_config.header.signal_id!=AVDTP_SET_CONFIGURATION)) {
> 		fprintf(stderr,"couldn't get a set configurations request\n");
> 	}
> 	else printf("\nGot a set configurations request\n");
> 	
> 	//Now send the set config resp
> 
> 	struct set_config_resp s_resp;
> 	//Fill in the values of the structure
> 	memset(&s_resp,0,sizeof(s_resp));
> 	init_request(&s_resp.header,AVDTP_SET_CONFIGURATION);
> 	s_resp.header.signal_id=AVDTP_SET_CONFIGURATION;
> 	s_resp.header.message_type=MESSAGE_TYPE_ACCEPT;
> 	if(write(cmdfd,&s_resp,sizeof(s_resp))!=sizeof(s_resp)) {
> 		fprintf(stderr,"couldn't send set config resp\n");
> 	}
> 	else printf("\nSent a Set configurations response\n");
> 
> 	
> 	struct open_stream_cmd open_stream;
>       memset(&open_stream, 0, sizeof(open_stream));
>                                                                                 
>       if ((read(cmdfd, &open_stream, sizeof(open_stream)) != sizeof(open_stream)) || (open_stream.header.signal_id!=AVDTP_OPEN)){
>                printf("\nDidn't receive an open stream command\n");
>                return (-1);
>       }
>                                                                                 
>       printf("\nReceived an open stream command\n");
>                                                                               
>       struct open_stream_rsp open_resp;
> 	memset(&open_resp,0,sizeof(open_resp));
> 	init_request(&open_resp.header,AVDTP_OPEN);
> 	open_resp.header.signal_id=AVDTP_OPEN;
> 	open_resp.header.message_type=MESSAGE_TYPE_ACCEPT;
>       if (write(cmdfd, &open_resp, sizeof(open_resp)) < sizeof(open_resp)) {
>               fprintf(stderr, "couldn't send open stream response confirm for seid = %d\n", open_stream.acp_seid);
>               return (-1);
>       }
>                                                                                 
>       printf("\nSent open stream confirm\n");
> 
> 	// open the stream l2cap
> 
> 	mtu = 48;
> 	socklen_t addrlen;
>       struct sockaddr_l2 addr;                                                                                         
>       memset(&addr, 0, sizeof(addr));
>       addrlen = sizeof(addr);
>                                                                                                  
>       streamfd = accept(sk, (struct sockaddr *) &addr, &addrlen);
>                         
> 	if (streamfd < 0) {
> 		fprintf(stderr, "cannot open psm_stream = %d\n", psm_stream);
> 		exit(-1);
> 	}
> 	else printf("\nConnected on the streamfd channel");
> 	
> 	// start the stream
> 
> 	struct start_stream_cmd start_stream;
> 	memset(&start_stream, 0, sizeof(start_stream));
> 
> 	//Read the start stream command
> 	if (read(cmdfd, &start_stream, sizeof(start_stream)) != sizeof(start_stream) || (start_stream.header.signal_id!=AVDTP_START)) {
> 		fprintf(stderr, "\nDid not get a start stream command\n");
> 		close(streamfd);
> 		close(cmdfd);
> 		exit(-1);
> 	}
> 
> 	else printf("\nGot a stream-start command\n");
> 
> 	//Give the start stream response
> 	struct start_stream_rsp start_resp;
> 	//Fill in the values of the structure
> 	memset(&start_resp,0,sizeof(start_resp));
> 	init_request(&start_resp.header,AVDTP_START);
> 	if (write(cmdfd, &start_resp, sizeof(start_resp)) < sizeof(start_resp)) {
> 		fprintf(stderr, "Couldn't send start stream command confirm");
> 		close(streamfd);
> 		close(cmdfd);
> 		return (-1);
> 	}
> 
> 	else printf("\nSent start stream confirm\n");
> 
> 	char buf[BUFS];
> 	int psize;
> 
> 	if (mtu > BUFS)
> 		mtu = BUFS;
> 
> 	terminate = 0;
> 	seq_num = 1;
> 
> 	sbc_init(&sbc,SBC_NULL);
> 	struct media_packet_header packet_header;
> 	struct media_payload_header payload_header;
> 	memset(&payload_header, 0, sizeof(payload_header));
> 	int packsize; //Size of the packet that is read
> 	timestamp = 0;
> 	packsize=read(streamfd,buf,1024);
> 	decode(buf+(sizeof(packet_header)+sizeof(payload_header)),(packsize-sizeof(packet_header)-sizeof(payload_header)));
> 
> 	printf("Channels=%d,speed=%d",channels,speed);
> 	struct close_stream_cmd close_stream;
> 	memset(&close_stream,0,sizeof(close_stream));
> 	while (!terminate) {
> 
> 		packsize=read(streamfd, buf,1024);
> 		if(packsize < 0)
> 			break;
> 		printf("\nRead:%d bytes",packsize);
> 
> 		decode(buf+(sizeof(packet_header)+sizeof(payload_header)),(packsize-sizeof(packet_header)-sizeof(payload_header)));
> 		
> 		seq_num++;
> 	}
> 	sbc_finish(&sbc);
> 	
> 	printf("Received %d packets\n", seq_num);
> 
> 	// signal the stream close
> 	
> 	if (read(cmdfd, &close_stream, sizeof(close_stream)) != sizeof(close_stream)) {
> 		fprintf(stderr, "couldn't get close_stream\n");
> 		close(streamfd);
> 		close(cmdfd);
> 		exit(-1);
> 	}
> 
> 	if(close_stream.header.signal_id==AVDTP_CLOSE) {
> 		printf("Got stream-close\n");
> 		struct close_stream_rsp close_resp;
> 		init_request(&close_resp.header,AVDTP_CLOSE);
> 		if (write(cmdfd, &close_resp, sizeof(close_resp)) < sizeof(close_resp)) {
> 			fprintf(stderr, "Couldn't send close_resp confirm \n");
> 			close(streamfd);
> 			close(cmdfd);
> 			return (-1);
> 		}
> 		else printf("Sent close stream confirm\n");
> 	}
> 	else {
> 		printf("\nDidnt get a stream close as expected");
> 		close(streamfd);
> 		close(cmdfd);
> 		exit(-1);
> 	}
> 	closesound();
> 	close(streamfd);
> 	close(cmdfd);
> 
> 	return 0;
> }


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
