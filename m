Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH v2 13/13] Bluetooth: Disconnect the link if Encryption on LE links fails
Date: Thu, 25 Aug 2011 20:02:39 -0300
Message-Id: <1314313359-12652-14-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1314313359-12652-1-git-send-email-vcgomes@gmail.com>
References: <1314313359-12652-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With the last commit this solves a security issue, in the case
that a device spoofs the address of an already bonded device, if
we try encryption, we will receive an error that there's no agreed
key between those devices.

The solution is to disconnect the link as soon as the error is
detected and report the error. So the user can remove the ofending
key and start the pairing process from the begining.

Signed-off-by: Vinicius Costa Gomes <vcgomes@gmail.com>
---
 net/bluetooth/l2cap_core.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index cff4475..34f66b6 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4034,10 +4034,11 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 	BT_DBG("conn %p", conn);
 
-	if (hcon->type == LE_LINK) {
+	if (hcon->type == LE_LINK && !status) {
 		smp_distribute_keys(conn, 0);
 		del_timer(&conn->security_timer);
-	}
+	} else if (hcon->type == LE_LINK)
+		l2cap_conn_del(hcon, bt_to_errno(status));
 
 	read_lock(&conn->chan_lock);
 
-- 
1.7.6

