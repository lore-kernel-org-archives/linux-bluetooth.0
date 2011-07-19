Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [RFC 03/19] avrcp: handle ListPlayerApplicationSettingAttributes pdu
Date: Tue, 19 Jul 2011 16:49:14 -0300
Message-Id: <1311104970-18600-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 905f57a..56115df 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -113,6 +113,7 @@
 
 /* PDU types for metadata transfer */
 #define AVRCP_GET_CAPABILITIES		0x10
+#define AVRCP_LIST_PLAYER_ATTRIBUTES	0X11
 
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
 #define CAP_COMPANY_ID		0x02
@@ -529,6 +530,27 @@ static int handle_vendordep_pdu(struct control *control,
 
 		pdu->params[0] = E_INVALID_PARAM;
 		goto err_metadata;
+	case AVRCP_LIST_PLAYER_ATTRIBUTES:
+		if (len != 0 || avrcp->code != CTYPE_STATUS)
+			break;
+
+		for (i = 1; i <= PLAYER_SETTING_SCAN; i++) {
+			if (!control->player_setting[i]) {
+				DBG("Ignoring setting %u since value"
+						"has never never been set", i);
+				continue;
+			}
+
+			len++;
+			pdu->params[len] = i;
+		}
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

