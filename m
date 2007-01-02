Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <elmo11674783871759394055518@atlantide>
References: <elmo11674783871759394055518@atlantide>
Date: Tue, 02 Jan 2007 05:50:36 +0100
Message-Id: <1167713436.30886.22.camel@violet>
Mime-Version: 1.0
Cc: mrkiko.rs@gmail.com
Subject: Re: [Bluez-devel] A bug in the bluetooth stack?
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

> I was helped by: Omar. He gave to me his phone because I had to send him a song 
> via Obex Push (OBEX OBJECT PUSH PROTOCOL). Many Nokia phones like this, will 
> forbid you make more than just one connection. If you try to connect more than 
> once simultaneously the bluetooth stack will bring down some layers of the 
> kernel!
> 
> To reproduce this bug follow the following steps: I here use obexftp but may be 
> any application might reproduce the problem as yuo can see with rfcomm...
> 1 - Connect to the phone sending a relatively big file:
> obexftp -b xx:xx:xx:xx:xx:xx -p location/nomefile.ext
> 
> And while the phone is receiving the file, in another session type:
> rfcomm -i hci1 connect /dev/rfcomm0 xx:xx:xx:xx:xx:xx 1
> 
> And you will see the following happen:
> 
> Dec 27 16:43:05 atlantide hcid[1022]: link_key_request (sba=00:0B:0D:62:55:00, dba=00:0E:6D:BE:54:9B)
> Dec 27 16:45:43 atlantide kernel: add_conn: Failed to register connection device
> Dec 27 16:46:03 atlantide kernel: BUG: unable to handle kernel NULL pointer dereference at virtual address 0000000c
> Dec 27 16:46:03 atlantide kernel:  printing eip:
> Dec 27 16:46:03 atlantide kernel: c02440dd
> Dec 27 16:46:03 atlantide kernel: *pde = 00000000
> Dec 27 16:46:03 atlantide kernel: Oops: 0000 [#1]
> Dec 27 16:46:03 atlantide kernel: PREEMPT 
> Dec 27 16:46:03 atlantide kernel: Modules linked in: rfcomm l2cap processor af_packet reiserfs hci_usb bluetooth usbhid w83781d hwmon_vid hwmon i2c_isa i2c_i801 i2c_core snd_emu10k1 snd_rawmidi snd_seq_device snd_util_mem snd_hwdep uhci_hcd snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc iTCO_wdt b44 mii ehci_hcd ohci_hcd usbcore atkbd libps2 rtc pcspkr
> Dec 27 16:46:03 atlantide kernel: CPU:    0
> Dec 27 16:46:03 atlantide kernel: EIP:    0060:[<c02440dd>]    Not tainted VLI
> Dec 27 16:46:03 atlantide kernel: EFLAGS: 00010282   (2.6.19.1 #1)
> Dec 27 16:46:03 atlantide kernel: EIP is at klist_del+0x6/0x45
> Dec 27 16:46:03 atlantide kernel: eax: 00000000   ebx: cee63aa8   ecx: cee63a7c   edx: c1920748
> Dec 27 16:46:03 atlantide kernel: esi: cee63ab8   edi: cee63a78   ebp: f7e8b94c   esp: c1949f4c
> Dec 27 16:46:03 atlantide kernel: ds: 007b   es: 007b   ss: 0068
> Dec 27 16:46:03 atlantide kernel: Process events/0 (pid: 3, ti=c1948000 task=c192d030 task.ti=c1948000)
> Dec 27 16:46:03 atlantide kernel: Stack: cee63aa8 c1920740 c01e0e68 00000286 c1920740 cee63a78 cee63a00 c012073a 
> Dec 27 16:46:03 atlantide kernel:        00000000 0000a57f 08074116 f89b62e8 c1920750 c1920740 c1920748 00000000 
> Dec 27 16:46:03 atlantide kernel:        c0120c36 00000001 00000000 c192da50 00010000 00000000 00000000 c192d030 
> Dec 27 16:46:03 atlantide kernel: Call Trace:
> Dec 27 16:46:03 atlantide kernel:  [<c01e0e68>] device_del+0x15/0x169
> Dec 27 16:46:03 atlantide kernel:  [<c012073a>] run_workqueue+0x8a/0xe6
> Dec 27 16:46:03 atlantide kernel:  [<f89b62e8>] del_conn+0x0/0xa [bluetooth]
> Dec 27 16:46:03 atlantide kernel:  [<c0120c36>] worker_thread+0xe8/0x11a
> Dec 27 16:46:03 atlantide kernel:  [<c01108ea>] default_wake_function+0x0/0xc
> Dec 27 16:46:03 atlantide kernel:  [<c0120b4e>] worker_thread+0x0/0x11a
> Dec 27 16:46:03 atlantide kernel:  [<c0123083>] kthread+0xad/0xda
> Dec 27 16:46:03 atlantide kernel:  [<c0122fd6>] kthread+0x0/0xda
> Dec 27 16:46:03 atlantide kernel:  [<c01033cf>] kernel_thread_helper+0x7/0x10
> Dec 27 16:46:04 atlantide kernel:  =======================
> Dec 27 16:46:04 atlantide kernel: Code: 04 89 42 04 89 10 c7 43 f8 00 01 10 00 c7 41 04 00 02 20 00 8d 43 04 e8 57 ce ec ff c7 43 f4 00 00 00 00 5b c3 56 53 89 c6 8b 00 <8b> 58 0c 89 e0 25 00 e0 ff ff ff 40 14 89 f0 e8 a9 ff ff ff 85 
> Dec 27 16:46:04 atlantide kernel: EIP: [<c02440dd>] klist_del+0x6/0x45 SS:ESP 0068:c1949f4c
> 
> The key to reproduce this bug is to attempt to connect to the same device 
> which allows only one connection with two different hci interfaces!

I can reproduce this issue with a 2.6.20-rc3 kernel running on my G5:

add_conn: Failed to register connection device
Unable to handle kernel paging request for data at address 0x00000020
Faulting instruction address: 0xc0000000002877d8
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=4 
Modules linked in: hci_usb binfmt_misc rfcomm hidp l2cap bluetooth ipv6 cpufreq_stats usbhid hid fuse ide_cd cdrom snd_aoa_codec_onyx snd_aoa_fabric_layout snd_aoa snd_aoa_i2sbus snd_aoa_soundbus snd_pcm snd_page_alloc snd_timer bcm43xx snd ieee80211softmac ieee80211 ohci_hcd ieee80211_crypt ehci_hcd evdev ide_core soundcore tg3 firmware_class ata_generic pmac_zilog serial_core usbcore
NIP: C0000000002877D8 LR: C0000000001B7380 CTR: C0000000001B7344
REGS: c00000003ff07940 TRAP: 0300   Not tainted  (2.6.20-rc3)
MSR: 9000000000009032 <EE,ME,IR,DR>  CR: 28000028  XER: 000FFFFF
DAR: 0000000000000020, DSISR: 0000000040000000
TASK = c0000000018cc040[17] 'events/3' THREAD: c00000003ff04000 CPU: 3
GPR00: C0000000001B7380 C00000003FF07BC0 C0000000003D1F50 0000000000000000 
GPR04: 0000000000000001 0000000000000001 0000000028000022 0000000000F12E00 
GPR08: C00000003FF07EB0 0000000000000001 C000000001981FB0 C0000000001B7344 
GPR12: D000000000402360 C00000000034BC80 0000000000000000 C0000000002C6F78 
GPR16: 4000000001400000 C0000000002C5A98 0000000000000000 0000000000000000 
GPR20: C00000000033BCA8 000000000173BCA8 C00000000033BF18 000000000173BF18 
GPR24: 0000000000241AC0 0000000000000000 C00000003FF04000 C000000001981F80 
GPR28: C00000003823FD10 0000000000000000 C000000000386668 C00000003823FCE8 
NIP [C0000000002877D8] .klist_del+0x24/0xb4
LR [C0000000001B7380] .device_del+0x3c/0x278
Call Trace:
[C00000003FF07BC0] [C0000000018CC040] 0xc0000000018cc040 (unreliable)
[C00000003FF07C50] [C0000000001B7380] .device_del+0x3c/0x278
[C00000003FF07CE0] [D000000000400820] .del_conn+0x14/0x28 [bluetooth]
[C00000003FF07D60] [C000000000058560] .run_workqueue+0xec/0x1d4
[C00000003FF07E00] [C000000000059198] .worker_thread+0x15c/0x1b4
[C00000003FF07EE0] [C00000000005DE88] .kthread+0x11c/0x16c
[C00000003FF07F90] [C0000000000210EC] .kernel_thread+0x4c/0x68
Instruction dump:
eba1ffe8 7c0803a6 4e800020 7c0802a6 fb81ffe0 fba1ffe8 fbe1fff8 7c7c1b78 
f8010010 f821ff71 eba30000 7fa3eb78 <ebfd0020> 4800386d 60000000 7f83e378 

The problem is that the add_conn call fails for some strange reasons. I
have no idea why, because it actually shouldn't. Even if it fails, it
shouldn't kill the kernel on del_conn.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
