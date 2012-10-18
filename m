Return-Path: <cyrus@holtmann.org>
From: Jiri Slaby <jslaby@suse.cz>
To: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com,
	linux-kernel@vger.kernel.org,
	jirislaby@gmail.com,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/21] TTY: hci_ldisc, remove invalid check in open
Date: Thu, 18 Oct 2012 22:26:34 +0200
Message-Id: <1350592007-9216-9-git-send-email-jslaby@suse.cz>
In-Reply-To: <1350592007-9216-1-git-send-email-jslaby@suse.cz>
References: <1350592007-9216-1-git-send-email-jslaby@suse.cz>
List-ID: <linux-bluetooth.vger.kernel.org>

hci_ldisc's open checks if tty_struct->disc_data is set. And if so it
returns with an error. But nothing ensures disc_data to be NULL. And
since ld->ops->open shall be called only once, we do not need the
check at all. So remove it.

Note that this is not an issue now, but n_tty will start using the
disc_data pointer and this invalid 'if' would trigger then rendering
TTYs over BT unusable.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
---
 drivers/bluetooth/hci_ldisc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index c8abce3..ed0fade 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -270,15 +270,10 @@ static int hci_uart_send_frame(struct sk_buff *skb)
  */
 static int hci_uart_tty_open(struct tty_struct *tty)
 {
-	struct hci_uart *hu = (void *) tty->disc_data;
+	struct hci_uart *hu;
 
 	BT_DBG("tty %p", tty);
 
-	/* FIXME: This btw is bogus, nothing requires the old ldisc to clear
-	   the pointer */
-	if (hu)
-		return -EEXIST;
-
 	/* Error if the tty has no write op instead of leaving an exploitable
 	   hole */
 	if (tty->ops->write == NULL)
-- 
1.7.12.3
