Return-Path: <fabchevalier@free.fr>
Message-ID: <4718E9A4.6090101@free.fr>
Date: Fri, 19 Oct 2007 19:30:12 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
CC: Brad Midgley <bmidgley@xmission.com>,
        Johan Hedberg <johan.hedberg@nokia.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>, thiagossantos@gmail.com,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] [PATCH] newapi patch v1
References: <4718E8E0.5050608@silicom.fr>
In-Reply-To: <4718E8E0.5050608@silicom.fr>
Content-Type: multipart/mixed;
 boundary="------------080105030805090608000400"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------080105030805090608000400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

As usual with this kind of big e-mails, you forget the most important 
thing, the attachement :-)

This one fixes this mistake.

Fabien


> 
> All, here is the first version of the patch that moves to the newapi
> usage... yeheee !!
> As nobody suggested a new name, i've just chose one, which is
> "btaudioservice.h" :-). Of course this can be changed if somebody
> prefers a better name :-)
> 
> This patch does not bring any new feature by itself, it's goal is only
> to get rid from the ipc.h stuff. However is is already quite big, but i
> really can't make it smaller without breaking stuff that is known to
> work today :-(
> 
> I did some basic testing of the patch, which is:
>   - play a file using a2dp, seek during playing (audacious)
>   - play a file using a2dp, seek during playing (rhythmnbox)
>   - play a file using SCO, seek during playing (audacious)
>   - record and play file using aplay & arecord.
> 
> I didn't notice any regression, but i don't want to fool anybody : such
> a big patch will inevitably bring its set of regressions, it's just that
> i haven't found them yet :-)
> 
> Due to the fairly big nature of the patch, i would suggest to wait for
> 3.21 before moving to the new api, this will give us the usual time
> between two bluez releases to :
>   - fix regressions introduced (my job :-) )
>   - upgrading the gstreamer plugin to use the new api ( i'd prefer
> thiagoss to work on this one (with my support of course), as i've never
> put my nose on this part of the code )
> 
> As usual, comments are welcome. ;-)
> 
> Cheers,
> 
> Fabien
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >> http://get.splunk.com/
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


--------------080105030805090608000400
Content-Type: text/plain;
 name="newapiv1.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="newapiv1.diff"

Index: pcm_bluetooth.c
===================================================================
--- pcm_bluetooth.c	(.../tags/20071019_1300/audio)	(révision 144)
+++ pcm_bluetooth.c	(.../branches/20071019_1300/audio)	(révision 144)
@@ -33,13 +33,13 @@
 
 #include <netinet/in.h>
 
 #include <alsa/asoundlib.h>
 #include <alsa/pcm_external.h>
 
-#include "ipc.h"
+#include "btaudioservice.h"
 #include "sbc.h"
 #include "rtp.h"
 
 //#define ENABLE_DEBUG
 
 #define UINT_SECS_MAX (UINT_MAX / 1000000 - 1)
@@ -65,38 +65,65 @@
 
 #ifndef SCO_RXBUFS
 #define SCO_RXBUFS 0x04
 #endif
 
 struct bluetooth_a2dp {
-	sbc_t sbc;			/* Codec data */
-	int codesize;			/* SBC codesize */
-	int samples;			/* Number of encoded samples */
-	uint8_t buffer[MAX_BUFFER_SIZE];/* Codec transfer buffer */
-	int count;			/* Codec transfer buffer counter */
-
-	int nsamples;			/* Cumulative number of codec samples */
-	uint16_t seq_num;		/* Cumulative packet sequence */
-	int frame_count;		/* Current frames in buffer*/
+	SBC_capabilities_t sbc_capabilities; 	
+	sbc_t sbc;				/* Codec data */
+	int sbc_initialized;			/* Keep track if the encoder is initialized */
+	int codesize;				/* SBC codesize */
+	int samples;				/* Number of encoded samples */
+	uint8_t buffer[MAX_BUFFER_SIZE];	/* Codec transfer buffer */
+	int count;				/* Codec transfer buffer counter */
+
+	int nsamples;				/* Cumulative number of codec samples */
+	uint16_t seq_num;			/* Cumulative packet sequence */
+	int frame_count;			/* Current frames in buffer*/
+};
+
+struct bluetooth_alsa_config {
+	char device[18];     		/* Address of the remote Device */
+	int has_device; 	
+	uint8_t transport;   		/* Requested transport */
+	int has_transport;	
+	uint16_t rate;
+	int has_rate;
+	uint8_t channel_mode;		/* A2DP only */
+	int has_channel_mode;
+	uint8_t allocation_method;	/* A2DP only */
+	int has_allocation_method;
+	uint8_t subbands;		/* A2DP only */
+	int has_subbands;
+	uint8_t block_length;		/* A2DP only */
+	int has_block_length;
+	uint8_t bitpool;		/* A2DP only */
+	int has_bitpool;
 };
 
 struct bluetooth_data {
 	snd_pcm_ioplug_t io;
+	struct bluetooth_alsa_config alsa_config;	/* ALSA resource file parameters */
 	volatile snd_pcm_sframes_t hw_ptr;
-	struct ipc_data_cfg cfg;	/* Bluetooth device config */
-	struct pollfd stream;		/* Audio stream filedescriptor */
-	struct pollfd server;		/* Audio daemon filedescriptor */
-	uint8_t buffer[MAX_BUFFER_SIZE];/* Encoded transfer buffer */
-	int count;			/* Transfer buffer counter */
-	struct bluetooth_a2dp a2dp;	/* A2DP data */
+	int transport;					/* chosen transport SCO or AD2P */	
+	int link_mtu;					/* MTU for selected transport channel */
+	volatile struct pollfd stream;			/* Audio stream filedescriptor */
+	struct pollfd server;				/* Audio daemon filedescriptor */
+	uint8_t buffer[MAX_BUFFER_SIZE];		/* Encoded transfer buffer */
+	int count;					/* Transfer buffer counter */
+	struct bluetooth_a2dp a2dp;			/* A2DP data */
 
-	pthread_t hw_thread;		/* Makes virtual hw pointer move */
-	int pipefd[2];			/* Inter thread communication */
+	pthread_t hw_thread;				/* Makes virtual hw pointer move */
+	int pipefd[2];					/* Inter thread communication */
 	int stopped;
 };
 
+static int audioservice_send(int sk, const bt_audio_msg_header_t * msg);
+static int audioservice_expect(int sk, bt_audio_msg_header_t * outmsg,
+				int expected_type);
+
 static int bluetooth_start(snd_pcm_ioplug_t *io)
 {
 	DBG("bluetooth_start %p", io);
 
 	return 0;
 }
@@ -184,78 +211,19 @@
 	}
 
 	data->hw_thread = 0;
 	pthread_exit(NULL);
 }
 
