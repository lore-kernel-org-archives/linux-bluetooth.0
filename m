Return-Path: <bluez@thomae-privat.de>
Message-ID: <40A480B8.2050400@thomae-privat.de>
Date: Fri, 14 May 2004 10:18:00 +0200
From: Matthias Thomae <bluez@thomae-privat.de>
MIME-Version: 1.0
To: Christoph Scholz <scholz@cs.uni-bonn.de>
CC: bluez-devel@lists.sourceforge.net, marcel@holtmann.org
Subject: Re: [Fwd: Re: [Bluez-devel] PAN and bridge problem when bnep0	disconnects
 before bnep1]
References: <1084467658.2322.37.camel@willie.informatik.uni-bonn.de>
In-Reply-To: <1084467658.2322.37.camel@willie.informatik.uni-bonn.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Christoph, Marcel, all,

Christoph Scholz wrote:
>>Aha. These MAC addresses seem to be used in the forwarding database. 
>>Maybe setting the ageing time to 0 (man brctl) would help...
> 
> 
> I don't think so. The problem is that the code assumes that MAC
> addresses are unique. Even if there are multiple Bluetooth BNEP devices,
> there will only be one entry in the forwarding database. When one of the
> devices is removed, this entry in the forwarding database is also
> removed.

You are right, setting ageing 0 doesn't help.

>><shemminger@osdl.org>
>>	[BRIDGE]: Forwarding database changes.
>>	
>>	Make forwarding database more robust.
>>	  + Don't insert invalid ether address,
>>	  + Report errors back so adding an interface to bridge can fail
>>	  + get rid of unneeded explicit pads in data structure
>>	  + replace bitfields with byte's for simple booleans.
>>
>>Maybe that fixes our problem? I might be able to try 2.6.6 and the 
>>ageing timer tonight...

2.6.6 (-mh1) didn't help either...

> I am not sure but I would guess that the problem is still there. The
> same warning can be found in br_fdb.c in 2.6.6:
> 
> printk(KERN_INFO "%s: attempt to add" " interface with same source add
> ress.\n", source->dev->name);

I also tried the patch that Diego Liziero mentioned in his post, but it 
didn't help either...

> I have not written to to the bridge people. My personal opinion is that
> BlueZ should do the forwarding (like Affix does). You can argue about
> that of course.

I don't have a competent opinion about that (except: it's not only the 
forwarding problem, but also DHCP, right?), and don't know what Affix does.

Marcel, what do you think? Is there any sense to contact the bridge people?

Regards.
Matthias
