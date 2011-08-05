Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 17/23] avrcp: handle query for supported events
Date: Fri,  5 Aug 2011 15:15:26 -0300
Message-Id: <1312568132-21112-17-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 00cd192..f627861 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -132,6 +132,7 @@
 
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
 #define CAP_COMPANY_ID		0x02
+#define CAP_EVENTS_SUPPORTED	0x03
 
 #define QUIRK_NO_RELEASE	1 << 0
 
@@ -854,6 +855,13 @@ static int avrcp_handle_get_capabilities(struct control *control,
 		pdu->params[1] = G_N_ELEMENTS(company_ids);
 
 		return 2 + (3 * G_N_ELEMENTS(company_ids));
+	case CAP_EVENTS_SUPPORTED:
+		pdu->params_len = htons(4);
+		pdu->params[1] = 2;
+		pdu->params[2] = AVRCP_EVENT_PLAYBACK_STATUS_CHANGED;
+		pdu->params[3] = AVRCP_EVENT_TRACK_CHANGED;
+
+		return 4;
 	}
 
 err:
-- 
1.7.6

