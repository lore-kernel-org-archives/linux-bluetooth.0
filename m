Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f16b04cf05080822596e9aa5ab@mail.gmail.com>
From: hariharan veerappan <hariharanneevee@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Can't init device hci0. Connection timed out(110)
In-Reply-To: <8eddf07b05080809396f5d3c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <8eddf07b05080809396f5d3c1@mail.gmail.com>
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
Date: Tue, 9 Aug 2005 11:29:18 +0530

Hello,
Please confirm whether there is a module of inseting.........
/lib/modules/2.6.12-mh2/kernel/drivers/bluetooth/hci_usb.ko
or check for the module dependency file..........]
/lib/modules/2.6.12-mh2/modules.dep
Hariharan.V

On 8/8/05, Wu Jason <superht001@gmail.com> wrote:
> Dear All,
>=20
> I'm a newbie to use bluez in my school final project on Fedora Core 3.
> But I encounter the problem as the Subject "Can't init device hci0.
> Connection timed out(110)".
> I had search the older mail list, and try many methods to cover the
> problem but it still didn't work.
> Finally, I still need your help, thanks.
>=20
> My environment (I had updated the kernal to the lastest version and patch=
)
>=20
> [root@localhost ~]# uname -a
> Linux localhost.localdomain 2.6.12-mh2 #1 Sat Aug 6 00:25:51 CST 2005
> i686 i686 i386 GNU/Linux
>=20
> [root@localhost ~]# rpm -qa | grep ^bluez
> bluez-libs-2.10-2
> bluez-hcidump-1.11-1
> bluez-bluefw-1.0-6
> bluez-utils-2.10-2
>=20
> Status
>=20
> [root@localhost ~]# modprobe hci_usb
> [root@localhost ~]# modprobe l2cap
> [root@localhost ~]# lsmod
> Module                  Size  Used by
> l2cap                  29700  0
> hci_usb                17288  0
> bluetooth              51972  2 l2cap,hci_usb
> md5                     4096  1
> ipv6                  267264  10
> parport_pc             26948  1
> lp                     11272  0
> parport                38984  2 parport_pc,lp
> autofs4                27652  0
> sunrpc                158916  1
> ipt_REJECT              4736  1
> ipt_state               1792  2
> ip_conntrack           39128  1 ipt_state
> iptable_filter          2560  1
> ip_tables              19200  3 ipt_REJECT,ipt_state,iptable_filter
> dm_mod                 57396  0
> button                  5264  0
> battery                 7940  0
> ac                      3716  0
> uhci_hcd               34192  0
> i2c_piix4               8080  0
> i2c_core               18816  1 i2c_piix4
> pcnet32                33028  0
> mii                     5248  1 pcnet32
> floppy                 63028  0
> BusLogic               79380  0
> sd_mod                 17920  0
> scsi_mod              138312  2 BusLogic,sd_mod
>=20
> [root@localhost ~]# hciconfig -a
> hci0:   Type: USB
>        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
>        DOWN
>        RX bytes:0 acl:0 sco:0 events:0 errors:0
>        TX bytes:0 acl:0 sco:0 commands:0 errors:0
>        Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>        Packet type: DM1 DH1 HV1
>        Link policy:
>        Link mode: SLAVE ACCEPT
>=20
> [root@localhost ~]# hciconfig hci0 up
> Can't init device hci0. Connection timed out(110)
>=20
> The method I tried (remove the bluetooth.ko)
>=20
> [root@localhost bluetooth]# pwd
> /lib/modules/2.6.12-mh2/kernel/net/bluetooth
> [root@localhost bluetooth]# mv bluetooth.ko bluetooth.ko.old
> [root@localhost bluetooth]# modprobe hci_usb
> WARNING: Could not open
> '/lib/modules/2.6.12-mh2/kernel/net/bluetooth/bluetooth.ko': No such
> file or directory
> FATAL: Error inserting hci_usb
> (/lib/modules/2.6.12-mh2/kernel/drivers/bluetooth/hci_usb.ko): Unknown
> symbol in module, or unknown parameter (see dmesg)
>=20
>=20
> If you need more information to help me, please let me know, thank for
> your help again.
>=20
>=20
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
