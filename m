Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <c303508f0611181827s178b8776g57d3dbec37264691@mail.gmail.com>
Date: Sat, 18 Nov 2006 21:27:30 -0500
From: "Axel Ruder" <axel.ruder@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Rfcomm kernel crashes (2.6.18.2)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1805838501=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1805838501==
Content-Type: multipart/alternative;
	boundary="----=_Part_30826_21979491.1163903250380"

------=_Part_30826_21979491.1163903250380
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

please help me!
I have the following problem with Bluez/RFcomm:
- I use a shell script that calls 'rfcomm listen rfcomm0 3' repeatedly to
wait for a client to connect.
- Everything works fine, except that every once in a while (unfortunately
pretty often, like twice a day), the linux kernel crashes with the following
message in syslog:

Nov 18 20:31:48 localhost hcid[23340]: link_key_request
(sba=00:02:72:C5:88:A1, dba=00:12:37:8D:A3:D5)
Nov 18 20:32:28 localhost kernel: BUG: unable to handle kernel NULL pointer
dereference at virtual address 0000003c
Nov 18 20:32:28 localhost kernel:  printing eip:
Nov 18 20:32:28 localhost kernel: e1ce8e85
Nov 18 20:32:28 localhost kernel: *pde = 00000000
Nov 18 20:32:28 localhost kernel: Oops: 0000 [#1]
Nov 18 20:32:28 localhost kernel: SMP
Nov 18 20:32:28 localhost kernel: Modules linked in: dv1394 ohci1394 eth1394
nvidia rfcomm l2cap lirc_serial cx8800 cx88xx bttv video_buf ir_common
compat_ioctl32 btcx_risc lirc_i2c lirc_dev ipv6 dm_mod sd_mod hci_usb
bluetooth raw1394 msp3400 mousedev saa7127 tsdev saa7115 usb_storage
snd_intel8x0 tuner snd_ac97_codec snd_ac97_bus scsi_mod snd_pcm_oss ivtv
snd_mixer_oss firmware_class snd_pcm i2c_algo_bit snd_timer ide_cd cdrom
tveeprom videodev rtc sis_agp psmouse v4l1_compat v4l2_common ohci_hcd snd
evdev parport_pc parport i2c_sis96x 8250_pnp ns558 i2c_core serio_raw sis900
mii ehci_hcd agpgart shpchp pci_hotplug analog usbcore ieee1394 pcspkr
gameport soundcore snd_page_alloc ext3 jbd mbcache ide_disk ide_generic
via82cxxx trm290 triflex slc90e66 sis5513 siimage serverworks sc1200 rz1000
piix pdc202xx_old pdc202xx_new opti621 ns87415 it821x hpt366 hpt34x generic
cy82c693 cs5535 cs5530 cs5520 cmd64x atiixp amd74xx alim15x3 aec62xx
ide_core
Nov 18 20:32:28 localhost kernel: CPU:    0
Nov 18 20:32:28 localhost kernel: EIP:    0060:[<e1ce8e85>]    Tainted: PF
M  VLI
Nov 18 20:32:28 localhost kernel: EFLAGS: 00010246   (2.6.18.2 #1)
Nov 18 20:32:28 localhost kernel: EIP is at
rfcomm_tty_chars_in_buffer+0x6/0x19 [rfcomm]
Nov 18 20:32:28 localhost kernel: eax: 00000000   ebx: c4591000   ecx:
00000000   edx: dda3bc00
Nov 18 20:32:28 localhost kernel: esi: 00000000   edi: c6c54a40   ebp:
c459100c   esp: cd6bdc00
Nov 18 20:32:28 localhost kernel: ds: 007b   es: 007b   ss: 0068
Nov 18 20:32:28 localhost kernel: Process rfcomm (pid: 23351, ti=cd6bc000
task=ca605570 task.ti=cd6bc000)
Nov 18 20:32:28 localhost kernel: Stack: b01fb6e7 00124d5e c4591000 b01fb5f2
c6c54a40 b01f7943 00000000 00000000
Nov 18 20:32:28 localhost kernel:        00000000 cd6bdea0 c6c54a40 cd6bde98
b0167131 cd6bdfb0 afc02110 afc02118
Nov 18 20:32:28 localhost kernel:        00000000 cd6bde98 cd6bde98 cd6bde98
cd6bdea8 00000000 b0167bdf 00000000
Nov 18 20:32:28 localhost kernel: Call Trace:
Nov 18 20:32:28 localhost kernel:  [<b01fb6e7>] normal_poll+0xf5/0x11a
Nov 18 20:32:28 localhost kernel:  [<b01fb5f2>] normal_poll+0x0/0x11a
Nov 18 20:32:28 localhost kernel:  [<b01f7943>] tty_poll+0x48/0x60
Nov 18 20:32:28 localhost kernel:  [<b0167131>] do_sys_poll+0x1a7/0x341
Nov 18 20:32:28 localhost kernel:  [<b0167bdf>] __pollwait+0x0/0xb2
Nov 18 20:32:28 localhost kernel:  [<b0117295>]
default_wake_function+0x0/0xc
Nov 18 20:32:28 localhost kernel:  [<b0117295>]
default_wake_function+0x0/0xc
Nov 18 20:32:28 localhost kernel:  [<b016b0ed>] dput+0x1a/0x117
Nov 18 20:32:28 localhost kernel:  [<b016489e>] __link_path_walk+0xb95/0xcce
Nov 18 20:32:28 localhost kernel:  [<b0159351>]
__find_get_block_slow+0xfb/0x105
Nov 18 20:32:28 localhost kernel:  [<b014490d>]
blockable_page_cache_readahead+0x46/0x99
Nov 18 20:32:28 localhost kernel:  [<b016ad20>] __d_lookup+0x2f/0xd7
Nov 18 20:32:28 localhost kernel:  [<b011728b>] try_to_wake_up+0x355/0x35f
Nov 18 20:32:28 localhost kernel:  [<b01431e7>]
get_page_from_freelist+0x74/0x328
Nov 18 20:32:28 localhost kernel:  [<b0115d79>] __wake_up_common+0x2f/0x53
Nov 18 20:32:28 localhost kernel:  [<b016ad89>] __d_lookup+0x98/0xd7
Nov 18 20:32:28 localhost kernel:  [<b01629b2>] do_lookup+0x4f/0x135
Nov 18 20:32:28 localhost kernel:  [<b016b0ed>] dput+0x1a/0x117
Nov 18 20:32:28 localhost kernel:  [<b016489e>] __link_path_walk+0xb95/0xcce
Nov 18 20:32:28 localhost kernel:  [<b016e6df>] mntput_no_expire+0x11/0x68
Nov 18 20:32:28 localhost kernel:  [<b0164a7e>] link_path_walk+0xa7/0xb1
Nov 18 20:32:28 localhost kernel:  [<b01b774e>] memmove+0xe/0x22
Nov 18 20:32:28 localhost kernel:  [<b02019d2>] scrup+0x8c/0xb9
Nov 18 20:32:28 localhost kernel:  [<b011cde5>]
release_console_sem+0x17b/0x1b5
Nov 18 20:32:28 localhost kernel:  [<b02045de>] do_con_write+0x1462/0x1493
Nov 18 20:32:28 localhost kernel:  [<b01100ff>] __cpu_disable+0x1d/0xee
Nov 18 20:32:28 localhost kernel:  [<b01f9c91>] tty_open+0x179/0x2f0
Nov 18 20:32:28 localhost kernel:  [<b011cde5>]
release_console_sem+0x17b/0x1b5
Nov 18 20:32:28 localhost kernel:  [<b013f453>] find_get_page+0x18/0x38
Nov 18 20:32:28 localhost kernel:  [<b01419bf>] filemap_nopage+0x191/0x30a
Nov 18 20:32:28 localhost kernel:  [<b0149d94>]
__handle_mm_fault+0x3fa/0x72e
Nov 18 20:32:28 localhost kernel:  [<b01f692e>] tty_ldisc_deref+0x14/0x59
Nov 18 20:32:28 localhost kernel:  [<b0115026>] do_page_fault+0x184/0x460
Nov 18 20:32:28 localhost kernel:  [<b0167300>] sys_poll+0x35/0x38
Nov 18 20:32:28 localhost kernel:  [<b0102c73>] syscall_call+0x7/0xb
Nov 18 20:32:28 localhost kernel: Code: 88 84 01 00 00 8b 59 3c 8b 53 5c 85
d2 b8 01 00 00 00 0f 44 d0 8b 49 64 0f af 53 50 30 c0 29 ca 0f 49 c2 5b c3
8b 80 84 01 00 00 <8b> 50 3c 8d 42 0c 31 c9 39 42 0c 74 03 8b 4a 50 89 c8 c3
c3 c3
Nov 18 20:32:28 localhost kernel: EIP: [<e1ce8e85>]
rfcomm_tty_chars_in_buffer+0x6/0x19 [rfcomm] SS:ESP 0068:cd6bdc00
Nov 18 20:32:28 localhost sdpd[23342]: terminating...


- I use kernel version 2.6.18.2
- I use debian unstable
- bluez-utils version 3.7-1
- the communication between client and bluez uses 9600 Baud and standard
parameters

Any help would be highly appreciated!

Thanks,
Axel

------=_Part_30826_21979491.1163903250380
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>please help me! <br>I have the following problem with Bluez/RFcomm:<br>- I use a shell script that calls 'rfcomm listen rfcomm0 3' repeatedly to wait for a client to connect.<br>- Everything works fine, except that every once in a while (unfortunately pretty often, like twice a day), the linux kernel crashes with the following message in syslog:
<br><br>Nov 18 20:31:48 localhost hcid[23340]: link_key_request (sba=00:02:72:C5:88:A1, dba=00:12:37:8D:A3:D5)<br>Nov 18 20:32:28 localhost kernel: BUG: unable to handle kernel NULL pointer dereference at virtual address 0000003c
<br>Nov 18 20:32:28 localhost kernel:&nbsp; printing eip:<br>Nov 18 20:32:28 localhost kernel: e1ce8e85<br>Nov 18 20:32:28 localhost kernel: *pde = 00000000<br>Nov 18 20:32:28 localhost kernel: Oops: 0000 [#1]<br>Nov 18 20:32:28 localhost kernel: SMP 
<br>Nov 18 20:32:28 localhost kernel: Modules linked in: dv1394 ohci1394 eth1394 nvidia rfcomm l2cap lirc_serial cx8800 cx88xx bttv video_buf ir_common compat_ioctl32 btcx_risc lirc_i2c lirc_dev ipv6 dm_mod sd_mod hci_usb bluetooth raw1394 msp3400 mousedev saa7127 tsdev saa7115 usb_storage snd_intel8x0 tuner snd_ac97_codec snd_ac97_bus scsi_mod snd_pcm_oss ivtv snd_mixer_oss firmware_class snd_pcm i2c_algo_bit snd_timer ide_cd cdrom tveeprom videodev rtc sis_agp psmouse v4l1_compat v4l2_common ohci_hcd snd evdev parport_pc parport i2c_sis96x 8250_pnp ns558 i2c_core serio_raw sis900 mii ehci_hcd agpgart shpchp pci_hotplug analog usbcore ieee1394 pcspkr gameport soundcore snd_page_alloc ext3 jbd mbcache ide_disk ide_generic via82cxxx trm290 triflex slc90e66 sis5513 siimage serverworks sc1200 rz1000 piix pdc202xx_old pdc202xx_new opti621 ns87415 it821x hpt366 hpt34x generic cy82c693 cs5535 cs5530 cs5520 cmd64x atiixp amd74xx alim15x3 aec62xx ide_core
<br>Nov 18 20:32:28 localhost kernel: CPU:&nbsp;&nbsp;&nbsp; 0<br>Nov 18 20:32:28 localhost kernel: EIP:&nbsp;&nbsp;&nbsp; 0060:[&lt;e1ce8e85&gt;]&nbsp;&nbsp;&nbsp; Tainted: PF&nbsp; M&nbsp; VLI<br>Nov 18 20:32:28 localhost kernel: EFLAGS: 00010246&nbsp;&nbsp; (<a href="http://2.6.18.2">
2.6.18.2</a> #1) <br>Nov 18 20:32:28 localhost kernel: EIP is at rfcomm_tty_chars_in_buffer+0x6/0x19 [rfcomm]<br>Nov 18 20:32:28 localhost kernel: eax: 00000000&nbsp;&nbsp; ebx: c4591000&nbsp;&nbsp; ecx: 00000000&nbsp;&nbsp; edx: dda3bc00<br>Nov 18 20:32:28 localhost kernel: esi: 00000000&nbsp;&nbsp; edi: c6c54a40&nbsp;&nbsp; ebp: c459100c&nbsp;&nbsp; esp: cd6bdc00
<br>Nov 18 20:32:28 localhost kernel: ds: 007b&nbsp;&nbsp; es: 007b&nbsp;&nbsp; ss: 0068<br>Nov 18 20:32:28 localhost kernel: Process rfcomm (pid: 23351, ti=cd6bc000 task=ca605570 task.ti=cd6bc000)<br>Nov 18 20:32:28 localhost kernel: Stack: b01fb6e7 00124d5e c4591000 b01fb5f2 c6c54a40 b01f7943 00000000 00000000 
<br>Nov 18 20:32:28 localhost kernel:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000000 cd6bdea0 c6c54a40 cd6bde98 b0167131 cd6bdfb0 afc02110 afc02118 <br>Nov 18 20:32:28 localhost kernel:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000000 cd6bde98 cd6bde98 cd6bde98 cd6bdea8 00000000 b0167bdf 00000000 
<br>Nov 18 20:32:28 localhost kernel: Call Trace:<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b01fb6e7&gt;] normal_poll+0xf5/0x11a<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b01fb5f2&gt;] normal_poll+0x0/0x11a<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b01f7943&gt;] tty_poll+0x48/0x60
<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b0167131&gt;] do_sys_poll+0x1a7/0x341<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b0167bdf&gt;] __pollwait+0x0/0xb2<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b0117295&gt;] default_wake_function+0x0/0xc
<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b0117295&gt;] default_wake_function+0x0/0xc<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b016b0ed&gt;] dput+0x1a/0x117<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b016489e&gt;] __link_path_walk+0xb95/0xcce
<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b0159351&gt;] __find_get_block_slow+0xfb/0x105<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b014490d&gt;] blockable_page_cache_readahead+0x46/0x99<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b016ad20&gt;] __d_lookup+0x2f/0xd7
<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b011728b&gt;] try_to_wake_up+0x355/0x35f<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b01431e7&gt;] get_page_from_freelist+0x74/0x328<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b0115d79&gt;] __wake_up_common+0x2f/0x53
<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b016ad89&gt;] __d_lookup+0x98/0xd7<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b01629b2&gt;] do_lookup+0x4f/0x135<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b016b0ed&gt;] dput+0x1a/0x117
<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b016489e&gt;] __link_path_walk+0xb95/0xcce<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b016e6df&gt;] mntput_no_expire+0x11/0x68<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b0164a7e&gt;] link_path_walk+0xa7/0xb1
<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b01b774e&gt;] memmove+0xe/0x22<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b02019d2&gt;] scrup+0x8c/0xb9<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b011cde5&gt;] release_console_sem+0x17b/0x1b5
<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b02045de&gt;] do_con_write+0x1462/0x1493<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b01100ff&gt;] __cpu_disable+0x1d/0xee<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b01f9c91&gt;] tty_open+0x179/0x2f0
<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b011cde5&gt;] release_console_sem+0x17b/0x1b5<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b013f453&gt;] find_get_page+0x18/0x38<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b01419bf&gt;] filemap_nopage+0x191/0x30a
<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b0149d94&gt;] __handle_mm_fault+0x3fa/0x72e<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b01f692e&gt;] tty_ldisc_deref+0x14/0x59<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b0115026&gt;] do_page_fault+0x184/0x460
<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b0167300&gt;] sys_poll+0x35/0x38<br>Nov 18 20:32:28 localhost kernel:&nbsp; [&lt;b0102c73&gt;] syscall_call+0x7/0xb<br>Nov 18 20:32:28 localhost kernel: Code: 88 84 01 00 00 8b 59 3c 8b 53 5c 85 d2 b8 01 00 00 00 0f 44 d0 8b 49 64 0f af 53 50 30 c0 29 ca 0f 49 c2 5b c3 8b 80 84 01 00 00 &lt;8b&gt; 50 3c 8d 42 0c 31 c9 39 42 0c 74 03 8b 4a 50 89 c8 c3 c3 c3 
<br>Nov 18 20:32:28 localhost kernel: EIP: [&lt;e1ce8e85&gt;] rfcomm_tty_chars_in_buffer+0x6/0x19 [rfcomm] SS:ESP 0068:cd6bdc00<br>Nov 18 20:32:28 localhost sdpd[23342]: terminating...&nbsp;&nbsp; <br><br><br>- I use kernel version 
<a href="http://2.6.18.2">2.6.18.2</a><br>- I use debian unstable <br>- bluez-utils version 3.7-1<br>- the communication between client and bluez uses 9600 Baud and standard parameters<br><br>Any help would be highly appreciated! 
<br><br>Thanks,<br>Axel<br>

------=_Part_30826_21979491.1163903250380--


--===============1805838501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1805838501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1805838501==--
