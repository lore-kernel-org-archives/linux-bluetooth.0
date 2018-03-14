Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] shared/gatt-client: Fix attempting to discovery with handle 0
Date: Wed, 14 Mar 2018 15:17:26 +0200
Message-Id: <20180314131726.24945-3-luiz.dentz@gmail.com>
In-Reply-To: <20180314131726.24945-1-luiz.dentz@gmail.com>
References: <20180314131726.24945-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If a service was removed an no other service was added it may happen
that pending_svc has not empty but first_svc and last_svc has not been
set causing the following request:

< ACL Data TX: Handle 76 flags 0x00 dlen 11
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0000-0x0000
        Attribute type: Include (0x2802)
---
 src/shared/gatt-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index c369ccb40..e1d489d32 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -988,7 +988,7 @@ static void discover_secondary_cb(bool success, uint8_t att_ecode,
 	}
 
 next:
-	if (queue_isempty(op->pending_svcs))
+	if (queue_isempty(op->pending_svcs) || !op->svc_first)
 		goto done;
 
 	client->discovery_req = bt_gatt_discover_included_services(client->att,
-- 
2.14.3

