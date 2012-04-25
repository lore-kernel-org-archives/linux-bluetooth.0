Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/8] Bluetooth: Rename mgmt_to_le to bdaddr_to_le
Date: Tue, 24 Apr 2012 21:02:51 -0300
Message-Id: <1335312176-21306-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1335312176-21306-1-git-send-email-andre.guedes@openbossa.org>
References: <1335312176-21306-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since address type macros are not only related to Management
Interface anymore, it makes sense to rename the helper function
mgmt_to_le to bdaddr_to_le.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 40c7514..6d80cb3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1644,9 +1644,9 @@ static u8 link_to_bdaddr(u8 link_type, u8 addr_type)
 	}
 }
 
-static u8 mgmt_to_le(u8 mgmt_type)
+static u8 bdaddr_to_le(u8 bdaddr_type)
 {
-	switch (mgmt_type) {
+	switch (bdaddr_type) {
 	case BDADDR_LE_PUBLIC:
 		return ADDR_LE_DEV_PUBLIC;
 
@@ -2664,7 +2664,7 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 			type = HCI_SMP_LTK_SLAVE;
 
 		hci_add_ltk(hdev, &key->addr.bdaddr,
-			    mgmt_to_le(key->addr.type),
+			    bdaddr_to_le(key->addr.type),
 			    type, 0, key->authenticated, key->val,
 			    key->enc_size, key->ediv, key->rand);
 	}
-- 
1.7.10

