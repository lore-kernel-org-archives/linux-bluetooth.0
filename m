Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <1891.128.59.13.6.1130107536.squirrel@webmail.cs.columbia.edu>
In-Reply-To: <435B72B0.5050309@libero.it>
References: <435B72B0.5050309@libero.it>
Subject: Re: [Bluez-users] Bluetooth-Alsa: cannot pair the headset
From: mv2147@cs.columbia.edu
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
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
Date: Sun, 23 Oct 2005 18:45:36 -0400 (EDT)

Hi immi,

  Can you please tell me the usb dongle manufacturer, version and model no.
you are using? I am using a bluetake BT009si and it is not able to
establish a SCO connection with my headset. hciconfig hci0 revision gives
"unsupported manufacturer". Do you know if your dongle might work with
2.6.11 fedora core 4 and BT400 G5 headset?

Thanks.

Manmohan.

> Ciao,
>
> I'm trying to use Jabra BT 250v with skype. The headset connect trough a
> USB-BT key, that  I know it's working because I  used already with other
> devices.
>
> My laptop has  a Debian unstable, and I followed  the instruction of the
> Bluetooth-alsa  project. I  could load  the module  snd_bt_sco, and  the
> output of some commands are here:
>
> # hcitool scan
> Scanning ...
>         00:07:A4:14:0F:BF       Jabra BT 250v
>
> # btsco -v 00:07:A4:14:0F:BF
> btsco v0.4
> Device is 2:0
> Error: Failed to connect to SDP server: Permission denied
> Assuming channel 2
>
> Voice setting: 0x0060
> Can't connect RFCOMM channel: Permission denied
>
> # hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:11:95:7D:83:E9 ACL MTU: 192:8 SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:244 acl:0 sco:0 events:30 errors:0
>         TX bytes:384 acl:0 sco:0 commands:22 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'Titanic-0'
>         Class: 0x3e0100
>         Service Classes: Networking, Rendering, Capturing
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver:
> 0x20d
>         Manufacturer: Cambridge Silicon Radio (10)
>
> # hciconfig hci0
> hci0:   Type: USB
>         BD Address: 00:11:95:7D:83:E9 ACL MTU: 192:8 SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:521 acl:0 sco:0 events:33 errors:0
>         TX bytes:393 acl:0 sco:0 commands:25 errors:0
>
> # hciconfig hci0 revision
> hci0:   Type: USB
>         BD Address: 00:11:95:7D:83:E9 ACL MTU: 192:8 SCO MTU: 64:8
>         HCI 16.4
>         Chip version: BlueCore02-External
>         Max key size: 56 bit
>         SCO mapping:  HCI
>
> # hcitool info 00:07:A4:14:0F:BF
> Requesting information ...
> Can't create connection: Input/output error
>
> I  searched for  the "SDP  server" error  but I  could not  get suitable
> informations. Has anybody an hint about?
>
> Thanks in advance
> --
>    ---         _   o        |     Sembra di sentirlo ancora dire al     |
>    / immi   ---  _/\_>      | mercante di liquori: tu che lo vendi cosa |
> (_/          -  O,> / O     |        ti compri di migliore? FdA         |
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.
> Get Certified Today * Register for a JBoss Training Course
> Free Certification Exam for All Training Attendees Through End of 2005
> Visit http://www.jboss.com/services/certification for more information
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
