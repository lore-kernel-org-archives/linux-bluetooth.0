Return-Path: <cyrus@holtmann.org>
From: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>,
	Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
Subject: [RFC 6/9] Bluetooth: Add HCI command to enable/disable advertising
Date: Wed, 24 Oct 2012 12:58:12 -0300
Message-Id: <1351094295-10418-7-git-send-email-aloisio.almeida@openbossa.org>
In-Reply-To: <1351094295-10418-1-git-send-email-aloisio.almeida@openbossa.org>
References: <1351094295-10418-1-git-send-email-aloisio.almeida@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

This command will be used when in discoverable mode or broadcaster role.

Signed-off-by: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
---
 include/net/bluetooth/hci.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c0e9c3f..1dadf3d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -963,6 +963,10 @@ struct hci_cp_le_set_adv_data {
 	__u8     data[HCI_MAX_ADV_LENGTH];
 } __packed;
 
+#define HCI_OP_LE_SET_ADV_ENABLE	0x200a
+	#define ADVERTISING_DISABLE	0x00
+	#define ADVERTISING_ENABLE	0x01
+
 #define HCI_OP_LE_SET_SCAN_PARAM	0x200b
 struct hci_cp_le_set_scan_param {
 	__u8    type;
-- 
1.7.10.4

