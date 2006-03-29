Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f64f4e8a0603290636m323b0802v10a71ce9be067254@mail.gmail.com>
From: "zhu yong" <zhuyong0003@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] l2ping problem about "Can't connect: Host is down"
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
Date: Wed, 29 Mar 2006 22:36:32 +0800

Hi everyone,

  I am working with two bluetooth USB dongles. I use bluez-utils-2.25
and bluez-libs-2.25 packet. I use redhat9.0 with linux kernel 2.4.20,
I am not familier with kernel update, so I don't use bluez patch to
2.4.20.
 They are connected to the same host. However I cannot l2ping one from
the other.
 info as follows:
 [root@localhost root]# l2ping -i 00:11:67:20:7e:33 00:11:67:1a:a7:0f
 Can't connect: Host is down

 And it looks like they are configured:
 [root@localhost root]# hciconfig -a hci0
hci0:   Type: USB
        BD Address: 00:11:67:1A:A7:0F ACL MTU: 678:8 SCO MTU: 48:10
        UP RUNNING PSCAN ISCAN INQUIRY
        RX bytes:1038 acl:0 sco:0 events:38 errors:0
        TX bytes:923 acl:0 sco:0 commands:38 errors:0
        Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x1fe LMP Ver: 1.2 (0x2) LMP Subver: 0x=
1fe
        Manufacturer: Integrated System Solution Corp. (57)

[root@localhost root]# hciconfig -a hci1
hci1:   Type: USB
        BD Address: 00:11:67:20:7E:33 ACL MTU: 678:8 SCO MTU: 48:10
        UP RUNNING PSCAN ISCAN
        RX bytes:724 acl:0 sco:0 events:58 errors:0
        TX bytes:1075 acl:0 sco:0 commands:49 errors:0
        Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (1)'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x1f4 LMP Ver: 1.2 (0x2) LMP Subver: 0x=
1f4
        Manufacturer: Integrated System Solution Corp. (57)

  load module as follows:
  [root@localhost bluez-utils-2.25]# lsmod
Module                  Size  Used by    Not tainted
l2cap                  19276   1
hci_usb                 8920   2
bluez                  40132  11  [l2cap hci_usb]
nls_iso8859-1           3516   1  (autoclean)
nls_cp437               5116   1  (autoclean)
vfat                   13004   1  (autoclean)
fat                    38808   0  (autoclean) [vfat]
ide-cd                 35708   0  (autoclean)
cdrom                  33728   0  (autoclean) [ide-cd]
parport_pc             19076   1  (autoclean)
lp                      8996   0  (autoclean)
parport                37056   1  (autoclean) [parport_pc lp]
autofs                 13268   0  (autoclean) (unused)
sis900                 16812   1
ipt_REJECT              3928   6  (autoclean)
iptable_filter          2412   1  (autoclean)
ip_tables              15096   2  [ipt_REJECT iptable_filter]
microcode               4668   0  (autoclean)
keybdev                 2944   0  (unused)
mousedev                5492   1
hid                    22148   0  (unused)
input                   5856   0  [keybdev mousedev hid]
ehci-hcd               19976   0  (unused)
usb-ohci               21480   0  (unused)
usbcore                78784   1  [hci_usb hid ehci-hcd usb-ohci]
[root@localhost bluez-utils-2.25]#

 Can anyone figure out what"s wrong?

 Thanks in advance,
 yong Zhu


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
