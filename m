Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4729E570.6060202@free.fr>
Date: Thu, 01 Nov 2007 15:40:48 +0100
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>,
        Kai.Vehmanen@nokia.com
References: <719D5CCC2F6E3644B0A9F5C9B1D00088038171C2@esebe104.NOE.Nokia.com><471730B2.3030606@free.fr>	<Pine.LNX.4.64.0710181017560.28683@simba.math.ucla.edu><719D5CCC2F6E3644B0A9F5C9B1D0008803840FC4@esebe104.NOE.Nokia.com>	<471E2829.5020303@free.fr>
	<719D5CCC2F6E3644B0A9F5C9B1D00088038C8C83@esebe104.NOE.Nokia.com>
In-Reply-To: <719D5CCC2F6E3644B0A9F5C9B1D00088038C8C83@esebe104.NOE.Nokia.com>
Subject: [Bluez-devel] Kai's experimental ALSA/A2DP plugin patch review
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

Hi Kai,

I generated a patch from your latest pcm_bluetooth.c changes.
Please find some comments below (look for ==> sequence for my comments) :

--- pcm_bluetooth.c.orig	2007-11-01 14:48:34.000000000 +0100
+++ pcm_bluetooth.c	2007-10-30 13:31:14.000000000 +0100
@@ -609,8 +609,8 @@
  	header->timestamp = htonl(a2dp->nsamples);
  	header->ssrc = htonl(1);

-	ret = send(data->stream.fd, a2dp->buffer, a2dp->count, MSG_DONTWAIT);
-	if (ret == -1)
+        ret = send(data->stream.fd, a2dp->buffer, a2dp->count, 0);

==> MSG_DONTWAIT is there to prevent the l2cap socket to lock us up,
if for some (bad) reason the l2cap layer is not able to send data at the 
right speed. I see no reason to change that !!


+	if (ret < 0)
  		ret = -errno;

  	/* Reset buffer of data to send */
@@ -629,19 +629,20 @@
  	struct bluetooth_data *data = io->private_data;
  	struct bluetooth_a2dp *a2dp = &data->a2dp;
  	snd_pcm_sframes_t ret = 0;
-	snd_pcm_uframes_t frames_to_read;
+	snd_pcm_uframes_t frames_to_read, frames_left = size;
  	int frame_size, encoded;
  	uint8_t *buff;

  	DBG("areas->step=%u areas->first=%u offset=%lu size=%lu",
  				areas->step, areas->first, offset, size);
-	DBG("hw_ptr=%lu appl_ptr=%lu", io->hw_ptr, io->appl_ptr);
+	DBG("hw_ptr=%lu appl_ptr=%lu diff=%lu", io->hw_ptr, io->appl_ptr, 
io->appl_ptr - io->hw_ptr);

  	if (io->hw_ptr > io->appl_ptr) {
-		ret = bluetooth_playback_stop(io);
-		if (ret == 0)
-			ret = -EPIPE;
-		goto done;
+		/* Delegate XRUN handling to the headset. Here we just
+		 * reset the virtual hardware pointer. */
+		DBG("hw-ptr reset, hw_ptr=%lu appl_ptr=%lu diff=%lu.\n",
+		       io->hw_ptr, io->appl_ptr, io->appl_ptr - io->hw_ptr);
+		io->hw_ptr = io->appl_ptr;
  	}

==> Could you explain why this change is needed ? It seems to be pretty 
bas to me as it is not *at all* in the ALSA philosophy to play magics 
whith the hw_ptr, especially not bring it back in  the past !!

  	/* Check if we should autostart */
@@ -661,9 +662,11 @@
  		snd_pcm_sw_params_free(swparams);
  	}

