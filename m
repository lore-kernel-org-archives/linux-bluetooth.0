Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Thu, 8 Nov 2007 11:58:49 +0200
Message-ID: <719D5CCC2F6E3644B0A9F5C9B1D00088039D4053@esebe104.NOE.Nokia.com>
In-Reply-To: <472A0CDB.50104@free.fr>
References: <719D5CCC2F6E3644B0A9F5C9B1D00088038171C2@esebe104.NOE.Nokia.com><471730B2.3030606@free.fr>	<Pine.LNX.4.64.0710181017560.28683@simba.math.ucla.edu><719D5CCC2F6E3644B0A9F5C9B1D0008803840FC4@esebe104.NOE.Nokia.com>	<471E2829.5020303@free.fr>	<719D5CCC2F6E3644B0A9F5C9B1D00088038C8C83@esebe104.NOE.Nokia.com>	<4729E570.6060202@free.fr><719D5CCC2F6E3644B0A9F5C9B1D00088039392F0@esebe104.NOE.Nokia.com>
	<472A0CDB.50104@free.fr>
From: <Kai.Vehmanen@nokia.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] new not-so-experimental ALSA plugin patch (was: RE:
	Kai's experimental ALSA/A2DP plugin patch review)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Fabien and others,

On 01 Nov 2007, Fabien Chevalier wrote:
>  * i noticed audible audio clicks while using rhythmbox and 
>my HBH DS970 headset: from my point of view the audio quality 
>is clearly inferior to what is in CVS today.
>  * as such this patch is not ready for inclusion, furthermore 
>it still has some design flaws (see below).

so there (see above) were problems with my last attempt. But in 
the spririt of...

>  * if Kai goes on with he's good work, i have no doubt he's 
>gonna come up with something quite good in the future :-) ... 
>but for now we're not there yet.

... ;), here's another attempt. I now got a Logitech Freepulse 
headset, which triggered quite a few issues I hadn't seen
before (some of which happen also with CVS-HEAD of pcm_bluetooth.c):

Delta to last patch:
  - brought MSG_DONTWAIT back (and dropped hw_ptr "adaptation" as
    it's not needed if MSG_DONTWAIT is used)
	-> rely on XRUN mechanism as before
  - dropped 16384 byte period size -> broken playback with
    Logitech Freepulse
  - modified polling mechanism to queue wakeups (write to internal
    pipe) for each hw_ptr increment -> this fixes plugin's poll() 
    behaviour in cases where hw_ptr jumps multiple periods in
    one go -> fixes a problem with Logitech Freepulse
  - added a simple mechanism to reset the hw_thread state 
    when XRUNs occur

General ideas I'm trying to accomplish:
  - allow use of bigger blocksizes to reduce wakeup load
  - fix playback with apps that rely on accurate poll
    behaviour: alsa-lib/test/pcm.c and 'write_and_poll' access
    method, Pulseaudio 0.9.[67], ...
  - make a2dp_write consume all bytes in one go (needed to
    make MMAP emulation work and still allow bigger period sizes)

If this is ok to the reviewers, I'm proposing to merge this
into CVS-HEAD.

Patched pcm_bluetooth.c, and a patch against CVS-HEAD are 
available at:
http://sofia-sip.org/~vehmanek/bluez-patches/pcm_bluetooth.c-worksgood20
071108-clean
http://sofia-sip.org/~vehmanek/bluez-patches/patch-20071108-a2dp-wakeup-
rectoring-kv.txt

Here's the patch inlined for commenting:
--cut--
--- pcm_bluetooth.c?revision=1.77	2007-11-06 13:37:25.000000000
+0200
+++ pcm_bluetooth.c-worksgood20071108-clean	2007-11-08
11:53:56.000000000 +0200
@@ -3,6 +3,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2004-2007  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2007 Nokia Corporation
  *
  *
  *  This library is free software; you can redistribute it and/or
@@ -30,6 +31,7 @@
 #include <sys/un.h>
 #include <sys/time.h>
 #include <pthread.h>
+#include <signal.h>
 
 #include <netinet/in.h>
 
@@ -91,6 +93,7 @@
 	pthread_t hw_thread;		/* Makes virtual hw pointer move
*/
 	int pipefd[2];			/* Inter thread communication */
 	int stopped;
+	sig_atomic_t reset;             /* Request XRUN handling */
 };
 
 static int bluetooth_start(snd_pcm_ioplug_t *io)
