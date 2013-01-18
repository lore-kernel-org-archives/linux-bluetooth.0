Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ] avrcp: Ignore MSB of Absolute Volume parameter
Date: Fri, 18 Jan 2013 16:25:20 -0300
Message-Id: <1358537120-7955-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to the Section 6.13.1 of the AVRCP 1.5 specification document,
the most significant bit of the Absolute Volume parameter is reserved
for future additions, so it should be ignored when parsing parameters of
the SetAbsoluteVolume command. This is also necessary to pass PTS test
TC_TG_VLH_BI_02_C.
---
 profiles/audio/avrcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 636d3e4..237f176 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1398,11 +1398,13 @@ static uint8_t avrcp_handle_set_absolute_volume(struct avrcp *session,
 {
 	struct avrcp_player *player = session->player;
 	uint16_t len = ntohs(pdu->params_len);
+	uint8_t volume;
 
 	if (len != 1)
 		goto err;
 
-	if (pdu->params[0] > 127)
+	volume = pdu->params[0] & 0x7F;
+	if (volume > 127)
 		goto err;
 
 	if (!player)
-- 
1.7.11.7

