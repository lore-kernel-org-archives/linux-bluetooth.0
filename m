Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: second scan timing out, bisected to 314b2381a79c6bfe3ddc4ba3806ecb6aec27a3db
Date: Tue, 30 Aug 2011 15:52:18 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <201108301005.20103.oliver@neukum.org> <20110830084322.GA15992@dell.ger.corp.intel.com>
In-Reply-To: <20110830084322.GA15992@dell.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Message-Id: <201108301552.19010.oliver@neukum.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am Dienstag, 30. August 2011, 10:45:05 schrieb Johan Hedberg:
> Hi Oliver,
> 
> On Tue, Aug 30, 2011, Oliver Neukum wrote:

> I think this is a real issue, but it only happens with the HCIINQUIRY
> ioctl which bluetoothd doesn't use (but hcitool does). I think the
> problems is with the following type of additions in the patch:
> 
> +       if (test_bit(HCI_MGMT, &hdev->flags) &&
> +                               test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
> +               mgmt_discovering(hdev->id, 0);
> 
> Because of the ordering of the if-statement the HCI_INQUIRY flags
> doesn't get cleared if HCI_MGMT is not set and so the HCIINQUIRY ioctl
> doesn't trigger inquiry even though it should (see hci_inq_req in
> net/bluetooth/hci_core.c). Can you try to flip the ordering of the
> test_bit and test_and_clear_bit calls in all relevant if-statements in
> the patch and see if it resolves your issue?

Hi,

this patch makes it work again.

	Regards
		Oliver

>From 06dedee9fb972748bb9240a498c954089ed1b41e Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oliver@neukum.org>
Date: Tue, 30 Aug 2011 14:33:26 +0200
Subject: [PATCH 1/2] BT:fix timeout on scanning for the second time

The checks for HCI_INQUIRY and HCI_MGMT were in the wrong order,
so that second scans always failed.

Signed-off-by: Oliver Neukum <oneukum@suse.de>
---
 net/bluetooth/hci_event.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a40170e..7ef4eb4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -58,8 +58,8 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
 	if (status)
 		return;
 
-	if (test_bit(HCI_MGMT, &hdev->flags) &&
-				test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
+	if (test_and_clear_bit(HCI_INQUIRY, &hdev->flags) &&
+			test_bit(HCI_MGMT, &hdev->flags))
 		mgmt_discovering(hdev->id, 0);
 
 	hci_req_complete(hdev, HCI_OP_INQUIRY_CANCEL, status);
@@ -76,8 +76,8 @@ static void hci_cc_exit_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
 	if (status)
 		return;
 
-	if (test_bit(HCI_MGMT, &hdev->flags) &&
-				test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
+	if (test_and_clear_bit(HCI_INQUIRY, &hdev->flags) &&
+				test_bit(HCI_MGMT, &hdev->flags))
 		mgmt_discovering(hdev->id, 0);
 
 	hci_conn_check_pending(hdev);
@@ -959,9 +959,8 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 		return;
 	}
 
-	if (test_bit(HCI_MGMT, &hdev->flags) &&
-					!test_and_set_bit(HCI_INQUIRY,
-							&hdev->flags))
+	if (!test_and_set_bit(HCI_INQUIRY, &hdev->flags) &&
+				test_bit(HCI_MGMT, &hdev->flags))
 		mgmt_discovering(hdev->id, 1);
 }
 
@@ -1340,8 +1339,8 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
 
 	BT_DBG("%s status %d", hdev->name, status);
 
-	if (test_bit(HCI_MGMT, &hdev->flags) &&
-				test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
+	if (test_and_clear_bit(HCI_INQUIRY, &hdev->flags) &&
+				test_bit(HCI_MGMT, &hdev->flags))
 		mgmt_discovering(hdev->id, 0);
 
 	hci_req_complete(hdev, HCI_OP_INQUIRY, status);
-- 
1.7.1

