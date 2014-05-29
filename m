Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix properly ignoring LTKs of unknown types
Date: Thu, 29 May 2014 19:36:53 +0300
Message-Id: <1401381413-12782-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In case there are new LTK types in the future we shouldn't just blindly
assume that != MGMT_LTK_UNAUTHENTICATED means that the key is
authenticated. This patch adds explicit checks for each allowed key type
in the form of a switch statement and skips any key which has an unknown
value.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5e9c21a5525f..0fce54412ffd 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4546,10 +4546,16 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 		else
 			type = HCI_SMP_LTK_SLAVE;
 
-		if (key->type == MGMT_LTK_UNAUTHENTICATED)
+		switch (key->type) {
+		case MGMT_LTK_UNAUTHENTICATED:
 			authenticated = 0x00;
-		else
+			break;
+		case MGMT_LTK_AUTHENTICATED:
 			authenticated = 0x01;
+			break;
+		default:
+			continue;
+		}
 
 		hci_add_ltk(hdev, &key->addr.bdaddr, addr_type, type,
 			    authenticated, key->val, key->enc_size, key->ediv,
-- 
1.9.3

