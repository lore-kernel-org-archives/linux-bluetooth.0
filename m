Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Dean Jenkins <Dean_Jenkins@mentor.com>, "Gustavo F . Padovan"
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
Subject: [PATCH V1 0/3] hci_ldisc: inhibit "proto" function pointers, avoid crash
Date: Fri, 28 Apr 2017 13:57:23 +0100
Message-ID: <1493384246-15381-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

This is my 2nd patchset in my series of resolving a design flaw in
hci_uart_tty_close() related to the proper closure of the Data Link protocol
layer which can result in a kernel crash.

The 3 patches in this patchset will unmask the design flaw in
hci_uart_tty_close() and provide a partial fix. My future patchsets based on
my original 1st patchset V2 can be discussed at a later date to get a complete
fix.


Previous Discussions
====================

Please refer to the discussion on my 1st patchset V3 that can be found here:
https://www.spinics.net/lists/linux-bluetooth/msg70315.html
You accepted the first 3 patches of my series of commits namely:
  Bluetooth: hci_ldisc: Add missing return in hci_uart_init_work()
  Bluetooth: hci_ldisc: Ensure hu->hdev set to NULL before freeing hdev
  Bluetooth: hci_ldisc: Add missing clear HCI_UART_PROTO_READY

 drivers/bluetooth/hci_ldisc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Please refer to the discussion on my 1st patchset V2 that can be found here:
https://www.spinics.net/lists/linux-bluetooth/msg70183.html

Please refer to the discussion on my 1st RFC patchset V1 that can be found here:
https://www.spinics.net/lists/linux-bluetooth/msg70077.html


Failure test case
=================

Note this failure is probably reproducible on many series 3 and 4 kernels.

Connect a UART based Bluetooth Radio Module via a USB to serial adaptor to a
Linux PC running kernel v4.10.11. This module used the Data Link protocol called
BCSP but that is not too important because the issue is common to all the
Data Link protocols. If the Data Link protocol supports a retransmission
procedure then the probability of a kernel crash is higher.

Use the Bluez utility called btattach to try to use BCSP. Note the BCSP
implementation is incomplete in the kernel so BCSP will not establish a
connection with the Bluetooth Radio Module. However, this is ideal in exposing
the design issue in hci_uart_tty_close() because BCSP performs retransmissions.

I created this simple testcase script to trigger a kernel crash in
approximately 10 minutes of running.

#!/bin/bash

let i=1

while [ true ]
do
        echo "loop $i"
        ./btattach -B /dev/ttyUSB0 -P bcsp -r &
        sleep 5
        echo "now killing..."
        killall btattach
        i=$(($i + 1))
done

I got the following kernel crash after 78 loops.

Here is a snippet of the dmesg log (dynamic debug used) leading up to the crash:

Note BCSP is retransmitting during hci_uart_tty_close() which increases the
probability of crashing.

