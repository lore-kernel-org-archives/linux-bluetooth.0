Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 11/13] Bluetooth: Remove support for other SMP keys than the LTK
Date: Thu, 25 Aug 2011 20:02:37 -0300
Message-Id: <1314313359-12652-12-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1314313359-12652-1-git-send-email-vcgomes@gmail.com>
References: <1314313359-12652-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

For now, only the LTK is properly supported. We are able to receive
and generate the other types of keys, but we are not able to use
them. So it's better not request them to be distributed.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 5e6ee28..2a96621 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -213,7 +213,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 
 	dist_keys = 0;
 	if (test_bit(HCI_PAIRABLE, &conn->hcon->hdev->flags)) {
-		dist_keys = SMP_DIST_ENC_KEY | SMP_DIST_ID_KEY | SMP_DIST_SIGN;
+		dist_keys = SMP_DIST_ENC_KEY;
 		authreq |= SMP_AUTH_BONDING;
 	}
 
-- 
1.7.6

