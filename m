Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1231768413.23749.1.camel@californication>
References: <496895AB.4050902@nokia.com>
	 <1231768413.23749.1.camel@californication>
Date: Mon, 12 Jan 2009 09:15:10 -0800
Message-ID: <35c90d960901120915g76235db9ra480cf3431d3025@mail.gmail.com>
Subject: Re: [RFC] Some kernel changes
From: Nick Pelly <npelly@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Ville Tervo <ville.tervo@nokia.com>, linux-bluetooth@vger.kernel.org,
        johan.hedberg@nokia.com
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 12, 2009 at 5:53 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Ville,
>
>> Here is set of unclean patches for discussion. These are still untested
>> and contain issues, but I would like to know if we should continue with
>> these or change something radically. Also commit messages are somewhat
>> misleading in some places.
>>
>> Basically idea is to implement connection rejection support for l2cap
>> and rfcomm sockets. IOW possibility to check initiator bd-address and
>> ask for authorization before accepting connection.
>>
>> Other goal is to fix encryption and authentication levels to fulfill 2.1
>> requirements.
>
> so I pushed my re-worked and pending patches to bluetooth-testing.git
> now. This adds support for BT_DEFER_SETUP and BT_SECURITY (only the
> logic and not the actual socket option).

Ville: thanks for the patches, pausing RFCOMM while encryption is
disabled is a nice fix.

I imagine that if encryption is not quickly re-established we need to
drop the RFCOMM link rather than leaving it paused though.

We will do some testing of the current rfcomm-pause patches.

Nick
