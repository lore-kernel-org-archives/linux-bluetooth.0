Return-Path: <topsyturvy@nemo.student.utwente.nl>
Date: Wed, 23 Jun 2004 00:07:27 +0200 (CEST)
From: tOpSy TuRvY <topsyturvy@nemo.student.utwente.nl>
To: Marcel Holtmann <marcel@holtmann.org>
cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Max Number of PANUs supported in PAN
In-Reply-To: <1087939830.4209.12.camel@pegasus>
Message-ID: <Pine.BSO.4.58.0406222346200.5451@nemo.student.utwente.nl>
References: <E1BcqIi-0002cT-53@sc8-sf-list2.sourceforge.net>
 <Pine.BSO.4.58.0406222046050.9882@nemo.student.utwente.nl>
 <1087939830.4209.12.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-users.lists.sourceforge.net>


Hi Marcel,

I am not really interested in the actual number of parked devices, I just 
assumed if you can support one parked slave, you can support an arbirtary 
number.

I will therefore re-phrase my question to: Can one PAN support 9 PANUs, 
i.e. there will always be atleast one parked PANU. The GN will now have to 
juggle PANUs between active and parked modes so they all seem "connected" 
and are able to communicate with each other.

Thanks.

Regards,
Assed


Can one PAN support 9 devices i.e. 8 active and 1 parked

On Tue, 22 Jun 2004, Marcel Holtmann wrote:

> Hi Assed,
> 
> > Can someone tell me the maximum number of users supported in one PAN?
> > I guess this question boils down to:
> > 
> > a) Are PANUs in Parked mode supported (i.e. 200+ PANUs in one PAN 
> > possible).
> > b) Is the PAN able to juggle PANUs between active and parked mode so 
> > they all seem "connected" and are able to communicate with each 
> > other.
> > 
> > Also, can something tell me if something like above is possible in the BT 
> > SIG PAN specification, or does it also support a maximum of 8 users in a 
> > PAN.
> 
> actually this might be possible. I never tried it, but the bigger
> problem will be to find a Bluetooth chip that is tested to work with
> seven actives slaves and a big number of parked devices in one piconet.
> 
> Regards
> 
> Marcel
> 
> 
> 
