Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fred Schaettgen <bluez-devel@schaettgen.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Bluetooth MIME types and URIs
References: <1120747365.18553.15.camel@pegasus> <200507081451.38781.bluez-devel@schaettgen.de> <1120833804.18553.117.camel@pegasus>
In-Reply-To: <1120833804.18553.117.camel@pegasus>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PHqzC42ygfYRJil"
Message-Id: <200507081754.55107.bluez-devel@schaettgen.de>
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
Date: Fri, 8 Jul 2005 17:54:54 +0200

--Boundary-00=_PHqzC42ygfYRJil
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday, 8. July 2005 16:43, Marcel Holtmann wrote:
=2E..
> > But I wonder if this isn=B4t actually an abuse of mimetypes. Aren=B4t
> > mimetypes supposed to declare the format of a file? Yet we are not
> > talking about file contents at all here. Instead we associate a mimetype
> > with a certain URL format.
>
> In general yes, but they always have been misused.



> > At the moment, an item with the mimetype =A8bluetooth/obex-push-profile=
=A8
> > can only live inside the sdp kioslave.
> > Maybe a more correct way would in fact be to have a helper application
> > associated with the type application/x-bt.service, which gets the
> > information what device to connect to not from the URL, but from the URL
> > contents. application/x-bt.service could simply be a file that contains
> > the whole service record as xml, similar to the service record files for
> > the metaserver. The applications would have to parse this xml file, whi=
ch
> > isn=B4t very lightweight, but it gives all available information and we
> > don=B4t have to worry how to squezze everything into an URL.
>
> I am not really happy with adding somekind of XML overhead.

But it=B4s the most natural format for a hierarchical data structure like t=
he=20
service records. The computational overhead would be neglectable and it onl=
y=20
has to be implemented in the service dispatcher, not in each application=20
started by it. We can put everything we know in the xml structure without=20
much effort. Extending the url format might become more troublesome at some=
=20
point.=20
We could also go without the service dispatcher and still use distinct=20
mimetypes for each service, but let the application read the needed=20
information from the data the url points to and not from the URL itself.
We didn=B4t have to standardize on a URL format then, but just on the mimet=
ypes=20
and the service description format, be it xml or anything else.=20
In KDE it would allow for a kfile plugin which displays additional properti=
es=20
of services in konqueror besides the name.=20
Or we could do both - putting just the most relevant information into the U=
RL=20
(bdaddr+channel) and the complete service record, device adress + name and=
=20
everything else we know about a service into the file contents as xml simil=
ar=20
to sdp registration files we use (see attachment).

=46red

=2D-=20
=46red Schaettgen
bluez-devel@schaettgen.de

--Boundary-00=_PHqzC42ygfYRJil
Content-Type: text/xml;
  charset="iso-8859-1";
  name="kbluetoothd_kbtobexsrv.sdp.xml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="kbluetoothd_kbtobexsrv.sdp.xml"

<sdprecord>
<attributes>

<!-- Service name -->
<attribute id='0x0100'>
<str>Obex Push Server</str>
</attribute>

<!-- Service description -->
<attribute id='0x0101'>
<str>KDE OBEX Object Push Service</str>
</attribute>

<!-- Supported formats list -->
<attribute id='0x0303'>
<seq>
<uint val='0xFF' size='8'/><!-- anything  -->
<uint val='0x01' size='8'/><!-- vCard 2.1 -->
<uint val='0x02' size='8'/><!-- vCard 3.0 -->
<uint val='0x03' size='8'/><!-- vCal  1.0 -->
<uint val='0x04' size='8'/><!-- iCal  2.0 -->
<uint val='0x05' size='8'/><!-- vNotes    -->
<uint val='0x06' size='8'/><!-- vMessage  -->
</seq>
</attribute>

<!-- Service class ID list -->
<attribute id='0x0001'>
<seq>
<uuid val='0x1105' size='16'/>
</seq>
</attribute>

<!-- Protocol descriptor list -->
<attribute id='0x0004'>
<seq>
<seq><uuid val='256' size='16'/></seq>
<seq><uuid val='3' size='16'/>
<uint valref='rfcommchannel' size='8'/></seq>
<seq><uuid val='0x0008' size='16'/></seq>
</seq>
</attribute>

<!-- Browse group list-->
<attribute id='0x0005'>
<seq>
<uuid val='0x1002' size='16'/>
</seq>
</attribute>

<!-- Bluetooth profile descriptor list -->
<attribute id='0x0009'>
<seq>
<seq><uuid val='0x1105' size='16'/>
<uint val='0x0100' size='16'/></seq>
</seq>
</attribute>

</attributes>
</sdprecord>

--Boundary-00=_PHqzC42ygfYRJil--


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
