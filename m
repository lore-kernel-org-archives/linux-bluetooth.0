Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Feb 2008 18:36:11 +0800
From: Dave Young <hidave.darkstar@gmail.com>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	marcel@holtmann.org, bluez-devel@lists.sourceforge.net
Subject: Re: [BUG] rfcomm
Message-ID: <20080220103611.GA4027@darkstar.te-china.tietoenator.com>
References: <200710231950.31313.alon.barlev@gmail.com> <a8e1da0802141928yabfd87ajfed0b009e1e79018@mail.gmail.com> <a8e1da0802151513p34ad118i54ddd8f00e6e136@mail.gmail.com> <200802162349.59780.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200802162349.59780.alon.barlev@gmail.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Sat, Feb 16, 2008 at 11:49:58PM +0200, Alon Bar-Lev wrote:
> On Saturday 16 February 2008, Dave Young wrote:
> > Hi, alon
> >=20
> > Please try the attached patch, hope it fixes your problem.
> >=20
> > Regards
> > dave
>=20
> Does not work... :(
>=20
> Alon.
>=20
> Feb 16 23:41:33 alon1 usb 3-1: configuration #1 chosen from 1 choice
> Feb 16 23:41:33 alon1 BUG: unable to handle kernel NULL pointer dereferen=
ce at virtual address 00000008
> Feb 16 23:41:33 alon1 printing eip: c01b2db6 *pde =3D 00000000=20
> Feb 16 23:41:33 alon1 Oops: 0000 [#1] PREEMPT=20
> Feb 16 23:41:33 alon1 Modules linked in: ppp_deflate zlib_deflate zlib_in=
flate bsd_comp ppp_async rfcomm l2cap hci_usb vmnet(P) vmmon(P) tun radeon =
drm autofs4 ipv6 aes_generic crypto_algapi ieee80211_crypt_ccmp nf_nat_irc =
nf_nat_ftp nf_conntrack_irc nf_conntrack_ftp ipt_MASQUERADE iptable_nat nf_=
nat ipt_REJECT xt_tcpudp ipt_LOG xt_limit xt_state nf_conntrack_ipv4 nf_con=
ntrack iptable_filter ip_tables x_tables snd_pcm_oss snd_mixer_oss snd_seq_=
dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device bluetooth ppp_g=
eneric slhc ioatdma dca cfq_iosched cpufreq_powersave cpufreq_ondemand cpuf=
req_conservative acpi_cpufreq freq_table uinput fan af_packet nls_cp1255 nl=
s_iso8859_1 nls_utf8 nls_base pcmcia snd_intel8x0 snd_ac97_codec ac97_bus s=
nd_pcm nsc_ircc snd_timer ipw2200 thinkpad_acpi irda snd ehci_hcd yenta_soc=
ket uhci_hcd psmouse ieee80211 soundcore intel_agp hwmon rsrc_nonstatic pcs=
pkr e1000 crc_ccitt snd_page_alloc i2c_i801 ieee80211_crypt pcmcia_core agp=
gart thermal battery nvram rtc sr_mod ac sg firmware_class button processor=
 cdrom unix usbcore evdev ext3 jbd ext2 mbcache loop ata_piix libata sd_mod=
 scsi_mod
> Feb 16 23:41:33 alon1=20
> Feb 16 23:41:33 alon1 Pid: 4, comm: events/0 Tainted: P        (2.6.24-ge=
ntoo-r2 #1)
> Feb 16 23:41:33 alon1 EIP: 0060:[<c01b2db6>] EFLAGS: 00010282 CPU: 0
> Feb 16 23:41:33 alon1 EIP is at sysfs_get_dentry+0x26/0x80
> Feb 16 23:41:33 alon1 EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: f48a=
2210
> Feb 16 23:41:33 alon1 ESI: f72eb900 EDI: f4803ae0 EBP: f4803ae0 ESP: f7c4=
9efc
> Feb 16 23:41:33 alon1 hcid[7004]: HCI dev 0 registered
> Feb 16 23:41:33 alon1 DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
> Feb 16 23:41:33 alon1 Process events/0 (pid: 4, ti=3Df7c48000 task=3Df7c3=
efc0 task.ti=3Df7c48000)
> Feb 16 23:41:33 alon1 Stack: f7cb6140 f4822668 f7e71e10 c01b304d ffffffff=
 ffffffff fffffffe c030ba9c=20
> Feb 16 23:41:33 alon1 f7cb6140 f4822668 f6da6720 f7cb6140 f4822668 f6da67=
20 c030ba8e c01ce20b=20
> Feb 16 23:41:33 alon1 f6e9dd00 c030ba8e f6da6720 f6e9dd00 f6e9dd00 000000=
00 f4822600 00000000=20
> Feb 16 23:41:33 alon1 Call Trace:
> Feb 16 23:41:33 alon1 [<c01b304d>] sysfs_move_dir+0x3d/0x1f0
> Feb 16 23:41:33 alon1 [<c01ce20b>] kobject_move+0x9b/0x120
> Feb 16 23:41:33 alon1 [<c0241711>] device_move+0x51/0x110
> Feb 16 23:41:33 alon1 [<f9aaed80>] del_conn+0x0/0x70 [bluetooth]
> Feb 16 23:41:33 alon1 [<f9aaed99>] del_conn+0x19/0x70 [bluetooth]
> Feb 16 23:41:33 alon1 [<c012c1a1>] run_workqueue+0x81/0x140
> Feb 16 23:41:33 alon1 [<c02c0c88>] schedule+0x168/0x2e0
> Feb 16 23:41:33 alon1 [<c012fc70>] autoremove_wake_function+0x0/0x50
> Feb 16 23:41:33 alon1 [<c012c9cb>] worker_thread+0x9b/0xf0
> Feb 16 23:41:33 alon1 [<c012fc70>] autoremove_wake_function+0x0/0x50
> Feb 16 23:41:33 alon1 [<c012c930>] worker_thread+0x0/0xf0
> Feb 16 23:41:33 alon1 [<c012f962>] kthread+0x42/0x70
> Feb 16 23:41:33 alon1 [<c012f920>] kthread+0x0/0x70
> Feb 16 23:41:33 alon1 [<c0104c2f>] kernel_thread_helper+0x7/0x18
> Feb 16 23:41:33 alon1 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> Feb 16 23:41:33 alon1 Code: 26 00 00 00 00 57 89 c7 a1 50 1b 3a c0 56 53 =
8b 70 38 85 f6 74 08 8b 0e 85 c9 74 58 ff 06 8b 56 50 39 fa 74 47 89 fb eb =
02 89 c3 <8b> 43 08 39 c2 75 f7 8b 46 08 83 c0 68 e8 98 e7 10 00 8b 43 10=
=20
> Feb 16 23:41:33 alon1 EIP: [<c01b2db6>] sysfs_get_dentry+0x26/0x80 SS:ESP=
 0068:f7c49efc
> Feb 16 23:41:33 alon1 ---[ end trace aae864e9592acc1d ]---
> Feb 16 23:41:33 alon1 hcid[7004]: HCI dev 0 up
> Feb 16 23:41:33 alon1 hcid[7004]: Device hci0 has been added
> Feb 16 23:41:33 alon1 hcid[7004]: Starting security manager 0

Could you try patch below?


Defer hci_unregister_sysfs because hci device could be destructed
while hci conn devices still there.

Signed-off-by: Dave Young <hidave.darkstar@gmail.com>

---
net/bluetooth/hci_core.c |    4 ++--
1 file changed, 2 insertions(+), 2 deletions(-)

diff -upr linux/net/bluetooth/hci_core.c linux.new/net/bluetooth/hci_core.c
--- linux/net/bluetooth/hci_core.c	2008-02-20 18:27:28.000000000 +0800
+++ linux.new/net/bluetooth/hci_core.c	2008-02-20 18:28:34.000000000 +0800
@@ -901,8 +901,6 @@ int hci_unregister_dev(struct hci_dev *h
=20
 	BT_DBG("%p name %s type %d", hdev, hdev->name, hdev->type);
=20
-	hci_unregister_sysfs(hdev);
-
 	write_lock_bh(&hci_dev_list_lock);
 	list_del(&hdev->list);
 	write_unlock_bh(&hci_dev_list_lock);
@@ -914,6 +912,8 @@ int hci_unregister_dev(struct hci_dev *h
=20
 	hci_notify(hdev, HCI_DEV_UNREG);
=20
+	hci_unregister_sysfs(hdev);
+
 	__hci_dev_put(hdev);
=20
 	return 0;
