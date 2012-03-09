Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Correct ediv in SMP
Date: Fri,  9 Mar 2012 14:43:27 +0200
Message-Id: <1331297007-7119-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---

 Send this as RFC as I am not 100% sure that it is correct

 include/net/bluetooth/smp.h |    2 +-
 net/bluetooth/smp.c         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/smp.h b/include/net/bluetooth/smp.h
index 7b3acdd..ca356a7 100644
--- a/include/net/bluetooth/smp.h
+++ b/include/net/bluetooth/smp.h
@@ -77,7 +77,7 @@ struct smp_cmd_encrypt_info {
 
 #define SMP_CMD_MASTER_IDENT	0x07
 struct smp_cmd_master_ident {
-	__u16	ediv;
+	__le16	ediv;
 	__u8	rand[8];
 } __packed;
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index deb1198..6fc7c47 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -956,7 +956,7 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 			    HCI_SMP_LTK_SLAVE, 1, authenticated,
 			    enc.ltk, smp->enc_key_size, ediv, ident.rand);
 
-		ident.ediv = cpu_to_le16(ediv);
+		ident.ediv = ediv;
 
 		smp_send_cmd(conn, SMP_CMD_MASTER_IDENT, sizeof(ident), &ident);
 
-- 
1.7.9

