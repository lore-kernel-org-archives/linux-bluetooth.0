Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Ankit Navik <ankit.p.navik@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.b.panda@intel.com, ankit.p.navik@intel.com
Subject: [PATCH 2/2] Bluetooth: Add HCI command for clear Resolv list
Date: Fri, 29 Jun 2018 12:13:20 +0530
Message-Id: <1530254600-32499-1-git-send-email-ankit.p.navik@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Check for Resolv list supported by controller. So check the supported
commmand first before issuing this command i.e.,HCI_OP_LE_CLEAR_RESOLV_LIST

Before patch:
< HCI Command: LE Read White List... (0x08|0x000f) plen 0  #55 [hci0] 13.338168
> HCI Event: Command Complete (0x0e) plen 5                #56 [hci0] 13.338842
      LE Read White List Size (0x08|0x000f) ncmd 1
        Status: Success (0x00)
        Size: 25
< HCI Command: LE Clear White List (0x08|0x0010) plen 0    #57 [hci0] 13.339029
> HCI Event: Command Complete (0x0e) plen 4                #58 [hci0] 13.339939
      LE Clear White List (0x08|0x0010) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Resolving L.. (0x08|0x002a) plen 0  #59 [hci0] 13.340152
> HCI Event: Command Complete (0x0e) plen 5                #60 [hci0] 13.340952
      LE Read Resolving List Size (0x08|0x002a) ncmd 1
        Status: Success (0x00)
        Size: 25
< HCI Command: LE Read Maximum Dat.. (0x08|0x002f) plen 0  #61 [hci0] 13.341180
> HCI Event: Command Complete (0x0e) plen 12               #62 [hci0] 13.341898
      LE Read Maximum Data Length (0x08|0x002f) ncmd 1
        Status: Success (0x00)
        Max TX octets: 251
        Max TX time: 17040
        Max RX octets: 251
        Max RX time: 17040

After patch:
< HCI Command: LE Read White List... (0x08|0x000f) plen 0  #55 [hci0] 28.919131
> HCI Event: Command Complete (0x0e) plen 5                #56 [hci0] 28.920016
      LE Read White List Size (0x08|0x000f) ncmd 1
        Status: Success (0x00)
        Size: 25
< HCI Command: LE Clear White List (0x08|0x0010) plen 0    #57 [hci0] 28.920164
> HCI Event: Command Complete (0x0e) plen 4                #58 [hci0] 28.920873
      LE Clear White List (0x08|0x0010) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Resolving L.. (0x08|0x002a) plen 0  #59 [hci0] 28.921109
> HCI Event: Command Complete (0x0e) plen 5                #60 [hci0] 28.922016
      LE Read Resolving List Size (0x08|0x002a) ncmd 1
        Status: Success (0x00)
        Size: 25
< HCI Command: LE Clear Resolving... (0x08|0x0029) plen 0  #61 [hci0] 28.922166
> HCI Event: Command Complete (0x0e) plen 4                #62 [hci0] 28.922872
      LE Clear Resolving List (0x08|0x0029) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Maximum Dat.. (0x08|0x002f) plen 0  #63 [hci0] 28.923117
> HCI Event: Command Complete (0x0e) plen 12               #64 [hci0] 28.924030
      LE Read Maximum Data Length (0x08|0x002f) ncmd 1
        Status: Success (0x00)
        Max TX octets: 251
        Max TX time: 17040
        Max RX octets: 251
        Max RX time: 17040

Signed-off-by: Ankit Navik <ankit.p.navik@intel.com>
---
 include/net/bluetooth/hci.h |  2 ++
 net/bluetooth/hci_core.c    |  5 +++++
 net/bluetooth/hci_event.c   | 17 +++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 484f24c..4af1a3a 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1490,6 +1490,8 @@ struct hci_cp_le_write_def_data_len {
 	__le16	tx_time;
 } __packed;
 
+#define HCI_OP_LE_CLEAR_RESOLV_LIST	0x2029
+
 #define HCI_OP_LE_READ_RESOLV_LIST_SIZE	0x202a
 struct hci_rp_le_read_resolv_list_size {
 	__u8	status;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 51efc4a..af1675d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -729,6 +729,11 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
 				    0, NULL);
 		}
 
+		if (hdev->commands[34] & 0x20) {
+			/* Clear LE Resolv List */
+			hci_req_add(req, HCI_OP_LE_CLEAR_RESOLV_LIST, 0, NULL);
+		}
+
 		if (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT) {
 			/* Read LE Maximum Data Length */
 			hci_req_add(req, HCI_OP_LE_READ_MAX_DATA_LEN, 0, NULL);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c57969a..3029d79 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1307,6 +1307,19 @@ static void hci_cc_le_write_def_data_len(struct hci_dev *hdev,
 	hdev->le_def_tx_time = le16_to_cpu(sent->tx_time);
 }
 
+static void hci_cc_le_clear_resolv_list(struct hci_dev *hdev,
+				       struct sk_buff *skb)
+{
+	__u8 status = *((__u8 *) skb->data);
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (status)
+		return;
+
+	hci_bdaddr_list_clear(&hdev->le_resolv_list);
+}
+
 static void hci_cc_le_read_resolv_list_size(struct hci_dev *hdev,
 					   struct sk_buff *skb)
 {
@@ -3029,6 +3042,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_le_write_def_data_len(hdev, skb);
 		break;
 
+	case HCI_OP_LE_CLEAR_RESOLV_LIST:
+		hci_cc_le_clear_resolv_list(hdev, skb);
+		break;
+
 	case HCI_OP_LE_READ_RESOLV_LIST_SIZE:
 		hci_cc_le_read_resolv_list_size(hdev, skb);
 		break;
-- 
1.9.1

