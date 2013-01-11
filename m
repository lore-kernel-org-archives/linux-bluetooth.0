Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: vinicius.gomes@openbossa.org, claudio.takahasi@openbossa.org,
	luiz.von.dentz@intel.com,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 03/11] avrcp: Add EVENT_VOLUME_CHANGED to CT capabilities
Date: Fri, 11 Jan 2013 17:25:26 -0300
Message-Id: <1357935934-20033-4-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1357935934-20033-1-git-send-email-jprvita@openbossa.org>
References: <1357935934-20033-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/audio/avrcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index ef324b0..bb8ab24 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2164,6 +2164,9 @@ static void session_ct_init(struct avrcp *session)
 
 	session->control_handlers = ct_control_handlers;
 
+	if (session->version >= 0x0104)
+		session->supported_events = (1 << AVRCP_EVENT_VOLUME_CHANGED);
+
 	DBG("%p version 0x%04x", session, session->version);
 
 	session->control_id = avctp_register_pdu_handler(session->conn,
-- 
1.7.11.7

