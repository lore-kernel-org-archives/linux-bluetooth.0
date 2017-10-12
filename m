Return-Path: <garsilva@embeddedor.com>
Date: Thu, 12 Oct 2017 17:24:02 -0500
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] Bluetooth: mark expected switch fall-throughs
Message-ID: <20171012222402.GA31769@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

In this particular case, notice that I replaced the
"deliberate fall-through..." comment with a "fall through"
comment, which is what GCC is expecting to find.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/bluetooth/bcm203x.c | 2 +-
 drivers/bluetooth/hci_ll.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/bcm203x.c b/drivers/bluetooth/bcm203x.c
index 5ce6d41..8e9547f 100644
--- a/drivers/bluetooth/bcm203x.c
+++ b/drivers/bluetooth/bcm203x.c
@@ -121,7 +121,7 @@ static void bcm203x_complete(struct urb *urb)
 		}
 
 		data->state = BCM203X_LOAD_FIRMWARE;
-
+		/* fall through */
 	case BCM203X_LOAD_FIRMWARE:
 		if (data->fw_sent == data->fw_size) {
 			usb_fill_int_urb(urb, udev, usb_rcvintpipe(udev, BCM203X_IN_EP),
diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 424c15a..e2c078d 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -242,7 +242,7 @@ static void ll_device_want_to_wakeup(struct hci_uart *hu)
 		 * perfectly safe to always send one.
 		 */
 		BT_DBG("dual wake-up-indication");
-		/* deliberate fall-through - do not add break */
+		/* fall through */
 	case HCILL_ASLEEP:
 		/* acknowledge device wake up */
 		if (send_hcill_cmd(HCILL_WAKE_UP_ACK, hu) < 0) {
-- 
2.7.4
