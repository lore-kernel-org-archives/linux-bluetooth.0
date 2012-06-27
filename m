Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <E50901D4F2CF69428D43141B7C85867929E12C7163@EXMB03.eu.tieto.com>
References: <1340803668-31686-1-git-send-email-michal.labedzki@tieto.com>
 <CABBYNZ+QhVLY+Yr6qH92HO0k0SYGtWiGaEfmAnuou_05g7XqDQ@mail.gmail.com> <E50901D4F2CF69428D43141B7C85867929E12C7163@EXMB03.eu.tieto.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Wed, 27 Jun 2012 13:22:54 -0300
Message-ID: <CAMOw1v4i8KMuDjiFU279mV4mpA5sWSDvH3yuKF-2kLZEz-5kJA@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] AVRCP: Update constants
To: Michal.Labedzki@tieto.com
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
	lucas.demarchi@profusion.mob, johan.hedberg@gmail.com
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Wed, Jun 27, 2012 at 11:25 AM,  <Michal.Labedzki@tieto.com> wrote:
> Hi Luiz,
>
>
>> Haven't I nak the changes to enum before? What have you changed in v2?
>>
>>--
>> Luiz Augusto von Dentz
>
> No. According to Lucas I removed unused constants.
> What wrong with enum? Look into sap.h, vhci.h, reporter.h, parser.h, cups.h and... avrcp.c ("enum battery_status" is here)

I strongly NACKed this before. Not only because of the unused constants.

>
> I have idea to make enum new convention in BlueZ. See sap.h - it looks very clearly for me. Pros for used enum is that enum can be thread as group of constants, mostly constants defined in specification. But "magic constants" should stay define - mostly defined by developer.
> Disadvantage for "define" is that as you can see in BlueZ AVRCP - you must use additional comment to describe group of constants.

I don't see any advantage in being able to group them. You still have
to define the name by prefixing it with the namespace. If it was
already enum, fine - changing for the sake of change only is not good.

>
> Luiz, why "nak"? Could you present your point of view?

IMO this change doesn't give us anything

Lucas De Marchi
