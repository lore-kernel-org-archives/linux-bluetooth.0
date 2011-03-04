Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Mar 2011 22:37:06 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: RFC: LE Security Manager and next steps
Message-ID: <20110304013706.GA20251@piper>
References: <4D6FF23D.5020608@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D6FF23D.5020608@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On 11:55 Thu 03 Mar, Brian Gix wrote:
> 
> Hi Vinicius & All,
> 
> I am starting to move forward on the LE Security Manager for bluez.
> I am currently using the patches submitted by Vinicius for
> bluetooth-next, and hope that they are accepted by Gustavo soon, but
> at some point, I will be forced to move forward with or without that
> acceptance.

I hope so too. There are still some still some details to be sorted out,
but I think that the meat of those patches will stay as they are right now.

> 
> My more immediate attention is therefore placed on key storage (LTK,
> IRK, CSRK), and high level APIs, in particular Passkey agents for
> MITM support.
> 
> If anyone is working these problem already, I would like to discuss
> details, so that we are not coming up with competing solutions.  The
> main reason I would like Vinicius' patches accepted sooner rather
> than later is so that I (and others) can start contributing these
> next pieces without creating a divergence headache.
> 

I have a very simple implementation of the key distribution part, for now
it is focused on only the LTK. As I did a lot of experiments while writing
it, the code still a mess. I hope to have a cleaner version soon and will
send a RFC, so more people can take a look and test it, which was extremely
useful the last time :-)

I think that the most important fact about this implementation is that it is
dependend on the Management Interface[1]. It needs this interface for
communicating userspace about new keys and so userspace loads the stored
keys when the userspace daemon is run.

> To begin with, I am planning on making the key storage part of the
> existing system used by BR/EDR. I am primarily concerned with Dual
> Mode devices, and we believe that from a "big system" point of view,
> that most of the differences between remote dual-mode and remote
> LE-only can be largely abstracted and out of sight by high level
> apps.  The main differences between LE keys and BR/EDR keys of
> course is that there are multiple keys per "pairs of devices", and
> except for LTKs, they are used very differently.

For now I have a separate storage for LTKs. For the other kinds of
keys I am still not sure how to store/use them. Right now, your idea
holds, it is completely hidden from the apps how the pairing happened.

> 
> Also, I understand that some people think that Write-Cmd signing
> (CSRK) and verification should be a function of GATT/ATT in User
> space, and others think it should be handled down in the SM kernel
> on the way out (and in).  I know that the crypto library is being
> brought into the kernel for STK resolution, and this would seem to
> point towards kernel based signing and verification.

How/where to do signing is a very good question. I just have a small
preference about doing it in userspace (most of the ATT stuff is there).
But it is just a gut feeling.

This is something that any form of input will be awesome. 

> 
> Privacy is the biggest problem however.  Identity *resolution* can
> of course be done at the kernel level but if addresses change, we
> will need to come up with a plan as to how to deal with everything
> up to and including dbus object-paths that currently include an
> ascii representation of the BD Addr as part of the path.  At the
> highest (DBus) level I am thinking that a signal on the original
> object path might work when we connect/detect a new address for an
> existing device, and an object path which is then an extension of
> the originally paired device:
> 
> If Original was:
> /org/bluez/3456/hci0/dev_XX_XX_XX_XX_XX_XX
> 
> The Private could be:
> /org/bluez/3456/hci0/dev_XX_XX_XX_XX_XX_XX/priv_YY_YY_YY_YY_YY_YY
>

Yeah, this is the most serious problem. One thought that happened some
time ago, was that the DBus path doesn't have to have the address, it is
just a path, we could change the way we name the objects, as long as the
naming is consistent i.e. the same device will have always the same path.

But even without this restriction I guess there are few problems that 
need be solved before we can support Privacy the Right Way. In short,
any help with this will be great :-)

> 
> Anyway, we are starting work on this soon, so if there is
> competing/complimentary work being done, I would really like to hear
> from you.  There is a lot to be done here, and I'd like to have the
> architectural conversations sooner rather than later.
> 
> I would also like to hear from you if you simply have a good idea of
> how you think these LE pieces should be architected, and haven't
> started writing code.
> 
> 
> 
> -- 
> Brian Gix
> bgix@codeaurora.org
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum


Cheers,
-- 
Vinicius

[1] http://www.bluez.org/the-management-interface/
