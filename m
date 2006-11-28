Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <c303508f0611271806t6e5f0b31u4908ee4234b5e1ad@mail.gmail.com>
Date: Mon, 27 Nov 2006 21:06:04 -0500
From: "Axel Ruder" <axel.ruder@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Rfcomm kernel crashes (2.6.18.2)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1612183975=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1612183975==
Content-Type: multipart/alternative;
	boundary="----=_Part_197_27234092.1164679564379"

------=_Part_197_27234092.1164679564379
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,
thanks again for your patch. It seems to have fixed the problem partially.
I get a lot less frequent crashes, but unfortunately I now got this new
error:

Nov 26 21:57:58 localhost kernel: BUG: unable to handle kernel NULL pointer
dereference at virtual address 0000003c
Nov 26 21:57:58 localhost kernel:  printing eip:
Nov 26 21:57:58 localhost kernel: e1cebe5f
Nov 26 21:57:58 localhost kernel: *pde = 00000000
Nov 26 21:57:58 localhost kernel: Oops: 0000 [#1]
Nov 26 21:57:58 localhost kernel: SMP
Nov 26 21:57:58 localhost kernel: Modules linked in: nvidia rfcomm l2cap
lirc_serial cx8800 cx88xx bttv video_buf ir_common compat_ioctl32 btcx_risc
lirc_i2c lirc_dev ipv6 dm_mod it87 hwmon_vid i2c_isa eeprom sd_mod eth1394
dv1394 raw1394 hci_usb bluetooth usb_storage scsi_mod msp3400 saa7127
mousedev saa7115 tsdev tuner snd_intel8x0 snd_ac97_codec snd_ac97_bus
snd_pcm_oss snd_mixer_oss snd_pcm shpchp ivtv ohci1394 ide_cd cdrom
firmware_class ehci_hcd ieee1394 pci_hotplug i2c_sis96x i2c_algo_bit
ohci_hcd snd_timer sis900 ns558 snd 8250_pnp tveeprom i2c_core psmouse
usbcore mii analog sis_agp agpgart videodev v4l1_compat v4l2_common evdev
soundcore snd_page_alloc serio_raw pcspkr rtc gameport parport_pc parport
ext3 jbd mbcache ide_disk ide_generic via82cxxx trm290 triflex slc90e66
sis5513 siimage serverworks sc1200 rz1000 piix pdc202xx_old pdc202xx_new
opti621 ns87415 it821x hpt366 hpt34x generic cy82c693 cs5535 cs5530 cs5520
cmd64x atiixp amd74xx alim15x3 aec62xx ide_core
Nov 26 21:57:58 localhost kernel: CPU:    1
Nov 26 21:57:58 localhost kernel: EIP:    0060:[<e1cebe5f>]    Tainted:
PF     VLI
Nov 26 21:57:58 localhost kernel: EFLAGS: 00010293   (2.6.18.2 #1)
Nov 26 21:57:58 localhost kernel: EIP is at rfcomm_tty_write_room+0x7/0x27
[rfcomm]
Nov 26 21:57:58 localhost kernel: eax: c297a000   ebx: c297a000   ecx:
00000000   edx: deeb8200
Nov 26 21:57:58 localhost kernel: esi: 00000000   edi: d6b1c8c0   ebp:
c297a00c   esp: c554fbfc
Nov 26 21:57:58 localhost kernel: ds: 007b   es: 007b   ss: 0068
Nov 26 21:57:58 localhost kernel: Process rfcomm (pid: 20250, ti=c554e000
task=dfceeab0 task.ti=c554e000)
Nov 26 21:57:58 localhost kernel: Stack: c297a000 b01fb6f9 00124d5e c297a000
b01fb5f2 d6b1c8c0 b01f7943 00000000
Nov 26 21:57:58 localhost kernel:        00000000 00000000 c554fea0 d6b1c8c0
c554fe98 b0167131 c554ffb0 afcd69e0
Nov 26 21:57:58 localhost kernel:        afcd69e8 00000000 c554fe98 c554fe98
c554fe98 c554fea8 00000000 b0167bdf
Nov 26 21:57:58 localhost kernel: Call Trace:
Nov 26 21:57:58 localhost kernel:  [<b01fb6f9>] normal_poll+0x107/0x11a
Nov 26 21:57:58 localhost kernel:  [<b01fb5f2>] normal_poll+0x0/0x11a
Nov 26 21:57:58 localhost kernel:  [<b01f7943>] tty_poll+0x48/0x60
Nov 26 21:57:58 localhost kernel:  [<b0167131>] do_sys_poll+0x1a7/0x341
Nov 26 21:57:58 localhost kernel:  [<b0167bdf>] __pollwait+0x0/0xb2
Nov 26 21:57:58 localhost kernel:  [<b0117295>]
default_wake_function+0x0/0xc
Nov 26 21:57:58 localhost kernel:  [<b0117295>]
default_wake_function+0x0/0xc
Nov 26 21:57:58 localhost kernel:  [<e2374249>] _nv005245rm+0xa9/0xe8
[nvidia]
Nov 26 21:57:58 localhost kernel:  [<e2374249>] _nv005245rm+0xa9/0xe8
[nvidia]
Nov 26 21:57:58 localhost kernel:  [<e21fe10a>] _nv002668rm+0x26/0x2c
[nvidia]
Nov 26 21:57:58 localhost kernel:  [<e24336d2>] _nv000984rm+0x1a/0x20
[nvidia]
Nov 26 21:57:58 localhost kernel:  [<e243203f>] _nv000986rm+0x33/0x68
[nvidia]
Nov 26 21:57:58 localhost kernel:  [<e2432051>] _nv000986rm+0x45/0x68
[nvidia]
Nov 26 21:57:58 localhost kernel:  [<e21fe053>] _nv002682rm+0x53/0x84
[nvidia]
Nov 26 21:57:58 localhost kernel:  [<e23748b1>] _nv005436rm+0x15/0x1c
[nvidia]
Nov 26 21:57:58 localhost kernel:  [<e21fe101>] _nv002668rm+0x1d/0x2c
[nvidia]
Nov 26 21:57:58 localhost kernel:  [<e21fe10a>] _nv002668rm+0x26/0x2c
[nvidia]
Nov 26 21:57:58 localhost kernel:  [<b020ed34>] dma_pool_alloc+0x16e/0x178
Nov 26 21:57:58 localhost kernel:  [<e093fe8c>] ohci_urb_enqueue+0x61d/0x6d1
[ohci_hcd]
Nov 26 21:57:58 localhost kernel:  [<b0115f3e>] __activate_task+0x1c/0x29
Nov 26 21:57:58 localhost kernel:  [<b011728b>] try_to_wake_up+0x355/0x35f
Nov 26 21:57:58 localhost kernel:  [<e0965e40>] hcd_submit_urb+0x67d/0x727
[usbcore]
Nov 26 21:57:58 localhost kernel:  [<b012d1f2>]
autoremove_wake_function+0xd/0x2d
Nov 26 21:57:58 localhost kernel:  [<b0115d79>] __wake_up_common+0x2f/0x53
Nov 26 21:57:58 localhost kernel:  [<b01161ca>] __wake_up+0x2a/0x3d
Nov 26 21:57:58 localhost kernel:  [<b0141c58>] mempool_free+0x5f/0x63
Nov 26 21:57:58 localhost kernel:  [<b015bc9c>] bio_put+0x22/0x23
Nov 26 21:57:58 localhost kernel:  [<b017500c>] mpage_end_io_read+0x5e/0x66
Nov 26 21:57:58 localhost kernel:  [<b0124dfb>] __mod_timer+0x93/0x9d
Nov 26 21:57:58 localhost kernel:  [<b01aec85>] as_antic_waitnext+0x25/0x31
Nov 26 21:57:58 localhost kernel:  [<b01afa43>]
as_dispatch_request+0x176/0x30e
Nov 26 21:57:58 localhost kernel:  [<b01a896f>] elv_next_request+0x106/0x113
Nov 26 21:57:58 localhost kernel:  [<e083630f>] ide_do_request+0x249/0x6bf
[ide_core]
Nov 26 21:57:58 localhost kernel:  [<b01aa2b7>] freed_request+0x1d/0x37
Nov 26 21:57:58 localhost kernel:  [<e0836095>] ide_end_request+0xc1/0xc9
[ide_core]
Nov 26 21:57:58 localhost kernel:  [<e0836a0a>] ide_intr+0x183/0x18f
[ide_core]
Nov 26 21:57:58 localhost kernel:  [<b013d8bf>] handle_IRQ_event+0x23/0x49
Nov 26 21:57:58 localhost kernel:  [<b0106758>] enable_8259A_irq+0xd/0x42
Nov 26 21:57:58 localhost kernel:  [<b013d9bb>] __do_IRQ+0xd6/0xe6
Nov 26 21:57:58 localhost kernel:  [<b0167300>] sys_poll+0x35/0x38
Nov 26 21:57:58 localhost kernel:  [<b0102c73>] syscall_call+0x7/0xb
Nov 26 21:57:58 localhost kernel: Code: 5f 5d c3 90 89 c1 a1 c0 16 cf e1 eb
07 39 48 18 74 11 89 d0 8b 10 0f 18 02 90 3d c0 16 cf e1 75 ec 31 c0 c3 53
8b 88 84 01 00 00 <8b> 59 3c 8b 53 5c 85 d2 b8 01 00 00 00 0f 44 d0 8b 49 64
0f af
Nov 26 21:57:58 localhost kernel: EIP: [<e1cebe5f>]
rfcomm_tty_write_room+0x7/0x27 [rfcomm] SS:ESP 0068:c554fbfc


Thanks for your help!
Axel

------=_Part_197_27234092.1164679564379
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,<br>thanks again for your patch. It seems to have fixed the problem partially.<br>I get a lot less frequent crashes, but unfortunately I now got this new error:<br><br>Nov 26 21:57:58 localhost kernel: BUG: unable to handle kernel NULL pointer dereference at virtual address 0000003c
<br>Nov 26 21:57:58 localhost kernel:&nbsp; printing eip:<br>Nov 26 21:57:58 localhost kernel: e1cebe5f<br>Nov 26 21:57:58 localhost kernel: *pde = 00000000<br>Nov 26 21:57:58 localhost kernel: Oops: 0000 [#1]<br>Nov 26 21:57:58 localhost kernel: SMP 
<br>Nov 26 21:57:58 localhost kernel: Modules linked in: nvidia rfcomm l2cap lirc_serial cx8800 cx88xx bttv video_buf ir_common compat_ioctl32 btcx_risc lirc_i2c lirc_dev ipv6 dm_mod it87 hwmon_vid i2c_isa eeprom sd_mod eth1394 dv1394 raw1394 hci_usb bluetooth usb_storage scsi_mod msp3400 saa7127 mousedev saa7115 tsdev tuner snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm shpchp ivtv ohci1394 ide_cd cdrom firmware_class ehci_hcd ieee1394 pci_hotplug i2c_sis96x i2c_algo_bit ohci_hcd snd_timer sis900 ns558 snd 8250_pnp tveeprom i2c_core psmouse usbcore mii analog sis_agp agpgart videodev v4l1_compat v4l2_common evdev soundcore snd_page_alloc serio_raw pcspkr rtc gameport parport_pc parport ext3 jbd mbcache ide_disk ide_generic via82cxxx trm290 triflex slc90e66 sis5513 siimage serverworks sc1200 rz1000 piix pdc202xx_old pdc202xx_new opti621 ns87415 it821x hpt366 hpt34x generic cy82c693 cs5535 cs5530 cs5520 cmd64x atiixp amd74xx alim15x3 aec62xx ide_cor
 e
<br>Nov 26 21:57:58 localhost kernel: CPU:&nbsp;&nbsp;&nbsp; 1<br>Nov 26 21:57:58 localhost kernel: EIP:&nbsp;&nbsp;&nbsp; 0060:[&lt;e1cebe5f&gt;]&nbsp;&nbsp;&nbsp; Tainted: PF&nbsp;&nbsp;&nbsp;&nbsp; VLI<br>Nov 26 21:57:58 localhost kernel: EFLAGS: 00010293&nbsp;&nbsp; (<a href="http://2.6.18.2">
2.6.18.2</a> #1) <br>Nov 26 21:57:58 localhost kernel: EIP is at rfcomm_tty_write_room+0x7/0x27 [rfcomm]<br>Nov 26 21:57:58 localhost kernel: eax: c297a000&nbsp;&nbsp; ebx: c297a000&nbsp;&nbsp; ecx: 00000000&nbsp;&nbsp; edx: deeb8200<br>Nov 26 21:57:58 localhost kernel: esi: 00000000&nbsp;&nbsp; edi: d6b1c8c0&nbsp;&nbsp; ebp: c297a00c&nbsp;&nbsp; esp: c554fbfc
<br>Nov 26 21:57:58 localhost kernel: ds: 007b&nbsp;&nbsp; es: 007b&nbsp;&nbsp; ss: 0068<br>Nov 26 21:57:58 localhost kernel: Process rfcomm (pid: 20250, ti=c554e000 task=dfceeab0 task.ti=c554e000)<br>Nov 26 21:57:58 localhost kernel: Stack: c297a000 b01fb6f9 00124d5e c297a000 b01fb5f2 d6b1c8c0 b01f7943 00000000 
<br>Nov 26 21:57:58 localhost kernel:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000000 00000000 c554fea0 d6b1c8c0 c554fe98 b0167131 c554ffb0 afcd69e0 <br>Nov 26 21:57:58 localhost kernel:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; afcd69e8 00000000 c554fe98 c554fe98 c554fe98 c554fea8 00000000 b0167bdf 
<br>Nov 26 21:57:58 localhost kernel: Call Trace:<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;b01fb6f9&gt;] normal_poll+0x107/0x11a<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;b01fb5f2&gt;] normal_poll+0x0/0x11a<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;b01f7943&gt;] tty_poll+0x48/0x60
<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;b0167131&gt;] do_sys_poll+0x1a7/0x341<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;b0167bdf&gt;] __pollwait+0x0/0xb2<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;b0117295&gt;] default_wake_function+0x0/0xc
<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;b0117295&gt;] default_wake_function+0x0/0xc<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;e2374249&gt;] _nv005245rm+0xa9/0xe8 [nvidia]<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;e2374249&gt;] _nv005245rm+0xa9/0xe8 [nvidia]
<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;e21fe10a&gt;] _nv002668rm+0x26/0x2c [nvidia]<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;e24336d2&gt;] _nv000984rm+0x1a/0x20 [nvidia]<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;e243203f&gt;] _nv000986rm+0x33/0x68 [nvidia]
<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;e2432051&gt;] _nv000986rm+0x45/0x68 [nvidia]<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;e21fe053&gt;] _nv002682rm+0x53/0x84 [nvidia]<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;e23748b1&gt;] _nv005436rm+0x15/0x1c [nvidia]
<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;e21fe101&gt;] _nv002668rm+0x1d/0x2c [nvidia]<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;e21fe10a&gt;] _nv002668rm+0x26/0x2c [nvidia]<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;b020ed34&gt;] dma_pool_alloc+0x16e/0x178
<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;e093fe8c&gt;] ohci_urb_enqueue+0x61d/0x6d1 [ohci_hcd]<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;b0115f3e&gt;] __activate_task+0x1c/0x29<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;b011728b&gt;] try_to_wake_up+0x355/0x35f
<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;e0965e40&gt;] hcd_submit_urb+0x67d/0x727 [usbcore]<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;b012d1f2&gt;] autoremove_wake_function+0xd/0x2d<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;b0115d79&gt;] __wake_up_common+0x2f/0x53
<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;b01161ca&gt;] __wake_up+0x2a/0x3d<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;b0141c58&gt;] mempool_free+0x5f/0x63<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;b015bc9c&gt;] bio_put+0x22/0x23
<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;b017500c&gt;] mpage_end_io_read+0x5e/0x66<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;b0124dfb&gt;] __mod_timer+0x93/0x9d<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;b01aec85&gt;] as_antic_waitnext+0x25/0x31
<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;b01afa43&gt;] as_dispatch_request+0x176/0x30e<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;b01a896f&gt;] elv_next_request+0x106/0x113<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;e083630f&gt;] ide_do_request+0x249/0x6bf [ide_core]
<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;b01aa2b7&gt;] freed_request+0x1d/0x37<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;e0836095&gt;] ide_end_request+0xc1/0xc9 [ide_core]<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;e0836a0a&gt;] ide_intr+0x183/0x18f [ide_core]
<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;b013d8bf&gt;] handle_IRQ_event+0x23/0x49<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;b0106758&gt;] enable_8259A_irq+0xd/0x42<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;b013d9bb&gt;] __do_IRQ+0xd6/0xe6
<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;b0167300&gt;] sys_poll+0x35/0x38<br>Nov 26 21:57:58 localhost kernel:&nbsp; [&lt;b0102c73&gt;] syscall_call+0x7/0xb<br>Nov 26 21:57:58 localhost kernel: Code: 5f 5d c3 90 89 c1 a1 c0 16 cf e1 eb 07 39 48 18 74 11 89 d0 8b 10 0f 18 02 90 3d c0 16 cf e1 75 ec 31 c0 c3 53 8b 88 84 01 00 00 &lt;8b&gt; 59 3c 8b 53 5c 85 d2 b8 01 00 00 00 0f 44 d0 8b 49 64 0f af 
<br>Nov 26 21:57:58 localhost kernel: EIP: [&lt;e1cebe5f&gt;] rfcomm_tty_write_room+0x7/0x27 [rfcomm] SS:ESP 0068:c554fbfc<br><br><br>Thanks for your help!<br>Axel<br>

------=_Part_197_27234092.1164679564379--


--===============1612183975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1612183975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1612183975==--
