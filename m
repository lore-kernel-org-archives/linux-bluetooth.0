Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] Bluetooth: Remove not needed l2cap_ertm_data_rcv forward declaration
Date: Tue, 17 Jan 2012 11:42:31 +0100
Message-ID: <1326796951-16377-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1326796951-16377-1-git-send-email-szymon.janc@tieto.com>
References: <1326796951-16377-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

l2cap_ertm_data_rcv is only used after it is defined so there is no
need for forward declaration.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/l2cap_core.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d66c368..003bd40 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -73,8 +73,6 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data);
 static void l2cap_send_disconn_req(struct l2cap_conn *conn,
 				struct l2cap_chan *chan, int err);
 
-static int l2cap_ertm_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb);
-
 /* ---- L2CAP channels ---- */
 
 static struct l2cap_chan *__l2cap_get_chan_by_dcid(struct l2cap_conn *conn, u16 cid)
-- 
on behalf of ST-Ericsson