-#if 0
-static int bluetooth_state_init(struct ipc_packet *pkt, int newstate)
-{
-	struct ipc_data_state *state = (void *) pkt->data;
-
-	pkt->length = sizeof(*state);
-	pkt->type = PKT_TYPE_STATE_REQ;
-	pkt->error = PKT_ERROR_NONE;
-	state->state = newstate;
-
-	return 0;
-}
-
-static int bluetooth_state(struct bluetooth_data *data, int newstate)
-{
-	char buf[IPC_MTU];
-	struct ipc_packet *pkt = (void *) buf;
-	struct ipc_data_state *state = (void *) pkt->data;
-	int ret;
-
-	memset(buf, 0, sizeof(buf));
-
-	ret = bluetooth_state_init(pkt, newstate);
-	if (ret < 0)
-		return -ret;
-
-	ret = send(data->server.fd, pkt, sizeof(*pkt) + pkt->length, 0);
-	if (ret < 0)
-		return -errno;
-	else if (ret == 0)
-		return -EIO;
-
-	DBG("OK - %d bytes sent. Waiting for response...", ret);
-
-	memset(buf, 0, sizeof(buf));
-
-	ret = recv(data->server.fd, buf, sizeof(*pkt) + sizeof(*state), 0);
-	if (ret < 0)
-		return -errno;
-	else if (ret == 0)
-		return -EIO;
-
-	if (pkt->type != PKT_TYPE_STATE_RSP) {
-		SNDERR("Unexpected packet type %d received", pkt->type);
-		return -EINVAL;
-	}
-
-	if (pkt->error != PKT_ERROR_NONE) {
-		SNDERR("Error %d while configuring device", pkt->error);
-		return -pkt->error;
-	}
-
-	return 0;
-}
-#endif
-
 static int bluetooth_playback_start(snd_pcm_ioplug_t *io)
 {
 	struct bluetooth_data *data = io->private_data;
 	int err;
 
 	DBG("%p", io);
 
-#if 0
-	bluetooth_state(data, STATE_STREAMING);
-#endif
 	data->stopped = 0;
 
 	if (data->hw_thread)
 		return 0;
 
 	err = pthread_create(&data->hw_thread, 0, playback_hw_thread, data);
@@ -266,15 +234,12 @@
 static int bluetooth_playback_stop(snd_pcm_ioplug_t *io)
 {
 	struct bluetooth_data *data = io->private_data;
 
 	DBG("%p", io);
 
-#if 0
-	bluetooth_state(data, STATE_CONNECTED);
-#endif
 	data->stopped = 1;
 
 	return 0;
 }
 
 static snd_pcm_sframes_t bluetooth_pointer(snd_pcm_ioplug_t *io)
@@ -286,23 +251,23 @@
 
 static void bluetooth_exit(struct bluetooth_data *data)
 {
 	struct bluetooth_a2dp *a2dp = &data->a2dp;
 
 	if (data->server.fd >= 0)
-		close(data->server.fd);
+		bt_audio_service_close(data->server.fd);
 
 	if (data->stream.fd >= 0)
 		close(data->stream.fd);
 
 	if (data->hw_thread) {
 		pthread_cancel(data->hw_thread);
 		pthread_join(data->hw_thread, 0);
 	}
 
-	if (data->cfg.codec == CFG_CODEC_SBC)
+	if (a2dp->sbc_initialized)
 		sbc_finish(&a2dp->sbc);
 
 	if (data->pipefd[0] > 0)
 		close(data->pipefd[0]);
 
 	if (data->pipefd[1] > 0)
@@ -323,82 +288,207 @@
 }
 
 static int bluetooth_prepare(snd_pcm_ioplug_t *io)
 {
 	struct bluetooth_data *data = io->private_data;
 	char c = 'w';
+	char buf[BT_AUDIO_IPC_PACKET_SIZE];
+	struct bt_streamstart_req *start_req = (void*) buf;
+	struct bt_streamstart_rsp *start_rsp = (void*) buf;
+	struct bt_datafd_ind *datafd_ind = (void*) buf;
+	uint32_t period_count = io->buffer_size / io->period_size;
+	int opt_name, err;
+	struct timeval t = { 0, period_count };
 
 	DBG("Preparing with io->period_size=%lu io->buffer_size=%lu",
 					io->period_size, io->buffer_size);
 
+	/* As we're gonna receive messages on the server socket, we have to stop the 
+	   hw thread that is polling on it, if any */
+
+	if (data->hw_thread) {
+		pthread_cancel(data->hw_thread);
+		pthread_join(data->hw_thread, 0);
+		data->hw_thread = 0;
+	}
+
 	if (io->stream == SND_PCM_STREAM_PLAYBACK)
 		/* If not null for playback, xmms doesn't display time
 		 * correctly */
 		data->hw_ptr = 0;
 	else
 		/* ALSA library is really picky on the fact hw_ptr is not null.
 		 * If it is, capture won't start */
 		data->hw_ptr = io->period_size;
 
-	/* wake up any client polling at us */
-	return write(data->pipefd[1], &c, 1);
-}
+	/* send start */
+	memset(start_req, 0, BT_AUDIO_IPC_PACKET_SIZE);
+	start_req->h.msg_type = BT_STREAMSTART_REQ;
 
-static int bluetooth_hsp_hw_params(snd_pcm_ioplug_t *io,
-					snd_pcm_hw_params_t *params)
-{
-	struct bluetooth_data *data = io->private_data;
-	uint32_t period_count = io->buffer_size / io->period_size;
-	int opt_name, err;
+	err = audioservice_send(data->server.fd, &start_req->h);
+	if (err < 0)
+		return err;
+
+	err = audioservice_expect(data->server.fd, &start_rsp->h, BT_STREAMSTART_RSP);
+	if (err < 0)
+		return err;
+
+	if (start_rsp->posix_errno != 0) {
+		SNDERR("BT_START failed : %s(%d)",
+					strerror(start_rsp->posix_errno), 
+					start_rsp->posix_errno);
+		return -start_rsp->posix_errno;
+	}
+
+	err = audioservice_expect(data->server.fd, &datafd_ind->h, BT_STREAMFD_IND);
+	if (err < 0)
+		return err;
+
+	if (data->stream.fd >= 0)
+		close(data->stream.fd);
 
-	DBG("fd=%d period_count=%d", data->stream.fd, period_count);
+	data->stream.fd = bt_audio_service_get_data_fd(data->server.fd);
+	if (data->stream.fd < 0) {
+		return -errno;
+	}
+
+	if (data->transport == BT_CAPABILITIES_TRANSPORT_A2DP) {
+		opt_name = (io->stream == SND_PCM_STREAM_PLAYBACK) ?
+						SO_SNDTIMEO : SO_RCVTIMEO;
 
-	opt_name = (io->stream == SND_PCM_STREAM_PLAYBACK) ?
+		if (setsockopt(data->stream.fd, SOL_SOCKET, opt_name, &t,
+							sizeof(t)) < 0) {
+			return -errno;
+		}
+	} else {
+		opt_name = (io->stream == SND_PCM_STREAM_PLAYBACK) ?
 						SCO_TXBUFS : SCO_RXBUFS;
 
-	if (setsockopt(data->stream.fd, SOL_SCO, opt_name, &period_count,
+		if (setsockopt(data->stream.fd, SOL_SCO, opt_name, &period_count,
 						sizeof(period_count)) == 0)
-		return 0;
+			return 0;
 
-	opt_name = (io->stream == SND_PCM_STREAM_PLAYBACK) ?
+		opt_name = (io->stream == SND_PCM_STREAM_PLAYBACK) ?
 						SO_SNDBUF : SO_RCVBUF;
 
-	if (setsockopt(data->stream.fd, SOL_SCO, opt_name, &period_count,
+		if (setsockopt(data->stream.fd, SOL_SCO, opt_name, &period_count,
 						sizeof(period_count)) == 0)
-		return 0;
-
-	err = errno;
+			return 0;
 
-	SNDERR("%s (%d)", strerror(err), err);
+		/* FIXME : handle error codes */
+	}
 
-	/* FIXME: We should not ignores errors in the future. */
-	return 0;
+	/* wake up any client polling at us */
+	return write(data->pipefd[1], &c, 1);
 }
 
 static int bluetooth_a2dp_hw_params(snd_pcm_ioplug_t *io,
 					snd_pcm_hw_params_t *params)
 {
 	struct bluetooth_data *data = io->private_data;
-	uint32_t period_count = io->buffer_size / io->period_size;
-	int opt_name, err;
-	struct timeval t = { 0, period_count };
+	struct bluetooth_a2dp *a2dp = &data->a2dp;
+	char buf[BT_AUDIO_IPC_PACKET_SIZE];
+	struct bt_setconfiguration_req *setconf_req = (void*) buf;
+	struct bt_setconfiguration_rsp *setconf_rsp = (void*) buf;
+	int err;
+	SBC_capabilities_t active_capabilities;
 
-	DBG("fd=%d period_count=%d", data->stream.fd, period_count);
+	DBG("Preparing with io->period_size=%lu io->buffer_size=%lu",
+					io->period_size, io->buffer_size);
 
-	opt_name = (io->stream == SND_PCM_STREAM_PLAYBACK) ?
-						SO_SNDTIMEO : SO_RCVTIMEO;
+	/* FIXME: this needs to be really implemented (take into account 
+	real asoundrc settings + ALSA hw settings ) once server side sends us 
+	more than one possible configuration */
+	active_capabilities = a2dp->sbc_capabilities;
+	
+	memset(setconf_req, 0, BT_AUDIO_IPC_PACKET_SIZE);
+	setconf_req->h.msg_type = BT_SETCONFIGURATION_REQ;
+	setconf_req->sbc_capabilities = active_capabilities;
 
-	if (setsockopt(data->stream.fd, SOL_SOCKET, opt_name, &t,
-							sizeof(t)) == 0)
-		return 0;
+	err = audioservice_send(data->server.fd, &setconf_req->h);
+	if (err < 0)
+		return err;
 
-	err = errno;
+	err = audioservice_expect(data->server.fd, &setconf_rsp->h, BT_SETCONFIGURATION_RSP);
+	if (err < 0)
+		return err;
 
-	SNDERR("%s (%d)", strerror(err), err);
+	if (setconf_rsp->posix_errno != 0) {
+		SNDERR("BT_SETCONFIGURATION failed : %s(%d)",
+					strerror(setconf_rsp->posix_errno), 
+					setconf_rsp->posix_errno);
+		return -setconf_rsp->posix_errno;
+	}
 
-	return -err;
+	/* Setup SBC encoder now we agree on parameters */
+	if (a2dp->sbc_initialized)
+		sbc_finish(&a2dp->sbc);
+
+	/* FIXME: init using flags? */
+	sbc_init(&a2dp->sbc, 0);
+	a2dp->sbc_initialized = 1;
+	if (active_capabilities.frequency & BT_A2DP_SAMPLING_FREQ_16000)	
+		a2dp->sbc.rate = 16000;
+	
+	if (active_capabilities.frequency & BT_A2DP_SAMPLING_FREQ_32000)	
+		a2dp->sbc.rate = 32000;
+	
+	if (active_capabilities.frequency & BT_A2DP_SAMPLING_FREQ_44100)	
+		a2dp->sbc.rate = 44100;
+	
+	if (active_capabilities.frequency & BT_A2DP_SAMPLING_FREQ_48000)	
+		a2dp->sbc.rate = 48000;
+	
+	if (active_capabilities.channel_mode & BT_A2DP_CHANNEL_MODE_MONO)	
+		a2dp->sbc.channels = 1;
+	else
+		a2dp->sbc.channels = 2;
+
+	if (active_capabilities.channel_mode &
+			(BT_A2DP_CHANNEL_MODE_MONO || BT_A2DP_CHANNEL_MODE_JOINT_STEREO))
+		a2dp->sbc.joint = 1;
+	else
+		a2dp->sbc.joint = 0;
+
+	a2dp->sbc.allocation = active_capabilities.allocation_method 
+					== BT_A2DP_ALLOCATION_SNR ? 0x01 : 0x00;
+	
+	switch (active_capabilities.subbands) {
+	case BT_A2DP_SUBBANDS_4:
+		a2dp->sbc.subbands = 4;
+		break;
+	case BT_A2DP_SUBBANDS_8:
+		a2dp->sbc.subbands = 8;
+		break;
+	}
+
+	switch (active_capabilities.block_length) {
+	case BT_A2DP_BLOCK_LENGTH_4:
+		a2dp->sbc.blocks = 4;
+		break;
+	case BT_A2DP_BLOCK_LENGTH_8:
+		a2dp->sbc.blocks = 8;
+		break;
+	case BT_A2DP_BLOCK_LENGTH_12:
+		a2dp->sbc.blocks = 12;
+		break;
+	case BT_A2DP_BLOCK_LENGTH_16:
+		a2dp->sbc.blocks = 16;
+		break;
+	}
+
+	a2dp->sbc.bitpool = active_capabilities.max_bitpool;
+	a2dp->codesize = a2dp->sbc.subbands * a2dp->sbc.blocks *
+						a2dp->sbc.channels * 2;
+	a2dp->count = sizeof(struct rtp_header) + sizeof(struct rtp_payload);
+
+	DBG("\tallocation=%u\n\tsubbands=%u\n\tblocks=%u\n\tbitpool=%u\n",
+		a2dp->sbc.allocation, a2dp->sbc.subbands, a2dp->sbc.blocks,
+		a2dp->sbc.bitpool); 
+
+	return 0;
 }
 
 static int bluetooth_poll_descriptors(snd_pcm_ioplug_t *io,
 					struct pollfd *pfd, unsigned int space)
 {
 	struct bluetooth_data *data = io->private_data;
@@ -470,55 +560,54 @@
 
 static snd_pcm_sframes_t bluetooth_hsp_read(snd_pcm_ioplug_t *io,
 				const snd_pcm_channel_area_t *areas,
 				snd_pcm_uframes_t offset, snd_pcm_uframes_t size)
 {
 	struct bluetooth_data *data = io->private_data;
-	struct ipc_data_cfg cfg = data->cfg;
 	snd_pcm_uframes_t frames_to_write, ret;
 	unsigned char *buff;
 	int nrecv, frame_size = 0;
 
 	DBG("areas->step=%u areas->first=%u offset=%lu size=%lu io->nonblock=%u",
 			areas->step, areas->first, offset, size, io->nonblock);
 
 	if (data->count > 0)
 		goto proceed;
 
 	frame_size = areas->step / 8;
 
-	nrecv = recv(data->stream.fd, data->buffer, cfg.pkt_len,
+	nrecv = recv(data->stream.fd, data->buffer, data->link_mtu,
 			MSG_WAITALL | (io->nonblock ? MSG_DONTWAIT : 0));
 
 	if (nrecv < 0) {
 		ret = (errno == EPIPE) ? -EIO : -errno;
 		goto done;
 	}
 
-	if (nrecv != cfg.pkt_len) {
+	if (nrecv != data->link_mtu) {
 		ret = -EIO;
 		SNDERR(strerror(-ret));
 		goto done;
 	}
 
 	/* Increment hardware transmition pointer */
-	data->hw_ptr = (data->hw_ptr + cfg.pkt_len / cfg.sample_size) %
+	data->hw_ptr = (data->hw_ptr + data->link_mtu / frame_size) %
 								io->buffer_size;
 
 proceed:
 	buff = (unsigned char *) areas->addr +
 			(areas->first + areas->step * offset) / 8;
 
-	if ((data->count + size * frame_size) <= cfg.pkt_len)
+	if ((data->count + size * frame_size) <= data->link_mtu)
 		frames_to_write = size;
 	else
-		frames_to_write = (cfg.pkt_len - data->count) / frame_size;
+		frames_to_write = (data->link_mtu - data->count) / frame_size;
 
 	memcpy(buff, data->buffer + data->count, frame_size * frames_to_write);
 	data->count += (frame_size * frames_to_write);
-	data->count %= cfg.pkt_len;
+	data->count %= data->link_mtu;
 
 	/* Return written frames count */
 	ret = frames_to_write;
 
 done:
 	DBG("returning %lu", ret);
@@ -527,13 +616,12 @@
 
 static snd_pcm_sframes_t bluetooth_hsp_write(snd_pcm_ioplug_t *io,
 				const snd_pcm_channel_area_t *areas,
 				snd_pcm_uframes_t offset, snd_pcm_uframes_t size)
 {
 	struct bluetooth_data *data = io->private_data;
-	struct ipc_data_cfg cfg = data->cfg;
 	snd_pcm_sframes_t ret = 0;
 	snd_pcm_uframes_t frames_to_read;
 	uint8_t *buff;
 	int rsend, frame_size;
 
 	DBG("areas->step=%u areas->first=%u offset=%lu, size=%lu io->nonblock=%u",
@@ -544,32 +632,32 @@
 		if (ret == 0)
 			ret = -EPIPE;
 		goto done;
 	}
 
 	frame_size = areas->step / 8;
-	if ((data->count + size * frame_size) <= cfg.pkt_len)
+	if ((data->count + size * frame_size) <= data->link_mtu)
 		frames_to_read = size;
 	else
-		frames_to_read = (cfg.pkt_len - data->count) / frame_size;
+		frames_to_read = (data->link_mtu - data->count) / frame_size;
 
 	DBG("count=%d frames_to_read=%lu", data->count, frames_to_read);
 
 	/* Ready for more data */
 	buff = (uint8_t *) areas->addr +
 			(areas->first + areas->step * offset) / 8;
 	memcpy(data->buffer + data->count, buff, frame_size * frames_to_read);
 
 	/* Remember we have some frames in the pipe now */
 	data->count += frames_to_read * frame_size;
-	if (data->count != cfg.pkt_len) {
+	if (data->count != data->link_mtu) {
 		ret = frames_to_read;
 		goto done;
 	}
 
-	rsend = send(data->stream.fd, data->buffer, cfg.pkt_len,
+	rsend = send(data->stream.fd, data->buffer, data->link_mtu,
 			io->nonblock ? MSG_DONTWAIT : 0);
 	if (rsend > 0) {
 		/* Reset count pointer */
 		data->count = 0;
 
 		ret = frames_to_read;
@@ -666,13 +754,13 @@
 	if ((data->count + size * frame_size) <= a2dp->codesize)
 		frames_to_read = size;
 	else
 		frames_to_read = (a2dp->codesize - data->count) / frame_size;
 
 	DBG("count=%d frames_to_read=%lu", data->count, frames_to_read);
-	DBG("a2dp.count=%d cfg.pkt_len=%d", a2dp->count, data->cfg.pkt_len);
+	DBG("a2dp.count=%d data.link_mtu=%d", a2dp->count, data->link_mtu);
 
 	/* FIXME: If state is not streaming then return */
 
 	/* Ready for more data */
 	buff = (uint8_t *) areas->addr +
 				(areas->first + areas->step * offset) / 8;
@@ -693,13 +781,13 @@
 	}
 
 	data->count -= encoded;
 
 	DBG("encoded=%d  a2dp.sbc.len=%d", encoded, a2dp->sbc.len);
 
-	if (a2dp->count + a2dp->sbc.len >= data->cfg.pkt_len) {
+	if (a2dp->count + a2dp->sbc.len >= data->link_mtu) {
 		ret = avdtp_write(data);
 		if (ret < 0) {
 			if (-ret == EPIPE)
 				ret = -EIO;
 			goto done;
 		}
@@ -739,26 +827,24 @@
 
 static snd_pcm_ioplug_callback_t bluetooth_hsp_playback = {
 	.start			= bluetooth_playback_start,
 	.stop			= bluetooth_playback_stop,
 	.pointer		= bluetooth_pointer,
 	.close			= bluetooth_close,
-	.hw_params		= bluetooth_hsp_hw_params,
 	.prepare		= bluetooth_prepare,
 	.transfer		= bluetooth_hsp_write,
 	.poll_descriptors	= bluetooth_playback_poll_descriptors,
 	.poll_revents		= bluetooth_playback_poll_revents,
 	.delay			= bluetooth_playback_delay,
 };
 
 static snd_pcm_ioplug_callback_t bluetooth_hsp_capture = {
 	.start			= bluetooth_start,
 	.stop			= bluetooth_stop,
 	.pointer		= bluetooth_pointer,
 	.close			= bluetooth_close,
-	.hw_params		= bluetooth_hsp_hw_params,
 	.prepare		= bluetooth_prepare,
 	.transfer		= bluetooth_hsp_read,
 	.poll_descriptors	= bluetooth_poll_descriptors,
 	.poll_revents		= bluetooth_poll_revents,
 };
 
@@ -789,24 +875,23 @@
 
 #define ARRAY_NELEMS(a) (sizeof((a)) / sizeof((a)[0]))
 
 static int bluetooth_hsp_hw_constraint(snd_pcm_ioplug_t *io)
 {
 	struct bluetooth_data *data = io->private_data;
-	struct ipc_data_cfg cfg = data->cfg;
 	snd_pcm_access_t access_list[] = {
 		SND_PCM_ACCESS_RW_INTERLEAVED,
 		/* Mmap access is really useless fo this driver, but we
 		 * support it because some pieces of software out there
 		 * insist on using it */
 		SND_PCM_ACCESS_MMAP_INTERLEAVED
 	};
 	unsigned int format_list[] = {
 		SND_PCM_FORMAT_S16_LE
 	};
-	int err, channels;
+	int err;
 
 	/* access type */
 	err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_ACCESS,
 					ARRAY_NELEMS(access_list), access_list);
 	if (err < 0)
 		return err;
@@ -815,27 +900,26 @@
 	err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_FORMAT,
 					ARRAY_NELEMS(format_list), format_list);
 	if (err < 0)
 		return err;
 
 	/* supported channels */
-	channels = cfg.mode == CFG_MODE_MONO ? 1 : 2;
 	err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_CHANNELS,
-							channels, channels);
+							1, 1);
 	if (err < 0)
 		return err;
 
 	/* supported rate */
 	err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_RATE,
-							cfg.rate, cfg.rate);
+							8000, 8000);
 	if (err < 0)
 		return err;
 
 	/* supported block size */
 	err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_PERIOD_BYTES,
-						cfg.pkt_len, cfg.pkt_len);
+						data->link_mtu, data->link_mtu);
 	if (err < 0)
 		return err;
 
 	err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_PERIODS,
 									2, 200);
 	if (err < 0)
@@ -845,24 +929,25 @@
 }
 
 static int bluetooth_a2dp_hw_constraint(snd_pcm_ioplug_t *io)
 {
 	struct bluetooth_data *data = io->private_data;
 	struct bluetooth_a2dp *a2dp = &data->a2dp;
-	struct ipc_data_cfg cfg = data->cfg;
 	snd_pcm_access_t access_list[] = {
 		SND_PCM_ACCESS_RW_INTERLEAVED,
 		/* Mmap access is really useless fo this driver, but we
 		 * support it because some pieces of software out there
 		 * insist on using it */
 		SND_PCM_ACCESS_MMAP_INTERLEAVED
 	};
 	unsigned int format_list[] = {
 		SND_PCM_FORMAT_S16_LE
 	};
-	int err, channels;
+	unsigned int rate_list[4];
+	unsigned int rate_count;
+	int err, min_channels, max_channels;
 
 	/* access type */
 	err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_ACCESS,
 					ARRAY_NELEMS(access_list), access_list);
 	if (err < 0)
 		return err;
@@ -871,139 +956,79 @@
 	err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_FORMAT,
 					ARRAY_NELEMS(format_list), format_list);
 	if (err < 0)
 		return err;
 
 	/* supported channels */
-	channels = cfg.mode == CFG_MODE_MONO ? 1 : 2;
+	if (a2dp->sbc_capabilities.channel_mode & BT_A2DP_CHANNEL_MODE_MONO)
+		min_channels = 1;
+	else
+		min_channels = 2;
+
+	if (a2dp->sbc_capabilities.channel_mode & (~BT_A2DP_CHANNEL_MODE_MONO))
+		max_channels = 2;
+	else
+		max_channels = 1;
+	
 	err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_CHANNELS,
-							channels, channels);
+							min_channels, max_channels);
 	if (err < 0)
 		return err;
 
-	/* supported rate */
-	err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_RATE,
-							cfg.rate, cfg.rate);
+	/* supported rates */
+	rate_count = 0;	
+	if (a2dp->sbc_capabilities.frequency & BT_A2DP_SAMPLING_FREQ_16000) {
+		rate_list[rate_count] = 16000;		
+		rate_count++;
+	}
+	
+	if (a2dp->sbc_capabilities.frequency & BT_A2DP_SAMPLING_FREQ_32000) {
+		rate_list[rate_count] = 32000;		
+		rate_count++;
+	}
+	
+	if (a2dp->sbc_capabilities.frequency & BT_A2DP_SAMPLING_FREQ_44100) {
+		rate_list[rate_count] = 44100;		
+		rate_count++;
+	}
+	
+	if (a2dp->sbc_capabilities.frequency & BT_A2DP_SAMPLING_FREQ_48000) {
+		rate_list[rate_count] = 48000;		
+		rate_count++;
+	}
+	
+	err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_RATE,
+							rate_count, rate_list);
 	if (err < 0)
 		return err;
 
