Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
Subject: Re: [RFC V1 00/16] hci_ldisc hci_uart_tty_close() fixes
To: Marcel Holtmann <marcel@holtmann.org>
References: <1490723429-28870-1-git-send-email-Dean_Jenkins@mentor.com>
 <AA3DD0DD-5CAC-4ADD-9B0C-4E652C93E4D6@holtmann.org>
 <ee49f939-1094-0ae0-0fa7-6c5cad112527@mentor.com>
 <119BB9FC-C735-405B-9A77-E9F102393B7D@holtmann.org>
CC: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, <linux-bluetooth@vger.kernel.org>
Message-ID: <3662704c-dfd4-67db-a2f9-45c949c45c6c@mentor.com>
Date: Tue, 4 Apr 2017 21:36:33 +0100
MIME-Version: 1.0
In-Reply-To: <119BB9FC-C735-405B-9A77-E9F102393B7D@holtmann.org>
Content-Type: multipart/mixed;
	boundary="------------993B4B5E08F1A9B7E4997AAE"
List-ID: <linux-bluetooth.vger.kernel.org>

--------------993B4B5E08F1A9B7E4997AAE
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

On 03/04/17 16:51, Marcel Holtmann wrote:
>
> If this is an issue in 4.10, then lets get this fixed / hardened.
>

I have created a simple test script that leads to a kernel crash in HCI 
UART LDISC. Please note that this is a different scenario to the one 
documented in my previous E-mails but the resulting crash is similar.

I am using a BCSP supported Bluetooth Radio Module connected via a USB 
to serial interface to a 64-bit x86 Linux laptop.

I built kernel v4.10.5 although I messed up the .config settings so 
uname -r gave a strange string of4.10.54.10.5_debug+, sigh

Please note that "btattach" fails to establish a BCSP connection with 
the Bluetooth Radio Module but that is advantageous in exposing a fatal 
race condition in hci_uart_tty_close(). In this case, the BCSP Data Link 
protocol layer attempts to retransmit every 250ms and the BCSP layer 
gets closed down whilst still attempting to retransmit which causes a 
kernel crash.

My proposed patchset fixes this race condition plus some other issues.

Please refer to my attached tarball v4.10.5_bt_crash_info.tgz, the 
contents are:
v4.10.5_pure_testing/
v4.10.5_pure_testing/0001-Bluetooth-Debug-shows-how-hci_uart_tty_close-is-call.patch
v4.10.5_pure_testing/v4.10.5_pure_testing/btattach_loop.sh
v4.10.5_pure_testing/enable_hci_bt_logging.sh
v4.10.5_pure_testing/bt_hci_uart_ldisc_crash_snippet_log.txt

The patch file 
0001-Bluetooth-Debug-shows-how-hci_uart_tty_close-is-call.patch
is just adding debug so you can see that killing "btattach" causes 
do_group_exit() to run in the kernel which cleans-up by using 
tty_ldisc_kill() which calls tty_ldisc_close() which causes 
hci_uart_tty_close() to run.

enable_hci_bt_logging.sh
enables dynamic debug for dmesg although dynamic debug seems unreliable 
these days at least for me and I have to run enable_hci_bt_logging.sh 
multiple times to get all the files logging properly.

bt_hci_uart_ldisc_crash_snippet_log.txt
This shows my analysis of 2 example NULL pointer dereference kernel 
crashes which are easy to reproduce using my test script.

v4.10.5_pure_testing/btattach_loop.sh
This is the simple test script which causes a kernel crash within 10 
minutes of running, it is easily repeatable with my equipment. I think 
the kernel crash occurs before the loop counter reaches 100.

The contents of the script is:

#!/bin/bash

let i=1

while [ true ]
do
         echo "loop $i"
         ./btattach -A /dev/ttyUSB0 -P bcsp &
         sleep 5
         echo "now killing..."
         killall btattach
         i=$(($i + 1))
done

Example kernel crash backtrace:

[ 1561.709737] BUG: unable to handle kernel NULL pointer dereference at 
0000000000000044
[ 1561.709829] IP: _raw_spin_lock_irqsave+0x22/0x40
[ 1561.709862] PGD 0

