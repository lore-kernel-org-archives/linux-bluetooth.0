Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth serial vs. audio connection
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.62.0503271736360.3135@ybpnyubfg.ybpnyqbznva>
References: <Pine.LNX.4.62.0503271303450.3134@ybpnyubfg.ybpnyqbznva>
	 <1111923433.9195.216.camel@pegasus>
	 <Pine.LNX.4.62.0503271357080.3134@ybpnyubfg.ybpnyqbznva>
	 <1111926923.9195.218.camel@pegasus>
	 <Pine.LNX.4.62.0503271736360.3135@ybpnyubfg.ybpnyqbznva>
Content-Type: text/plain
Message-Id: <1111938339.9195.229.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 27 Mar 2005 17:45:39 +0200

Hi Andreas,

> >MH: then do "sdptool search --bdaddr <bdaddr> {sp|dun}".
> 
> 
> Ok, I see... this could lead to something. I've the following output:
> 
> root@notebook:/home/andreas > sdptool search --bdaddr 00:xx sp
> Searching for sp on 00:xx ...
> Service Name: Serial Port
> Service RecHandle: 0x10003
> Service Class ID List:
>   "Serial Port" (0x1101)
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>   "RFCOMM" (0x0003)
>     Channel: 3
> 
> root@notebook:/home/andreas > sdptool search --bdaddr 00:xx dun
> Searching for dun on 00:xx ...
> Service Name: Dial-up networking
> Service RecHandle: 0x10002
> Service Class ID List:
>   "Dialup Networking" (0x00001103)
> Protocol Descriptor List:
>   "L2CAP" (0x00000100)
>   "RFCOMM" (0x00000003)
>     Channel: 4
> Segmentation fault
> root@notebook:/home/andreas >
> 
> (note the last 'Segmentation fault', this might be the reason, the 
> browse command does not work as expected)

what kind of phone is this?

> Thanks so far, but how to proceed? (I've still the same problem, 
> connecting with bluez 'only' gives an 'audio' connection, not the 
> expected 'serial' as I got from Windows).

What happens if you connect to channel 3 or channel 4?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
