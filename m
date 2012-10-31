Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 04/12] Bluetooth: Derive remote and local amp id from chan struct
Date: Wed, 31 Oct 2012 15:46:29 +0200
Message-Id: <1351691197-8394-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1351691197-8394-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350493622.26318.114.camel@aeonflux>
 <1351691197-8394-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

l2cap_chan already keeps information about *_amp_id.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d51741f..782e49c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4573,9 +4573,11 @@ static void l2cap_do_move_cancel(struct l2cap_chan *chan, int result)
 	l2cap_ertm_send(chan);
 }
 
-void l2cap_physical_cfm(struct l2cap_chan *chan, int result, u8 local_amp_id,
-			u8 remote_amp_id)
+void l2cap_physical_cfm(struct l2cap_chan *chan, int result)
 {
+	u8 local_amp_id = chan->local_amp_id;
+	u8 remote_amp_id = chan->ctrl_id;
+
 	BT_DBG("chan %p, result %d, local_amp_id %d, remote_amp_id %d",
 	       chan, result, local_amp_id, remote_amp_id);
 
-- 
1.7.9.5

