Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Linux@feline-soul.com
In-Reply-To: <200608311829.31921.Linux@feline-soul.com>
References: <e4f1f0110608230129y73240448ufc024c1c99810789@mail.gmail.com>
	<200608311150.38005.Linux@feline-soul.com>
	<1157062113.4026.145.camel@aeonflux.holtmann.net>
	<200608311829.31921.Linux@feline-soul.com>
Date: Fri, 01 Sep 2006 13:04:45 +0200
Message-Id: <1157108685.4026.149.camel@aeonflux.holtmann.net>
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

> I killed kdebluetooth and made sure no traces of it were running. I get the 
> same errors.
> 
> Here is the hcidump -X -V with kdebluetooth off:
> 18:23:48 root@linux:/home/bearcat# hcidump -X -V
> HCI sniffer - Bluetooth packet analyzer ver 1.31
> device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>     bdaddr 00:0D:44:4F:37:72 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Command Status (0x0f) plen 4
>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> > HCI Event: Connect Complete (0x03) plen 11
>     status 0x04 handle 0 bdaddr 00:0D:44:4F:37:72 type ACL encrypt 0x00
>     Error: Page Timeout
> < HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> > HCI Event: Command Complete (0x0e) plen 6
>     Read Voice Setting (0x03|0x0025) ncmd 1
>     status 0x00 voice setting 0x0060
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>     bdaddr 00:0D:44:4F:37:72 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Command Status (0x0f) plen 4
>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> > HCI Event: Connect Complete (0x03) plen 11
>     status 0x04 handle 0 bdaddr 00:0D:44:4F:37:72 type ACL encrypt 0x00
>     Error: Page Timeout

both are a page timeout. Which means that the device is not on or not in
page scan mode. Please turn the device on and put it into pairing mode.

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
