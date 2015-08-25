Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Aug 2015 11:11:48 -0700
From: Mark Haun <haunma@keteu.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Intel 7260 spontaneous USB disconnect/reconnect every 23h18m07s
Message-ID: <20150825181148.GC28893@hau.nz>
References: <20150819222049.15ca98f0@angwin.home>
 <86D221DC0B85F94D9B05B97827669A34064C4EF7@PGSMSX106.gar.corp.intel.com>
 <20150825165238.GA28893@hau.nz>
 <E5BA38C2-48F1-41C8-9C43-D2C077EBB44B@holtmann.org>
 <20150825171647.GB28893@hau.nz>
 <DE828595-3ADE-4F8F-8B24-4426C19A8DFF@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DE828595-3ADE-4F8F-8B24-4426C19A8DFF@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel Holtmann [marcel@holtmann.org] wrote:
> > [83894.699185] usb 1-1: USB disconnect, device number 2
> > [83894.914720] usb 1-1: new full-speed USB device number 3 using tegra-ehci
> > [83895.044528] usb 1-1: New USB device found, idVendor=8087, idProduct=07dc
> > [83895.051304] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> > [83895.076633] Bluetooth: hci0: read Intel version: 3707100180012d0d06
> > [83895.082944] Bluetooth: hci0: Intel device is already patched. patch num: 06
> > [167782.187624] usb 1-1: USB disconnect, device number 3
> > [167782.403343] usb 1-1: new full-speed USB device number 4 using tegra-ehci
> > [167782.532645] usb 1-1: New USB device found, idVendor=8087, idProduct=07dc
> > [167782.539504] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> > [167782.564803] Bluetooth: hci0: read Intel version: 3707100180012d0d06
> > [167782.571242] Bluetooth: hci0: Intel device is already patched. patch num: 06
> 
> please run bluemoon -T to enable the LMP tracing feature and then see if
> you happen to catch the messages before the controller jumps off the bus. 
> I wonder which side initiates the key refresh.  Also what is the remote
> device.  You can try hcitool info <bdaddr> to get its features.

Ok.  It might be a few days before I get time.  Debian doesn't package this
so I'll need to build bluez from source, which I ought to do anyway for the
PS3 remote issues.

There is no remote device.  As far as I am aware there is no bluetooth RF
activity whatsoever.  Well, I did pair with my Android phone last week as a
test, but its bluetooth is currently switched off.  The PS3 remote is also
in bluez' database, but it is also turned off (batteries removed).

> As I said before, just running bluemoon should decode the firmware version
> for you.  No need to wildly guess.

Cool.  Although I would like Ethan to clarify how the firmware files are
named, how he was able to deduce a version from my dmesg output, and whether
the new observation matches his expectation.  There could be some issue
where the driver isn't loading the latest firmware on disk.

Mark
