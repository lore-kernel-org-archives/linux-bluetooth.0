Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4C63F363.4000400@nokia.com>
References: <4C63F363.4000400@nokia.com>
Date: Thu, 12 Aug 2010 14:59:54 -0300
Message-ID: <AANLkTimdRHPtwqPcnVkfgYwC47H5XgXLC8xo7nLNmgRk@mail.gmail.com>
Subject: Re: Question about phonebook_add_contact
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Thu, Aug 12, 2010 at 10:13 AM, Radoslaw Jablonski
<ext-jablonski.radoslaw@nokia.com> wrote:
>
>  Hi!
> I've got question about this part of code from beginning
>  phonebook_add_contact func:
>
> if ((contact->numbers == NULL && (contact->fullname == NULL ||
>                        contact->fullname[0] == '\0')))
>        return;
>
> Is this checking really needed in that place? It is possible to have
> contacts data
> in phonebook that have all data except phone set (by example: email
> addresses,
> main address etc). In that condition when we want to pull target vcard
> entry, then
> empty string will be returned even if user send ATTRIBUTE_MASK to include
> all fields
> in the result.
>

That piece of code is a legacy from simpler times, when we supported
less types of contact information.

> I'm asking because I have problem with "0.vcf" vcard (this is responsible
> for personal
> information of device owner). This entry by default does not have any
> phone's data
> filled in address book but it is mandatory to put this in vcard-listing.
> Actually, I am forced to initialize contact->numbers list with empty number
> even if
> none of number is available to return correct result for "0.vcf."(in
> phonebook-tracker)...
>
> Can this 'contact->numbers' checking be removed from there or maybe other
> phonebooks
> rely on this behaviour?

>From what I know, the Tracker backend is the only thing that relies on
that, so I think that check could be removed with little to no
problem. In fact, as you are already dealing with the empty numbers
list case, the problem is already solved.

>
> BR,
> Radek
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


Cheers,
-- 
Vinicius
