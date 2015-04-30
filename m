Return-Path: <cyrus@holtmann.org>
From: Kalle Valo <kvalo@qca.qualcomm.com>
To: Ben Hutchings <ben@decadent.org.uk>
CC: Jouni Malinen <jouni@qca.qualcomm.com>,
	Kyle McMartin <kyle@infradead.org>,
	<linux-firmware@kernel.org>, <linux-bluetooth@vger.kernel.org>,
	<agoel@qca.qualcomm.com>
Subject: Re: [PATCH] ath3k: update AR3012 2.2.1 firmware with v.170
References: <1428687294-10706-1-git-send-email-kvalo@qca.qualcomm.com>
	<20150413140205.GB27807@merlin.infradead.org>
	<20150413140617.GC27807@merlin.infradead.org>
	<1428934503.3211.7.camel@decadent.org.uk>
	<20150415083357.GA3907@jouni.qca.qualcomm.com>
Date: Thu, 30 Apr 2015 18:43:00 +0300
In-Reply-To: <20150415083357.GA3907@jouni.qca.qualcomm.com> (Jouni Malinen's
	message of "Wed, 15 Apr 2015 11:33:57 +0300")
Message-ID: <87h9rxzkor.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ben,

Jouni Malinen <jouni@qca.qualcomm.com> writes:

> On Mon, Apr 13, 2015 at 03:15:03PM +0100, Ben Hutchings wrote:
>
>> I have some concern about the narrower patent license in this version.
>> 
>> The new patent license specifically excludes patents that are not owned
>> by QCA (whereas the old license also included those 'controlled' by
>> Atheros) and any that are obtained after the date of submission.  This
>> seems to allow revoking permission to distribute at a later date, if
>> there are any other patent applications in the pipeline.
>> 
>> If QCA wants the firmware to be redistributed freely (with the legal
>> notices intact, only for use with their hardware) then I don't see what
>> the point is of restricting the patent license in this way.
>
> I don't think there is such limitation for redistribution (see the
> copyright license above in the "Redistribution" section). As far as the
> limited patent license language is concerned, would the following
> changes address your concern?

Did you have a chance to look at the proposal? It would be good to solve
this so that we can get the bluetooth firmware images to linux-firmware.

-- 
Kalle Valo
