Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <35c90d960911131445w16076c70sa0473e9b459d7d15@mail.gmail.com>
References: <35c90d960911121639o8b0b0bfxde880af69adc9f95@mail.gmail.com>
	<1258082098.7715.7.camel@violet> <35c90d960911121931n687a2cd4ie8130f919041ee70@mail.gmail.com>
	<1258084357.7715.26.camel@violet> <35c90d960911131445w16076c70sa0473e9b459d7d15@mail.gmail.com>
From: Nick Pelly <npelly@google.com>
Date: Wed, 13 Jan 2010 15:46:55 +1100
Message-ID: <35c90d961001122046o733c7e10nf28bfed9e7f5465@mail.gmail.com>
Subject: Re: What is the motivation for conn->power_save
To: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Nov 14, 2009 at 9:45 AM, Nick Pelly <npelly@google.com> wrote:
> On Thu, Nov 12, 2009 at 7:52 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> Hi Nick,
>>
>>> >> If I understand correctly, conn->power_save prevents the host stack
>>> >> from requesting active mode if it was not the host stack that
>>> >> requested sniff mode.
>>> >>
>>> >> I don't understand the motivation for this. If we have ACL data to
>>> >> send, then it seems like a good idea for the host stack to explicitly
>>> >> request active mode, regardless of the reason that we entered sniff
>>> >> mode.
>>> >>
>>> >> We want to enter active mode more aggressively when setting up SCO
>>> >> connections, to avoid a 5 second delay with certain sniff modes. But
>>> >> the conn->power_save code is getting in the way and doesn't appear to
>>> >> be useful in the first place.
>>> >
>>> > we have discussed this a few times. And if you lock through the code
>>> > history then you see that initially we just took devices out of sniff
>>> > mode if we had to send data. However with HID devices this falls flat on
>>> > its face. They need to stay in control of sniff mode if they initiated
>>> > it. Some of them crash and others just drain the battery. With sniff
>>> > mode you can send small amounts of data even while in sniff and for HID
>>> > that is sometimes used. So the remote side better not interfere.
>>> >
>>> > What we really need is a socket option where we can control this on a
>>> > per socket basis if we take devices out of sniff mode. And one extra
>>> > case might be when we try to establish a SCO channel, because then it is
>>> > clearly not an HID device. However even A2DP has this sort of problems
>>> > sometimes where the stream setup takes time.
>>>
>>> Makes sense. Thanks for the explanation.
>>
>> this means you will be working on a patch for this :)

Actually, I want to put a patch together for a socket option to not
use power_save (so that we *always* exit sniff mode when sending ACL
data). We're seeing this problem with the Plantronics Voyager 855
which enters sniff mode during A2DP.

Given that power_save is just for HID devices, my preferred design is
to disable power_save by default, and have an L2CAP socket option to
turn on power_save that would be used by HID L2CAP sockets.
Unfortunately this would require userspace HID code to use the new
socket option to keep current behavior. But it seems preferable to the
alternative of having every single other L2CAP socket use a new socket
option just to disable power_save for the sake of HID.

Nick
