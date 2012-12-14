Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
Subject: [PATCH 06/12] Bluetooth: Advertise controller data in broadcaster mode
Date: Fri, 14 Dec 2012 14:51:32 -0400
Message-Id: <1355511098-10190-7-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1355511098-10190-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1355511098-10190-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>

In broadcaster mode, the adapter must advertise the data set by user in
set_controller_data.

According to the spec, the flags field must be ommited if its value is zero.

Signed-off-by: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
---
 net/bluetooth/hci_core.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d015e1f..5ba9fad 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -654,6 +654,30 @@ static u8 create_ad(struct hci_dev *hdev, u8 *ptr)
 	return ad_len;
 }
 
+static u8 create_ad_broadcast(struct hci_dev *hdev, u8 *ptr)
+{
+	u16 len = 0;
+	struct broadcast_data *d;
+
+	list_for_each_entry(d, &hdev->broadcast_data, list) {
+		u8 entry_len = sizeof(d->length) + sizeof(d->type) + d->length;
+
+		if (len + entry_len > HCI_MAX_AD_LENGTH) {
+			BT_DBG("Controller data bigger than adv data slot");
+			return len;
+		}
+
+		ptr[0] = sizeof(d->type) + d->length;
+		ptr[1] = d->type;
+		memcpy(&ptr[2], d->data, d->length);
+
+		len += entry_len;
+		ptr += entry_len;
+	}
+
+	return len;
+}
+
 int hci_update_ad(struct hci_dev *hdev)
 {
 	struct hci_cp_le_set_adv_data cp;
@@ -669,7 +693,10 @@ int hci_update_ad(struct hci_dev *hdev)
 
 	memset(&cp, 0, sizeof(cp));
 
-	len = create_ad(hdev, cp.data);
+	if (test_bit(HCI_BROADCASTER, &hdev->dev_flags))
+		len = create_ad_broadcast(hdev, cp.data);
+	else
+		len = create_ad(hdev, cp.data);
 
 	if (hdev->adv_data_len == len &&
 	    memcmp(cp.data, hdev->adv_data, len) == 0) {
-- 
1.8.0.2

