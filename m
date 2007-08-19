Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46C875BA.90204@free.fr>
Date: Sun, 19 Aug 2007 18:54:18 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------010908040901050405000607"
Subject: [Bluez-devel] [PATCH] pcm_bluetooth : fix a2dp streaming
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010908040901050405000607
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Johan & All,

Following recent mailing list discussions, i decided to implement some 
of the ideas that have been suggested recently. :-)

So i heavily modified the A2DP streaming part of the pcm plugin

The user-visible features of this patch:
   * much reduced latency (You should love this one Frederic)
   * supports headsets that are unable to throttle the data flow and
     that play too fast or drop packets or whatever (Marcel, could you
     please confirm that fixes the issues you had with some headsets ?).

This patch is fairly intrusive, and removes some code that i judjed 
useless now, like the bandwidth measurement stuff, and has greatly 
simplifyed transfer loop for avdtp (see comments in the code for the 
justifications)

It brings in a thread that has for only reponsibility to increment the 
so called hardware pointer (which doesn't point to anything in our 
case), and notify the application trough writing in a pipe that some 
room is available (virtual room again), so that it could send more data.

The attached file details the tests i've run to check i didn't break 
anything. All is conclusive except playing with XMMS that goes underrun 
for a reason i haven spotted yet. Apart from that aplay, mplayer, 
gstreamer are fine.

I'm looking forward for any questions you have on the patch.

Nest step would be to fix the SCO part of the plugin, but this one is 
looks harder as i think it will require tweaking the kernel SCO part.

Regards,

Fabien

--------------010908040901050405000607
Content-Type: text/x-patch;
 name="pcm_bluetooth.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcm_bluetooth.c.patch"

diff -u -r1.31 pcm_bluetooth.c
--- pcm_bluetooth.c	15 Aug 2007 10:36:16 -0000	1.31
+++ pcm_bluetooth.c	19 Aug 2007 16:24:22 -0000
@@ -28,6 +28,7 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <sys/time.h>
+#include <pthread.h>
 
 #include <netinet/in.h>
 
@@ -93,13 +94,13 @@
 	uint16_t seq_num;		/* */
 	int frame_count;		/* */
 
-	int bandwithcount;
-	struct timeval bandwithtimestamp;
+	pthread_t hw_thread;            /* Makes virtual hw pointer move */	
+	int pipefd[2];			/* Inter thread communication */
 };
 
 struct bluetooth_data {
 	snd_pcm_ioplug_t io;
-	snd_pcm_sframes_t hw_ptr;
+	volatile snd_pcm_sframes_t hw_ptr;
 	struct ipc_data_cfg cfg;	/* Bluetooth device config */
 	int stream_fd;			/* Audio stream filedescriptor */
 	int sock;			/* Daemon unix socket */
@@ -108,6 +109,8 @@
 	struct bluetooth_a2dp a2dp;	/* a2dp data */
 };
 
+static void * a2dp_playback_hw_thread(void *param);
+
 void memcpy_changeendian(void *dst, const void *src, int size)
 {
 	int i;
@@ -132,6 +135,43 @@
 	return 0;
 }
 
+static int bluetooth_a2dp_playback_start(snd_pcm_ioplug_t *io)
+{
+	struct bluetooth_data *data = io->private_data;
+	struct bluetooth_a2dp *a2dp_data = &data->a2dp;	
+	int ret = 0;
+	DBG("%p", io);
+
+	assert(a2dp_data->hw_thread == 0);
+	ret = -pthread_create(&a2dp_data->hw_thread, 0, a2dp_playback_hw_thread, data);
+
+	DBG(" - return %d", ret);
+	return ret;
+}
+
+static int bluetooth_a2dp_playback_stop(snd_pcm_ioplug_t *io)
+{
+	DBG("%p", io);
+	struct bluetooth_data *data = io->private_data;
+	struct bluetooth_a2dp *a2dp_data = &data->a2dp;	
+	int ret = 0;
+
+	/* Beware - We can be called more than once */
+	if(a2dp_data->hw_thread != 0) {
+		ret = -pthread_cancel(a2dp_data->hw_thread);
+		if(ret != 0) {
+			goto end;
+		}
+
+		ret = -pthread_join(a2dp_data->hw_thread, 0);
+	}
+
+end:
+	a2dp_data->hw_thread = 0;
+	DBG(" - return %d", ret);
+	return ret;
+}
+
 static snd_pcm_sframes_t bluetooth_pointer(snd_pcm_ioplug_t *io)
 {
 	struct bluetooth_data *data = io->private_data;
@@ -154,6 +194,12 @@
 	if (data->cfg.codec == CFG_CODEC_SBC)
 		sbc_finish(&data->a2dp.sbc);
 
+	if(data->a2dp.pipefd[0] > 0)
+		close(data->a2dp.pipefd[0]);
+	
+	if(data->a2dp.pipefd[1] > 0)
+		close(data->a2dp.pipefd[1]);
+	
 	free(data);
 }
 
