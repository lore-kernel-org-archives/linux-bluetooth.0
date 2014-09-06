Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix dereferencing conn variable before NULL check
Date: Sat,  6 Sep 2014 06:59:10 +0300
Message-Id: <1409975950-6110-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch fixes the following type of static analyzer warning (and
probably a real bug as well as the NULL check should be there for a
reason):

net/bluetooth/smp.c:1182 smp_conn_security() warn: variable dereferenced before check 'conn' (see line 1174)

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 1201670afe38..560f78a9f960 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1210,7 +1210,7 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
-	struct l2cap_chan *chan = conn->smp;
+	struct l2cap_chan *chan;
 	struct smp_chan *smp;
 	__u8 authreq;
 	int ret;
@@ -1221,6 +1221,8 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 	if (!conn)
 		return 1;
 
+	chan = conn->smp;
+
 	if (!test_bit(HCI_LE_ENABLED, &hcon->hdev->dev_flags))
 		return 1;
 
-- 
1.9.3

