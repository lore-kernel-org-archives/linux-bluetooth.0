Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: bluez-devel <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Crosscompiling HCIEMU
In-Reply-To: <IA5UYB$8CDBA1E15CF3997E0FCABCA3192E8041@uol.com.br>
Message-ID: <Pine.LNX.4.33.0501111735130.4468-100000@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
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
Date: Tue, 11 Jan 2005 17:38:40 +0100 (CET)


Hi,

I haven't tried HCIEmu, but for libs / utils you have to add a line like

--includedir=3D$XPREFIX/include

to the configure arguments. $XPREFIX points to the "root" of your target
file system.

Ciao,
	Peter


On Tue, 11 Jan 2005, omap wrote:

>
> Hi Marcel,
>
> Well, I have to deploy bluetooth into
> this platform and we dont have any
> bluetooth device to test it. So, I
> thought i coult use hciemu to make tests.
>
> I am using a crosscompiling evironment
> called SCRATCHBOX. The problem is that
> the compiler can not find the glib.h.
> I verified and the file is there but
> for some reason it can not be found.
>
> Regards
>
> > Hi,
> >
> > > I am trying to compile HCIemu for ARM
> > > platform, but i am having problems.
> > > has Any one tryed it before?
> >
> > I haven't, but for what do you need
> hciemu on an ARM platform?
> >
> > Regards
> >
> > Marcel
> >
> >
> >
> >
> >
> -------------------------------------------------------
> > The SF.Net email is sponsored by:
> Beat the post-holiday blues
> > Get a FREE limited edition
> SourceForge.net t-shirt from ThinkGeek.
> > It's fun and FREE -- well,
> almost....http://www.thinkgeek.com/sfshirt
> >
> _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> >
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
>
> _______________________________________________________________________=
___
> Acabe com aquelas janelinhas que pulam na sua tela.
> AntiPop-up UOL - =C9 gr=E1tis!
> http://antipopup.uol.com.br/
>
>
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

|	Peter Wippich 			Voice: +49 30 46776411		|
|	G&W Instruments GmbH		fax:   +49 30 46776419		|
|	Gustav-Meyer-Allee 25, Geb. 12	Email: pewi@gw-instruments.de	|
|	D-13355 Berlin  / Germany					|




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
