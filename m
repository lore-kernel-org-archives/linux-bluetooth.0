Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 4/4] Bluetooth: AMP: Set no FCS for incoming L2CAP chan
Date: Tue, 20 Nov 2012 17:16:22 +0200
Message-Id: <1353424582-26042-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1353424582-26042-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <20121119212812.GB14006@joana>
 <1353424582-26042-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When receiving L2CAP Create Channel Request set the channel as
L2CAP_FCS_NONE. Then in "L2CAP Config req" following field will
be set: "FCS Option 0x00 (No FCS)". So by default High Speed
channels have no FCS.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f44c542..b52f66d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4286,6 +4286,7 @@ static int l2cap_create_channel_req(struct l2cap_conn *conn,
 
 		mgr->bredr_chan = chan;
 		chan->hs_hcon = hs_hcon;
+		chan->fcs = L2CAP_FCS_NONE;
 		conn->mtu = hdev->block_mtu;
 	}
 
-- 
1.7.10.4

