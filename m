Return-Path: <Dean_Jenkins@mentor.com>
Subject: Re: [RFC V1 00/16] hci_ldisc hci_uart_tty_close() fixes
To: Marcel Holtmann <marcel@holtmann.org>
References: <1490723429-28870-1-git-send-email-Dean_Jenkins@mentor.com>
 <AA3DD0DD-5CAC-4ADD-9B0C-4E652C93E4D6@holtmann.org>
 <ee49f939-1094-0ae0-0fa7-6c5cad112527@mentor.com>
 <119BB9FC-C735-405B-9A77-E9F102393B7D@holtmann.org>
 <3662704c-dfd4-67db-a2f9-45c949c45c6c@mentor.com>
CC: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, <linux-bluetooth@vger.kernel.org>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
Message-ID: <ca51d648-55b9-fca8-d4b4-f19aa637197f@mentor.com>
Date: Wed, 5 Apr 2017 16:28:32 +0100
MIME-Version: 1.0
In-Reply-To: <3662704c-dfd4-67db-a2f9-45c949c45c6c@mentor.com>
Content-Type: multipart/mixed;
	boundary="------------9DD444AF402A56F7CF4581E6"
List-ID: <linux-bluetooth.vger.kernel.org>

--------------9DD444AF402A56F7CF4581E6
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

On 04/04/17 21:36, Dean Jenkins wrote:
>
>
> On 03/04/17 16:51, Marcel Holtmann wrote:
>>
>> If this is an issue in 4.10, then lets get this fixed / hardened.
>>
>
> If I manage to produce some more useful results then I will post them.
>

I have now managed to crash the h4 Data Link protocol layer via 
hci_uart_tty_close().

This confirms that there is a design flaw in hci_uart_tty_close() which 
is independent of the Bluetooth Data Link protocol layers.

I don't have a Bluetooth Radio Module that uses h4 protocol so I used my 
BCSP enabled Bluetooth Radio Module that has a USB to serial interface. 
I realise that this is a weird setup but it is OK for this testcase 
because we need the h4 protocol to be timing out for transmissions. Also 
the BCSP Bluetooth Radio Module may send BCSP frames which will exercise 
the h4 receive path although rejection of the frames should occur which 
is as expected.

Please see the attached tarball v4.10.5.h4_crash.tgz, the contents are:
v4.10.5.h4_crash/
v4.10.5.h4_crash/0001-btattach-Add-option-r-for-sending-HCI-RESET-on-close.patch
v4.10.5.h4_crash/0002-btattach-Fix-raw_device-flag-usage.patch
v4.10.5.h4_crash/0001-Bluetooth-Debug-shows-how-hci_uart_tty_close-is-call.patch
v4.10.5.h4_crash/enable_hci_bt_logging.sh
v4.10.5.h4_crash/btattach_loop_h4.sh
v4.10.5.h4_crash/bt_hci_uart_ldisc_h4_crash_snippet_log.txt


0001-btattach-Add-option-r-for-sending-HCI-RESET-on-close.patch
0002-btattach-Fix-raw_device-flag-usage.patch
These btattach patches add a command line option -r to override 
HCI_UART_RESET_ON_INIT so that the kernel HCI UART LDISC component can 
use the quirk HCI_QUIRK_RESET_ON_CLOSE. This means hci_uart_tty_close() 
is allowed to a send a HCI RESET command during closure of the HCI UART 
LDISC which increases the probability of a kernel crash occurring due to 
the design flaw in hci_uart_tty_close().


0001-Bluetooth-Debug-shows-how-hci_uart_tty_close-is-call.patch
is a kernel patch for v4.10.5 to add some debug to show when 
hci_uart_tty_close() gets called.

enable_hci_bt_logging.sh
Enabled dynamic debug of some Bluetooth files to allow dmesg to show 
when the Bluetooth functions run. However, this seems unreliable and the 
script needs to be run multiple times to get all the files to log properly.

btattach_loop_h4.sh
is a simple test script, and the content is:

#!/bin/bash

let i=1

while [ true ]
do
     echo "loop $i"
     ./btattach -A /dev/ttyUSB0 -P h4 -r &
     sleep 5
     echo "now killing..."
     killall btattach
     i=$(($i + 1))
done

Note that I used my -r option. I suspect I should of used -B option, sigh.

Here is the kernel crash backtrace from 
bt_hci_uart_ldisc_h4_crash_snippet_log.txt, it seems easy to reproduce:

[  563.702430] BUG: unable to handle kernel NULL pointer dereference at 
000000000000001c
[  563.702491] IP: _raw_spin_lock_irqsave+0x22/0x40
[  563.702520] PGD 13230e067
[  563.702521] PUD 1238d6067
[  563.702540] PMD 0

