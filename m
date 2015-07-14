Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Jul 2015 15:16:12 -0400
From: Chris Mason <clm@fb.com>
To: <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH] I have no idea what I'm doing
Message-ID: <20150714191612.GA27622@ret.masoncoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

I upgraded my macbook from 4.0.2 to 4.1.2, and now I get
messages similar to this bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=100651

and this one:

https://bugzilla.kernel.org/show_bug.cgi?id=101171

[21552.711888] Bluetooth: hci0: BCM: Read verbose config info failed (-16)
[21728.019676] Bluetooth: hci0: BCM: Read verbose config info failed (-16)

A little poking around shows you recently added this check, and from
what I can tell with grep and friends the btbcm_read_verbose_config()
function is completely new?  I don't see similar reads being done by
older kernels.

So, I pushed some code around.  It does compile, but printk proves that
only the second hunk is happening on my box, so testing is somewhat
light.

With this applied, I'm able to use bluetooth again.

Signed-off-by: Chris Mason <clm@fb.com>

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 4bba866..90e7099 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -294,11 +294,10 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 
 	/* Read Verbose Config Version Info */
 	skb = btbcm_read_verbose_config(hdev);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	BT_INFO("%s: BCM: chip id %u", hdev->name, skb->data[1]);
-	kfree_skb(skb);
+	if (!IS_ERR(skb)) {
+		BT_INFO("%s: BCM: chip id %u", hdev->name, skb->data[1]);
+		kfree_skb(skb);
+	}
 
 	switch ((rev & 0xf000) >> 12) {
 	case 0:
@@ -378,12 +377,11 @@ int btbcm_setup_apple(struct hci_dev *hdev)
 
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
 
