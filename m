Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Prepare patch bluez for the CoD in hci_conn
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1102352748.1779.3.camel@debian>
References: <1102340081.653.6.camel@debian>
	 <1102315236.8510.55.camel@pegasus>  <1102345868.2011.2.camel@debian>
	 <1102317505.8510.66.camel@pegasus>  <1102348405.3281.4.camel@debian>
	 <1102322516.8510.74.camel@pegasus>  <1102352748.1779.3.camel@debian>
Content-Type: text/plain; charset=Shift-JIS
Message-Id: <1102324476.8510.85.camel@pegasus>
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
Date: Mon, 06 Dec 2004 10:14:36 +0100

Hi Chen,

> I see your patch that you patch the hci_acl_connect()=81Cbut why not
> hci_conn_add()?
>=20
> I feel the latter is more appropriate.

no, it is not. The hci_conn_add is called at various times. It is called
for incoming and outgoing connections. We don't need to do a lookup at
the inquiry cache for an incoming connection, because we get the value
within the connection request event. The hci_acl_connect() is used to
create an outgoing connection and it already have to lookup the other
parameters from the inquiry cache. Do see the point?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
