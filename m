Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <bb22f2f905020105324e6ec65f@mail.gmail.com>
From: divisor <disserman@gmail.com>
To: Bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-devel] kill hciattach causes a system error
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 1 Feb 2005 15:32:36 +0200

Hello,

I have the following problem:

when I do 'killall hciattach' then remove card from the slot everything is fine.
when I remove card and then cardmgr kills hciattach it causes a system
error and bluetooth card is no longer available when inserted again
until reboot.

I use card called Belkin Bluetooth PDA CompactFlash Type I Model
No.F8T020 ver. 2 thru  PCMCIA adapter called Bluetooth PC Adapter Card
F8T007

command used for attaching card to hci daemon:

/usr/sbin/hciattach ttyS3 comon

I tried different card types with the same result.

what can you suggest?

kernel: 2.6.10, Gentoo Linux 2004.3

bluez version: 2.12 (tried 2.14 with the same result)

kernel error:

Oops: 0002 [#1]
PREEMPT
Modules linked in: rfcomm i915 ieee80211_crypt_wep ieee80211
ieee80211_crypt vmnet vmmon hci_uart serial_cs pcmcia yenta_socket
pcmcia_core bc_cast bc_rijn bc_idea bc_3des bc_bf128 bc_bf448
bc_twofish bc_gost bc_des bc_blowfish bc ntfs l2cap bluetooth tun
usb_storageusbhid ehci_hcd uhci_hcd usbcore snd_intel8x0m
CPU:    0
EIP:    0060:[<c02b87d1>]    Tainted: P      VLI
EFLAGS: 00010002   (2.6.10)
EIP is at uart_flush_buffer+0x21/0x60
eax: ee2ca000   ebx: ee102000   ecx: 00000286   edx: 00000000
esi: ee102000   edi: f06c2390   ebp: 00000001   esp: ee2cbd50
ds: 007b   es: 007b   ss: 0068
Process hciattach (pid: 7600, threadinfo=ee2ca000 task=ee7435c0)
Stack: eda7fc60 eda7fc60 f06c2229 ee102000 eda7fc60 ed7a2e00 f06c224e ed7a2e00
       f06c23bc ed7a2e00 ee102000 00000000 c0299371 ee102000 00000000 00000000
       c15a8940 00000000 00000003 00000000 00000001 00000000 00000000 2d44a067
Call Trace:
 [<f06c2229>] hci_uart_flush+0x89/0x90 [hci_uart]
 [<f06c224e>] hci_uart_close+0x1e/0x20 [hci_uart]
 [<f06c23bc>] hci_uart_tty_close+0x2c/0x70 [hci_uart]
 [<c0299371>] release_dev+0x631/0x760
 [<c03ff000>] irlmp_expire_discoveries+0x110/0x170
 [<c0145d13>] zap_pmd_range+0x63/0x80
 [<c0145d83>] unmap_page_range+0x53/0x80
 [<c016e203>] dput+0x33/0x220
 [<c0299934>] tty_release+0x14/0x20
 [<c01574a0>] __fput+0x110/0x130
 [<c0155ba9>] filp_close+0x59/0x90
 [<c011a144>] put_files_struct+0x64/0xd0
 [<c011af08>] do_exit+0x198/0x450
 [<c011b235>] do_group_exit+0x35/0xb0
 [<c01243e1>] get_signal_to_deliver+0x211/0x310
 [<c0102edb>] do_signal+0x9b/0x130
 [<c041d3ae>] schedule+0x2de/0x540
 [<c041da9d>] schedule_timeout+0x6d/0xc0
 [<c024e82e>] copy_to_user+0x3e/0x50
 [<c0121941>] sys_nanosleep+0x121/0x170
 [<c0102fa7>] do_notify_resume+0x37/0x3c
 [<c010312a>] work_notifysig+0x13/0x15
Code: ff 0f 00 00 c3 90 8d 74 26 00 83 ec 08 89 5c 24 04 8b 5c 24 0c
8b 93 7c 09 00 00 9c 59 fa b8 00 e0 ff ff 21 e0 ff 40 14 8b 52 10 <c7>
42 0c 00 00 00 00 c7 42 08 00 00 00 00 51 9d ff 48 14 8b 40
 <6>note: hciattach[7600] exited with preempt_count 2

#dump_cis
Socket 0:
  dev_info
    NULL 0ns, 512b
  vers_1 1.1, "Bluetooth BT0100M", "", ""
  funcid serial_port [post]
  config base 0x0100 mask 0x0001 last_index 0x03
  cftable_entry 0x01 [default]
    [mwait]
    Vcc Vnom 3300mV Vmin 3140mV Vmax 3470mV
    io 0x02f8-0x02ff [lines=10] [8bit] [range]
    irq mask 0x9eb8 [level]
  cftable_entry 0x02
    io 0x02e8-0x02ef [lines=10] [8bit] [range]
  cftable_entry 0x03
    io 0x03e8-0x03ef [lines=10] [8bit] [range]

#hciconfig -a
hci0:   Type: UART
        BD Address: 00:02:72:B1:A6:8A ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:1023 acl:0 sco:0 events:45 errors:0
        TX bytes:1266 acl:0 sco:0 commands:47 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'DiviCraft'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x110 LMP Ver: 1.1 (0x1) LMP Subver: 0x110
        Manufacturer: Cambridge Silicon Radio (10)

#hciconfig hci0 revision
hci0:   Type: UART
        BD Address: 00:02:72:B1:A6:8A ACL MTU: 192:8  SCO MTU: 64:8
        HCI 14.3


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
