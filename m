Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 09/13] Bluetooth: Fix not setting a pending security level
Date: Thu, 25 Aug 2011 20:02:35 -0300
Message-Id: <1314313359-12652-10-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1314313359-12652-1-git-send-email-vcgomes@gmail.com>
References: <1314313359-12652-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

For slave initiated security, we should set a default security level,
for now BT_SECURITY_MEDIUM.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/smp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 4531681..5e6ee28 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -545,6 +545,8 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	BT_DBG("conn %p", conn);
 
+	hcon->pending_sec_level = BT_SECURITY_MEDIUM;
+
 	if (smp_ltk_encrypt(conn))
 		return 0;
 
-- 
1.7.6

