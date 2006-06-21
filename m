Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060621050238.39581.qmail@web15809.mail.cnb.yahoo.com>
References: <20060621050238.39581.qmail@web15809.mail.cnb.yahoo.com>
Date: Wed, 21 Jun 2006 09:10:57 +0200
Message-Id: <1150873857.3950.7.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel]
	=?utf-8?b?UkXvvJogUkU6IEZXRO+8miBSZTogUmU6UmVxdWVz?=
	=?utf-8?q?t_with_RSSI?=
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

Hi,

>  I want to get RSSI value when inquiring, and my dongole support the
> feature:
> mylinux:/home/lucharse# hciconfig hci0 features
> hci0:   Type: USB
>         BD Address: 00:11:67:19:3D:EC ACL MTU: 678:8 SCO MTU: 48:10
>         Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
>                 <3-slot packets> <5-slot packets> <encryption> <slot
> offset>
>                 <timing accuracy> <role switch> <sniff mode> <RSSI>
>                 <channel quality> <SCO link> <HV2 packets> <HV3
> packets>
>                 <u-law log> <A-law log> <CVSD> <power control>
>                 <transparent SCO> <broadcast encrypt> <enhanced iscan>
>                 <interlaced iscan> <interlaced pscan> <inquiry with
> RSSI>
>                 <AFH cap. slave> <AFH cap. master> <AFH class. master>
>  
> I set the inquiry mode to 1 which is inquiry with RSSI:
>  
> mylinux:/home/lucharse# hciconfig hci0 inqmode 1
> mylinux:/home/lucharse# hciconfig hci0 inqmode
> hci0:   Type: USB
>         BD Address: 00:11:67:19:3D:EC ACL MTU: 678:8 SCO MTU: 48:10
>         Inquiry mode: Inquiry with RSSI
> 
> But when I use the sample code from from Scott W
> Gifford(http://sourceforge.net/mailarchive/message.php?msg_id=10195457) which is claimed to inquiry with RSSI, the output shows that the inquiry result without RSSI value. and the hcidump(-X -V) show the event type is EVT_INQUIRY_RESULT.
>  
> mylinux:/home/lucharse/testcase# ./a.out
> activate_rssi: err=0
> begin_inquiry: starting
> Polling...
> Got event!  Type is 2
> inquiry_result: num 1
>  00:0F:B3:9B:04:D3:    ?
> Polling...
> Got event!  Type is 2
> inquiry_result: num 1
>  00:14:A4:D7:52:48:    ?
> Polling...
> Got event!  Type is 2
> inquiry_result: num 1
>  00:14:A4:D7:52:91:    ?
> Polling...
> Got event!  Type is 2
> inquiry_result: num 1
>  00:20:E0:7A:F4:E6:    ?
> Polling...
> Polling...
> Program finished.
> cancel_inquiry: err=0
> 
> while using hcidump -X -V:
>  
> mylinux:/home/lucharse/# hcidump -X -V
> HCI sniffer - Bluetooth packet analyzer ver 1.31
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1
>     mode 1
> > HCI Event: Command Complete (0x0e) plen 4
>     Write Inquiry Mode (0x03|0x0045) ncmd 1
>     status 0x00
> < HCI Command: Inquiry (0x01|0x0001) plen 5
>     lap 0x9e8b33 len 48 num 0
> > HCI Event: Command Status (0x0f) plen 4
>     Inquiry (0x01|0x0001) status 0x00 ncmd 1
> > HCI Event: Inquiry Result (0x02) plen 16
>     bdaddr 00:0F:B3:9B:04:D3 mode 1 clkoffset 0x10e4 class 0x020104
> > HCI Event: Inquiry Result (0x02) plen 16
>     bdaddr 00:14:A4:D7:52:48 mode 1 clkoffset 0x7c5a class 0x72010c
> > HCI Event: Inquiry Result (0x02) plen 16
>     bdaddr 00:14:A4:D7:52:91 mode 1 clkoffset 0x4c9b class 0x72010c
> > HCI Event: Inquiry Result (0x02) plen 16
>     bdaddr 00:20:E0:7A:F4:E6 mode 1 clkoffset 0x6ec5 class 0x00010c
> < HCI Command: Inquiry Cancel (0x01|0x0002) plen 0
> > HCI Event: Command Complete (0x0e) plen 4
>     Inquiry Cancel (0x01|0x0002) ncmd 1
>     status 0x00
> 
> in your last mail, you ask me to to use hcidump(-X -V), but I can't
> see the RSSI value. 
>  
> The sample code I used uses the HCI raw socket, and I review the DBus
> API(bluez-utils-3.1), I don't know which API can give me the RSSI
> wheng inquirying.
>  
> How do you think about it?

this is strange. If "hciconfig hci0 inqmode" tells you that you use
Inquiry with RSSI then you should get the Inquiry with RSSI Results.
What hardware is this (hciconfig hci0 version).

Regards

Marcel

> 



_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
