Return-Path: <cyrus@holtmann.org>
From: Dohyun Pyun <re20sfree@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: steve.jun@samsung.com, DoHyun Pyun <dh79.pyun@samsung.com>,
	C S Bhargava <cs.bhargava@samsung.com>
Subject: [PATCH v3 6/8] Bluetooth: Add Start Synchronization Train Command
Date: Wed,  2 Oct 2013 21:09:16 +0900
Message-Id: <1380715758-10334-7-git-send-email-dh79.pyun@samsung.com>
In-Reply-To: <1380715758-10334-1-git-send-email-dh79.pyun@samsung.com>
References: <1380715758-10334-1-git-send-email-dh79.pyun@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: DoHyun Pyun <dh79.pyun@samsung.com>

The Start_Synchronization_Train command controls the Synchronization
Train functionality in the BR/EDR Controller.

The Core Spec Addendum 4 adds this command in part B Connectionless
Slave Broadcast.

Bluetooth Core Specification Addendum 4 - Page 86

"7.1.51 Start Synchronization Train Command [New Section]
...
If connectionless slave broadcast mode is not enabled, the Command
Disallowed (0x0C) error code shall be returned. After receiving this
command and returning a Command Status event, the Baseband starts
attempting to send synchronization train packets containing information
related to the enabled Connectionless Slave Broadcast packet timing.

Note: The AFH_Channel_Map used in the synchronization train packets is
configured by the Set_AFH_Channel_Classification command and the local
channel classification in the BR/EDR Controller.

The synchronization train packets will be sent using the parameters
specified by the latest Write_Synchronization_Train_Parameters command.
The Synchronization Train will continue until synchronization_trainTO
slots (as specified in the last Write_Synchronization_Train command)
have passed or until the Host disables the Connectionless Slave Broadcast
logical transport."

Signed-off-by: Dohyun Pyun <dh79.pyun@samsung.com>
Signed-off-by: C S Bhargava <cs.bhargava@samsung.com>
---
 include/net/bluetooth/hci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 42d3832..657d2b0 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -644,6 +644,8 @@ struct hci_rp_set_csb {
 	__le16	interval;
 } __packed;
 
+#define HCI_OP_START_SYNC_TRAIN		0x0443
+
 #define HCI_OP_SNIFF_MODE		0x0803
 struct hci_cp_sniff_mode {
 	__le16   handle;
-- 
1.8.1.2

