Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Fix response for mgmt_start_discovery when powered off
Date: Mon,  7 Nov 2011 23:13:37 +0200
Message-Id: <1320700419-4665-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We should return a ENETDOWN status response if the adapter is powered
off (i.e. the HCI_UP flag isn't set).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6f9e3cd..16ccc7e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1619,6 +1619,11 @@ static int start_discovery(struct sock *sk, u16 index)
 
 	hci_dev_lock_bh(hdev);
 
+	if (!test_bit(HCI_UP, &hdev->flags)) {
+		err = cmd_status(sk, index, MGMT_OP_START_DISCOVERY, ENETDOWN);
+		goto failed;
+	}
+
 	cmd = mgmt_pending_add(sk, MGMT_OP_START_DISCOVERY, index, NULL, 0);
 	if (!cmd) {
 		err = -ENOMEM;
-- 
1.7.7.1

