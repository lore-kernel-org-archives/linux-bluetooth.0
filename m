Return-Path: <cyrus@holtmann.org>
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: peter@hurleysoftware.com
Cc: gustavo@padovan.org,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org,
	Gianluca Anzolin <gianluca@sottospazio.it>
Subject: [PATCH v3 6/6] rfcomm: Purge the dlc->tx_queue to avoid circular dependency
Date: Thu, 25 Jul 2013 20:32:13 +0200
Message-Id: <1374777133-12397-6-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1374777133-12397-1-git-send-email-gianluca@sottospazio.it>
References: <1374777133-12397-1-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

In rfcomm_tty_cleanup we purge the dlc->tx_queue which may contain socket
buffers referencing the tty_port and thus preventing the tty_port destruction.

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
---
 net/bluetooth/rfcomm/tty.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 9def67a..1c6bd90 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -667,6 +667,12 @@ static void rfcomm_tty_cleanup(struct tty_struct *tty)
 	tty->driver_data = NULL;
 	rfcomm_dlc_unlock(dev->dlc);
 
+	/*
+	 * purge the dlc->tx_queue to avoid circular dependencies
+	 * between dev and dlc
+	 */
+	skb_queue_purge(&dev->dlc->tx_queue);
+
 	tty_port_put(&dev->port);
 }
 
-- 
1.8.3.3
