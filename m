Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] PAN connection: palmtop -> linux -> internet
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <loom.20041216T200707-397@post.gmane.org>
References: <loom.20041216T200707-397@post.gmane.org>
Content-Type: text/plain
Message-Id: <1103227435.6325.17.camel@notepaq>
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
Date: Thu, 16 Dec 2004 21:03:55 +0100

Hi Grzegorz,

> I have searched may post but I couldnt why my connection is not working.
> I had tryed many configurations like on this sites:
> http://bluez.sourceforge.net/contrib/HOWTO-PAN
> http://fedoranews.org/contributors/muhammad_al_ismail/bluetooth/
> 
> My hardware:
> 
> Linux kernel 2.4.27
> Bluetooth dongle D-Link DBT-120
> Palmtop Siemens LOOX 600 with Windows Mobile 20003
> 
> hciconfig -a gives this:
> 
> hci0:   
> 
> Type: USB
> BD Address: 00:0D:88:AC:CB:6A ACL MTU: 192:8  SCO MTU: 64:8
> UP RUNNING PSCAN ISCAN
> RX bytes:99 acl:0 sco:0 events:13 errors:0
> TX bytes:296 acl:0 sco:0 commands:12 errors:0
> Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
> Packet type: DM1 DH1 HV1
> Link policy: HOLD SNIFF PARK
> Link mode: MASTER
> Name: 'Linux'
> Class: 0x000100
> Service Classes: Unspecified
> Device Class: Computer, Uncategorized
> HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
> Manufacturer: Cambridge Silicon Radio (10)

enable the rswitch and use accept,slave as link mode.

> hcitool scan easy finds my palmtop Siemens LOOX 600:
> Scanning ...
>         00:E0:00:C8:1C:65       LOOX
> 
> ... and now I want to have internet access on my palmtop. I can
> connect to Linux using palmtop.
> 
> When I reboot Linux I'm writing this to make BT connection and
> services working:
> 
> modprobe hci_usb
> hciconfig hci0 up
> hcid
> sdpd
> pand -s -M --role=NAP
> 
> I configured everything on palmtop and when I try to connect to
> Linux using PAN in /var/messages is showing:
> 
> Dec 16 20:59:12 router_nnd hcid[11147]:
> link_key_request (sba=00:0D:88:AC:CB:6A,dba=00:E0:00:C8:1C:65)
> 
> Dec 16 20:59:12 router_nnd pand[6330]:
> New connection from 00:E0:00:C8:1C:65 bnep0
> 
> .. and now is the problem. After few seconds after connection a
> window on palmtop is showing with this message:
> 
> Unable to obtain a server assigned IP adress. Try again later or
> enter an IP address in Network settings.
> 
> So .. I tryed some configurations in dhcp but they didnt worked.
> Can someone help me? I think that I'm near of making it working
> but I tryed almost every possibility I know.

It seems that you need to run a DHCP server and maybe you need to create
a bridge for all incoming PAN connections.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
