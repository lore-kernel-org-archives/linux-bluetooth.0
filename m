Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] Bluetooth: Remove unnecessary hcon->smp_conn variable
Date: Fri, 27 Jun 2014 14:23:07 +0300
Message-Id: <1403868187-19396-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1403868187-19396-1-git-send-email-johan.hedberg@gmail.com>
References: <1403868187-19396-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The smp_conn member of struct hci_conn was simply a pointer to the
l2cap_conn object. Since we already have hcon->l2cap_data that points to
the same thing there's no need to have this second variable. This patch
removes it and changes the single place that was using it to use
hcon->l2cap_data instead.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 1 -
 net/bluetooth/smp.c              | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index dda7f00c07c5..ca2a99807615 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -409,7 +409,6 @@ struct hci_conn {
 	struct hci_dev	*hdev;
 	void		*l2cap_data;
 	void		*sco_data;
-	void		*smp_conn;
 	struct amp_mgr	*amp_mgr;
 
 	struct hci_conn	*link;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 641ce8b69d2a..414c5151aa46 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -584,7 +584,6 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 
 	smp->conn = conn;
 	conn->smp_chan = smp;
-	conn->hcon->smp_conn = conn;
 
 	hci_conn_hold(conn->hcon);
 
@@ -626,13 +625,12 @@ void smp_chan_destroy(struct l2cap_conn *conn)
 
 	kfree(smp);
 	conn->smp_chan = NULL;
-	conn->hcon->smp_conn = NULL;
 	hci_conn_drop(conn->hcon);
 }
 
 int smp_user_confirm_reply(struct hci_conn *hcon, u16 mgmt_op, __le32 passkey)
 {
-	struct l2cap_conn *conn = hcon->smp_conn;
+	struct l2cap_conn *conn = hcon->l2cap_data;
 	struct smp_chan *smp;
 	u32 value;
 
-- 
1.9.3

