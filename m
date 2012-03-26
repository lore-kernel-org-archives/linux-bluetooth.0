Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Don't increment twice in eir_has_data_type()
Date: Mon, 26 Mar 2012 14:21:41 +0300
Message-Id: <1332760902-16071-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The parsed variable is already incremented inside the for-loop so there
no need to increment it again (not to mention that the code was
incrementing it the wrong amount).

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8dc07fa..83cd301 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -911,11 +911,10 @@ static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 status,
 
 static inline bool eir_has_data_type(u8 *data, size_t data_len, u8 type)
 {
-	u8 field_len;
-	size_t parsed;
+	size_t parsed = 0;
 
-	for (parsed = 0; parsed < data_len - 1; parsed += field_len) {
-		field_len = data[0];
+	while (parsed < data_len - 1) {
+		u8 field_len = data[0];
 
 		if (field_len == 0)
 			break;
-- 
1.7.9.1

