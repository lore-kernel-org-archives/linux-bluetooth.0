Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Andreas Fehr <andreas@mrs.ch>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth serial vs. audio connection
In-Reply-To: <1111939568.9195.236.camel@pegasus>
Message-ID: <Pine.LNX.4.62.0503271813180.3135@ybpnyubfg.ybpnyqbznva>
References: <Pine.LNX.4.62.0503271303450.3134@ybpnyubfg.ybpnyqbznva>
 <1111923433.9195.216.camel@pegasus>  <Pine.LNX.4.62.0503271357080.3134@ybpnyubfg.ybpnyqbznva>
  <1111926923.9195.218.camel@pegasus>  <Pine.LNX.4.62.0503271736360.3135@ybpnyubfg.ybpnyqbznva>
  <1111938339.9195.229.camel@pegasus>  <Pine.LNX.4.62.0503271751420.3135@ybpnyubfg.ybpnyqbznva>
 <1111939568.9195.236.camel@pegasus>
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
Date: Sun, 27 Mar 2005 18:21:06 +0200 (CEST)

On Sun, 27 Mar 2005, 18:06, Marcel Holtmann (as MH) wrote:

>MH: > >MH: >   "RFCOMM" (0x00000003)
>MH: > >MH: >     Channel: 4
>MH: > >MH: > Segmentation fault
>MH: > >MH: > root@notebook:/home/andreas >
>MH: > >MH: > 
>MH: > >MH: > (note the last 'Segmentation fault', this might be the 
>MH: > >MH: > reason, the browse command does not work as expected)
>MH: > >MH: 
>MH: > >MH: what kind of phone is this?
>MH: > 
>MH: > If I just run sdptool browse 00:xx, I don't get any output, I'm 
>MH: > not sure, this is the normal behavior. I see this as a problem, 
>MH: > as there are some supported services. But then, I didn't check 
>MH: > the code of this tool.
>MH: 
>MH: this does not answer my question. What kind of phone is this? Does 
>MH: adding "--tree" before the "--bdaddr" parameter helps?

Yes, I misread the question. This is a Samsung SGH-D500 (a nice phone 
but crappy windows software...)

No difference. With or without --tree, there is only one line of output 
"Browsing 00:xx ...", nothing else



>MH: > >MH: > Thanks so far, but how to proceed? (I've still the same 
>MH: > >MH: > problem, connecting with bluez 'only' gives an 'audio' 
>MH: > >MH: > connection, not the expected 'serial' as I got from 
>MH: > >MH: > Windows).
>MH: > >MH: 
>MH: > >MH: What happens if you connect to channel 3 or channel 4?
>MH: > 
>MH: > Duh.... well... thanks for the hint... of course, if I use 
>MH: > channel 3 (as given in the output of "sdptool search .. sp" it 
>MH: > does work, I get a 'serial' connection. I'll test this with 
>MH: > minicom, whether I can use all the commands I need, but I'm 
>MH: > confident.
>MH: > 
>MH: > Now, I wonder, whether there is some information on service <=> 
>MH: > channel pairs that I should have read?
>MH: 
>MH: This phone have the serial port profile service on channel 3 and 
>MH: the dialup networking profile service on channel 4. You can see 
>MH: everything in the sdptool output.

Yes, I see this now. But is it written somewhere in the documentation, 
that these services are bound to different channels? I wasn't aware of 
the fact.

Thanks anyway, it works now.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
