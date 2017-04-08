Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sat, 8 Apr 2017 10:18:34 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Barry Byford <31baz66@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Subject: Re: Serial Port connection with DBus API
Message-ID: <20170408071834.GA12144@x1c>
References: <CAAu3APbw0JyPfKUi6PZ4Nr2Uh5WXtDprDVFBTj3xr+801b9L6w@mail.gmail.com>
 <CAAu3APbMKQY2dnD=TUAb_3BqFKk0s2bzuFFLX8=h-1g7gm8G=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAAu3APbMKQY2dnD=TUAb_3BqFKk0s2bzuFFLX8=h-1g7gm8G=Q@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Barry,

On Fri, Apr 07, 2017, Barry Byford wrote:
> = bluetoothd: Invalid value for profile option Channel

Let's look at your code:

> >             'Channel': GLib.Variant('i', 1),

Yep, that's wrong. The expected D-Bus type for 'Channel' is UINT16,
which is 'q' and not 'i'.

> = bluetoothd: RFCOMM server failed for SerialPort: socket(STREAM,
> RFCOMM): Protocol not supported (93)

That usually means that your kernel is incorrectly configured and
lacking RFCOMM support.

Johan
