Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Jul 2015 16:25:30 -0400
From: Chris Mason <clm@fb.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH v2] Bluetooth: btbcm: allow btbcm_read_verbose_config to fail
 on Apple
Message-ID: <20150714202530.GD27622@ret.masoncoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Commit 1c8ba6d013 moved around the setup code for broadcomm chips,
and also added btbcm_read_verbose_config() to read extra information
about the hardware.  It's returning errors on some macbooks:

Bluetooth: hci0: BCM: Read verbose config info failed (-16)

Which makes us error out of the setup function.  Since this
probe isn't critical to operate the chip, this patch just changes
things to carry on when it fails.

Signed-off-by: Chris Mason <clm@fb.com>
cc: stable@vger.kernel.org # v4.1

---
 v2 Add stable cc
 drivers/bluetooth/btbcm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 4bba866..3f146c9 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -378,12 +378,11 @@ int btbcm_setup_apple(struct hci_dev *hdev)
 
 	/* Read Verbose Config Version Info */
 	skb = btbcm_read_verbose_config(hdev);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	BT_INFO("%s: BCM: chip id %u build %4.4u", hdev->name, skb->data[1],
-		get_unaligned_le16(skb->data + 5));
-	kfree_skb(skb);
+	if (!IS_ERR(skb)) {
+		BT_INFO("%s: BCM: chip id %u build %4.4u", hdev->name, skb->data[1],
+			get_unaligned_le16(skb->data + 5));
+		kfree_skb(skb);
+	}
 
 	set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 
-- 
2.4.5
