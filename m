Return-Path: <cyrus@holtmann.org>
From: "Gregory M. Turner" <gmt@be-evil.net>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] bluetooth/l2cap: silence framedrop kmsg noise
Date: Mon, 23 Feb 2015 13:09:07 -0800
Message-ID: <1619328.sIzMdT7lV0@moneypit>
In-Reply-To: <FD2FEA27-B249-43B9-A269-AA5DC4A519D3@holtmann.org>
References: <1832240.mNuY6LIF5L@moneypit> <CA+VB3NQeeMzdi_n0ZMgQtivBPUMfaOK8J=EFubYKT0+jM2EubA@mail.gmail.com> <FD2FEA27-B249-43B9-A269-AA5DC4A519D3@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

On Sunday 22 February 2015 16:05:37 Marcel Holtmann wrote:
> Hi Greg,
>
> I get the feeling that either dongle or the remote device is broken. If it
> is the dongle, it might actually needs a firmware update / ROM patch to
> make this behave properly.

I'm pretty sure the firmware's up to date on it.  But this thing is quite old 
and not well supported.  I think it's an old revision of the HW that was 
superseded by something slightly less shitty in future Logitech packages (they 
do still sell this keyboard package, or did the last time I checked, but 
reports were, it came with a different dongle).

This behavior definitely follows the dongle -- all other factors have been 
varied and ruled out over the many years I've put up with this thing.

> The real problem is that we get a ACL fragment from the controller telling
> us that it is continuation of a previous packet. However this previous
> packet seems to never arrive in the first place. Meaning I have no idea
> what is actually happening here. The error message tells you that.

With length zero?  That seems crazy.  Or am I misunderstanding what that 
number signifies?

> So instead of removing it, we might want to consider using rate limiting for
> that specific error message.

In my particular case, it makes sense to just apply the patch I posted even if 
it's wrong.  Clearly, though, this is treating the symptom, not the disease.

> It is a valid error message.

Idunno... obv. it's valid in the sense that this is what the driver thinks the 
device is telling the host, hence, my patch is stupid.

However, it seems I have either a) a broken dongle b) a dongle that's working 
as designed, but whose design is broken or nonstandard*, or c) a broken linux 
driver (but the line between c and b is blurry).

I'm wondering, in particular, about (b).  I used to have a second dongle like 
this one.  It fell apart some years ago (hmm, I may have saved the pieces 
somewhere), but I'm pretty sure it had the same behavior.  That was a long 
time ago, however; I could definitely be remembering incorrectly.

I'll see if I can't learn how to get my android phone to sniff this traffic.  My 
thinking is, if a sniffed dump looked different from the host's dump, I'd have a 
pretty clear indication of a problem arising at or below the driver layer.

Another similar avenue of attack would be to mess around with Windows.  If 
there is some way to generate these dumps in Windows, and everything looked 
fine there, I'd at least have a clear indication that the kernel driver lacks 
some needed quirk support for this device.

-gmt
