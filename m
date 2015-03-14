Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add support for Read Extended Index List management command
Date: Sat, 14 Mar 2015 12:08:07 -0700
Message-Id: <1426360087-11985-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The new Read Extended Index List command allows for reading the complete
list of controllers. It includes Configure, Unconfigured and also AMP
controllers. This makes it easier for userspace to figure out what kind
of controllers are present and what to do with them.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/mgmt.h | 10 +++++++
 net/bluetooth/mgmt.c         | 70 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 5bf6af9cee78..d00e33f14207 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -505,6 +505,16 @@ struct mgmt_cp_start_service_discovery {
 } __packed;
 #define MGMT_START_SERVICE_DISCOVERY_SIZE 4
 
+#define MGMT_OP_READ_EXT_INDEX_LIST	0x003C
+#define MGMT_READ_EXT_INDEX_LIST_SIZE	0
+struct mgmt_rp_read_ext_index_list {
+	__le16	num_controllers;
+	struct {
+		__le16 index;
+		__u8   type;
+	} entry[0];
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c58908652519..65c1a52129e7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -489,6 +489,73 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static int read_ext_index_list(struct sock *sk, struct hci_dev *hdev,
+			       void *data, u16 data_len)
+{
+	struct mgmt_rp_read_ext_index_list *rp;
+	struct hci_dev *d;
+	size_t rp_len;
+	u16 count;
+	int err;
+
+	BT_DBG("sock %p", sk);
+
+	read_lock(&hci_dev_list_lock);
+
+	count = 0;
+	list_for_each_entry(d, &hci_dev_list, list) {
+		if (d->dev_type == HCI_BREDR || d->dev_type == HCI_AMP)
+			count++;
+	}
+
+	rp_len = sizeof(*rp) + (3 * count);
+	rp = kmalloc(rp_len, GFP_ATOMIC);
+	if (!rp) {
+		read_unlock(&hci_dev_list_lock);
+		return -ENOMEM;
+	}
+
+	count = 0;
+	list_for_each_entry(d, &hci_dev_list, list) {
+		if (hci_dev_test_flag(d, HCI_SETUP) ||
+		    hci_dev_test_flag(d, HCI_CONFIG) ||
+		    hci_dev_test_flag(d, HCI_USER_CHANNEL))
+			continue;
+
+		/* Devices marked as raw-only are neither configured
+		 * nor unconfigured controllers.
+		 */
+		if (test_bit(HCI_QUIRK_RAW_DEVICE, &d->quirks))
+			continue;
+
+		if (d->dev_type == HCI_BREDR) {
+			if (hci_dev_test_flag(d, HCI_UNCONFIGURED))
+				rp->entry[count].type = 0x01;
+			else
+				rp->entry[count].type = 0x00;
+		} else if (d->dev_type == HCI_AMP) {
+			rp->entry[count].type = 0x02;
+		} else {
+			continue;
+		}
+
+		rp->entry[count++].index = cpu_to_le16(d->id);
+		BT_DBG("Added hci%u", d->id);
+	}
+
+	rp->num_controllers = cpu_to_le16(count);
+	rp_len = sizeof(*rp) + (3 * count);
+
+	read_unlock(&hci_dev_list_lock);
+
+	err = mgmt_cmd_complete(sk, MGMT_INDEX_NONE,
+				MGMT_OP_READ_EXT_INDEX_LIST, 0, rp, rp_len);
+
+	kfree(rp);
+
+	return err;
+}
+
 static bool is_configured(struct hci_dev *hdev)
 {
 	if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks) &&
@@ -6235,6 +6302,9 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 						HCI_MGMT_UNCONFIGURED },
 	{ start_service_discovery, MGMT_START_SERVICE_DISCOVERY_SIZE,
 						HCI_MGMT_VAR_LEN },
+	{ NULL },
+	{ read_ext_index_list,     MGMT_READ_EXT_INDEX_LIST_SIZE,
+						HCI_MGMT_NO_HDEV },
 };
 
 int mgmt_control(struct hci_mgmt_chan *chan, struct sock *sk,
-- 
2.1.0

