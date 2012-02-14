Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Feb 2012 19:23:14 +0100
From: Fabrice DELENTE <delentef@gmail.com>
To: David Herrmann <dh.herrmann@googlemail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Entering the PIN of a device?
Message-ID: <20120214182314.GA18195@smtp.free.fr>
References: <20120214164518.GA11881@smtp.free.fr>
 <CANq1E4QEeoFr4HC+DajcsPt_BNNgzsp8-_7tRFVOOVin1atTEA@mail.gmail.com>
 <20120214175813.GA16393@smtp.free.fr>
 <CANq1E4Q7UQjQNKPy0c-w4DX8dimuRNYB_mOsetMBNPaY44Ae5A@mail.gmail.com>
 <20120214180937.GA17364@smtp.free.fr>
 <CANq1E4R0xkzJF8CebBFkc5R=idO=cEPciK2XQW9Yv9nWuWGnGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CANq1E4R0xkzJF8CebBFkc5R=idO=cEPciK2XQW9Yv9nWuWGnGw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> There was no CC ;) CC is enough of course.

Strange, mutt showed me a CC though...

> No, don't! The user shouldn't care what protocols are used. I just
> wanted to notify you that using rfcomm won't work here.

Ok, ok, won't do :^)

> This is exactly what should happen, yes. No PIN as BlueZ generates
> it for you.

I guess it hasn't, because when I try simple-agent hci0 $WIIMOTE, it
asks for a PIN?

> Did the device show up in /sys/bus/hid/devices ? Did you check
> dmesg? I think you got the device connected successfully, it just
> doesn't do anything useful without configuration ;)

Well nothing showed in /sys/bus/hid/devices, nor in dmesg. The only
thing I had was in /var/log/messages, after trying the simple-agent
hci0 $WIIMOTE thing:

Feb 14 19:11:11 slick dbus-daemon: [system] Rejected send message, 0 matched rules; type="method_return", sender=":1.65" (uid=0 pid=17775 comm="/usr/bin/python) interface="(unset)" member="(unset)" error name="(unset)" requested_reply=0 destination=":1.9" (uid=0 pid=1930 comm="/usr/sbin/bluetoothd))

> You may also want to have a look at
> https://wiki.archlinux.org/index.php/XWiimote This is a short
> summary of the current state of the xwiimote drivers.  The
> user-space part is still under development so you might want to look
> at cwiid instead.

Will do. I thought cwiid was abandonned, and replaced by the kernel
driver?

Thanks again!

-- 
F. Delente
