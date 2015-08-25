Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: Intel 7260 spontaneous USB disconnect/reconnect every 23h18m07s
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150825171647.GB28893@hau.nz>
Date: Tue, 25 Aug 2015 10:23:21 -0700
Cc: "Ge, Ethan" <ethan.ge@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <DE828595-3ADE-4F8F-8B24-4426C19A8DFF@holtmann.org>
References: <20150819222049.15ca98f0@angwin.home> <86D221DC0B85F94D9B05B97827669A34064C4EF7@PGSMSX106.gar.corp.intel.com> <20150825165238.GA28893@hau.nz> <E5BA38C2-48F1-41C8-9C43-D2C077EBB44B@holtmann.org> <20150825171647.GB28893@hau.nz>
To: Mark Haun <haunma@keteu.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mark,

>>> So I tried this before going away for the weekend, rebooted, and then
>>> checked dmesg when I got back.  The issue is still there, spontaneous
>>> disconnect/reconnect every 23h18m07s like clockwork.
>> 
>> this sounds suspiciously like the validity of the encryption key. I assume
>> your connection is encrypted.
> 
> Sorry, I should have re-iterated in the message, that this is a *USB*
> disconnect/reconnect.  There is actually no bluetooth activity or
> connections at all during this time---bluetoothd is running, but that's it
> (although I am eager to test an IdleTimeout patch when it's available).
> 
> I snipped the dmesg output from earlier in the thread; it looked like this:
> 
> [83894.699185] usb 1-1: USB disconnect, device number 2
> [83894.914720] usb 1-1: new full-speed USB device number 3 using tegra-ehci
> [83895.044528] usb 1-1: New USB device found, idVendor=8087, idProduct=07dc
> [83895.051304] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [83895.076633] Bluetooth: hci0: read Intel version: 3707100180012d0d06
> [83895.082944] Bluetooth: hci0: Intel device is already patched. patch num: 06
> [167782.187624] usb 1-1: USB disconnect, device number 3
> [167782.403343] usb 1-1: new full-speed USB device number 4 using tegra-ehci
> [167782.532645] usb 1-1: New USB device found, idVendor=8087, idProduct=07dc
> [167782.539504] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [167782.564803] Bluetooth: hci0: read Intel version: 3707100180012d0d06
> [167782.571242] Bluetooth: hci0: Intel device is already patched. patch num: 06
> ...
> 
> So, strictly a hardware driver/firmware issue of some kind.  Either that, or
> something quite strange happening on my system which I've not figured out
> yet.  (I do have other USB devices attached, which are not cycling like
> this.)

please run bluemoon -T to enable the LMP tracing feature and then see if you happen to catch the messages before the controller jumps off the bus. I wonder which side initiates the key refresh. Also what is the remote device. You can try hcitool info <bdaddr> to get its features.

As I said before, just running bluemoon should decode the firmware version for you. No need to wildly guess.

In general if the device gets kicked off the USB bus, then something bad happened. The firmware might has crashed or something like that. The fact that the interval is consistent and pretty much the validity period of the encryption key, I bet that something goes wrong with the key refresh procedure.

Regards

Marcel

