Return-Path: <cyrus@holtmann.org>
Subject: BNEP fails in the new vanilla kernels
From: Stanislav Brabec <sbrabec@suse.cz>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="ISO-8859-2"
Date: Wed, 21 Jul 2010 15:02:44 +0200
Message-ID: <1279717364.5589.21.camel@hammer.site>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I just tried to connect to my PDA using "pand -c". Instead of
connection, I got following backtrace:

Tested in Linux hammer 2.6.35-rc5 from last week's
http://download.opensuse.org/repositories/Kernel:/HEAD/openSUSE_11.3/

It worked in 2.6.34.

[40323.569899] ------------[ cut here ]------------
[40323.569911] WARNING: at /usr/src/packages/BUILD/kernel-desktop-2.6.35/linux-2.6.34/fs/sysfs/dir.c:451 sysfs_add_one+0xc8/0x160()
[40323.569914] Hardware name: MS-6702
[40323.569916] sysfs: cannot create duplicate filename '/class/net/bnep0'
[40323.569918] Modules linked in: autofs4 nls_iso8859_1 nls_cp437 vfat fat joydev rt2870sta(C) crc_ccitt xt_physdev rfcomm sco bridge stp llc bnep l2cap snd_pcm_oss snd_mixer_oss snd_seq edd ip6t_LOG xt_tcpudp xt_pkttype ipt_LOG xt_limit nfs lockd fscache nfs_acl auth_rpcgss sunrpc af_packet mperf ip6t_REJECT nf_conntrack_ipv6 ip6table_raw xt_NOTRACK ipt_REJECT xt_state iptable_raw iptable_filter ip6table_mangle nf_conntrack_netbios_ns nf_conntrack_ipv4 nf_conntrack nf_defrag_ipv4 ip_tables ip6table_filter ip6_tables x_tables fuse loop dm_mod snd_via82xx gameport snd_ac97_codec ac97_bus firewire_ohci snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device firewire_core btusb ppdev floppy parport_pc usb_storage bluetooth crc_itu_t parport snd sr_mod r8169 pcspkr i2c_viapro amd64_edac_mod sg ohci1394 rfkill ieee1394 k8temp edac_core edac_mce_amd soundcore shpchp cdrom pci_hotplug ext4 jbd2 crc16 nouveau ttm drm_kms_helper drm sd_mod i2c_algo_bit button fan processor ata_generic sata_via sata_promise thermal thermal_sys pata_via libata scsi_mod
[40323.569994] Pid: 7035, comm: pand Tainted: G         C  2.6.35-rc5-10-desktop #1
[40323.569996] Call Trace:
[40323.570023]  [<ffffffff81005a69>] dump_trace+0x79/0x340
[40323.570031]  [<ffffffff814acb05>] dump_stack+0x69/0x6f
[40323.570040]  [<ffffffff8105671b>] warn_slowpath_common+0x7b/0xc0
[40323.570046]  [<ffffffff81056815>] warn_slowpath_fmt+0x45/0x50
[40323.570051]  [<ffffffff811b2a78>] sysfs_add_one+0xc8/0x160
[40323.570058]  [<ffffffff811b346b>] sysfs_do_create_link+0x11b/0x1b0
[40323.570066]  [<ffffffff813119d2>] device_add_class_symlinks+0x62/0xf0
[40323.570072]  [<ffffffff81312b08>] device_add+0x228/0x420
[40323.570079]  [<ffffffff813de48b>] netdev_register_kobject+0x8b/0x1a0
[40323.570087]  [<ffffffff813cc965>] register_netdevice+0x1c5/0x3b0
[40323.570096]  [<ffffffff813ccb86>] register_netdev+0x36/0x50
[40323.570105]  [<ffffffffa00f82c5>] bnep_add_connection+0x1a5/0x2c0 [bnep]
[40323.570123]  [<ffffffffa00f8994>] bnep_sock_ioctl+0x1f4/0x280 [bnep]
[40323.570132]  [<ffffffff813b5199>] sock_do_ioctl+0x29/0x60
[40323.570138]  [<ffffffff813b5320>] sock_ioctl+0x70/0x2b0
[40323.570144]  [<ffffffff81155eb9>] vfs_ioctl+0x39/0xc0
[40323.570149]  [<ffffffff81156450>] do_vfs_ioctl+0x70/0x390
[40323.570154]  [<ffffffff811567f0>] sys_ioctl+0x80/0xa0
[40323.570161]  [<ffffffff81002fbb>] system_call_fastpath+0x16/0x1b
[40323.570171]  [<00007fb2e6649e87>] 0x7fb2e6649e87
[40323.570174] ---[ end trace 3ca3c5fdcca93270 ]---

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12           tel: +420 284 028 966, +49 911 740538747
190 00 Praha 9                                  fax: +420 284 028 951
Czech Republic                                    http://www.suse.cz/