[  563.704521] Oops: 0002 [#1] SMP
[  563.706215] Modules linked in: hci_uart btqca nf_log_ipv6 
ip6table_nat nf_nat_ipv6 ip6t_REJECT nf_reject_ipv6 ip6table_mangle 
xt_set ip_set_hash_ip ip_set nf_log_ipv4 nf_log_common xt_LOG xt_recent 
iptable_nat nf_nat_ipv4 xt_comment ipt_REJECT nf_reject_ipv4 xt_addrtype 
bridge stp llc xt_mark iptable_mangle xt_tcpudp iptable_raw 
nf_conntrack_ipv4 nf_defrag_ipv4 xt_CT nf_nat_tftp nf_nat_snmp_basic 
nf_conntrack_snmp ip6table_raw nf_nat_sip xt_multiport nf_nat_pptp 
nf_nat_proto_gre nf_nat_irc nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_h323 
nf_nat_ftp xt_conntrack nf_nat_amanda nf_nat nf_conntrack_tftp 
nf_conntrack_sip nf_conntrack_sane nf_conntrack_pptp 
nf_conntrack_proto_gre nf_conntrack_netlink nfnetlink 
nf_conntrack_netbios_ns nf_conntrack_broadcast nf_conntrack_irc 
nf_conntrack_h323 nf_conntrack_ftp
[  563.715634]  ts_kmp nf_conntrack_amanda nf_conntrack iptable_filter 
ip_tables ip6table_filter ip6_tables x_tables lockd grace ctr ccm 
af_packet bnep msr arc4 brcmsmac uvcvideo cordic brcmutil ftdi_sio 
videobuf2_vmalloc usbserial intel_powerclamp mac80211 videobuf2_memops 
btusb videobuf2_v4l2 btrtl coretemp snd_hda_codec_hdmi btbcm 
videobuf2_core btintel kvm_intel snd_hda_codec_realtek bluetooth kvm 
videodev joydev cfg80211 snd_hda_codec_generic media snd_hda_intel 
snd_hda_codec psmouse snd_hda_core irqbypass e1000e snd_hwdep input_leds 
snd_pcm iTCO_wdt iTCO_vendor_support serio_raw crc32c_intel toshiba_acpi 
snd_timer ptp mei_me fjes bcma snd mei thermal sparse_keymap 
toshiba_haps industrialio lpc_ich soundcore battery ac pps_core shpchp 
intel_ips toshiba_bluetooth wmi rfkill tpm_tis tpm_tis_core
[  563.726159]  tpm cpufreq_ondemand cpufreq_conservative 
cpufreq_powersave acpi_cpufreq evdev nvram sunrpc sch_fq_codel ipv6 
crc_ccitt autofs4 hid_generic usbhid hid sdhci_pci mmc_block sdhci 
sr_mod ehci_pci ehci_hcd mmc_core usbcore usb_common i915 video button 
i2c_algo_bit drm_kms_helper drm
[  563.730623] CPU: 0 PID: 29 Comm: kworker/0:1 Not tainted 
4.10.54.10.5_debug+ #13
[  563.732862] Hardware name: TOSHIBA Satellite R630/Portable PC, BIOS 
Version 1.40   07/20/2010
[  563.735127] Workqueue: events hci_uart_write_work [hci_uart]
[  563.737376] task: ffffa03f32951b00 task.stack: ffffbc4ec0768000
[  563.739620] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
[  563.741839] RSP: 0018:ffffbc4ec076bdd8 EFLAGS: 00010046
[  563.744059] RAX: 0000000000000000 RBX: 0000000000000202 RCX: 
ffffa03f37c1cd60
[  563.746286] RDX: 0000000000000001 RSI: ffffa03f37c18ae0 RDI: 
000000000000001c
[  563.748493] RBP: ffffbc4ec076bde0 R08: ffffa03f32332380 R09: 
0000000000000001
[  563.750690] R10: ffffe9de427ce800 R11: ffffa03f33498600 R12: 
0000000000000008
[  563.752884] R13: 000000000000001c R14: ffffa03e79b1ad38 R15: 
ffffa03e79b1a240
[  563.755075] FS:  0000000000000000(0000) GS:ffffa03f37c00000(0000) 
knlGS:0000000000000000
[  563.757260] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  563.759426] CR2: 000000000000001c CR3: 000000011d7a3000 CR4: 
00000000000006f0
[  563.761610] Call Trace:
[  563.763798]  skb_dequeue+0x1d/0x70
[  563.765975]  h4_dequeue+0x16/0x20 [hci_uart]
[  563.768128]  hci_uart_write_work+0xc4/0x100 [hci_uart]
[  563.770262]  process_one_work+0x151/0x410
[  563.772368]  worker_thread+0x69/0x4b0
[  563.774466]  kthread+0x114/0x150
[  563.776519]  ? rescuer_thread+0x340/0x340
[  563.778546]  ? kthread_park+0x90/0x90
[  563.780566]  ret_from_fork+0x2c/0x40
[  563.782559] Code: 89 e5 e8 82 96 98 ff 5d c3 66 66 66 66 90 55 48 89 
e5 53 9c 58 66 66 90 66 90 48 89 c3 fa 66 66 90 66 66 90 31 c0 ba 01 00 
00 00 <f0> 0f b1 17 85 c0 75 06 48 89 d8 5b 5d c3 89 c6 e8 29 83 98 ff
[  563.786800] RIP: _raw_spin_lock_irqsave+0x22/0x40 RSP: ffffbc4ec076bdd8
[  563.788940] CR2: 000000000000001c
[  563.798389] ---[ end trace 326429e7baa9f359 ]---

Please see my analysis in bt_hci_uart_ldisc_h4_crash_snippet_log.txt

With my patchset applied, this crash does not occur because locking is 
present which inhibits the Data Link protocol layer's dequeue function 
from running when the Data Link protocol layer is about to be closed down.

I will try to provide some "good" logs of my patchset with btattach 
using BCSP.

Thanks,

Best regards,
Dean

-- 
Dean Jenkins
Embedded Software Engineer
Linux Transportation Solutions
Mentor Embedded Software Division
Mentor Graphics (UK) Ltd.


--------------9DD444AF402A56F7CF4581E6
Content-Type: application/x-compressed-tar; name="v4.10.5.h4_crash.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="v4.10.5.h4_crash.tgz"

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
--------------9DD444AF402A56F7CF4581E6--
