Return-Path: <topsyturvy@nemo.student.utwente.nl>
Date: Wed, 23 Jun 2004 14:58:32 +0200 (CEST)
From: tOpSy TuRvY <topsyturvy@nemo.student.utwente.nl>
To: Marcel Holtmann <marcel@holtmann.org>
cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Slaves in Sniff mode
In-Reply-To: <1087992990.4209.79.camel@pegasus>
Message-ID: <Pine.BSO.4.58.0406231451130.835@nemo.student.utwente.nl>
References: <E1BcqIi-0002cT-53@sc8-sf-list2.sourceforge.net>
 <Pine.BSO.4.58.0406222046050.9882@nemo.student.utwente.nl>
 <1087939830.4209.12.camel@pegasus>  <Pine.BSO.4.58.0406222346200.5451@nemo.student.utwente.nl>
  <1087942444.4209.45.camel@pegasus>  <Pine.BSO.4.58.0406231319140.20827@nemo.student.utwente.nl>
 <1087992990.4209.79.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

I'm wondering how the master can request an unsniff if the slave is not 
listening to the channel.

I suppose the master should delay transmission till the next sniff window 
starts (i.e. as Peter suggested). Of course I'm guessing that at this 
point it could request an unsniff if the packet to be transmitted will 
not fit the sniff window.

Regards,
Assed

p.s. I'm also wondering how you get the time to reply to everybodys 
questions!

On Wed, 23 Jun 2004, Marcel Holtmann wrote:

> Hi Assed,
> 
> > Does anyone know if the master delays ACL transmittions to slaves in sniff 
> > mode (i.e. till they become active again), or will it just keep on 
> > transmitting the baseband frame till the slave eventually wakes up and can 
> > send an ACK.
> 
> the master should request an unsiff before it sends the next ACL packet.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by Black Hat Briefings & Training.
> Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
> digital self defense, top technical experts, no vendor pitches, 
> unmatched networking opportunities. Visit www.blackhat.com
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
