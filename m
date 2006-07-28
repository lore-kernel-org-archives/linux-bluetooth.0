Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <44C697FF.3040702@gmail.com>
References: <44C697FF.3040702@gmail.com>
Date: Fri, 28 Jul 2006 03:55:00 +0200
Message-Id: <1154051700.7650.18.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Can't read local name on hci0: Connection
	timed	out (110)
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

> OK.. so I built from source 3.1 source last night and everything was 
> going well.
> 
> Today I come to find this pesky little error:
>     % hciconfig -a
>         ......
>        before REOBOOT
>        Can't read local name on hci0: Out of available memory space (or 
> something close to that)
>        after REBOOT:
>        Can't read local name on hci0: Connection timed out (110)
> 
>     ERROR ON CONSOLE:
>        hci_cmd_task: hci0 command tx timeout
> 
>     RESULTS OF hcidump -X -V:
>         HCI sniffer - Bluetooth packet analyzer ver 1.31
>         device: hci0 snap_len: 1028 filter: 0xffffffff
>         < HCI Command: Read Local Name (0x03|0x0014) plen 0
> 
> 
> So I unplugged/replugged the USB  dongle
> 
>    usb.c: USB disconnect on device 00:0f.4-1 address 2
>    hub.c: new USB device 00:0f.4-1, assigned address 3
> 
> and NOW everything is working fine again.
> 
> Can anyone shed any light on this?

looks like a strange and broken adapter (what was "hciconfig -a" saying
again) or simply a bad day.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
