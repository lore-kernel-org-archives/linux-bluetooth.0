Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <80236d750701310010g7d67bcc4qf1d9d3b1fe03e12f@mail.gmail.com>
Date: Wed, 31 Jan 2007 09:10:43 +0100
From: "Emanuele Novelli" <ema.novelli@gmail.com>
To: Bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] System crash using bluetooth
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0958022686=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0958022686==
Content-Type: multipart/alternative;
	boundary="----=_Part_28234_25000379.1170231043326"

------=_Part_28234_25000379.1170231043326
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

While doing more tests with multiple threads call to HCI lib functions I got
a system crash. Machine halts and need to reboot.
I was using 2 threads at once. first an inquiry then a search service and
search name with 2 usb hci device plugged. And after that I was trying an
rfcomm connection to the devices.

Kernel version 2.6.19-1.2895.FC6 - bluez libs 3.7.1.
this is an extract from messages.

I know maybe I'm doing something but this seems a bug inside bluez kernel
functions.
-----

Jan 30 16:05:05 Fedora-6-Develop kernel: add_conn: Failed to register
connection device
Jan 30 16:05:38 Fedora-6-Develop kernel: BUG: unable to handle kernel NULL
pointer dereference at virtual address 0000001c
Jan 30 16:05:38 Fedora-6-Develop kernel:  printing eip:
Jan 30 16:05:38 Fedora-6-Develop kernel: c061b254
Jan 30 16:05:38 Fedora-6-Develop kernel: *pde = 17e2f067
Jan 30 16:05:38 Fedora-6-Develop kernel: Oops: 0000 [#1]
Jan 30 16:05:38 Fedora-6-Develop kernel: SMP
Jan 30 16:05:38 Fedora-6-Develop kernel: last sysfs file:
/class/usb_device/usbdev1.7/dev
Jan 30 16:05:38 Fedora-6-Develop kernel: Modules linked in: via drm autofs4
hidp rfcomm l2cap sunrpc dm_multipath video sbs i2c_ec button battery ac
ipv6 lp floppy snd_via82xx gameport snd_ac97_codec snd_ac97_bus
snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss
snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi
via_rhine snd_seq_device mii snd soundcore i2c_viapro pcspkr k8temp i2c_core
hwmon ide_cd k8_edac edac_mc cdrom parport_pc hci_usb parport bluetooth
serio_raw dm_snapshot dm_zero dm_mirror dm_mod sata_via libata sd_mod
scsi_mod ext3 jbd ehci_hcd ohci_hcd uhci_hcd
Jan 30 16:05:38 Fedora-6-Develop kernel: CPU:    0
Jan 30 16:05:38 Fedora-6-Develop kernel: EIP:    0060:[<c061b254>]    Not
tainted VLI
Jan 30 16:05:38 Fedora-6-Develop kernel: EFLAGS: 00010282   (
2.6.19-1.2895.fc6 #1)
Jan 30 16:05:38 Fedora-6-Develop kernel: EIP is at klist_del+0x9/0x3b
Jan 30 16:05:38 Fedora-6-Develop kernel: eax: 00000000   ebx: 00000000
ecx: f7fef000   edx: 00000282
Jan 30 16:05:38 Fedora-6-Develop kernel: esi: dd4e24e8   edi: f7da21c0
ebp: dd21cddc   esp: f7feff44
Jan 30 16:05:38 Fedora-6-Develop kernel: ds: 007b   es: 007b   ss: 0068
Jan 30 16:05:38 Fedora-6-Develop kernel: Process events/0 (pid: 5,
ti=f7fef000 task=f7d00030 task.ti=f7fef000)
Jan 30 16:05:38 Fedora-6-Develop kernel: Stack: dd4e2498 dd4e24c8 f7da21c0
c0554802 dd4e2498 dd4e249c f7da21c0 00000282
Jan 30 16:05:38 Fedora-6-Develop kernel:        c043271b 00000282 f7da21c0
f7da21e0 f890e244 dd4e2400 f7da21e0 f7da21c0
Jan 30 16:05:38 Fedora-6-Develop kernel:        f7da21d8 00000000 c04330e0
00000001 00000000 00000000 00010000 00000000
Jan 30 16:05:38 Fedora-6-Develop kernel: Call Trace:
Jan 30 16:05:38 Fedora-6-Develop kernel:  [<c0554802>] device_del+0x18/0x19a
Jan 30 16:05:38 Fedora-6-Develop kernel:  [<c043271b>]
run_workqueue+0x97/0xdd
Jan 30 16:05:38 Fedora-6-Develop kernel:  [<c04330e0>]
worker_thread+0xd9/0x10d
Jan 30 16:05:38 Fedora-6-Develop kernel:  [<c0435660>] kthread+0xc0/0xec
Jan 30 16:05:38 Fedora-6-Develop kernel:  [<c0405257>]
kernel_thread_helper+0x7/0x10
Jan 30 16:05:38 Fedora-6-Develop kernel:  =======================
Jan 30 16:05:38 Fedora-6-Develop kernel: Code: 8b 04 24 89 46 08 8b 06 e8 87
22 00 00 85 ed 74 08 85 ff 74 04 89 f8 ff d5 8b 04 24 5a 5b 5e 5f 5d c3 57
56 89 c6 53 8b 18 89 d8 <8b> 7b 1c e8 8e 22 00 00 89 f0 e8 6e ff ff ff 85 c0
74 11 89 d8
Jan 30 16:05:38 Fedora-6-Develop kernel: EIP: [<c061b254>]
klist_del+0x9/0x3b SS:ESP 0068:f7feff44
Jan 30 16:06:09 Fedora-6-Develop kernel:  <3>hci_cmd_task: hci0 command tx
timeout
Jan 30 16:06:41 Fedora-6-Develop kernel: hci_cmd_task: hci0 command tx
timeout

------=_Part_28234_25000379.1170231043326
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

While doing more tests with multiple threads call to HCI lib functions I got a system crash. Machine halts and need to reboot.<br>I was using 2 threads at once. first an inquiry then a search service and search name with 2 usb hci device plugged. And after that I was trying an rfcomm connection to the devices.
<br><br>Kernel version 2.6.19-1.2895.FC6 - bluez libs 3.7.1. <br>this is an extract from messages.<br><br>I know maybe I&#39;m doing something but this seems a bug inside bluez kernel functions.<br>-----<br><br>Jan 30 16:05:05 Fedora-6-Develop kernel: add_conn: Failed to register connection device
<br>Jan 30 16:05:38 Fedora-6-Develop kernel: BUG: unable to handle kernel NULL pointer dereference at virtual address 0000001c<br>Jan 30 16:05:38 Fedora-6-Develop kernel:&nbsp; printing eip:<br>Jan 30 16:05:38 Fedora-6-Develop kernel: c061b254
<br>Jan 30 16:05:38 Fedora-6-Develop kernel: *pde = 17e2f067<br>Jan 30 16:05:38 Fedora-6-Develop kernel: Oops: 0000 [#1]<br>Jan 30 16:05:38 Fedora-6-Develop kernel: SMP <br>Jan 30 16:05:38 Fedora-6-Develop kernel: last sysfs file: /class/usb_device/usbdev1.7/dev
<br>Jan 30 16:05:38 Fedora-6-Develop kernel: Modules linked in: via drm autofs4 hidp rfcomm l2cap sunrpc dm_multipath video sbs i2c_ec button battery ac ipv6 lp floppy snd_via82xx gameport snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi via_rhine snd_seq_device mii snd soundcore i2c_viapro pcspkr k8temp i2c_core hwmon ide_cd k8_edac edac_mc cdrom parport_pc hci_usb parport bluetooth serio_raw dm_snapshot dm_zero dm_mirror dm_mod sata_via libata sd_mod scsi_mod ext3 jbd ehci_hcd ohci_hcd uhci_hcd
<br>Jan 30 16:05:38 Fedora-6-Develop kernel: CPU:&nbsp;&nbsp;&nbsp; 0<br>Jan 30 16:05:38 Fedora-6-Develop kernel: EIP:&nbsp;&nbsp;&nbsp; 0060:[&lt;c061b254&gt;]&nbsp;&nbsp;&nbsp; Not tainted VLI<br>Jan 30 16:05:38 Fedora-6-Develop kernel: EFLAGS: 00010282&nbsp;&nbsp; (2.6.19-1.2895.fc6
 #1)<br>Jan 30 16:05:38 Fedora-6-Develop kernel: EIP is at klist_del+0x9/0x3b<br>Jan 30 16:05:38 Fedora-6-Develop kernel: eax: 00000000&nbsp;&nbsp; ebx: 00000000&nbsp;&nbsp; ecx: f7fef000&nbsp;&nbsp; edx: 00000282<br>Jan 30 16:05:38 Fedora-6-Develop kernel: esi: dd4e24e8&nbsp;&nbsp; edi: f7da21c0&nbsp;&nbsp; ebp: dd21cddc&nbsp;&nbsp; esp: f7feff44
<br>Jan 30 16:05:38 Fedora-6-Develop kernel: ds: 007b&nbsp;&nbsp; es: 007b&nbsp;&nbsp; ss: 0068<br>Jan 30 16:05:38 Fedora-6-Develop kernel: Process events/0 (pid: 5, ti=f7fef000 task=f7d00030 task.ti=f7fef000)<br>Jan 30 16:05:38 Fedora-6-Develop kernel: Stack: dd4e2498 dd4e24c8 f7da21c0 c0554802 dd4e2498 dd4e249c f7da21c0 00000282 
<br>Jan 30 16:05:38 Fedora-6-Develop kernel:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c043271b 00000282 f7da21c0 f7da21e0 f890e244 dd4e2400 f7da21e0 f7da21c0 <br>Jan 30 16:05:38 Fedora-6-Develop kernel:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f7da21d8 00000000 c04330e0 00000001 00000000 00000000 00010000 00000000 
<br>Jan 30 16:05:38 Fedora-6-Develop kernel: Call Trace:<br>Jan 30 16:05:38 Fedora-6-Develop kernel:&nbsp; [&lt;c0554802&gt;] device_del+0x18/0x19a<br>Jan 30 16:05:38 Fedora-6-Develop kernel:&nbsp; [&lt;c043271b&gt;] run_workqueue+0x97/0xdd
<br>Jan 30 16:05:38 Fedora-6-Develop kernel:&nbsp; [&lt;c04330e0&gt;] worker_thread+0xd9/0x10d<br>Jan 30 16:05:38 Fedora-6-Develop kernel:&nbsp; [&lt;c0435660&gt;] kthread+0xc0/0xec<br>Jan 30 16:05:38 Fedora-6-Develop kernel:&nbsp; [&lt;c0405257&gt;] kernel_thread_helper+0x7/0x10
<br>Jan 30 16:05:38 Fedora-6-Develop kernel:&nbsp; =======================<br>Jan 30 16:05:38 Fedora-6-Develop kernel: Code: 8b 04 24 89 46 08 8b 06 e8 87 22 00 00 85 ed 74 08 85 ff 74 04 89 f8 ff d5 8b 04 24 5a 5b 5e 5f 5d c3 57 56 89 c6 53 8b 18 89 d8 &lt;8b&gt; 7b 1c e8 8e 22 00 00 89 f0 e8 6e ff ff ff 85 c0 74 11 89 d8 
<br>Jan 30 16:05:38 Fedora-6-Develop kernel: EIP: [&lt;c061b254&gt;] klist_del+0x9/0x3b SS:ESP 0068:f7feff44<br>Jan 30 16:06:09 Fedora-6-Develop kernel:&nbsp; &lt;3&gt;hci_cmd_task: hci0 command tx timeout<br>Jan 30 16:06:41 Fedora-6-Develop kernel: hci_cmd_task: hci0 command tx timeout

------=_Part_28234_25000379.1170231043326--


--===============0958022686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0958022686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0958022686==--
