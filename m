Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/6] Bluetooth: Add SMP flag to track which side is the initiator
Date: Mon, 24 Mar 2014 15:54:11 +0200
Message-Id: <1395669251-20128-1-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1395664748-13494-5-git-send-email-johan.hedberg@gmail.com>
References: <1395664748-13494-5-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

For remotely initiated just-works pairings we want to show the user a
confirmation dialog for the pairing. However, we can only know which
side was the initiator by tracking which side sends the first Security
Request or Pairing Request PDU. This patch adds a new SMP flag to
indicate whether our side was the initiator for the pairing.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
v2: Fix potential NULL dereference in smp_cmd_security_req()

 net/bluetooth/smp.c | 6 ++++++
 net/bluetooth/smp.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 97e95c849fff..1b28f5fd798f 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -716,6 +716,8 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (ret)
 		return SMP_UNSPECIFIED;
 
+	clear_bit(SMP_FLAG_INITIATOR, &smp->smp_flags);
+
 	return 0;
 }
 
@@ -871,6 +873,8 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
 
+	clear_bit(SMP_FLAG_INITIATOR, &smp->smp_flags);
+
 	return 0;
 }
 
@@ -939,6 +943,8 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 	}
 
 done:
+	set_bit(SMP_FLAG_INITIATOR, &smp->smp_flags);
+
 	hcon->pending_sec_level = sec_level;
 
 	return 0;
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index b6913471815a..0d536b8b3f9a 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -120,6 +120,7 @@ struct smp_cmd_security_req {
 #define SMP_FLAG_MITM_AUTH	3
 #define SMP_FLAG_LTK_ENCRYPT	4
 #define SMP_FLAG_COMPLETE	5
+#define SMP_FLAG_INITIATOR	6
 
 #define SMP_REENCRYPT_TIMEOUT	msecs_to_jiffies(500)
 
-- 
1.8.5.3

