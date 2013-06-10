Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/15] AVRCP: Fix setting reserved bit in GetCapabilities response
Date: Mon, 10 Jun 2013 13:37:03 +0300
Message-Id: <1370860630-30359-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
References: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

EventID 0x00 is reserved:

< ACL data: handle 12 flags 0x00 dlen 25
    L2CAP(d): cid 0x0541 len 21 [psm 23]
      AVCTP Control: Response : pt 0x00 transaction 2 pid 0x110e
        AV/C: Stable: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: GetCapabilities: pt Single len 0x0008
            CapabilityID: 0x03 (EventsID)
            CapabilityCount: 0x06
            EventsID: 0x00 (Reserved)
            EventsID: 0x01 (EVENT_PLAYBACK_STATUS_CHANGED)
            EventsID: 0x02 (EVENT_TRACK_CHANGED)
            EventsID: 0x03 (EVENT_TRACK_REACHED_END)
            EventsID: 0x04 (EVENT_TRACK_REACHED_START)
            EventsID: 0x08 (EVENT_PLAYER_APPLICATION_SETTING_CHANGED)
---
 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 45ca490..78d0fa2 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -897,7 +897,7 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp *session,
 
 		return AVC_CTYPE_STABLE;
 	case CAP_EVENTS_SUPPORTED:
-		for (i = 0; i <= AVRCP_EVENT_LAST; i++) {
+		for (i = 1; i <= AVRCP_EVENT_LAST; i++) {
 			if (session->supported_events & (1 << i)) {
 				pdu->params[1]++;
 				pdu->params[pdu->params[1] + 1] = i;
-- 
1.8.1.4

