Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] About new hardware testing
In-Reply-To: <1ffb4b070502200751191953c@mail.gmail.com>
Message-ID: <Pine.LNX.4.33.0502201659100.26897-100000@redbean.intranet.gw-instruments.de>
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
Date: Sun, 20 Feb 2005 17:04:17 +0100 (CET)


Hi Mike,

I remember we initialy had a problem to get the right default pass for
hcid.conf when cross compiling.

Try to start hcid with -f [config-file] to make sure it starts with the
right configuration file. Does "hciconfig hci0 up" work ??

I use

hciattach /dev/ttyS1 -s 115200 csr 921600 flow

to attach the bluetooth device (CSR with HCI connected to an ARM).

Hope this help,

Peter

On Sun, 20 Feb 2005, Mike Lee wrote:

> Dear Peter
>
>    Yes, i have done that.
>
> best regard
> Mike,Lee
>
>
> On Sun, 20 Feb 2005 16:39:49 +0100 (CET), Peter Wippich
> <pewi@gw-instruments.de> wrote:
> >
> > Hi Mike,
> >
> > have you started hcid ?? Or do  "hciconfig hci0 up".
> >
> > Ciao,
> >
> > Peter
> >
> >
> > On Sun, 20 Feb 2005, Mike Lee wrote:
> >
> > > Dear All
> > >     I am now testing new hardware in ARM9 platform with CSR bluetooth
> > > module. After i hciattach with 921600 baud rate, I can see the Build
> > > ID of CSR. But when i use hciconfig, i can not see any device.
> > >      Could anybody suggest me a way to find out the hardware error. Is
> > > there any debug version of bluez util?
> > >
> > > Thank a lot
> > > best regard
> > > --
> > > -------------------------------------------------------
> > > Mike Lee
> > >
> > >
> > > -------------------------------------------------------
> > > SF email is sponsored by - The IT Product Guide
> > > Read honest & candid reviews on hundreds of IT Products from real users.
> > > Discover which products truly live up to the hype. Start reading now.
> > > http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> > > _______________________________________________
> > > Bluez-devel mailing list
> > > Bluez-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> > >
> >
> > |       Peter Wippich                   Voice: +49 30 46776411          |
> > |       G&W Instruments GmbH            fax:   +49 30 46776419          |
> > |       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
> > |       D-13355 Berlin  / Germany                                       |
> >
> > -------------------------------------------------------
> > SF email is sponsored by - The IT Product Guide
> > Read honest & candid reviews on hundreds of IT Products from real users.
> > Discover which products truly live up to the hype. Start reading now.
> > http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
>
>
> --
> -------------------------------------------------------
> Mike Lee
>
>
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
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
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
