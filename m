Return-Path: <cyrus@holtmann.org>
Date: Thu, 22 Jan 2015 02:41:30 +0200
From: Jukka Kinnunen <jukka.kinnunen@iki.fi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] tools/btsnoop: Fix opcode for SCO TX packet
Message-ID: <20150122004130.GA4545@mail.example1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btsnoop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btsnoop.c b/tools/btsnoop.c
index 71191eb..3eb8082 100644
--- a/tools/btsnoop.c
+++ b/tools/btsnoop.c
@@ -230,7 +230,7 @@ next_packet:
 		if (flags & 0x01)
 			opcode = BTSNOOP_OPCODE_SCO_RX_PKT;
 		else
-			opcode = BTSNOOP_OPCODE_ACL_TX_PKT;
+			opcode = BTSNOOP_OPCODE_SCO_TX_PKT;
 		break;
 	case 0x04:
 		opcode = BTSNOOP_OPCODE_EVENT_PKT;
-- 
1.9.1

