Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Andreas Fehr <andreas@mrs.ch>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth serial vs. audio connection
In-Reply-To: <1111923433.9195.216.camel@pegasus>
Message-ID: <Pine.LNX.4.62.0503271357080.3134@ybpnyubfg.ybpnyqbznva>
References: <Pine.LNX.4.62.0503271303450.3134@ybpnyubfg.ybpnyqbznva>
 <1111923433.9195.216.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Sun, 27 Mar 2005 14:01:38 +0200 (CEST)

On Sun, 27 Mar 2005, 13:37, Marcel Holtmann (as MH) wrote:

>MH: > I have a problem connecting to my phone with my computer. With 
>MH: > Linux, I only get an 'audio' connection, on the same computer 
>MH: > (using VMware) I get a 'serial' connection. With this audio 
>MH: > connection, I'm not able to read data from my mobile phone. How 
>MH: > is it possible to get a serial connection? Is there some 'howto' 
>MH: > on this?
>MH: 
>MH: in general you only do:
>MH: 
>MH: 	rfcomm connect 0 <bdaddr> <channel>
>MH: 
>MH: and then /dev/rfcomm0 is your serial port of the phone. However you 
>MH: may have to check with "sdptool browse <bdaddr>" what's the channel 
>MH: for the serial port or dialup networking profile.

Hmm, in theory... yes. But as soon as rfcomm comes up, my phone asks me, 
if I want an 'audio' connection. If I connect with the windows software, 
the mobile asks me, if I want a 'serial' connection.

sdptool browse 00:xx gives no information. Just the line "Browsing 00:xx 
..." Any idea on that?


Thanks for the fast reply,
Andreas


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
