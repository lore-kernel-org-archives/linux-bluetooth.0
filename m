Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Apple BT Keyboard and Ubuntu Linux
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <42655077.7080609@metalan.net>
References: <42649E3C.1080608@metalan.net>
	 <1113907413.16233.167.camel@pegasus>  <42654471.7090804@metalan.net>
	 <1113934141.2469.53.camel@pegasus>  <42655077.7080609@metalan.net>
Content-Type: text/plain
Message-Id: <1113936350.2469.56.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 19 Apr 2005 20:45:50 +0200

Hi Andre,

> Understood, I made sure I grabbed the latest libs and utils as well.
> hcidump:
> 
> lampshade:/# hcidump -X -V
> HCI sniffer - Bluetooth packet analyzer ver 1.19
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Write Authentication Enable (0x03|0x0020) plen 1
>   0000: 01                                                .
> > HCI Event: Command Complete (0x0e) plen 4
>     Write Authentication Enable (0x03|0x0020) ncmd 1
>     0000: 00                                                .
> < HCI Command: Inquiry (0x01|0x0001) plen 5
>     lap 0x9e8b33 len 8 num 0
> > HCI Event: Command Status (0x0f) plen 4
>     Inquiry (0x01|0x0001) status 0x00 ncmd 1
> > HCI Event: Inquiry Result (0x02) plen 15
>     bdaddr 00:0A:95:3E:CC:74 mode 1 clkoffset 0x705c class 0x002540
> > HCI Event: Inquiry Complete (0x01) plen 1
>     status 0x00
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>     bdaddr 00:0A:95:3E:CC:74 ptype 0xcc18 rswitch 0x01 clkoffset
> 0x705c (valid)
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Command Status (0x0f) plen 4
>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> > HCI Event: Link Key Request (0x17) plen 6
>     bdaddr 00:0A:95:3E:CC:74
> > HCI Event: PIN Code Request (0x16) plen 6
>     bdaddr 00:0A:95:3E:CC:74
> > HCI Event: Connect Complete (0x03) plen 11
>     status 0x10 handle 41 bdaddr 00:0A:95:3E:CC:74 type ACL encrypt
> 0x00
>     Error: Connection Accept Timeout Exceeded
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>     bdaddr 00:0A:95:3E:CC:74 ptype 0xcc18 rswitch 0x01 clkoffset
> 0x705c (valid)
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Command Status (0x0f) plen 4
>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> > HCI Event: Link Key Request (0x17) plen 6
>     bdaddr 00:0A:95:3E:CC:74
> > HCI Event: PIN Code Request (0x16) plen 6
>     bdaddr 00:0A:95:3E:CC:74
> > HCI Event: Connect Complete (0x03) plen 11
>     status 0x10 handle 42 bdaddr 00:0A:95:3E:CC:74 type ACL encrypt
> 0x00
>     Error: Connection Accept Timeout Exceeded

check if hcid is running, because nobody is answering the pin code and
link key requests.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
