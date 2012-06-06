Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Fix SMP pairing method selection
Date: Wed,  6 Jun 2012 18:44:10 +0800
Message-Id: <1338979451-15851-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The tk_request function takes the local IO capability as the second last
parameter and the remote IO capability as the first parameter. They were
previously swapped: when we receive a pairing response
req->io_capability contains the local one and rsp->io_capability the
remote one.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index ff4835b..1885697 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -649,7 +649,7 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	auth |= (req->auth_req | rsp->auth_req) & SMP_AUTH_MITM;
 
-	ret = tk_request(conn, 0, auth, rsp->io_capability, req->io_capability);
+	ret = tk_request(conn, 0, auth, req->io_capability, rsp->io_capability);
 	if (ret)
 		return SMP_UNSPECIFIED;
 
-- 
1.7.10

