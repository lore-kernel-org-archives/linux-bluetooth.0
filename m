Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Jan 2008 18:22:48 +0200 (IST)
From: Ohad Ben-Cohen <ohad@bencohen.org>
Subject: [PATCH][FIX] Bluetooth: always send explicit hci_ll wake-up acks
To: marcel@holtmann.org, linux-kernel@vger.kernel.org
cc: bluez-devel@lists.sourceforge.net
Message-ID: <tkrat.091a3ceefb96c3e3@bencohen.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

In the (rare) event of simultaneous mutual wake up requests,
do send the chip an explicit wake-up ack. This is required
for Texas Instruments's BRF6350 chip.

Signed-off-by: Ohad Ben-Cohen <ohad@bencohen.org>

---

 drivers/bluetooth/hci_ll.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 8c3e62a..b91d45a 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -204,6 +204,19 @@ static void ll_device_want_to_wakeup(struct hci_uart *hu)
 	spin_lock_irqsave(&ll->hcill_lock, flags);
 
 	switch (ll->hcill_state) {
+	case HCILL_ASLEEP_TO_AWAKE:
+		/*
+		 * This state means that both the host and the BRF chip
+		 * have simultaneously sent a wake-up-indication packet.
+		 * Traditionaly, in this case, receiving a wake-up-indication
+		 * was enough and an additional wake-up-ack wasn't needed.
+		 * This has changed with the BRF6350, which does require an
+		 * explicit wake-up-ack. Other BRF versions, which do not
+		 * require an explicit ack here, do accept it, thus it is
+		 * perfectly safe to always send one.
+		 */
+		BT_DBG("dual wake-up-indication");
+		/* deliberate fall-through - do not add break */
 	case HCILL_ASLEEP:
 		/* acknowledge device wake up */
 		if (send_hcill_cmd(HCILL_WAKE_UP_ACK, hu) < 0) {
@@ -211,16 +224,8 @@ static void ll_device_want_to_wakeup(struct hci_uart *hu)
 			goto out;
 		}
 		break;
-	case HCILL_ASLEEP_TO_AWAKE:
-		/*
-		 * this state means that a wake-up-indication
-		 * is already on its way to the device,
-		 * and will serve as the required wake-up-ack
-		 */
-		BT_DBG("dual wake-up-indication");
-		break;
 	default:
-		/* any other state are illegal */
+		/* any other state is illegal */
 		BT_ERR("received HCILL_WAKE_UP_IND in state %ld", ll->hcill_state);
 		break;
 	}
-- 
1.4.4.2
