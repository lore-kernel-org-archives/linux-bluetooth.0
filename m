Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1232061946.15331.1.camel@californication>
References: <496895AB.4050902@nokia.com>
	 <1231768413.23749.1.camel@californication>
	 <35c90d960901120915g76235db9ra480cf3431d3025@mail.gmail.com>
	 <1231873966.12234.2.camel@californication>
	 <ac290f760901151113jfd2d3b2t8bce890dd186ecbd@mail.gmail.com>
	 <1232061946.15331.1.camel@californication>
Date: Thu, 15 Jan 2009 15:52:28 -0800
Message-ID: <ac290f760901151552y2b176f0cjf44a29dabfa8e309@mail.gmail.com>
Subject: Re: [RFC] Some kernel changes
From: jaikumar Ganesh <jaikumarg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Nick Pelly <npelly@google.com>, Ville Tervo <ville.tervo@nokia.com>,
	linux-bluetooth@vger.kernel.org, johan.hedberg@nokia.com
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jan 15, 2009 at 3:25 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi,
>
>>         so I pushed another set of patches to the
>>         bluetooth-testing.git tree and
>>         it should include the full BT_SECURITY implemention,
>>         BT_DEFER_SETUP for
>>         RFCOMM and SCO rejection if no listen socket is present.
>>
>>         It currently only drops the connection is encryption is
>>         disabled when
>>         using BT_SECURITY_HIGH. That is only used for SAP anyway. For
>>         all other
>>         profiles we use BT_SECURITY_MEDIUM.
>>
>>     I updated our build with the patches and after picking up 6e26576c
>> (Pause RFCOMM TX when encryption drops) and fixes upto f32ef1836
>> (Enforce authentication before encryption) I see a couple of
>> problems::
>>
>>    a)   I see that in rfcomm/core.c in function rfcomm_security_cfm:
>> when the remote side has dropped the encryption for the role change,
>> we set the RFCOMM_SEC_PENDING bit but we don't set RFCOMM_AUTH_PENDING
>> as suggested in Ville's original patch and so when encryption is
>> re-established we dont get past the - test_and_clear_bit
>> (RFCOMM_AUTH_PENDING) check in the function.
>
> why do you wanna set AUTH_PENDING again. That is not needed we only
> wanna know once encryption comes back on. If no in time, then we just
> disconnect the link. That simple.
>
>>    b) I also see that we are not clearing the timer and hence after
>> RFCOMM_AUTH_TIMEOUT period expires we bring down the RFCOMM connection
>> even though the encryption has been established.
>
> Good catch. Fixed it.

Cool.  Can you upload it to bluetooth-testing git ? I saw a related
problem while looking at the timer issue and wanted to see if the fix
takes care of it.

The timer thats started in rfcomm_security_cfm (for the drop in
encryption) does get cleared in rfcomm_process_dlcs
but then we have some data to send.  So we send the RFCOMM PN packet
just after encryption is re-established.
This results in a new timer being started in rfcomm_process_dlcs and
we don't get the UA packet to clear this timer and hence when
the timer expires, the connection is dropped.

Thanks
Jaikumar

> Regards
>
> Marcel
>
>
>
