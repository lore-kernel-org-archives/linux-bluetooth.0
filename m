Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: Michael B Allen <mba2000@ioplex.com>
Cc: <bluez-devel@lists.sourceforge.net>, <pewi@gw-instruments.de>
Subject: Re: [Bluez-devel] Waking up a machine with bluetooth signal?
In-Reply-To: <20050227125748.4fc29727.mba2000@ioplex.com>
Message-ID: <Pine.LNX.4.33.0502281012130.23677-100000@redbean.intranet.gw-instruments.de>
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
Date: Mon, 28 Feb 2005 10:16:04 +0100 (CET)


Hi Mike,

yes, about the implementation on the Mac. Usually internal BT Adapters are
connected through an internal USB port. However, a normal USB port doesn't
have the capability to wakeup the machine. Some machines implement extra
signals for this purpose, but I don't know if it is done in the  Mac . So
ask your favorite Apple engineer...

Ciao,

Peter


On Sun, 27 Feb 2005, Michael B Allen wrote:

> On Sun, 27 Feb 2005 17:13:36 +0100 (CET)
> Peter Wippich <pewi@gw-instruments.de> wrote:
>
> > better ask the Apple developers if this is possible. It is not a matter of
> > the Bluetooth stack but of the hardware and driver implementation.
>
> About the implementation on the Mac? The machine from which I would
> be sending this "wakeup" signal is Linux 2.4 on an IBM T30 laptop w/
> builtin BT. I bought a logitect MX900 mouse for the Mac and it worked
> without installing any extra drivers or anything so there must be some
> level of standard communication. No?
>
> Mike
>
> > On Fri, 25 Feb 2005, Michael B Allen wrote:
> >
> > > I just bought a mac mini w/ a bluetooth keyboard. I'd like to be able to
> > > ssh into it from my laptop but when it's in sleep mode it doesn't
> > > respond over the network. I can't use wake on lan because it's a
> > > wireless connection not ethernet. I'm all the way across the other side
> > > of the room and I'm very very lazy so I would like to use the bluetooth
> > > capability builtin to my Thinkpad T30 to try to wake up the mac mini
> > > from across the room. Is this possible?
>
> --
> IRC - where men are men, women are men, and the boys are FBI agents.
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
