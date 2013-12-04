Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/31] Bluetooth: Move LE L2CAP initiator procedure to its own function
Date: Wed,  4 Dec 2013 16:11:02 +0200
Message-Id: <1386166287-13693-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386166287-13693-1-git-send-email-johan.hedberg@gmail.com>
References: <1386166287-13693-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Once connection oriented L2CAP channels over LE are supported they will
need a completely separate handling from BR/EDR channels.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index eafcdf65718b..d250d8af7fd6 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1170,12 +1170,17 @@ static void l2cap_start_connection(struct l2cap_chan *chan)
 	}
 }
 
+static void l2cap_le_start(struct l2cap_chan *chan)
+{
+	l2cap_chan_ready(chan);
+}
+
 static void l2cap_do_start(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
 
 	if (conn->hcon->type == LE_LINK) {
-		l2cap_chan_ready(chan);
+		l2cap_le_start(chan);
 		return;
 	}
 
-- 
1.8.4.2

