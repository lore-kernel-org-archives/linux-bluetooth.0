Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [RFC 07/19] avrcp: handle commands for future extension
Date: Tue, 19 Jul 2011 16:49:18 -0300
Message-Id: <1311104970-18600-8-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

AVRCP_GET_PLAYER_ATTRIBUTE_TEXT and AVRCP_GET_PLAYER_VALUE_TEXT shall
only be used if TG has extended attributes.

For the ones defined in AVRCP spec these commands should not be called.
Since we do not have extended attributes yet we can ignore those
commands.
---
 audio/control.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 2d6d9e6..36f727f 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -117,6 +117,8 @@
 #define AVRCP_LIST_PLAYER_VALUES	0x12
 #define AVRCP_GET_CURRENT_PLAYER_VALUE	0x13
 #define AVRCP_SET_PLAYER_VALUE		0x14
+#define AVRCP_GET_PLAYER_ATTRIBUTE_TEXT	0x15
+#define AVRCP_GET_PLAYER_VALUE_TEXT	0x16
 
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
 #define CAP_COMPANY_ID		0x02
@@ -824,6 +826,20 @@ static int handle_vendordep_pdu(struct control *control,
 		}
 
 		break;
+	case AVRCP_GET_PLAYER_ATTRIBUTE_TEXT:
+	case AVRCP_GET_PLAYER_VALUE_TEXT:
+		if (avrcp->code != CTYPE_STATUS)
+			break;
+
+		/*
+		 * As per sec. 5.2.5 of AVRCP 1.3 spec, this command is
+		 * expected to be used only for extended attributes, i.e.
+		 * custom attributes defined by the application. As we
+		 * currently don't have any such attribute, we respond with
+		 * invalid param id.
+		 */
+		pdu->params[0] = E_INVALID_PARAM;
+		goto err_metadata;
 	}
 
 	/*
-- 
1.7.6

