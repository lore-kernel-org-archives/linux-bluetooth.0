Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH] bluetooth/l2cap: silence framedrop kmsg noise
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1619328.sIzMdT7lV0@moneypit>
Date: Mon, 23 Feb 2015 13:18:39 -0800
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <99FAFB7A-43DF-47DF-B6B1-D62311227073@holtmann.org>
References: <1832240.mNuY6LIF5L@moneypit> <CA+VB3NQeeMzdi_n0ZMgQtivBPUMfaOK8J=EFubYKT0+jM2EubA@mail.gmail.com> <FD2FEA27-B249-43B9-A269-AA5DC4A519D3@holtmann.org> <1619328.sIzMdT7lV0@moneypit>
To: "Gregory M. Turner" <gmt@be-evil.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Greg,

>> I get the feeling that either dongle or the remote device is broken. If it
>> is the dongle, it might actually needs a firmware update / ROM patch to
>> make this behave properly.
> 
> I'm pretty sure the firmware's up to date on it.  But this thing is quite old 
> and not well supported.  I think it's an old revision of the HW that was 
> superseded by something slightly less shitty in future Logitech packages (they 
> do still sell this keyboard package, or did the last time I checked, but 
> reports were, it came with a different dongle).
> 
> This behavior definitely follows the dongle -- all other factors have been 
> varied and ruled out over the many years I've put up with this thing.
> 
>> The real problem is that we get a ACL fragment from the controller telling
>> us that it is continuation of a previous packet. However this previous
>> packet seems to never arrive in the first place. Meaning I have no idea
>> what is actually happening here. The error message tells you that.
> 
> With length zero?  That seems crazy.  Or am I misunderstanding what that 
> number signifies?

the problem is that the controller tells us that this is continuation fragment with zero length. Meaning that there has to be a start packet in the first place. That one seems to never happen or it gets out of sync at some point.

If you say that whenever you use the controller, you see this behavior, then it sounds like a problem with the controller. So maybe investing in a 10 USD dongle from China would help.

>> So instead of removing it, we might want to consider using rate limiting for
>> that specific error message.
> 
> In my particular case, it makes sense to just apply the patch I posted even if 
> it's wrong.  Clearly, though, this is treating the symptom, not the disease.
> 
>> It is a valid error message.
> 
> Idunno... obv. it's valid in the sense that this is what the driver thinks the 
> device is telling the host, hence, my patch is stupid.
> 
> However, it seems I have either a) a broken dongle b) a dongle that's working 
> as designed, but whose design is broken or nonstandard*, or c) a broken linux 
> driver (but the line between c and b is blurry).
> 
> I'm wondering, in particular, about (b).  I used to have a second dongle like 
> this one.  It fell apart some years ago (hmm, I may have saved the pieces 
> somewhere), but I'm pretty sure it had the same behavior.  That was a long 
> time ago, however; I could definitely be remembering incorrectly.
> 
> I'll see if I can't learn how to get my android phone to sniff this traffic.  My 
> thinking is, if a sniffed dump looked different from the host's dump, I'd have a 
> pretty clear indication of a problem arising at or below the driver layer.
> 
> Another similar avenue of attack would be to mess around with Windows.  If 
> there is some way to generate these dumps in Windows, and everything looked 
> fine there, I'd at least have a clear indication that the kernel driver lacks 
> some needed quirk support for this device.

If this is on purpose, then I can not figure out why it would be. It makes no sense to me and since Bluetooth is a rather old technology these days, this would have come up more often.

We should rate limit the error message, but we should not suppress it completely. So I am fine adding a patch that rate limits it.

Sniffing the air traffic and USB HCI traffic comes with a 40k EUR price point. So I would go for a new dongle and throw this in a trashcan ;)

Regards

Marcel

