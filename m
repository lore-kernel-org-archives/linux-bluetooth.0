Return-Path: <theo.beisch@gmx.de>
From: Theo Beisch <theo.beisch@gmx.de>
Reply-To: theo.beisch@gmx.de
To: Marcel Holtmann <marcel@holtmann.org>,
   Paulo Marques <pmarques@grupopie.com>
Subject: Re: [Bluez-users] help for bluez and bridge configuration needed
Date: Wed, 8 Oct 2003 21:10:12 +0200
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <200310062337.37090.root <> <3F82A016.2050901@grupopie.com> <1065526456.5327.45.camel@pegasus>
In-Reply-To: <1065526456.5327.45.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200310082110.19194.theo.beisch@gmx.de>
List-ID: <bluez-users.lists.sourceforge.net>

Marcel,

thanks, I tried this but couldnt get it to work at least with SuSEfirewall2, 
activating NAT between the internal:pan0 (bridge) and external:eth0. ANy 
other ways?

What I am trying to get to: as I use my linux-laptop online (DHCP on eth0 in 
different networks) and offline (with th PDA/BT connection with apache etc. 
running on the laptop) my plan was to have a default configuration which at 
boot is overridden after DHCP on eth0 (or the bridge) has provided the laptop 
with its network IP, gateway and so on.

As I said, new to all this stuff....

Tx again
Theo

Am Dienstag, 7. Oktober 2003 13:34 schrieb Marcel Holtmann:
> Hi,
>
> > The problem is that when the bnep0 interface enters the bridge, the
> > bridge's "mac address" changes. You can see that happening doing a
> > "ifconfig pan0" before the bnep0 joining the bridge and after, to see the
> > hardware address of the pan0 interface.
> >
> > I tried to solve this by issuing "arping's" so that other machines on the
> > network would be warned about the new hardware address, but unfortunately
> > never got this to work properly... :(
>
> I never put the eth0 into the bridge ;) You can use IP forwarding and
> NAT between eth0 und pan0.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

-- 
Theo Beisch
106 Ronheider Weg
Aachen, Germany 52066
Tel +49 (241) 13935 & +49 (9401) 6000283
Mobil +49 (172) 2102211
theo.beisch@gmx.de
