Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sat, 22 Apr 2017 08:26:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Barry Byford <31baz66@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Subject: Re: Serial Port connection with DBus API
Message-ID: <20170422052644.GA31652@x1c>
References: <CAAu3APbw0JyPfKUi6PZ4Nr2Uh5WXtDprDVFBTj3xr+801b9L6w@mail.gmail.com>
 <CAAu3APbMKQY2dnD=TUAb_3BqFKk0s2bzuFFLX8=h-1g7gm8G=Q@mail.gmail.com>
 <20170408071834.GA12144@x1c>
 <CAAu3APahskA_b2Ydt8TzUWBQnkuC10UwjZ37RaOyhAt4s1iyiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAAu3APahskA_b2Ydt8TzUWBQnkuC10UwjZ37RaOyhAt4s1iyiQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Barry,

On Fri, Apr 21, 2017, Barry Byford wrote:
> >> >             'Channel': GLib.Variant('i', 1),
...
> However I'm now seeing this error appear in btmon when I try to bind
> to the RFCOMM socket:
> 
> = bluetoothd: RFCOMM server failed for SerialPort: rfcomm_bind:
> Address already in use (98)

I think that means that you already have some other service listening on
RFCOMM channel 1. Try using some other channel, or identify and stop the
other service that's using channel 1. You can find the per-profile
recommended channels (to avoid conflicts) in doc/assigned-numbers.txt in
the BlueZ source tree. Pure SPP doesn't seem to be listed there, so you
could just pick one that's not yet allocated.

Johan
