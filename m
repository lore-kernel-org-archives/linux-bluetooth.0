Return-Path: <cyrus@holtmann.org>
From: Hemant Gupta <hemant.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Hemant Gupta <hemant.gupta@stericsson.com>
Subject: [PATCH v1] Bluetooth: Update L2CAP Channel State for LE Link during Pairing
Date: Thu, 19 Apr 2012 21:15:42 +0530
Message-ID: <1334850342-23063-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates the L2CAP Channel state to Connected when LE Link
is established, so that data transmission can start on CID 4.
Without this fix if remote side sends data on CID 4 immidiately after
LE Link was established, data was being discarded in l2cap_att_channel()
API because channel state was still BT_CONNECT when SMP pairing is in
progress. This was resulting in disconnection from remote side after 30 seconds
since ATT request was not answered by user space as data was discarded.

Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
---
 net/bluetooth/l2cap_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 15478b3..ef0cc91 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1189,7 +1189,7 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 		l2cap_chan_lock(chan);
 
 		if (conn->hcon->type == LE_LINK) {
-			if (smp_conn_security(conn, chan->sec_level))
+			if (!smp_conn_security(conn, chan->sec_level))
 				l2cap_chan_ready(chan);
 
 		} else if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
-- 
1.7.0.4

