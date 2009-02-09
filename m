Return-Path: <cyrus@holtmann.org>
Subject: Re: btusb compatibility issues
From: Marcel Holtmann <marcel@holtmann.org>
To: Brian Rogers <brian@xyzw.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <498F7C4E.4040305@xyzw.org>
References: <498EB082.7040708@xyzw.org>
	 <1234113019.5355.18.camel@californication>  <498F7C4E.4040305@xyzw.org>
Content-Type: text/plain
Date: Mon, 09 Feb 2009 13:39:03 +0100
Message-Id: <1234183143.4705.11.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

> > Don't try with bluetoothd at all. Make sure it is not running. Plug in
> > the dongle and start hcidump -X -V and then do hciconfig hci0 up. This
> > way I see what is going on.
> >   
> And then start bluetoothd at this point, right? (Assuming no obvious 
> errors have already occurred)

not starting bluetoothd is just for testing so I see all messages from
hcidump.

> > Also please run a kernel built from bluetooth-testing.git so I can
> > properly debug this. There is one change in it that affects the bulk
> > URBs and maybe these dongles just don't like it if we only submit them
> > when needed.
> >   
> I found bluetooth-testing.git last night after posting here, and merged 
> it into my kernel. Today I just tested it, and the problem is solved 
> here. So there's probably no reason to provide the dump anymore. Will 
> this fix be backported to 2.6.27 and 2.6.28?

not likely since it is not clear what is causing it. There can be some
other changes in the tree that could have broken and fixed it. Sometimes
this is not Bluetooth related.

> (BTW, there's now a compile error in bluetooth-testing.git as of today)

I re-based against 2.6.29-rc4 and then boarded and plane and merged a
bad patch into it. Should be fixed now. Feel free to re-test it.

> > Next step is to check on these devices ISOC interface. So I need the
> > content of /proc/bus/usb/devices for this dongle. And then you need to
> > try to mark them with BTUSB_BROKEN_ISOC.
> >   
> This dongle now functions better than my laptop's internal Bluetooth 
> device. I'll make sure to include this info and an hcidump log when I 
> start a thread for the issue I'm having with that.

They should all work the same :)

Regards

Marcel


