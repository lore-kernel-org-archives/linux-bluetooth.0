Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Qihe Wang <qwang@ececs.uc.edu>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Information on Scatternet
In-Reply-To: <1107439743.11944.68.camel@pegasus>
Message-ID: <Pine.GSO.4.43.0502242320200.3601-100000@gatekeeper.ececs.uc.edu>
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
Date: Thu, 24 Feb 2005 23:31:07 -0500 (EST)

Hello,

I'm looking at this information too.  With 300 nodes, it almost impossible
to do manual set up.  I know there are several CSR engineers on this
mailing.  Would you like give us some information about how big a
scatternet can be built and what is the bridge scheduling algorithm?  Are
you have R&D interest in this kind of things?

Regards, Qihe

On Thu, 3 Feb 2005, Marcel Holtmann wrote:

> Hi Elisabetta,
>
> > I would like to know if it's possible to realize a BT scatternet made
> > by some hundreds (300 for example) of piconets. Each node of the
> > piconet (max 5) has to connect only with the master of the piconet
> > itself, and each piconet has to send and receive data, via BT, with a
> > PC that has to  collect and manage the data of all the piconets. The
> > distance between the majority of the piconets and the PC is greater
> > than the max possible for a BT class 1 device, so it's necessary that
> > the master of each piconet work as a gateway for the other piconets.
>
> this is possible, but you need at scatternet capable Bluetooth chip (for
> example a CSR BlueCore with HCI 16.4 firmware or newer). What you really
> need to make sure is that the roles are switched correctly. Remember
> that the device that initiates a connection is the master of a piconet
> in the first place.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
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
