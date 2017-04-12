Return-Path: <Dean_Jenkins@mentor.com>
Subject: Re: [PATCH V2 00/16] hci_ldisc hci_uart_tty_close() fixes
To: Marcel Holtmann <marcel@holtmann.org>
References: <1491584678-27228-1-git-send-email-Dean_Jenkins@mentor.com>
CC: "Gustavo F . Padovan" <gustavo@padovan.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, <linux-bluetooth@vger.kernel.org>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
Message-ID: <b7cf2b48-c821-3541-2391-004c62b4042b@mentor.com>
Date: Wed, 12 Apr 2017 10:13:33 +0100
MIME-Version: 1.0
In-Reply-To: <1491584678-27228-1-git-send-email-Dean_Jenkins@mentor.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 07/04/17 18:04, Dean Jenkins wrote:
> This is patchset V2 which reorganises hci_uart_tty_close() to overcome a design
> flaw related to the proper closure of the Data Link protocol layer. In the worst
> case scenario a kernel crash occurs.
>
>
> Previous Discussions
> ====================
>
> Please refer to the discussion on my RFC patchset V1 that can be found here:
> https://www.spinics.net/lists/linux-bluetooth/msg70077.html
>
>
> Changes between V1 and V2
> =========================
>
> 1. Implemented some minor code style changes that were suggested by Marcel
> Holtmann.
> 2. Reordered some of the patches to better group together related changes.
>
>
> Terms used
> ==========
>
> Data Link protocol:
>
> This refers to the serial link protocol used by the UART based Bluetooth Radio
> Module. h4, BCSP and h5 are examples of Data Link protocols and there are other
> protocols available.
>
> Data Link protocol layer:
>
> This refers to the "proto" protocols that implement the Data Link protocol on
> the Linux side of the UART link.
>
> These protocols are implemented with a function pointer interface and therefore
> a specific Data Link protocol can be bound within the UART HCI driver.
>
>
> Overview of Data Link protocol data flow
> ========================================
>
> The Data Link protocol layer uses serial protocol frames to transport
> information such as HCI messages to the Bluetooth Radio Module.
>
> Internally within the Linux kernel, the Data Link protocol layer supplies
> protocol frames via the HCI UART LDISC and TTY layers to the UART driver. Any
> breakage in this data "pipe" will cause a disruption of the communications with
> the Bluetooth Radio Module.
>
>
> Overview of Design Flaw
> =======================
>
> There are a number of issues relating to the implementation of
> hci_uart_tty_close().
>
> The areas of concern are:
>
> a) poor locking of hu->proto->close() with respect to the other "proto" function
>     pointers. This means hu->proto->close() can asynchronously remove resources
>     used by the other "proto" function pointers resulting in malfunctions and
>     kernel crashes.
>
> b) tearing down parts of the data "pipe" between the Data Link protocol layer
>     and the UART driver despite attempting to send HCI commands and trying to
>     handle retransmissions within hci_uart_tty_close(). This results in a loss of
>     communications with the Bluetooth Radio Module. Note that a loss of
>     communications can cause the Data Link protocol layer to independently
>     attempt to retransmit such as in the case of BCSP.
>
> c) suspect HCI_QUIRK_RESET_ON_CLOSE has been broken for many years because it
>     is not possible to get the HCI RESET command successfully ACK'ed due to the
>     data "pipe" being cut in multiple places during the execution of
>     tty_ldisc_close().
>
> Please note the issue is independent of the implementation of the Data Link
> protocol layer. BCSP closedown scenarios have been used as an example.
>
>
> Test cases
> ==========
>
> Test 1
> ------
>
> Setup Bluetooth to use a BCSP based UART Bluetooth Radio Module. In this case
> use the Bluez hciattach utility.
>
> Then kill the userland hciattach program by doing
> killall hciattach
>
> When hciattach terminates, SIGTERM handling causes ioctl TIOCSETD to run
> kernel function tty_set_ldisc().
>
> Test 2
> ------
>
> Setup Bluetooth to use a BCSP based UART Bluetooth Radio Module. In this case
> use the Bluez btattach utility.
>
> Note that btattach does not establish a BCSP connection due to missing some BCSP
> protocol implementation. However, this is ideal in exposing the design flaw.
>
> Here is an example test script that can trigger a Bluetooth kernel crash in
> relation to hci_uart_tty_close().
>
> #!/bin/bash
>
> let i=1
>
> while [ true ]
> do
>          echo "loop $i"
>          ./btattach -A /dev/ttyUSB0 -P bcsp &
>          sleep 5
>          echo "now killing..."
>          killall btattach
>          i=$(($i + 1))
> done
>
> Kernel crashes within 10 minutes of starting the script.
>
> h4 can also be shown to fail by using
> 	./btattach -A /dev/ttyUSB0 -P h4 &
>
> Note that in my test run, h4 was communicating with a BCSP enabled Bluetooth
> Radio Module. The probability of a crash is increased when poor communications
> occur.
>
> When btattach gets a SIGTERM, the program terminates with a group_exit() system
> call which causes tty_set_ldisc() to run to perform clean-up.
>
>
> Analysis of hci_uart_tty_close() callstack
> ==========================================
>
> Crash 1 - Sending HCI RESET command due to HCI_QUIRK_RESET_ON_CLOSE
> -------
>
>  From tests 1 and 2 the callstack can be:
>
> tty_set_ldisc() takes a tty ref lock via tty_ldisc_lock
> tty_ldisc_close()
> hci_uart_tty_close()
> hci_unregister_dev()
> hci_dev_do_close()
> __hci_req_sync() which tries to send a HCI RESET command which depends on
> HCI_QUIRK_RESET_ON_CLOSE being enabled and that is the default condition. This
> is done by queueing up the HCI RESET command which adds a work-item to the
> hdev->workqueue and waits 2 seconds for a response
>
> Subsequently in a parallel thread to hci_uart_tty_close()
> hdev->workqueue runs and processes the work-item by calling
> hci_cmd_work()
> hci_send_frame()
> hci_uart_send_frame()
> hci_uart_tx_wakeup() to schedule hci_uart_write_work() via the work queue
>   hu->write_work
>
> Subsequently in a parallel thread to hci_uart_tty_close()
> hci_uart_write_work()
> hci_uart_dequeue()
> hu->proto->dequeue()
> bcsp_dequeue()
> tty->ops->write() to write the BCSP frame to the UART driver via TTY layer
>
> Subsequently in a parallel thread to hci_uart_tty_close()
> BCSP re-transmission timer expires after 250ms due to no ACK from the Bluetooth
> Radio Module.
> bcsp_timed_event()
> hci_uart_tx_wakeup() to schedule hci_uart_write_work() via the work queue
>   hu->write_work
>
> Subsequently in a parallel thread to hci_uart_tty_close()
> hci_uart_write_work()
> hci_uart_dequeue()
> hu->proto->dequeue()
> bcsp_dequeue()
> tty->ops->write() to write the BCSP frame to the UART driver via TTY layer
>
> Subsequently in a parallel thread to hci_uart_tty_close()
> BCSP re-transmission timer expires after 250ms due to no ACK from the Bluetooth
> Radio Module.
> bcsp_timed_event()
> hci_uart_tx_wakeup() to schedule hci_uart_write_work() via the work queue
>   hu->write_work
>
> Subsequently in a parallel thread to hci_uart_tty_close()
> hci_uart_write_work()
> hci_uart_dequeue()
> hu->proto->dequeue()
> bcsp_dequeue()
> tty->ops->write() to write the BCSP frame to the UART driver via TTY layer
>
> etc. BCSP attempts to retransmit every 250ms during the execution of
> hci_uart_tty_close() until bcsp_close() is called via hu->proto->close().
>
> Here is an example kernel crash log for kernel 4.10.5 + debug
> (sorry for the bad kernel version string 4.10.54.10.5_debug+)
>
> [ 1561.709737] BUG: unable to handle kernel NULL pointer dereference at 0000000000000044
> [ 1561.709829] IP: _raw_spin_lock_irqsave+0x22/0x40
> [ 1561.709862] PGD 0
> [ 1561.709889] Oops: 0002 1 SMP
> [ 1561.709911] Modules linked in: ftdi_sio rfcomm hci_uart btqca xt_set ip_set_hash_ip nf_log_ipv6 ip_set nf_log_ipv4 nf_log_common xt_LOG ip6table_nat nf_nat_ipv6 xt_recent iptable_nat nf_nat_ipv4 ipt_REJECT nf_reject_ipv4 iptable_mangle iptable_raw nf_conntrack_ipv4 nf_defrag_ipv4 xt_comment ip6t_REJECT nf_reject_ipv6 xt_addrtype bridge stp llc xt_mark ip6table_mangle nf_nat_tftp nf_nat_snmp_basic nf_conntrack_snmp xt_tcpudp nf_nat_sip xt_CT nf_nat_pptp nf_nat_proto_gre nf_nat_irc ip6table_raw nf_nat_h323 xt_multiport nf_nat_ftp nf_nat_amanda nf_conntrack_ipv6 nf_defrag_ipv6 xt_conntrack nf_nat nf_conntrack_tftp nf_conntrack_sip nf_conntrack_sane nf_conntrack_pptp nf_conntrack_proto_gre nf_conntrack_netlink nfnetlink nf_conntrack_netbios_ns nf_conntrack_broadcast nf_conntrack_irc nf_conntrack_h323
> [ 1561.710172] nf_conntrack_ftp ts_kmp nf_conntrack_amanda nf_conntrack iptable_filter ip_tables ip6table_filter ip6_tables x_tables lockd grace ctr ccm af_packet bnep msr usbserial uvcvideo btusb btrtl arc4 brcmsmac btbcm videobuf2_vmalloc btintel cordic videobuf2_memops bluetooth intel_powerclamp brcmutil videobuf2_v4l2 videobuf2_core mac80211 videodev coretemp kvm_intel kvm joydev media cfg80211 iTCO_wdt iTCO_vendor_support snd_hda_codec_hdmi snd_hda_codec_realtek psmouse snd_hda_codec_generic toshiba_acpi input_leds bcma snd_hda_intel irqbypass snd_hda_codec toshiba_bluetooth cpufreq_ondemand sparse_keymap crc32c_intel cpufreq_conservative industrialio snd_hda_core serio_raw wmi rfkill thermal cpufreq_powersave battery ac snd_hwdep snd_pcm acpi_cpufreq snd_timer snd toshiba_haps mei_me mei e1000e
> [ 1561.718028] fjes soundcore evdev ptp lpc_ich shpchp pps_core intel_ips tpm_tis tpm_tis_core nvram tpm sch_fq_codel sunrpc ipv6 crc_ccitt autofs4 hid_generic usbhid hid sdhci_pci mmc_block sdhci sr_mod ehci_pci ehci_hcd mmc_core usbcore usb_common i915 video button i2c_algo_bit drm_kms_helper drm [last unloaded: ftdi_sio]
> [ 1561.721317] CPU: 1 PID: 4473 Comm: kworker/1:0 Not tainted 4.10.54.10.5_debug+ #12
> [ 1561.722981] Hardware name: TOSHIBA Satellite R630/Portable PC, BIOS Version 1.40 07/20/2010
> [ 1561.724660] Workqueue: events hci_uart_write_work [hci_uart]
> [ 1561.726377] task: ffff98d9b4f15100 task.stack: ffffa868c1178000
> [ 1561.728568] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
> [ 1561.730355] RSP: 0000:ffffa868c117bda8 EFLAGS: 00010046
> [ 1561.731993] RAX: 0000000000000000 RBX: 0000000000000296 RCX: 0000000000079ad6
> [ 1561.733646] RDX: 0000000000000001 RSI: ffff98da77c5c580 RDI: 0000000000000044
> [ 1561.735314] RBP: ffffa868c117bdb0 R08: 000000000001c5a0 R09: ffffffff9965a54a
> [ 1561.736991] R10: fffff48441dc9a80 R11: ffff98da73403700 R12: 0000000000000030
> [ 1561.738641] R13: 0000000000000044 R14: 0000000000000030 R15: ffff98d9b4e50000
> [ 1561.740288] FS: 0000000000000000(0000) GS:ffff98da77c40000(0000) knlGS:0000000000000000
> [ 1561.741940] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1561.743585] CR2: 0000000000000044 CR3: 0000000128d1a000 CR4: 00000000000006e0
> [ 1561.745238] Call Trace:
> [ 1561.746882] skb_dequeue+0x1d/0x70
> [ 1561.748512] bcsp_dequeue+0x27/0x180 [hci_uart]
> [ 1561.750130] ? kfree_skbmem+0x5a/0x60
> [ 1561.751742] hci_uart_write_work+0xc4/0x100 [hci_uart]
> [ 1561.753356] process_one_work+0x151/0x410
> [ 1561.754930] worker_thread+0x69/0x4b0
> [ 1561.756507] kthread+0x114/0x150
> [ 1561.758076] ? rescuer_thread+0x340/0x340
> [ 1561.759636] ? kthread_park+0x90/0x90
> [ 1561.761191] ret_from_fork+0x2c/0x40
> [ 1561.762693] Code: 89 e5 e8 82 96 98 ff 5d c3 66 66 66 66 90 55 48 89 e5 53 9c 58 66 66 90 66 90 48 89 c3 fa 66 66 90 66 66 90 31 c0 ba 01 00 00 00 <f0> 0f b1 17 85 c0 75 06 48 89 d8 5b 5d c3 89 c6 e8 29 83 98 ff
> [ 1561.766034] RIP: _raw_spin_lock_irqsave+0x22/0x40 RSP: ffffa868c117bda8
> [ 1561.768033] CR2: 0000000000000044
> [ 1561.774555] --[ end trace 51cc1d3575c0e559 ]--
>
>
> Crash 2 - Sending HCI commands but get no ACKs
> -------
>
> Using test 2 and h4, a similar crash could be triggered for h4_dequeue().
>
> In this case HCI is attempting to send multiple HCI commands.
>
> tty_set_ldisc() takes a tty ref lock via tty_ldisc_lock
> tty_ldisc_close()
> hci_uart_tty_close()
> hci_unregister_dev()
> hci_dev_do_close()
>
> HCI commands become queued up by adding work-items to the hdev->workqueue.
>
> Subsequently in a parallel thread to hci_uart_tty_close()
> hdev->workqueue runs and processes a work-item by calling
> hci_cmd_work()
> hci_send_frame()
> hci_uart_send_frame()
> hci_uart_tx_wakeup() to schedule hci_uart_write_work() via the work queue
>   hu->write_work
>
> Subsequently in a parallel thread to hci_uart_tty_close()
> hci_uart_write_work()
> hci_uart_dequeue()
> hu->proto->dequeue()
> tty->ops->write() to write the h4 frame to the UART driver via TTY layer
>
> Subsequently in a parallel thread to hci_uart_tty_close()
> hdev->workqueue runs and processes a work-item by calling
> hci_cmd_work()
> hci_send_frame()
> hci_uart_send_frame()
> hci_uart_tx_wakeup() to schedule hci_uart_write_work() via the work queue
>   hu->write_work
>
> Subsequently in a parallel thread to hci_uart_tty_close()
> hci_uart_write_work()
> hci_uart_dequeue()
> hu->proto->dequeue()
> tty->ops->write() to write the h4 frame to the UART driver via TTY layer
>
> etc. Note that HCI TX timeouts occur.
>
> Here is an example kernel crash log for kernel 4.10.5 + debug
> (sorry for the bad kernel version string 4.10.54.10.5_debug+)
>
> [ 563.702430] BUG: unable to handle kernel NULL pointer dereference at 000000000000001c
> [ 563.702491] IP: _raw_spin_lock_irqsave+0x22/0x40
> [ 563.702520] PGD 13230e067
> [ 563.702521] PUD 1238d6067
> [ 563.702540] PMD 0
> [ 563.704521] Oops: 0002 1 SMP
> [ 563.706215] Modules linked in: hci_uart btqca nf_log_ipv6 ip6table_nat nf_nat_ipv6 ip6t_REJECT nf_reject_ipv6 ip6table_mangle xt_set ip_set_hash_ip ip_set nf_log_ipv4 nf_log_common xt_LOG xt_recent iptable_nat nf_nat_ipv4 xt_comment ipt_REJECT nf_reject_ipv4 xt_addrtype bridge stp llc xt_mark iptable_mangle xt_tcpudp iptable_raw nf_conntrack_ipv4 nf_defrag_ipv4 xt_CT nf_nat_tftp nf_nat_snmp_basic nf_conntrack_snmp ip6table_raw nf_nat_sip xt_multiport nf_nat_pptp nf_nat_proto_gre nf_nat_irc nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_h323 nf_nat_ftp xt_conntrack nf_nat_amanda nf_nat nf_conntrack_tftp nf_conntrack_sip nf_conntrack_sane nf_conntrack_pptp nf_conntrack_proto_gre nf_conntrack_netlink nfnetlink nf_conntrack_netbios_ns nf_conntrack_broadcast nf_conntrack_irc nf_conntrack_h323 nf_conntrack_ftp
> [ 563.715634] ts_kmp nf_conntrack_amanda nf_conntrack iptable_filter ip_tables ip6table_filter ip6_tables x_tables lockd grace ctr ccm af_packet bnep msr arc4 brcmsmac uvcvideo cordic brcmutil ftdi_sio videobuf2_vmalloc usbserial intel_powerclamp mac80211 videobuf2_memops btusb videobuf2_v4l2 btrtl coretemp snd_hda_codec_hdmi btbcm videobuf2_core btintel kvm_intel snd_hda_codec_realtek bluetooth kvm videodev joydev cfg80211 snd_hda_codec_generic media snd_hda_intel snd_hda_codec psmouse snd_hda_core irqbypass e1000e snd_hwdep input_leds snd_pcm iTCO_wdt iTCO_vendor_support serio_raw crc32c_intel toshiba_acpi snd_timer ptp mei_me fjes bcma snd mei thermal sparse_keymap toshiba_haps industrialio lpc_ich soundcore battery ac pps_core shpchp intel_ips toshiba_bluetooth wmi rfkill tpm_tis tpm_tis_core
> [ 563.726159] tpm cpufreq_ondemand cpufreq_conservative cpufreq_powersave acpi_cpufreq evdev nvram sunrpc sch_fq_codel ipv6 crc_ccitt autofs4 hid_generic usbhid hid sdhci_pci mmc_block sdhci sr_mod ehci_pci ehci_hcd mmc_core usbcore usb_common i915 video button i2c_algo_bit drm_kms_helper drm
> [ 563.730623] CPU: 0 PID: 29 Comm: kworker/0:1 Not tainted 4.10.54.10.5_debug+ #13
> [ 563.732862] Hardware name: TOSHIBA Satellite R630/Portable PC, BIOS Version 1.40 07/20/2010
> [ 563.735127] Workqueue: events hci_uart_write_work [hci_uart]
> [ 563.737376] task: ffffa03f32951b00 task.stack: ffffbc4ec0768000
> [ 563.739620] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
> [ 563.741839] RSP: 0018:ffffbc4ec076bdd8 EFLAGS: 00010046
> [ 563.744059] RAX: 0000000000000000 RBX: 0000000000000202 RCX: ffffa03f37c1cd60
> [ 563.746286] RDX: 0000000000000001 RSI: ffffa03f37c18ae0 RDI: 000000000000001c
> [ 563.748493] RBP: ffffbc4ec076bde0 R08: ffffa03f32332380 R09: 0000000000000001
> [ 563.750690] R10: ffffe9de427ce800 R11: ffffa03f33498600 R12: 0000000000000008
> [ 563.752884] R13: 000000000000001c R14: ffffa03e79b1ad38 R15: ffffa03e79b1a240
> [ 563.755075] FS: 0000000000000000(0000) GS:ffffa03f37c00000(0000) knlGS:0000000000000000
> [ 563.757260] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 563.759426] CR2: 000000000000001c CR3: 000000011d7a3000 CR4: 00000000000006f0
> [ 563.761610] Call Trace:
> [ 563.763798] skb_dequeue+0x1d/0x70
> [ 563.765975] h4_dequeue+0x16/0x20 [hci_uart]
> [ 563.768128] hci_uart_write_work+0xc4/0x100 [hci_uart]
> [ 563.770262] process_one_work+0x151/0x410
> [ 563.772368] worker_thread+0x69/0x4b0
> [ 563.774466] kthread+0x114/0x150
> [ 563.776519] ? rescuer_thread+0x340/0x340
> [ 563.778546] ? kthread_park+0x90/0x90
> [ 563.780566] ret_from_fork+0x2c/0x40
> [ 563.782559] Code: 89 e5 e8 82 96 98 ff 5d c3 66 66 66 66 90 55 48 89 e5 53 9c 58 66 66 90 66 90 48 89 c3 fa 66 66 90 66 66 90 31 c0 ba 01 00 00 00 <f0> 0f b1 17 85 c0 75 06 48 89 d8 5b 5d c3 89 c6 e8 29 83 98 ff
> [ 563.786800] RIP: _raw_spin_lock_irqsave+0x22/0x40 RSP: ffffbc4ec076bdd8
> [ 563.788940] CR2: 000000000000001c
> [ 563.798389] --[ end trace 326429e7baa9f359 ]--
>
>
> Detailed analysis
> =================
>
> The failure can be rare due to the following mitigations:
>
> a) the Data Link protocol layer might be idle when hci_uart_tty_close() runs.
> b) the system never shuts down Bluetooth so hci_uart_tty_close() does not run.
> c) HCI_QUIRK_RESET_ON_CLOSE is disabled so the HCI RESET command is not sent.
>
> Please note that disabling HCI_QUIRK_RESET_ON_CLOSE helps to reduce the
> probability that a crash occurs. However, it is not a fix.
>
> It can be seen that the following threads can be running concurrently with
> hci_uart_tty_close():
>
> a) hci_cmd_work() via the work queue hdev->workqueue
> b) hci_uart_write_work() via the work queue hu->write_work
> c) Data Link protocol layer retransmission timer such as bcsp_timed_event()
>
> In order to send a HCI command the Data Link protocol layer must be able to send
> and receive frames from the UART port that is physically connected to the UART
> based Bluetooth Radio Module. If this data "pipe" is broken then the Data Link
> protocol layer may perform retransmissions such as in the case of BCSP. In
> addition, a loss of communications causes the HCI command to not be ACK'ed so
> causes a HCI command timeout to occur.
>
> In the case of HCI_QUIRK_RESET_ON_CLOSE, the sending of the HCI RESET command
> has a 2 second timeout which will block __hci_req_sync() for up to 2 seconds.
>
> The hu->proto->dequeue() kernel crash occurs because hu->proto->close() was
> called which removes the resources needed by hu->proto->dequeue(). This causes
> a NULL pointer dereference kernel crash to occur when hu->proto->dequeue()
> executes.
>
> The reason why hu->proto->close() can run before or during hu->proto->dequeue()
> is because the call to cancel_work_sync(&hu->write_work) is ineffective. This is
> because hci_cmd_work() and BCSP bcsp_timed_event() can schedule work-items
> after the cancel_work_sync() completed.
>
> Note that flushing can corrupt any protocol serial frames being sent from the
> Data Link protocol layer to the UART driver and this is undesirable.
>
>
> Solution
> ========
>
> Reorganise hci_uart_tty_close() so that hci_unregister_dev() can run with no
> interference to the data "pipe" between the Data Link protocol layer such as
> BCSP and the UART driver.
>
> The patchset cleans up the HCI_UART_REGISTERED and HCI_UART_PROTO_READY flag
> handling so that:
>
> a) hdev is only valid when HCI_UART_REGISTERED is in the set state.
> b) the "proto" Data Link function pointers can only be used when
>     HCI_UART_PROTO_READY is in the set state.
>
> The most important patch is
> "Bluetooth: hci_ldisc: Use rwlocking to avoid closing proto races"
>
> This patch adds rwlocking around the clearing of the flag HCI_UART_PROTO_READY.
> This is because the atomic flag HCI_UART_PROTO_READY cannot always prevent a
> thread using a Data Link protocol layer function pointer during or after closure
> of the Data Link protocol layer. This can result in a kernel crash. Remember
> that the BCSP retransmission handling runs in a separate thread and tries to
> send a new frame. Therefore there is a small window of a race condition for the
> flag HCI_UART_PROTO_READY to be seen in the set state and then calls the
> "proto" function pointer after the Data Link protocol layer has been closed,
> resulting in a kernel crash.
>
>
> Overview of patches
> -------------------
>
> The patches were rebased onto the bluetooth-next/master branch commit:
> 3eed895 Bluetooth: L2CAP: Don't return -EAGAIN if out of credits
>
> Tidy-up patches (mainly for h5 binding error handling)
>    Bluetooth: hci_ldisc: Add missing return in hci_uart_init_work()
>    Bluetooth: hci_ldisc: Ensure hu->hdev set to NULL before freeing hdev
>    Bluetooth: hci_ldisc: Add missing clear HCI_UART_PROTO_READY
>
> Adds a comment to warn that hci_unregister_dev() may send a HCI RESET command
>    Bluetooth: hci_ldisc: Add HCI RESET comment to hci_unregister_dev()
>      call
>
> Simplifies the relationship between HCI_UART_REGISTERED and HCI_UART_PROTO_READY
>    Bluetooth: hci_ldisc: Separate flag handling in hci_uart_tty_close()
>
> Prevents "proto" functions being used immediately before and after
> hu->proto->close()
>    Bluetooth: hci_ldisc: Add protocol check to hci_uart_send_frame()
>    Bluetooth: hci_ldisc: Add protocol check to hci_uart_dequeue()
>    Bluetooth: hci_ldisc: Add protocol check to hci_uart_tx_wakeup()
>    Bluetooth: hci_ldisc: Use rwlocking to avoid closing proto races
>
> Prevents the "data" pipe being cut too early inside hci_uart_tty_close()
>    Bluetooth: hci_ldisc: Tidy-up HCI_UART_REGISTERED in
>      hci_uart_tty_close()
>    Bluetooth: hci_ldisc: hci_uart_tty_close() move hci_uart_close()
>    Bluetooth: hci_ldisc: hci_uart_tty_close() detach tty after last msg
>    Bluetooth: hci_ldisc: hci_uart_tty_close() move cancel_work_sync()
>    Bluetooth: hci_ldisc: hci_uart_tty_close() free hu->tx_skb
>    Bluetooth: hci_ldisc: Simplify flushing
>
> Prevent concurrency of hci_uart_tty_ioctl() with hci_uart_tty_close()
>    Bluetooth: hci_ldisc: Add ioctl_mutex avoiding concurrency
>
>
> Further work
> ============
>
> This patchset tackles the issues of hci_uart_tty_close().
>
> However, the TTY layer needs investigation because tty_set_ldisc() has a tty ref
> lock during the execution of hci_uart_tty_close() which:
>
> a) prevents flush_to_ldisc() from passing the received UART data to the Data
>     Link protocol layer.
> b) prevents hci_uart_tty_wakeup() from passing the Data Link protocol layer's
>     transmission data to the UART driver.
>
> Therefore, the TTY layer cuts the data "pipe" during the execution of
> hci_uart_tty_close() causing a loss of communications with the Bluetooth Radio
> Module.
>
> This patchset does not attempt to fix the TTY layer. This means that the
> HCI_QUIRK_RESET_ON_CLOSE will remain being unsuccessful in sending the HCI RESET
> command. In fact, all attempts at sending an HCI command during
> hci_uart_tty_close() will still fail.
>
>
> Dean Jenkins (16):
>    Bluetooth: hci_ldisc: Add missing return in hci_uart_init_work()
>    Bluetooth: hci_ldisc: Ensure hu->hdev set to NULL before freeing hdev
>    Bluetooth: hci_ldisc: Add missing clear HCI_UART_PROTO_READY
>    Bluetooth: hci_ldisc: Add HCI RESET comment to hci_unregister_dev()
>      call
>    Bluetooth: hci_ldisc: Separate flag handling in hci_uart_tty_close()
>    Bluetooth: hci_ldisc: Add protocol check to hci_uart_send_frame()
>    Bluetooth: hci_ldisc: Add protocol check to hci_uart_dequeue()
>    Bluetooth: hci_ldisc: Add protocol check to hci_uart_tx_wakeup()
>    Bluetooth: hci_ldisc: Use rwlocking to avoid closing proto races
>    Bluetooth: hci_ldisc: Tidy-up HCI_UART_REGISTERED in
>      hci_uart_tty_close()
>    Bluetooth: hci_ldisc: hci_uart_tty_close() move hci_uart_close()
>    Bluetooth: hci_ldisc: hci_uart_tty_close() detach tty after last msg
>    Bluetooth: hci_ldisc: hci_uart_tty_close() move cancel_work_sync()
>    Bluetooth: hci_ldisc: hci_uart_tty_close() free hu->tx_skb
>    Bluetooth: hci_ldisc: Simplify flushing
>    Bluetooth: hci_ldisc: Add ioctl_mutex avoiding concurrency
>
>   drivers/bluetooth/hci_ldisc.c | 105 ++++++++++++++++++++++++++++++++----------
>   drivers/bluetooth/hci_uart.h  |   3 ++
>   2 files changed, 84 insertions(+), 24 deletions(-)
>

If you have not already noticed, I have sent you my V2 HCI UART LDISC 
patchset for you to look at.

I look forward to receiving your comments and feedback.

Thank you,

Best regards,
Dean

-- 
Dean Jenkins
Embedded Software Engineer
Linux Transportation Solutions
Mentor Embedded Software Division
Mentor Graphics (UK) Ltd.
