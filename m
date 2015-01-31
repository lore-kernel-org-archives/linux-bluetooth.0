Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix OOB data present value for SMP pairing
Date: Sat, 31 Jan 2015 00:15:52 -0800
Message-Id: <1422692152-2802-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Before setting the OOB data present flag with SMP pairing, check the
newly introduced present tracking that actual OOB data values have
been provided. The existence of remote OOB data structure does not
actually mean that the correct data values are available.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 37d9180bfe1c..c09a821f381d 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -620,7 +620,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 
 		oob_data = hci_find_remote_oob_data(hdev, &hcon->dst,
 						    bdaddr_type);
-		if (oob_data) {
+		if (oob_data && oob_data->present) {
 			set_bit(SMP_FLAG_OOB, &smp->flags);
 			oob_flag = SMP_OOB_PRESENT;
 			memcpy(smp->rr, oob_data->rand256, 16);
-- 
2.1.0

