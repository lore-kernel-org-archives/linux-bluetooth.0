Return-Path: <topsyturvy@nemo.student.utwente.nl>
Date: Thu, 24 Jun 2004 14:46:55 +0200 (CEST)
From: tOpSy TuRvY <topsyturvy@nemo.student.utwente.nl>
To: Marcel Holtmann <marcel@holtmann.org>
cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] BT_ADDR Address Resolution
In-Reply-To: <1088080317.4296.59.camel@pegasus>
Message-ID: <Pine.BSO.4.58.0406241437430.23390@nemo.student.utwente.nl>
References: <200406241009.i5OA9wFo030305@news01.csr.com>
 <Pine.BSO.4.58.0406241335110.23949@nemo.student.utwente.nl>
 <1088078815.4296.55.camel@pegasus>  <Pine.BSO.4.58.0406241408110.8407@nemo.student.utwente.nl>
 <1088080317.4296.59.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

> the Linux PAN is a point-to-point connection. If you want to build a NAP
> or GN you must also use the Linux bridge. So this is not a PAN question,
> this depends on how you configured your bridge.

You are right, it was a bridge question. I think it would be fair to 
assume that the bridge is going to forward all broadcast traffic it 
recieves on all the ports (except the one it came on).

> 
> > Also does the bridge implimentation result in one broadcast per "port" 
> > i.e. instead of one baseband layer broadcast (i.e. LT_ADDR = 000), we will have 
> > as many broadcasts as the number of connected PANUs (i.e. one per 
> > port)?
> 
> No Bluetooth broadcast is used. Read the BNEP and PAN specifications.
> 

Read those and tried to understand them. What I gathered is that there 
will be one Bluetooth broadcast sent to each of the connected PANUs. i.e. 
one Bluetooth broadcast sent on each bridge port, and that seems very 
wasteful since just one bluetooth broadcast on any port would have been 
recieved by all the PANUs right?


Regards,
Assed