-	/* supported block sizes:
-	 *   - lower limit is A2DP codec size
-	 *   - total buffer size is the upper limit (with two periods) */
-	err = snd_pcm_ioplug_set_param_minmax(io,
-						SND_PCM_IOPLUG_HW_PERIOD_BYTES,
-						a2dp->codesize,
-						MAX_BUFFER_SIZE / 2);
+	/* supported block size */
+	err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_PERIOD_BYTES,
+						512, MAX_BUFFER_SIZE / 2);
 	if (err < 0)
 		return err;
 
 	/* supported buffer sizes */
 	err = snd_pcm_ioplug_set_param_minmax(io,
 						SND_PCM_IOPLUG_HW_BUFFER_BYTES,
 						MIN_BUFFER_SIZE,
 						MAX_BUFFER_SIZE);
 	if (err < 0)
 		return err;
 
-	/* supported period count: 
-	 *   - derived from max buffer size and minimum period size */
-	err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_PERIODS,
-					2, MAX_BUFFER_SIZE / a2dp->codesize);
-	if (err < 0)
-		return err;
-
 	return 0;
 }
 
-static int bluetooth_recvmsg_fd(struct bluetooth_data *data)
-{
-	char cmsg_b[CMSG_SPACE(sizeof(int))], m;
-	int err, ret;
-	struct iovec iov = { &m, sizeof(m) };
-	struct msghdr msgh;
-	struct cmsghdr *cmsg;
-
-	memset(&msgh, 0, sizeof(msgh));
-	msgh.msg_iov = &iov;
-	msgh.msg_iovlen = 1;
-	msgh.msg_control = &cmsg_b;
-	msgh.msg_controllen = CMSG_LEN(sizeof(int));
-
-	ret = recvmsg(data->server.fd, &msgh, 0);
-	if (ret < 0) {
-		err = errno;
-		SNDERR("Unable to receive fd: %s (%d)", strerror(err), err);
-		return -err;
-	}
-
-	/* Receive auxiliary data in msgh */
-	for (cmsg = CMSG_FIRSTHDR(&msgh); cmsg != NULL;
-			cmsg = CMSG_NXTHDR(&msgh, cmsg)) {
-		if (cmsg->cmsg_level == SOL_SOCKET
-				&& cmsg->cmsg_type == SCM_RIGHTS) {
-			data->stream.fd = (*(int *) CMSG_DATA(cmsg));
-			DBG("stream_fd=%d", data->stream.fd);
-			return 0;
-		}
-	}
-
-	return -EINVAL;
-}
-
-static int bluetooth_a2dp_init(struct bluetooth_data *data,
-				struct ipc_codec_sbc *sbc)
+static int bluetooth_parse_config(snd_config_t *conf,
+				struct bluetooth_alsa_config *bt_config)
 {
-	struct bluetooth_a2dp *a2dp = &data->a2dp;
-	struct ipc_data_cfg *cfg = &data->cfg;
-
-	if (cfg == NULL) {
-		SNDERR("Error getting codec parameters");
-		return -1;
-	}
-
-	if (cfg->codec != CFG_CODEC_SBC)
-		return -1;
-
-	/* FIXME: init using flags? */
-	sbc_init(&a2dp->sbc, 0);
-	a2dp->sbc.rate = cfg->rate;
-	a2dp->sbc.channels = cfg->mode == CFG_MODE_MONO ? 1 : 2;
-	if (cfg->mode == CFG_MODE_MONO || cfg->mode == CFG_MODE_JOINT_STEREO)
-		a2dp->sbc.joint = 1;
-	a2dp->sbc.allocation = sbc->allocation;
-	a2dp->sbc.subbands = sbc->subbands;
-	a2dp->sbc.blocks = sbc->blocks;
-	a2dp->sbc.bitpool = sbc->bitpool;
-	a2dp->codesize = a2dp->sbc.subbands * a2dp->sbc.blocks *
-						a2dp->sbc.channels * 2;
-	a2dp->count = sizeof(struct rtp_header) + sizeof(struct rtp_payload);
-
-	DBG("\tallocation=%u\n\tsubbands=%u\n\tblocks=%u\n\tbitpool=%u\n",
-		a2dp->sbc.allocation, a2dp->sbc.subbands, a2dp->sbc.blocks,
-		a2dp->sbc.bitpool);
-
-	return 0;
-}
-
-static int bluetooth_cfg_init(struct ipc_packet *pkt, snd_pcm_stream_t stream,
-				snd_config_t *conf)
-{
-	struct ipc_data_cfg *cfg = (void *) pkt->data;
-	struct ipc_codec_sbc *sbc = (void *) cfg->data;
 	snd_config_iterator_t i, next;
 	const char *addr, *pref;
 	const char *mode, *allocation, *rate, *subbands, *blocks, *bitpool;
 
-	switch (stream) {
-	case SND_PCM_STREAM_PLAYBACK:
-		cfg->fd_opt = CFG_FD_OPT_WRITE;
-		break;
-	case SND_PCM_STREAM_CAPTURE:
-		cfg->fd_opt = CFG_FD_OPT_READ;
-		break;
-	}
+	memset(bt_config, 0, sizeof(struct bluetooth_alsa_config));
 
 	snd_config_for_each(i, next, conf) {
 		snd_config_t *n = snd_config_iterator_entry(i);
 		const char *id;
 
 		if (snd_config_get_id(n, &id) < 0)
@@ -1015,260 +1040,264 @@
 		if (strcmp(id, "device") == 0 || strcmp(id, "bdaddr") == 0) {
 			if (snd_config_get_string(n, &addr) < 0) {
 				SNDERR("Invalid type for %s", id);
 				return -EINVAL;
 			}
 
-			strncpy(pkt->device, addr, 18);
+			bt_config->has_device = 1;
+			strncpy(bt_config->device, addr, 18);
 			continue;
 		}
 
 		if (strcmp(id, "profile") == 0) {
 			if (snd_config_get_string(n, &pref) < 0) {
 				SNDERR("Invalid type for %s", id);
 				return -EINVAL;
 			}
 
-			if (strcmp(pref, "auto") == 0)
-				pkt->role = PKT_ROLE_AUTO;
-			else if (strcmp(pref, "voice") == 0 ||
+			if (strcmp(pref, "auto") == 0) {
+				bt_config->transport = BT_CAPABILITIES_TRANSPORT_ANY;
+				bt_config->has_transport = 1;			
+			} else if (strcmp(pref, "voice") == 0 ||
 						strcmp(pref, "hfp") == 0) {
-				pkt->role = PKT_ROLE_VOICE;
+				bt_config->transport = BT_CAPABILITIES_TRANSPORT_SCO;
+				bt_config->has_transport = 1;			
 			} else if (strcmp(pref, "hifi") == 0 ||
-						strcmp(pref, "a2dp") == 0)
-				pkt->role = PKT_ROLE_HIFI;
+						strcmp(pref, "a2dp") == 0) {
+				bt_config->transport = BT_CAPABILITIES_TRANSPORT_A2DP;
+				bt_config->has_transport = 1;			
+			}
 			continue;
 		}
 
 		if (strcmp(id, "rate") == 0) {
 			if (snd_config_get_string(n, &rate) < 0) {
 				SNDERR("Invalid type for %s", id);
 				return -EINVAL;
 			}
 
-			cfg->rate = atoi(rate);
+			bt_config->rate = atoi(rate);
+			bt_config->has_rate = 1;
 			continue;
 		}
 
 		if (strcmp(id, "mode") == 0) {
 			if (snd_config_get_string(n, &mode) < 0) {
 				SNDERR("Invalid type for %s", id);
 				return -EINVAL;
 			}
 
-			if (strcmp(pref, "auto") == 0)
-				cfg->mode = CFG_MODE_AUTO;
-			else if (strcmp(pref, "mono") == 0)
-				cfg->mode = CFG_MODE_MONO;
-			else if (strcmp(pref, "dual") == 0)
-				cfg->mode = CFG_MODE_DUAL_CHANNEL;
-			else if (strcmp(pref, "stereo") == 0)
-				cfg->mode = CFG_MODE_STEREO;
-			else if (strcmp(pref, "joint") == 0)
-				cfg->mode = CFG_MODE_JOINT_STEREO;
+			if (strcmp(pref, "auto") == 0) {
+				bt_config->channel_mode = BT_A2DP_CHANNEL_MODE_MONO_AUTO;
+				bt_config->has_channel_mode = 1;
+			} else if (strcmp(pref, "mono") == 0) {
+				bt_config->channel_mode = BT_A2DP_CHANNEL_MODE_MONO;
+				bt_config->has_channel_mode = 1;
+			} else if (strcmp(pref, "dual") == 0) {
+				bt_config->channel_mode = BT_A2DP_CHANNEL_MODE_DUAL_CHANNEL;
+				bt_config->has_channel_mode = 1;
+			} else if (strcmp(pref, "stereo") == 0) {
+				bt_config->channel_mode = BT_A2DP_CHANNEL_MODE_STEREO;
+				bt_config->has_channel_mode = 1;
+			} else if (strcmp(pref, "joint") == 0) {
+				bt_config->channel_mode = BT_A2DP_CHANNEL_MODE_JOINT_STEREO;
+				bt_config->has_channel_mode = 1;
+			}			
 			continue;
 		}
 
 		if (strcmp(id, "allocation") == 0) {
 			if (snd_config_get_string(n, &allocation) < 0) {
 				SNDERR("Invalid type for %s", id);
 				return -EINVAL;
 			}
 
-			if (strcmp(pref, "auto") == 0)
-				sbc->allocation = CFG_ALLOCATION_AUTO;
-			else if (strcmp(pref, "loudness") == 0)
-				sbc->allocation = CFG_ALLOCATION_LOUDNESS;
-			else if (strcmp(pref, "snr") == 0)
-				sbc->allocation = CFG_ALLOCATION_SNR;
+			if (strcmp(pref, "auto") == 0) {
+				bt_config->allocation_method = BT_A2DP_ALLOCATION_AUTO;
+				bt_config->has_allocation_method = 1;
+			} else if (strcmp(pref, "loudness") == 0) {
+				bt_config->allocation_method = BT_A2DP_ALLOCATION_LOUDNESS;
+				bt_config->has_allocation_method = 1;
+			} else if (strcmp(pref, "snr") == 0) {
+				bt_config->allocation_method = BT_A2DP_ALLOCATION_SNR;
+				bt_config->has_allocation_method = 1;
+			}
 			continue;
 		}
 
 		if (strcmp(id, "subbands") == 0) {
 			if (snd_config_get_string(n, &subbands) < 0) {
 				SNDERR("Invalid type for %s", id);
 				return -EINVAL;
 			}
 
-			sbc->subbands = atoi(subbands);
+			bt_config->subbands = atoi(subbands);
+			bt_config->has_subbands = 1;
 			continue;
 		}
 
 		if (strcmp(id, "blocks") == 0) {
 			if (snd_config_get_string(n, &blocks) < 0) {
 				SNDERR("Invalid type for %s", id);
 				return -EINVAL;
 			}
 
-			sbc->blocks = atoi(blocks);
+			bt_config->block_length = atoi(blocks);
+			bt_config->has_block_length = 1;
 			continue;
 		}
 
 		if (strcmp(id, "bitpool") == 0) {
 			if (snd_config_get_string(n, &bitpool) < 0) {
 				SNDERR("Invalid type for %s", id);
 				return -EINVAL;
 			}
 
-			sbc->bitpool = atoi(bitpool);
+			bt_config->bitpool = atoi(bitpool);
+			bt_config->has_bitpool = 1;
 			continue;
 		}
 
 		SNDERR("Unknown field %s", id);
 		return -EINVAL;
 	}
 
-	pkt->length = sizeof(*cfg) + sizeof(*sbc);
-	pkt->type = PKT_TYPE_CFG_REQ;
-	pkt->error = PKT_ERROR_NONE;
-
 	return 0;
 }
 
