Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Piconet Routing
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Mischke <survivor@uni-paderborn.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4174026A.1080209@uni-paderborn.de>
References: <4173F86A.3050801@uni-paderborn.de>
	 <1098120822.11765.5.camel@pegasus>  <4174026A.1080209@uni-paderborn.de>
Content-Type: text/plain
Message-Id: <1098142954.5415.7.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 19 Oct 2004 01:42:35 +0200

Hi Stefan,

> > > Since Bluetooth uses Time Division Duplex, a slave is not allowed to 
> > > talk to another slave in the same Piconet. The logical consequence must 
> > > be that the data is routed over the master. I've used l2test to check if 
> > > l2cap does this kind of routing automatically. It doesn't but rather 
> > > creates a new, direct acl link to the remote slave device (scatternet). 
> > > I don't know how it is with rfcomm, but I suppose it's the same. My 
> > > question: Is there any automatic Piconet Routing inside BlueZ or does 
> > > one have to implement it by oneself?
> > >     
> > you must do it by yourself, because even if the master manages to put
> > all devices into the same piconet the connections are point to point.
> > 
> >   
> TCP connections are also point to point, but since it's built on top
> of IP, it goes (transparently) over many routers. Before I tested it,
> I thought the link manager would take care of this. How does the
> communiction of many BT devices work in practice? Who manages this
> routing, since one device can only be point-to-point-connected to 2
> devices (an this doesn't work really smooth)? There must be one
> controlling instance. One cannot let the different applications handle
> this, can one?

this is true, but the problem is, that a slave does not know to which
other slaves a master is connected. There is no routing stuff like in IP
and you can't retrieve these information from the HCI layer.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
