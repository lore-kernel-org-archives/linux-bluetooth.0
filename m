Return-Path: <wadgienaughton@hotmail.com>
From: "Ronan Naughton" <wadgienaughton@hotmail.com>
To: marcel@holtmann.org
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth Scatternet
Date: Sat, 27 Mar 2004 14:04:32 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY10-F36jyAG8SjQhX00018932@hotmail.com>
List-ID: <bluez-users.lists.sourceforge.net>

Ya, I can do that. I can connect to one pan using bnep0 acting as a slave. 
Then I can make it a master on bnep1 and conncet to it form another pc. When 
I do "pand --show", it shows both interfaces bnep0 and bnep1 and their 
connections.
However, I cannot communicate between the two networks. When I even try to 
ping the master of the other network it comes up host unreachable. I don't 
know why this is?
Ronan.


>From: Marcel Holtmann <marcel@holtmann.org>
>To: Ronan Naughton <wadgienaughton@hotmail.com>
>CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
>Subject: Re: [Bluez-users] Bluetooth Scatternet
>Date: Fri, 26 Mar 2004 00:37:08 +0100
>
>Hi Ronan,
>
> > Has anyone ever implemented a bluetooth scatternet using pan over bnep.
> > I have two simple piconets running at the moment and want to join them.  
>How
> > will I assign it so that a node can be a slave in both piconets. Do i 
>need
> > two bnep connections. Or should I have a node to be a master in one 
>piconet
> > and a slave in an other. How is this implemented?
>
>you need a scatternet capable Bluetooth chip, which means a chip which
>can be master in one and slave in another or slave in two different
>piconets. Actually you form a scatternet if one of these two conditions
>are present and each connection will have its own BNEP connection.
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: IBM Linux Tutorials
>Free Linux tutorial presented by Daniel Robbins, President and CEO of
>GenToo technologies. Learn everything from fundamentals to system
>administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users

_________________________________________________________________
The new MSN 8: smart spam protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail
