Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Andreas Fehr <andreas@mrs.ch>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth serial vs. audio connection
In-Reply-To: <Pine.LNX.4.62.0503280908130.3082@ybpnyubfg.ybpnyqbznva>
Message-ID: <Pine.LNX.4.62.0503281112030.3082@ybpnyubfg.ybpnyqbznva>
References: <Pine.LNX.4.62.0503271303450.3134@ybpnyubfg.ybpnyqbznva>
 <1111923433.9195.216.camel@pegasus>  <Pine.LNX.4.62.0503271357080.3134@ybpnyubfg.ybpnyqbznva>
  <1111926923.9195.218.camel@pegasus>  <Pine.LNX.4.62.0503271736360.3135@ybpnyubfg.ybpnyqbznva>
  <1111938339.9195.229.camel@pegasus>  <Pine.LNX.4.62.0503271751420.3135@ybpnyubfg.ybpnyqbznva>
  <1111939568.9195.236.camel@pegasus>  <Pine.LNX.4.62.0503271813180.3135@ybpnyubfg.ybpnyqbznva>
 <1111942691.9195.241.camel@pegasus> <Pine.LNX.4.62.0503280908130.3082@ybpnyubfg.ybpnyqbznva>
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
Date: Mon, 28 Mar 2005 11:15:48 +0200 (CEST)

On Mon, 28 Mar 2005, 09:11, Andreas Fehr (as AF) wrote:

>AF: >MH: > Yes, I misread the question. This is a Samsung SGH-D500 (a 
>AF: >MH: > nice phone but crappy windows software...)
>AF: >MH: > 
>AF: >MH: > No difference. With or without --tree, there is only one 
>AF: >MH: > line of output "Browsing 00:xx ...", nothing else
>AF: >MH: 
>AF: >MH: I actually meant the "spdtool search" part to see if the 
>AF: >MH: segmentation fault is still present then. However, again the 
>AF: >MH: bad Samsung phone. I think I need one of these at home for 
>AF: >MH: fixing this thing.

Well, I tried to debug this segmentation fault, but the changes I made 
in the code haven't been reflected in the binary. I'm not that 
experienced as a programmer, so I don't know what happened (probably 
due to the static declaration of the functions?)

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
