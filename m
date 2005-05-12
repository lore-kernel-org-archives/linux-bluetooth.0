Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] DBUS service support - Initial library
In-Reply-To: <e1effdeb0505120545500a13c9@mail.gmail.com>
Message-ID: <Pine.LNX.4.33.0505121822250.3523-100000@redbean.intranet.gw-instruments.de>
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
Date: Thu, 12 May 2005 18:23:19 +0200 (CEST)


Thank you Claudio !

May be this will be interesting for a project we are currently working on.
I'll have a look at it.

Ciao,
Peter


On Thu, 12 May 2005, Claudio Takahasi wrote:

> Hi Peter,
>
> You can find more information on the references below:
>
> http://www.freedesktop.org/Software/dbus
> http://www-106.ibm.com/developerworks/linux/library/l-dbus.html
>
>
> Basically, DBUS is system for interprocess communication.
>
> Where/Why PAND DBUS service can be usefull:
> - pand required root permission
> - user applications are not allowed to establish connection or control
>  the BT device/connections
> - For embedded devices(cell phones, PDAs,..), applications like
> gamming, UPnP, etc.
> want to control BT connections, search services, ... and there isn't
> API for address this.
>
> Obviously, there is a hard work to do. Bridge creation/control, IP assi=
gnment,
> service name resolution have to be improved too in order to provide sea=
mless
> connections.
>
> Regards,
> Claudio.
>
>
>
> On 5/12/05, Peter Wippich <pewi@gw-instruments.de> wrote:
> >
> > Hi all,
> >
> > sorry for asking a possible dump question, but:
> > can anybody point me to a source what this D-BUS stuff is ???
> > Think I missed something.
> >
> > Thanks a lot,
> >
> > Peter
> >
> >
> > |       Peter Wippich                   Voice: +49 30 46776411       =
   |
> > |       G&W Instruments GmbH            fax:   +49 30 46776419       =
   |
> > |       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de=
   |
> > |       D-13355 Berlin  / Germany                                    =
   |
> >
> >
> > -------------------------------------------------------
> > This SF.Net email is sponsored by Oracle Space Sweepstakes
> > Want to be the first software developer in space?
> > Enter now for the Oracle Space Sweepstakes!
> > http://ads.osdn.com/?ad_id=3D7393&alloc_id=3D16281&op=3Dclick
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_ids93&alloc_id=16281&op=CCk
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
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
