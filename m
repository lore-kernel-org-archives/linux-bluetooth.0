Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 3/4] Bluetooth: btintel: Fix calls to __hci_cmd_sync()
Date: Fri, 15 May 2015 11:58:41 +0200
Message-Id: <1431683922-20418-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1431683922-20418-1-git-send-email-frederic.danis@linux.intel.com>
References: <1431683922-20418-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove test of command reply status as it is already performed by
__hci_cmd_sync().

__hci_cmd_sync_ev() function already returns an error if it got a
non-zero status either through a Command Complete or a Command
Status event.

For both of these events the status is collected up in the event
handlers called by hci_event_packet() and then passed as the second
parameter to req_complete_skb(). The req_complete_skb() callback in
turn is hci_req_sync_complete() for __hci_cmd_sync_ev() which stores
the status in hdev->req_result. The hdev->req_result is then further
converted through bt_to_errno() back in __hci_cmd_sync_ev().

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/btintel.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 2d43d42..828f2f8 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -53,12 +53,6 @@ int btintel_check_bdaddr(struct hci_dev *hdev)
 	}
 
 	bda = (struct hci_rp_read_bd_addr *)skb->data;
-	if (bda->status) {
-		BT_ERR("%s: Intel device address result failed (%02x)",
-		       hdev->name, bda->status);
-		kfree_skb(skb);
-		return -bt_to_errno(bda->status);
-	}
 
 	/* For some Intel based controllers, the default Bluetooth device
 	 * address 00:03:19:9E:8B:00 can be found. These controllers are
-- 
1.9.1

