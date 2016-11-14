Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/adapter: Fix using wrong address type to listen ATT
Date: Mon, 14 Nov 2016 13:30:09 +0200
Message-Id: <1479123009-7190-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bdaddr_type shall only matter for controllers supporting LE otherwise
it may cause BDADDR_BREDR to be used for things like LE ATT socket
listen breaking reconnections.
---
 src/adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index b81b4e8..b134709 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -8085,7 +8085,7 @@ static void read_info_complete(uint8_t status, uint16_t length,
 		}
 	} else {
 		bacpy(&adapter->bdaddr, &rp->bdaddr);
-		if (adapter->supported_settings & MGMT_SETTING_BREDR)
+		if (!(adapter->supported_settings & MGMT_SETTING_LE))
 			adapter->bdaddr_type = BDADDR_BREDR;
 		else
 			adapter->bdaddr_type = BDADDR_LE_PUBLIC;
-- 
2.7.4

