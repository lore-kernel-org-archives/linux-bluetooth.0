Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 05/12] Bluetooth: Use chan->state instead of sk->sk_state
Date: Thu, 24 May 2012 19:59:45 -0300
Message-Id: <1337900389-30915-5-git-send-email-gustavo@padovan.org>
In-Reply-To: <1337900389-30915-1-git-send-email-gustavo@padovan.org>
References: <1337900389-30915-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

These vars are kept in sync so we can use chan->state here.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index aa77a93..377dc7e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1444,7 +1444,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 
 	lock_sock(sk);
 
-	switch (sk->sk_state) {
+	switch (chan->state) {
 	case BT_CONNECT:
 	case BT_CONNECT2:
 	case BT_CONFIG:
-- 
1.7.10.1

