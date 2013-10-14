Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Read current IAC LAP on controller setup
Date: Mon, 14 Oct 2013 14:06:36 -0700
Message-Id: <1381784796-52321-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Read the current IAC LAP values when initializing the controller. The
values are not used, but it is good to have them in the trace files
for debugging purposes.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 2 ++
 net/bluetooth/hci_core.c    | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 8567f44..b096f5f 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -821,6 +821,8 @@ struct hci_rp_read_num_supported_iac {
 	__u8	num_iac;
 } __packed;
 
+#define HCI_OP_READ_CURRENT_IAC_LAP	0x0c39
+
 #define HCI_OP_WRITE_INQUIRY_MODE	0x0c45
 
 #define HCI_MAX_EIR_LENGTH		240
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b5ef05e..7add9c9 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -373,6 +373,9 @@ static void bredr_setup(struct hci_request *req)
 	/* Read Number of Supported IAC */
 	hci_req_add(req, HCI_OP_READ_NUM_SUPPORTED_IAC, 0, NULL);
 
+	/* Read Current IAC LAP */
+	hci_req_add(req, HCI_OP_READ_CURRENT_IAC_LAP, 0, NULL);
+
 	/* Clear Event Filters */
 	flt_type = HCI_FLT_CLEAR_ALL;
 	hci_req_add(req, HCI_OP_SET_EVENT_FLT, 1, &flt_type);
-- 
1.8.3.1

