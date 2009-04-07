Return-Path: <cyrus@holtmann.org>
From: "Xu, Martin" <martin.xu@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 7 Apr 2009 09:32:34 +0800
Subject: patch to fix a2dp issue
Message-ID: <9F0C1DB20AFA954FA1DA05309350433D5B0B91CC@pdsmsx503.ccr.corp.intel.com>
References: <1238730552-3765-1-git-send-email-forrest.zhao@gmail.com>
	 <20090403201207.GA8156@jh-x301>
 <ac8af0be0904031748u4b109e11kb78a1db3d50ead71@mail.gmail.com>
In-Reply-To: <ac8af0be0904031748u4b109e11kb78a1db3d50ead71@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi:
We have found a2dp issue, that bluez earphone can not work. The issue has filed at: 
https://bugzilla.moblin.org/show_bug.cgi?id=1355 
(Some one can kindly tell me where I can file the bluez bug. So I can transfer the bug from moblin bugzilla there.)

The root cause is that:
bluez-alsa-plugin has issue at poll revents.
alsa lib needs to poll 2 channel state. But bluez-alsa-plugin only handles
channel1 revent, and leave another one unhandled which leads to the channel's
poll state unpredictable, consequently, pcm stream transfer is broken for the
wront poll state, and bluethooh earphone(a2dp) can not work.
I have worked out a patch to fix the issue, which is listed as below. 
BTW: 
I found the issue at bluez-4.30 but I find that the latest bluez git tree still has the issue.
I just touch bluez, if something not accurate, please let me know. ;)

diff --git a/audio/pcm_bluetooth.c b/audio/pcm_bluetooth.c
index 9bef89e..1af07b3 100644
--- a/audio/pcm_bluetooth.c
+++ b/audio/pcm_bluetooth.c
@@ -798,7 +798,7 @@ static int bluetooth_playback_poll_revents(snd_pcm_ioplug_t *io,
 		io->state = SND_PCM_STATE_DISCONNECTED;
 
 	*revents = (pfds[0].revents & POLLIN) ? POLLOUT : 0;
-
+	*(revents+1) = (pfds[1].revents & POLLIN) ? POLLOUT : 0;
 	return 0;
 }