[ 2932.969451] hci_uart_tty_close: tty ffff8c015f11d400
[ 2932.969455] hci_uart_close: hdev ffff8c01e3ee4000
[ 2932.969458] hci_uart_flush: hdev ffff8c01e3ee4000 tty ffff8c015f11d400
[ 2932.969460] bcsp_flush: hu ffff8c01f0bca240
[ 2932.969465] hci_unregister_dev: ffff8c01e3ee4000 name hci1 bus 3
[ 2933.154206] bcsp_timed_event: hu ffff8c01f0bca240 retransmitting 2 pkts
[ 2933.154231] hci_uart_tx_wakeup: 
[ 2933.154446] bcsp_prepare_pkt: We request packet no 0 to card
[ 2933.154447] bcsp_prepare_pkt: Sending packet with seqno 0
[ 2933.154465] bcsp_prepare_pkt: We request packet no 0 to card
[ 2933.154466] bcsp_prepare_pkt: Sending packet with seqno 1
[ 2933.410201] bcsp_timed_event: hu ffff8c01f0bca240 retransmitting 2 pkts
[ 2933.410240] hci_uart_tx_wakeup: 
[ 2933.410307] bcsp_prepare_pkt: We request packet no 0 to card
[ 2933.410308] bcsp_prepare_pkt: Sending packet with seqno 0
[ 2933.410321] bcsp_prepare_pkt: We request packet no 0 to card
[ 2933.410322] bcsp_prepare_pkt: Sending packet with seqno 1
[ 2933.666198] bcsp_timed_event: hu ffff8c01f0bca240 retransmitting 2 pkts
[ 2933.666225] hci_uart_tx_wakeup: 
< snipped: do not show all BCSP retransmissions that occur every 250ms >
[ 2934.182902] Bluetooth: hci1 command 0x1001 tx timeout
[ 2934.182916] hci_cmd_work: hci1 cmd_cnt 1 cmd queued 1
[ 2934.182920] hci_send_frame: hci1 type 1 len 3
[ 2934.182922] hci_uart_send_frame: hci1: type 1 len 3
[ 2934.182923] hci_uart_tx_wakeup: 
[ 2934.182928] bcsp_prepare_pkt: We request packet no 0 to card
[ 2934.182929] bcsp_prepare_pkt: Sending packet with seqno 2
[ 2934.434214] bcsp_timed_event: hu ffff8c01f0bca240 retransmitting 3 pkts
[ 2934.434217] hci_uart_tx_wakeup: 
[ 2934.434243] bcsp_prepare_pkt: We request packet no 0 to card
[ 2934.434244] bcsp_prepare_pkt: Sending packet with seqno 0
[ 2934.434263] bcsp_prepare_pkt: We request packet no 0 to card
[ 2934.434264] bcsp_prepare_pkt: Sending packet with seqno 1
[ 2934.434268] bcsp_prepare_pkt: We request packet no 0 to card
[ 2934.434269] bcsp_prepare_pkt: Sending packet with seqno 2
[ 2934.690178] bcsp_timed_event: hu ffff8c01f0bca240 retransmitting 3 pkts
[ 2934.690217] hci_uart_tx_wakeup: 
< snipped: do not show all BCSP retransmissions that occur every 250ms >
[ 2936.226215] Bluetooth: hci1 command 0x1009 tx timeout
[ 2936.226233] hci_cmd_work: hci1 cmd_cnt 1 cmd queued 0
[ 2936.226280] bcsp_prepare_pkt: We request packet no 0 to card
[ 2936.226282] bcsp_prepare_pkt: Sending packet with seqno 0
[ 2936.226300] bcsp_prepare_pkt: We request packet no 0 to card
[ 2936.226301] bcsp_prepare_pkt: Sending packet with seqno 1
[ 2936.226304] bcsp_prepare_pkt: We request packet no 0 to card
[ 2936.226306] bcsp_prepare_pkt: Sending packet with seqno 2
[ 2936.482149] bcsp_timed_event: hu ffff8c01f0bca240 retransmitting 3 pkts
[ 2936.482179] hci_uart_tx_wakeup: 
[ 2936.482259] bcsp_prepare_pkt: We request packet no 0 to card
[ 2936.482261] bcsp_prepare_pkt: Sending packet with seqno 0
[ 2936.482280] bcsp_prepare_pkt: We request packet no 0 to card
[ 2936.482281] bcsp_prepare_pkt: Sending packet with seqno 1
[ 2936.482285] bcsp_prepare_pkt: We request packet no 0 to card
[ 2936.482286] bcsp_prepare_pkt: Sending packet with seqno 2
[ 2936.738141] bcsp_timed_event: hu ffff8c01f0bca240 retransmitting 3 pkts
[ 2936.738179] hci_uart_tx_wakeup: 
< snipped: do not show all BCSP retransmissions that occur every 250ms >
[ 2940.066125] hci_uart_tx_wakeup: 
[ 2940.066200] bcsp_prepare_pkt: We request packet no 0 to card
[ 2940.066202] bcsp_prepare_pkt: Sending packet with seqno 0
[ 2940.066221] bcsp_prepare_pkt: We request packet no 0 to card
[ 2940.066223] bcsp_prepare_pkt: Sending packet with seqno 1
[ 2940.066227] bcsp_prepare_pkt: We request packet no 0 to card
[ 2940.066230] bcsp_prepare_pkt: Sending packet with seqno 2
[ 2940.322113] bcsp_timed_event: hu ffff8c01f0bca240 retransmitting 3 pkts
[ 2940.322126] hci_uart_tx_wakeup: 
[ 2940.322147] hci_uart_close: hdev ffff8c01e3ee4000
[ 2940.322149] hci_uart_flush: hdev ffff8c01e3ee4000 tty ffff8c015f11d400
[ 2940.322164] hci_dev_do_close: hci1 ffff8c01e3ee4000
[ 2940.322335] hci_conn_params_clear_all: All LE connection parameters were removed
[ 2940.322340] bcsp_close: hu ffff8c01f0bca240
[ 2940.322667] ftdi_set_termios: ftdi_sio ttyUSB0: Setting CS8
[ 2940.322686] BUG: unable to handle kernel NULL pointer dereference at 0000000000000044
[ 2940.322750] IP: _raw_spin_lock_irqsave+0x22/0x40
[ 2940.322779] PGD 0 
[ 2940.383274] Oops: 0002 [#1] SMP
[ 2940.384001] Modules linked in: hci_uart btqca xt_set ip_set_hash_ip ip_set nf_log_ipv4 nf_log_ipv6 nf_log_common xt_LOG ip6table_nat nf_nat_ipv6 xt_recent iptable_nat nf_nat_ipv4 ip6t_REJECT nf_reject_ipv6 xt_comment ip6table_mangle ipt_REJECT nf_reject_ipv4 xt_addrtype bridge stp llc xt_mark iptable_mangle xt_tcpudp iptable_raw nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_tftp xt_CT nf_nat_snmp_basic nf_conntrack_snmp nf_nat_sip nf_nat_pptp nf_nat_proto_gre ip6table_raw nf_nat_irc xt_multiport nf_nat_h323 nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ftp nf_nat_amanda nf_nat xt_conntrack nf_conntrack_sane nf_conntrack_tftp ts_kmp nf_conntrack_sip nf_conntrack_amanda nf_conntrack_pptp nf_conntrack_proto_gre nf_conntrack_netlink nfnetlink nf_conntrack_netbios_ns nf_conntrack_broadcast nf_conntrack_irc nf_conntrack_h323
[ 2940.388162]  nf_conntrack_ftp nf_conntrack ip6table_filter ip6_tables iptable_filter ip_tables x_tables lockd grace ctr ccm af_packet bnep msr arc4 brcmsmac uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 cordic btusb btrtl ftdi_sio brcmutil btbcm videobuf2_core btintel mac80211 usbserial bluetooth intel_powerclamp videodev coretemp kvm_intel kvm media snd_hda_codec_hdmi snd_hda_codec_realtek cfg80211 snd_hda_codec_generic snd_hda_intel joydev snd_hda_codec iTCO_wdt irqbypass snd_hda_core toshiba_acpi sparse_keymap iTCO_vendor_support crc32c_intel bcma industrialio snd_hwdep snd_pcm psmouse toshiba_bluetooth snd_timer input_leds serio_raw mei_me rfkill ac e1000e snd thermal wmi shpchp intel_ips battery toshiba_haps soundcore fjes lpc_ich mei ptp pps_core tpm_tis tpm_tis_core tpm cpufreq_ondemand
[ 2940.393216]  cpufreq_conservative cpufreq_powersave acpi_cpufreq evdev nvram sunrpc sch_fq_codel ipv6 crc_ccitt autofs4 hid_generic usbhid hid sdhci_pci mmc_block sr_mod sdhci ehci_pci ehci_hcd mmc_core usbcore usb_common i915 video button i2c_algo_bit drm_kms_helper drm
[ 2940.395473] CPU: 3 PID: 6669 Comm: kworker/3:1 Not tainted 4.10.11_pure #1
[ 2940.396606] Hardware name: TOSHIBA Satellite R630/Portable PC, BIOS Version 1.40   07/20/2010
[ 2940.397763] Workqueue: events hci_uart_write_work [hci_uart]
[ 2940.399076] task: ffff8c01f2883600 task.stack: ffffb2a704d34000
[ 2940.400360] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
[ 2940.401511] RSP: 0018:ffffb2a704d37da8 EFLAGS: 00010046
[ 2940.402660] RAX: 0000000000000000 RBX: 0000000000000296 RCX: ffff8c01f2883600
[ 2940.403829] RDX: 0000000000000001 RSI: ffff8c01f7cd8ba0 RDI: 0000000000000044
[ 2940.404995] RBP: ffffb2a704d37db0 R08: ffff8c01f7cd8b80 R09: 00000000000001f9
[ 2940.406157] R10: 000002ac98e2f8d0 R11: 0000000000000001 R12: 0000000000000030
[ 2940.407317] R13: 0000000000000044 R14: 0000000000000030 R15: ffff8c01f0bca780
[ 2940.408495] FS:  0000000000000000(0000) GS:ffff8c01f7cc0000(0000) knlGS:0000000000000000
[ 2940.409671] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2940.410845] CR2: 0000000000000044 CR3: 00000001306fb000 CR4: 00000000000006e0
[ 2940.412049] Call Trace:
[ 2940.413276]  skb_dequeue+0x1d/0x70
[ 2940.414511]  bcsp_dequeue+0x27/0x180 [hci_uart]
[ 2940.415760]  hci_uart_write_work+0xc4/0x100 [hci_uart]
[ 2940.417012]  process_one_work+0x151/0x410
[ 2940.418248]  worker_thread+0x69/0x4b0
[ 2940.419494]  kthread+0x114/0x150
[ 2940.420753]  ? rescuer_thread+0x340/0x340
[ 2940.422017]  ? kthread_park+0x90/0x90
[ 2940.423295]  ret_from_fork+0x2c/0x40
[ 2940.424563] Code: 89 e5 e8 22 55 98 ff 5d c3 66 66 66 66 90 55 48 89 e5 53 9c 58 66 66 90 66 90 48 89 c3 fa 66 66 90 66 66 90 31 c0 ba 01 00 00 00 <f0> 0f b1 17 85 c0 75 06 48 89 d8 5b 5d c3 89 c6 e8 c9 41 98 ff 
[ 2940.427448] RIP: _raw_spin_lock_irqsave+0x22/0x40 RSP: ffffb2a704d37da8
[ 2940.428956] CR2: 0000000000000044
[ 2940.435363] ---[ end trace 26e358778a5b55c5 ]---


