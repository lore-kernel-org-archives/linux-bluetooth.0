Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix warning of uninitialized adv_instance variable
Date: Thu, 18 Jun 2015 20:26:31 +0300
Message-Id: <1434648391-13789-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Some static checkers may cause the following (false positive) warning:

>> net/bluetooth/mgmt.c:7294:29: warning: 'adv_instance' may be used
uninitialized in this function [-Wuninitialized]

Fix it by ensuring adv_instance always gets set to a known value.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2fe6f3bfc579..2b3411136d68 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7291,8 +7291,10 @@ static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
 
 	if (cp->instance)
 		adv_instance = hci_find_adv_instance(hdev, cp->instance);
+	else
+		adv_instance = NULL;
 
-	if (!(cp->instance == 0x00 || adv_instance)) {
+	if (!adv_instance) {
 		err = mgmt_cmd_status(sk, hdev->id,
 				      MGMT_OP_REMOVE_ADVERTISING,
 				      MGMT_STATUS_INVALID_PARAMS);
-- 
2.4.3

