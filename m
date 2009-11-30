Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Nov 2009 15:39:15 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: bluetooth cf slow (10KB/sec), lots of dmesg spam
Message-ID: <20091130153915.0a6910e3@lxorguk.ukuu.org.uk>
In-Reply-To: <20091129155801.GA1634@ucw.cz>
References: <20091129155801.GA1634@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

> I believe the problem is 115200 bitrate between system and CF serial;

and lack of flow control I assume ?

> I did setserial baud_base 921600,  but that does not seem to speed it
> up. Do I need to do some special magic to enable high speed?

Just set the baud rate to 921600. You may need to write an app to do this
directly via the TERMIOS2 ioctl because it seems three years ago is a bit
quick for the glibc maintainers to keep up.

Basically set the baud to BOTHER, set the ispeed = ospeed = 921600 and
the kernel will do its best to give you your request

Alan
