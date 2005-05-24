Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Early failures with Treo 650
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <4292938B.2090000@gmail.com>
References: <428EDFCA.5070702@gmail.com> <1116842776.30044.33.camel@pegasus>
	 <4292938B.2090000@gmail.com>
Content-Type: text/plain
Message-Id: <1116924491.30044.131.camel@pegasus>
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
Date: Tue, 24 May 2005 10:48:10 +0200

Hi David,

> > show us "hciconfig -a" and run "hcidump -X -V" as root while you are
> > scanning. 
> 
> I have confirmed that this device does work on windows (a friends
> machine)... for a while I was wondering.
> 
> Now on to the infomation requested:
> 
> 
> hcitool/hciconfig output:
> -------------------------
> 
> red:/home/dpb# hcitool scan
> Scanning ...
> Inquiry failed: Connection timed out
> red:/home/dpb#
> hciconfig -a:
> red:/home/dpb# hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:0C:55:F8:5A:2B ACL MTU: 377:10 SCO MTU: 16:0
>         UP RUNNING PSCAN ISCAN INQUIRY AUTH
>         RX bytes:101 acl:0 sco:0 events:13 errors:0
>         TX bytes:304 acl:0 sco:0 commands:13 errors:0
>         Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: HOLD SNIFF PARK
>         Link mode: ACCEPT MASTER
>         Name: 'red (0)'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver:
> 0x6965
>         Manufacturer: Broadcom Corporation (15)
> 
> red:/home/dpb#

what kind of USB dongle is this? What version of kernel and what
versions of bluez-* packages are installed?

Why do you set "auth" in hcid.conf? Why is "rswitch" not activated in
hcid.conf?

Show us the content of /proc/bus/usb/devices.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
