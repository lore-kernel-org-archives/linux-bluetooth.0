Return-Path: <colin.king@canonical.com>
From: Colin King <colin.king@canonical.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btqca: remove null checks on edl->data as it is an array
Date: Tue,  6 Sep 2016 13:15:49 +0100
Message-Id: <20160906121549.14144-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

edl->data is an array of __u8 so the null check is unneccessary,
so remove it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/bluetooth/btqca.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 4a62081..28afd5d 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -55,8 +55,8 @@ static int rome_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
 	}
 
 	edl = (struct edl_event_hdr *)(skb->data);
-	if (!edl || !edl->data) {
-		BT_ERR("%s: TLV with no header or no data", hdev->name);
+	if (!edl) {
+		BT_ERR("%s: TLV with no header", hdev->name);
 		err = -EILSEQ;
 		goto out;
 	}
@@ -224,8 +224,8 @@ static int rome_tlv_send_segment(struct hci_dev *hdev, int idx, int seg_size,
 	}
 
 	edl = (struct edl_event_hdr *)(skb->data);
-	if (!edl || !edl->data) {
-		BT_ERR("%s: TLV with no header or no data", hdev->name);
+	if (!edl) {
+		BT_ERR("%s: TLV with no header", hdev->name);
 		err = -EILSEQ;
 		goto out;
 	}
-- 
2.9.3
