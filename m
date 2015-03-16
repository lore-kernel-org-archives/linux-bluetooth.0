Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add extra SMP_DBG statement for remote OOB data
Date: Mon, 16 Mar 2015 10:21:48 -0700
Message-Id: <1426526508-14806-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Just for pure debugging purposes print the remote out-of-band data
that has been received and is going to be used.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 4c423bb4b043..895cfc9bd413 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -685,6 +685,8 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 			oob_flag = SMP_OOB_PRESENT;
 			memcpy(smp->rr, oob_data->rand256, 16);
 			memcpy(smp->pcnf, oob_data->hash256, 16);
+			SMP_DBG("OOB Remote Confirmation: %16phN", smp->pcnf);
+			SMP_DBG("OOB Remote Random: %16phN", smp->rr);
 		}
 
 	} else {
-- 
2.1.0

