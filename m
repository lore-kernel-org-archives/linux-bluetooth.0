Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 02/11] Bluetooth: Use helper function sending EFS conf rsp
Date: Thu, 25 Oct 2012 15:20:43 +0300
Message-Id: <1351167652-12346-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1351167652-12346-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350493622.26318.114.camel@aeonflux>
 <1351167652-12346-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

There is helper function used to send EFS Configuration Response.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 962a322..600d808 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4374,16 +4374,11 @@ static void l2cap_logical_finish_create(struct l2cap_chan *chan,
 					struct hci_chan *hchan)
 {
 	struct l2cap_conf_rsp rsp;
-	u8 code;
 
 	chan->hs_hcon = hchan->conn;
 	chan->hs_hcon->l2cap_data = chan->conn;
 
-	code = l2cap_build_conf_rsp(chan, &rsp,
-				    L2CAP_CONF_SUCCESS, 0);
-	l2cap_send_cmd(chan->conn, chan->ident, L2CAP_CONF_RSP, code,
-		       &rsp);
-	set_bit(CONF_OUTPUT_DONE, &chan->conf_state);
+	l2cap_send_efs_conf_rsp(chan, &rsp, chan->ident, 0);
 
 	if (test_bit(CONF_INPUT_DONE, &chan->conf_state)) {
 		int err;
-- 
1.7.9.5

