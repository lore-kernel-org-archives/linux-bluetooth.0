Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <44DB1CEA.2070001@pracucci.com>
References: <44DA046D.7020600@pracucci.com>
	<1155160420.4492.6.camel@aeonflux.holtmann.net>
	<44DB1CEA.2070001@pracucci.com>
Date: Thu, 10 Aug 2006 18:22:40 +0200
Message-Id: <1155226960.4492.28.camel@aeonflux.holtmann.net>
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

> I have dump it (hcidump -i hci1 -t -X -V). Here I publish only
> interesting commands and events:
> 
> 2006-08-10 11:10:51.168745 < HCI Command: Create Connection
> (0x01|0x0005) plen 13
> bdaddr 00:07:80:81:03:E0 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
> Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> 2006-08-10 11:10:51.171492 > HCI Event: Command Status (0x0f) plen 4
> Create Connection (0x01|0x0005) status 0x00 ncmd 1
> 
> 2006-08-10 11:10:54.773623 > HCI Event: Role Change (0x12) plen 8
> status 0x00 bdaddr 7B:00:00:01:C3:E0 role 0x00
> Role: Master
> 2006-08-10 11:10:54.921650 > HCI Event: Connect Complete (0x03) plen 11
> status 0x21 handle 1 bdaddr 7B:00:00:01:C3:E0 type ACL encrypt 0x00
> Error: Role Change Not Allowed
> 
> No other related event has been received, but the connect() system call
> returns after 40 seconds (2006-08-10 11:11:31). Have you any idea and/or
> suggestion?
> 
> P.S. bdaddr 7B:00:00:01:C3:E0 is wrong: is it a little bug of hcidump?

I don't know of any bug in hcidump. What version are you using. If the
address is displayed wrong then actually the wrong address might be
used.

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
