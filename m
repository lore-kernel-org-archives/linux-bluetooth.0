Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1258082098.7715.7.camel@violet>
References: <35c90d960911121639o8b0b0bfxde880af69adc9f95@mail.gmail.com>
	<1258082098.7715.7.camel@violet>
From: Nick Pelly <npelly@google.com>
Date: Thu, 12 Nov 2009 19:31:55 -0800
Message-ID: <35c90d960911121931n687a2cd4ie8130f919041ee70@mail.gmail.com>
Subject: Re: What is the motivation for conn->power_save
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Nov 12, 2009 at 7:14 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Nick,
>
>> If I understand correctly, conn->power_save prevents the host stack
>> from requesting active mode if it was not the host stack that
>> requested sniff mode.
>>
>> I don't understand the motivation for this. If we have ACL data to
>> send, then it seems like a good idea for the host stack to explicitly
>> request active mode, regardless of the reason that we entered sniff
>> mode.
>>
>> We want to enter active mode more aggressively when setting up SCO
>> connections, to avoid a 5 second delay with certain sniff modes. But
>> the conn->power_save code is getting in the way and doesn't appear to
>> be useful in the first place.
>
> we have discussed this a few times. And if you lock through the code
> history then you see that initially we just took devices out of sniff
> mode if we had to send data. However with HID devices this falls flat on
> its face. They need to stay in control of sniff mode if they initiated
> it. Some of them crash and others just drain the battery. With sniff
> mode you can send small amounts of data even while in sniff and for HID
> that is sometimes used. So the remote side better not interfere.
>
> What we really need is a socket option where we can control this on a
> per socket basis if we take devices out of sniff mode. And one extra
> case might be when we try to establish a SCO channel, because then it is
> clearly not an HID device. However even A2DP has this sort of problems
> sometimes where the stream setup takes time.

Makes sense. Thanks for the explanation.

> Not sure if we have to make SCO setup special. The only reason would be
> if there is a case where we don't get an AT command before SCO needs to
> be established.

If you are in-call, and transfer audio from handset to BT headset,
then there is SCO setup without any AT command.

I think for the SCO setup case we would always want to enter active
mode. I could modify enter_active_mode() to take a parameter like 'int
force' that would force us to enter active mode regardless of the
state of power_save, and use this when setting up SCO. What do you
think?

Nick
