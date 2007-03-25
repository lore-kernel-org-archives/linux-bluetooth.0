Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: CIJOML <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net
Date: Sun, 25 Mar 2007 09:54:28 +0200
MIME-Version: 1.0
Message-Id: <200703250954.28363.cijoml@volny.cz>
Subject: [Bluez-users] Logitech diNovo Bluetooth 2.0 EDR dongle description
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Marcel,

I am sending you info about Logitech diNovo Bluetooth 2.0 EDR dongle 
description. You can add it into your list. And BTW is there newer firmware 
for it?

hci1:   Type: USB
        BD Address: 00:07:61:46:8F:98 ACL MTU: 1017:8 SCO MTU: 64:0
        UP RUNNING PSCAN
        RX bytes:695 acl:0 sco:0 events:23 errors:0
        TX bytes:336 acl:0 sco:0 commands:23 errors:0
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'notas-1'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing, Object Transfer, 
Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0x2000 LMP Ver: 2.0 (0x3) LMP Subver: 
0x4147
        Manufacturer: Broadcom Corporation (15)

notas:/usr/src/dinovo/bluez-utils-3.9# hciconfig hci1 features
hci1:   Type: USB
        BD Address: 00:07:61:46:8F:98 ACL MTU: 1017:8 SCO MTU: 64:0
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <power control>
                <transparent SCO> <broadcast encrypt> <EDR ACL 2 Mbps>
                <EDR ACL 3 Mbps> <enhanced iscan> <interlaced iscan>
                <interlaced pscan> <inquiry with RSSI> <extended SCO>
                <EV4 packets> <EV5 packets> <AFH cap. slave>
                <AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL>
                <AFH cap. master> <AFH class. master> <EDR eSCO 2 Mbps>
                <EDR eSCO 3 Mbps> <3-slot EDR eSCO> <extended features>
notas:/usr/src/dinovo/bluez-utils-3.9# hciconfig hci1 revision
hci1:   Type: USB
        BD Address: 00:07:61:46:8F:98 ACL MTU: 1017:8 SCO MTU: 64:0
        Firmware 0.65 / 71


I also got OOPS switching dongle into hci mode. Kernel 2.6.20-mh1:

usb 7-1.2: new full speed USB device using ohci_hcd and address 3
usb 7-1.2: configuration #1 chosen from 1 choice
input: Logitech Logitech BT Mini-Receiver as /class/input/input10
input: USB HID v1.11 Keyboard [Logitech Logitech BT Mini-Receiver] on 
usb-0000:02:00.1-1.2
usb 7-1.3: new full speed USB device using ohci_hcd and address 4
usb 7-1.3: configuration #1 chosen from 1 choice
input: Logitech Logitech BT Mini-Receiver as /class/input/input11
input,hiddev0: USB HID v1.11 Mouse [Logitech Logitech BT Mini-Receiver] on 
usb-0000:02:00.1-1.3
BUG: at drivers/hid/hid-core.c:785 implement()
 [<c027a9c3>] hid_output_report+0x213/0x2be
 [<fcaf73fb>] hid_submit_ctrl+0x52/0x1bc [usbhid]
 [<fcaf76b9>] usbhid_submit_report+0x154/0x187 [usbhid]
 [<fcaf7970>] usbhid_init_reports+0x60/0xbb [usbhid]
 [<fcaf917d>] hiddev_ioctl+0x361/0x8e7 [usbhid]
 [<c01b4dd1>] avc_has_perm+0x4e/0x58
 [<c01b5595>] inode_has_perm+0x5b/0x63
 [<c0148652>] __handle_mm_fault+0x2c3/0x7b1
 [<c01b5626>] file_has_perm+0x89/0x91
 [<c0161158>] do_ioctl+0x4c/0x62
 [<c01613aa>] vfs_ioctl+0x23c/0x24f
 [<c0161409>] sys_ioctl+0x4c/0x67
 [<c0102cc8>] syscall_call+0x7/0xb
 [<c02d0033>] __sched_text_start+0x43/0x546
 =======================
