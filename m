Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Testing l2cap using l2test for
	authentication/encryption
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5987A7CB1694D811A04D0002B32C289601BF3C77@il93exb05.corp.mot.com>
References: 
	 <5987A7CB1694D811A04D0002B32C289601BF3C77@il93exb05.corp.mot.com>
Content-Type: text/plain
Message-Id: <1100813200.7164.83.camel@pegasus>
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
Date: Thu, 18 Nov 2004 22:26:40 +0100

Hi Abhi,

> I am trying to use l2test program to test authentication/encryption using 
> two bluetooth devices running bluez. However, my client keeps on timing out with the message "l2test[612]: Can't connect. Connection refused(111)"
> l2test works fine without authentication/encryption requested.
> 
> I am running 2.4.20-8 kernel with the mh12 patch. 
> 
> I am running hcid and hcid.conf looks like this on both ends. 
> except for the class of device on the server is set to 0xffff.
> options {
>         autoinit yes;
>         security auto;
>         pairing multi;
>         pin_helper /etc/bluetooth/outgoingpin.sh
> }
> 
> # Default settings for HCI devices
> device {
>         name "BlueZ (%d)";
>         class 0x100;
>         iscan enable; pscan enable;
>         lm accept;
> 	  lp rswitch,hold,sniff,park;
>         auth enable;
>         encrypt enable;
> }
> 

you know that this is security mode 3, do you?

> outgoingpin.sh 
> #!/bin/sh
> # Outgoing pin
> echo "PIN:00000"
> 
> /etc/bluetooth/pin on both sides is set to 00000.
> 
> hcidump: CLIENT
> client# ./l2test_client -s -b 10 -N 2 xx:xx:xx:xx:xx:xx
> HCIDump - HCI packet analyzer ver 1.11
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Create Connection (0x01|0x0005) plen 13
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: Connect Complete (0x03) plen 11
> < ACL data: handle 0x0006 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 10 scid 0x0040
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> > HCI Event: Command Complete (0x0e) plen 6
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > HCI Event: Max Slots Change (0x1b) plen 3
> > ACL data: handle 0x0006 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 1
> > ACL data: handle 0x0006 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 3 status 0
> < HCI Command: Disconnect (0x01|0x0006) plen 3
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: Disconn Complete (0x05) plen 4
> 
> hcidump: SERVER
> server# ./l2test_server -r -A
> HCIDump - HCI packet analyzer ver 1.5
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > HCI Event: Connect Request(0x04) plen 10
> < HCI Command: Accept Connection Request(0x01|0x0009) plen 7
> > HCI Event: Command Status(0x0f) plen 4
> > HCI Event: Connect Complete(0x03) plen 11
> < HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
> > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
> > HCI Event: Command Status(0x0f) plen 4
> > HCI Event: Connection Packet Type Changed(0x1d) plen 5
> > ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 10 scid 0x0040
> < ACL data: handle 0x0029 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 1
> < HCI Command: Authentication Requested(0x01|0x0011) plen 2
> > HCI Event: Command Status(0x0f) plen 4
> > HCI Event: Number of Completed Packets(0x13) plen 5
> > HCI Event: Max Slots Change(0x1b) plen 3
> > HCI Event: Link Key Request(0x17) plen 6
> > HCI Event: Command Status(0x0f) plen 4
> > HCI Event: Auth Complete(0x06) plen 3
> < ACL data: handle 0x0029 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 3 status 0
> > HCI Event: Number of Completed Packets(0x13) plen 5
> > HCI Event: Disconn Complete(0x05) plen 4

Use "hcidump -x" to see the result code of the HCI events and check if
hcid is running.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
