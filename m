Return-Path: <cyrus@holtmann.org>
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: gustavo@padovan.org
Cc: peter@hurleysoftware.com,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jslaby@suse.cz,
	Gianluca Anzolin <gianluca@sottospazio.it>
Subject: [PATCH v5 6/6] rfcomm: Purge the dlc->tx_queue to avoid circular dependency
Date: Mon, 29 Jul 2013 17:08:13 +0200
Message-Id: <1375110493-5237-7-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1375110493-5237-1-git-send-email-gianluca@sottospazio.it>
References: <1375110493-5237-1-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

In rfcomm_tty_cleanup we purge the dlc->tx_queue which may contain
socket buffers referencing the tty_port and thus preventing the tty_port
destruction.

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
---
 net/bluetooth/rfcomm/tty.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 3e078b7..6d126fa 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -668,6 +668,12 @@ static void rfcomm_tty_cleanup(struct tty_struct *tty)
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
1.8.3.4
