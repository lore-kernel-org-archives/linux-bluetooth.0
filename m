Return-Path: <cyrus@holtmann.org>
Date: Sat, 1 Aug 2015 15:30:08 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Marcel Holtmann <marcel@holtmann.org>, Arron Wang <arron.wang@intel.com>
Cc: Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] Bluetooth: fix breakage in amp_write_rem_assoc_frag()
Message-ID: <20150801123008.GA4378@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

We should be passing the pointer itself instead of the address of the
pointer.

This was a copy and paste bug when we replaced the calls to
hci_send_cmd().  Originally, the arguments were "len, cp" but we
overwrote them with "sizeof(cp), &cp" by mistake.

Fixes: b3d3914006a0 ('Bluetooth: Move amp assoc read/write completed callback to amp.c')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I'm pretty sure this is correct, but it's a static checker fix and I
haven't tested it.

diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index 238ddd3..e32f341 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -379,7 +379,7 @@ static bool amp_write_rem_assoc_frag(struct hci_dev *hdev,
 	amp_ctrl_put(ctrl);
 
 	hci_req_init(&req, hdev);
-	hci_req_add(&req, HCI_OP_WRITE_REMOTE_AMP_ASSOC, sizeof(cp), &cp);
+	hci_req_add(&req, HCI_OP_WRITE_REMOTE_AMP_ASSOC, len, cp);
 	hci_req_run_skb(&req, write_remote_amp_assoc_complete);
 
 	kfree(cp);
