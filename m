Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: billy pucyutan <billy@asti.dost.gov.ph>
Reply-To: billy@asti.dost.gov.ph
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluez-utils 2.7 default configuration
References: <20040511192919.GB28581@gmx.net> <1085045305.28151.1269.camel@hades.cambridge.redhat.com> <1085046154.4327.147.camel@pegasus>
In-Reply-To: <1085046154.4327.147.camel@pegasus>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <200405201805.02911.billy@asti.dost.gov.ph>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 20 May 2004 18:04:58 -0400

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi! I recompiled your ppc rpms to i386 rpms. It is available at=20

http://kde4bl.pandayan.bayanihan.gov.ph/

Basically, these are Fedora Core 2 rpms for BlueZ.

On Thursday 20 May 2004 05:42, Marcel Holtmann wrote:
> Hi David,
>
> > It's in the bluez-utils-cups RPM. I haven't tried it as I have no
> > suitable hardware. We only have the client side implemented, don't we --
> > I can't emulate it by using another Linux/BlueZ box as the 'printer'?
>
> that is great. A "server side" is on my todo list, but I haven't written
> any line of code so far.
>
> > I note it doesn't actually try very hard to find printers :)
>
> You have to give the right URI. For example for a printer with Bluetooth
> address 00:90:02:63:e0:83 it is bluetooth://00900263E083/
>
> > > > In fact, I suspect that the right answer for pand is to tie it into
> > > > the initscripts and system-config-network, so you add an interface =
of
> > > > type 'PAN slave' or 'PAN master' and the network scripts handle
> > > > starting and stopping the daemon like they do ipppd, rather than
> > > > doing it from a SysV init script. I haven't used dund so I'm less
> > > > sure about that but it might also be the right approach there.
> > >
> > > I am not a Fedora Core user, so I can't answer this question, but in
> > > general it is up to you to decide.
> >
> > That's not really distro-specific. Well, the precise details of the
> > implementation might be -- but the idea that it's done in network
> > configuration and started like pppd on 'ifup', rather than by init like
> > a system daemon, isn't.
>
> For pand you simply start it and let the IP assignment done by the
> network hotplugging. For dund this is done by your pppd scripts. So no
> IP configuration has to be done in the init scripts, but you have to
> start the daemons somewhere. Otherwise you won't get the SDP entries and
> so nobody can find your service.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g.
> Take an Oracle 10g class now, and we'll give you the exam FREE.
> http://ads.osdn.com/?ad_id=3D3149&alloc_id=3D8166&op=3Dclick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFArSuNG/HeFwSbwiYRAq5EAJ9XV26XKQsOgj8pDqlXl/Wy6BkUoQCfbSWJ
zhT0uHM37/J3GCoEVSKHRGY=3D
=3Dm9HN
=2D----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
