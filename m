Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ v2] mgmtops: Fix calling btd_adapter_start() for an off adapter
Date: Fri,  6 Jul 2012 17:26:58 -0300
Message-Id: <1341606418-12257-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the adapter mode is off and the controller is down, we should
not consider that the adapter is powered up.
---
 plugins/mgmtops.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index c060ada..27cec09 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1072,11 +1072,12 @@ static void read_info_complete(int sk, uint16_t index, void *buf, size_t len)
 		return;
 	}
 
-	if (mode != MODE_OFF && !mgmt_powered(info->current_settings))
-		mgmt_set_powered(index, TRUE);
-	else {
-		get_connections(sk, index);
-		btd_adapter_start(adapter);
+	if (mode != MODE_OFF) {
+		if (mgmt_powered(info->current_settings)) {
+			get_connections(sk, index);
+			btd_adapter_start(adapter);
+		} else
+			mgmt_set_powered(index, TRUE);
 	}
 
 	btd_adapter_unref(adapter);
-- 
1.7.10.4

