Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4] Bluetooth: Fix calls to __hci_cmd_sync()
Date: Tue, 12 May 2015 12:11:43 +0200
Message-Id: <1431425503-9120-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove test of command reply status as it is already performed by
__hci_cmd_sync().

__hci_cmd_sync_ev() function already returns an error if it got a
non-zero status either through a Command Complete or a Command
Status event.

For both of these events the status is collected up in the event
handlers called by hci_event_packet() and then passed as the second
parameter to req_complete_skb(). The req_complete_skb() callback in
turn is hci_req_sync_complete() for __hci_cmd_sync_ev() which stores
the status in hdev->req_result. The hdev->req_result is then further
converted through bt_to_errno() back in __hci_cmd_sync_ev().

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/btbcm.c   |  6 -----
 drivers/bluetooth/btintel.c |  6 -----
 drivers/bluetooth/btusb.c   | 53 +++------------------------------------------
 net/bluetooth/hci_core.c    |  5 -----
 4 files changed, 3 insertions(+), 67 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 4bba866..728fce3 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -55,12 +55,6 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 	}
 
 	bda = (struct hci_rp_read_bd_addr *)skb->data;
-	if (bda->status) {
-		BT_ERR("%s: BCM: Device address result failed (%02x)",
-		       hdev->name, bda->status);
-		kfree_skb(skb);
-		return -bt_to_errno(bda->status);
-	}
 
 	/* The address 00:20:70:02:A0:00 indicates a BCM20702A0 controller
 	 * with no configured address.
diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 2d43d42..828f2f8 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -53,12 +53,6 @@ int btintel_check_bdaddr(struct hci_dev *hdev)
 	}
 
 	bda = (struct hci_rp_read_bd_addr *)skb->data;
-	if (bda->status) {
-		BT_ERR("%s: Intel device address result failed (%02x)",
-		       hdev->name, bda->status);
-		kfree_skb(skb);
-		return -bt_to_errno(bda->status);
-	}
 
 	/* For some Intel based controllers, the default Bluetooth device
 	 * address 00:03:19:9E:8B:00 can be found. These controllers are
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d21f3b4..2de1b56 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1403,7 +1403,6 @@ static int rtl_read_rom_version(struct hci_dev *hdev, u8 *version)
 {
 	struct rtl_rom_version_evt *rom_version;
 	struct sk_buff *skb;
-	int ret;
 
 	/* Read RTL ROM version command */
 	skb = __hci_cmd_sync(hdev, 0xfc6d, 0, NULL, HCI_INIT_TIMEOUT);
@@ -1423,12 +1422,10 @@ static int rtl_read_rom_version(struct hci_dev *hdev, u8 *version)
 	BT_INFO("%s: rom_version status=%x version=%x",
 		hdev->name, rom_version->status, rom_version->version);
 
-	ret = rom_version->status;
-	if (ret == 0)
-		*version = rom_version->version;
+	*version = rom_version->version;
 
 	kfree_skb(skb);
-	return ret;
+	return 0;
 }
 
 static int rtl8723b_parse_firmware(struct hci_dev *hdev, u16 lmp_subver,
@@ -1587,7 +1584,6 @@ static int rtl_download_firmware(struct hci_dev *hdev,
 		return -ENOMEM;
 
 	for (i = 0; i < frag_num; i++) {
-		struct rtl_download_response *dl_resp;
 		struct sk_buff *skb;
 
 		BT_DBG("download fw (%d/%d)", i, frag_num);
@@ -1609,7 +1605,7 @@ static int rtl_download_firmware(struct hci_dev *hdev,
 			goto out;
 		}
 
-		if (skb->len != sizeof(*dl_resp)) {
+		if (skb->len != sizeof(struct rtl_download_response)) {
 			BT_ERR("%s: download fw event length mismatch",
 			       hdev->name);
 			kfree_skb(skb);
@@ -1617,13 +1613,6 @@ static int rtl_download_firmware(struct hci_dev *hdev,
 			goto out;
 		}
 
-		dl_resp = (struct rtl_download_response *)skb->data;
-		if (dl_resp->status != 0) {
-			kfree_skb(skb);
-			ret = bt_to_errno(dl_resp->status);
-			goto out;
-		}
-
 		kfree_skb(skb);
 		data += RTL_FRAG_LEN;
 	}
@@ -1948,12 +1937,6 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	}
 
 	ver = (struct intel_version *)skb->data;
-	if (ver->status) {
-		BT_ERR("%s Intel fw version event failed (%02x)", hdev->name,
-		       ver->status);
-		kfree_skb(skb);
-		return -bt_to_errno(ver->status);
-	}
 
 	BT_INFO("%s: read Intel version: %02x%02x%02x%02x%02x%02x%02x%02x%02x",
 		hdev->name, ver->hw_platform, ver->hw_variant,
@@ -2001,15 +1984,6 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 		return PTR_ERR(skb);
 	}
 
-	if (skb->data[0]) {
-		u8 evt_status = skb->data[0];
-
-		BT_ERR("%s enable Intel manufacturer mode event failed (%02x)",
-		       hdev->name, evt_status);
-		kfree_skb(skb);
-		release_firmware(fw);
-		return -bt_to_errno(evt_status);
-	}
 	kfree_skb(skb);
 
 	disable_patch = 1;
@@ -2355,13 +2329,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	}
 
 	ver = (struct intel_version *)skb->data;
-	if (ver->status) {
-		BT_ERR("%s: Intel version command failure (%02x)",
-		       hdev->name, ver->status);
-		err = -bt_to_errno(ver->status);
-		kfree_skb(skb);
-		return err;
-	}
 
 	/* The hardware platform number has a fixed value of 0x37 and
 	 * for now only accept this single value.
@@ -2436,13 +2403,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	}
 
 	params = (struct intel_boot_params *)skb->data;
-	if (params->status) {
-		BT_ERR("%s: Intel boot parameters command failure (%02x)",
-		       hdev->name, params->status);
-		err = -bt_to_errno(params->status);
-		kfree_skb(skb);
-		return err;
-	}
 
 	BT_INFO("%s: Device revision is %u", hdev->name,
 		le16_to_cpu(params->dev_revid));
@@ -2675,13 +2635,6 @@ static void btusb_hw_error_intel(struct hci_dev *hdev, u8 code)
 		return;
 	}
 
-	if (skb->data[0] != 0x00) {
-		BT_ERR("%s: Exception info command failure (%02x)",
-		       hdev->name, skb->data[0]);
-		kfree_skb(skb);
-		return;
-	}
-
 	BT_ERR("%s: Exception info %s", hdev->name, (char *)(skb->data + 1));
 
 	kfree_skb(skb);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 476709b..1183eba 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -94,7 +94,6 @@ static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
 	char buf[32];
 	size_t buf_size = min(count, (sizeof(buf)-1));
 	bool enable;
-	int err;
 
 	if (!test_bit(HCI_UP, &hdev->flags))
 		return -ENETDOWN;
@@ -121,12 +120,8 @@ static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	err = -bt_to_errno(skb->data[0]);
 	kfree_skb(skb);
 
-	if (err < 0)
-		return err;
-
 	hci_dev_change_flag(hdev, HCI_DUT_MODE);
 
 	return count;
-- 
1.9.1

