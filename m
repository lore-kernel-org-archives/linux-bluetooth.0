Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Aug 2015 16:46:16 -0700
From: Mark Haun <haunma@keteu.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Intel 7260 spontaneous USB disconnect/reconnect every 23h18m07s
Message-ID: <20150825234616.GA5510@hau.nz>
References: <20150819222049.15ca98f0@angwin.home>
 <86D221DC0B85F94D9B05B97827669A34064C4EF7@PGSMSX106.gar.corp.intel.com>
 <20150825165238.GA28893@hau.nz>
 <E5BA38C2-48F1-41C8-9C43-D2C077EBB44B@holtmann.org>
 <20150825171647.GB28893@hau.nz>
 <DE828595-3ADE-4F8F-8B24-4426C19A8DFF@holtmann.org>
 <20150825191523.GA3220@hau.nz>
 <E3B23B91-CC1C-43E7-96BE-3A23692E41DE@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E3B23B91-CC1C-43E7-96BE-3A23692E41DE@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel Holtmann [marcel@holtmann.org] wrote:
> you can run bluemoon with -r switch additionally to any other command. It
> will use raw HCI access and it will also work when the device is up and
> bluetoothd already running.

Ok, that worked (interesting that every switch mentioned so far is
undocumented in 'bluemoon --help' :)

        Hardware Platform:      55
        Hardware Variant:       iBT 2.0 (WP) (0x07)
        Hardware Revision:      1.0
        Firmware Variant:       iBT 1.0 - iBT 2.5 (0x01)
        Firmware Revision:      8.0
        Firmware Build Number:  1-45.2013
        Firmware Patch Number:  6

Of course, I have no way of knowing what the latest firmware is, and whether
I am running it or not.


As mentioned, I am on rc4 right now, so when I upgrade the kernel
"bluemoon -T" should work.  4.2.0 final should be out next weekend, so I may
wait for that.

In the meantime, I am going to watch dmesg with none of the bluez userspace
components running.  I have a hunch the USB disconnect issue will still be
there...

Mark
