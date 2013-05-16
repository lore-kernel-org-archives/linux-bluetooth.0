Return-Path: <cyrus@holtmann.org>
Message-ID: <5194DBF2.60209@ahsoftware.de>
Date: Thu, 16 May 2013 15:15:30 +0200
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Jiri Slaby <jslaby@suse.cz>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 linux-bluetooth@vger.kernel.org
Subject: Re: BUG: tty: memory corruption through tty_release/tty_ldisc_release
References: <519480A1.6030909@ahsoftware.de>
In-Reply-To: <519480A1.6030909@ahsoftware.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Am 16.05.2013 08:45, schrieb Alexander Holler:

> tty_port is self-destructing, that means it destroys itself in
> tty_port.c:tty_port_destructor() when the last reference is gone. E.g.
> in case of rfcomm this happens with the call to tty->ops->close() in
> tty_io.c:tty_release().
>
> The problem here is that tty_io.c:tty_release() calls
> tty_ldisc.c:tty_ldisc_release() which uses the tty_port to flush the
> ldisc work queues.

As I've got a bit nervous if ptys are affected, I've played a bit around 
using the following patch:

--------------
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 84ec4ca..340440b 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1790,6 +1790,7 @@ int tty_release(struct inode *inode, struct file 
*filp)
         if (!tty_closing || (o_tty && !o_tty_closing))
                 return 0;

+pr_info("AHO: tty_release tty_port 0x%p\n", tty->port);
  #ifdef TTY_DEBUG_HANGUP
         printk(KERN_DEBUG "%s: freeing tty structure...\n", __func__);
  #endif
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index b7ff59d..346e30b 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -139,6 +139,7 @@ EXPORT_SYMBOL(tty_port_destroy);
  static void tty_port_destructor(struct kref *kref)
  {
         struct tty_port *port = container_of(kref, struct tty_port, kref);
+pr_info("AHO: tty_port_destructor 0x%p\n", port);
         if (port->xmit_buf)
                 free_page((unsigned long)port->xmit_buf);
         tty_port_destroy(port);
--------------

Happily it looks like ptys are not affected, the destructor seems to be 
always called after tty_release() and not before. But I'm not sure if I 
tried all possible ways (from userland).

Regards,

Alexander Holler
