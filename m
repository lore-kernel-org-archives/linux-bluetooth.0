Return-Path: <cyrus@holtmann.org>
From: Luis Rodriguez <Luis.Rodriguez@Atheros.com>
To: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, Jothikumar Mothilal
	<Jothikumar.Mothilal@Atheros.com>
Date: Tue, 1 Jun 2010 07:29:33 -0700
Subject: RE: [PATCH 2/3] Replace hci_recv_fragment calls
Message-ID: <BD672EAEE3AD2C47A7120B0973C3FB3A2DC28BB600@SC1EXMB-MBCL.global.atheros.com>
References: <1275379440.19477.9.camel@atheros013-desktop>,<1275379734.19477.14.camel@atheros013-desktop>
In-Reply-To: <1275379734.19477.14.camel@atheros013-desktop>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


You want to unify patches 1 and 2. Patches upstream should be atomic so tha=
t if  you apply it, it should make everything still work. Your first patch =
removes hci_recv_fragment() and then this one fixes the places that call it=
, you want to do both in one shot.

  Luis
________________________________________
From: Suraj Sumangala
Sent: Tuesday, June 01, 2010 1:08 AM
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org; Luis Rodriguez; Jothikumar Mothilal
Subject: [PATCH 2/3] Replace hci_recv_fragment calls

Replace all usages of hci_recv_fragment calls with
hci_recv_packet_fragment


Signed-off-by: suraj <suraj@Atheros.com>
---
 drivers/bluetooth/btusb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5d9cc53..50aa8d1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -211,7 +211,7 @@ static void btusb_intr_complete(struct urb *urb)
        if (urb->status =3D=3D 0) {
                hdev->stat.byte_rx +=3D urb->actual_length;

-               if (hci_recv_fragment(hdev, HCI_EVENT_PKT,
+               if (hci_recv_packet_fragment(hdev, HCI_EVENT_PKT,
                                                urb->transfer_buffer,
                                                urb->actual_length) < 0) {
                        BT_ERR("%s corrupted event packet", hdev->name);
@@ -295,7 +295,7 @@ static void btusb_bulk_complete(struct urb *urb)
        if (urb->status =3D=3D 0) {
                hdev->stat.byte_rx +=3D urb->actual_length;

-               if (hci_recv_fragment(hdev, HCI_ACLDATA_PKT,
+               if (hci_recv_packet_fragment(hdev, HCI_ACLDATA_PKT,
                                                urb->transfer_buffer,
                                                urb->actual_length) < 0) {
                        BT_ERR("%s corrupted ACL packet", hdev->name);
@@ -384,7 +384,7 @@ static void btusb_isoc_complete(struct urb *urb)

                        hdev->stat.byte_rx +=3D length;

-                       if (hci_recv_fragment(hdev, HCI_SCODATA_PKT,
+                       if (hci_recv_packet_fragment(hdev, HCI_SCODATA_PKT,
                                                urb->transfer_buffer + offs=
et,
                                                                length) < 0=
) {
                                BT_ERR("%s corrupted SCO packet", hdev->nam=
e);
--
1.7.0
