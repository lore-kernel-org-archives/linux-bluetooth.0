Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 13/15] AVRCP: Fix sending SetPlayerApplicationSettingValue using notify command type
Date: Mon, 10 Jun 2013 13:37:08 +0300
Message-Id: <1370860630-30359-13-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
References: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The command type for SetPlayerApplicationSettingValue is control
---
 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 7eaadf4..515303e 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2230,7 +2230,7 @@ static void avrcp_set_player_value(struct avrcp *session, uint8_t attr,
 
 	length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
 
-	avctp_send_vendordep_req(session->conn, AVC_CTYPE_NOTIFY,
+	avctp_send_vendordep_req(session->conn, AVC_CTYPE_CONTROL,
 					AVC_SUBUNIT_PANEL, buf, length,
 					avrcp_player_value_rsp, session);
 }
-- 
1.8.1.4

