Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio/AVRCP: Fix sending invalid response to GetCapabilities
Date: Tue, 28 Jan 2014 12:05:34 -0800
Message-Id: <1390939534-15699-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The attribute count has to be initialized with 0 since we reuse the same
buffer for both command and responses it may be already be set causing
invalid response to be generated.
---
 profiles/audio/avrcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 59a966e..ad5dc34 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -921,6 +921,7 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp *session,
 
 		return AVC_CTYPE_STABLE;
 	case CAP_EVENTS_SUPPORTED:
+		pdu->params[1] = 0;
 		for (i = 1; i <= AVRCP_EVENT_LAST; i++) {
 			if (session->supported_events & (1 << i)) {
 				pdu->params[1]++;
-- 
1.8.4.2

