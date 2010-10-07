Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Oct 2010 21:41:34 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, marcel@holtmann.org,
        linux-bluetooth@vger.kernel.org
Subject: Peculiar stuff in hci_ath3k/badness in hci_uart
Message-ID: <20101007214134.6bcd2e8f@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

Noticed this while looking at Savoy's stuff


ath_wakeup_ar3k:

       int status = tty->driver->ops->tiocmget(tty, NULL);

Now if the tty driver it is bound to happens to use the file pointer or
worse still call into its file->ops badness is going to occur. Doubly fun
is this - a NULL tiocmget is perfectly acceptable and some drivers don't
have one. In the case of serial or usb core using code your backside is
saved by luck. For other hardware well the SELinux page 0 mapping stuff
will save your backside, and probably if enabled the sysctl bit on
current kernels, but if not - oh dear me.

It continues....

(kernel space)
	struct termios settings;


        n_tty_ioctl_helper(tty, NULL, TCGETS, (unsigned long)&settings);
        settings.c_cflag &= ~CRTSCTS;
        n_tty_ioctl_helper(tty, NULL, TCSETS, (unsigned long)&settings);

n_tty_ioctl_helper expects a user space pointer.


I've not reviewed it for security impacts. I'd imagine you can oops the
kernel happily with it and maybe more via the NULL pointers if suitable
obscure hardware happens to be present. My gut feeling is that for most
x86 boxes the worst will be an Oops or very bizarre behaviour because they
won't have any suitable serial ports you can hit or have permission to
access.

tiocmget needs a file pointer because some devices check for hangups
here. Now in fact it would actually make sense to move that into the core
code and see if we can kill the file pointer but right now it doesn't
seem safe.

The ioctl helper stuff can either use the ugly set_fs hackery or better
yet shove a helper in the kernel tree to get or set kernel termios which
just takes a struct ktermios and does the right mutex locks and ops calls
checks for NULL ops.

I can find no record of this code having been anywhere near
linux-kernel/linux-serial, which is a pity because after we'd mopped up
our spilled drinks the bug would have been reported.

Fortunately I looked further and the further I looked the more fun it gets

in hci_uart we have

                len = tty->ops->write(tty, skb->data, skb->len);

but I can't find anywhere we check that the tty has a write op (a few
don't), and you should check this at open and refuse if the ops you need
don't exist (eg as SLIP does:

static int slip_open(struct tty_struct *tty)
{
        struct slip *sl;
        int err;

        if (!capable(CAP_NET_ADMIN))
                return -EPERM;

        if (tty->ops->write == NULL)
                return -EOPNOTSUPP;

Fortunately almost no system will have a driver loaded which lacks a
write op, but this should be fixed.


Alan
