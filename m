Return-Path: <cyrus@holtmann.org>
Message-ID: <1225132303.4906090f12442@webmail.vt.edu>
Date: Mon, 27 Oct 2008 14:31:43 -0400
From: Matt Witherspoon <spoon@vt.edu>
To: linux-bluetooth@vger.kernel.org
Cc: David Vrabel <david.vrabel@csr.com>
Subject: Re: Problems & crash with Bluecore6 and SDIO driver
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Quoting David Vrabel <david.vrabel@csr.com>:
> Deep sleep control is done on a per-function basis so you need to write
> 0x11 to disable deep sleep on function 1 (the bluetooth function).

Thanks for the response, David.

Applying Tomas' patch does indeed fix the crash.
I put a sdio_f0_writeb(data->func, 0x11, 0xf0, NULL); in btsdio_open(). This
register write does seem to have some effect. Without it, idle current was
0.6mA. With the write, idle current is around 2.5mA. However, the BC6 still
will not respond to commands after being idle for several seconds. Or, it will
respond but with bogus data (like a features bitfield of all 0x00s).

Then, I realized that if I run this command:
hciconfig hci0 up ; bccmd psset -s psram -r 0x0229 0
along with the register write, everything works great. I appear to have to do
both: the register write and the PSKEY setting. One or the other alone is not
sufficient.

Does this seem correct to you? I can't see how btsdio could work on a BC6
without following this process, unless I have a old bad firmware or something.

Thanks -Matt
