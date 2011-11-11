Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Add missing cmd_complete for mgmt_load_link_keys
Date: Fri, 11 Nov 2011 16:18:54 +0200
Message-Id: <1321021134-31809-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1321021134-31809-1-git-send-email-johan.hedberg@gmail.com>
References: <1321021134-31809-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The command complete event was completely missing for this command.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5b5f064..ca88e6d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1055,6 +1055,8 @@ static int load_link_keys(struct sock *sk, u16 index, unsigned char *data,
 								key->pin_len);
 	}
 
+	cmd_complete(sk, index, MGMT_OP_LOAD_LINK_KEYS, NULL, 0);
+
 	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
-- 
1.7.7.2

