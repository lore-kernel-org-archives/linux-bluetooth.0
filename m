Return-Path: <cyrus@holtmann.org>
From: Hemant Gupta <hemant.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Hemant Gupta <hemant.gupta@stericsson.com>
Subject: [PATCH v1 1/1] Bluetooth: mgmt: Fix address type while loading Long Term Key
Date: Mon, 16 Apr 2012 14:34:53 +0530
Message-ID: <1334567093-15058-2-git-send-email-hemant.gupta@stericsson.com>
In-Reply-To: <1334567093-15058-1-git-send-email-hemant.gupta@stericsson.com>
References: <1334567093-15058-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes the address type while loading long term keys when BT is
switched on. Without this fix pairing is reinitated even though LTK exists
for remote device because of mismatch of address type.

Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
---
 net/bluetooth/mgmt.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 880b7c9..b84de64 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2652,7 +2652,8 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 		else
 			type = HCI_SMP_LTK_SLAVE;
 
-		hci_add_ltk(hdev, &key->addr.bdaddr, key->addr.type,
+		hci_add_ltk(hdev, &key->addr.bdaddr,
+			    mgmt_to_link(LE_LINK, key->addr.type),
 			    type, 0, key->authenticated, key->val,
 			    key->enc_size, key->ediv, key->rand);
 	}
-- 
1.7.0.4