Analysis
========

The kernel crashes because the work queue hu->write_work runs
hci_uart_write_work() which attempts to dequeue a Data Layer protocol frame
using hu->proto->dequeue(). Unfortunately, hci_uart_tty_close() has already
called hu->proto->close() which removes the resources needed by
hu->proto->dequeue() and a kernel crash occurs.

Assuming device is hci0 (my actual test used hci1). 
hciattach or btattach can be used and are examples.

Example normal case scenario:
-----------------------------

1. hciconfig hci0 up ==> hci_dev_do_open() and sets HCI_UP

2. hciconfig hci0 down ==> hci_dev_do_close() and clears HCI_UP

3. killall hciattach ==> hci_dev_do_close() exits early as HCI_UP is clear

Notice that hci_dev_do_close() runs twice.

There is probably many seconds between these events so the HCI layer is likely
to be idle before hci_uart_tty_close() runs. Therefore, in an environment where
the communications with the Bluetooth Radio Module are good, the kernel crash is
very unlikely to occur.

Example failure case scenario:
------------------------------

1. hciconfig hci0 up ==> hci_dev_do_open() and sets HCI_UP

2. killall hciattach ==> hci_dev_do_close() and clears HCI_UP

In the failure case, hci_dev_do_close() attempts to perform clean-up because
HCI_UP is in the set state. hci_dev_do_close() is running in the callstack:

