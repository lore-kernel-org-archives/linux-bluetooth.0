Return-Path: <cyrus@holtmann.org>
Message-ID: <4A711294.5010901@xyzw.org>
Date: Wed, 29 Jul 2009 20:25:08 -0700
From: Brian Rogers <brian@xyzw.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>,
 David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Wait for child devices to go away before deleting a connection
References: <4A6424D8.3040306@xyzw.org> <1248077430.4549.97.camel@violet>	 <4A6864DE.5010501@xyzw.org> <1248901964.28545.242.camel@violet>	 <4A70CF45.1060706@xyzw.org> <1248921191.28545.251.camel@violet>
In-Reply-To: <1248921191.28545.251.camel@violet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel Holtmann wrote:
> Hi Brian,
>
>   
>>>>> Kay, David, wouldn't be pinning of the parent device here be enough to
>>>>> get this done in a clean way?
>>>>>   
>>>>>       
>>>>>           
>>>> If there's a way that the connection can be pinned until the child 
>>>> devices go away, that definitely sounds cleaner to me.
>>>>     
>>>>         
>>> so I pushed some patches to bluetooth-testing tree that should fix this
>>> problem. They are not fully tested by me. Please test and report back
>>> the results.
>>>   
>>>       
>> Fails to compile if CONFIG_USB_HIDDEV=y :
>>
>> ERROR: "hiddev_disconnect" [net/bluetooth/hidp/hidp.ko] undefined!
>>
>> Ironically, the reference to hiddev_disconnect is fine if hiddev isn't 
>> enabled because then hiddev.h supplies an empty static inline function.
>>
>> I'm going to test with a kernel without hiddev for now.
>>     
>
> just take that piece out of the patch. It is not important. I just wanna
> now if the uevents are now coming in order.
>   

I just tried it without hiddev and observed that the input devices go 
away, but the connection never gets deleted. Then when I turn my mouse 
back on, bad stuff happens:

