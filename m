Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: patbert@patbert.com
Subject: Re: [Bluez-users] Apple bluetooth keyboard fun...
References: <4115A5E3.8000107@patbert.com>
In-Reply-To: <4115A5E3.8000107@patbert.com>
Cc: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408081121.24065.cijoml@volny.cz>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 8 Aug 2004 11:21:24 +0200

Dne ne 8. srpna 2004 06:02 Patrick napsal(a):
> I have had my apple bt keyboard working in linux for some time on my old
> pc. I now have a new pc and I can't get the damn thing going...
>
> I am using the same bluetooth adaptor from the old pc and as far as I
> can tell the same kernel config (as relates to bluetooth) as the old pc.
> This is with bluez-libs and utils 2.7.
>
> Reading through the archives I saw some mention of hcidump but I don't
> seem to have that.
>
> hcitool scan
> Scanning ...
>          00:0A:95:3A:63:E4       Apple Wireless Keyboard
>
> hcitool inq
> Inquiring ...
>          00:0A:95:3A:63:E4       clock offset: 0x3a7f    class: 0x002540
>
> hcitool info 00:0A:95:3A:63:E4
> Requesting information ...
>          BD Address:  00:0A:95:3A:63:E4
>          Device Name: Apple Wireless Keyboard
>          LMP Version: 1.1 (0x1) LMP Subversion: 0x5b00
>          Manufacturer: Broadcom Corporation (15)
>          Features: 0xbc 0x02 0x04 0x00 0x08 0x00 0x00 0x00
>                  <encryption> <slot offset> <timing accuracy> <role switch>
>                  <sniff mode> <RSSI> <power control> <AFH cap. slave>
>
>
>
> I have hidd --server in my startup scripts...
>
> hidd --show
> 00:0A:95:3A:63:E4 HID Boot Device [05ac:0208] connected
>
> Here is my bluetooth kernel config. As far as I know all I need is
> RFCOMM and HIDP support but since I was having trouble I figured what
> the hell and turned on everything. What can I safely turn off down there?
>
>
> Linux Kernel v2.6.8-rc2 Configuration
>
> --- Bluetooth subsystem support
> <*>   L2CAP protocol support
> <*>   SCO links support
> <*>   RFCOMM protocol support
> [*]     RFCOMM TTY support
> <*>   BNEP protocol support
> [*]     Multicast filter support
> [*]     Protocol filter support
> <*>   HIDP protocol support
>
> <*> HCI USB driver
> [ ]   SCO (voice) support
> <*> HCI UART driver
> [*]   UART (H4) protocol support
> [*]   BCSP protocol support
> [ ]     Transmit CRC with every BCSP packet
> < > HCI BCM203x USB driver
> < > HCI BlueFRITZ! USB driver
> <*> HCI VHCI (Virtual HCI device) driver

here use modules!

>
> My hcid.conf file...
>
> # HCI daemon configuration file.
> # $Id: hcid.conf,v 1.4 2004/04/29 20:14:21 holtmann Exp $
>
> options {
>          autoinit yes;
>          security user;
auto
>          pairing multi;
>          pin_helper /usr/bin/bluepin;
> }
>
> device {
>          name "BlueZ (%d)";
>          class 0x100;
>          iscan enable; pscan enable;
>          lm accept;
lm accept,master;
>          lp rswitch,hold,sniff,park;
>          auth enable;
disable
>          encrypt enable;
disable
> }
>
> bluepin is just the basic echo "PIN:0000" or whatever...
>
> What am I missing here? I am completely stumped. Thank you for any help!
>
> Patrick
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by OSTG. Have you noticed the changes on
> Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
> one more big change to announce. We are now OSTG- Open Source Technology
> Group. Come see the changes on the new OSTG site. www.ostg.com
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
