Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] Fix regression when disconnecting AVRCP
Date: Mon,  3 Oct 2011 17:57:50 +0300
Message-Id: <1317653871-14689-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This prevent to disconnect AVRCP when doing e.g. Audio.Disconnect
---
 audio/avctp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index e9b8e40..b8cb36e 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -1021,7 +1021,7 @@ struct avctp *avctp_connect(const bdaddr_t *src, const bdaddr_t *dst)
 
 void avctp_disconnect(struct avctp *session)
 {
-	if (session->io)
+	if (!session->io)
 		return;
 
 	avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
-- 
1.7.6.2

