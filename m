Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] scanning possible, but no l2ping?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41FB0236.3030600@coriand.com>
References: <41FB0236.3030600@coriand.com>
Content-Type: text/plain
Message-Id: <1106969620.10580.23.camel@pegasus>
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
Date: Sat, 29 Jan 2005 04:33:40 +0100

Hi Franz,

> My problem with my two bluetooth adapter is, it's possible to scan the
> area und I get the right result, but it isn't possible to execute l2ping?
> I've a desktop computer and my crappy linux watch ... only with the
> desktop i've hcidump yet.
> I hope it is something with the config wrong?!
> 
> Franz
> 
> DESKTOP:
> ========
> 
> [root@dervish root]# hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:0F:3D:0B:EE:6C ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN AUTH ENCRYPT
>         RX bytes:1004 acl:0 sco:0 events:31 errors:0
>         TX bytes:379 acl:0 sco:0 commands:21 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: HOLD SNIFF PARK
>         Link mode: ACCEPT MASTER
>         Name: 'dervish-0'
>         Class: 0x120104
>         Service Classes: Networking, Object Transfer
>         Device Class: Computer, Desktop workstation
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver:
> 0x20d
>         Manufacturer: Cambridge Silicon Radio (10)
> 
> [root@dervish root]# hcitool scan
> Scanning ...
>         00:60:57:01:10:AE       WatchPad_15
> 
> [root@dervish root]# l2ping 00:60:57:01:10:AE
> Can't connect.: Connection timed out
> 
> hcidump (desktop) during  try to execute l2ping from desktop to watch:
> ------------------------------------------------------------------------
> [root@dervish sbin]# ./hcidump
> HCIDump - HCI packet analyzer ver 1.5
> device: hci0 snap_len: 1028 filter: 0xffffffff
> 
> 
> < HCI Command: Create Connection(0x01|0x0005) plen 13
>  > HCI Event: Command Status(0x0f) plen 4
>  > HCI Event: Link Key Request(0x17) plen 6
>  > HCI Event: Connect Complete(0x03) plen 11

you set your desktop device into security mode 3. Is this what you
really want?

It seems that hcid is not running, start it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
