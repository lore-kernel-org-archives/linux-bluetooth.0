Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/3] Bluetooth: Fix SMP user passkey notification mgmt event
Date: Wed, 19 Mar 2014 14:14:53 +0200
Message-Id: <1395231293-26581-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1395231293-26581-1-git-send-email-johan.hedberg@gmail.com>
References: <1395231293-26581-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When performing SMP pairing with MITM protection one side needs to
enter the passkey while the other side displays to the user what needs
to be entered. Nowhere in the SMP specification does it say that the
displaying side needs to any kind of confirmation of the passkey, even
though a code comment in smp.c implies this.

This patch removes the misleading comment and converts the code to use
the passkey notification mgmt event instead of the passkey confirmation
mgmt event.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index ed1c9547ba6e..2a7ee7f6cd8b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -407,13 +407,14 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 			method = REQ_PASSKEY;
 	}
 
-	/* Generate random passkey. Not valid until confirmed. */
+	/* Generate random passkey. */
 	if (method == CFM_PASSKEY) {
 		memset(smp->tk, 0, sizeof(smp->tk));
 		get_random_bytes(&passkey, sizeof(passkey));
 		passkey %= 1000000;
 		put_unaligned_le32(passkey, smp->tk);
 		BT_DBG("PassKey: %d", passkey);
+		set_bit(SMP_FLAG_TK_VALID, &smp->smp_flags);
 	}
 
 	hci_dev_lock(hcon->hdev);
@@ -422,7 +423,7 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 		ret = mgmt_user_passkey_request(hcon->hdev, &hcon->dst,
 						hcon->type, hcon->dst_type);
 	else
-		ret = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
+		ret = mgmt_user_passkey_notify(hcon->hdev, &hcon->dst,
 						hcon->type, hcon->dst_type,
 						cpu_to_le32(passkey), 0);
 
-- 
1.8.5.3

