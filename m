Return-Path: <cyrus@holtmann.org>
Message-ID: <498F7C4E.4040305@xyzw.org>
Date: Sun, 08 Feb 2009 16:43:58 -0800
From: Brian Rogers <brian@xyzw.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: btusb compatibility issues
References: <498EB082.7040708@xyzw.org> <1234113019.5355.18.camel@californication>
In-Reply-To: <1234113019.5355.18.camel@californication>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel Holtmann wrote:
> Don't try with bluetoothd at all. Make sure it is not running. Plug in
> the dongle and start hcidump -X -V and then do hciconfig hci0 up. This
> way I see what is going on.
>   
And then start bluetoothd at this point, right? (Assuming no obvious 
errors have already occurred)
> Also please run a kernel built from bluetooth-testing.git so I can
> properly debug this. There is one change in it that affects the bulk
> URBs and maybe these dongles just don't like it if we only submit them
> when needed.
>   
I found bluetooth-testing.git last night after posting here, and merged 
it into my kernel. Today I just tested it, and the problem is solved 
here. So there's probably no reason to provide the dump anymore. Will 
this fix be backported to 2.6.27 and 2.6.28?

(BTW, there's now a compile error in bluetooth-testing.git as of today)
> Next step is to check on these devices ISOC interface. So I need the
> content of /proc/bus/usb/devices for this dongle. And then you need to
> try to mark them with BTUSB_BROKEN_ISOC.
>   
This dongle now functions better than my laptop's internal Bluetooth 
device. I'll make sure to include this info and an hcidump log when I 
start a thread for the issue I'm having with that.

Thanks!
