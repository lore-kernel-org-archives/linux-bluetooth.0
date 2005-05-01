Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Joshua Davis <crossbox@stealth.kirenet.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] BlueZ: Accepting incoming traffic
In-Reply-To: <1114959364.21785.18.camel@pegasus>
Message-ID: <Pine.LNX.4.30.0505011109330.22819-100000@stealth.kirenet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 1 May 2005 11:13:03 -0400 (EDT)


  I see.  So when we tell it not to respond to probes, we are just setting
a bit in the chip?  There is memory in the chip to store the name, then?
THis is correct?

 Thanks :)


   ----
   Joshua Davis
   Transient Infrastructure Security Solutions


  /"\
  \ /    ASCII Ribbon Campaign
   X   against HTML email & vCards
  / \



On Sun, 1 May 2005, Marcel Holtmann wrote:

> Hi Joshua,
>
> >   This is an impossibility?  I know that using hciconfigure and hcid I can
> > set what name my computer uses to respond to probes.  Something on my
> > computer is thus hearing these probes.  Is this just taking place in the
> > kernel?
>
> it is taking place inside the Bluetooth chip itself. No further
> interaction with the host stack is needed.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.
> Get your fingers limbered up and give it your best shot. 4 great events, 4
> opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
> win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