[ 1561.709889] Oops: 0002 [#1] SMP
[ 1561.709911] Modules linked in: ftdi_sio rfcomm hci_uart btqca xt_set 
ip_set_hash_ip nf_log_ipv6 ip_set nf_log_ipv4 nf_log_common xt_LOG 
ip6table_nat nf_nat_ipv6 xt_recent iptable_nat nf_nat_ipv4 ipt_REJECT 
nf_reject_ipv4 iptable_mangle iptable_raw nf_conntrack_ipv4 
nf_defrag_ipv4 xt_comment ip6t_REJECT nf_reject_ipv6 xt_addrtype bridge 
stp llc xt_mark ip6table_mangle nf_nat_tftp nf_nat_snmp_basic 
nf_conntrack_snmp xt_tcpudp nf_nat_sip xt_CT nf_nat_pptp 
nf_nat_proto_gre nf_nat_irc ip6table_raw nf_nat_h323 xt_multiport 
nf_nat_ftp nf_nat_amanda nf_conntrack_ipv6 nf_defrag_ipv6 xt_conntrack 
nf_nat nf_conntrack_tftp nf_conntrack_sip nf_conntrack_sane 
nf_conntrack_pptp nf_conntrack_proto_gre nf_conntrack_netlink nfnetlink 
nf_conntrack_netbios_ns nf_conntrack_broadcast nf_conntrack_irc 
nf_conntrack_h323
[ 1561.710172]  nf_conntrack_ftp ts_kmp nf_conntrack_amanda nf_conntrack 
iptable_filter ip_tables ip6table_filter ip6_tables x_tables lockd grace 
ctr ccm af_packet bnep msr usbserial uvcvideo btusb btrtl arc4 brcmsmac 
btbcm videobuf2_vmalloc btintel cordic videobuf2_memops bluetooth 
intel_powerclamp brcmutil videobuf2_v4l2 videobuf2_core mac80211 
videodev coretemp kvm_intel kvm joydev media cfg80211 iTCO_wdt 
iTCO_vendor_support snd_hda_codec_hdmi snd_hda_codec_realtek psmouse 
snd_hda_codec_generic toshiba_acpi input_leds bcma snd_hda_intel 
irqbypass snd_hda_codec toshiba_bluetooth cpufreq_ondemand sparse_keymap 
crc32c_intel cpufreq_conservative industrialio snd_hda_core serio_raw 
wmi rfkill thermal cpufreq_powersave battery ac snd_hwdep snd_pcm 
acpi_cpufreq snd_timer snd toshiba_haps mei_me mei e1000e
[ 1561.718028]  fjes soundcore evdev ptp lpc_ich shpchp pps_core 
intel_ips tpm_tis tpm_tis_core nvram tpm sch_fq_codel sunrpc ipv6 
crc_ccitt autofs4 hid_generic usbhid hid sdhci_pci mmc_block sdhci 
sr_mod ehci_pci ehci_hcd mmc_core usbcore usb_common i915 video button 
i2c_algo_bit drm_kms_helper drm [last unloaded: ftdi_sio]
[ 1561.721317] CPU: 1 PID: 4473 Comm: kworker/1:0 Not tainted 
4.10.54.10.5_debug+ #12
[ 1561.722981] Hardware name: TOSHIBA Satellite R630/Portable PC, BIOS 
Version 1.40   07/20/2010
[ 1561.724660] Workqueue: events hci_uart_write_work [hci_uart]
[ 1561.726377] task: ffff98d9b4f15100 task.stack: ffffa868c1178000
[ 1561.728568] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
[ 1561.730355] RSP: 0000:ffffa868c117bda8 EFLAGS: 00010046
[ 1561.731993] RAX: 0000000000000000 RBX: 0000000000000296 RCX: 
0000000000079ad6
[ 1561.733646] RDX: 0000000000000001 RSI: ffff98da77c5c580 RDI: 
0000000000000044
[ 1561.735314] RBP: ffffa868c117bdb0 R08: 000000000001c5a0 R09: 
ffffffff9965a54a
[ 1561.736991] R10: fffff48441dc9a80 R11: ffff98da73403700 R12: 
0000000000000030
[ 1561.738641] R13: 0000000000000044 R14: 0000000000000030 R15: 
ffff98d9b4e50000
[ 1561.740288] FS:  0000000000000000(0000) GS:ffff98da77c40000(0000) 
knlGS:0000000000000000
[ 1561.741940] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1561.743585] CR2: 0000000000000044 CR3: 0000000128d1a000 CR4: 
00000000000006e0
[ 1561.745238] Call Trace:
[ 1561.746882]  skb_dequeue+0x1d/0x70
[ 1561.748512]  bcsp_dequeue+0x27/0x180 [hci_uart]
[ 1561.750130]  ? kfree_skbmem+0x5a/0x60
[ 1561.751742]  hci_uart_write_work+0xc4/0x100 [hci_uart]
[ 1561.753356]  process_one_work+0x151/0x410
[ 1561.754930]  worker_thread+0x69/0x4b0
[ 1561.756507]  kthread+0x114/0x150
[ 1561.758076]  ? rescuer_thread+0x340/0x340
[ 1561.759636]  ? kthread_park+0x90/0x90
[ 1561.761191]  ret_from_fork+0x2c/0x40
[ 1561.762693] Code: 89 e5 e8 82 96 98 ff 5d c3 66 66 66 66 90 55 48 89 
e5 53 9c 58 66 66 90 66 90 48 89 c3 fa 66 66 90 66 66 90 31 c0 ba 01 00 
00 00 <f0> 0f b1 17 85 c0 75 06 48 89 d8 5b 5d c3 89 c6 e8 29 83 98 ff
[ 1561.766034] RIP: _raw_spin_lock_irqsave+0x22/0x40 RSP: ffffa868c117bda8
[ 1561.768033] CR2: 0000000000000044
[ 1561.774555] ---[ end trace 51cc1d3575c0e559 ]---

Please see my analysis in bt_hci_uart_ldisc_crash_snippet_log.txt

With my patchset applied, this crash appears to no longer occur.

If I manage to produce some more useful results then I will post them.

Thanks,

Best regards,
Dean

-- 
Dean Jenkins
Embedded Software Engineer
Linux Transportation Solutions
Mentor Embedded Software Division
Mentor Graphics (UK) Ltd.


--------------993B4B5E08F1A9B7E4997AAE
Content-Type: application/x-compressed-tar; name="v4.10.5_bt_crash_info.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="v4.10.5_bt_crash_info.tgz"

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
9NJLL7308v8p/wOW/NqoAMgAAA==
--------------993B4B5E08F1A9B7E4997AAE--
