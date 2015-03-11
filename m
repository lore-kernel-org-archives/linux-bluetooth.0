Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] audio/avctp: Cancel outgoing connection in case of conflict
Date: Wed, 11 Mar 2015 19:11:02 +0100
Message-Id: <1426097463-5288-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1426097463-5288-1-git-send-email-marcin.kraglak@tieto.com>
References: <1426097463-5288-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to AVRCP Spec 1.5 AVCTP channel should be closed if both
sides try establish connection at the same time.
---
 profiles/audio/avctp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 14b0266..22bf35b 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1351,6 +1351,13 @@ static void avctp_control_confirm(struct avctp *session, GIOChannel *chan,
 	if (session->control != NULL) {
 		error("Control: Refusing unexpected connect");
 		g_io_channel_shutdown(chan, TRUE, NULL);
+
+		/*
+		 * Close AVCTP channel if remote tried connect
+		 * at the same time
+		 * AVRCP SPEC V1.5 4.1.1 Connection Establishment
+		 */
+		avctp_set_state(session, AVCTP_STATE_DISCONNECTED, -EAGAIN);
 		return;
 	}
 
-- 
2.1.0

