Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <OFB1F3144F.CCE46262-ONC12580EA.0051B938-C12580EA.0053A564@continental-corporation.com>
References: <OFB1F3144F.CCE46262-ONC12580EA.0051B938-C12580EA.0053A564@continental-corporation.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 22 Mar 2017 11:40:44 +0200
Message-ID: <CABBYNZKftJVJw6CWydVe_1AYDgLVCsi_QaL5_3bb9drAxe2PsQ@mail.gmail.com>
Subject: Re: way of woking / how to develop new features (roadmap)
To: Mike.Stahl@continental-corporation.com
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

On Tue, Mar 21, 2017 at 5:13 PM,
<Mike.Stahl@continental-corporation.com> wrote:
> Dear community members,
>
> I just joined this mailing list and I have a couple of questions regarding
> the way of working in this community.
>
> 1. Is there any documentation that explains how to contribute to the open
> source development (i.e. is there a kind of guideline for a BlueZ software
> engineer)?

Please check the HACKING document:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/HACKING

> 2. How is the development of new profile features (or profile version
> upgrades) organized for BlueZ:
>    a) How does the community discuss and agree on the features that should
> be developed next?

It depends on the feature, for example if that affects the public APIs
then you might want to send an email with the intended API as RFC to
collect feedback. If you need quicker feedback join the irc channel
#bluez@freenode.

>    b) What are the typical steps to integrate new/additional functionality
> into Bluez?

Send patches, it may take a few iteration until they get merged but
that is no different than working with Linux kernel community.

>    c) Does a kind of roadmap exist for Bluetooth profiles/features?

Not in a formal way, most companies do have something on their own
though, we do however have a TODO document:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/TODO

>    d) Are there working groups for specific topics in order to coordinate
> development activities and to share experience?

Nope, we do have maintainers that focus more on specific areas, I
currently maintain the userspace area, others may focus more on
Kernel, Android or some specific profile.

> 3. What is the focus of current BlueZ development? This question basically
> goes to all community members. Feedback from everybody who likes to answer
> is very welcome!

I guess it would be easier to look at the git history instead of
asking here, in any case from my side Im currently working on
finalizing IPSP support.

>
> Thank you in anticipation!
>
> Best regards
>
> Mike
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
