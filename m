Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110726143637.GA3587@dell.ger.corp.intel.com>
References: <1311689387-10114-1-git-send-email-prasadbhat22@gmail.com>
	<4E2ECCF0.6050106@kernelconcepts.de>
	<20110726143637.GA3587@dell.ger.corp.intel.com>
Date: Tue, 26 Jul 2011 20:53:24 +0530
Message-ID: <CA+y7xkER2Y+jJum=JBwzNcY0Pg_drvnjG_E12jDQ6kKZYbkQVw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/6] Initial VDP implementation.
From: Prasad Bhat <prasadbhat22@gmail.com>
To: Nils Faerber <nils.faerber@kernelconcepts.de>,
	Prasad Bhat <prasadbhat22@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jul 26, 2011 at 8:06 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Tue, Jul 26, 2011, Nils Faerber wrote:
>> Am 26.07.2011 16:09, schrieb Prasad Bhat:
>> > --- /dev/null
>> > +++ b/audio/vdp.c
>> > @@ -0,0 +1,2303 @@
>> > +/*
>> > + *
>> > + *  BlueZ - Bluetooth protocol stack for Linux
>> > + *
>> > + *  Copyright (C) 2006-2010  Nokia Corporation
>> > + *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
>>
>>
>> I think this is your code, is it?
>>
>> Why do you assign the copyright to Nokia and Marcel then?
>
> Looking at the code it seems to a large part copy-paste + minor
> modifications from a2dp.c, so to that extent those copyright
> declarations would be correct. However, I would also have expected Prasad
> to add either his personal copyright or the copyright of the company
> that he's working for.
>
> Couple of other notes:
>
> - The patch is huge. Any chance of splitting it up into smaller chunks?
> - Since there's so much in common with a2dp.c it'd make sense to attempt
>  some refactoring.
> - Now that audio/*.c does video too we might consider renaming the
>  audio plugin and directory to something else.
>
> Johan
>

Thanks for the inputs, I will work on it and will resend it with other patches.

Regards
Prasad
