Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Prepare patch bluez for the CoD in hci_conn
From: Chen Bin <binch@mobilesoft.com.cn>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1102324476.8510.85.camel@pegasus>
References: <1102340081.653.6.camel@debian>
	 <1102315236.8510.55.camel@pegasus>  <1102345868.2011.2.camel@debian>
	 <1102317505.8510.66.camel@pegasus>  <1102348405.3281.4.camel@debian>
	 <1102322516.8510.74.camel@pegasus>  <1102352748.1779.3.camel@debian>
	 <1102324476.8510.85.camel@pegasus>
Content-Type: text/plain; charset=gbk
Message-Id: <1102353672.2206.1.camel@debian>
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
Date: Tue, 07 Dec 2004 01:21:12 +0800

=D4=DA 2004-12-06=D2=BB=B5=C4 10:14 +0100=A3=ACMarcel Holtmann=D0=B4=B5=C0=
=A3=BA
> Hi Chen,
>=20
> > I see your patch that you patch the hci_acl_connect()=A3=ACbut why no=
t
> > hci_conn_add()?
> >=20
> > I feel the latter is more appropriate.
>=20
> no, it is not. The hci_conn_add is called at various times. It is calle=
d
> for incoming and outgoing connections. We don't need to do a lookup at
> the inquiry cache for an incoming connection, because we get the value
> within the connection request event. The hci_acl_connect() is used to
> create an outgoing connection and it already have to lookup the other
> parameters from the inquiry cache. Do see the point?
>=20

Ok, got it. Thanks.

> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users=
.
> Discover which products truly live up to the hype. Start reading now.=20
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