@@ -171,6 +217,8 @@
 static int bluetooth_prepare(snd_pcm_ioplug_t *io)
 {
 	struct bluetooth_data *data = io->private_data;
+	int ret;
+	char c;	
 
 	DBG("Preparing with io->period_size = %lu, io->buffer_size = %lu",
 			io->period_size, io->buffer_size);
@@ -184,7 +232,9 @@
 		 * If it is, capture won't start */
 		data->hw_ptr = io->period_size;
 
-	return 0;
+	/* a2dp : wake up any client polling at us */	
+	ret = write(data->a2dp.pipefd[1], &c, 1);
+	return ret;
 }
 
 static int bluetooth_hsp_hw_params(snd_pcm_ioplug_t *io,
@@ -239,6 +289,111 @@
 	return -err;
 }
 
+static int bluetooth_poll_descriptors(snd_pcm_ioplug_t *io, 
+					struct pollfd *pfd, 
+					unsigned int space)
+{
+	assert(io);
+	assert(space >= 1);
+
+	pfd[0].fd = ((struct bluetooth_data *)io->private_data)->stream_fd;
+	pfd[0].events = POLLIN;
+	pfd[0].revents = 0;
+
+	return 1;
+}
+
+static int bluetooth_poll_revents(snd_pcm_ioplug_t *io ATTRIBUTE_UNUSED,
+				     struct pollfd *pfds, unsigned int nfds,
+				     unsigned short *revents)
+{
+	assert(pfds && nfds == 1 && revents);
+
+	*revents = pfds[0].revents;
+	return 0;
+}
+
+static int bluetooth_a2dp_playback_poll_descriptors(snd_pcm_ioplug_t *io, 
+							struct pollfd *pfd, 
+							unsigned int space)
+{
+	struct bluetooth_data *data = io->private_data;
+
+	DBG("");
+
+	assert(io);
+	assert(space >= 1);
+	assert(data->a2dp.pipefd[0] != 0);
+
+	pfd[0].fd = data->a2dp.pipefd[0];
+	pfd[0].events = POLLIN;
+	pfd[0].revents = 0;
+
+	return 1;
+}
+
+static int bluetooth_a2dp_playback_poll_revents(snd_pcm_ioplug_t *io,
+				     struct pollfd *pfds, unsigned int nfds,
+				     unsigned short *revents)
+{
+	static char buf[1];
+	int ret = 0;	
+
+	DBG("");
+
+	assert(pfds);
+	assert(nfds == 1);
+	assert(revents);
+	assert(pfds[0].fd != 0);
+
+	if(io->state != SND_PCM_STATE_PREPARED) {	
+		ret = read(pfds[0].fd, buf, 1);
+	}	
+	*revents = (pfds[0].revents & ~POLLIN) | POLLOUT;
+	return 0;
+}
+
+static void * a2dp_playback_hw_thread(void *param)
+{
+	struct bluetooth_data* data = (struct bluetooth_data *)param;
+	unsigned int num_period_elapsed = 0;
+	unsigned long long starttime; /* in usecs */
+	unsigned long long curtime; /* in usecs */
+	struct timeval tv;
+	int ret;
+
+	gettimeofday(&tv, 0);
+	starttime = tv.tv_sec * 1000000 + tv.tv_usec;
+
+	#define PERIOD_TIME_USECS (1000000.0 * \
+		(data->io.period_size) / \
+		 data->io.rate)
+	for(;;) {
+		gettimeofday(&tv, 0);
+		curtime = tv.tv_sec * 1000000 + tv.tv_usec;
+		/* How much time period_time has elapsed since the thread started ? */
+		unsigned int ntimes = (1.0 * (curtime - starttime)) 
+					/ PERIOD_TIME_USECS;
+		if(ntimes > num_period_elapsed) {
+			char c;			
+			data->hw_ptr = (data->hw_ptr + 
+					(ntimes - num_period_elapsed)
+					* data->io.period_size)
+					% data->io.buffer_size;
+			DBG("pointer = %ld", data->hw_ptr);			
+			/* Notify user that hardware pointer has moved */
+			ret = write(data->a2dp.pipefd[1], &c, 1);
+			assert(ret == 1);			
+			num_period_elapsed = ntimes;
+		}		
+		/* Period time is usually no shorter that 1 ms, 
+		   no need to sleep for a shorter amount of time */
+		usleep(1000);
+		/* Offer opportunity to be canceled by main thread */		
+		pthread_testcancel();	
+	}
+}
+
 static snd_pcm_sframes_t bluetooth_hsp_read(snd_pcm_ioplug_t *io,
 						const snd_pcm_channel_area_t *areas,
 						snd_pcm_uframes_t offset,
@@ -364,19 +519,14 @@
 	return ret;
 }
 
