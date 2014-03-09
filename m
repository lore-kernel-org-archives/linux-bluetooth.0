Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Distribute configured signature resolving key over SMP
Date: Sat,  8 Mar 2014 23:06:04 -0800
Message-Id: <1394348764-6722-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the connection signature resolving key (CSRK) is requested over
SMP and it has been configured from userspace, then distribute it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 6 ++++--
 net/bluetooth/smp.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index f886bcae1b7e..a98a902eadf1 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -298,6 +298,9 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 		return;
 	}
 
+	if (memcmp(hdev->csrk, SMP_KEY_NONE, 16))
+		local_dist |= SMP_DIST_SIGN;
+
 	rsp->io_capability = conn->hcon->io_capability;
 	rsp->oob_flag = SMP_OOB_NOT_PRESENT;
 	rsp->max_key_size = SMP_MAX_ENC_KEY_SIZE;
@@ -1275,8 +1278,7 @@ int smp_distribute_keys(struct l2cap_conn *conn)
 	if (*keydist & SMP_DIST_SIGN) {
 		struct smp_cmd_sign_info sign;
 
-		/* Send a dummy key */
-		get_random_bytes(sign.csrk, sizeof(sign.csrk));
+		memcpy(sign.csrk, hdev->csrk, sizeof(sign.csrk));
 
 		smp_send_cmd(conn, SMP_CMD_SIGN_INFO, sizeof(sign), &sign);
 
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index f55d83617218..522e11aa73e8 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -123,6 +123,8 @@ struct smp_cmd_security_req {
 
 #define SMP_REENCRYPT_TIMEOUT	msecs_to_jiffies(250)
 
+#define SMP_KEY_NONE (&(u8[16]) {0, })
+
 struct smp_chan {
 	struct l2cap_conn *conn;
 	u8		preq[7]; /* SMP Pairing Request */
-- 
1.8.5.3

