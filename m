Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] mgmtops: Fix calling btd_adapter_start() for an off adapter
Date: Fri,  6 Jul 2012 15:47:28 -0300
Message-Id: <1341600448-26310-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the adapter mode is off and the controller is down, we should
not consider that the adapter is powered up.
---
 plugins/mgmtops.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index c060ada..4c86389 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1074,7 +1074,7 @@ static void read_info_complete(int sk, uint16_t index, void *buf, size_t len)
 
 	if (mode != MODE_OFF && !mgmt_powered(info->current_settings))
 		mgmt_set_powered(index, TRUE);
-	else {
+	else if (mode != MODE_OFF) {
 		get_connections(sk, index);
 		btd_adapter_start(adapter);
 	}
-- 
1.7.10.4

