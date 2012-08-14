Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH] Bluetooth: mgmt: Fix returning a list with invalid indexes
Date: Tue, 14 Aug 2012 20:59:48 -0300
Message-Id: <1344988788-16378-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When a device is in the HCI_SETUP state, it was being counted as
a valid device, but it wasn't included in the list returned to
userspace.

This can be reproduced when you add an adapter after doing
'rfkill block all', for example.

This commit also has the (intended) effect of making
'btmgmt power on' work after the rfkill block has been lifted.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/mgmt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a3329cb..c500b59 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -350,9 +350,6 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	i = 0;
 	list_for_each_entry(d, &hci_dev_list, list) {
-		if (test_bit(HCI_SETUP, &d->dev_flags))
-			continue;
-
 		if (!mgmt_valid_hdev(d))
 			continue;
 
-- 
1.7.11.4

