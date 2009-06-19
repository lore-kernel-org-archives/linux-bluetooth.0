Return-Path: <cyrus@holtmann.org>
From: "Andrew Kohlsmith (Mailing List Account)" <aklists@mixdown.ca>
Reply-To: akohlsmith-lists@mixdown.ca
To: linux-bluetooth@vger.kernel.org
Subject: Re: omnibook module loads but still can't use bluetooth device
Date: Fri, 19 Jun 2009 00:33:14 -0400
References: <1245274194.3925.13.camel@renato-laptop>
In-Reply-To: <1245274194.3925.13.camel@renato-laptop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200906190033.15149.aklists@mixdown.ca>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On June 17, 2009 05:29:54 pm Renato Budinich wrote:
> renato@renato-laptop:/proc/omnibook$ lsusb
> Bus 003 Device 002: ID 0930:0508 Toshiba Corp. Integrated Bluetooth HCI

> renato@renato-laptop:/proc/omnibook$ sudo lshw -C communication
>   *-usb UNCLAIMED
>        description: Bluetooth wireless interface
>        product: Integrated Bluetooth HCI
>        vendor: Toshiba Corp.
>        physical id: 2
>        bus info: usb@3:2
>        version: 19.15
>        capabilities: bluetooth usb-2.00
>        configuration: speed=12.0MB/s
>
> could the above "UNCLAIMED" be part of the problem?

Yes; it appears that the module is not being recognized as one that is 
supported by any kernel modules.

On my Toshiba U300, I had to specify ectype=14 when I load the omnibook module 
or I don't find any BT device at all.  I don't think that's your problem, 
though.

my lsusb output is the same as yours:
Bus 007 Device 002: ID 0930:0508 Toshiba Corp. Integrated Bluetooth HCI

Now the 'btusb' module gets loaded, and that is what seems to bring up the HCI 
device for me.  Perhaps that's what is missing on your system?

BTW: lshw doesn't show anything for me.

-A.