-static int avdtp_write(struct bluetooth_data *data, unsigned int nonblock)
+static int avdtp_write(struct bluetooth_data *data)
 {
-	int count = 0, written = 0, ret = 0;
+	int ret = 0;
 	struct rtp_header *header;
 	struct rtp_payload *payload;
 	struct bluetooth_a2dp *a2dp = &data->a2dp;
-#ifdef ENABLE_DEBUG
-	static struct timeval send_date = { 0, 0 };
-	static struct timeval prev_date = { 0, 0 };
-	struct timeval send_delay = { 0, 0 };
-	struct timeval sendz_delay = { 0, 0 };
-#endif
 
+	DBG("");
 	header = (void *) a2dp->buffer;
 	payload = (void *) (a2dp->buffer + sizeof(*header));
 
@@ -389,98 +539,24 @@
 	header->timestamp = htonl(a2dp->nsamples);
 	header->ssrc = htonl(1);
 
-	while (count++ < 10) {
-#ifdef ENABLE_DEBUG
-		gettimeofday(&send_date, NULL);
-#endif
-		ret = send(data->stream_fd, a2dp->buffer, a2dp->count,
-				nonblock ? MSG_DONTWAIT : 0);
-		if (ret < 0) {
-			ret = -errno;
-			if (errno == EAGAIN)
-				goto retry;
-			fprintf(stderr, "send: %s (%d)\n", strerror(errno),
-					errno);
-			goto done;
-		}
-
-		written += ret;
-
-#ifdef ENABLE_DEBUG
-		if ((written >= 0 || errno == EAGAIN) && prev_date.tv_sec != 0) {
-			long delay, real, theo, delta;
+	ret = send(data->stream_fd, a2dp->buffer, a2dp->count,
+				MSG_DONTWAIT);
+	if(ret == -1)
+		ret = -errno;
+
+	/* Kernel side l2cap socket layer makes sure either everything 
+	   is buffered for sending, or nothing is buffered.
+	   This assertion is to remind people of this fact (and be noticed
+	   the day that changes)
+ 	   */
+	assert(ret < 0 || ret == a2dp->count);
 
-			delay = (long) (send_delay.tv_sec * 1000 +
-						send_delay.tv_usec / 1000),
-			real = (long) (sendz_delay.tv_sec * 1000 +
-						sendz_delay.tv_usec / 1000);
-			theo = (long) (((float) a2dp->nsamples) /
-						data->cfg.rate * 1000.0);
-			delta = (long) (sendz_delay.tv_sec * 1000 +
-						sendz_delay.tv_usec / 1000) -
-					(long) (((float) a2dp->nsamples) /
-							data->cfg.rate * 1000.0);
-
-			timersub(&send_date, &prev_date, &send_delay);
-			timersub(&send_date, &a2dp->ntimestamp, &sendz_delay);
-
-			printf("send %d (cumul=%d) samples (delay=%ld ms,"
-					" real=%ld ms, theo=%ld ms,"
-					" delta=%ld ms).\n", a2dp->samples,
-					a2dp->nsamples, delay, real, theo,
-					delta);
-		}
-#endif
-		if (written == a2dp->count)
-			break;
-
-		a2dp->count -= written;
-
-retry:
-		DBG("send (retry).");
-		usleep(150000);
-	}
-
-#ifdef ENABLE_DEBUG
-	prev_date = send_date;
-#endif
-
-	if (written != a2dp->count)
-		printf("Wrote %d not %d bytes\n", written, a2dp->count);
-
-#ifdef ENABLE_DEBUG
-	else {
-		/* Measure bandwith usage */
-		struct timeval now = { 0, 0 };
-		struct timeval interval = { 0, 0 };
-
-		if(a2dp->bandwithtimestamp.tv_sec == 0)
-			gettimeofday(&a2dp->bandwithtimestamp, NULL);
-
-		/* See if we must wait again */
-		gettimeofday(&now, NULL);
-		timersub(&now, &a2dp->bandwithtimestamp, &interval);
-		if(interval.tv_sec > 0)
-			printf("Bandwith: %d (%d kbps)\n", a2dp->bandwithcount,
-				a2dp->bandwithcount / 128);
-		a2dp->bandwithtimestamp = now;
-		a2dp->bandwithcount = 0;
-	}
-
-	a2dp->bandwithcount += written;
-
-#endif
-
-done:
 	/* Reset buffer of data to send */
 	a2dp->count = sizeof(struct rtp_header) + sizeof(struct rtp_payload);
 	a2dp->frame_count = 0;
 	a2dp->samples = 0;
 	a2dp->seq_num++;
 
-	if (written > 0)
-		return written;
-
 	return ret;
 }
 
