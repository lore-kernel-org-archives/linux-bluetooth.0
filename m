Return-Path: <jd@sdf.lonestar.org>
Date: Fri, 30 Jul 2004 08:36:42 -0500 (CDT)
From: John Dahlstrom <jd@freeshell.org>
To: Marcel Holtmann <marcel@holtmann.org>
cc: bluez-devel@lists.sourceforge.net
Subject: Re: Linux 2.4.27rc3 and Bluetooth
In-Reply-To: <1090055676.4558.15.camel@pegasus>
Message-ID: <Pine.NEB.4.60.0407300813490.24330@mx.freeshell.org>
References: <Pine.NEB.4.60.0407131537590.12135@norge.freeshell.org>
 <1089826204.4517.0.camel@pegasus>  <Pine.NEB.4.60.0407141844100.22049@mx.freeshell.org>
 <1090055676.4558.15.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

Yes, your new patch works!

When the firmware file is removed and the Bluetooth card is inserted,
the machine humbly protests as expected, without a kernel panic.
Then, with the file copied back into place, everything runs smoothly
upon subsequent insertions.

Thank you again for your assistance.

Kind regards,

- John

--
http://jodarom.sdf1.org/



On Sat, 24 Jul 2004, Marcel Holtmann wrote:

> Hi John,
>
>> [...]
>
> you are right. That is the problem. I fixed it in a different way.
> Please try out the attached patch and report if it also works.
>
>> [...]
>
> No. The 2.6 kernel is not affected, because the hdev is a pointer in
> that kernel series and we have the NULL pointer check in place.
>
> Regards
>
> Marcel
>
