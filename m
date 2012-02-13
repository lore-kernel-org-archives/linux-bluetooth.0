Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] mgmtops: Improve event size mismatch messages
Date: Mon, 13 Feb 2012 09:12:25 -0400
Message-Id: <1329138745-15423-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes them consistent, and updates the function names.
---
 plugins/mgmtops.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 7e47386..952ccf3 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -367,7 +367,7 @@ static void mgmt_new_link_key(int sk, uint16_t index, void *buf, size_t len)
 	struct controller_info *info;
 
 	if (len != sizeof(*ev)) {
-		error("new_key event size mismatch (%zu != %zu)",
+		error("mgmt_new_link_key event size mismatch (%zu != %zu)",
 							len, sizeof(*ev));
 		return;
 	}
@@ -1071,7 +1071,8 @@ static void read_local_oob_data_complete(int sk, uint16_t index, void *buf,
 	struct btd_adapter *adapter;
 
 	if (len != sizeof(*rp)) {
-		error("Wrong read_local_oob_data_complete event size");
+		error("read_local_oob_data_complete event size mismatch "
+					"(%zu != %zu)", len, sizeof(*rp));
 		return;
 	}
 
@@ -1313,7 +1314,7 @@ static void mgmt_device_found(int sk, uint16_t index, void *buf, size_t len)
 
 	eir_len = bt_get_le16(&ev->eir_len);
 	if (len != sizeof(*ev) + eir_len) {
-		error("mgmt_device_found length %zu instead of expected %zu",
+		error("mgmt_device_found event size mismatch (%zu != %zu)",
 						len, sizeof(*ev) + eir_len);
 		return;
 	}
@@ -1445,7 +1446,7 @@ static void mgmt_new_ltk(int sk, uint16_t index, void *buf, size_t len)
 	struct controller_info *info;
 
 	if (len != sizeof(*ev)) {
-		error("new_smp_key event size mismatch (%zu != %zu)",
+		error("mgmt_new_ltk event size mismatch (%zu != %zu)",
 							len, sizeof(*ev));
 		return;
 	}
-- 
1.7.5.4