@@ -497,9 +573,35 @@
 	uint8_t *buff;
 	static int codesize = 0;
 
-	DBG("areas->step=%u, areas->first=%u, offset=%lu, size=%lu,"
-			"io->nonblock=%u", areas->step, areas->first,
-			offset, size, io->nonblock);
+	DBG("areas->step=%u, areas->first=%u, offset=%lu, size=%lu"
+			, areas->step, areas->first, offset, size);
+	DBG("hw_ptr = %lu, appl_ptr = %lu"
+			, io->hw_ptr, io->appl_ptr);
+
+	if(io->hw_ptr > io->appl_ptr) {
+		ret = bluetooth_a2dp_playback_stop(io);
+		if(ret == 0)		
+			ret = -EPIPE;
+		goto done;	
+	}		
+
+	/* Check if we should autostart */
+	if(io->state == SND_PCM_STATE_PREPARED) {
+		snd_pcm_sw_params_t *swparams;
+		snd_pcm_uframes_t threshold;
+	
+		snd_pcm_sw_params_malloc(&swparams);
+		if(!snd_pcm_sw_params_current(io->pcm, swparams)
+		   && !snd_pcm_sw_params_get_start_threshold(swparams,
+		       &threshold) ) {
+			if(io->appl_ptr >= threshold) {
+				ret = snd_pcm_start(io->pcm);
+				if(ret != 0)
+					goto done;			
+			}
+		}
+		snd_pcm_sw_params_free(swparams);	
+	}
 
 	if (codesize == 0) {
 		/* How much data can be encoded by sbc at a time? */
@@ -548,7 +650,7 @@
 	DBG("encoded = %d  a2dp.sbc.len= %d", encoded, a2dp->sbc.len);
 
 	if (a2dp->count + a2dp->sbc.len >= data->cfg.pkt_len) {
-		ret = avdtp_write(data, io->nonblock);
+		ret = avdtp_write(data);
 		if (ret < 0) {
 			if (-ret == EPIPE)
 				ret = -EIO;
@@ -561,55 +663,60 @@
 	a2dp->frame_count++;
 	a2dp->samples += encoded / frame_size;
 	a2dp->nsamples += encoded / frame_size;
-	/* Increment hardware transmition pointer */
-	data->hw_ptr = (data->hw_ptr + encoded / frame_size)
-			% io->buffer_size;
 
 	ret = frames_to_read;
 
 done:
-	DBG("returning %lu", ret);
+	DBG("returning %ld", ret);
 	return ret;
 }
 
 static snd_pcm_ioplug_callback_t bluetooth_hsp_playback = {
-	.start		= bluetooth_start,
-	.stop		= bluetooth_stop,
-	.pointer	= bluetooth_pointer,
-	.close		= bluetooth_close,
-	.hw_params	= bluetooth_hsp_hw_params,
-	.prepare	= bluetooth_prepare,
-	.transfer	= bluetooth_hsp_write,
+	.start			= bluetooth_start,
+	.stop			= bluetooth_stop,
+	.pointer		= bluetooth_pointer,
+	.close			= bluetooth_close,
+	.hw_params		= bluetooth_hsp_hw_params,
+	.prepare		= bluetooth_prepare,
+	.transfer		= bluetooth_hsp_write,
+	.poll_descriptors	= bluetooth_poll_descriptors,
+	.poll_revents		= bluetooth_poll_revents,
 };
 
 static snd_pcm_ioplug_callback_t bluetooth_hsp_capture = {
-	.start		= bluetooth_start,
-	.stop		= bluetooth_stop,
-	.pointer	= bluetooth_pointer,
-	.close		= bluetooth_close,
-	.hw_params	= bluetooth_hsp_hw_params,
-	.prepare	= bluetooth_prepare,
-	.transfer	= bluetooth_hsp_read,
+	.start			= bluetooth_start,
+	.stop			= bluetooth_stop,
+	.pointer		= bluetooth_pointer,
+	.close			= bluetooth_close,
+	.hw_params		= bluetooth_hsp_hw_params,
+	.prepare		= bluetooth_prepare,
+	.transfer		= bluetooth_hsp_read,
+	.poll_descriptors	= bluetooth_poll_descriptors,
+	.poll_revents		= bluetooth_poll_revents,
 };
 
 static snd_pcm_ioplug_callback_t bluetooth_a2dp_playback = {
-	.start		= bluetooth_start,
-	.stop		= bluetooth_stop,
-	.pointer	= bluetooth_pointer,
-	.close		= bluetooth_close,
-	.hw_params	= bluetooth_a2dp_hw_params,
-	.prepare	= bluetooth_prepare,
-	.transfer	= bluetooth_a2dp_write,
+	.start			= bluetooth_a2dp_playback_start,
+	.stop			= bluetooth_a2dp_playback_stop,
+	.pointer		= bluetooth_pointer,
+	.close			= bluetooth_close,
+	.hw_params		= bluetooth_a2dp_hw_params,
+	.prepare		= bluetooth_prepare,
+	.transfer		= bluetooth_a2dp_write,
+	.poll_descriptors	= bluetooth_a2dp_playback_poll_descriptors,
+	.poll_revents		= bluetooth_a2dp_playback_poll_revents,
 };
 
 static snd_pcm_ioplug_callback_t bluetooth_a2dp_capture = {
-	.start		= bluetooth_start,
-	.stop		= bluetooth_stop,
-	.pointer	= bluetooth_pointer,
-	.close		= bluetooth_close,
-	.hw_params	= bluetooth_a2dp_hw_params,
-	.prepare	= bluetooth_prepare,
-	.transfer	= bluetooth_a2dp_read,
+	.start			= bluetooth_start,
+	.stop			= bluetooth_stop,
+	.pointer		= bluetooth_pointer,
+	.close			= bluetooth_close,
+	.hw_params		= bluetooth_a2dp_hw_params,
+	.prepare		= bluetooth_prepare,
+	.transfer		= bluetooth_a2dp_read,
+	.poll_descriptors	= bluetooth_poll_descriptors,
+	.poll_revents		= bluetooth_poll_revents,
 };
 
 #define ARRAY_NELEMS(a) (sizeof((a)) / sizeof((a)[0]))
@@ -661,7 +768,7 @@
 		return err;
 
 	err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_PERIODS,
-					2, 200);
+					2, 50);
 	if (err < 0)
 		return err;
 
