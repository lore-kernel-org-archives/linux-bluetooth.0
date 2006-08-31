Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Linux@feline-soul.com
In-Reply-To: <200608302048.42931.Linux@feline-soul.com>
References: <e4f1f0110608230129y73240448ufc024c1c99810789@mail.gmail.com>
	<200608291908.52176.Linux@feline-soul.com>
	<1156931555.4026.79.camel@aeonflux.holtmann.net>
	<200608302048.42931.Linux@feline-soul.com>
Date: Thu, 31 Aug 2006 13:04:38 +0200
Message-Id: <1157022278.4026.118.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] How do I reset a pairing?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Bearcat,

> Alright, we're getting there. I added the line to the pincodes file and now 
> the pin is accepted.
> 
> However, doing an btsco 00:0D:44:4F:37:72 i get
> 
> Error: Failed to connect to SDP server: Function not implemented
> Assuming channel 2
> 
> Can't connect RFCOMM channel: Resource temporarily unavailable
> 
> hcidump gives me:
> 
> HCI sniffer - Bluetooth packet analyzer ver 1.31
> device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
> < HCI Command: Create Connection (0x01|0x0005) plen 13
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: PIN Code Request (0x16) plen 6
> > HCI Event: Mode Change (0x14) plen 6
> > HCI Event: Mode Change (0x14) plen 6
> > HCI Event: Connect Complete (0x03) plen 11
> < HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> > HCI Event: Command Complete (0x0e) plen 6
> < HCI Command: Create Connection (0x01|0x0005) plen 13
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: PIN Code Request (0x16) plen 6
> > HCI Event: Connect Complete (0x03) plen 11

run "hcidump -X -V". This output is not really helpful.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