+	while(frames_left > 0) {
+
  	frame_size = areas->step / 8;
-	if ((data->count + size * frame_size) <= a2dp->codesize)
-		frames_to_read = size;
+		if ((data->count + frames_left * frame_size) <= a2dp->codesize)
+			frames_to_read = frames_left;
  	else
  		frames_to_read = (a2dp->codesize - data->count) / frame_size;

@@ -674,7 +677,7 @@

  	/* Ready for more data */
  	buff = (uint8_t *) areas->addr +
-				(areas->first + areas->step * offset) / 8;
+			(areas->first + areas->step * (offset + ret)) / 8;
  	memcpy(data->buffer + data->count, buff, frame_size * frames_to_read);

  	/* Remember we have some frames in the pipe now */
@@ -693,15 +696,16 @@

  	data->count -= encoded;

-	DBG("encoded=%d  a2dp.sbc.len=%d", encoded, a2dp->sbc.len);
+		DBG("encoded=%d  a2dp.sbc.len=%d count=%d", encoded, a2dp->sbc.len, 
a2dp->count);

+		/* Send previously encoded buffer */
  	if (a2dp->count + a2dp->sbc.len >= data->cfg.pkt_len) {
-		ret = avdtp_write(data);
-		if (ret < 0) {
-			if (-ret == EPIPE)
-				ret = -EIO;
-			goto done;
-		}
+#ifdef ENABLE_DEBUG
+			int old_count = a2dp->count;
+			int c =
+#endif
+			avdtp_write(data);
+			DBG("sending packet %d, count %d, pkt_len %u", c, old_count, 
data->cfg.pkt_len);
  	}

  	memcpy(a2dp->buffer + a2dp->count, a2dp->sbc.data, a2dp->sbc.len);
@@ -710,7 +714,15 @@
  	a2dp->samples += encoded / frame_size;
  	a2dp->nsamples += encoded / frame_size;

-	ret = frames_to_read;
+		/* (io->buffer_size + io->appl_ptr - io->period_size) * % 
io->buffer_size */
+
+		ret += frames_to_read;
+		frames_left -= frames_to_read;
+	}
+
+	/* note: some ALSA apps will get confused otherwise */
+	if (ret > size)
+		ret = size;

  done:
  	DBG("returning %ld", ret);
@@ -847,7 +859,6 @@
  static int bluetooth_a2dp_hw_constraint(snd_pcm_ioplug_t *io)
  {
  	struct bluetooth_data *data = io->private_data;
-	struct bluetooth_a2dp *a2dp = &data->a2dp;
  	struct ipc_data_cfg cfg = data->cfg;
  	snd_pcm_access_t access_list[] = {
  		SND_PCM_ACCESS_RW_INTERLEAVED,
@@ -886,18 +897,26 @@
  	if (err < 0)
  		return err;

-	/* supported block sizes:
-	 *   - lower limit is A2DP codec size
-	 *   - total buffer size is the upper limit (with two periods) */
-	err = snd_pcm_ioplug_set_param_minmax(io,
-						SND_PCM_IOPLUG_HW_PERIOD_BYTES,
-						a2dp->codesize,
-						a2dp->codesize);
+	/* supported block sizes: */
+	{
+		const unsigned int period_list[] = {
+			2048,
+			4096, /* 23/46ms (mono/stereo 16bit at 44.1kHz) */
+#if 0
+			8192, /* 46/93ms */
+			16384 /* 93/185ms */
+#endif
+		};
+		
+		err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_PERIOD_BYTES,
+						    ARRAY_NELEMS(period_list), period_list);
  	if (err < 0)
  		return err;
+	}

+	/* period count fixed to 3 as we don't support prefilling */
  	err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_PERIODS,
-						2, 50);
+						3, 3);
  	if (err < 0)
  		return err;


>  - send errors are now ignored (packets dropped), seems
>    to have no bad side effects on the headsets I've tested
>    with
>      -> the positive impact is that we can more easily keep
> 	  up the correct timing even with bigger period sizes

I agree with that.

>  - a2dp_write() now loops'n'sends until all data submitted by
>    the app is  encoded (needed to work with MMAP using clients)

Ok for me :-)

>  - allowed period sizes defined as set of values (vs range), 
>    this works with for example pcm.c (seems to be an alsa-lib bug,
>    but didn't have time to track it down)

Ok with that too.

>  - period count fixed to 3 (seems to work best and still 
>    doesn't confuse ALSA apps)

OK with that too.

Cheers,

Fabien

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
