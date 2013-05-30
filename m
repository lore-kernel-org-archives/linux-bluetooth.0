Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 May 2013 11:05:10 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: [patch] Bluetooth: check for (harmless) underflow
Message-ID: <20130530080510.GD8148@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

"len" can be negative here.  It's harmless but pretty subtle and
scary looking so lets add a check for it.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a1b7a02..438f39e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4069,6 +4069,9 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 	BT_DBG("scid 0x%4.4x flags 0x%2.2x result 0x%2.2x len %d", scid, flags,
 	       result, len);
 
+	if (len < 0)
+		return -EINVAL;
+
 	chan = l2cap_get_chan_by_scid(conn, scid);
 	if (!chan)
 		return 0;
