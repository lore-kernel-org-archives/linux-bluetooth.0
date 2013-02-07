Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Feb 2013 12:38:12 -0500
From: Dave Jones <davej@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Fedora Kernel Team <kernel-team@fedoraproject.org>,
        linux-bluetooth@vger.kernel.org
Subject: list_debug double add from bluetooth
Message-ID: <20130207173812.GA23062@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

We had a user report this against 3.7.  I don't see anything obvious that has been
committed in 3.8rc that would address this..

	Dave


:WARNING: at lib/list_debug.c:36 __list_add+0x9c/0xd0()
:Hardware name: Latitude E6430
:list_add double add: new=ffff8801d2c341b8, prev=ffff8801d2c341b8, next=ffff88021581d480.
:Modules linked in: hidp fuse ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_CHECKSUM iptable_mangle be2iscsi iscsi_boot_sysfs bnx2i bridge stp llc cnic uio cxgb4i cxgb4 cxgb3i cxgb3 mdio libcxgbi ib_iser lockd sunrpc rdma_cm ib_addr iw_cm ib_cm ib_sa ib_mad ib_core iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi rfcomm bnep ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables uvcvideo arc4 iwldvm videobuf2_vmalloc btusb videobuf2_memops videobuf2_core videodev media coretemp mac80211 snd_hda_codec_hdmi bluetooth snd_hda_codec_idt i2c_i801 dell_laptop ppdev dcdbas parport_pc parport iTCO_wdt iTCO_vendor_support snd_hda_intel iwlwifi snd_hda_codec snd_hwdep lpc_ich mei mfd_core cfg80211 rfkill microcode snd_seq snd_seq_device snd_pcm snd_page_alloc snd_timer snd dell_wmi sparse_keymap soundcore e1000e vhost_net tun macvtap macvlan kvm_intel kvm uinput crc32c_intel ghas
:h_clmulni_intel sdhci_pci sdhci mmc_core wmi i915 video i2c_algo_bit drm_kms_helper drm i2c_core
:Pid: 548, comm: kworker/u:2H Not tainted 3.7.3-101.fc17.x86_64 #1
:Call Trace:
: [<ffffffff8105e69f>] warn_slowpath_common+0x7f/0xc0
: [<ffffffff8105e796>] warn_slowpath_fmt+0x46/0x50
: [<ffffffff812f985c>] __list_add+0x9c/0xd0
: [<ffffffff812e7277>] kobject_add_internal+0x77/0x260
: [<ffffffff812efa41>] ? vsnprintf+0x461/0x600
: [<ffffffff8109a0f0>] ? enqueue_entity+0xc0/0x440
: [<ffffffff812e77c7>] kobject_add+0x67/0xc0
: [<ffffffff8117f009>] ? kfree+0x49/0x170
: [<ffffffff813cc619>] device_add+0x119/0x6e0
: [<ffffffff813caf91>] ? dev_set_name+0x41/0x50
: [<ffffffffa03c73bb>] hci_conn_add_sysfs+0x5b/0xe0 [bluetooth]
: [<ffffffffa03b8d30>] hci_conn_complete_evt.isra.45+0xe0/0x3f0 [bluetooth]
: [<ffffffffa03bc198>] hci_event_packet+0x16b8/0x2900 [bluetooth]
: [<ffffffffa03c628f>] ? hci_send_to_sock+0xff/0x1e0 [bluetooth]
: [<ffffffff81513b27>] ? __kfree_skb+0x47/0xa0
: [<ffffffff81513bb6>] ? kfree_skb+0x36/0xa0
: [<ffffffffa03c628f>] ? hci_send_to_sock+0xff/0x1e0 [bluetooth]
: [<ffffffffa03ae258>] hci_rx_work+0x1e8/0x430 [bluetooth]
: [<ffffffff8101358e>] ? __switch_to+0x13e/0x4a0
: [<ffffffff8107a4a7>] process_one_work+0x147/0x490
: [<ffffffffa03ae070>] ? hci_send_frame+0xc0/0xc0 [bluetooth]
: [<ffffffff8107cd3e>] worker_thread+0x15e/0x450
: [<ffffffff8107cbe0>] ? busy_worker_rebind_fn+0x110/0x110
: [<ffffffff81081ca0>] kthread+0xc0/0xd0
: [<ffffffff81010000>] ? ftrace_raw_event_xen_mmu_flush_tlb_others+0x50/0xe0
: [<ffffffff81081be0>] ? kthread_create_on_node+0x120/0x120
: [<ffffffff816396ec>] ret_from_fork+0x7c/0xb0
: [<ffffffff81081be0>] ? kthread_create_on_node+0x120/0x120