BUG: at drivers/hid/hid-core.c:785 implement()
 [<c027a9c3>] hid_output_report+0x213/0x2be
 [<fcaf73fb>] hid_submit_ctrl+0x52/0x1bc [usbhid]
 [<fcaf76b9>] usbhid_submit_report+0x154/0x187 [usbhid]
 [<fcaf7970>] usbhid_init_reports+0x60/0xbb [usbhid]
 [<fcaf917d>] hiddev_ioctl+0x361/0x8e7 [usbhid]
 [<c01b4dd1>] avc_has_perm+0x4e/0x58
 [<c01b5595>] inode_has_perm+0x5b/0x63
 [<c0148652>] __handle_mm_fault+0x2c3/0x7b1
 [<c01b5626>] file_has_perm+0x89/0x91
 [<c0161158>] do_ioctl+0x4c/0x62
 [<c01613aa>] vfs_ioctl+0x23c/0x24f
 [<c0161409>] sys_ioctl+0x4c/0x67
 [<c0102cc8>] syscall_call+0x7/0xb
 [<c02d0033>] __sched_text_start+0x43/0x546
 =======================
BUG: at drivers/hid/hid-core.c:785 implement()
 [<c027a9c3>] hid_output_report+0x213/0x2be
 [<fcaf73fb>] hid_submit_ctrl+0x52/0x1bc [usbhid]
 [<fcaf76b9>] usbhid_submit_report+0x154/0x187 [usbhid]
 [<fcaf7970>] usbhid_init_reports+0x60/0xbb [usbhid]
 [<fcaf917d>] hiddev_ioctl+0x361/0x8e7 [usbhid]
 [<c01b4dd1>] avc_has_perm+0x4e/0x58
 [<c01b5595>] inode_has_perm+0x5b/0x63
 [<c0148652>] __handle_mm_fault+0x2c3/0x7b1
 [<c01b5626>] file_has_perm+0x89/0x91
 [<c0161158>] do_ioctl+0x4c/0x62
 [<c01613aa>] vfs_ioctl+0x23c/0x24f
 [<c0161409>] sys_ioctl+0x4c/0x67
 [<c0102cc8>] syscall_call+0x7/0xb
 [<c02d0033>] __sched_text_start+0x43/0x546
 =======================
BUG: at drivers/hid/hid-core.c:785 implement()
 [<c027a9c3>] hid_output_report+0x213/0x2be
 [<fcaf73fb>] hid_submit_ctrl+0x52/0x1bc [usbhid]
 [<fcaf76b9>] usbhid_submit_report+0x154/0x187 [usbhid]
 [<fcaf917d>] hiddev_ioctl+0x361/0x8e7 [usbhid]
 [<c01b4dd1>] avc_has_perm+0x4e/0x58
 [<c01b5595>] inode_has_perm+0x5b/0x63
 [<c0148652>] __handle_mm_fault+0x2c3/0x7b1
 [<c01b5626>] file_has_perm+0x89/0x91
 [<c0161158>] do_ioctl+0x4c/0x62
 [<c01613aa>] vfs_ioctl+0x23c/0x24f
 [<c0161409>] sys_ioctl+0x4c/0x67
 [<c0102cc8>] syscall_call+0x7/0xb
 [<c02d0033>] __sched_text_start+0x43/0x546
 =======================
BUG: at drivers/hid/hid-core.c:785 implement()
 [<c027a9c3>] hid_output_report+0x213/0x2be
 [<fcaf73fb>] hid_submit_ctrl+0x52/0x1bc [usbhid]
 [<fcaf76b9>] usbhid_submit_report+0x154/0x187 [usbhid]
 [<fcaf917d>] hiddev_ioctl+0x361/0x8e7 [usbhid]
 [<c01b4dd1>] avc_has_perm+0x4e/0x58
 [<c01b5595>] inode_has_perm+0x5b/0x63
 [<c0148652>] __handle_mm_fault+0x2c3/0x7b1
 [<c01b5626>] file_has_perm+0x89/0x91
 [<c0161158>] do_ioctl+0x4c/0x62
 [<c01613aa>] vfs_ioctl+0x23c/0x24f
 [<c0161409>] sys_ioctl+0x4c/0x67
 [<c0102cc8>] syscall_call+0x7/0xb
 [<c02d0033>] __sched_text_start+0x43/0x546
 =======================
