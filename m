Return-Path: <cyrus@holtmann.org>
From: Dohyun Pyun <re20sfree@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: steve.jun@samsung.com, DoHyun Pyun <dh79.pyun@samsung.com>,
	C S Bhargava <cs.bhargava@samsung.com>
Subject: [PATCH 8/8] Bluetooth: Add Slave Page Response Timeout Event
Date: Wed,  2 Oct 2013 18:11:18 +0900
Message-Id: <1380705078-22154-9-git-send-email-dh79.pyun@samsung.com>
In-Reply-To: <1380705078-22154-1-git-send-email-dh79.pyun@samsung.com>
References: <1380705078-22154-1-git-send-email-dh79.pyun@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: DoHyun Pyun <dh79.pyun@samsung.com>

The Slave Page Response Timeout event indicates to the Host that a
slave page response timeout has occurred in the BR/EDR Controller.

The Core Spec Addendum 4 adds this command in part B Connectionless
Slave Broadcast.

Bluetooth Core Specification Addendum 4 - Page 110

"7.7.67 Synchronization Train Complete Event [New Section]
...
Note: this event will be generated if the slave BR/EDR Controller
responds to a page but does not receive the master FHS packet
(see Baseband, Section 8.3.3) within pagerespTO.

Event Parameters: NONE"

Signed-off-by: Dohyun Pyun <dh79.pyun@samsung.com>
Signed-off-by: C S Bhargava <cs.bhargava@samsung.com>
---
 include/net/bluetooth/hci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 022d44f..809c9ee 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1507,6 +1507,8 @@ struct hci_ev_sync_train_complete {
 	__u8 status;
 } __packed;
 
+#define HCI_EV_SLAVE_PAGE_RESP_TIMEOUT	0x54
+
 /* Low energy meta events */
 #define LE_CONN_ROLE_MASTER	0x00
 
-- 
1.8.1.2

