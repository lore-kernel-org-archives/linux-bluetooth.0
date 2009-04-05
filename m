Return-Path: <cyrus@holtmann.org>
Message-ID: <49D8E48A.2060807@pook.es>
Date: Sun, 05 Apr 2009 19:04:10 +0200
From: Stuart Pook <linux-bluetooth4@pook.es>
MIME-Version: 1.0
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez 4.34 + Linksys USBBT100 + hcitool scan -> core dump
References: <49D89DCD.7090808@pook.es>
In-Reply-To: <49D89DCD.7090808@pook.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

here I am replying to myself

On 05/04/09 14:02, Stuart Pook wrote:
> I tried it again with bluez 4.34 and now a simple 
> "hcitool scan" makes bluetoothd core dump.

I have just noticed that I've been getting kernel errors with all this plugging and unplugging of Bluetooth adapters.

The first one happened after I sent my email so it perhaps not the cause of the bluetoothd core dumps. All the other kernel errors have the same message ('hci0:6' can not be created).

Apr  5 12:14:39 kooka kernel: [1171487.385852] ------------[ cut here ]------------
Apr  5 12:14:39 kooka kernel: [1171487.385855] WARNING: at fs/sysfs/dir.c:462 sysfs_add_one+0x27/0x2f()
Apr  5 12:14:39 kooka kernel: [1171487.385857] sysfs: duplicate filename 'hci0:6' can not be created
Apr  5 12:14:39 kooka kernel: [1171487.385858] Modules linked in: battery hfs hfsplus udf crc_itu_t usblp snd_seq_dummy snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq rfcomm nls_iso8859_1 sco l2cap tun binfmt_misc kvm_intel kvm bridge stp ip6t_LOG nf_conntrack_ipv6 ipt_REJECT xt_limit nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack xt_comment ts_bm xt_string xt_length xt_tcpudp xt_physdev ipt_LOG ip6table_filter ip6_tables iptable_filter ip_tables x_tables ipv6 ext4 jbd2 crc16 nls_utf8 nls_cp437 vfat fat isofs nls_base zlib_inflate sha256_generic aes_i586 aes_generic cbc dm_crypt coretemp it87 hwmon_vid hid_dell hid_pl hid_cypress hid_zpff hid_gyration hid_bright hid_sony hid_samsung hid_microsoft hid_tmff hid_monterey hid_ezkey hid_apple hid_a4tech hid_logitech ff_memless snd_hda_intel snd_usb_audio hid_cherry snd_usb_lib i2c_i801 snd_mixer_oss hid_sunplus snd_rawmidi evdev serio_raw pcspkr i2c_core snd_pcm iTCO_wdt hid_petalynx snd_seq_device snd_timer hid_belki
n parport_pc usbhid snd_page_alloc snd_hwdep snd soundcore hid_chicony btusb bluetooth hid intel_agp agpgart button parport usb_storage ext3 jbd mbcache dm_mirror dm_region_hash dm_log dm_snapshot dm_mod ide_cd_mod cdrom sd_mod crc_t10dif ide_gd_mod ata_generic ide_pci_generic ahci uhci_hcd pdc202xx_new jmicron r8169 mii libata ide_core scsi_mod ehci_hcd usbcore thermal processor fan thermal_sys
Apr  5 12:14:39 kooka kernel: [1171487.385961] Pid: 1738, comm: btaddconn Tainted: G        W  2.6.28-1-686 #1
Apr  5 12:14:39 kooka kernel: [1171487.385963] Call Trace:
Apr  5 12:14:39 kooka kernel: [1171487.385967]  [<c0126d7a>] warn_slowpath+0x5a/0x79
Apr  5 12:14:39 kooka kernel: [1171487.385970]  [<c011de3f>] enqueue_entity+0x6b/0x112
Apr  5 12:14:39 kooka kernel: [1171487.385974]  [<c01f8c0e>] idr_get_empty_slot+0x145/0x202
Apr  5 12:14:39 kooka kernel: [1171487.385976]  [<c01f8d9f>] ida_get_new_above+0xd4/0x178
Apr  5 12:14:39 kooka kernel: [1171487.385980]  [<c01953d6>] find_inode+0x1b/0x56
Apr  5 12:14:39 kooka kernel: [1171487.385982]  [<c01c25c4>] sysfs_ilookup_test+0x0/0xd
Apr  5 12:14:39 kooka kernel: [1171487.385985]  [<c01954d5>] ifind+0x3a/0x73
Apr  5 12:14:39 kooka kernel: [1171487.385987]  [<c01c2777>] sysfs_find_dirent+0x13/0x23
Apr  5 12:14:39 kooka kernel: [1171487.385990]  [<c01c28f3>] sysfs_add_one+0x27/0x2f
Apr  5 12:14:39 kooka kernel: [1171487.385992]  [<c01c2d73>] create_dir+0x3c/0x6c
Apr  5 12:14:39 kooka kernel: [1171487.386010]  [<f90f9585>] add_conn+0x0/0x2f [bluetooth]
Apr  5 12:14:39 kooka kernel: [1171487.386013]  [<c01c2dcc>] sysfs_create_dir+0x29/0x3b
Apr  5 12:14:39 kooka kernel: [1171487.386016]  [<c01f95b2>] kobject_get+0xf/0x13
Apr  5 12:14:39 kooka kernel: [1171487.386019]  [<c01f96c4>] kobject_add_internal+0xb6/0x14f
Apr  5 12:14:39 kooka kernel: [1171487.386033]  [<f90f9585>] add_conn+0x0/0x2f [bluetooth]
Apr  5 12:14:39 kooka kernel: [1171487.386035]  [<c01f986e>] kobject_add+0x44/0x47
Apr  5 12:14:39 kooka kernel: [1171487.386038]  [<c0259d54>] device_add+0x7b/0x455
Apr  5 12:14:39 kooka kernel: [1171487.386041]  [<c01f860c>] __next_cpu+0x12/0x21
Apr  5 12:14:39 kooka kernel: [1171487.386054]  [<f90f9585>] add_conn+0x0/0x2f [bluetooth]
Apr  5 12:14:39 kooka kernel: [1171487.386068]  [<f90f959c>] add_conn+0x17/0x2f [bluetooth]
Apr  5 12:14:39 kooka kernel: [1171487.386071]  [<c0133f6b>] run_workqueue+0x89/0x10e
Apr  5 12:14:39 kooka kernel: [1171487.386073]  [<c01340a6>] worker_thread+0xb6/0xc2
Apr  5 12:14:39 kooka kernel: [1171487.386077]  [<c0136cce>] autoremove_wake_function+0x0/0x2d
Apr  5 12:14:39 kooka kernel: [1171487.386079]  [<c0133ff0>] worker_thread+0x0/0xc2
Apr  5 12:14:39 kooka kernel: [1171487.386081]  [<c0136a0f>] kthread+0x38/0x5d
Apr  5 12:14:39 kooka kernel: [1171487.386084]  [<c01369d7>] kthread+0x0/0x5d
Apr  5 12:14:39 kooka kernel: [1171487.386087]  [<c0104773>] kernel_thread_helper+0x7/0x10
Apr  5 12:14:39 kooka kernel: [1171487.386089] ---[ end trace 1bc6cd22ec210d33 ]---
Apr  5 12:14:39 kooka kernel: [1171487.386091] kobject_add_internal failed for hci0:6 with -EEXIST, don't try to register things with the same name in the same directory.
Apr  5 12:14:39 kooka kernel: [1171487.386094] Pid: 1738, comm: btaddconn Tainted: G        W  2.6.28-1-686 #1
Apr  5 12:14:39 kooka kernel: [1171487.386096] Call Trace:
Apr  5 12:14:39 kooka kernel: [1171487.386098]  [<c01f974d>] kobject_add_internal+0x13f/0x14f
Apr  5 12:14:39 kooka kernel: [1171487.386112]  [<f90f9585>] add_conn+0x0/0x2f [bluetooth]
Apr  5 12:14:39 kooka kernel: [1171487.386115]  [<c01f986e>] kobject_add+0x44/0x47
Apr  5 12:14:39 kooka kernel: [1171487.386117]  [<c0259d54>] device_add+0x7b/0x455
Apr  5 12:14:39 kooka kernel: [1171487.386130]  [<c01f860c>] __next_cpu+0x12/0x21
Apr  5 12:14:39 kooka kernel: [1171487.386142]  [<f90f9585>] add_conn+0x0/0x2f [bluetooth]
Apr  5 12:14:39 kooka kernel: [1171487.386154]  [<f90f959c>] add_conn+0x17/0x2f [bluetooth]
Apr  5 12:14:39 kooka kernel: [1171487.386157]  [<c0133f6b>] run_workqueue+0x89/0x10e
Apr  5 12:14:39 kooka kernel: [1171487.386159]  [<c01340a6>] worker_thread+0xb6/0xc2
Apr  5 12:14:39 kooka kernel: [1171487.386162]  [<c0136cce>] autoremove_wake_function+0x0/0x2d
Apr  5 12:14:39 kooka kernel: [1171487.386165]  [<c0133ff0>] worker_thread+0x0/0xc2
Apr  5 12:14:39 kooka kernel: [1171487.386167]  [<c0136a0f>] kthread+0x38/0x5d
Apr  5 12:14:39 kooka kernel: [1171487.386170]  [<c01369d7>] kthread+0x0/0x5d
Apr  5 12:14:39 kooka kernel: [1171487.386172]  [<c0104773>] kernel_thread_helper+0x7/0x10
Apr  5 12:14:39 kooka kernel: [1171487.386174] add_conn: Failed to register connection device

-- 
If the From address bounces, please see http://www.pook.it/.