hci_uart_tty_close()
hci_unregister_dev()
hci_dev_do_close()

hci_uart_tty_close() is acting against hci_dev_do_close() by systematically
inhibiting various aspects of the data plane between the Data Link protocol
layer and the UART driver. This seems to be a design flaw; either allow
successful transmissions OR fully inhibit transmissions. Unfortunately, the
design is attempting both at the same time.

When hci_unregister_dev() returns to hci_uart_tty_close(), 1 or
more HCI commands might have been queued inside the Data Link protocol layer by
hu->proto->enqueue(). The Data Link protocol layer may attempt to periodically
retransmit these HCI commands.

In any case, attempts at sending any HCI commands will fail during the
execution of hci_uart_tty_close() because the data plane between the Data Link
protocol Layer and the UART driver has been cut in various places including
inside the TTY layer.

The weakness in hci_uart_tty_close() is that hu->proto->close() is not prevented
from running before or during the execution of the other "proto" function
pointers such as hu->proto->dequeue(). Therefore a race condition exists.


Solution implemented by this patchset
=====================================

When the flag HCI_UART_PROTO_READY is in the clear state, this means the "proto"
layer is no longer ready. Therefore use HCI_UART_PROTO_READY to prevent any
"proto" function pointer except hu->proto->close() from running.

Already protected:
p->open() in hci_uart_set_proto()
hu->proto->flush() in hci_uart_flush()
hu->proto->close() in hci_uart_tty_close()
p->close() in hci_uart_set_proto()
hu->proto->close() in hci_uart_init_work()

The following "proto" functions pointers are now protected by the patchset:
hu->proto->enqueue() in hci_uart_send_frame()
hu->proto->dequeue() in hci_uart_dequeue()

by the implementations in the patches:
  Bluetooth: hci_ldisc: Add protocol check to hci_uart_send_frame()
  Bluetooth: hci_ldisc: Add protocol check to hci_uart_dequeue()

This protection helps to avoid the kernel crash by ensuring that a "proto"
function pointer except hu->proto->close() does not run after
HCI_UART_PROTO_READY has been cleared in hci_uart_tty_close().

