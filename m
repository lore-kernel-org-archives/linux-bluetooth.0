Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <44DB7700.2040501@pracucci.com>
References: <44DA046D.7020600@pracucci.com>
	<1155160420.4492.6.camel@aeonflux.holtmann.net>
	<44DB1CEA.2070001@pracucci.com>
	<1155226960.4492.28.camel@aeonflux.holtmann.net>
	<44DB7700.2040501@pracucci.com>
Date: Thu, 10 Aug 2006 21:04:34 +0200
Message-Id: <1155236674.4492.44.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] connect() and L2CAP_CONN_TIMEOUT
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Marco,

> >> 2006-08-10 11:10:54.773623 > HCI Event: Role Change (0x12) plen 8
> >> status 0x00 bdaddr 7B:00:00:01:C3:E0 role 0x00
> >> Role: Master
> >> 2006-08-10 11:10:54.921650 > HCI Event: Connect Complete (0x03) plen 11
> >> status 0x21 handle 1 bdaddr 7B:00:00:01:C3:E0 type ACL encrypt 0x00
> >> Error: Role Change Not Allowed
> >>
> >> P.S. bdaddr 7B:00:00:01:C3:E0 is wrong: is it a little bug of hcidump?    
> >
> > I don't know of any bug in hcidump. What version are you using. If the
> > address is displayed wrong then actually the wrong address might be
> > used.
> 
> hcidump version: 1.30
> Bluez libs: 2.25
> 
> If it's not an hcidump bug, it could be a protocol stack. Since the
> remote device implements a closed/proprietary Bluetooth stack (from
> BlueGiga Technologies), it could be a bug of it.
> 
> What do you think? Have you any other suggestion?

it must be actually a bug on our side. I actually trust hcidump to do
the right thing and this means that somehow the wrong address gets used.
Please include some more information about your system and kernel
version you use. You should also create a binary dump in BTSnoop format.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
