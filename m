Return-Path: <nigel.magnay@gmail.com>
Message-ID: <320075ff04092805251ce925e6@mail.gmail.com>
Date: Tue, 28 Sep 2004 13:25:49 +0100
From: Nigel Magnay <nigel.magnay@gmail.com>
Reply-To: Nigel Magnay <nigel.magnay@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] ipaq 1945
Cc: Wolfgang <wood.stock@gmx.net>, bluez-users@lists.sourceforge.net
In-Reply-To: <1096371841.4950.5.camel@notepaq>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <320075ff040925153753850d92@mail.gmail.com>
	 <1096153758.7719.12.camel@pegasus>
	 <320075ff040926011212538dac@mail.gmail.com>
	 <003001c4a3ba$d064fba0$8696a8c0@marcy>
	 <320075ff0409270050bbaf228@mail.gmail.com>
	 <1096371841.4950.5.camel@notepaq>
List-ID: <bluez-users.lists.sourceforge.net>

I got a lot further, I can connect to my server now; I am just left
with trying to understand why I can't get bridging to work.

I have:
 - router (Internet, DHCP serving 192.168.1.{100-200}) (255.255.255.0)
 - linux box, eth0 = 192.168.1.55 (fixed), bnep0 for bluetooth
 - iPaq connecting to bluetooth

I can talk to the server by making bnep0 192.168.*2*.254 and fixing
the IP address in the ipaq (or running a dchp server on linux as
well), but it would be nice to not have to have another dchp server.

I had thought I could bridge the interfaces, but I have tried lots of
things like
brctl addbr br0
 brctl addif br0 eth0
 brctl addif br0 bnep0

but that just leads to aggravating things like the linux box dropping
off the network altogether ..




On Tue, 28 Sep 2004 13:44:01 +0200, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Nigel,
> 
> > Hm - don't think its that; I turned off all the firewall options when
> > installing because I am behind a router.
> >
> > It's odd because it all looks like it's working (in that it connects
> > and information seems to flow), just that the ipaq doesn't seem to be
> > able to talk to the linux box
> >
> > Unless I've missed some additional step - I'm not running bridging or
> > anything since I just wanted to try and talk to the host linux box -
> > perhaps I should install those modules and give that a go.
> 
> please try some older kernel versions and see if one of them works,
> because the default filter setting has some side effects I haven't
> thought of so far.
> 
> Regards
> 
> Marcel
> 
>
