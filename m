Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Oct 2012 08:26:08 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: Mat Martineau <mathewm@codeaurora.org>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: l2cap_physical_cfm() can be static
Message-ID: <20121025002608.GA10418@localhost>
References: <508863c1.QTbySMnQ9kj6jDZz%fengguang.wu@intel.com>
 <20121024220131.GB3030@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121024220131.GB3030@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 net/bluetooth/l2cap_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next.orig/net/bluetooth/l2cap_core.c	2012-10-25 08:23:52.456742699 +0800
+++ linux-next/net/bluetooth/l2cap_core.c	2012-10-25 08:23:55.056742760 +0800
@@ -4569,7 +4569,7 @@ static void l2cap_do_move_cancel(struct
 	l2cap_ertm_send(chan);
 }
 
-void l2cap_physical_cfm(struct l2cap_chan *chan, int result, u8 local_amp_id,
+static void l2cap_physical_cfm(struct l2cap_chan *chan, int result, u8 local_amp_id,
 			u8 remote_amp_id)
 {
 	BT_DBG("chan %p, result %d, local_amp_id %d, remote_amp_id %d",
