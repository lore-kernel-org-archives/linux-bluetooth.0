Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F89968EE-EFA3-4978-904D-5F02988B0785@holtmann.org>
References: <CAHZ1yCmu26xibOaeGUP3HGhp7cvC0eXuviJBRq2VDD0fE6U6SQ@mail.gmail.com>
	<1396564054-20566-1-git-send-email-scott@netsplit.com>
	<20140404072528.GA16753@t440s.lan>
	<CA+bD78i-x0O2odFSEGwSKHULg-uZ=rR7f9TTetBVnVFrf2T3LA@mail.gmail.com>
	<F89968EE-EFA3-4978-904D-5F02988B0785@holtmann.org>
Date: Fri, 4 Apr 2014 09:42:09 -0700
Message-ID: <CA+bD78hF5EVhD_Ct5xHS-1Ho9VS1VFVbtPsYgbnO=VRS7G3nHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] core: don't set BR/EDR support when no flags present
From: Scott James Remnant <scott@netsplit.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Apr 4, 2014 at 8:57 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>>> One thing to note regarding this first one: this is actually not a
>>> problem with current bluetooth-next since there we merge the adv_ind and
>>> scan_rsp into a single mgmt device found event. I.e. with such a kernel
>>> we will not need to have this extra non-zero flags check. I added an
>>> extra code comment to this place so we don't forget to fix it.
>>>
>>
>> Makes sense, we're testing with the current
>> bluetooth-next/for-upstream tag, and it looks like the
>> ADV_IND/SCAN_RSP merging patches aren't submitted yet ;-)
>>
>> Won't this mean that the flag checking will be needed on kernels prior
>> to 3.15 in either case?
>
> they will be needed for kernels < 3.16 since that will be the earliest kernel this gets merged.
>

Right, that's what I would have meant if I'd had more coffee.

> The 3.15 merge window is closed for us. What you have with bluetooth-next/for-upstream is what is merged into 3.15 and from now on only bug fixes are allowed.
>

Great! That's what I understood, our current plan for Chrome OS 36 is
to ship with at least BlueZ 5.17, and then use the 3.15 kernel
bluetooth stack backported to 3.10 and 3.8.  (We'll also continue to
use the 3.8 stack on 3.4 on our oldest hardware.)

This backported stack is what we've been testing with

Scott
-- 
Have you ever, ever felt like this?
Had strange things happen?  Are you going round the twist?
