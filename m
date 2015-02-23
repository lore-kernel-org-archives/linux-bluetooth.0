Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH] bluetooth/l2cap: silence framedrop kmsg noise
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+VB3NQeeMzdi_n0ZMgQtivBPUMfaOK8J=EFubYKT0+jM2EubA@mail.gmail.com>
Date: Sun, 22 Feb 2015 16:05:37 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FD2FEA27-B249-43B9-A269-AA5DC4A519D3@holtmann.org>
References: <1832240.mNuY6LIF5L@moneypit> <A863E4B8-1461-4680-A8CE-40FDDB04858B@holtmann.org> <CA+VB3NQeeMzdi_n0ZMgQtivBPUMfaOK8J=EFubYKT0+jM2EubA@mail.gmail.com>
To: Greg Turner <gmt@be-evil.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Greg,

>> and be more specific which devices are these.
> 
> It's not pretty.  It's a (usb id) 046d:c709.  They come bundled with
> Logitech keyboards.  They require hid2hci (udev, or somebody, does it
> for me automagically these days).
> 
> I believe the radio is a BCM2045A... or maybe not... it's definitely a
> fairly obscure thing to use as a radio, as Logitech pretty much goes
> out of their way to pretend it's married to the keyboard it comes
> with.
> 
> Is there some good way to ask the kernel what board it thinks it's
> talking to?  I have heard some grumbling about Logitech recycling the
> 0xc709 product ID although I'm not sure I trust whoever said it :(
> 
> The device has a plastic OEM "shell" but the plastic is
> semitransparent.  If I shine my flashlight at it just right, I can see
> an inner plastic(?) enclosure with different markings than Logitech's,
> but it's partially obscured -- all I can read on that inner device is
> the last line: "0541 LF".  I could definitely sacrifice it for
> science, if it became necessary.
> 
> I only ever use a2dp, avrcp and hfp (or maybe hsp?, can't keep 'em
> straight in my head); I have a couple different gizmos and they all
> fill my logs with that message.
> 
>> There seems to be something really off going on here.
> 
> Really?  That's sort-of encouraging... There were so many reports
> online and everyone sounded so resigned to this fate that I just
> assumed that was the expected result.
> 
> One odd behavior I have observed (aside from logs full of garbage) --
> if I go too far out of range, the entire connection between my device
> and the dongle just "breaks".  If I come back into range, they are
> never able to find each other and resume their conversation until
> reboot my gizmo (or sometimes it will come back online after a very
> long time).  Yet, the dongle still thinks they're connected.  I've
> learned to just leave them behind before leaving the room :)

I get the feeling that either dongle or the remote device is broken. If it is the dongle, it might actually needs a firmware update / ROM patch to make this behave properly.

The real problem is that we get a ACL fragment from the controller telling us that it is continuation of a previous packet. However this previous packet seems to never arrive in the first place. Meaning I have no idea what is actually happening here. The error message tells you that.

So instead of removing it, we might want to consider using rate limiting for that specific error message. It is a valid error message.

Regards

Marcel



