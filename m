Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Linux@feline-soul.com
In-Reply-To: <200608311150.38005.Linux@feline-soul.com>
References: <e4f1f0110608230129y73240448ufc024c1c99810789@mail.gmail.com>
	<200608302048.42931.Linux@feline-soul.com>
	<1157022278.4026.118.camel@aeonflux.holtmann.net>
	<200608311150.38005.Linux@feline-soul.com>
Date: Fri, 01 Sep 2006 00:08:33 +0200
Message-Id: <1157062113.4026.145.camel@aeonflux.holtmann.net>
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

> Thank you. Here is the output from hcidump -X -V:
> 
> 11:46:21 root@linux:/home/bearcat# hcidump -X -V
> HCI sniffer - Bluetooth packet analyzer ver 1.31
> device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>     bdaddr 00:0D:44:4F:37:72 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Command Status (0x0f) plen 4
>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> > HCI Event: PIN Code Request (0x16) plen 6
>     bdaddr 00:0D:44:4F:37:72
> > HCI Event: Mode Change (0x14) plen 6
>     status 0x00 handle 41 mode 0x00 interval 0
>     Mode: Active
> > HCI Event: Mode Change (0x14) plen 6
>     status 0x00 handle 41 mode 0x02 interval 126
>     Mode: Sniff
> > HCI Event: Connect Complete (0x03) plen 11
>     status 0x22 handle 44 bdaddr 00:0D:44:4F:37:72 type ACL encrypt 0x00
>     Error: LMP Response Timeout
> < HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> > HCI Event: Command Complete (0x0e) plen 6
>     Read Voice Setting (0x03|0x0025) ncmd 1
>     status 0x00 voice setting 0x0060
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>     bdaddr 00:0D:44:4F:37:72 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Command Status (0x0f) plen 4
>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> > HCI Event: PIN Code Request (0x16) plen 6
>     bdaddr 00:0D:44:4F:37:72
> < HCI Command: Inquiry (0x01|0x0001) plen 5
>     lap 0x9e8b33 len 6 num 0
> > HCI Event: Command Status (0x0f) plen 4
>     Inquiry (0x01|0x0001) status 0x00 ncmd 1
> > HCI Event: Inquiry Result (0x02) plen 15
>     bdaddr 00:0D:44:4F:37:72 mode 1 clkoffset 0x50a7 class 0x200404
> > HCI Event: Inquiry Complete (0x01) plen 1
>     status 0x00
> > HCI Event: Connect Complete (0x03) plen 11
>     status 0x22 handle 45 bdaddr 00:0D:44:4F:37:72 type ACL encrypt 0x00
>     Error: LMP Response Timeout

this looks like you have the KDE Bluetooth thingy running and it
interferes when trying to connect. They always did this scanning thing
without actually checking if the HCI controller is in use. I would
advise you to not use KDE Bluetooth unless they switched to using the
new D-Bus driven API.

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