@@ -738,6 +845,14 @@
 	a2dp->sbc.blocks = sbc->blocks;
 	a2dp->sbc.bitpool = sbc->bitpool;
 
+
+	if(pipe(a2dp->pipefd) != 0)
+		return -errno;
+	if(fcntl(a2dp->pipefd[0], F_SETFL, O_NONBLOCK) != 0)
+		return -errno;	
+	if(fcntl(a2dp->pipefd[1], F_SETFL, O_NONBLOCK) != 0)
+		return -errno;
+
 	return 0;
 }
 
@@ -888,7 +1003,7 @@
 	DBG("Bluetooth PCM plugin (%s)",
 		stream == SND_PCM_STREAM_PLAYBACK ? "Playback" : "Capture");
 
-	data = malloc(sizeof(struct bluetooth_data));
+	data = calloc(1, sizeof(struct bluetooth_data));
 	if (!data) {
 		err = -ENOMEM;
 		goto error;
@@ -901,9 +1016,6 @@
 	data->io.version = SND_PCM_IOPLUG_VERSION;
 	data->io.name = "Bluetooth Audio Device";
 	data->io.mmap_rw = 0; /* No direct mmap communication */
-	data->io.poll_fd = data->stream_fd;
-	data->io.poll_events = stream == SND_PCM_STREAM_PLAYBACK ?
-					POLLOUT : POLLIN;
 	data->io.private_data = data;
 
 	if (data->cfg.codec == CFG_CODEC_SBC)

--------------010908040901050405000607
Content-Type: text/plain;
 name="plugin non reg cookbook.txt"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="plugin non reg cookbook.txt"

Qmx1ZXRvb3RoIGFsc2EgYTJkcCBub24gcmVncmVzc2lvbiBjb29rYm9vawotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgpJKSBQQ00gdGVzdCB0b29sIHNo
aXBwZWQgd2l0aCBBTFNBCgpTZXR1cDoKKkRvd25sb2FkIHRoZSBhbHNhLXV0aWxzIHNvdXJj
ZSBmb3IgdGhlIGJpbmFyeSB0aGF0IHJ1biBvbiB5b3VyIG1hY2hpbmUKKmJ1aWxkIHRoZSBw
Y20gZXhlY3V0YWJsZSBpbiB0aGUgdGVzdCBkaXJlY3RvcnkKClJ1bjoKLi9wY20gLWMgMiAt
ciA0ODAwMCAtRGJsdWV0b290aCAtbSB3cml0ZSAtYiAxMDAwMAouL3BjbSAtYyAyIC1yIDQ4
MDAwIC1EYmx1ZXRvb3RoIC1tIHdyaXRlX2FuZF9wb2xsIC1iIDEwMDAwCi4vcGNtIC1jIDIg
LXIgNDgwMDAgLURibHVldG9vdGggLW0gZGlyZWN0X3dyaXRlIC1iIDEwMDAwCgpSZXN1bHQ6
CllvdSBzaG91bGQgaGVhciBhIGNsZWFyIHNpbmUgaW4gdGhlIGhlYWRzZXQuCnBjbSBwcm9j
ZXNzIHNob3VsZCBub3QgZWF0IDEwMCUgY3B1IChjaGVjayB3aXRoIHRvcCkKT2NjYXNpb25u
YWwgc291bmQgZHJvcHMgYXJlIE9LIChkdWUgdG8gcXVpdGUgc2hvcnQgYnVmZmVyaW5nIG9m
IDEwIG1zKQoKSUkpIFBsYXkgYSBmaWxlIGZyb20gWE1NUwoKSUlJKSBQbGF5IGZpbGUgZnJv
bSB0b3RlbQpTZXR1cDoKKiBnY29uZnRvb2wgLXQgc3RyaW5nIC1zIC9zeXN0ZW0vZ3N0cmVh
bWVyLzAuMTAvZGVmYXVsdC9tdXNpY2F1ZGlvc2luayAiYWxzYXNpbmsgZGV2aWNlPWJsdWV0
b290aCIKClJ1bjoKTGF1bmNoIHRvdGVtLCB0aGVuIHNlbGVjdCBhIGZpbGUgZm9yIHBsYXkK
CklJSSkgUExheSBhIGZpbGUgZnJvbSBtcGxheWVyCm1wbGF5ZXIgLWFvIGFsc2E6ZGV2aWNl
PWJsdWV0b290aCBmaWxldG9wbGF5Lndhdgo=
--------------010908040901050405000607
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--------------010908040901050405000607
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------010908040901050405000607--
