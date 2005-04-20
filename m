Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <e9a6e82b0504200915563ed0a0@mail.gmail.com>
From: Stefan Magdalinski <smagdali@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluez + 6630 rfcomm was working, suddenly died.
In-Reply-To: <1114008711.2469.175.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e9a6e82b050420074245382ddd@mail.gmail.com>
	 <1114008711.2469.175.camel@pegasus>
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
Date: Wed, 20 Apr 2005 17:15:46 +0100

looks like the version of hcidump (1.1.2) is too old for -V, but
here's what I get for -X

is there a repository I should be adding to sources.list to pull a newer on=
e?=20

thanks for your help

# hcidump -X
HCIDump - HCI packet analyzer ver 1.12
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: 63 ea dc 62 12 00 18 cc  02 00 00 00 01           c..b.........
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
> HCI Event: Link Key Request (0x17) plen 6
  0000: 63 ea dc 62 12 00                                 c..b..
> HCI Event: Connect Complete (0x03) plen 11
  0000: 22 29 00 63 ea dc 62 12  00 01 00                 ").c..b....



On 4/20/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Stefan,
>=20
> > I had bluez + ubuntu hoary making a ppp connection over bluetooth to
> > my 6630, just fine for a few days, by following the instructions here:
> >
> > http://www.teaparty.net/technotes/blue-gprs.html
> >
> > and then suddenly it broke.
> >
> > now, when I do
> > 'pppd call gprs', it just returns, the phone never prompts me to
> > accept the connection, and no connection is made.
> >
> > it seems to be communicating:
> >
> >  rfcomm show
> > rfcomm0: 00:12:62:DC:EA:63 channel 1 clean
> > root@stefvaio:~ # pppd call gprs
> > root@stefvaio:~ # rfcomm show
> > rfcomm0: 00:12:62:DC:EA:63 channel 1 config [tty-attached]
> > root@stefvaio:~ # rfcomm show
> > rfcomm0: 00:12:62:DC:EA:63 channel 1 config [tty-attached]
> > root@stefvaio:~ # rfcomm show
> > rfcomm0: 00:12:62:DC:EA:63 channel 1 config [tty-attached]
> > root@stefvaio:~ # rfcomm show
> > rfcomm0: 00:12:62:DC:EA:63 channel 1 config [tty-attached]
> > root@stefvaio:~ # rfcomm show
> > rfcomm0: 00:12:62:DC:EA:63 channel 1 config [tty-attached]
> > root@stefvaio:~ # rfcomm show
> > rfcomm0: 00:12:62:DC:EA:63 channel 1 config [tty-attached]
> > root@stefvaio:~ # rfcomm show
> > rfcomm0: 00:12:62:DC:EA:63 channel 1 config [tty-attached]
> > root@stefvaio:~ # rfcomm show
> > rfcomm0: 00:12:62:DC:EA:63 channel 1 disconnecting [tty-attached]
> > root@stefvaio:~ # rfcomm show
> > rfcomm0: 00:12:62:DC:EA:63 channel 1 closed
> > root@stefvaio:~ #
> >
> > but it doesn't seem able to make the connection anymore
> >
> > I did a couple of things (overexcited by the ease with which I got it
> > working), that might have caused this.
> >
> > I tried to re-pair the phone with the laptop, because I wanted to
> > change the name of the phone.  So I deleted the pairing on the phone,
> > and then the /etc/bluetooth/link_key . Now when I re-pair, it finds
> > the device, but just hangs with 'waiting for stefvaio-0', and then
> > 'says unable to pair' . The phone still works fine with another
> > machine running OSX (and I realise you can change the name without
> > re-pairing. woe is me)
> >
> > so it looks like pairing is the cause of the problem.
> >
> > How do I re-pair the phone with my laptop, short of reinstalling everyt=
hing?
> >
> > where should I  be looking for further diagnostics?
> >
> > I also changed my hcid.conf to try and get my palm sync working too,
> > so that may have caused the problem.
> >
> > I have attached the hcid.conf in case it's glaringly obvious.
> >
> > This is a shame. I've waited *years* for my phone to become a decent
> > access device, and then after a weekend I've broken it.
>=20
> show us the output of "hcidump -X -V" as root while you are trying to
> connect to your phone.
>=20
> Regards
>=20
> Marcel
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: New Crystal Reports XI.
> Version 11 adds new functionality designed to reduce time involved in
> creating, integrating, and deploying reporting solutions. Free runtime in=
fo,
> new features, or free trial, at: http://www.businessobjects.com/devxi/728
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
