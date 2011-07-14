Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Thu, 14 Jul 2011 08:48:32 -0400
Subject: [PATCH] Bluetooth: Allow ACL packets over USB in HCI_RAW mode
Message-ID: <1310647712.3208.3.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Removed tests which prevent transmission of ACL packets
when the device is in HCI_RAW mode. These tests verified that
there are ACL or LE links currently tracked by the HCI
connection manager. However, a HCI_RAW mode device does not
use the connection manager. In these circumstances, the connection
counts will be zero, and thus, transmitted ACL packets dropped.

The acl_num test is actually a vestige of a previous bulk URB
scheme that is no longer used by this driver (bulk URBs were not
started until at least one ACL connection was created). This was
incompatible with some endpoint implementations and was dropped -
see commit 43c2e57f94.

The utility of these tests is marginal - currently, the hci tx
scheduler cannot send an ACL or LE packet for an untracked connection
(except if the device is in HCI_RAW mode).

Lastly, no other transport layer driver enforces these same tests.
---
 drivers/bluetooth/btusb.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 513d462..020a3c5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -693,8 +693,7 @@ static int btusb_send_frame(struct sk_buff *skb)
 		break;
 
 	case HCI_ACLDATA_PKT:
-		if (!data->bulk_tx_ep || (hdev->conn_hash.acl_num < 1 &&
-						hdev->conn_hash.le_num < 1))
+		if (!data->bulk_tx_ep)
 			return -ENODEV;
 
 		urb = usb_alloc_urb(0, GFP_ATOMIC);
-- 
1.7.4.1

