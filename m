Return-Path: <cyrus@holtmann.org>
From: Dohyun Pyun <re20sfree@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: steve.jun@samsung.com, DoHyun Pyun <dh79.pyun@samsung.com>,
	C S Bhargava <cs.bhargava@samsung.com>
Subject: [PATCH v2 7/8] Bluetooth: Add Synchronization Train Complete Event
Date: Wed,  2 Oct 2013 20:10:17 +0900
Message-Id: <1380712218-9269-8-git-send-email-dh79.pyun@samsung.com>
In-Reply-To: <1380712218-9269-1-git-send-email-dh79.pyun@samsung.com>
References: <1380712218-9269-1-git-send-email-dh79.pyun@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: DoHyun Pyun <dh79.pyun@samsung.com>

The Synchronization Train Complete event indicates that the Start
Synchronization Train command has completed.

The Core Spec Addendum 4 adds this command in part B Connectionless
Slave Broadcast.

Bluetooth Core Specification Addendum 4 - Page 103

"7.7.67 Synchronization Train Complete Event [New Section]
...

Event Parameters:

Status 0x00       Start Synchronization Train command completed
                  successfully.
       0x01-0xFF  Start Synchronization Train command failed.
                  See Part D, Error Codes, for error codes and
                  descriptions."

Signed-off-by: Dohyun Pyun <dh79.pyun@samsung.com>
Signed-off-by: C S Bhargava <cs.bhargava@samsung.com>
---
 include/net/bluetooth/hci.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5f30012..8ec8ee8 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1503,6 +1503,11 @@ struct hci_ev_num_comp_blocks {
 	struct hci_comp_blocks_info handles[0];
 } __packed;
 
+#define HCI_EV_SYNC_TRAIN_COMPLETE	0x4F
+struct hci_ev_sync_train_complete {
+	__u8	status;
+} __packed;
+
 /* Low energy meta events */
 #define LE_CONN_ROLE_MASTER	0x00
 
-- 
1.8.1.2

