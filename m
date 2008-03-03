Return-Path: <cyrus@holtmann.org>
Message-ID: <47CC3EEB.6060105@access-company.com>
Date: Mon, 03 Mar 2008 19:09:47 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?= <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <47CC3DF5.8070303@access-company.com>
In-Reply-To: <47CC3DF5.8070303@access-company.com>
Content-Type: multipart/mixed; boundary="------------010504060002070805020501"
Subject: Re: [Bluez-devel] [patch] alsa plugin disconnection
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
--------------010504060002070805020501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit


updated patch.

Frédéric Dalleau wrote:
> Hi,
>
> This patch will allow alsa plugin to detect disconnection of devices and 
> return error to applications.
> Not all applications will handle this error, but at least it is available.
>
> Comments are welcome.
>
> Frederic
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>   


--------------010504060002070805020501
Content-Type: text/x-patch;
 name="alsa_plugin_disconnection.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa_plugin_disconnection.patch"

diff --git a/audio/pcm_bluetooth.c b/audio/pcm_bluetooth.c
index 2282b2e..1355066 100644
--- a/audio/pcm_bluetooth.c
+++ b/audio/pcm_bluetooth.c
@@ -750,6 +750,11 @@ static int bluetooth_poll_revents(snd_pcm_ioplug_t *io ATTRIBUTE_UNUSED,
 	return 0;
 }
 
+static int bluetooth_playback_poll_descriptors_count(snd_pcm_ioplug_t *io)
+{
+	return 2;
+}
+
 static int bluetooth_playback_poll_descriptors(snd_pcm_ioplug_t *io,
 					struct pollfd *pfd, unsigned int space)
 {
@@ -759,14 +764,17 @@ static int bluetooth_playback_poll_descriptors(snd_pcm_ioplug_t *io,
 
 	assert(data->pipefd[0] >= 0);
 
-	if (space < 1)
+	if (space < 2)
 		return 0;
 
 	pfd[0].fd = data->pipefd[0];
 	pfd[0].events = POLLIN;
 	pfd[0].revents = 0;
+	pfd[1].fd = data->stream.fd;
+	pfd[1].events = POLLERR | POLLHUP | POLLNVAL;
+	pfd[1].revents = 0;
 
-	return 1;
+	return 2;
 }
 
 static int bluetooth_playback_poll_revents(snd_pcm_ioplug_t *io,
@@ -779,14 +787,19 @@ static int bluetooth_playback_poll_revents(snd_pcm_ioplug_t *io,
 	DBG("");
 
 	assert(pfds);
-	assert(nfds == 1);
+	assert(nfds == 2);
 	assert(revents);
 	assert(pfds[0].fd >= 0);
+	assert(pfds[1].fd >= 0);
 
 	if (io->state != SND_PCM_STATE_PREPARED)
 		ret = read(pfds[0].fd, buf, 1);
 
-	*revents = (pfds[0].revents & ~POLLIN) | POLLOUT;
+	if (pfds[1].revents & (POLLERR | POLLHUP | POLLNVAL))
+		io->state = SND_PCM_STATE_DISCONNECTED;
+
+	revents[0] = (pfds[0].revents & ~POLLIN) | POLLOUT;
+	revents[1] = (pfds[1].revents & ~POLLIN);
 
 	return 0;
 }
@@ -1087,6 +1100,7 @@ static snd_pcm_ioplug_callback_t bluetooth_hsp_playback = {
 	.hw_params		= bluetooth_hsp_hw_params,
 	.prepare		= bluetooth_prepare,
 	.transfer		= bluetooth_hsp_write,
+	.poll_descriptors_count	= bluetooth_playback_poll_descriptors_count,
 	.poll_descriptors	= bluetooth_playback_poll_descriptors,
 	.poll_revents		= bluetooth_playback_poll_revents,
 	.delay			= bluetooth_playback_delay,
@@ -1112,6 +1126,7 @@ static snd_pcm_ioplug_callback_t bluetooth_a2dp_playback = {
 	.hw_params		= bluetooth_a2dp_hw_params,
 	.prepare		= bluetooth_prepare,
 	.transfer		= bluetooth_a2dp_write,
+	.poll_descriptors_count	= bluetooth_playback_poll_descriptors_count,
 	.poll_descriptors	= bluetooth_playback_poll_descriptors,
 	.poll_revents		= bluetooth_playback_poll_revents,
 	.delay			= bluetooth_playback_delay,

--------------010504060002070805020501
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--------------010504060002070805020501
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------010504060002070805020501--
