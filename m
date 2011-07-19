Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [RFC 04/19] avrcp: handle ListPlayerApplicationSettingValues pdu
Date: Tue, 19 Jul 2011 16:49:15 -0300
Message-Id: <1311104970-18600-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 56115df..cd3beb7 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -114,6 +114,7 @@
 /* PDU types for metadata transfer */
 #define AVRCP_GET_CAPABILITIES		0x10
 #define AVRCP_LIST_PLAYER_ATTRIBUTES	0X11
+#define AVRCP_LIST_PLAYER_VALUES	0x12
 
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
 #define CAP_COMPANY_ID		0x02
@@ -474,6 +475,22 @@ static void handle_panel_passthrough(struct control *control,
 						operands[0] & 0x7F, status);
 }
 
+static unsigned int setting_get_max_val(uint8_t setting)
+{
+	switch (setting) {
+	case (PLAYER_SETTING_EQUALIZER):
+		return EQUALIZER_MODE_ON;
+	case(PLAYER_SETTING_REPEAT):
+		return REPEAT_MODE_GROUP;
+	case(PLAYER_SETTING_SHUFFLE):
+		return SHUFFLE_MODE_GROUP;
+	case(PLAYER_SETTING_SCAN):
+		return SCAN_MODE_GROUP;
+	}
+
+	return 0;
+}
+
 /* handle vendordep pdu inside an avctp packet */
 static int handle_vendordep_pdu(struct control *control,
 					struct avrcp_header *avrcp,
@@ -551,6 +568,26 @@ static int handle_vendordep_pdu(struct control *control,
 
 		return AVRCP_HEADER_LENGTH +
 				AVRCP_SPECAVCPDU_HEADER_LENGTH + len + 1;
+	case AVRCP_LIST_PLAYER_VALUES:
+		if (len != 1 || avrcp->code != CTYPE_STATUS)
+			break;
+
+		len = setting_get_max_val(pdu->params[0]);
+		if (!len) {
+			error("Setting is invalid: %u", pdu->params[0]);
+			pdu->params[0] = E_INVALID_PARAM;
+			goto err_metadata;
+		}
+
+		for (i = 1; i <= len; i++)
+			pdu->params[i] = i;
+
+		avrcp->code = CTYPE_STABLE;
+		pdu->params[0] = len;
+		pdu->params_len = htons(len + 1);
+
+		return AVRCP_HEADER_LENGTH +
+				AVRCP_SPECAVCPDU_HEADER_LENGTH + len + 1;
 	}
 
 	/*
-- 
1.7.6

