Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Set disc_timeout to 0 when calling hci_chan_del
Date: Mon, 18 Aug 2014 00:41:43 +0300
Message-Id: <1408311704-31747-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1408311704-31747-1-git-send-email-johan.hedberg@gmail.com>
References: <1408311704-31747-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The hci_chan_del() function is used in scenarios where we've decided we
want to get rid of the underlying baseband link. It makes therefore
sense to force the disc_timeout to 0 so that the disconnection routines
are immediately scheduled.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7815826a48e4..cb04a4e3c829 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1316,6 +1316,9 @@ void hci_chan_del(struct hci_chan *chan)
 
 	synchronize_rcu();
 
+	/* Force the connection to be immediately dropped */
+	conn->disc_timeout = 0;
+
 	hci_conn_drop(conn);
 	hci_conn_put(conn);
 
-- 
1.9.3

