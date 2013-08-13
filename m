Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Set different event mask for LE-only controllers
Date: Tue, 13 Aug 2013 10:00:54 -0700
Message-Id: <1376413254-36536-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case of a Low Energy only controller it makes no sense to configure
the full BR/EDR event mask. It will just enable events that can not be
send anyway and there is no guarantee that such a controller will accept
this value.

Use event mask 0x90 0xe8 0x04 0x02 0x00 0x80 0x00 0x20 for LE-only
controllers which enables the following events:

          Disconnection Complete
          Encryption Change
          Read Remote Version Information Complete
          Command Complete
          Command Status
          Hardware Error
          Number of Completed Packets
          Data Buffer Overflow
          Encryption Key Refresh Complete
          LE Meta

This is according to Core Specification, Part E, Section 3.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b821b19..8d9b87d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -454,6 +454,18 @@ static void hci_setup_event_mask(struct hci_request *req)
 		events[4] |= 0x04; /* Read Remote Extended Features Complete */
 		events[5] |= 0x08; /* Synchronous Connection Complete */
 		events[5] |= 0x10; /* Synchronous Connection Changed */
+	} else {
+		/* Use a different default for LE-only devices */
+		memset(events, 0, sizeof(events));
+		events[0] |= 0x10; /* Disconnection Complete */
+		events[0] |= 0x80; /* Encryption Change */
+		events[1] |= 0x08; /* Read Remote Version Information Complete */
+		events[1] |= 0x20; /* Command Complete */
+		events[1] |= 0x40; /* Command Status */
+		events[1] |= 0x80; /* Hardware Error */
+		events[2] |= 0x04; /* Number of Completed Packets */
+		events[3] |= 0x02; /* Data Buffer Overflow */
+		events[5] |= 0x80; /* Encryption Key Refresh Complete */
 	}
 
 	if (lmp_inq_rssi_capable(hdev))
-- 
1.8.3.1

