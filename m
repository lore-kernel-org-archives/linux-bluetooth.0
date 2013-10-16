Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Remove unused command reject mapping for EMSGSIZE
Date: Wed, 16 Oct 2013 11:06:40 +0300
Message-Id: <1381910801-3130-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1381910801-3130-1-git-send-email-johan.hedberg@gmail.com>
References: <1381910801-3130-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There is no command handler that would return an EMSGSIZE error, so just
remove this mapping from the l2cap_err_to_reason function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7d25ec5..5f2720c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5316,8 +5316,6 @@ static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
 static __le16 l2cap_err_to_reason(int err)
 {
 	switch (err) {
-	case -EMSGSIZE:
-		return __constant_cpu_to_le16(L2CAP_REJ_MTU_EXCEEDED);
 	case -EINVAL:
 	case -EPROTO:
 	default:
-- 
1.8.3.1

