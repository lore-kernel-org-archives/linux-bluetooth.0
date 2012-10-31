Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 02/12] Bluetooth: Save hs_hchan instead of hs_hcon in loglink complete
Date: Wed, 31 Oct 2012 15:46:27 +0200
Message-Id: <1351691197-8394-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1351691197-8394-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350493622.26318.114.camel@aeonflux>
 <1351691197-8394-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When logical link creation is completed we need to save hs_hchan
which represents logical link instead of hs_hcon representing
physical link. hs_hcon shall be saved when receiving physical link
complete event.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c2fbaf9..4ef85d2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4375,7 +4375,7 @@ static void l2cap_logical_finish_create(struct l2cap_chan *chan,
 {
 	struct l2cap_conf_rsp rsp;
 
-	chan->hs_hcon = hchan->conn;
+	chan->hs_hchan = hchan;
 	chan->hs_hcon->l2cap_data = chan->conn;
 
 	l2cap_send_efs_conf_rsp(chan, &rsp, chan->ident, 0);
-- 
1.7.9.5

