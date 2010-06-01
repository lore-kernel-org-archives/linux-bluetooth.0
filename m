Return-Path: <cyrus@holtmann.org>
Subject: [PATCH 2/3] Replace hci_recv_fragment calls
From: GLOBAL/suraj <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <Luis.Rodriguez@Atheros.com>,
	<Jothikumar.Mothilal@Atheros.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 1 Jun 2010 12:24:14 +0530
Message-ID: <1275375254.7163.25.camel@atheros013-desktop>
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


Replace all usages of hci_recv_fragment calls with hci_recv_packet_fragment

Signed-off-by: suraj <suraj@Atheros.com>
---
 drivers/bluetooth/btusb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5d9cc53..50aa8d1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -211,7 +211,7 @@ static void btusb_intr_complete(struct urb *urb)
 	if (urb->status == 0) {
 		hdev->stat.byte_rx += urb->actual_length;
 
-		if (hci_recv_fragment(hdev, HCI_EVENT_PKT,
+		if (hci_recv_packet_fragment(hdev, HCI_EVENT_PKT,
 						urb->transfer_buffer,
 						urb->actual_length) < 0) {
 			BT_ERR("%s corrupted event packet", hdev->name);
@@ -295,7 +295,7 @@ static void btusb_bulk_complete(struct urb *urb)
 	if (urb->status == 0) {
 		hdev->stat.byte_rx += urb->actual_length;
 
-		if (hci_recv_fragment(hdev, HCI_ACLDATA_PKT,
+		if (hci_recv_packet_fragment(hdev, HCI_ACLDATA_PKT,
 						urb->transfer_buffer,
 						urb->actual_length) < 0) {
 			BT_ERR("%s corrupted ACL packet", hdev->name);
@@ -384,7 +384,7 @@ static void btusb_isoc_complete(struct urb *urb)
 
 			hdev->stat.byte_rx += length;
 
-			if (hci_recv_fragment(hdev, HCI_SCODATA_PKT,
+			if (hci_recv_packet_fragment(hdev, HCI_SCODATA_PKT,
 						urb->transfer_buffer + offset,
 								length) < 0) {
 				BT_ERR("%s corrupted SCO packet", hdev->name);
-- 
1.7.0
