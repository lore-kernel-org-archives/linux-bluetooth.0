Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1270577971.764253.580.nullmailer@galant.ukfsn.org>
References: <r2if3ae2ce11004061001mc539e7eaq206d43ffb12fb2d2@mail.gmail.com>
	<j2tf3ae2ce11004061008x26da852el996b017a5115d595@mail.gmail.com>
	<1270577971.764253.580.nullmailer@galant.ukfsn.org>
From: Garry Paxinos <paxinos@gmail.com>
Date: Tue, 6 Apr 2010 14:32:06 -0400
Message-ID: <x2xf3ae2ce11004061132gd546fb7emd890e6c096c72bd3@mail.gmail.com>
Subject: Re: upper limit of bonded devices?
To: Iain Hibbert <plunky@rya-online.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for the quick reply!    We actually have an application that
could conceivable pair with over 1M devices if the project is
successful.

There are really two other issues to resolve in this scenario -

1. Is it possible to have the computer initiate the connection to a
bonded device without previously knowing what devices are currently in
the vicinity?  Especially when our bonded DB is excessively large.

2. Is there a way (even if we need to do device driver work) to gain
access to signal strength before bonding to  a device?  And before
connecting to a device?  We really need to limit ourselves to bonding
and connecting with devices that are located in a very close
proximity.

Thanks,
Pax.

On Tue, Apr 6, 2010 at 2:19 PM, Iain Hibbert <plunky@rya-online.net> wrote:
> On Tue, 6 Apr 2010, Garry Paxinos wrote:
>
>> Is there a practical upper limit of the number of devices that can be
>> bonded to a single computer?
>>
>> I am considering reworking the bonding code to use a MySQL DB to store
>> the list of devices, but was wondering if there was any other limit
>> (either coding or practical).   For example, can a single computer
>> bond with 1k devices?  what about 100K or even 1M ?
>
> There is no reason it cannot pair with such a number of devices though I
> can't think how you will fit them all in your pocket..
>
> ..but bear in mind that it cannot connect with more than 7 in a Bluetooth
> piconet at any one time. (perhaps with other transports it can do more)
> and because pairing generally involves human interaction, it is not a
> frequently occurring event.
>
> I suspect the vast majority of usage case is pairing with <10 in the
> lifetime of the device and that using a MySQL database would be just
> overkill.. but perhaps there are other, more minimal, data-storage front
> ends that can be used (cdb?), if you wanted to provide generic access to
> the information..
>
> regards,
> iain
>