BUG: at drivers/hid/hid-core.c:785 implement()
 [<c027a9c3>] hid_output_report+0x213/0x2be
 [<c011bfb6>] irq_exit+0x25/0x30
 [<c0105190>] do_IRQ+0x87/0x9b
 [<fcaf73fb>] hid_submit_ctrl+0x52/0x1bc [usbhid]
 [<fcaf76b9>] usbhid_submit_report+0x154/0x187 [usbhid]
 [<c0127f9f>] autoremove_wake_function+0x0/0x35
 [<fcaf917d>] hiddev_ioctl+0x361/0x8e7 [usbhid]
 [<c01b4dd1>] avc_has_perm+0x4e/0x58
 [<c01b5595>] inode_has_perm+0x5b/0x63
 [<c0148652>] __handle_mm_fault+0x2c3/0x7b1
 [<c01b5626>] file_has_perm+0x89/0x91
 [<c0161158>] do_ioctl+0x4c/0x62
 [<c01613aa>] vfs_ioctl+0x23c/0x24f
 [<c0161409>] sys_ioctl+0x4c/0x67
 [<c0102cc8>] syscall_call+0x7/0xb
 [<c02d0033>] __sched_text_start+0x43/0x546
 =======================
BUG: at drivers/hid/hid-core.c:785 implement()
 [<c027a9c3>] hid_output_report+0x213/0x2be
 [<c011bfb6>] irq_exit+0x25/0x30
 [<c0105190>] do_IRQ+0x87/0x9b
 [<fcaf73fb>] hid_submit_ctrl+0x52/0x1bc [usbhid]
 [<fcaf76b9>] usbhid_submit_report+0x154/0x187 [usbhid]
 [<c0127f9f>] autoremove_wake_function+0x0/0x35
 [<fcaf917d>] hiddev_ioctl+0x361/0x8e7 [usbhid]
 [<c01b4dd1>] avc_has_perm+0x4e/0x58
 [<c01b5595>] inode_has_perm+0x5b/0x63
 [<c0148652>] __handle_mm_fault+0x2c3/0x7b1
 [<c01b5626>] file_has_perm+0x89/0x91
 [<c0161158>] do_ioctl+0x4c/0x62
 [<c01613aa>] vfs_ioctl+0x23c/0x24f
 [<c0161409>] sys_ioctl+0x4c/0x67
 [<c0102cc8>] syscall_call+0x7/0xb
 [<c02d0033>] __sched_text_start+0x43/0x546
 =======================
BUG: at drivers/hid/hid-core.c:785 implement()
 [<c027a9c3>] hid_output_report+0x213/0x2be
 [<c011bfb6>] irq_exit+0x25/0x30
 [<c0105190>] do_IRQ+0x87/0x9b
 [<fcaf73fb>] hid_submit_ctrl+0x52/0x1bc [usbhid]
 [<fcaf76b9>] usbhid_submit_report+0x154/0x187 [usbhid]
 [<c0127f9f>] autoremove_wake_function+0x0/0x35
 [<fcaf917d>] hiddev_ioctl+0x361/0x8e7 [usbhid]
 [<c01b4dd1>] avc_has_perm+0x4e/0x58
 [<c01b5595>] inode_has_perm+0x5b/0x63
 [<c0148652>] __handle_mm_fault+0x2c3/0x7b1
 [<c01b5626>] file_has_perm+0x89/0x91
 [<c0161158>] do_ioctl+0x4c/0x62
 [<c01613aa>] vfs_ioctl+0x23c/0x24f
 [<c0161409>] sys_ioctl+0x4c/0x67
 [<c0102cc8>] syscall_call+0x7/0xb
 [<c02d0033>] __sched_text_start+0x43/0x546
 =======================
usb 7-1.1: new full speed USB device using ohci_hcd and address 5
usb 7-1.1: configuration #1 chosen from 1 choice

Best regards

Michal

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
