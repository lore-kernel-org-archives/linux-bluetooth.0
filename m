Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: remove unnecessary atribution to err var
Date: Sat, 28 Mar 2009 14:47:27 -0300
Message-Id: <1238262449-3321-3-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1238262449-3321-2-git-send-email-gustavo@las.ic.unicamp.br>
References: <1238262449-3321-1-git-send-email-gustavo@las.ic.unicamp.br>
 <1238262449-3321-2-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The init value of err is not used until it is set to -ENOMEM. So we
initialize it directly to -ENOMEM

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 net/bluetooth/l2cap.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index ff1744e..85926f5 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -844,7 +844,7 @@ static int l2cap_do_connect(struct sock *sk)
 	struct hci_conn *hcon;
 	struct hci_dev *hdev;
 	__u8 auth_type;
-	int err = 0;
+	int err = -ENOMEM;
 
 	BT_DBG("%s -> %s psm 0x%2.2x", batostr(src), batostr(dst),
 							l2cap_pi(sk)->psm);
@@ -854,8 +854,6 @@ static int l2cap_do_connect(struct sock *sk)
 
 	hci_dev_lock_bh(hdev);
 
-	err = -ENOMEM;
-
 	if (sk->sk_type == SOCK_RAW) {
 		switch (l2cap_pi(sk)->sec_level) {
 		case BT_SECURITY_HIGH:
-- 
1.6.0.6

