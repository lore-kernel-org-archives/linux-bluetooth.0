Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluetooth MIME types and URIs
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <200507081754.55107.bluez-devel@schaettgen.de>
References: <1120747365.18553.15.camel@pegasus>
	 <200507081451.38781.bluez-devel@schaettgen.de>
	 <1120833804.18553.117.camel@pegasus>
	 <200507081754.55107.bluez-devel@schaettgen.de>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1120850233.7444.8.camel@notepaq>
Mime-Version: 1.0
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
Date: Fri, 08 Jul 2005 21:17:13 +0200

Hi Fred,

> > > At the moment, an item with the mimetype =A8bluetooth/obex-push-pro=
file=A8
> > > can only live inside the sdp kioslave.
> > > Maybe a more correct way would in fact be to have a helper applicat=
ion
> > > associated with the type application/x-bt.service, which gets the
> > > information what device to connect to not from the URL, but from th=
e URL
> > > contents. application/x-bt.service could simply be a file that cont=
ains
> > > the whole service record as xml, similar to the service record file=
s for
> > > the metaserver. The applications would have to parse this xml file,=
 which
> > > isn=B4t very lightweight, but it gives all available information an=
d we
> > > don=B4t have to worry how to squezze everything into an URL.
> >
> > I am not really happy with adding somekind of XML overhead.
>=20
> But it=B4s the most natural format for a hierarchical data structure li=
ke the=20
> service records. The computational overhead would be neglectable and it=
 only=20
> has to be implemented in the service dispatcher, not in each applicatio=
n=20
> started by it. We can put everything we know in the xml structure witho=
ut=20
> much effort. Extending the url format might become more troublesome at =
some=20
> point.=20
> We could also go without the service dispatcher and still use distinct=20
> mimetypes for each service, but let the application read the needed=20
> information from the data the url points to and not from the URL itself.
> We didn=B4t have to standardize on a URL format then, but just on the m=
imetypes=20
> and the service description format, be it xml or anything else.=20
> In KDE it would allow for a kfile plugin which displays additional prop=
erties=20
> of services in konqueror besides the name.=20
> Or we could do both - putting just the most relevant information into t=
he URL=20
> (bdaddr+channel) and the complete service record, device adress + name =
and=20
> everything else we know about a service into the file contents as xml s=
imilar=20
> to sdp registration files we use (see attachment).

actually right now, I don't tend in either direction.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