However, a complete solution (not implemented in this patchset) requires locking
to prevent hu->proto->close() from running whilst another "proto" function
pointer is already running. The flag HCI_UART_PROTO_READY is insufficient
because another "proto" function pointer may already be running at the point the
flag is cleared.

In addition the patch:
  Bluetooth: hci_ldisc: Add protocol check to hci_uart_tx_wakeup()

prevents the scheduling of new or retransmitted HCI commands from being queued
on the work queue hu->write_work so that hci_uart_write_work() is not able to
run when HCI_UART_PROTO_READY is in the cleared state. This inhibits
transmission attempts so reduces the probability of hci_uart_write_work()
running after hu->proto->close() has run.


Test results with patchset applied
==================================

snippet of dmesg log

[ 1122.904072] hci_uart_tty_close: tty ffff91b59c41c000
[ 1122.904075] hci_uart_close: hdev ffff91b59c456000
[ 1122.904078] hci_uart_flush: hdev ffff91b59c456000 tty ffff91b59c41c000
[ 1122.904080] bcsp_flush: hu ffff91b5a29340c0
[ 1122.904085] hci_unregister_dev: ffff91b59c456000 name hci1 bus 3
[ 1122.984911] bcsp_timed_event: hu ffff91b5a29340c0 retransmitting 2 pkts
[ 1124.520958] Bluetooth: hci1 command 0x1001 tx timeout
[ 1124.521009] hci_cmd_work: hci1 cmd_cnt 1 cmd queued 1
[ 1124.521013] hci_send_frame: hci1 type 1 len 3
[ 1124.521015] hci_uart_send_frame: hci1: type 1 len 3
[ 1124.521016] Bluetooth: hci1 sending frame failed (-49)
[ 1126.569048] Bluetooth: hci1 command 0x1009 tx timeout
[ 1126.569065] hci_cmd_work: hci1 cmd_cnt 1 cmd queued 0
[ 1130.665151] hci_uart_close: hdev ffff91b59c456000
[ 1130.665154] hci_uart_flush: hdev ffff91b59c456000 tty ffff91b59c41c000
[ 1130.665173] hci_dev_do_close: hci1 ffff91b59c456000
[ 1130.665357] hci_conn_params_clear_all: All LE connection parameters were removed
[ 1130.665361] bcsp_close: hu ffff91b5a29340c0

Notice the following error message is now output:
Bluetooth: hci1 sending frame failed (-49)

This is because the patch
  Bluetooth: hci_ldisc: Add protocol check to hci_uart_send_frame()

is preventing hci_send_frame() from calling hu->proto->enqueue() after
hci_uart_tty_close() has cleared the flag HCI_UART_PROTO_READY. Therefore,
no new HCI commands can be queued within the Data Link protocol layer because
the Data Link protocol layer is pending to be closed.


Conclusions
===========

This patchset demonstrates the following design issues:

1. Attempts are made at trying to send HCI commands during hci_uart_tty_close()
   but this is in conflict with the hci_uart_tty_close() closure procedures.

2. Data Link protocol layer retransmission attempts can occur during
   hci_uart_tty_close() to resend HCI commands but this is in conflict with the
   hci_uart_tty_close() closure procedures.

3. Sending of HCI commands fail anyway during hci_uart_tty_close() because
   the data plane between the Data Link protocol layer and the UART driver has
   been cut in various places including inside the TTY layer. Therefore the
   attempts at sending HCI commands during hci_uart_tty_close() are futile.

This means that, currently the design is attempting to send HCI commands AND
trying to inhibit transmissions at the same time. Therefore, there is a conflict
in the procedures.

The design of hci_uart_tty_close() needs to be changed to either
a) allow sucessful transmission of HCI commands and implement a clean controlled
   closure of the Data Link protocol.
OR
b) abruptly inhibit further communications of the Data Link protocol.


Side-effects
------------

The patchset should be safe although a side-effect could be some occassional
error messages:
Bluetooth: hci1 sending frame failed (-49)

Note hci_send_frame() does not propagate the -EUNATCH (-49) error code so takes
no specific action. Therefore, hci_core.c handling is not modified by the
patchset.


Dean Jenkins (3):
  Bluetooth: hci_ldisc: Add protocol check to hci_uart_send_frame()
  Bluetooth: hci_ldisc: Add protocol check to hci_uart_dequeue()
  Bluetooth: hci_ldisc: Add protocol check to hci_uart_tx_wakeup()

 drivers/bluetooth/hci_ldisc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

-- 
2.7.4
