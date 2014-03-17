Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 12/17] unit/test-avrcp: Fix invalid PDU for test /TP/PAS/BV-04-C
Date: Mon, 17 Mar 2014 15:07:58 +0200
Message-Id: <1395061683-17206-12-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
References: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

GetPlayerAttributeText needs at least one parameter otherwise it can be
considered invalid.
---
 unit/test-avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index b443a40..a49a0a2 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -670,7 +670,7 @@ int main(int argc, char *argv[])
 			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
 				0x00, 0x19, 0x58,
 				AVRCP_GET_PLAYER_ATTRIBUTE_TEXT,
-				0x00, 0x00, 0x00),
+				0x00, 0x00, 0x01, 0x00),
 			raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
 				0x00, 0x19, 0x58,
 				AVRCP_GET_PLAYER_ATTRIBUTE_TEXT,
-- 
1.8.5.3

