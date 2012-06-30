Return-Path: <cyrus@holtmann.org>
Message-ID: <4FEE80B4.6060609@gmail.com>
Date: Sat, 30 Jun 2012 12:29:40 +0800
From: Vic Lee <llyzs.vic@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] audio: returns error if poll_revents failed.
Content-Type: multipart/mixed;
 boundary="------------050301090003010709040802"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------050301090003010709040802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------050301090003010709040802
Content-Type: text/x-patch;
 name="0001-audio-returns-error-if-poll_revents-failed.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-audio-returns-error-if-poll_revents-failed.patch"

>From a79537c26867fd92f32e77a6fe59bf0e1dd61c11 Mon Sep 17 00:00:00 2001
From: Vic Lee <llyzs@163.com>
Date: Sat, 30 Jun 2012 20:16:18 +0800
Subject: [PATCH] audio: returns error if poll_revents failed.

Error must be reported back to ALSA if poll_revents failed. Otherwise,
when the bluetooth audio device is disconnected during playback, ALSA
will enter in an infinite loop, bluez will keep printing "read error",
and application freezes.

Signed-off-by: Vic Lee <llyzs@163.com>
---
 audio/pcm_bluetooth.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/audio/pcm_bluetooth.c b/audio/pcm_bluetooth.c
index b9da805..ca5ff11 100644
--- a/audio/pcm_bluetooth.c
+++ b/audio/pcm_bluetooth.c
@@ -821,6 +821,7 @@ static int bluetooth_playback_poll_revents(snd_pcm_ioplug_t *io,
 					unsigned short *revents)
 {
 	static char buf[1];
+	int err = 0;
 
 	DBG("");
 
@@ -832,14 +833,17 @@ static int bluetooth_playback_poll_revents(snd_pcm_ioplug_t *io,
 
 	if (io->state != SND_PCM_STATE_PREPARED)
 		if (read(pfds[0].fd, buf, 1) < 0)
+		{
 			SYSERR("read error: %s (%d)", strerror(errno), errno);
+			err = -1;
+		}
 
 	if (pfds[1].revents & (POLLERR | POLLHUP | POLLNVAL))
 		io->state = SND_PCM_STATE_DISCONNECTED;
 
 	*revents = (pfds[0].revents & POLLIN) ? POLLOUT : 0;
 
-	return 0;
+	return err;
 }
 
 
-- 
1.7.10


--------------050301090003010709040802--
