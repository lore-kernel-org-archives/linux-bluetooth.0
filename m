Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Fernando Unzu <fernando@bluexare.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Wed, 14 Feb 2007 11:36:42 +0100
References: <200702071644.02277.fernando@bluexare.org>
	<1171309461.11774.22.camel@violet>
In-Reply-To: <1171309461.11774.22.camel@violet>
MIME-Version: 1.0
Message-Id: <200702141136.42898.fernando@bluexare.org>
Subject: Re: [Bluez-devel] Pairing event in a module
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Marcel,


El Lunes, 12 de Febrero de 2007 20:44, Marcel Holtmann escribi=F3:
> Hi Fernando,
>
> > I'm trying to develop an application that works with mobil devices.
> >
> > I want to caugth the pairing event to do some things...
> >
> > Only I need the device address of it, when the device pairs to me.
> >
> > I have been seen the code, but I don't know how I can integrate to my
> > module.
> >
> > The link_key_notify shows when a device have paired with me, but how can
> > I "listen" until the launch of this method?
> > How I can listen the EVT_LINK_KEY_NOTIFY event?
> >
> > Which method launch this events??
> >
> > I have seen that io_security_event do something with this events when
> > they are launched, but..., Who launch them?
> >
> > Or, if i can listen these envets, It would be sufficient for me.
>
> use the D-Bus API and listend to BondingCreated signals. Playing on the
> low-level HCI is not a good idea at all.
>
> Regards
>
> Marcel

You have all the reason saying that works with low-level HCI is not a good =

idea, jejej (although I have develop a non perfect solution).

But if you inform me something about where I can find information about D-B=
us, =

and where I can see the api, the code or the functions that uses...., I wou=
ld =

be thankfull and try to understand and learn about it.
Now, I don't know a lot about D-Bus.

Thank you very much,

Fernando

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
