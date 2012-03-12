Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/6] Bluetooth: Correct ediv in SMP
Date: Mon, 12 Mar 2012 12:13:06 +0200
Message-Id: <1331547191-15307-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1331547191-15307-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331547191-15307-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
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

