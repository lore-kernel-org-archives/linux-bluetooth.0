Return-Path: <cyrus@holtmann.org>
From: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>,
	Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
Subject: [RFC 3/9] Bluetooth: Add HCI command to set advertising data
Date: Wed, 24 Oct 2012 12:58:09 -0300
Message-Id: <1351094295-10418-4-git-send-email-aloisio.almeida@openbossa.org>
In-Reply-To: <1351094295-10418-1-git-send-email-aloisio.almeida@openbossa.org>
References: <1351094295-10418-1-git-send-email-aloisio.almeida@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

The information to be broadcasted must be set using this HCI command.

Signed-off-by: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
---
 include/net/bluetooth/hci.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c539314..75b7e58 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -952,6 +952,14 @@ struct hci_cp_le_set_adv_params {
 	__u8     filter_policy;
 } __packed;
 
+#define HCI_MAX_ADV_LENGTH		31
+
+#define HCI_OP_LE_SET_ADV_DATA		0x2008
+struct hci_cp_le_set_adv_data {
+	__u8     data_len;
+	__u8     data[HCI_MAX_ADV_LENGTH];
+} __packed;
+
 #define HCI_OP_LE_SET_SCAN_PARAM	0x200b
 struct hci_cp_le_set_scan_param {
 	__u8    type;
-- 
1.7.10.4

