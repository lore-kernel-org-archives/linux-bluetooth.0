Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Qihe Wang <qwang@ececs.uc.edu>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Information on Scatternet
In-Reply-To: <Pine.LNX.4.33.0502251621120.12798-100000@redbean.intranet.gw-instruments.de>
Message-ID: <Pine.GSO.4.43.0502251120260.19812-100000@gatekeeper.ececs.uc.edu>
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
Date: Fri, 25 Feb 2005 11:37:26 -0500 (EST)

Peter,

Thanks.  I have been working on the scatternet thing for a whole and I
built a quite complex simulator for it.  I'm doing a ph.d thesis on it,
too.  I don't believe the current specification is sufficient to support
scatternets.  For one thing bridging handling need to access timing
critical information which is not exported to HCI, such as instructing a
bridge to switch to another master exactly at a certain slot.  For another
thing, connection setup takes too long, which makes a scatternet almost
impossible to maintain.  I think lower layers (LMP and Baseband) changes
are needed to solve these issues.  I'd like to know if there is any
industry interest in building a large scatternet.

Regards, Qihe

On Fri, 25 Feb 2005, Peter Wippich wrote:

>
> Hello Qihe,
>
> from the Bluetooth Specification 1.2:
>
> "A Bluetooth device that is a member of two or more piconets is said to be
> involved in a scatternet. Involvement in a scatternet does not necessarily
> imply any network routing capability or function in the Bluetooth device.
> The Bluetooth core protocols do not, and are not intended to offer such
> functionality, which is the responsibility of higher level protocols and
> is outside the scope of the Bluetooth core specification."
>
> So, in fact, if you want to implement a scatternet with bridging it has to
> be done on the profile layer. Maybe the PAN profile with bridging is a
> good point to start.
>
> Good luck,
>
> Peter
>
> On Thu, 24 Feb 2005, Qihe Wang wrote:
>
> > Hello,
> >
> > I'm looking at this information too.  With 300 nodes, it almost impossible
> > to do manual set up.  I know there are several CSR engineers on this
> > mailing.  Would you like give us some information about how big a
> > scatternet can be built and what is the bridge scheduling algorithm?  Are
> > you have R&D interest in this kind of things?
> >
> > Regards, Qihe
> >
> > On Thu, 3 Feb 2005, Marcel Holtmann wrote:
> >
> > > Hi Elisabetta,
> > >
> > > > I would like to know if it's possible to realize a BT scatternet made
> > > > by some hundreds (300 for example) of piconets. Each node of the
> > > > piconet (max 5) has to connect only with the master of the piconet
> > > > itself, and each piconet has to send and receive data, via BT, with a
> > > > PC that has to  collect and manage the data of all the piconets. The
> > > > distance between the majority of the piconets and the PC is greater
> > > > than the max possible for a BT class 1 device, so it's necessary that
> > > > the master of each piconet work as a gateway for the other piconets.
> > >
> > > this is possible, but you need at scatternet capable Bluetooth chip (for
> > > example a CSR BlueCore with HCI 16.4 firmware or newer). What you really
> > > need to make sure is that the roles are switched correctly. Remember
> > > that the device that initiates a connection is the master of a piconet
> > > in the first place.
> > >
> > > Regards
> > >
> > > Marcel
> > >
> > >
> > >
> > >
> > > -------------------------------------------------------
> > > This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> > > Tool for open source databases. Create drag-&-drop reports. Save time
> > > by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> > > Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> > > _______________________________________________
> > > Bluez-devel mailing list
> > > Bluez-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> > >
> >
> >
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
> |	Peter Wippich 			Voice: +49 30 46776411		|
> |	G&W Instruments GmbH		fax:   +49 30 46776419		|
> |	Gustav-Meyer-Allee 25, Geb. 12	Email: pewi@gw-instruments.de	|
> |	D-13355 Berlin  / Germany					|
>
>
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




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
