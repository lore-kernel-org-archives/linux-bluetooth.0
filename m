Return-Path: <cyrus@holtmann.org>
From: Dohyun Pyun <re20sfree@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: steve.jun@samsung.com, DoHyun Pyun <dh79.pyun@samsung.com>,
	C S Bhargava <cs.bhargava@samsung.com>
Subject: [PATCH v4 8/8] Bluetooth: Add the definition for Slave Page Response Timeout
Date: Wed,  2 Oct 2013 21:54:53 +0900
Message-Id: <1380718493-4577-9-git-send-email-dh79.pyun@samsung.com>
In-Reply-To: <1380718493-4577-1-git-send-email-dh79.pyun@samsung.com>
References: <1380718493-4577-1-git-send-email-dh79.pyun@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: DoHyun Pyun <dh79.pyun@samsung.com>

The Slave Page Response Timeout event indicates to the Host that a
slave page response timeout has occurred in the BR/EDR Controller.

The Core Spec Addendum 4 adds this command in part B Connectionless
Slave Broadcast.

Bluetooth Core Specification Addendum 4 - Page 110

"7.7.72 Slave Page Response Timeout Event [New Section]
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
index 03f2a91..b90eec5 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1510,6 +1510,8 @@ struct hci_ev_sync_train_complete {
 	__u8	status;
 } __packed;
 
+#define HCI_EV_SLAVE_PAGE_RESP_TIMEOUT	0x54
+
 /* Low energy meta events */
 #define LE_CONN_ROLE_MASTER	0x00
 
-- 
1.8.1.2