[  281.027907] WARNING: at fs/sysfs/dir.c:487 sysfs_add_one+0x82/0x95()
[  281.027913] Hardware name: 
N/A                                           
[  281.027918] sysfs: cannot create duplicate filename 
'/devices/pci0000:00/0000:00:1a.1/usb2/2-1/2-1:1.0/bluetooth/hci0/hci0:11'
[  281.027924] Modules linked in: hidp hid aes_x86_64 aes_generic 
ecryptfs cpufreq_ondemand af_packet binfmt_misc ipt_MASQUERADE 
iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_state 
nf_conntrack ipt_REJECT xt_tcpudp iptable_filter ip_tables x_tables 
rfcomm bridge stp llc bnep sco l2cap kvm_intel kvm ipv6 container sbs 
sbshc microcode acpi_cpufreq freq_table uinput sbp2 snd_hda_codec_si3054 
snd_hda_codec_realtek snd_hda_intel snd_hda_codec joydev snd_hwdep arc4 
snd_pcm btusb ecb bluetooth snd_seq_midi iwl3945 snd_rawmidi iwlcore 
snd_seq_midi_event snd_seq snd_timer sr_mod mac80211 cdrom 
snd_seq_device led_class ata_generic ohci1394 tg3 pata_acpi cfg80211 
ehci_hcd uhci_hcd libphy snd ieee1394 ac ata_piix evdev usbcore rfkill 
soundcore sg psmouse wmi snd_page_alloc battery button pcspkr processor 
serio_raw sd_mod thermal fan fuse dm_mirror dm_region_hash dm_log dm_mod 
ahci libata scsi_mod ext4 mbcache jbd2 crc16
[  281.028108] Pid: 1765, comm: bluetooth Not tainted 2.6.31-rc4-red #4
[  281.028113] Call Trace:
[  281.028125]  [<ffffffff8103526b>] ? warn_slowpath_common+0x76/0x8c
[  281.028134]  [<ffffffff810352d3>] ? warn_slowpath_fmt+0x40/0x45
[  281.028142]  [<ffffffff810e5169>] ? sysfs_add_one+0x82/0x95
[  281.028150]  [<ffffffff810e5730>] ? create_dir+0x4f/0x89
[  281.028178]  [<ffffffffa02e075e>] ? add_conn+0x0/0xca [bluetooth]
[  281.028186]  [<ffffffff810e579f>] ? sysfs_create_dir+0x35/0x46
[  281.028195]  [<ffffffff811243d9>] ? kobject_get+0x12/0x17
[  281.028203]  [<ffffffff81124526>] ? kobject_add_internal+0xcd/0x186
[  281.028226]  [<ffffffffa02e075e>] ? add_conn+0x0/0xca [bluetooth]
[  281.028235]  [<ffffffff8112476f>] ? kobject_add+0x66/0x6b
[  281.028244]  [<ffffffff811c9f85>] ? device_add+0xcd/0x4ec
[  281.028296]  [<ffffffffa02e075e>] ? add_conn+0x0/0xca [bluetooth]
[  281.028318]  [<ffffffffa02e0793>] ? add_conn+0x35/0xca [bluetooth]
[  281.028329]  [<ffffffff81043e40>] ? worker_thread+0x146/0x1ea
[  281.028338]  [<ffffffff810476a3>] ? autoremove_wake_function+0x0/0x2a
[  281.028346]  [<ffffffff81043cfa>] ? worker_thread+0x0/0x1ea
[  281.028354]  [<ffffffff810473ba>] ? kthread+0x80/0x88
[  281.028365]  [<ffffffff8100c96a>] ? child_rip+0xa/0x20
[  281.028373]  [<ffffffff8104733a>] ? kthread+0x0/0x88
[  281.028381]  [<ffffffff8100c960>] ? child_rip+0x0/0x20
[  281.028387] ---[ end trace de74c554ac3186bd ]---
[  281.028396] kobject_add_internal failed for hci0:11 with -EEXIST, 
don't try to register things with the same name in the same directory.
[  281.028572] Pid: 1765, comm: bluetooth Tainted: G        W  
2.6.31-rc4-red #4
[  281.028577] Call Trace:
[  281.028585]  [<ffffffff811245b5>] ? kobject_add_internal+0x15c/0x186
[  281.028608]  [<ffffffffa02e075e>] ? add_conn+0x0/0xca [bluetooth]
[  281.028616]  [<ffffffff8112476f>] ? kobject_add+0x66/0x6b
[  281.028624]  [<ffffffff811c9f85>] ? device_add+0xcd/0x4ec
[  281.028646]  [<ffffffffa02e075e>] ? add_conn+0x0/0xca [bluetooth]
[  281.028667]  [<ffffffffa02e0793>] ? add_conn+0x35/0xca [bluetooth]
[  281.028676]  [<ffffffff81043e40>] ? worker_thread+0x146/0x1ea
[  281.028684]  [<ffffffff810476a3>] ? autoremove_wake_function+0x0/0x2a
[  281.028693]  [<ffffffff81043cfa>] ? worker_thread+0x0/0x1ea
[  281.028700]  [<ffffffff810473ba>] ? kthread+0x80/0x88
[  281.028709]  [<ffffffff8100c96a>] ? child_rip+0xa/0x20
[  281.028717]  [<ffffffff8104733a>] ? kthread+0x0/0x88
[  281.028724]  [<ffffffff8100c960>] ? child_rip+0x0/0x20
[  281.028730] add_conn: Failed to register connection device
[  281.136405] BUG: unable to handle kernel NULL pointer dereference at 
0000000000000038
[  281.136545] IP: [<ffffffff810e51a0>] sysfs_addrm_start+0x24/0xa0
[  281.136648] PGD 0
[  281.136692] Oops: 0000 [#1] PREEMPT SMP
[  281.136781] last sysfs file: 
/sys/devices/LNXSYSTM:00/device:00/PNP0A08:00/device:22/ACPI0003:00/power_supply/ACAD/online
[  281.136927] CPU 0
[  281.136970] Modules linked in: hidp hid aes_x86_64 aes_generic 
ecryptfs cpufreq_ondemand af_packet binfmt_misc ipt_MASQUERADE 
iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_state 
nf_conntrack ipt_REJECT xt_tcpudp iptable_filter ip_tables x_tables 
rfcomm bridge stp llc bnep sco l2cap kvm_intel kvm ipv6 container sbs 
sbshc microcode acpi_cpufreq freq_table uinput sbp2 snd_hda_codec_si3054 
snd_hda_codec_realtek snd_hda_intel snd_hda_codec joydev snd_hwdep arc4 
snd_pcm btusb ecb bluetooth snd_seq_midi iwl3945 snd_rawmidi iwlcore 
snd_seq_midi_event snd_seq snd_timer sr_mod mac80211 cdrom 
snd_seq_device led_class ata_generic ohci1394 tg3 pata_acpi cfg80211 
ehci_hcd uhci_hcd libphy snd ieee1394 ac ata_piix evdev usbcore rfkill 
soundcore sg psmouse wmi snd_page_alloc battery button pcspkr processor 
serio_raw sd_mod thermal fan fuse dm_mirror dm_region_hash dm_log dm_mod 
ahci libata scsi_mod ext4 mbcache jbd2 crc16
[  281.137011] Pid: 3226, comm: bluetoothd Tainted: G        W  
2.6.31-rc4-red #4 N/A                                           
[  281.137011] RIP: 0010:[<ffffffff810e51a0>]  [<ffffffff810e51a0>] 
sysfs_addrm_start+0x24/0xa0
[  281.137011] RSP: 0018:ffff88013887bab8  EFLAGS: 00010286
[  281.137011] RAX: 0000000000000000 RBX: ffff88013887bad8 RCX: 
0000000000000000
[  281.137011] RDX: 0000000000003d37 RSI: 0000000000000000 RDI: 
ffffffff813e5660
[  281.137011] RBP: 0000000000000000 R08: 0000000000000100 R09: 
ffff8801389adaa8
[  281.137011] R10: ffff880133e2dc00 R11: 0000000000000002 R12: 
ffff88013887bb30
[  281.137011] R13: ffff880131652370 R14: 00000000fffffff4 R15: 
ffff88013887bc68
[  281.137011] FS:  00007fc38fb106f0(0000) GS:ffff880028022000(0000) 
knlGS:0000000000000000
[  281.137011] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  281.137011] CR2: 0000000000000038 CR3: 000000013cf60000 CR4: 
00000000000026f0
[  281.137011] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[  281.137011] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 
0000000000000400
[  281.137011] Process bluetoothd (pid: 3226, threadinfo 
ffff88013887a000, task ffff88013d5deb50)
[  281.137011] Stack:
[  281.137011]  00000000ffffffea 0000000000000000 ffff8801388c3898 
ffffffff810e5725
[  281.137011] <0> 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[  281.137011] <0> ffff8801388c3898 ffff8801388c3898 ffff880138ad7560 
00000000ffffffea
[  281.137011] Call Trace:
[  281.219723]  [<ffffffff810e5725>] ? create_dir+0x44/0x89
[  281.219723]  [<ffffffff810e579f>] ? sysfs_create_dir+0x35/0x46
[  281.219723]  [<ffffffff811243d9>] ? kobject_get+0x12/0x17
[  281.219723]  [<ffffffff81124526>] ? kobject_add_internal+0xcd/0x186
[  281.219723]  [<ffffffff8112476f>] ? kobject_add+0x66/0x6b
[  281.219723]  [<ffffffff811c9f85>] ? device_add+0xcd/0x4ec
[  281.219723]  [<ffffffffa04fce02>] ? hid_add_device+0x13d/0x154 [hid]
[  281.219723]  [<ffffffffa050d27f>] ? hidp_add_connection+0x2af/0x58c 
[hidp]
[  281.219723]  [<ffffffffa050d78f>] ? hidp_sock_ioctl+0xf2/0x22e [hidp]
[  281.219723]  [<ffffffff81075304>] ? mark_page_accessed+0x23/0x33
[  281.219723]  [<ffffffff811f532f>] ? sock_ioctl+0x1e7/0x208
[  281.219723]  [<ffffffff810a22d4>] ? vfs_ioctl+0x19/0x83
[  281.219723]  [<ffffffff810a5ab4>] ? d_instantiate+0x3d/0x4b
[  281.219723]  [<ffffffff810a27db>] ? do_vfs_ioctl+0x42b/0x46f
[  281.219723]  [<ffffffff811f59fe>] ? sock_attach_fd+0x95/0xc0
[  281.219723]  [<ffffffff8109474b>] ? fd_install+0x31/0x5c
[  281.219723]  [<ffffffff810a286a>] ? sys_ioctl+0x4b/0x6f
[  281.219723]  [<ffffffff8100b9ab>] ? system_call_fastpath+0x16/0x1b
[  281.219723] Code: 5b 5d 41 5c 41 5d c3 55 31 c0 53 48 89 f5 48 83 ec 
08 48 89 fb b9 08 00 00 00 f3 ab 48 89 33 48 c7 c7 60 56 3e 81 e8 50 6a 
19 00 <48> 8b 75 38 48 89 e9 48 c7 c2 fc 4c 0e 81 48 8b 3d 13 49 40 00
[  281.219723] RIP  [<ffffffff810e51a0>] sysfs_addrm_start+0x24/0xa0
[  281.219723]  RSP <ffff88013887bab8>
[  281.219723] CR2: 0000000000000038
[  281.315613] ---[ end trace de74c554ac3186be ]---
