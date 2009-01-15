Return-Path: <cyrus@holtmann.org>
Message-ID: <ac290f760901151114s3c887f28u77a068f6c694d781@mail.gmail.com>
Date: Thu, 15 Jan 2009 11:14:59 -0800
From: "jaikumar Ganesh" <jaikumarg@gmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [RFC] Some kernel changes
Cc: "Nick Pelly" <npelly@google.com>, "Ville Tervo" <ville.tervo@nokia.com>,
	linux-bluetooth@vger.kernel.org, johan.hedberg@nokia.com
In-Reply-To: <1231873966.12234.2.camel@californication>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <496895AB.4050902@nokia.com>
	 <1231768413.23749.1.camel@californication>
	 <35c90d960901120915g76235db9ra480cf3431d3025@mail.gmail.com>
	 <1231873966.12234.2.camel@californication>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel
   [Sorry sending again as the mail bounced]

On Tue, Jan 13, 2009 at 11:12 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Nick,
>
>> >> Here is set of unclean patches for discussion. These are still untested
>> >> and contain issues, but I would like to know if we should continue with
>> >> these or change something radically. Also commit messages are somewhat
>> >> misleading in some places.
>> >>
>> >> Basically idea is to implement connection rejection support for l2cap
>> >> and rfcomm sockets. IOW possibility to check initiator bd-address and
>> >> ask for authorization before accepting connection.
>> >>
>> >> Other goal is to fix encryption and authentication levels to fulfill 2.1
>> >> requirements.
>> >
>> > so I pushed my re-worked and pending patches to bluetooth-testing.git
>> > now. This adds support for BT_DEFER_SETUP and BT_SECURITY (only the
>> > logic and not the actual socket option).
>>
>> Ville: thanks for the patches, pausing RFCOMM while encryption is
>> disabled is a nice fix.
>>
>> I imagine that if encryption is not quickly re-established we need to
>> drop the RFCOMM link rather than leaving it paused though.
>>
>> We will do some testing of the current rfcomm-pause patches.
>
> so I pushed another set of patches to the bluetooth-testing.git tree and
> it should include the full BT_SECURITY implemention, BT_DEFER_SETUP for
> RFCOMM and SCO rejection if no listen socket is present.
>
> It currently only drops the connection is encryption is disabled when
> using BT_SECURITY_HIGH. That is only used for SAP anyway. For all other
> profiles we use BT_SECURITY_MEDIUM.

I updated our build with the patches and after picking up 6e26576c
(Pause RFCOMM TX when encryption drops) and fixes upto f32ef1836
(Enforce authentication before encryption) I see a couple of
problems::

    a)   I see that in rfcomm/core.c in function rfcomm_security_cfm:
when the remote side has dropped the encryption for the role change,
we set the RFCOMM_SEC_PENDING bit but we don't set RFCOMM_AUTH_PENDING
as suggested in Ville's original patch and so when encryption is
re-established we dont get past the - test_and_clear_bit
(RFCOMM_AUTH_PENDING) check in the function.

    b) I also see that we are not clearing the timer and hence after
RFCOMM_AUTH_TIMEOUT period expires we bring down the RFCOMM connection
even though the encryption has been established.

    Sorry, I don't have a patch ready as yet and hence the description
above to check if you have encountered the same.

 Thanks
 Jaikumar

> Regards
>
> Marcel
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
