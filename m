Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1295895817.2656.26.camel@ubuntuLab1>
References: <001c01cb931d$dc4cb3a0$94e61ae0$@org>
	<20101203220534.GA16709@eris>
	<1295895817.2656.26.camel@ubuntuLab1>
Date: Mon, 24 Jan 2011 22:09:53 +0200
Message-ID: <AANLkTi=Hzaf2Ad7=+hQFEcvMfV4_P+-ZUVg5kzxvZyJH@mail.gmail.com>
Subject: Re: LE Kernel (bluetooth-le-2.6) and LE Security Manager
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Brian Gix <bgix@codeaurora.org>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Jan 24, 2011 at 9:03 PM, Brian Gix <bgix@codeaurora.org> wrote:
> Hi Vinicius,
>
> I am sorry that it has taken so long to test the snapshot that you
> placed on gitorious, but I have now done so.
>
> On Fri, 2010-12-03 at 19:05 -0300, Vinicius Costa Gomes wrote:
>> Hi Brian,
>>
>> On 11:11 Fri 03 Dec, Brian Gix wrote:
>> >
>> > Hi Claudio, Johan & All,
>> >
>> > Is this LE capable kernel that Ville is working on, the development stream
>> > for the LE Security Manager?  And if so, is it in a partial fleshed out
>> > state?
>>
>> There is a simple implementation of SMP here[1] on my "devel" branch. I am
>> cleaning it up for sending it for review.
>>
>> If you want to help, have any comments or just want to tell us what you are
>> working on, please drop by #bluez on freenode, or send an email.
>
> I have been able to verify that the Just Works negotiation of the Short
> Term Key does work against an independent implementation of the LE
> Security Manager, as long as I have requested no MITM protection.  I
> have the following comments:
>
> 1. You currently reject security if I *do* request MITM protection.
> This should not be done.  The correct functionality should be to
> continue the negotiation.  Even though I requested MITM, it will be
> clear to both sides that JUST_WORKS methodology has been used, and so
> when the Keys are generated and exchanged, both sides will indicate in
> their Key Database that they are no-MITM keys. If I then actually
> *needed* MITM protection, then whatever functionality requiring that
> level of security will fail with an insufficient security error code.
> However, security should *never* be rejected unless there is a
> fundamental incompatibility such as no level of security actually
> supported.  This is the only functionality that I found to be actually
> incorrect.

But the point of MITM is man in the middle protection, so if we end up
with a key which is not MITM there is no protection why store the link
key? Actually if we do that we can end up in a situation where
insufficient security is always triggered and the other stack may
attempt to repair but with current code it will never succeed to
generate a valid MITM link key. Anyway I suppose supporting MITM is
mandatory so obviously the only possible fix for this is to support
MITM.

> 2. Currently, you are not exchanging any permanent keys, which I am sure
> you are aware.  This makes it impossible to test much else, such as
> command signing, or security requests that use the generated keys.
>
> If you have a later version of SM that could be uploaded to your devel
> branch on gitorious, I would be more than happy (and in fact would love
> to be able) to test that for you as well.
>
> This is the git configuration I used for testing, which only has your SM
> up to the end of last December, and is so about a month old:
>
> remote.origin.url=git://gitorious.org/bluetooth-next/bluetooth-next.git
> branch.devel.remote=origin
> branch.devel.merge=refs/heads/devel
>
>
> Thanks for doing the SM,
>
> --
> Brian Gix
> bgix@codeaurora.org
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Luiz Augusto von Dentz
Computer Engineer
