Return-Path: <cyrus@holtmann.org>
Date: Sun, 5 Jan 2014 16:49:42 +0100
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: andrey.vihrov@gmail.com
Cc: peter@hurleysoftware.com, marcel@holtmann.org,
	gregkh@linuxfoundation.org, jslaby@suse.cz,
	linux-bluetooth@vger.kernel.org
Subject: Re: A problem with "rfcomm bind" and wvdial
Message-ID: <20140105154942.GA12621@sottospazio.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I looked at your problem this afternoon and I think I know what's happening:
wvdial is opening the port with the flag O_NONBLOCK. As expected the rfcomm
code returns immediately instead of waiting for the BT connection to come
up. Then wvdial sends the AT commands and the writes fail.

In the past it worked because the carrier_raised() logic was open coded inside
the rfcomm code: it always waited for a successful or failed connection even
with a non-blocking tty.

But now the code uses the tty_port methods and won't wait for a successful
bluetooth connection on open().

But there is more: when wvdial terminates, it will set the CLOCAL flag for the
tty and this will result in the same behaviour described above, even without
setting the O_NONBLOCK flag. This will affect other users of the tty.

These two cases make clear that the use of carrier_raised() method was not that
fair after all: while that allowed us to remove some code we now have to work
around it to get the previous behaviour.

For example we could mask off the O_NONBLOCK flag before opening the port and
then restore it when the tty_port_open() is completed. We could do something
similar for the CLOCAL flag: always remove it in rfcomm_tty_set_termios().

The alternative is to remove the carrier_raised() method and wait for the BT
connection in rfcomm_dev_activate() like the old code did.

I'm CC-ing some people who know the code better than me to get a suggestion
on how to proceed.

Thank you,
Gianluca
