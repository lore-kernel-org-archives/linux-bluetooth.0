Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <320075ff0409270050bbaf228@mail.gmail.com>
From: Nigel Magnay <nigel.magnay@gmail.com>
Reply-To: Nigel Magnay <nigel.magnay@gmail.com>
To: Wolfgang <wood.stock@gmx.net>
Subject: Re: [Bluez-users] ipaq 1945
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <003001c4a3ba$d064fba0$8696a8c0@marcy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <320075ff040925153753850d92@mail.gmail.com>
	 <1096153758.7719.12.camel@pegasus>
	 <320075ff040926011212538dac@mail.gmail.com>
	 <003001c4a3ba$d064fba0$8696a8c0@marcy>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 27 Sep 2004 08:50:59 +0100

Hm - don't think its that; I turned off all the firewall options when
installing because I am behind a router.

It's odd because it all looks like it's working (in that it connects
and information seems to flow), just that the ipaq doesn't seem to be
able to talk to the linux box

Unless I've missed some additional step - I'm not running bridging or
anything since I just wanted to try and talk to the host linux box -
perhaps I should install those modules and give that a go.

On Sun, 26 Sep 2004 13:20:22 +0200, Wolfgang <wood.stock@gmx.net> wrote:
> Just a non-technical idea:
> 
> It took me two nights to find out that SuSE has a
> running firewall and every new interface like bnep0 *is*
> protected.....
> 
> Wood
> 
> 
> 
> 
> ----- Original Message -----
> From: "Nigel Magnay" <nigel.magnay@gmail.com>
> To: "Marcel Holtmann" <marcel@holtmann.org>;
> <bluez-users@lists.sourceforge.net>
> Sent: Sunday, September 26, 2004 10:12 AM
> Subject: Re: [Bluez-users] ipaq 1945
> 
> > it's 2.6.8.1, built on FC2
> >
> >
> > On Sun, 26 Sep 2004 01:09:18 +0200, Marcel Holtmann <marcel@holtmann.org>
> wrote:
> > > Hi Nigel,
> > >
> > >
> > >
> > > > I'm having a bit of trouble. I'm using kernel 2.6.8.1, and I'm trying
> > > > to get my iPaq 1945 to be able to connect via bluetooth to the
> > > > internet, though to start with I'm just trying to get it to connect to
> > > > the host computer.
> > > >
> > > > I think everything is working correctly - I have the stack up and
> > > > running, I can get my bnep0 interface up, and assign it an ip address
> > > > - e.g. 192.168.1.56. I can then ping that address from linux, and I
> > > > can browse it as an internet connection on my ipaq, and connect to it.
> > > >
> > > > Problem is, neither IE nor Pocket puTTY can use the connection (I try
> > > > to ssh to 192.168.1.55, my linux box). I don't know if I'm just
> > > > missing something, but I've read all the guides and I'm just confused
> > > > as to whether I'm trying something that isn't possible.
> > >
> > > what kernel version do you use on your Linux machine?
> > >
> > > Regards
> > >
> > > Marcel
> > >
> > >
> >
> >
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
> > Project Admins to receive an Apple iPod Mini FREE for your judgement on
> > who ports your project to Linux PPC the best. Sponsored by IBM.
> > Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
> 
>


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
