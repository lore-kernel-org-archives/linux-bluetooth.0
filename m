Return-Path: <cyrus@holtmann.org>
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: linux-bluetooth@vger.kernel.org
Cc: peter@hurleysoftware.com,
	gustavo@padovan.org,
	marcel@holtmann.org,
	Gianluca Anzolin <gianluca@sottospazio.it>
Subject: [PATCH v2 7/7] rfcomm: Purge the dlc->tx_queue to avoid circular dependency
Date: Mon, 22 Jul 2013 18:27:15 +0200
Message-Id: <1374510435-12149-7-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1374510435-12149-1-git-send-email-gianluca@sottospazio.it>
References: <1374510435-12149-1-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

In rfcomm_tty_cleanup we purge the dlc->tx_queue which may contain socket
buffers that could prevent the tty_port destruction.

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
---
 net/bluetooth/rfcomm/tty.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 428543e..50b38d7 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -668,6 +668,10 @@ static void rfcomm_tty_cleanup(struct tty_struct *tty)
 	tty->driver_data = NULL;
 	rfcomm_dlc_unlock(dev->dlc);
 
+	/* purge the dlc->tx_queue to avoid circular dependencies
+	 * between dev and dlc */
+	skb_queue_purge(&dev->dlc->tx_queue);
+
 	tty_port_put(&dev->port);
 }
 
-- 
1.8.3.3
