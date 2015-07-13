Return-Path: <cyrus@holtmann.org>
From: sy39.ju@samsung.com
To: linux-bluetooth@vger.kernel.org
Cc: Seungyoun Ju <sy39.ju@samsung.com>
Subject: [PATCH] Bluetooth: hci_check_conn_params() check proper range
Date: Mon, 13 Jul 2015 17:28:13 +0900
Message-Id: <1436776093-12090-1-git-send-email-sy39.ju@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Seungyoun Ju <sy39.ju@samsung.com>

Slave latency range has been changed in Core Spec. 4.2 by Erratum 5419
of ESR08_V1.0.0. And it should be applied to Core Spec. 4.0 and 4.1.

Before:
   connSlaveLatency <= ((connSupervisionTimeout / connIntervalMax) - 1)

After:
   connSlaveLatency <= ((connSupervisionTimeout / (connIntervalMax*2)) - 1)

This patch makes hci_check_conn_params() check the allowable slave
latency range using the changed way.

Signed-off-by: Seungyoun Ju <sy39.ju@samsung.com>
---
 include/net/bluetooth/hci_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3bd618d..2a6b091 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1297,7 +1297,7 @@ static inline int hci_check_conn_params(u16 min, u16 max, u16 latency,
 	if (max >= to_multiplier * 8)
 		return -EINVAL;
 
-	max_latency = (to_multiplier * 8 / max) - 1;
+	max_latency = (to_multiplier * 4 / max) - 1;
 	if (latency > 499 || latency > max_latency)
 		return -EINVAL;
 
-- 
2.1.0

