Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] avrcp: do not get fd when not connected
Date: Thu, 25 Aug 2011 14:33:08 -0300
Message-Id: <1314293588-29190-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 882c9fb..9990b06 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -727,7 +727,7 @@ static int avctp_send_event(struct control *control, uint8_t id, void *data)
 	struct avrcp_header *avrcp = (void *) &buf[AVCTP_HEADER_LENGTH];
 	struct avrcp_spec_avc_pdu *pdu = (void *) &buf[AVCTP_HEADER_LENGTH +
 							AVRCP_HEADER_LENGTH];
-	int sk = g_io_channel_unix_get_fd(control->io);
+	int sk;
 	uint16_t size;
 
 	if (control->state != AVCTP_STATE_CONNECTED)
@@ -783,6 +783,8 @@ static int avctp_send_event(struct control *control, uint8_t id, void *data)
 	size += AVCTP_HEADER_LENGTH + AVRCP_HEADER_LENGTH +
 					AVRCP_SPECAVCPDU_HEADER_LENGTH;
 
+	sk = g_io_channel_unix_get_fd(control->io);
+
 	if (write(sk, buf, size) < 0)
 		return -errno;
 
-- 
1.7.6

