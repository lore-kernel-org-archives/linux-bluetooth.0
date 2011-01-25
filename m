Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110124213429.GA15121@piper>
References: <001c01cb931d$dc4cb3a0$94e61ae0$@org>
	<20101203220534.GA16709@eris>
	<1295895817.2656.26.camel@ubuntuLab1>
	<20110124213429.GA15121@piper>
Date: Tue, 25 Jan 2011 10:35:19 +0200
Message-ID: <AANLkTi=uByqBUVKD8UYwt5ZByvHwu6WpapG=BtUrFkzE@mail.gmail.com>
Subject: Re: LE Kernel (bluetooth-le-2.6) and LE Security Manager
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: Brian Gix <bgix@codeaurora.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Mon, Jan 24, 2011 at 11:34 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> Hi Brian,
>
> On 11:03 Mon 24 Jan, Brian Gix wrote:
>> Hi Vinicius,
>>
>> I am sorry that it has taken so long to test the snapshot that you
>> placed on gitorious, but I have now done so.
>>
>> On Fri, 2010-12-03 at 19:05 -0300, Vinicius Costa Gomes wrote:
>> > Hi Brian,
>> >
>> > On 11:11 Fri 03 Dec, Brian Gix wrote:
>> > >
>> > > Hi Claudio, Johan & All,
>> > >
>> > > Is this LE capable kernel that Ville is working on, the development stream
>> > > for the LE Security Manager?  And if so, is it in a partial fleshed out
>> > > state?
>> >
>> > There is a simple implementation of SMP here[1] on my "devel" branch. I am
>> > cleaning it up for sending it for review.
>> >
>> > If you want to help, have any comments or just want to tell us what you are
>> > working on, please drop by #bluez on freenode, or send an email.
>>
>> I have been able to verify that the Just Works negotiation of the Short
>> Term Key does work against an independent implementation of the LE
>> Security Manager, as long as I have requested no MITM protection.  I
>> have the following comments:
>>
>> 1. You currently reject security if I *do* request MITM protection.
>> This should not be done.  The correct functionality should be to
>> continue the negotiation.  Even though I requested MITM, it will be
>> clear to both sides that JUST_WORKS methodology has been used, and so
>> when the Keys are generated and exchanged, both sides will indicate in
>> their Key Database that they are no-MITM keys. If I then actually
>> *needed* MITM protection, then whatever functionality requiring that
>> level of security will fail with an insufficient security error code.
>> However, security should *never* be rejected unless there is a
>> fundamental incompatibility such as no level of security actually
>> supported.  This is the only functionality that I found to be actually
>> incorrect.
>>
>
> I was assuming that the meaning of setting the MITM protection bit, was that
> it was *requiring* MITM protection, and when that couldn't be fulfilled the
> Pairing Request should be rejected.
>
> So my assumption was incorrect, going to fix it soon.

Well the spec says it is a requirement:

"If the STK generation method does not result in an STK that provides
sufficient security properties then the device shall send the Pairing
Failed command with the error code “Authentication Requirements”" -
2.3.5.1 Selecting STK Generation Method - Page 608

In my interpretation this is exactly what should happen when MITM is
set but there is no way to generate an authenticated key as Table 2.4:
Mapping of IO Capabilities to STK Generation Method suggest, in other
words if one of sides has NoInputNoOutput and MITM is set we should
return "Authentication Requirements" error.

-- 
Luiz Augusto von Dentz
Computer Engineer
