Return-Path: <cyrus@holtmann.org>
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [Patch v2] Bluetooth: Fix SCO link type change handling on connection complete
Date: Fri, 28 Aug 2015 13:05:22 +0100
Message-Id: <1440763522-12399-1-git-send-email-kubax.t.pawlak@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Synchronous connections are initially created with type eSCO.
Link manager may reject proposed link parameters, which triggers
connection setup retry with a different set. Link type embedded
in responses should be disregarded until Synchronous Connect Complete
returns Success (0x00). Current code updates link type every time
which creates an issue when link type changes to SCO and back to eSCO
on further attepts.

Issue happens with BlackBerry 9100 and 9700 with Intel WilkinsPeak
on third connection setup attept

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
 net/bluetooth/hci_event.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7ba35a9ba6b77db152db5931530d8d0c5dcec6b5..186041866315a4e107de086df52142f39d6c6ee3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3726,17 +3726,25 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 		if (ev->link_type == ESCO_LINK)
 			goto unlock;
 
+		/* When the link type in the event indicates SCO connection
+		 * and lookup of the connection object fails, then check
+		 * if an eSCO connection object exists.
+		 *
+		 * The core limits the synchronous connections to either
+		 * SCO or eSCO. The eSCO connection is preferred and tried
+		 * to be setup first and until successfully established,
+		 * the link type will be hinted as eSCO.
+		 */
 		conn = hci_conn_hash_lookup_ba(hdev, ESCO_LINK, &ev->bdaddr);
 		if (!conn)
 			goto unlock;
-
-		conn->type = SCO_LINK;
 	}
 
 	switch (ev->status) {
 	case 0x00:
 		conn->handle = __le16_to_cpu(ev->handle);
 		conn->state  = BT_CONNECTED;
+		conn->type   = ev->link_type;
 
 		hci_debugfs_create_conn(conn);
 		hci_conn_add_sysfs(conn);
-- 
1.9.3

