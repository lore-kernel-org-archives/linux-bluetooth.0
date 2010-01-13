Return-Path: <cyrus@holtmann.org>
Subject: Re: What is the motivation for conn->power_save
From: Marcel Holtmann <marcel@holtmann.org>
To: Nick Pelly <npelly@google.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <35c90d961001122046o733c7e10nf28bfed9e7f5465@mail.gmail.com>
References: <35c90d960911121639o8b0b0bfxde880af69adc9f95@mail.gmail.com>
	 <1258082098.7715.7.camel@violet>
	 <35c90d960911121931n687a2cd4ie8130f919041ee70@mail.gmail.com>
	 <1258084357.7715.26.camel@violet>
	 <35c90d960911131445w16076c70sa0473e9b459d7d15@mail.gmail.com>
	 <35c90d961001122046o733c7e10nf28bfed9e7f5465@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 12 Jan 2010 23:04:51 -0800
Message-ID: <1263366291.922.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

> >>> >> If I understand correctly, conn->power_save prevents the host stack
> >>> >> from requesting active mode if it was not the host stack that
> >>> >> requested sniff mode.
> >>> >>
> >>> >> I don't understand the motivation for this. If we have ACL data to
> >>> >> send, then it seems like a good idea for the host stack to explicitly
> >>> >> request active mode, regardless of the reason that we entered sniff
> >>> >> mode.
> >>> >>
> >>> >> We want to enter active mode more aggressively when setting up SCO
> >>> >> connections, to avoid a 5 second delay with certain sniff modes. But
> >>> >> the conn->power_save code is getting in the way and doesn't appear to
> >>> >> be useful in the first place.
> >>> >
> >>> > we have discussed this a few times. And if you lock through the code
> >>> > history then you see that initially we just took devices out of sniff
> >>> > mode if we had to send data. However with HID devices this falls flat on
> >>> > its face. They need to stay in control of sniff mode if they initiated
> >>> > it. Some of them crash and others just drain the battery. With sniff
> >>> > mode you can send small amounts of data even while in sniff and for HID
> >>> > that is sometimes used. So the remote side better not interfere.
> >>> >
> >>> > What we really need is a socket option where we can control this on a
> >>> > per socket basis if we take devices out of sniff mode. And one extra
> >>> > case might be when we try to establish a SCO channel, because then it is
> >>> > clearly not an HID device. However even A2DP has this sort of problems
> >>> > sometimes where the stream setup takes time.
> >>>
> >>> Makes sense. Thanks for the explanation.
> >>
> >> this means you will be working on a patch for this :)
> 
> Actually, I want to put a patch together for a socket option to not
> use power_save (so that we *always* exit sniff mode when sending ACL
> data). We're seeing this problem with the Plantronics Voyager 855
> which enters sniff mode during A2DP.
> 
> Given that power_save is just for HID devices, my preferred design is
> to disable power_save by default, and have an L2CAP socket option to
> turn on power_save that would be used by HID L2CAP sockets.
> Unfortunately this would require userspace HID code to use the new
> socket option to keep current behavior. But it seems preferable to the
> alternative of having every single other L2CAP socket use a new socket
> option just to disable power_save for the sake of HID.

actually you still mix up the meaning of the power_save option. From the
stack side, the automatic sniff mode is off by default. You have to
enable via sysfs first. The power_save option is just to control when
sniff mode is activated and the remote enters sniff mode, that we are
not getting out of it if we have ACL data.

In conclusion, I am fine with a socket option that allows to control
sniff mode (preferable with interval details) and sniff subrate details
so that we can use them for that ACL link.

So go ahead and work on this. We can fix userspace easily since a new
socket can be detected easily with newer kernels.

Regards

Marcel


