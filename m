Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH] audio: Fix missing reply to Acquire in AVDTP
Date: Mon,  2 Jul 2012 17:16:11 +0200
Message-Id: <1341242171-20485-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Calling org.bluez.MediaEndpoint.Acquire ends in avdtp_start().
If bluez is acceptor of AVDTP_OPEN, then avdtp_start is delayed in a
timer in order to wait for the initiator to send AVDTP_START.
If the timer expires, avdtp_start() is called a second time and find
that Bluez is acceptor. This time, since a timer already exists, Bluez
does nothing and the answer to Acquire is never sent.
The idea of this patch is that if we get in the timeout, we will no longer
care whether we accepted open or not.
---
 audio/avdtp.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index 56a0905..e431ce8 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -3627,6 +3627,8 @@ static gboolean start_timeout(gpointer user_data)
 	struct avdtp_stream *stream = user_data;
 	struct avdtp *session = stream->session;
 
+	stream->open_acp = 0;
+
 	if (avdtp_start(session, stream) < 0)
 		error("wait_timeout: avdtp_start failed");
 
-- 
1.7.9.5

