Return-Path: <cyrus@holtmann.org>
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCH] Bluetooth: Support the case when SCO link type changes
Date: Thu, 27 Aug 2015 18:14:18 +0100
Message-Id: <1440695658-7366-1-git-send-email-kubax.t.pawlak@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It may happen that a synchronous connection changes from eSCO to SCO
but it may also go back to eSCO on further attempts. This scenario is
not handled and results in userspace connection to fail, while
having SCO on airlink established.
Happens with BlackBerry 9100 and 9700 on third attempt.

2015-05-18 01:27:57.332242 < HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
    handle 256 voice setting 0x0060 ptype 0x0380
2015-05-18 01:27:57.333604 > HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
2015-05-18 01:27:57.334614 > HCI Event: Synchronous Connect Complete (0x2c) plen 17
    status 0x1a handle 0 bdaddr 30:7C:30:B3:A8:86 type SCO
    Error: Unsupported Remote Feature / Unsupported LMP Feature
2015-05-18 01:27:57.334895 < HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
    handle 256 voice setting 0x0060 ptype 0x0380
2015-05-18 01:27:57.335601 > HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
2015-05-18 01:27:57.336610 > HCI Event: Synchronous Connect Complete (0x2c) plen 17
    status 0x1a handle 0 bdaddr 30:7C:30:B3:A8:86 type SCO
    Error: Unsupported Remote Feature / Unsupported LMP Feature
2015-05-18 01:27:57.336685 < HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
    handle 256 voice setting 0x0060 ptype 0x03c8
2015-05-18 01:27:57.337603 > HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
2015-05-18 01:27:57.342608 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 256 slots 1
2015-05-18 01:27:57.377631 > HCI Event: Synchronous Connect Complete (0x2c) plen 17
    status 0x00 handle 257 bdaddr 30:7C:30:B3:A8:86 type eSCO
    Air mode: CVSD

Signed-off-by: Kuba Pawlak <kubax.t.pawlak@intel.com>
---
 net/bluetooth/hci_event.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7ba35a9ba6b77db152db5931530d8d0c5dcec6b5..8662896aece45610839c8b7dceb486c021a4adde 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3723,14 +3723,13 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 
 	conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
 	if (!conn) {
-		if (ev->link_type == ESCO_LINK)
-			goto unlock;
-
-		conn = hci_conn_hash_lookup_ba(hdev, ESCO_LINK, &ev->bdaddr);
+		conn = hci_conn_hash_lookup_ba(hdev,
+                             (ev->link_type == ESCO_LINK ? SCO_LINK : ESCO_LINK),
+                              &ev->bdaddr);
 		if (!conn)
 			goto unlock;
 
-		conn->type = SCO_LINK;
+		conn->type = ev->link_type;
 	}
 
 	switch (ev->status) {
-- 
1.9.3

