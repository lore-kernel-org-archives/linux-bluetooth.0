Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth serial vs. audio connection
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.62.0503271751420.3135@ybpnyubfg.ybpnyqbznva>
References: <Pine.LNX.4.62.0503271303450.3134@ybpnyubfg.ybpnyqbznva>
	 <1111923433.9195.216.camel@pegasus>
	 <Pine.LNX.4.62.0503271357080.3134@ybpnyubfg.ybpnyqbznva>
	 <1111926923.9195.218.camel@pegasus>
	 <Pine.LNX.4.62.0503271736360.3135@ybpnyubfg.ybpnyqbznva>
	 <1111938339.9195.229.camel@pegasus>
	 <Pine.LNX.4.62.0503271751420.3135@ybpnyubfg.ybpnyqbznva>
Content-Type: text/plain
Message-Id: <1111939568.9195.236.camel@pegasus>
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
Date: Sun, 27 Mar 2005 18:06:08 +0200

Hi Andreas,

> >MH: > root@notebook:/home/andreas > sdptool search --bdaddr 00:xx dun
> >MH: > Searching for dun on 00:xx ...
> >MH: > Service Name: Dial-up networking
> >MH: > Service RecHandle: 0x10002
> >MH: > Service Class ID List:
> >MH: >   "Dialup Networking" (0x00001103)
> >MH: > Protocol Descriptor List:
> >MH: >   "L2CAP" (0x00000100)
> >MH: >   "RFCOMM" (0x00000003)
> >MH: >     Channel: 4
> >MH: > Segmentation fault
> >MH: > root@notebook:/home/andreas >
> >MH: > 
> >MH: > (note the last 'Segmentation fault', this might be the reason, the 
> >MH: > browse command does not work as expected)
> >MH: 
> >MH: what kind of phone is this?
> 
> If I just run sdptool browse 00:xx, I don't get any output, I'm not 
> sure, this is the normal behavior. I see this as a problem, as there 
> are some supported services. But then, I didn't check the code of this 
> tool.

this does not answer my question. What kind of phone is this? Does
adding "--tree" before the "--bdaddr" parameter helps?

> >MH: > Thanks so far, but how to proceed? (I've still the same problem, 
> >MH: > connecting with bluez 'only' gives an 'audio' connection, not the 
> >MH: > expected 'serial' as I got from Windows).
> >MH: 
> >MH: What happens if you connect to channel 3 or channel 4?
> 
> Duh.... well... thanks for the hint... of course, if I use channel 3 (as 
> given in the output of "sdptool search .. sp" it does work, I get a 
> 'serial' connection. I'll test this with minicom, whether I can use all 
> the commands I need, but I'm confident.
> 
> Now, I wonder, whether there is some information on service <=> channel 
> pairs that I should have read?

This phone have the serial port profile service on channel 3 and the
dialup networking profile service on channel 4. You can see everything
in the sdptool output.

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