-static int bluetooth_cfg(struct bluetooth_data *data, snd_pcm_stream_t stream,
-				snd_config_t *conf)
+static int audioservice_send(int sk, const bt_audio_msg_header_t * msg)
 {
-	int ret, total;
-	char buf[IPC_MTU];
-	struct ipc_packet *pkt = (void *) buf;
-	struct ipc_data_cfg *cfg = (void *) pkt->data;
-	struct ipc_codec_sbc *sbc = (void *) cfg->data;
-
-	DBG("Sending PKT_TYPE_CFG_REQ...");
-
-	memset(buf, 0, sizeof(buf));
-
-	ret = bluetooth_cfg_init(pkt, stream, conf);
-	if (ret < 0)
-		return -ret;
-
-	ret = send(data->server.fd, pkt, sizeof(*pkt) + pkt->length, 0);
-	if (ret < 0)
-		return -errno;
-	else if (ret == 0)
-		return -EIO;
-
-	DBG("OK - %d bytes sent. Waiting for response...", ret);
-
-	memset(buf, 0, sizeof(buf));
-
-	ret = recv(data->server.fd, buf, sizeof(*pkt) + sizeof(*cfg), 0);
-	if (ret < 0)
-		return -errno;
-	else if (ret == 0)
-		return -EIO;
-
-	total = ret;
-
-	if (pkt->type != PKT_TYPE_CFG_RSP) {
-		SNDERR("Unexpected packet type %d received", pkt->type);
-		return -EINVAL;
-	}
-
-	if (pkt->error != PKT_ERROR_NONE) {
-		SNDERR("Error %d while configuring device", pkt->error);
-		return -pkt->error;
-	}
-
-	if (cfg->codec != CFG_CODEC_SBC)
-		goto done;
-
-	ret = recv(data->server.fd, sbc, sizeof(*sbc), 0);
-	if (ret < 0)
-		return -errno;
-	else if (ret == 0)
-		return -EIO;
-
-	total += ret;
-
-done:
-	DBG("OK - %d bytes received", total);
-
-	if (pkt->length != (total - sizeof(struct ipc_packet))) {
-		SNDERR("Error while configuring device: packet size doesn't match");
-		return -EINVAL;
+	int err;
+	DBG("sending %s", bt_audio_strmsg[msg->msg_type]);
+	if (send(sk, msg, BT_AUDIO_IPC_PACKET_SIZE, 0) > 0) {
+		err = 0;
+	} else {
+		err = -errno;
+		SNDERR("Error sending data to audio service: %s(%d)", strerror(errno), errno);
 	}
+	return err;
+}
 
-	memcpy(&data->cfg, cfg, sizeof(*cfg));
-
-	DBG("Device configuration:");
-
-	DBG("\n\tfd=%d\n\tfd_opt=%u\n\tpkt_len=%u\n\tsample_size=%u\n\trate=%u",
-			data->stream.fd, data->cfg.fd_opt, data->cfg.pkt_len,
-					data->cfg.sample_size, data->cfg.rate);
-
-	if (data->cfg.codec == CFG_CODEC_SBC) {
-		ret = bluetooth_a2dp_init(data, sbc);
-		if (ret < 0)
-			return ret;
+static int audioservice_recv(int sk, bt_audio_msg_header_t * inmsg)
+{
+	int err;
+	DBG("trying to receive msg from audio service...");
+	if (recv(sk, inmsg, BT_AUDIO_IPC_PACKET_SIZE, 0) > 0) {
+		if (inmsg->msg_type <= BT_MSG_MAX) {
+			DBG("Received %s", bt_audio_strmsg[inmsg->msg_type]);
+			err = 0;
+		} else {
+			err = -EINVAL;
+			SNDERR("Bogus message type %d "
+					"received from audio service", 
+					inmsg->msg_type);
+		}
+	} else {
+		err = -errno;
+		SNDERR("Error receiving data from audio service: %s(%d)",
+					strerror(errno), errno);
 	}
+	return err;
+}
 
-	ret = bluetooth_recvmsg_fd(data);
-	if (ret < 0)
-		return ret;
-
-	if (data->stream.fd == -1) {
-		SNDERR("Error while configuring device: could not acquire audio socket");
-		return -EINVAL;
+static int audioservice_expect(int sk, bt_audio_msg_header_t * outmsg,
+				int expected_type)
+{
+	int err = audioservice_recv(sk, outmsg);
+	if (err == 0) {
+		if (outmsg->msg_type != expected_type) {
+			err = -EINVAL;
+			SNDERR("Bogus message %s received while "
+					"%s was expected", 
+					bt_audio_strmsg[outmsg->msg_type],
+					bt_audio_strmsg[expected_type]);
+		}
 	}
-
-	/* It is possible there is some outstanding
-	data in the pipe - we have to empty it */
-	while (recv(data->stream.fd, data->buffer, data->cfg.pkt_len,
-				MSG_DONTWAIT) > 0);
-
-	memset(data->buffer, 0, sizeof(data->buffer));
-
-	return 0;
+	return err;
 }
 
 static int bluetooth_init(struct bluetooth_data *data, snd_pcm_stream_t stream,
 				snd_config_t *conf)
 {
 	int sk, err;
-	struct sockaddr_un addr = {
-		AF_UNIX, IPC_SOCKET_NAME
-	};
-
-	if (!data)
-		return -EINVAL;
+	struct bluetooth_alsa_config *alsa_conf = &data->alsa_config;
+	char buf[BT_AUDIO_IPC_PACKET_SIZE];
+	struct bt_getcapabilities_req * getcaps_req = (void*) buf;
+	struct bt_getcapabilities_rsp * getcaps_rsp = (void*) buf;
 
 	memset(data, 0, sizeof(struct bluetooth_data));
 
+	err = bluetooth_parse_config(conf, alsa_conf);
+	if (err < 0)
+		return err;
+
 	data->server.fd = -1;
 	data->stream.fd = -1;
 
-	sk = socket(PF_LOCAL, SOCK_STREAM, 0);
-	if (sk < 0) {
-		err = errno;
-		SNDERR("Cannot open socket: %s (%d)", strerror(err), err);
-		return -err;
-	}
-
-	DBG("Connecting to address: %s", addr.sun_path + 1);
-	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		err = errno;
-		SNDERR("Connection fail", strerror(err), err);
-		close(sk);
-		return -err;
+	sk = bt_audio_service_open();
+	if(sk <= 0) {
+		err = -errno;	
+		goto failed;
 	}
 
 	data->server.fd = sk;
 	data->server.events = POLLIN;
 
 	data->pipefd[0] = -1;
 	data->pipefd[1] = -1;
 
-	if (pipe(data->pipefd) < 0)
-		return -errno;
-	if (fcntl(data->pipefd[0], F_SETFL, O_NONBLOCK) < 0)
-		return -errno;
-	if (fcntl(data->pipefd[1], F_SETFL, O_NONBLOCK) < 0)
-		return -errno;
+	if (pipe(data->pipefd) < 0) {
+		err = -errno;	
+		goto failed;
+	}
+	if (fcntl(data->pipefd[0], F_SETFL, O_NONBLOCK) < 0) {
+		err = -errno;	
+		goto failed;
+	}
+	if (fcntl(data->pipefd[1], F_SETFL, O_NONBLOCK) < 0) {
+		err = -errno;	
+		goto failed;
+	}
+
+	memset(getcaps_req, 0, BT_AUDIO_IPC_PACKET_SIZE);
+	getcaps_req->h.msg_type = BT_GETCAPABILITIES_REQ;
+	strncpy(getcaps_req->device, alsa_conf->device, 18);
+	if (alsa_conf->has_transport)
+		getcaps_req->transport = alsa_conf->transport;	
+	else
+		getcaps_req->transport = BT_CAPABILITIES_TRANSPORT_ANY;
+
+	getcaps_req->access_mode = (stream == SND_PCM_STREAM_PLAYBACK ? 
+			BT_CAPABILITIES_ACCESS_MODE_WRITE : 
+			BT_CAPABILITIES_ACCESS_MODE_READ);
+
+	err = audioservice_send(data->server.fd, &getcaps_req->h);
+	if (err < 0)
+		goto failed;
+
+	err = audioservice_expect(data->server.fd, &getcaps_rsp->h, BT_GETCAPABILITIES_RSP);
+	if (err < 0)
+		goto failed;
+
+	if (getcaps_rsp->posix_errno != 0) {
+		SNDERR("BT_GETCAPABILITIES failed : %s(%d)",
+					strerror(getcaps_rsp->posix_errno), 
+					getcaps_rsp->posix_errno);
+		return -getcaps_rsp->posix_errno;
+	}
+
+	data->transport = getcaps_rsp->transport;
+	data->link_mtu = getcaps_rsp->link_mtu;
+	if (getcaps_rsp->transport == BT_CAPABILITIES_TRANSPORT_A2DP)
+		data->a2dp.sbc_capabilities = getcaps_rsp->sbc_capabilities;
 
-	return bluetooth_cfg(data, stream, conf);
+	return 0;
+
+failed:
+	bt_audio_service_close(sk);
+	return err;
 }
 
 SND_PCM_PLUGIN_DEFINE_FUNC(bluetooth)
 {
 	struct bluetooth_data *data;
 	int err;
@@ -1288,26 +1317,26 @@
 
 	data->io.version = SND_PCM_IOPLUG_VERSION;
 	data->io.name = "Bluetooth Audio Device";
 	data->io.mmap_rw = 0; /* No direct mmap communication */
 	data->io.private_data = data;
 
-	if (data->cfg.codec == CFG_CODEC_SBC)
+	if (data->transport == BT_CAPABILITIES_TRANSPORT_A2DP)
 		data->io.callback = stream == SND_PCM_STREAM_PLAYBACK ?
 			&bluetooth_a2dp_playback :
 			&bluetooth_a2dp_capture;
 	else
 		data->io.callback = stream == SND_PCM_STREAM_PLAYBACK ?
 			&bluetooth_hsp_playback :
 			&bluetooth_hsp_capture;
 
 	err = snd_pcm_ioplug_create(&data->io, name, stream, mode);
 	if (err < 0)
 		goto error;
 
-	if (data->cfg.codec == CFG_CODEC_SBC)
+	if (data->transport == BT_CAPABILITIES_TRANSPORT_A2DP)
 		err = bluetooth_a2dp_hw_constraint(&data->io);
 	else
 		err = bluetooth_hsp_hw_constraint(&data->io);
 
 	if (err < 0) {
 		snd_pcm_ioplug_delete(&data->io);
Index: unix.c
===================================================================
--- unix.c	(.../tags/20071019_1300/audio)	(révision 144)
+++ unix.c	(.../branches/20071019_1300/audio)	(révision 144)
@@ -37,13 +37,13 @@
 #include <bluetooth/sdp.h>
 #include <dbus/dbus.h>
 #include <glib.h>
 
 #include "logging.h"
 #include "dbus.h"
-#include "ipc.h"
+#include "btaudioservice.h"
 #include "device.h"
 #include "manager.h"
 #include "avdtp.h"
 #include "a2dp.h"
 #include "headset.h"
 #include "sink.h"
@@ -75,22 +75,28 @@
 	char *interface;
 	union {
 		struct a2dp_data a2dp;
 		struct headset_data hs;
 	} d;
 	int sock;
-	int fd_opt;
+	int access_mode;
+	int data_fd; /* To be deleted once two phase configuration is fully implemented */
 	unsigned int req_id;
 	unsigned int cb_id;
 	gboolean (*cancel_stream) (struct device *dev, unsigned int id);
 };
 
 static GSList *clients = NULL;
 
 static int unix_sock = -1;
 
+static void unix_ipc_sendmsg(struct unix_client *client, 
+					const bt_audio_msg_header_t * msg);
+
+static void send_getcapabilities_rsp_error(struct unix_client *client, int err);
+
 static void client_free(struct unix_client *client)
 {
 	struct a2dp_data *a2dp;
 
 	switch (client->type) {
 	case TYPE_SINK:
@@ -189,126 +195,77 @@
 		break;
 	default:
 		break;
 	}
 }
 
-static int unix_send_cfg(int sock, struct ipc_data_cfg *cfg, int fd)
-{
-	char buf[IPC_MTU];
-	struct ipc_packet *pkt = (void *) buf;
-	int len, codec_len;
-
-	memset(buf, 0, sizeof(buf));
-
-	pkt->type = PKT_TYPE_CFG_RSP;
-
-	if (!cfg) {
-		pkt->error = EINVAL;
-		len = send(sock, pkt, sizeof(struct ipc_packet), 0);
-		if (len < 0)
-			error("send: %s (%d)", strerror(errno), errno);
-		return len;
-	}
-
-	debug("fd=%d, fd_opt=%u, pkt_len=%u, sample_size=%u, rate=%u",
-						fd, cfg->fd_opt, cfg->pkt_len,
-						cfg->sample_size, cfg->rate);
-
-	if (cfg->codec == CFG_CODEC_SBC)
-		codec_len = sizeof(struct ipc_codec_sbc);
-	else
-		codec_len = 0;
-
-	pkt->error = PKT_ERROR_NONE;
-	pkt->length = sizeof(struct ipc_data_cfg) + codec_len;
-	memcpy(pkt->data, cfg, pkt->length);
-
-	len = sizeof(struct ipc_packet) + pkt->length;
-	len = send(sock, pkt, len, 0);
-	if (len < 0)
-		error("Error %s(%d)", strerror(errno), errno);
-
-	debug("%d bytes sent", len);
-
-	if (fd != -1) {
-		len = unix_sendmsg_fd(sock, fd);
-		if (len < 0)
-			error("Error %s(%d)", strerror(errno), errno);
-		debug("%d bytes sent", len);
-	}
-
-	return 0;
-}
-
 static void headset_setup_complete(struct device *dev, void *user_data)
 {
 	struct unix_client *client = user_data;
-	struct ipc_data_cfg cfg;
+	char buf[BT_AUDIO_IPC_PACKET_SIZE];
+	struct bt_getcapabilities_rsp *rsp = (void *) buf;	
 	struct headset_data *hs = &client->d.hs;
-	int fd;
 
 	client->req_id = 0;
 
 	if (!dev) {
-		unix_send_cfg(client->sock, NULL, -1);
+		send_getcapabilities_rsp_error(client, EIO);
 		client->dev = NULL;
 		return;
 	}
 
-	switch (client->fd_opt) {
-	case CFG_FD_OPT_READ:
+	switch (client->access_mode) {
+	case BT_CAPABILITIES_ACCESS_MODE_READ:
 		hs->lock = HEADSET_LOCK_READ;
 		break;
-	case CFG_FD_OPT_WRITE:
+	case BT_CAPABILITIES_ACCESS_MODE_WRITE:
 		hs->lock = HEADSET_LOCK_WRITE;
 		break;
-	case CFG_FD_OPT_READWRITE:
+	case BT_CAPABILITIES_ACCESS_MODE_READWRITE:
 		hs->lock = HEADSET_LOCK_READ | HEADSET_LOCK_WRITE;
 		break;
 	default:
 		hs->lock = 0;
 		break;
 	}
 
 	if (!headset_lock(dev, hs->lock)) {
 		error("Unable to lock headset");
-		unix_send_cfg(client->sock, NULL, -1);
+		send_getcapabilities_rsp_error(client, EIO);
 		client->dev = NULL;
 		return;
 	}
 
-	memset(&cfg, 0, sizeof(cfg));
-
-	cfg.fd_opt = client->fd_opt;
-	cfg.codec = CFG_CODEC_SCO;
-	cfg.mode = CFG_MODE_MONO;
-	cfg.pkt_len = 48;
-	cfg.sample_size = 2;
-	cfg.rate = 8000;
+	memset(buf, 0, sizeof(buf));
 
-	fd = headset_get_sco_fd(dev);
+	rsp->h.msg_type = BT_GETCAPABILITIES_RSP;
+	rsp->transport  = BT_CAPABILITIES_TRANSPORT_SCO;
+	rsp->access_mode = client->access_mode;
+	rsp->link_mtu = 48;
+	rsp->sampling_rate = 8000;
+	
+	client->data_fd = headset_get_sco_fd(dev);
 
-	unix_send_cfg(client->sock, &cfg, fd);
+	unix_ipc_sendmsg(client, &rsp->h);
 }
 
 static void a2dp_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 					struct avdtp_stream *stream,
 					void *user_data, struct avdtp_error *err)
 {
 	struct unix_client *client = user_data;
-	char buf[sizeof(struct ipc_data_cfg) + sizeof(struct ipc_codec_sbc)];
-	struct ipc_data_cfg *cfg = (void *) buf;
+	char buf[BT_AUDIO_IPC_PACKET_SIZE];
+	struct bt_getcapabilities_rsp *rsp = (void *) buf;	
 	struct avdtp_service_capability *cap;
 	struct avdtp_media_codec_capability *codec_cap;
 	struct sbc_codec_cap *sbc_cap;
-	struct ipc_codec_sbc *sbc = (void *) cfg->data;
 	struct a2dp_data *a2dp = &client->d.a2dp;
-	int fd;
 	GSList *caps;
 
+	memset(buf, 0, sizeof(buf));
+
 	client->req_id = 0;
 
 	if (!stream)
 		goto failed;
 
 	if (!a2dp_sep_lock(sep, session)) {
@@ -316,13 +273,13 @@
 		goto failed;
 	}
 
 	a2dp->sep = sep;
 	a2dp->stream = stream;
 
-	if (!avdtp_stream_get_transport(stream, &fd, &cfg->pkt_len, &caps)) {
+	if (!avdtp_stream_get_transport(stream, &client->data_fd, &rsp->link_mtu, &caps)) {
 		error("Unable to get stream transport");
 		goto failed;
 	}
 
 	for (codec_cap = NULL; caps; caps = g_slist_next(caps)) {
 		cap = caps->data;
@@ -335,83 +292,45 @@
 	if (codec_cap == NULL ||
 			codec_cap->media_codec_type != A2DP_CODEC_SBC) {
 		error("Unable to find matching codec capability");
 		goto failed;
 	}
 
-	cfg->fd_opt = CFG_FD_OPT_WRITE;
+	rsp->h.msg_type = BT_GETCAPABILITIES_RSP;
+	rsp->transport = BT_CAPABILITIES_TRANSPORT_A2DP;
+	client->access_mode = BT_CAPABILITIES_ACCESS_MODE_WRITE;
+	rsp->access_mode = client->access_mode;
+	/* rsp->link_mtu = already set (see above) */
 
 	sbc_cap = (void *) codec_cap;
-	cfg->sample_size = 2;
 
-	switch (sbc_cap->channel_mode) {
-	case A2DP_CHANNEL_MODE_MONO:
-		cfg->mode = CFG_MODE_MONO;
-		break;
-	case A2DP_CHANNEL_MODE_DUAL_CHANNEL:
-		cfg->mode = CFG_MODE_DUAL_CHANNEL;
-		break;
-	case A2DP_CHANNEL_MODE_STEREO:
-		cfg->mode = CFG_MODE_STEREO;
-		break;
-	case A2DP_CHANNEL_MODE_JOINT_STEREO:
-		cfg->mode = CFG_MODE_JOINT_STEREO;
-		break;
-	}
+	/* assignations below are ok as soon as newipc.h and a2dp.h are kept in sync */
+        /* However it is not possible to cast a struct to another due to endianess issues */
+	rsp->sbc_capabilities.channel_mode = sbc_cap->channel_mode;
+	rsp->sbc_capabilities.frequency = sbc_cap->frequency;
+	rsp->sbc_capabilities.allocation_method = sbc_cap->allocation_method;
+	rsp->sbc_capabilities.subbands = sbc_cap->subbands;
+	rsp->sbc_capabilities.block_length = sbc_cap->block_length;
+	/* FIXME */
+	rsp->sbc_capabilities.min_bitpool = sbc_cap->max_bitpool;
+	rsp->sbc_capabilities.max_bitpool = sbc_cap->max_bitpool;
 
-	switch (sbc_cap->frequency) {
-	case A2DP_SAMPLING_FREQ_16000:
-		cfg->rate = 16000;
-		break;
-	case A2DP_SAMPLING_FREQ_32000:
-		cfg->rate = 32000;
-		break;
-	case A2DP_SAMPLING_FREQ_44100:
-		cfg->rate = 44100;
-		break;
-	case A2DP_SAMPLING_FREQ_48000:
-		cfg->rate = 48000;
-		break;
-	}
-
-	cfg->codec = CFG_CODEC_SBC;
-	sbc->allocation = sbc_cap->allocation_method == A2DP_ALLOCATION_SNR ?
-								0x01 : 0x00;
-	sbc->subbands = sbc_cap->subbands == A2DP_SUBBANDS_4 ? 4 : 8;
-
-	switch (sbc_cap->block_length) {
-	case A2DP_BLOCK_LENGTH_4:
-		sbc->blocks = 4;
-		break;
-	case A2DP_BLOCK_LENGTH_8:
-		sbc->blocks = 8;
-		break;
-	case A2DP_BLOCK_LENGTH_12:
-		sbc->blocks = 12;
-		break;
-	case A2DP_BLOCK_LENGTH_16:
-		sbc->blocks = 16;
-		break;
-	}
-
-	sbc->bitpool = sbc_cap->max_bitpool;
-
-	unix_send_cfg(client->sock, cfg, fd);
+	unix_ipc_sendmsg(client, &rsp->h);
 
 	client->cb_id = avdtp_stream_add_cb(session, stream,
 						stream_state_changed, client);
 
 	return;
 
 failed:
 	error("stream setup failed");
 	if (a2dp->sep) {
 		a2dp_sep_unlock(a2dp->sep, a2dp->session);
 		a2dp->sep = NULL;
 	}
-	unix_send_cfg(client->sock, NULL, -1);
+	send_getcapabilities_rsp_error(client, EIO);
 
 	avdtp_unref(a2dp->session);
 
 	a2dp->session = NULL;
 	a2dp->stream = NULL;
 }
@@ -462,149 +381,73 @@
 	client->req_id = id;
 	client->dev = dev;
 
 	return;
 
 failed:
-	unix_send_cfg(client->sock, NULL, -1);
+	send_getcapabilities_rsp_error(client, EIO);
 }
 
 static void create_cb(struct device *dev, void *user_data)
 {
 	struct unix_client *client = user_data;
 
 	if (!dev)
-		unix_send_cfg(client->sock, NULL, -1);
+		send_getcapabilities_rsp_error(client, EIO);
 	else
 		create_stream(dev, client);
 }
 
-static int cfg_to_caps(struct ipc_data_cfg *cfg, struct sbc_codec_cap *sbc_cap)
+static void unix_ipc_sendmsg(struct unix_client *client, 
+					const bt_audio_msg_header_t * msg)
 {
-	struct ipc_codec_sbc *sbc = (void *) cfg->data;
-
-	memset(sbc_cap, 0, sizeof(struct sbc_codec_cap));
-
-	sbc_cap->cap.media_type = AVDTP_MEDIA_TYPE_AUDIO;
-	sbc_cap->cap.media_codec_type = A2DP_CODEC_SBC;
-
-	switch (cfg->rate) {
-	case 48000:
-		sbc_cap->frequency = A2DP_SAMPLING_FREQ_48000;
-		break;
-	case 44100:
-		sbc_cap->frequency = A2DP_SAMPLING_FREQ_44100;
-		break;
-	case 32000:
-		sbc_cap->frequency = A2DP_SAMPLING_FREQ_32000;
-		break;
-	case 16000:
-		sbc_cap->frequency = A2DP_SAMPLING_FREQ_16000;
-		break;
-	default:
-		sbc_cap->frequency = A2DP_SAMPLING_FREQ_44100;
-		break;
-	}
-
-	switch (cfg->mode) {
-	case CFG_MODE_MONO:
-		sbc_cap->channel_mode = A2DP_CHANNEL_MODE_MONO;
-		break;
-	case CFG_MODE_DUAL_CHANNEL:
-		sbc_cap->channel_mode = A2DP_CHANNEL_MODE_DUAL_CHANNEL;
-		break;
-	case CFG_MODE_STEREO:
-		sbc_cap->channel_mode = A2DP_CHANNEL_MODE_STEREO;
-		break;
-	case CFG_MODE_JOINT_STEREO:
-		sbc_cap->channel_mode = A2DP_CHANNEL_MODE_JOINT_STEREO;
-		break;
-	default:
-		sbc_cap->channel_mode = A2DP_CHANNEL_MODE_JOINT_STEREO;
-		break;
-	}
-
-	switch (sbc->allocation) {
-	case CFG_ALLOCATION_LOUDNESS:
-		sbc_cap->allocation_method = A2DP_ALLOCATION_LOUDNESS;
-		break;
-	case CFG_ALLOCATION_SNR:
-		sbc_cap->allocation_method = A2DP_ALLOCATION_LOUDNESS;
-		break;
-	default:
-		sbc_cap->allocation_method = A2DP_ALLOCATION_LOUDNESS;
-		break;
-	}
-
-	switch (sbc->subbands) {
-	case 8:
-		sbc_cap->subbands = A2DP_SUBBANDS_8;
-		break;
-	case 4:
-		sbc_cap->subbands = A2DP_SUBBANDS_4;
-		break;
-	default:
-		sbc_cap->subbands = A2DP_SUBBANDS_8;
-		break;
-	}
-
-	switch (sbc->blocks) {
-	case 16:
-		sbc_cap->block_length = A2DP_BLOCK_LENGTH_16;
-		break;
-	case 12:
-		sbc_cap->block_length = A2DP_BLOCK_LENGTH_12;
-		break;
-	case 8:
-		sbc_cap->block_length = A2DP_BLOCK_LENGTH_8;
-		break;
-	case 4:
-		sbc_cap->block_length = A2DP_BLOCK_LENGTH_4;
-		break;
-	default:
-		sbc_cap->block_length = A2DP_BLOCK_LENGTH_16;
-		break;
+	info("Audio API: sending %s", bt_audio_strmsg[msg->msg_type]);
+	if (send(client->sock, msg, BT_AUDIO_IPC_PACKET_SIZE, 0) < 0) {
+		error("Error %s(%d)", strerror(errno), errno);
 	}
+} 
 
-	if (sbc->bitpool != 0) {
-		if (sbc->bitpool > 250)
-			return -EINVAL;
-
-		sbc_cap->min_bitpool = sbc->bitpool;
-		sbc_cap->max_bitpool = sbc->bitpool;
-	}
+static void send_getcapabilities_rsp_error(struct unix_client *client, int err)
+{
+	char buf[BT_AUDIO_IPC_PACKET_SIZE];
+	struct bt_getcapabilities_rsp *rsp = (void *) buf;
+	
+	memset(buf, 0, sizeof(buf));
+	rsp->h.msg_type = BT_GETCAPABILITIES_RSP;
+	rsp->posix_errno = err;
 
-	return 0;
+	unix_ipc_sendmsg(client, &rsp->h);
 }
+					
 
-static void cfg_event(struct unix_client *client, struct ipc_packet *pkt, int len)
+static void handle_getcapabilities_req(struct unix_client *client,
+					struct bt_getcapabilities_req * req)
 {
 	struct device *dev;
 	bdaddr_t bdaddr;
-	struct ipc_data_cfg *cfg = (void *) pkt->data;
-	struct sbc_codec_cap sbc_cap;
 
-	str2ba(pkt->device, &bdaddr);
+	str2ba(req->device, &bdaddr);
 
-	client->fd_opt = cfg->fd_opt;
+	if (!req->access_mode) {
+		send_getcapabilities_rsp_error(client, EINVAL);
+		return;
+	}
+
+	client->access_mode = req->access_mode;
 
 	if (client->interface) {
 		g_free(client->interface);
 		client->interface = NULL;
 	}
 
-	if (pkt->role == PKT_ROLE_VOICE)
+	if (req->transport == BT_CAPABILITIES_TRANSPORT_SCO)
 		client->interface = g_strdup(AUDIO_HEADSET_INTERFACE);
-	else if (pkt->role == PKT_ROLE_HIFI)
+	else if (req->transport == BT_CAPABILITIES_TRANSPORT_A2DP)
 		client->interface = g_strdup(AUDIO_SINK_INTERFACE);
 
-	if (cfg_to_caps(cfg, &sbc_cap) < 0)
-		goto failed;
-
-	client->media_codec = avdtp_service_cap_new(AVDTP_MEDIA_CODEC,
-						&sbc_cap, sizeof(sbc_cap));
+	client->media_codec = 0;
 
 	if (!manager_find_device(&bdaddr, NULL, FALSE)) {
 		if (!bacmp(&bdaddr, BDADDR_ANY))
 			goto failed;
 		if (!manager_create_device(&bdaddr, create_cb, client))
 			goto failed;
@@ -620,63 +463,86 @@
 
 	create_stream(dev, client);
 
 	return;
 
 failed:
-	unix_send_cfg(client->sock, NULL, -1);
+	send_getcapabilities_rsp_error(client, EIO);
 }
 
-static void ctl_event(struct unix_client *client,
-					struct ipc_packet *pkt, int len)
+static void handle_setconfiguration_req(struct unix_client *client,
+					struct bt_setconfiguration_req * req)
 {
+	/* FIXME: for now we just blindly assume that we receive is the
+	   only valid configuration sent.*/
+	char buf[BT_AUDIO_IPC_PACKET_SIZE];
+	struct bt_setconfiguration_rsp *rsp = (void *) buf;
+	
+	memset(buf, 0, sizeof(buf));
+	rsp->h.msg_type = BT_SETCONFIGURATION_RSP;
+	rsp->posix_errno = 0;
+
+	unix_ipc_sendmsg(client, &rsp->h);
 }
 
-static int reply_state(int sock, struct ipc_packet *pkt)
+static void handle_streamstart_req(struct unix_client *client,
+					struct bt_streamstart_req * req)
 {
-	struct ipc_data_state *state = (struct ipc_data_state *) pkt->data;
-	int len;
+	/* FIXME : to be really implemented */
+	char buf[BT_AUDIO_IPC_PACKET_SIZE];
+	struct bt_streamstart_rsp *rsp = (void *) buf;
+	struct bt_datafd_ind *ind = (void *) buf;
+	
+	memset(buf, 0, sizeof(buf));
+	rsp->h.msg_type = BT_STREAMSTART_RSP;
+	rsp->posix_errno = 0;
+	unix_ipc_sendmsg(client, &rsp->h);
+	
+	memset(buf, 0, sizeof(buf));
+	ind->h.msg_type = BT_STREAMFD_IND;
+	unix_ipc_sendmsg(client, &ind->h);
 
-	info("status=%u", state->state);
+	if (unix_sendmsg_fd(client->sock, client->data_fd) < 0)
+		error("unix_sendmsg_fd: %s(%d)", strerror(errno), errno);
 
-	pkt->type = PKT_TYPE_STATE_RSP;
-	pkt->length = sizeof(struct ipc_data_state);
-	pkt->error = PKT_ERROR_NONE;
-
-	len = sizeof(struct ipc_packet) + sizeof(struct ipc_data_state);
-	len = send(sock, pkt, len, 0);
-	if (len < 0)
-		error("Error %s(%d)", strerror(errno), errno);
+}
 
-	debug("%d bytes sent", len);
+static void handle_streamstop_req(struct unix_client *client,
+					struct bt_streamstop_req * req)
+{
+	/* FIXME : to be implemented */
+	char buf[BT_AUDIO_IPC_PACKET_SIZE];
+	struct bt_streamstop_rsp *rsp = (void *) buf;
+	
+	memset(buf, 0, sizeof(buf));
+	rsp->h.msg_type = BT_STREAMSTOP_RSP;
+	rsp->posix_errno = 0;
 
-	return 0;
+	unix_ipc_sendmsg(client, &rsp->h);
 }
 
-static void state_event(struct unix_client *client,
-					struct ipc_packet *pkt, int len)
+static void handle_control_req(struct unix_client *client,
+					struct bt_control_req * req)
 {
-#if 0
-	struct ipc_data_state *state = (struct ipc_data_state *) pkt->data;
-	struct device *dev = client->dev;
-
-	if (len > sizeof(struct ipc_packet))
-		device_set_state(dev, state->state);
-	else
-		state->state = device_get_state(dev);
-#endif
+	/* FIXME: really implement that */
+	char buf[BT_AUDIO_IPC_PACKET_SIZE];
+	struct bt_setconfiguration_rsp *rsp = (void *) buf;
+	
+	memset(buf, 0, sizeof(buf));
+	rsp->h.msg_type = BT_CONTROL_RSP;
+	rsp->posix_errno = 0;
 
-	reply_state(client->sock, pkt);
+	unix_ipc_sendmsg(client, &rsp->h);
 }
 
 static gboolean client_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
-	char buf[IPC_MTU];
-	struct ipc_packet *pkt = (void *) buf;
+	char buf[BT_AUDIO_IPC_PACKET_SIZE];
+	bt_audio_msg_header_t *msghdr = (void *) buf;
 	struct unix_client *client = data;
-	int len, len_check;
+	int len;
 	struct a2dp_data *a2dp = &client->d.a2dp;
 	struct headset_data *hs = &client->d.hs;
 
 	if (cond & G_IO_NVAL)
 		return FALSE;
 
@@ -702,37 +568,45 @@
 			client->cancel_stream(client->dev, client->req_id);
 		goto failed;
 	}
 
 	memset(buf, 0, sizeof(buf));
 
-	len = recv(client->sock, buf, sizeof(buf), 0);
+	len = recv(client->sock, buf, sizeof(buf), MSG_WAITALL);
 	if (len < 0) {
 		error("recv: %s (%d)", strerror(errno), errno);
 		goto failed;
 	}
 
-	len_check = pkt->length + sizeof(struct ipc_packet);
-	if (len != len_check) {
-		error("Packet lenght doesn't match");
-		goto failed;
+	if (msghdr->msg_type <= BT_MSG_MAX) {
+		info("Audio API: received %s", bt_audio_strmsg[msghdr->msg_type]);
 	}
 
-	switch (pkt->type) {
-	case PKT_TYPE_CFG_REQ:
-		info("Package PKT_TYPE_CFG_REQ:%u", pkt->role);
-		cfg_event(client, pkt, len);
-		break;
-	case PKT_TYPE_STATE_REQ:
-		info("Package PKT_TYPE_STATE_REQ");
-		state_event(client, pkt, len);
-		break;
-	case PKT_TYPE_CTL_REQ:
-		info("Package PKT_TYPE_CTL_REQ");
-		ctl_event(client, pkt, len);
+	switch (msghdr->msg_type) {
+	case BT_GETCAPABILITIES_REQ:
+		handle_getcapabilities_req(client,
+				(struct bt_getcapabilities_req *) msghdr);		
+		break;
+	case BT_SETCONFIGURATION_REQ:
+		handle_setconfiguration_req(client,
+				(struct bt_setconfiguration_req *) msghdr);		
+		break;
+	case BT_STREAMSTART_REQ:
+		handle_streamstart_req(client,
+				(struct bt_streamstart_req *) msghdr);		
+		break;
+	case BT_STREAMSTOP_REQ:
+		handle_streamstop_req(client,
+				(struct bt_streamstop_req *) msghdr);		
+		break;
+	case BT_CONTROL_REQ:
+		handle_control_req(client,
+				(struct bt_control_req *) msghdr);		
 		break;
+	default:
+		error("Audio API: received unexpected packet type %d", msghdr->msg_type);
 	}
 
 	return TRUE;
 
 failed:
 	clients = g_slist_remove(clients, client);
@@ -782,13 +656,13 @@
 }
 
 int unix_init(void)
 {
 	GIOChannel *io;
 	struct sockaddr_un addr = {
-		AF_UNIX, IPC_SOCKET_NAME
+		AF_UNIX, BT_IPC_SOCKET_NAME
 	};
 
 	int sk, err;
 
 	sk = socket(PF_LOCAL, SOCK_STREAM, 0);
 	if (sk < 0) {
Index: ctl_bluetooth.c
===================================================================
--- ctl_bluetooth.c	(.../tags/20071019_1300/audio)	(révision 144)
+++ ctl_bluetooth.c	(.../branches/20071019_1300/audio)	(révision 144)
@@ -30,13 +30,13 @@
 
 #include <alsa/asoundlib.h>
 #include <alsa/control_external.h>
 
 #include <bluetooth/bluetooth.h>
 
-#include "ipc.h"
+#include "btaudioservice.h"
 
 #ifdef ENABLE_DEBUG
 #define DBG(fmt, arg...)  printf("DEBUG: %s: " fmt "\n" , __FUNCTION__ , ## arg)
 #else
 #define DBG(fmt, arg...)
 #endif
@@ -62,13 +62,13 @@
 static void bluetooth_exit(struct bluetooth_data *data)
 {
 	if (data == NULL)
 		return;
 
 	if (data->sock >= 0)
-		close(data->sock);
+		bt_audio_service_close(data->sock);
 
 	free(data);
 }
 
 static void bluetooth_close(snd_ctl_ext_t *ext)
 {
@@ -138,140 +138,135 @@
 	*imax  = BLUETOOTH_MAXVOL;
 
 	return 0;
 }
 
 static int bluetooth_send_ctl(struct bluetooth_data *data,
-				struct ipc_packet *pkt, int len)
+			uint8_t mode, uint8_t key, struct bt_control_rsp *ctl_rsp)
 {
 	int ret;
+	struct bt_control_req * ctl_req = (void *) ctl_rsp;
 
-	ret = send(data->sock, pkt, len, MSG_NOSIGNAL);
+	memset(ctl_req, 0, BT_AUDIO_IPC_PACKET_SIZE);
+	ctl_req->h.msg_type = BT_CONTROL_REQ;
+	ctl_req->mode = mode;
+	ctl_req->key = key;
+
+	ret = send(data->sock, ctl_req, BT_AUDIO_IPC_PACKET_SIZE, MSG_NOSIGNAL);
 	if (ret <= 0) {
 		SYSERR("Unable to request new volume value to server");
 		return  -errno;
 	}
 
-	ret = recv(data->sock, pkt, len, 0);
+	ret = recv(data->sock, ctl_rsp, BT_AUDIO_IPC_PACKET_SIZE, 0);
 	if (ret <= 0) {
-		SYSERR("Unable to receive new volume value from server");
+		SNDERR("Unable to receive new volume value from server");
 		return  -errno;
 	}
 
-	if(pkt->type != PKT_TYPE_CTL_RSP) {
-		SNDERR("Unexpected packet type %d received", pkt->type);
+	if (ctl_rsp->h.msg_type > BT_MSG_MAX) {
+		SNDERR("Bogus message type %d "
+				"received from audio service", 
+				ctl_rsp->h.msg_type);
 		return -EINVAL;
 	}
 
-	if(pkt->length != sizeof(struct ipc_data_ctl)) {
-		SNDERR("Unexpected packet length %d received", pkt->length);
+	if (ctl_rsp->h.msg_type != BT_CONTROL_RSP) {
+		SNDERR("Unexpected message %s received", 
+				bt_audio_strmsg[ctl_rsp->h.msg_type]);
 		return -EINVAL;
 	}
 
+	if (ctl_rsp->posix_errno != 0) {
+		SNDERR("BT_CONTROL failed : %s (%d)",
+					strerror(ctl_rsp->posix_errno), 
+					ctl_rsp->posix_errno);
+		return -ctl_rsp->posix_errno;
+	}
+
 	return 0;
 }
 
 static int bluetooth_read_integer(snd_ctl_ext_t *ext, snd_ctl_ext_key_t key,
 								long *value)
 {
 	struct bluetooth_data *data = ext->private_data;
-	struct ipc_packet *pkt;
-	struct ipc_data_ctl *ctl;
-	int len, ret;
+	int ret;
+	char buf[BT_AUDIO_IPC_PACKET_SIZE];
+	struct bt_control_rsp *rsp = (void *) buf;
 
 	DBG("ext %p key %ld", ext, key);
 
-	len = sizeof(struct ipc_packet) + sizeof(struct ipc_data_ctl);
-	pkt = malloc(len);
-	memset(pkt, 0, len);
+	memset(buf, 0, sizeof(buf));
 	*value = 0;
 
-	pkt->type = PKT_TYPE_CTL_REQ;
-	pkt->length = sizeof(struct ipc_data_ctl);
-	ctl = (struct ipc_data_ctl *) pkt->data;
-	ctl->mode = key;
-
-	if ((ret = bluetooth_send_ctl(data, pkt, len)) < 0)
+	if ((ret = bluetooth_send_ctl(data, key, 0, rsp)) < 0)
 		goto done;
 
-	*value = ctl->key;
+	*value = rsp->key;
 done:
-	free(pkt);
 	return ret;
 }
 
 static int bluetooth_write_integer(snd_ctl_ext_t *ext, snd_ctl_ext_key_t key,
 								long *value)
 {
 	struct bluetooth_data *data = ext->private_data;
-	struct ipc_packet *pkt;
-	struct ipc_data_ctl *ctl;
+	char buf[BT_AUDIO_IPC_PACKET_SIZE];
+	struct bt_control_rsp *rsp = (void *) buf;
 	long current;
-	int len, ret;
+	int ret, keyvalue;
 
 	DBG("ext %p key %ld", ext, key);
 
 	if ((ret = bluetooth_read_integer(ext, key, &current)) < 0)
 		return ret;
 
 	if (*value == current)
 		return 0;
 
-	len = sizeof(struct ipc_packet) + sizeof(struct ipc_data_ctl);
-	pkt = malloc(len);
-	memset(pkt, 0, len);
-
-	pkt->length = sizeof(struct ipc_data_ctl);
-	ctl = (struct ipc_data_ctl *) pkt->data;
-	ctl->mode = key;
-
 	while (*value != current) {
-		pkt->type = PKT_TYPE_CTL_REQ;
-		ctl->key = (*value > current) ? CTL_KEY_VOL_UP : CTL_KEY_VOL_DOWN;
+		keyvalue = (*value > current) ? BT_CONTROL_KEY_VOL_UP : BT_CONTROL_KEY_VOL_DOWN;
 
-		if ((ret = bluetooth_send_ctl(data, pkt, len)) < 0)
+		if ((ret = bluetooth_send_ctl(data, key, keyvalue, rsp)) < 0)
 			break;
 
-		current = ctl->key;
+		current = keyvalue;
 	}
 
-	free(pkt);
 	return ret;
 }
 
 static int bluetooth_read_event(snd_ctl_ext_t *ext, snd_ctl_elem_id_t *id,
 						unsigned int *event_mask)
 {
 	struct bluetooth_data *data = ext->private_data;
-	struct ipc_packet *pkt;
-	struct ipc_data_ctl *ctl;
-	int len, ret;
+	char buf[BT_AUDIO_IPC_PACKET_SIZE];
+	struct bt_control_ind *ind = (void *) buf;
+	int ret;
 
 	DBG("ext %p id %p", ext, id);
 
-	len = sizeof(struct ipc_packet) + sizeof(struct ipc_data_ctl);
-	pkt = malloc(len);
-	memset(pkt, 0, len);
-
-	ret = recv(data->sock, pkt, len, MSG_DONTWAIT);
-	if (ret <= 0)
-		return  -errno;
+	memset(buf, 0, sizeof(buf));
 
-	if(pkt->type != PKT_TYPE_CTL_NTFY) {
-		SNDERR("Unexpected packet type %d received!", pkt->type);
+	ret = recv(data->sock, ind, BT_AUDIO_IPC_PACKET_SIZE, MSG_DONTWAIT);
+	if (ind->h.msg_type > BT_MSG_MAX) {
+		SNDERR("Bogus message type %d "
+				"received from audio service", 
+				ind->h.msg_type);
 		return -EAGAIN;
 	}
 
-	if(pkt->length != sizeof(struct ipc_data_ctl)) {
-		SNDERR("Unexpected packet length %d received", pkt->length);
+	if (ind->h.msg_type != BT_CONTROL_IND) {
+		SNDERR("Unexpected message %s received", 
+				bt_audio_strmsg[ind->h.msg_type]);
 		return -EAGAIN;
 	}
 
-	ctl = (struct ipc_data_ctl *) pkt->data;
 	snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);
-	snd_ctl_elem_id_set_name(id, ctl->mode == BLUETOOTH_PLAYBACK ?
+	snd_ctl_elem_id_set_name(id, ind->mode == BLUETOOTH_PLAYBACK ?
 				vol_devices[BLUETOOTH_PLAYBACK] :
 				vol_devices[BLUETOOTH_CAPTURE]);
 	*event_mask = SND_CTL_EVENT_MASK_VALUE;
 
 	return 1;
 }
@@ -287,40 +282,25 @@
 	.write_integer		= bluetooth_write_integer,
 	.read_event		= bluetooth_read_event,
 };
 
 static int bluetooth_init(struct bluetooth_data *data)
 {
-	int sk, err, id;
-	struct sockaddr_un addr = {
-		AF_UNIX, IPC_SOCKET_NAME
-	};
+	int sk;
 
 	if (!data)
 		return -EINVAL;
 
 	memset(data, 0, sizeof(struct bluetooth_data));
 
 	data->sock = -1;
 
-	id = abs(getpid() * rand());
-
-	if ((sk = socket(PF_LOCAL, SOCK_STREAM, 0)) < 0) {
-		err = -errno;
-		SNDERR("Can't open socket");
+	if ((sk = bt_audio_service_open()) < 0) {
 		return -errno;
 	}
 
-	DBG("Connecting to address: %s", addr.sun_path + 1);
-	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		err = -errno;
-		SNDERR("Can't connect socket");
-		close(sk);
-		return err;
-	}
-
 	data->sock = sk;
 
 	return 0;
 }
 
 SND_CTL_PLUGIN_DEFINE_FUNC(bluetooth)
Index: btaudioservice.c
===================================================================
--- btaudioservice.c	(.../tags/20071019_1300/audio)	(révision 0)
+++ btaudioservice.c	(.../branches/20071019_1300/audio)	(révision 144)
@@ -0,0 +1,91 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2004-2007  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <btaudioservice.h>
+
+int bt_audio_service_open()
+{
+	int sk;
+	int err;
+	struct sockaddr_un addr = {
+		AF_UNIX, BT_IPC_SOCKET_NAME
+	};
+
+	sk = socket(PF_LOCAL, SOCK_STREAM, 0);
+	if (sk < 0) {
+		err = errno;
+		fprintf(stderr, "%s: Cannot open socket: %s (%d)\n", __FUNCTION__, strerror(err), err);
+		errno = err;
+		return -1;
+	}
+
+	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		err = errno;
+		fprintf(stderr, "%s: connect() failed: %s (%d)\n", __FUNCTION__, strerror(err), err);
+		close(sk);
+		errno = err;
+		return -1;
+	}
+	
+	return sk;
+}
+
+int bt_audio_service_close(int sk)
+{
+	return close(sk);
+}
+
+int bt_audio_service_get_data_fd(int sk)
+{
+	char cmsg_b[CMSG_SPACE(sizeof(int))], m;
+	int err, ret;
+	struct iovec iov = { &m, sizeof(m) };
+	struct msghdr msgh;
+	struct cmsghdr *cmsg;
+
+	memset(&msgh, 0, sizeof(msgh));
+	msgh.msg_iov = &iov;
+	msgh.msg_iovlen = 1;
+	msgh.msg_control = &cmsg_b;
+	msgh.msg_controllen = CMSG_LEN(sizeof(int));
+
+	ret = recvmsg(sk, &msgh, 0);
+	if (ret < 0) {
+		err = errno;
+		fprintf(stderr, "%s: Unable to receive fd: %s (%d)\n", __FUNCTION__, strerror(err), err);
+		errno = err;
+		return -1;
+	}
+
+	/* Receive auxiliary data in msgh */
+	for (cmsg = CMSG_FIRSTHDR(&msgh); cmsg != NULL;
+			cmsg = CMSG_NXTHDR(&msgh, cmsg)) {
+		if (cmsg->cmsg_level == SOL_SOCKET
+				&& cmsg->cmsg_type == SCM_RIGHTS) {
+			return (*(int *) CMSG_DATA(cmsg));
+		}
+	}
+
+	errno = EINVAL;
+	return -1;
+}
+
Index: btaudioservice.h
===================================================================
--- btaudioservice.h	(.../tags/20071019_1300/audio)	(révision 0)
+++ btaudioservice.h	(.../branches/20071019_1300/audio)	(révision 144)
@@ -0,0 +1,304 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2004-2007  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+/*
+  Message sequence chart of streaming sequence for A2DP transport
+  
+  Audio daemon                       User
+                             on snd_pcm_open
+                 <--BT_GETCAPABILITIES_REQ
+
+  BT_GETCAPABILITIES_RSP-->
+
+                        on snd_pcm_hw_params
+                <--BT_SETCONFIGURATION_REQ
+
+  BT_SETCONFIGURATION_RSP-->
+
+			on snd_pcm_prepare
+                <--BT_STREAMSTART_REQ
+
+  <Moves to streaming state>
+  BT_STREAMSTART_RSP-->
+
+  BT_STREAMFD_IND -->
+
+                          <  streams data >
+                             ..........
+
+               on snd_pcm_drop/snd_pcm_drain
+
+                <--BT_STREAMSTOP_REQ
+
+  <Moves to open state>
+  BT_STREAMSTOP_RSP-->
+    
+			on IPC close or appl crash 
+  <Moves to idle>
+			
+ */
+
+#ifndef BTAUDIOSERVICE_H
+#define BTAUDIOSERVICE_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <stdint.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <errno.h>
+
+#define BT_AUDIO_IPC_PACKET_SIZE   128
+#define BT_IPC_SOCKET_NAME "\0/org/bluez/audio"
+
+/* Generic message header definition */
+typedef struct {
+	uint8_t msg_type;
+} __attribute__ ((packed)) bt_audio_msg_header_t;
+
+/* Messages list */
+#define BT_GETCAPABILITIES_REQ		0
+#define BT_GETCAPABILITIES_RSP		1
+
+#define BT_SETCONFIGURATION_REQ		2
+#define BT_SETCONFIGURATION_RSP		3
+
+#define BT_STREAMSTART_REQ		4
+#define BT_STREAMSTART_RSP		5
+
+#define BT_STREAMSTOP_REQ		6
+#define BT_STREAMSTOP_RSP		7
+
+#define BT_STREAMSUSPEND_IND		8
+#define BT_STREAMRESUME_IND		9
+
+#define BT_CONTROL_REQ		       10
+#define BT_CONTROL_RSP		       11
+#define BT_CONTROL_IND		       12
+
+#define BT_STREAMFD_IND		       13
+
+/* This table contains the string representation for messages above */
+static const char * bt_audio_strmsg[] = {
+	"BT_GETCAPABILITIES_REQ",
+	"BT_GETCAPABILITIES_RSP",
+	"BT_SETCONFIGURATION_REQ",
+	"BT_SETCONFIGURATION_RSP",
+	"BT_STREAMSTART_REQ",
+	"BT_STREAMSTART_RSP",
+	"BT_STREAMSTOP_REQ",
+	"BT_STREAMSTOP_RSP",
+	"BT_STREAMSUSPEND_IND",
+	"BT_STREAMRESUME_IND",
+	"BT_CONTROL_REQ",
+	"BT_CONTROL_RSP",
+	"BT_CONTROL_IND",
+	"BT_STREAMFD_IND",
+};
+
+#define BT_MSG_MAX ((sizeof(bt_audio_strmsg) / sizeof(char*)) -1)
+
+/* BT_GETCAPABILITIES_REQ */
+
+#define BT_CAPABILITIES_TRANSPORT_A2DP	0
+#define BT_CAPABILITIES_TRANSPORT_SCO	1
+#define BT_CAPABILITIES_TRANSPORT_ANY	2
+
+#define BT_CAPABILITIES_ACCESS_MODE_READ	1
+#define BT_CAPABILITIES_ACCESS_MODE_WRITE	2
+#define BT_CAPABILITIES_ACCESS_MODE_READWRITE	3
+
+struct bt_getcapabilities_req {
+	bt_audio_msg_header_t h;
+	char device[18];      /* Address of the remote Device */
+ 	uint8_t transport;    /* Requested transport */
+	uint8_t access_mode;  /* Requested access mode */
+} __attribute__ ((packed));
+
+/* BT_GETCAPABILITIES_RSP */
+
+/**
+ * SBC Codec parameters as per A2DP profile 1.0 § 4.3
+ */
+
+#define BT_A2DP_SAMPLING_FREQ_16000		(1 << 3)
+#define BT_A2DP_SAMPLING_FREQ_32000		(1 << 2)
+#define BT_A2DP_SAMPLING_FREQ_44100		(1 << 1)
+#define BT_A2DP_SAMPLING_FREQ_48000		1
+
+#define BT_A2DP_CHANNEL_MODE_MONO		(1 << 3)
+#define BT_A2DP_CHANNEL_MODE_DUAL_CHANNEL	(1 << 2)
+#define BT_A2DP_CHANNEL_MODE_STEREO		(1 << 1)
+#define BT_A2DP_CHANNEL_MODE_JOINT_STEREO	1
+#define BT_A2DP_CHANNEL_MODE_MONO_AUTO		0
+
+#define BT_A2DP_BLOCK_LENGTH_4			(1 << 3)
+#define BT_A2DP_BLOCK_LENGTH_8			(1 << 2)
+#define BT_A2DP_BLOCK_LENGTH_12			(1 << 1)
+#define BT_A2DP_BLOCK_LENGTH_16			1
+
+#define BT_A2DP_SUBBANDS_4			(1 << 1)
+#define BT_A2DP_SUBBANDS_8			1
+
+#define BT_A2DP_ALLOCATION_SNR			(1 << 1)
+#define BT_A2DP_ALLOCATION_LOUDNESS		1
+#define BT_A2DP_ALLOCATION_AUTO			0
+
+typedef struct {
+	uint8_t channel_mode;
+	uint8_t frequency;
+	uint8_t allocation_method;
+	uint8_t subbands;
+	uint8_t block_length;
+	uint8_t min_bitpool;
+	uint8_t max_bitpool;
+} __attribute__ ((packed)) SBC_capabilities_t;
+
+/* To be defined */
+typedef struct {
+} __attribute__ ((packed)) MPEG_capabilities_t;
+
+struct bt_getcapabilities_rsp {
+	bt_audio_msg_header_t	h;
+	uint8_t			posix_errno;
+ 	uint8_t			transport;	    /* Granted transport */
+	uint8_t			access_mode; 	    /* Granted access mode */
+	uint16_t		link_mtu;           /* Max length that transport supports */
+	SBC_capabilities_t	sbc_capabilities;   /* A2DP only */
+	MPEG_capabilities_t	mpeg_capabilities;  /* A2DP only */
+	uint16_t		sampling_rate;	    /* SCO only */
+} __attribute__ ((packed));
+
+/* BT_SETCONFIGURATION_REQ */
+struct bt_setconfiguration_req {
+	bt_audio_msg_header_t	h;
+	SBC_capabilities_t 	sbc_capabilities;   /* A2DP only - only one of this field
+						   and next one must be filled */
+	MPEG_capabilities_t	mpeg_capabilities;  /* A2DP only */
+} __attribute__ ((packed));
+
+/* BT_SETCONFIGURATION_RSP */
+struct bt_setconfiguration_rsp {
+	bt_audio_msg_header_t 	h;
+	uint8_t 		posix_errno;
+} __attribute__ ((packed));
+
+/* BT_STREAMSTART_REQ */
+#define BT_STREAM_ACCESS_READ		0
+#define BT_STREAM_ACCESS_WRITE		1
+#define BT_STREAM_ACCESS_READWRITE	2
+struct bt_streamstart_req {
+	bt_audio_msg_header_t 	h;
+} __attribute__ ((packed));
+
+/* BT_STREAMSTART_RSP */
+struct bt_streamstart_rsp {
+	bt_audio_msg_header_t 	h;
+	uint8_t 		posix_errno;
+} __attribute__ ((packed));
+
+/* BT_STREAMFD_IND */
+/* This message is followed by one byte of data containing the stream data fd
+   as ancilliary data */
+struct bt_datafd_ind {
+	bt_audio_msg_header_t 	h;
+} __attribute__ ((packed));
+
+/* BT_STREAMSTOP_REQ */
+struct bt_streamstop_req {
+	bt_audio_msg_header_t 	h;
+} __attribute__ ((packed));
+
+/* BT_STREAMSTOP_RSP */
+struct bt_streamstop_rsp {
+	bt_audio_msg_header_t 	h;
+	uint8_t 		posix_errno;
+} __attribute__ ((packed));
+
+/* BT_STREAMSUSPEND_IND */
+struct bt_streamsuspend_ind {
+	bt_audio_msg_header_t 	h;
+} __attribute__ ((packed));
+
+/* BT_STREAMRESUME_IND */
+struct bt_streamresume_ind {
+	bt_audio_msg_header_t 	h;
+} __attribute__ ((packed));
+
+/* BT_CONTROL_REQ */
+
+#define BT_CONTROL_KEY_POWER			0x40
+#define BT_CONTROL_KEY_VOL_UP			0x41
+#define BT_CONTROL_KEY_VOL_DOWN			0x42
+#define BT_CONTROL_KEY_MUTE			0x43
+#define BT_CONTROL_KEY_PLAY			0x44
+#define BT_CONTROL_KEY_STOP			0x45
+#define BT_CONTROL_KEY_PAUSE			0x46
+#define BT_CONTROL_KEY_RECORD			0x47
+#define BT_CONTROL_KEY_REWIND			0x48
+#define BT_CONTROL_KEY_FAST_FORWARD		0x49
+#define BT_CONTROL_KEY_EJECT			0x4A
+#define BT_CONTROL_KEY_FORWARD			0x4B
+#define BT_CONTROL_KEY_BACKWARD			0x4C
+
+struct bt_control_req {
+	bt_audio_msg_header_t 	h;
+	uint8_t 		mode;		/* Control Mode */
+	uint8_t 		key;		/* Control Key */
+} __attribute__ ((packed));
+
+/* BT_CONTROL_RSP */
+struct bt_control_rsp {
+	bt_audio_msg_header_t 	h;
+	uint8_t 		posix_errno;
+	uint8_t 		mode;		/* Control Mode */
+	uint8_t 		key;		/* Control Key */
+} __attribute__ ((packed));
+
+/* BT_CONTROL_IND */
+struct bt_control_ind {
+	bt_audio_msg_header_t 	h;
+	uint8_t 		mode;		/* Control Mode */
+	uint8_t 		key;		/* Control Key */
+} __attribute__ ((packed));
+
+/* Function declaration */
+
+/* Opens a connection to the audio service: return a socket descriptor */
+int bt_audio_service_open();
+
+/* Closes a connection to the audio service */
+int bt_audio_service_close(int sk);
+
+/* Receives stream data file descriptor : must be called after a 
+BT_STREAMFD_IND message is returned */
+int bt_audio_service_get_data_fd(int sk);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* BTAUDIOSERVICE_H */
Index: Makefile.am
===================================================================
--- Makefile.am	(.../tags/20071019_1300/audio)	(révision 144)
+++ Makefile.am	(.../branches/20071019_1300/audio)	(révision 144)
@@ -20,18 +20,18 @@
 
 if ALSA
 alsadir = $(libdir)/alsa-lib
 
 alsa_LTLIBRARIES = libasound_module_pcm_bluetooth.la libasound_module_ctl_bluetooth.la
 
-libasound_module_pcm_bluetooth_la_SOURCES = pcm_bluetooth.c ipc.h
+libasound_module_pcm_bluetooth_la_SOURCES = pcm_bluetooth.c btaudioservice.h btaudioservice.c
 libasound_module_pcm_bluetooth_la_LDFLAGS = -module -avoid-version -export-symbols-regex [_]*snd_pcm_.*
 libasound_module_pcm_bluetooth_la_LIBADD = @SBC_LIBS@ @ALSA_LIBS@
 libasound_module_pcm_bluetooth_la_CFLAGS = @ALSA_CFLAGS@ @SBC_CFLAGS@
 
-libasound_module_ctl_bluetooth_la_SOURCES = ctl_bluetooth.c ipc.h
+libasound_module_ctl_bluetooth_la_SOURCES = ctl_bluetooth.c btaudioservice.h btaudioservice.c
 libasound_module_ctl_bluetooth_la_LDFLAGS = -module -avoid-version -export-symbols-regex [_]*snd_ctl_.*
 libasound_module_ctl_bluetooth_la_LIBADD = @ALSA_LIBS@
 libasound_module_ctl_bluetooth_la_CFLAGS = @ALSA_CFLAGS@
 endif
 
 if GSTREAMER

--------------080105030805090608000400--
