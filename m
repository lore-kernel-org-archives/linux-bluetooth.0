Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Fred Schaettgen <bluez-user@schaettgen.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] local device class...
References: <01LKX8B5H2GA00ECYA@beacon.nuigalway.ie>
In-Reply-To: <01LKX8B5H2GA00ECYA@beacon.nuigalway.ie>
Cc: Triona Ryan <triona.ryan@nuigalway.ie>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200502172355.12550.bluez-user@schaettgen.de>
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
Date: Thu, 17 Feb 2005 23:55:12 +0100

On Thursday 17 February 2005 20:42, Triona Ryan wrote:
> Ok, I seem to be very much ignored.
>
> Thanks very much

You're welcome :P
Maybe you're waiting so long (about 9 hours already!) for an answer because 
those misplaced wh itespace and linebreaks scared the readers? Or it's just 
because no one tried hard enough to figure out what you tried to achieve by 
doing what.
So in short: you want to send files to another PC and it's not working, right? 
Do you have an obex server running? Which one? Did it register with the SDP 
server (hint: sdptool --help)? The device class has very little to do with 
that. 

> However, IF there's any
> one out there using this list EXCEPT for one on-going thread, could someone
> plea se check their hciconfig -a and see if their device class matches
> their services . I'm using college lab computers, and I installed BT on one

The device class is not meant to match all your services. 
That's what the sdp server is for.

..
> computer a few week s ago, and it gave me 0x100 as device class, but last
> week I installed all on an other computer, and I got 0x3e0100. They're ALL
> linked to the SAME lan, and SAME computers etc. I changed the first
> computer to ox100100, to set Object Transfer , which immediately worked,
> but the other one is set already and isn't registeri ng the service. Why

"Is set already"? Set the device class to 0x100100? What makes you think it 
isn't registering the service? Did you actually check the sdp server or are 
you talking about the device class?

Fred

-- 
Fred Schaettgen
bluez-devel@schaettgen.de


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
