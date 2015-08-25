Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Aug 2015 10:16:47 -0700
From: Mark Haun <haunma@keteu.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Ge, Ethan" <ethan.ge@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Intel 7260 spontaneous USB disconnect/reconnect every 23h18m07s
Message-ID: <20150825171647.GB28893@hau.nz>
References: <20150819222049.15ca98f0@angwin.home>
 <86D221DC0B85F94D9B05B97827669A34064C4EF7@PGSMSX106.gar.corp.intel.com>
 <20150825165238.GA28893@hau.nz>
 <E5BA38C2-48F1-41C8-9C43-D2C077EBB44B@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E5BA38C2-48F1-41C8-9C43-D2C077EBB44B@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Marcel Holtmann [marcel@holtmann.org] wrote:
> > So I tried this before going away for the weekend, rebooted, and then
> > checked dmesg when I got back.  The issue is still there, spontaneous
> > disconnect/reconnect every 23h18m07s like clockwork.
> 
> this sounds suspiciously like the validity of the encryption key. I assume
> your connection is encrypted.

Sorry, I should have re-iterated in the message, that this is a *USB*
disconnect/reconnect.  There is actually no bluetooth activity or
connections at all during this time---bluetoothd is running, but that's it
(although I am eager to test an IdleTimeout patch when it's available).

I snipped the dmesg output from earlier in the thread; it looked like this:

[83894.699185] usb 1-1: USB disconnect, device number 2
[83894.914720] usb 1-1: new full-speed USB device number 3 using tegra-ehci
[83895.044528] usb 1-1: New USB device found, idVendor=8087, idProduct=07dc
[83895.051304] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[83895.076633] Bluetooth: hci0: read Intel version: 3707100180012d0d06
[83895.082944] Bluetooth: hci0: Intel device is already patched. patch num: 06
[167782.187624] usb 1-1: USB disconnect, device number 3
[167782.403343] usb 1-1: new full-speed USB device number 4 using tegra-ehci
[167782.532645] usb 1-1: New USB device found, idVendor=8087, idProduct=07dc
[167782.539504] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[167782.564803] Bluetooth: hci0: read Intel version: 3707100180012d0d06
[167782.571242] Bluetooth: hci0: Intel device is already patched. patch num: 06
...

So, strictly a hardware driver/firmware issue of some kind.  Either that, or
something quite strange happening on my system which I've not figured out
yet.  (I do have other USB devices attached, which are not cycling like
this.)

Mark