@@ -116,6 +119,9 @@
 	struct pollfd fds[2];
 	int poll_timeout;
 
+	data->server.events = POLLIN;
+	/* note: only errors for data->stream.events */
+
 	fds[0] = data->server;
 	fds[1] = data->stream;
 
@@ -136,6 +142,13 @@
 		if (data->stopped)
 			goto iter_sleep;
 
+		if (data->reset) {
+			DBG("Handle XRUN in hw-thread.");
+			data->reset = 0;
+			gettimeofday(&start, 0);
+			prev_periods = 0;
+		}
+
 		gettimeofday(&cur, 0);
 
 		timersub(&cur, &start, &delta);
@@ -145,14 +158,17 @@
 
 		if (periods > prev_periods) {
 			char c = 'w';
+			int frags = periods - prev_periods, n;
 
-			data->hw_ptr += (periods - prev_periods) *
-
data->io.period_size;
+			data->hw_ptr += frags *	data->io.period_size;
 			data->hw_ptr %= data->io.buffer_size;
 
-			/* Notify user that hardware pointer has moved
*/
-			if (write(data->pipefd[1], &c, 1) < 0)
-				pthread_testcancel();
+			for (n = 0; n < frags; n++) {
+				/* Notify user that hardware pointer
+				 * has moved * */
+				if (write(data->pipefd[1], &c, 1) < 0)
+					pthread_testcancel();
+			}
 
 			/* Reset point of reference to avoid too big
values
 			 * that wont fit an unsigned int */
@@ -167,6 +183,7 @@
 iter_sleep:
 		/* sleep up to one period interval */
 		ret = poll(fds, 2, poll_timeout);
+		
 		if (ret < 0) {
 			SNDERR("poll error: %s (%d)", strerror(errno),
errno);
 			if (errno != EINTR)
@@ -329,6 +346,8 @@
 	DBG("Preparing with io->period_size=%lu io->buffer_size=%lu",
 					io->period_size,
io->buffer_size);
 
+	data->reset = 0;
+
 	if (io->stream == SND_PCM_STREAM_PLAYBACK)
 		/* If not null for playback, xmms doesn't display time
 		 * correctly */
@@ -609,9 +628,11 @@
 	header->timestamp = htonl(a2dp->nsamples);
 	header->ssrc = htonl(1);
 
-	ret = send(data->stream.fd, a2dp->buffer, a2dp->count,
MSG_DONTWAIT);
-	if (ret == -1)
+        ret = send(data->stream.fd, a2dp->buffer, a2dp->count,
MSG_DONTWAIT);
+	if (ret < 0) {
+		DBG("send returned %d errno %s.", ret, strerror(errno));
 		ret = -errno;
+	}
 
 	/* Reset buffer of data to send */
 	a2dp->count = sizeof(struct rtp_header) + sizeof(struct
rtp_payload);
@@ -629,18 +650,19 @@
 	struct bluetooth_data *data = io->private_data;
 	struct bluetooth_a2dp *a2dp = &data->a2dp;
 	snd_pcm_sframes_t ret = 0;
-	snd_pcm_uframes_t frames_to_read;
+	snd_pcm_uframes_t frames_to_read, frames_left = size;
 	int frame_size, encoded;
 	uint8_t *buff;
 
 	DBG("areas->step=%u areas->first=%u offset=%lu size=%lu",
 				areas->step, areas->first, offset,
size);
-	DBG("hw_ptr=%lu appl_ptr=%lu", io->hw_ptr, io->appl_ptr);
+	DBG("hw_ptr=%lu appl_ptr=%lu diff=%lu", io->hw_ptr,
io->appl_ptr, io->appl_ptr - io->hw_ptr);
 
 	if (io->hw_ptr > io->appl_ptr) {
 		ret = bluetooth_playback_stop(io);
 		if (ret == 0)
 			ret = -EPIPE;
+		data->reset = 1;
 		goto done;
 	}
 
@@ -648,69 +670,82 @@
 	if (io->state == SND_PCM_STATE_PREPARED) {
 		snd_pcm_sw_params_t *swparams;
 		snd_pcm_uframes_t threshold;
-
+		
 		snd_pcm_sw_params_malloc(&swparams);
 		if (!snd_pcm_sw_params_current(io->pcm, swparams) &&
-
!snd_pcm_sw_params_get_start_threshold(swparams, &threshold)) {
+		    !snd_pcm_sw_params_get_start_threshold(swparams,
&threshold)) {
 			if (io->appl_ptr >= threshold) {
 				ret = snd_pcm_start(io->pcm);
 				if (ret != 0)
 					goto done;
 			}
 		}
+
 		snd_pcm_sw_params_free(swparams);
 	}
 
-	frame_size = areas->step / 8;
-	if ((data->count + size * frame_size) <= a2dp->codesize)
-		frames_to_read = size;
-	else
-		frames_to_read = (a2dp->codesize - data->count) /
frame_size;
+	while(frames_left > 0) {
 
-	DBG("count=%d frames_to_read=%lu", data->count, frames_to_read);
-	DBG("a2dp.count=%d cfg.pkt_len=%d", a2dp->count,
data->cfg.pkt_len);
+		frame_size = areas->step / 8;
+		if ((data->count + frames_left * frame_size) <=
a2dp->codesize)
+			frames_to_read = frames_left;
+		else
+			frames_to_read = (a2dp->codesize - data->count)
/ frame_size;
+
+		DBG("count=%d frames_to_read=%lu", data->count,
frames_to_read);
+		DBG("a2dp.count=%d cfg.pkt_len=%d", a2dp->count,
data->cfg.pkt_len);
+
+		/* FIXME: If state is not streaming then return */
+
+		/* Ready for more data */
+		buff = (uint8_t *) areas->addr +
+			(areas->first + areas->step * (offset + ret)) /
8;
+		memcpy(data->buffer + data->count, buff, frame_size *
frames_to_read);
+
+		/* Remember we have some frames in the pipe now */
+		data->count += frames_to_read * frame_size;
+		if (data->count != a2dp->codesize) {
+			ret = frames_to_read;
+			goto done;
+		}
 
-	/* FIXME: If state is not streaming then return */
+		/* Enough data to encode (sbc wants 1k blocks) */
+		encoded = sbc_encode(&(a2dp->sbc), data->buffer,
a2dp->codesize);
+		if (encoded <= 0) {
+			DBG("Encoding error %d", encoded);
+			goto done;
+		}
 
-	/* Ready for more data */
-	buff = (uint8_t *) areas->addr +
-				(areas->first + areas->step * offset) /
8;
-	memcpy(data->buffer + data->count, buff, frame_size *
frames_to_read);
+		data->count -= encoded;
 
-	/* Remember we have some frames in the pipe now */
-	data->count += frames_to_read * frame_size;
-	if (data->count != a2dp->codesize) {
-		ret = frames_to_read;
-		goto done;
-	}
+		DBG("encoded=%d  a2dp.sbc.len=%d count=%d", encoded,
a2dp->sbc.len, a2dp->count);
 
-	/* Enough data to encode (sbc wants 1k blocks) */
-	encoded = sbc_encode(&(a2dp->sbc), data->buffer,
a2dp->codesize);
-	if (encoded <= 0) {
-		DBG("Encoding error %d", encoded);
-		goto done;
-	}
+		/* Send previously encoded buffer */
+		if (a2dp->count + a2dp->sbc.len >= data->cfg.pkt_len) {
+#ifdef ENABLE_DEBUG
+			int old_count = a2dp->count;
+			int c =
+#endif
 
-	data->count -= encoded;
+			avdtp_write(data);
+			DBG("sending packet %d, count %d, pkt_len %u",
c, old_count, data->cfg.pkt_len);
+		}
 
-	DBG("encoded=%d  a2dp.sbc.len=%d", encoded, a2dp->sbc.len);
+		memcpy(a2dp->buffer + a2dp->count, a2dp->sbc.data,
a2dp->sbc.len);
+		a2dp->count += a2dp->sbc.len;
+		a2dp->frame_count++;
+		a2dp->samples += encoded / frame_size;
+		a2dp->nsamples += encoded / frame_size;
 
-	if (a2dp->count + a2dp->sbc.len >= data->cfg.pkt_len) {
-		ret = avdtp_write(data);
-		if (ret < 0) {
-			if (-ret == EPIPE)
-				ret = -EIO;
-			goto done;
-		}
-	}
+		/* (io->buffer_size + io->appl_ptr - io->period_size) *
% io->buffer_size */
 
-	memcpy(a2dp->buffer + a2dp->count, a2dp->sbc.data,
a2dp->sbc.len);
-	a2dp->count += a2dp->sbc.len;
-	a2dp->frame_count++;
-	a2dp->samples += encoded / frame_size;
-	a2dp->nsamples += encoded / frame_size;
+		ret += frames_to_read;
+		frames_left -= frames_to_read;
+	}
 
-	ret = frames_to_read;
+	/* note: some ALSA apps will get confused otherwise */
+	if (ret > size)
+		ret = size;
 
 done:
 	DBG("returning %ld", ret);
@@ -847,7 +882,6 @@
 static int bluetooth_a2dp_hw_constraint(snd_pcm_ioplug_t *io)
 {
 	struct bluetooth_data *data = io->private_data;
-	struct bluetooth_a2dp *a2dp = &data->a2dp;
 	struct ipc_data_cfg cfg = data->cfg;
 	snd_pcm_access_t access_list[] = {
 		SND_PCM_ACCESS_RW_INTERLEAVED,
@@ -886,18 +920,25 @@
 	if (err < 0)
 		return err;
 
-	/* supported block sizes:
-	 *   - lower limit is A2DP codec size
-	 *   - total buffer size is the upper limit (with two periods)
*/
-	err = snd_pcm_ioplug_set_param_minmax(io,
-
SND_PCM_IOPLUG_HW_PERIOD_BYTES,
-						a2dp->codesize,
-						a2dp->codesize);
-	if (err < 0)
-		return err;
+	/* supported block sizes: */
+	{ 
+		const unsigned int period_list[] = {
+			512,  /*  3/6ms (mono/stereo 16bit at 44.1kHz)
*/
+			1024, /*  6/12ms */
+			2048, /* 12/23ms */
+			4096, /* 23/46ms */
+			8192, /* 46/93ms */
+		};
+		
+		err = snd_pcm_ioplug_set_param_list(io,
SND_PCM_IOPLUG_HW_PERIOD_BYTES,
+
ARRAY_NELEMS(period_list), period_list);
+		if (err < 0)
+			return err;
+	}
 
+	/* period count fixed to 3 as we don't support prefilling */
 	err = snd_pcm_ioplug_set_param_minmax(io,
SND_PCM_IOPLUG_HW_PERIODS,
-						2, 50);
+					      3, 3);
 	if (err < 0)
 		return err;
--cut--

br,
-- 
first.surname@nokia.com (Kai Vehmanen)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
