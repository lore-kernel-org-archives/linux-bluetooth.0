Return-Path: <SRS0=sr2f=PQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28999C43387
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jan 2019 18:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08BD20883
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jan 2019 18:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4noq44m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfAHS6B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:58:01 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38607 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfAHS6A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jan 2019 13:58:00 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so5159796wrw.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jan 2019 10:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:openpgp:autocrypt:message-id:date:mime-version
         :content-language;
        bh=VUb3MxnPBZ+xE/Fl74CCCAGAJmsKxVbaamAE5gkSkmQ=;
        b=G4noq44mDjJtLo+e+G/DaHCjXDDGoxgYrQxV64EBsHIFqKC9DNpIe7dPu4uw1CN5GB
         ZbjsW/fJLGGxfAQ0Q03TRVwFf5uRhQlX4rrD6k7aJMfSUVTrzpaESUvoxcb6BMw5WGFl
         7Q1seaSbimhmzhITYFc0+vBY3vlTsjTV06tWvNVZ0UcHJdSuR+P5sz5A5FzY2X42+GzJ
         yo4GeTDL2etvvZyu52GoyyAqjYYcwwQcqqlLT440zIlqkLlHVpN/VgP8wdUdpUYS7MJL
         xBA40dA7t1i8S0ajl/T9BGaGi52Chy6oTU+unGuAV+nTXwsYPIcmCv4kLIQ7RB0SdePn
         44yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:openpgp:autocrypt:message-id
         :date:mime-version:content-language;
        bh=VUb3MxnPBZ+xE/Fl74CCCAGAJmsKxVbaamAE5gkSkmQ=;
        b=CT323/8noTF+wXVUK2/Pd1oA8NBn5qKyEBgOeLJ56KdL/SzqXL/KgQZ8S6UFivovQ5
         SezEW8La5bUwz3qah83U1dvLU50r6wsRKBO4UWLrfiRiTDkAtdNUT83eHUrB1k+T5/0B
         URvEgQtZcFvODUM1yshlzH1vM8NEfoFxFjuRXhxtd3u+5Fw3Ve4IvBmqyicrSt3kUv5l
         lVPWVoHGuDIyZ+k7II3oaB5FxoPwf/+ytVPDQKcPf1aKtjVQwB47o1GCrHGH9UobWqfm
         xHIiCyVIDGOs7+bEDho8GVU8CAXPwyVVHFP7CDAMW4GSmjuYYp1mabfo7J0zo94+gn9G
         x2+Q==
X-Gm-Message-State: AJcUukdsJGpLFcx1o7xm9N6CczRy5/3p9SDAkd2fbMBQLLkQYNmatczD
        ngDn8B/E4TelnJaeLiMyfZVHd/X3fQk=
X-Google-Smtp-Source: ALg8bN5K1kDRwfl+0Gqi51D2eBIdR+ea7UgRvEyUxhexnOeBs14rRq5ivJbI1lgi/dTSQZesjgJB0g==
X-Received: by 2002:adf:f4c2:: with SMTP id h2mr2269981wrp.21.1546973875418;
        Tue, 08 Jan 2019 10:57:55 -0800 (PST)
Received: from [192.168.2.164] (p5B08A983.dip0.t-ipconnect.de. [91.8.169.131])
        by smtp.gmail.com with ESMTPSA id l14sm132824768wrp.55.2019.01.08.10.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 10:57:54 -0800 (PST)
From:   Josua Mayer <josua.mayer97@gmail.com>
Subject: Multiple peers with bluetooth_6lowpan
To:     linux-bluetooth@vger.kernel.org
Openpgp: preference=signencrypt
Autocrypt: addr=josua.mayer97@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b0665aa8-4bfb-4ec8-3f7f-deb2bf5ea61a@gmail.com>
Date:   Tue, 8 Jan 2019 19:57:53 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------06F94660B77E24F49C24DD51"
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is a multi-part message in MIME format.
--------------06F94660B77E24F49C24DD51
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Greetings everybody,

I want to present to you an issue I am having the 6LoWPAN over BLE
facility in the kernel.
I have reached the point where I don't know where, what and how to debug
the situation and am hoping for some advice here:

First an overview of the setup:
1. an SBC with BLE capable Bluetooth chip
2. multiple Nordic nRF52840 modules

This is the problem I have observed:
1. One Nordic module is powered - SBC connects to it
--> ping6 works flawlessly till the module restarts
--> communication with the remote server works as expected

2. Two Nordic modules are powered - SBC connects only to one at a time
--> ping6 works flawlessly till the module restarts
--> communication with the remote server works as expected

3. Two Nordic modules are powered - SBC connects to both
--> ping6 receives no more replies as soon as the second module is connected
--> communication to the remote server stops as soon as the second
module is connected

Test Case:
rfkill unblock 0
modprobe bluetooth_6lowpan
echo -n 'module bluetooth_6lowpan +p' >
/sys/kernel/debug/dynamic_debug/control

while true; do ping6 -c 1 -I bt0 fe80::b1:fcff:fe8c:6e47 || true; sleep
1; done

echo "Connecting to first module while both are powered" > /dev/kmsg
echo "connect 00:B1:FC:8C:6E:47 1" >
/sys/kernel/debug/bluetooth/6lowpan_control
# sit back and watch pings till module restarts
echo "Connecting to first module while both are powered" > /dev/kmsg
echo "connect 00:B1:FC:8C:6E:47 1" >
/sys/kernel/debug/bluetooth/6lowpan_control
# wait till first ping goes through
echo "Connecting to second module" > /dev/kmsg
echo "connect 00:39:D3:29:92:1C 1" >
/sys/kernel/debug/bluetooth/6lowpan_control
# Expected: ping6 continues to receive replies
# Actual result: ping6 times out

Please see attached dmesg.log from this test case, with dynamic
debugging enabled for module bluetooth_6lowpan.

The Nordic modules are programmed to advertise themselves for
establishing a connection; Then they start communication with a server
on the internet over ipv6. Finally they are rebooted by a watchdog.
While a module is connected, it can be pinged by its link-local address
which is derived from its MAC address and thereby known.

As you may have noticed I just wrote "SBC" above.
That is because I have done this experiment with 3 different SBCs:
1. SolidRun HummingBoard with i.MX6 uSOM Revision 1.5
features Ti WL18MODGB combined WiFi and Bluetooth module
- linux-image-4.20.0-trunk-armmp_4.20-1~exp2_armhf.deb
(+BT_HCIUART=m, +BT_HCIUART_LL=y, +DYNAMIC_DEBUG=y)
^^ This system was used to produce the attached dmesg.log

2. RaspberryPi 3B
3. RaspberryPi 3B+
- rpi-4.15.y (from their github)
- rpi-4.16.y (from their github)
- rpi-4.17.y (from their github)
- rpi-4.18.y (from their github)
- rpi-4.19.y (from their github)
- rpi-4.20.y (from their github)
bcm2709_defconfig
zImage modules dtbs -j12
gcc-linaro-7.3.1-2018.05-x86_64_arm-linux-gnueabihf

rpi-4.14.y suffers from a busy kworker (Workqueue: hci0 hci_rx_work
[bluetooth]) making tests difficult.

Supposedly back in 4.4.8-v7 on raspberrypi this issue with multiple
peers did not exist, while the busy kworker did pop up after time
requring a reboot.
I did not verify or test with that rather old version yet.
Would it be a good idea to start from that 4.4.8 rpi fork working up to
4.15 to find the place where it broke? I feel like this kind of work is
difficult
when forks are involved.

Are there any components of the kernel in particular that could be verified
in order to figure out what is going wrong?


Yours sincerely
Josua Mayer

--------------06F94660B77E24F49C24DD51
Content-Type: text/x-log;
 name="dmesg.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.log"

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.20.0-trunk-armmp (debian-kernel@lists.debian.org) (gcc version 8.2.0 (Debian 8.2.0-11)) #1 SMP Debian 4.20-1~exp2 (2018-12-26)
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt: Machine model: SolidRun HummingBoard2 Dual/Quad (1.5som+emmc)
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: UEFI not found.
[    0.000000] cma: Reserved 16 MiB at 0x8f000000
[    0.000000] On node 0 totalpages: 524288
[    0.000000]   Normal zone: 1728 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 196608 pages, LIFO batch:63
[    0.000000]   HighMem zone: 327680 pages, LIFO batch:63
[    0.000000] random: get_random_bytes called from start_kernel+0xa0/0x500 with crng_init=0
[    0.000000] percpu: Embedded 17 pages/cpu @(ptrval) s38860 r8192 d22580 u69632
[    0.000000] pcpu-alloc: s38860 r8192 d22580 u69632 alloc=17*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 522560
[    0.000000] Kernel command line: root=UUID=b672b195-0858-41c1-8c52-224fb06a4ea9 rootfstype=ext4 rootwait log_buf_len=131072
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 2026904K/2097152K available (9216K kernel code, 1076K rwdata, 2604K rodata, 2048K init, 307K bss, 53864K reserved, 16384K cma-reserved, 1294336K highmem)
[    0.000000] Virtual kernel memory layout:
                   vector  : 0xffff0000 - 0xffff1000   (   4 kB)
                   fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
                   vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
                   lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
                   pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
                   modules : 0xbf000000 - 0xbfe00000   (  14 MB)
                     .text : 0x(ptrval) - 0x(ptrval)   (10208 kB)
                     .init : 0x(ptrval) - 0x(ptrval)   (2048 kB)
                     .data : 0x(ptrval) - 0x(ptrval)   (1077 kB)
                      .bss : 0x(ptrval) - 0x(ptrval)   ( 308 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] ftrace: allocating 32635 entries in 64 pages
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] L2C-310 errata 752271 769419 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 16 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76470001
[    0.000000] Switching to timer-based delay loop, resolution 333ns
[    0.000007] sched_clock: 32 bits at 3000kHz, resolution 333ns, wraps every 715827882841ns
[    0.000028] clocksource: mxc_timer1: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 637086815595 ns
[    0.002781] Console: colour dummy device 80x30
[    0.003301] printk: console [tty0] enabled
[    0.003352] Calibrating delay loop (skipped), value calculated using timer frequency.. 6.00 BogoMIPS (lpj=12000)
[    0.003384] pid_max: default: 32768 minimum: 301
[    0.003705] LSM: Security Framework initializing
[    0.003727] Yama: disabled by default; enable with sysctl kernel.yama.*
[    0.003836] AppArmor: AppArmor initialized
[    0.003969] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.004003] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.005048] CPU: Testing write buffer coherency: ok
[    0.005095] CPU0: Spectre v2: using BPIALL workaround
[    0.005454] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.006263] Setting up static identity map for 0x10300000 - 0x103000a0
[    0.007865] rcu: Hierarchical SRCU implementation.
[    0.011650] EFI services will not be available.
[    0.012179] smp: Bringing up secondary CPUs ...
[    0.013107] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.013114] CPU1: Spectre v2: using BPIALL workaround
[    0.014162] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.014168] CPU2: Spectre v2: using BPIALL workaround
[    0.015171] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.015178] CPU3: Spectre v2: using BPIALL workaround
[    0.015336] smp: Brought up 1 node, 4 CPUs
[    0.015361] SMP: Total of 4 processors activated (24.00 BogoMIPS).
[    0.015379] CPU: All CPU(s) started in SVC mode.
[    0.016778] devtmpfs: initialized
[    0.026367] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
[    0.026709] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.026752] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.028151] pinctrl core: initialized pinctrl subsystem
[    0.029659] DMI not present or invalid.
[    0.030122] NET: Registered protocol family 16
[    0.033877] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.034745] audit: initializing netlink subsys (disabled)
[    0.035017] audit: type=2000 audit(0.032:1): state=initialized audit_enabled=0 res=1
[    0.036755] CPU identified as i.MX6Q, silicon rev 1.5
[    0.059533] No ATAGs?
[    0.059694] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
[    0.059736] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.061696] imx6q-pinctrl 20e0000.iomuxc: initialized IMX pinctrl driver
[    0.063146] Serial: AMBA PL011 UART driver
[    0.085862] mxs-dma 110000.dma-apbh: initialized
[    0.088441] vcc_3v3: supplied by v_3v2
[    0.088519] nvcc_sd1: supplied by vcc_3v3
[    0.088731] vcc_1p8: supplied by v_3v2
[    0.089267] v_sd: supplied by v_3v2
[    0.091687] v_usb1: supplied by v_5v0
[    0.092175] v_usb2: supplied by v_5v0
[    0.092663] v_usb3: supplied by v_5v0
[    0.093161] v_usb4: supplied by v_5v0
[    0.097153] vgaarb: loaded
[    0.098633] media: Linux media interface: v0.10
[    0.098695] videodev: Linux video capture interface: v2.00
[    0.098764] pps_core: LinuxPPS API ver. 1 registered
[    0.098782] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.098822] PTP clock support registered
[    0.100686] clocksource: Switched to clocksource mxc_timer1
[    0.183913] VFS: Disk quotas dquot_6.6.0
[    0.184048] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.184797] AppArmor: AppArmor Filesystem Enabled
[    0.197565] NET: Registered protocol family 2
[    0.198544] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes)
[    0.198607] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.198713] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.198881] TCP: Hash tables configured (established 8192 bind 8192)
[    0.199144] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.199208] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.199527] NET: Registered protocol family 1
[    0.199576] PCI: CLS 0 bytes, default 64
[    0.200084] Unpacking initramfs...
[    1.740863] Freeing initrd memory: 18472K
[    1.741490] hw perfevents: no interrupt-affinity property for /pmu, guessing.
[    1.741824] hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7 counters available
[    1.744889] Initialise system trusted keyrings
[    1.745187] workingset: timestamp_bits=14 max_order=19 bucket_order=5
[    1.752694] zbud: loaded
[    6.584404] Key type asymmetric registered
[    6.584440] Asymmetric key parser 'x509' registered
[    6.584525] bounce: pool size: 64 pages
[    6.584598] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[    6.584897] io scheduler noop registered
[    6.584919] io scheduler deadline registered
[    6.585158] io scheduler cfq registered (default)
[    6.585180] io scheduler mq-deadline registered
[    6.595428] imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 ranges:
[    6.595485] imx6q-pcie 1ffc000.pcie:    IO 0x01f80000..0x01f8ffff -> 0x00000000
[    6.595523] imx6q-pcie 1ffc000.pcie:   MEM 0x01000000..0x01efffff -> 0x01000000
[    7.700998] imx6q-pcie 1ffc000.pcie: Phy link never came up
[    7.704283] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    7.704316] pci_bus 0000:00: root bus resource [bus 00-ff]
[    7.704341] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    7.704361] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
[    7.704424] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
[    7.704458] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
[    7.704477] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
[    7.704549] pci 0000:00:00.0: supports D1
[    7.704558] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    7.708587] PCI: bus0: Fast back to back transfers disabled
[    7.712357] PCI: bus1: Fast back to back transfers enabled
[    7.712415] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
[    7.712448] pci 0000:00:00.0: BAR 6: assigned [mem 0x01100000-0x0110ffff pref]
[    7.712476] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    7.712958] pcieport 0000:00:00.0: Signaling PME with IRQ 304
[    7.713317] aer 0000:00:00.0:pcie002: AER enabled with IRQ 304
[    7.719491] imx-sdma 20ec000.sdma: firmware: direct-loading firmware imx/sdma/sdma-imx6q.bin
[    7.719941] imx-sdma 20ec000.sdma: loaded firmware 3.3
[    7.725405] imx-pgc-pd imx-pgc-power-domain.0: DMA mask not set
[    7.725499] imx-pgc-pd imx-pgc-power-domain.0: Linked as a consumer to 20dc000.gpc
[    7.725575] imx-pgc-pd imx-pgc-power-domain.1: DMA mask not set
[    7.728412] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    7.731352] Serial: AMBA driver
[    7.732362] 2020000.serial: ttymxc0 at MMIO 0x2020000 (irq = 27, base_baud = 5000000) is a IMX
[    7.732404] Console IMX rounded baud rate from 114943 to 114900
[    8.610448] printk: console [ttymxc0] enabled
[    8.615950] 21ec000.serial: ttymxc2 at MMIO 0x21ec000 (irq = 71, base_baud = 5000000) is a IMX
[    8.625558] 21f0000.serial: ttymxc3 at MMIO 0x21f0000 (irq = 72, base_baud = 5000000) is a IMX
[    8.634452] serial serial0: tty port ttymxc3 registered
[    8.643627] libphy: Fixed MDIO Bus: probed
[    8.648727] fec 2188000.ethernet: 2188000.ethernet supply phy not found, using dummy regulator
[    8.657462] fec 2188000.ethernet: Linked as a consumer to regulator.0
[    8.667536] pps pps0: new PPS source ptp0
[    8.682112] libphy: fec_enet_mii_bus: probed
[    8.687039] fec 2188000.ethernet eth0: registered PHC device 0
[    8.693992] mousedev: PS/2 mouse device common for all mice
[    8.702541] snvs_rtc 20cc000.snvs:snvs-rtc-lp: rtc core: registered 20cc000.snvs:snvs-rtc-lp as rtc0
[    8.716209] ledtrig-cpu: registered to indicate activity on CPUs
[    8.724474] NET: Registered protocol family 10
[    8.758104] Segment Routing with IPv6
[    8.761976] mip6: Mobile IPv6
[    8.764993] NET: Registered protocol family 17
[    8.769491] mpls_gso: MPLS GSO support
[    8.773719] ThumbEE CPU extension supported.
[    8.778046] Registering SWP/SWPB emulation handler
[    8.783663] registered taskstats version 1
[    8.787821] Loading compiled-in X.509 certificates
[    9.217864] Loaded X.509 cert 'secure-boot-test-key-lfaraone: 97c1b25cddf9873ca78a58f3d73bf727d2cf78ff'
[    9.227426] zswap: loaded using pool lzo/zbud
[    9.232183] AppArmor: AppArmor sha1 policy hashing enabled
[    9.260271] snvs_rtc 20cc000.snvs:snvs-rtc-lp: setting system clock to 2019-01-08 15:07:28 UTC (1546960048)
[    9.270107] sr_init: No PMIC hook to init smartreflex
[    9.276220] v_sd: disabling
[    9.293518] Freeing unused kernel memory: 2048K
[    9.304990] Run /init as init process
[    9.420040] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    9.428134] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    9.429546] random: udevadm: uninitialized urandom read (16 bytes read)
[    9.744915] vdd1p1: supplied by regulator-dummy
[    9.758429] vdd3p0: supplied by regulator-dummy
[    9.766027] vdd2p5: supplied by regulator-dummy
[    9.777965] vddarm: supplied by regulator-dummy
[    9.785576] vddpu: supplied by regulator-dummy
[    9.791137] imx-pgc-pd imx-pgc-power-domain.1: Linked as a consumer to regulator.15
[    9.799720] sdhci: Secure Digital Host Controller Interface driver
[    9.804892] PU : no governor for states
[    9.806059] sdhci: Copyright(c) Pierre Ossman
[    9.814445] vddsoc: supplied by regulator-dummy
[    9.819881] imx-pgc-pd imx-pgc-power-domain.1: Linked as a consumer to 20dc000.gpc
[    9.822038] sdhci-pltfm: SDHCI platform and OF driver helper
[    9.850284] usbcore: registered new interface driver usbfs
[    9.853416] SCSI subsystem initialized
[    9.863875] usbcore: registered new interface driver hub
[    9.873591] sdhci-esdhc-imx 2190000.usdhc: allocated mmc-pwrseq
[    9.875001] usbcore: registered new device driver usb
[    9.879792] libata version 3.00 loaded.
[    9.880469] sdhci-esdhc-imx 2190000.usdhc: Linked as a consumer to regulator.1
[    9.885120] rtc-pcf8523 0-0068: rtc core: registered rtc-pcf8523 as rtc1
[    9.898316] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    9.900508] ahci-imx 2200000.sata: fsl,transmit-level-mV value 1104, using 00000044
[    9.903921] i2c i2c-0: IMX I2C adapter registered
[    9.903940] i2c i2c-0: can't use DMA, using PIO instead.
[    9.904646] i2c i2c-1: IMX I2C adapter registered
[    9.904658] i2c i2c-1: can't use DMA, using PIO instead.
[    9.905273] i2c i2c-2: IMX I2C adapter registered
[    9.905284] i2c i2c-2: can't use DMA, using PIO instead.
[    9.928218] imx_usb 2184000.usb: Linked as a consumer to regulator.7
[    9.933467] ahci-imx 2200000.sata: fsl,transmit-boost-mdB value 0, using 00000000
[    9.933481] ahci-imx 2200000.sata: fsl,transmit-atten-16ths value 9, using 00002000
[    9.965177] ahci-imx 2200000.sata: fsl,receive-eq-mdB not specified, using 05000000
[    9.974641] ci_hdrc ci_hdrc.0: EHCI Host Controller
[    9.978379] ahci-imx 2200000.sata: SSS flag set, parallel bus scan disabled
[    9.980910] ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus number 1
[    9.986646] ahci-imx 2200000.sata: AHCI 0001.0300 32 slots 1 ports 3 Gbps 0x1 impl platform mode
[   10.002542] ahci-imx 2200000.sata: flags: ncq sntf stag pm led clo only pmp pio slum part ccc apst 
[   10.008700] ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00
[   10.013908] scsi host0: ahci-imx
[   10.017339] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.20
[   10.021257] ata1: SATA max UDMA/133 mmio [mem 0x02200000-0x02203fff] port 0x100 irq 75
[   10.028632] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   10.043923] usb usb1: Product: EHCI Host Controller
[   10.048844] usb usb1: Manufacturer: Linux 4.20.0-trunk-armmp ehci_hcd
[   10.055323] usb usb1: SerialNumber: ci_hdrc.0
[   10.060714] hub 1-0:1.0: USB hub found
[   10.064533] hub 1-0:1.0: 1 port detected
[   10.069686] imx_usb 2184200.usb: 2184200.usb supply vbus not found, using dummy regulator
[   10.077985] imx_usb 2184200.usb: Linked as a consumer to regulator.0
[   10.088384] ci_hdrc ci_hdrc.1: EHCI Host Controller
[   10.093340] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus number 2
[   10.116728] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
[   10.122423] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.20
[   10.130744] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   10.138009] usb usb2: Product: EHCI Host Controller
[   10.142923] usb usb2: Manufacturer: Linux 4.20.0-trunk-armmp ehci_hcd
[   10.149399] usb usb2: SerialNumber: ci_hdrc.1
[   10.154479] hub 2-0:1.0: USB hub found
[   10.158317] hub 2-0:1.0: 1 port detected
[   10.207304] mmc0: SDHCI controller on 2190000.usdhc [2190000.usdhc] using ADMA
[   10.217336] sdhci-esdhc-imx 2194000.usdhc: Got CD GPIO
[   10.222716] sdhci-esdhc-imx 2194000.usdhc: Linked as a consumer to regulator.6
[   10.234534] sdhci-esdhc-imx 2190000.usdhc: card claims to support voltages below defined range
[   10.261965] mmc0: new high speed SDIO card at address 0001
[   10.270791] mmc1: SDHCI controller on 2194000.usdhc [2194000.usdhc] using ADMA
[   10.280051] sdhci-esdhc-imx 2198000.usdhc: Linked as a consumer to regulator.1
[   10.318353] mmc2: SDHCI controller on 2198000.usdhc [2198000.usdhc] using ADMA
[   10.378844] mmc2: new DDR MMC card at address 0001
[   10.386507] mmcblk2: mmc2:0001 8GME4R 7.28 GiB 
[   10.393759] mmcblk2boot0: mmc2:0001 8GME4R partition 1 4.00 MiB
[   10.400575] random: fast init done
[   10.402665] mmcblk2boot1: mmc2:0001 8GME4R partition 2 4.00 MiB
[   10.410455] mmcblk2rpmb: mmc2:0001 8GME4R partition 3 512 KiB, chardev (242:0)
[   10.494793] mmc1: host does not support reading read-only switch, assuming write-enable
[   10.496715] usb 2-1: new high-speed USB device number 2 using ci_hdrc
[   10.541321] mmc1: new ultra high speed DDR50 SDXC card at address 0001
[   10.550677] mmcblk1: mmc1:0001 00000 59.6 GiB 
[   10.564977]  mmcblk1: p1
[   10.624753] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   10.631189] ata1.00: ATA-10: 32GB SATA Flash Drive, SFPS925A, max UDMA/133
[   10.638148] ata1.00: 62533296 sectors, multi 16: LBA48 NCQ (depth 32)
[   10.644884] ata1.00: configured for UDMA/133
[   10.650611] scsi 0:0:0:0: Direct-Access     ATA      32GB SATA Flash  925A PQ: 0 ANSI: 5
[   10.666638] usb 2-1: New USB device found, idVendor=04b4, idProduct=6570, bcdDevice=32.99
[   10.668923] sd 0:0:0:0: [sda] 62533296 512-byte logical blocks: (32.0 GB/29.8 GiB)
[   10.674964] usb 2-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[   10.682585] sd 0:0:0:0: [sda] Write Protect is off
[   10.689659] usb 2-1: Product: USB2.0 Hub
[   10.698561] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   10.698916] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   10.700505] hub 2-1:1.0: USB hub found
[   10.712406] hub 2-1:1.0: 4 ports detected
[   10.713310] sd 0:0:0:0: [sda] Attached SCSI disk
[   10.995648] EXT4-fs (mmcblk1p1): mounted filesystem with ordered data mode. Opts: (null)
[   11.563298] systemd[1]: systemd 232 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[   11.582087] systemd[1]: Detected architecture arm.
[   11.601517] systemd[1]: Set hostname to <sr-imx6>.
[   11.958585] systemd[1]: Listening on Journal Audit Socket.
[   11.977153] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[   12.001104] systemd[1]: Listening on Syslog Socket.
[   12.021889] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[   12.049117] systemd[1]: Listening on udev Control Socket.
[   12.069106] systemd[1]: Listening on Journal Socket.
[   12.089191] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[   12.367967] EXT4-fs (mmcblk1p1): re-mounted. Opts: (null)
[   12.796292] systemd-journald[210]: Received request to flush runtime journal from PID 1
[   13.304985] cpu cpu0: Linked as a consumer to regulator.14
[   13.321137] cpu cpu0: Linked as a consumer to regulator.15
[   13.343395] cpu cpu0: Linked as a consumer to regulator.16
[   13.440750] Registered IR keymap rc-rc6-mce
[   13.460414] imx-ipuv3 2400000.ipu: IPUv3H probed
[   13.471345] etnaviv etnaviv: bound 130000.gpu (ops gpu_ops [etnaviv])
[   13.473549] imx-ipuv3 2800000.ipu: IPUv3H probed
[   13.497882] etnaviv etnaviv: bound 134000.gpu (ops gpu_ops [etnaviv])
[   13.521121] etnaviv etnaviv: bound 2204000.gpu (ops gpu_ops [etnaviv])
[   13.524586] spi_imx 200c000.spi: probed
[   13.524960] IR RC6 protocol handler initialized
[   13.527806] etnaviv-gpu 130000.gpu: model: GC2000, revision: 5108
[   13.534020] imx2-wdt 20bc000.wdog: timeout 60 sec (nowayout=0)
[   13.556944] rc rc0: gpio_ir_recv as /devices/soc0/ir-receiver/rc/rc0
[   13.571610] input: gpio_ir_recv as /devices/soc0/ir-receiver/rc/rc0/input0
[   13.596306] rc rc0: lirc_dev: driver gpio_ir_recv registered at minor = 0, raw IR receiver, no transmitter
[   13.623416] etnaviv-gpu 134000.gpu: model: GC320, revision: 5007
[   13.660095] fsl-ssi-dai 2028000.ssi: No cache defaults, reading back from HW
[   13.677432] etnaviv-gpu 2204000.gpu: model: GC355, revision: 1215
[   13.683705] etnaviv-gpu 2204000.gpu: Ignoring GPU with VG and FE2.0
[   13.703428] [drm] Initialized etnaviv 1.2.0 20151214 for etnaviv on minor 0
[   13.711394] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   13.718168] [drm] No driver support for vblank timestamp query.
[   13.724793] imx-drm display-subsystem: bound imx-ipuv3-crtc.2 (ops ipu_crtc_ops [imxdrm])
[   13.732753] rc rc0: two consecutive events of type space
[   13.733326] imx-drm display-subsystem: bound imx-ipuv3-crtc.3 (ops ipu_crtc_ops [imxdrm])
[   13.748237] imx-drm display-subsystem: bound imx-ipuv3-crtc.6 (ops ipu_crtc_ops [imxdrm])
[   13.759611] imx-drm display-subsystem: bound imx-ipuv3-crtc.7 (ops ipu_crtc_ops [imxdrm])
[   13.790860] dwhdmi-imx 120000.hdmi: Detected HDMI TX controller v1.30a with HDCP (DWC HDMI 3D TX PHY)
[   13.809871] imx-drm display-subsystem: bound 120000.hdmi (ops dw_hdmi_imx_platform_driver_exit [dw_hdmi_imx])
[   13.827159] [drm] Initialized imx-drm 1.0.0 20120507 for display-subsystem on minor 1
[   13.835453] [drm] Cannot find any crtc or sizes
[   13.843179] [drm] Cannot find any crtc or sizes
[   13.856148] sgtl5000 0-000a: Linked as a consumer to regulator.5
[   13.862991] sgtl5000 0-000a: Dropping the link to regulator.5
[   13.872580] sgtl5000 0-000a: Linked as a consumer to regulator.3
[   13.878939] sgtl5000 0-000a: Linked as a consumer to regulator.5
[   13.891909] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   13.908220] sgtl5000 0-000a: sgtl5000 revision 0x11
[   14.034301] asoc-simple-card sound-sgtl5000: sgtl5000 <-> 2028000.ssi mapping ok
[   14.043693] asoc-simple-card sound-sgtl5000: ASoC: no DMI vendor name!
[   14.342623] Bluetooth: Core ver 2.22
[   14.348473] NET: Registered protocol family 31
[   14.354144] Bluetooth: HCI device and connection manager initialized
[   14.360600] Bluetooth: HCI socket layer initialized
[   14.365549] Bluetooth: L2CAP socket layer initialized
[   14.370714] Bluetooth: SCO socket layer initialized
[   14.398335] wl18xx_driver wl18xx.2.auto: firmware: direct-loading firmware ti-connectivity/wl1271-nvs.bin
[   14.404896] Bluetooth: HCI UART driver ver 2.3
[   14.412482] Bluetooth: HCI UART protocol H4 registered
[   14.417881] Bluetooth: HCI UART protocol LL registered
[   14.423130] Bluetooth: HCI UART protocol ATH3K registered
[   14.428823] Bluetooth: HCI UART protocol Three-wire (H5) registered
[   14.435469] Bluetooth: HCI UART protocol Intel registered
[   14.435862] wl18xx_driver wl18xx.2.auto: firmware: direct-loading firmware ti-connectivity/wl18xx-conf.bin
[   14.441146] Bluetooth: HCI UART protocol Broadcom registered
[   14.456620] Bluetooth: HCI UART protocol QCA registered
[   14.456635] Bluetooth: HCI UART protocol AG6XX registered
[   14.456640] Bluetooth: HCI UART protocol Marvell registered
[   14.476742] wl1271_sdio mmc0:0001:2: wl12xx_sdio_power_on: failed to get_sync(-13)
[   14.479528] hci-ti serial0-0: firmware: direct-loading firmware ti-connectivity/TIInit_11.8.32.bts
[   14.496040] Bluetooth: hci0: change remote baud rate command in firmware
[   15.135054] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   15.140463] Bluetooth: BNEP filters: protocol multicast
[   15.145829] Bluetooth: BNEP socket layer initialized
[   15.180074] Atheros 8035 ethernet 2188000.ethernet-1:00: attached PHY driver [Atheros 8035 ethernet] (mii_bus:phy_addr=2188000.ethernet-1:00, irq=POLL)
[   15.194806] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   15.515580] tun: Universal TUN/TAP device driver, 1.6
[   15.608830] IPv6: ADDRCONF(NETDEV_UP): tun0: link is not ready
[   19.293516] fec 2188000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
[   19.301248] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   19.336030] 8021q: 802.1Q VLAN Support v1.8
[   20.796314] Bluetooth: RFCOMM TTY layer initialized
[   20.801337] Bluetooth: RFCOMM socket layer initialized
[   20.806568] Bluetooth: RFCOMM ver 1.11
[  111.419375] Connecting to first module while both are powered
[  111.575073] chan (ptrval) conn (ptrval) state BT_CONNECT err 0
[  111.575102] chan (ptrval) err 0
[  112.163148] NET: Registered protocol family 38
[  112.246378] chan (ptrval) suspend
[  112.246397] chan (ptrval) conn (ptrval) dev   (null)
[  112.247958] ifindex 4 peer bdaddr 00:b1:fc:8c:6e:47 type 1 my addr a4:d5:78:11:cf:6f type 1
[  112.248537] chan (ptrval) resume
[  112.248561] chan (ptrval) resume
[  112.248576] chan (ptrval) resume
[  112.257343] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  112.295698] chan (ptrval) resume
[  112.297695] chan (ptrval) resume
[  112.345647] chan (ptrval) resume
[  112.349564] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  112.445665] chan (ptrval) resume
[  112.445685] chan (ptrval) resume
[  112.446964] iphc_decompress failed: -22
[  112.446972] recv pkt 1
[  112.473572] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  112.546016] iphc_decompress failed: -22
[  112.546034] recv pkt 1
[  112.595803] chan (ptrval) resume
[  112.685923] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  112.696442] chan (ptrval) resume
[  112.745704] chan (ptrval) resume
[  112.910133] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  112.947466] chan (ptrval) resume
[  113.006299] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  113.046722] chan (ptrval) resume
[  113.095681] chan (ptrval) resume
[  113.711306] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  113.723075] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  113.723124] chan (ptrval) suspend
[  113.747262] chan (ptrval) resume
[  113.797185] chan (ptrval) resume
[  113.845701] chan (ptrval) resume
[  114.127602] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  114.147226] chan (ptrval) resume
[  114.223606] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  114.295627] chan (ptrval) resume
[  114.295641] chan (ptrval) resume
[  114.643821] dest IP fe80::b1:fcff:fe8c:6e47
[  114.643834] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  114.643851] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  114.647158] chan (ptrval) resume
[  114.745642] chan (ptrval) resume
[  115.728679] dest IP fe80::b1:fcff:fe8c:6e47
[  115.728694] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  115.728716] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  115.747221] chan (ptrval) resume
[  115.845632] chan (ptrval) resume
[  116.826831] dest IP fe80::b1:fcff:fe8c:6e47
[  116.826843] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  116.826866] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  116.847188] chan (ptrval) resume
[  116.945579] chan (ptrval) resume
[  117.925469] dest IP fe80::b1:fcff:fe8c:6e47
[  117.925481] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  117.925506] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  117.947165] chan (ptrval) resume
[  118.045569] chan (ptrval) resume
[  119.027892] dest IP fe80::b1:fcff:fe8c:6e47
[  119.027906] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  119.027926] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  119.047138] chan (ptrval) resume
[  119.145544] chan (ptrval) resume
[  119.859712] dest IP fe80::b1:fcff:fe8c:6e47
[  119.859767] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  119.859814] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 4800:: chan (ptrval)
[  119.946775] chan (ptrval) resume
[  120.127083] dest IP fe80::b1:fcff:fe8c:6e47
[  120.127094] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  120.127114] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  120.147119] chan (ptrval) resume
[  120.245513] chan (ptrval) resume
[  121.225732] dest IP fe80::b1:fcff:fe8c:6e47
[  121.225745] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  121.225769] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  121.247072] chan (ptrval) resume
[  121.345514] chan (ptrval) resume
[  122.326172] dest IP fe80::b1:fcff:fe8c:6e47
[  122.326185] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  122.326206] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  122.347062] chan (ptrval) resume
[  122.445471] chan (ptrval) resume
[  123.426489] dest IP fe80::b1:fcff:fe8c:6e47
[  123.426503] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  123.426524] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  123.447027] chan (ptrval) resume
[  123.545454] chan (ptrval) resume
[  124.526512] dest IP fe80::b1:fcff:fe8c:6e47
[  124.526527] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  124.526548] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  124.547013] chan (ptrval) resume
[  124.645507] chan (ptrval) resume
[  125.626907] dest IP fe80::b1:fcff:fe8c:6e47
[  125.626922] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  125.626943] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  125.646970] chan (ptrval) resume
[  125.745397] chan (ptrval) resume
[  126.726789] dest IP fe80::b1:fcff:fe8c:6e47
[  126.726801] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  126.726825] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  126.746946] chan (ptrval) resume
[  126.845359] chan (ptrval) resume
[  127.826146] dest IP fe80::b1:fcff:fe8c:6e47
[  127.826159] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  127.826181] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  127.895640] chan (ptrval) resume
[  127.946052] chan (ptrval) resume
[  128.976775] dest IP fe80::b1:fcff:fe8c:6e47
[  128.976788] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  128.976806] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  128.996895] chan (ptrval) resume
[  129.095299] chan (ptrval) resume
[  129.419998] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  129.446853] chan (ptrval) resume
[  129.495277] chan (ptrval) resume
[  129.996110] dest IP fe80::b1:fcff:fe8c:6e47
[  129.996134] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  129.996167] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 4000:: chan (ptrval)
[  130.077082] dest IP fe80::b1:fcff:fe8c:6e47
[  130.077093] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  130.077110] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  130.095167] chan (ptrval) resume
[  130.145578] chan (ptrval) resume
[  130.245216] chan (ptrval) resume
[  131.225849] dest IP fe80::b1:fcff:fe8c:6e47
[  131.225890] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  131.225914] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  131.246844] chan (ptrval) resume
[  131.345239] chan (ptrval) resume
[  132.325906] dest IP fe80::b1:fcff:fe8c:6e47
[  132.325919] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  132.325941] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  132.346810] chan (ptrval) resume
[  132.445208] chan (ptrval) resume
[  133.425793] dest IP fe80::b1:fcff:fe8c:6e47
[  133.425806] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  133.425829] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  133.446789] chan (ptrval) resume
[  133.545225] chan (ptrval) resume
[  134.525130] dest IP fe80::b1:fcff:fe8c:6e47
[  134.525141] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  134.525159] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  134.595354] chan (ptrval) resume
[  134.645155] chan (ptrval) resume
[  135.626023] dest IP fe80::b1:fcff:fe8c:6e47
[  135.626036] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  135.626058] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  135.646714] chan (ptrval) resume
[  135.745111] chan (ptrval) resume
[  136.725675] dest IP fe80::b1:fcff:fe8c:6e47
[  136.725690] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  136.725711] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  136.746697] chan (ptrval) resume
[  136.845096] chan (ptrval) resume
[  137.823810] dest IP fe80::b1:fcff:fe8c:6e47
[  137.823822] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  137.823846] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  137.846668] chan (ptrval) resume
[  137.945060] chan (ptrval) resume
[  138.925543] dest IP fe80::b1:fcff:fe8c:6e47
[  138.925556] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  138.925629] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  138.946646] chan (ptrval) resume
[  139.045050] chan (ptrval) resume
[  140.025611] dest IP fe80::b1:fcff:fe8c:6e47
[  140.025625] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  140.025646] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  140.046607] chan (ptrval) resume
[  140.144989] chan (ptrval) resume
[  141.126707] dest IP fe80::b1:fcff:fe8c:6e47
[  141.126722] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  141.126742] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  141.146572] chan (ptrval) resume
[  141.245012] chan (ptrval) resume
[  142.225632] dest IP fe80::b1:fcff:fe8c:6e47
[  142.225646] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  142.225667] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  142.246541] chan (ptrval) resume
[  142.344956] chan (ptrval) resume
[  143.325547] dest IP fe80::b1:fcff:fe8c:6e47
[  143.325560] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  143.325582] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  143.395111] chan (ptrval) resume
[  143.444926] chan (ptrval) resume
[  144.425793] dest IP fe80::b1:fcff:fe8c:6e47
[  144.425806] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  144.425828] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  144.446484] chan (ptrval) resume
[  144.546199] chan (ptrval) resume
[  145.574971] dest IP fe80::b1:fcff:fe8c:6e47
[  145.574983] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  145.575005] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  145.596473] chan (ptrval) resume
[  145.694914] chan (ptrval) resume
[  146.677116] dest IP fe80::b1:fcff:fe8c:6e47
[  146.677131] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  146.677154] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  146.696460] chan (ptrval) resume
[  146.845539] chan (ptrval) resume
[  147.012352] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  147.046773] chan (ptrval) resume
[  147.094847] chan (ptrval) resume
[  147.872837] dest IP fe80::b1:fcff:fe8c:6e47
[  147.872850] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  147.872871] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  147.896415] chan (ptrval) resume
[  147.994852] chan (ptrval) resume
[  148.533443] dest IP fe80::b1:fcff:fe8c:6e47
[  148.533515] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  148.533559] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 4800:: chan (ptrval)
[  148.596061] chan (ptrval) resume
[  148.975014] dest IP fe80::b1:fcff:fe8c:6e47
[  148.975027] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  148.975047] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  148.996388] chan (ptrval) resume
[  149.094818] chan (ptrval) resume
[  150.075009] dest IP fe80::b1:fcff:fe8c:6e47
[  150.075022] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  150.075043] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  150.096363] chan (ptrval) resume
[  150.194788] chan (ptrval) resume
[  151.174982] dest IP fe80::b1:fcff:fe8c:6e47
[  151.174997] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  151.175020] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  151.196314] chan (ptrval) resume
[  151.294762] chan (ptrval) resume
[  152.274977] dest IP fe80::b1:fcff:fe8c:6e47
[  152.274990] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  152.275013] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  152.296296] chan (ptrval) resume
[  152.394732] chan (ptrval) resume
[  153.374682] dest IP fe80::b1:fcff:fe8c:6e47
[  153.374695] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  153.374717] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  153.396260] chan (ptrval) resume
[  153.494682] chan (ptrval) resume
[  154.474864] dest IP fe80::b1:fcff:fe8c:6e47
[  154.474877] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  154.474897] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  154.496222] chan (ptrval) resume
[  154.594652] chan (ptrval) resume
[  155.577026] dest IP fe80::b1:fcff:fe8c:6e47
[  155.577040] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  155.577060] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  155.596223] chan (ptrval) resume
[  155.694642] chan (ptrval) resume
[  156.674858] dest IP fe80::b1:fcff:fe8c:6e47
[  156.674873] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  156.674894] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  156.696171] chan (ptrval) resume
[  156.794604] chan (ptrval) resume
[  157.776788] dest IP fe80::b1:fcff:fe8c:6e47
[  157.776800] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  157.776823] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  157.796162] chan (ptrval) resume
[  157.894560] chan (ptrval) resume
[  158.874813] dest IP fe80::b1:fcff:fe8c:6e47
[  158.874827] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  158.874848] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  158.896139] chan (ptrval) resume
[  158.994567] chan (ptrval) resume
[  159.974805] dest IP fe80::b1:fcff:fe8c:6e47
[  159.974821] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  159.974842] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  159.996117] chan (ptrval) resume
[  160.094536] chan (ptrval) resume
[  161.074821] dest IP fe80::b1:fcff:fe8c:6e47
[  161.074836] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  161.074855] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  161.096073] chan (ptrval) resume
[  161.194511] chan (ptrval) resume
[  162.173839] dest IP fe80::b1:fcff:fe8c:6e47
[  162.173854] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  162.173878] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  162.196035] chan (ptrval) resume
[  162.294444] chan (ptrval) resume
[  163.276757] dest IP fe80::b1:fcff:fe8c:6e47
[  163.276771] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  163.276792] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  163.296038] chan (ptrval) resume
[  163.394483] chan (ptrval) resume
[  164.374597] dest IP fe80::b1:fcff:fe8c:6e47
[  164.374610] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  164.374631] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  164.395989] chan (ptrval) resume
[  164.494409] chan (ptrval) resume
[  165.474537] dest IP fe80::b1:fcff:fe8c:6e47
[  165.474550] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  165.474573] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  165.495965] chan (ptrval) resume
[  165.594407] chan (ptrval) resume
[  166.574775] dest IP fe80::b1:fcff:fe8c:6e47
[  166.574789] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  166.574811] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  166.595934] chan (ptrval) resume
[  166.694340] chan (ptrval) resume
[  167.678373] dest IP fe80::b1:fcff:fe8c:6e47
[  167.678385] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  167.678402] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  167.695833] chan (ptrval) resume
[  167.794320] chan (ptrval) resume
[  168.776661] dest IP fe80::b1:fcff:fe8c:6e47
[  168.776675] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  168.776696] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  168.795881] chan (ptrval) resume
[  168.894316] chan (ptrval) resume
[  169.874715] dest IP fe80::b1:fcff:fe8c:6e47
[  169.874728] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  169.874752] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  169.895847] chan (ptrval) resume
[  169.994298] chan (ptrval) resume
[  170.974503] dest IP fe80::b1:fcff:fe8c:6e47
[  170.974516] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  170.974537] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  170.995833] chan (ptrval) resume
[  171.094247] chan (ptrval) resume
[  172.074439] dest IP fe80::b1:fcff:fe8c:6e47
[  172.074453] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  172.074474] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  172.095786] chan (ptrval) resume
[  172.194247] chan (ptrval) resume
[  173.174699] dest IP fe80::b1:fcff:fe8c:6e47
[  173.174713] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  173.174736] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  173.195778] chan (ptrval) resume
[  173.294179] chan (ptrval) resume
[  174.274614] dest IP fe80::b1:fcff:fe8c:6e47
[  174.274630] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  174.274652] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  174.295737] chan (ptrval) resume
[  174.394172] chan (ptrval) resume
[  175.374614] dest IP fe80::b1:fcff:fe8c:6e47
[  175.374626] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  175.374645] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  175.395718] chan (ptrval) resume
[  175.494163] chan (ptrval) resume
[  176.474342] dest IP fe80::b1:fcff:fe8c:6e47
[  176.474355] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  176.474377] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  176.495686] chan (ptrval) resume
[  176.594126] chan (ptrval) resume
[  177.205108] dest IP fe80::b1:fcff:fe8c:6e47
[  177.205178] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  177.205225] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 4800:: chan (ptrval)
[  177.295324] chan (ptrval) resume
[  177.574712] dest IP fe80::b1:fcff:fe8c:6e47
[  177.574727] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  177.574745] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  177.595647] chan (ptrval) resume
[  177.694100] chan (ptrval) resume
[  178.674501] dest IP fe80::b1:fcff:fe8c:6e47
[  178.674514] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  178.674536] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  178.695641] chan (ptrval) resume
[  178.794081] chan (ptrval) resume
[  179.773407] dest IP fe80::b1:fcff:fe8c:6e47
[  179.773420] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  179.773442] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  179.795621] chan (ptrval) resume
[  179.894055] chan (ptrval) resume
[  180.874521] dest IP fe80::b1:fcff:fe8c:6e47
[  180.874534] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  180.874556] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  180.895583] chan (ptrval) resume
[  180.994028] chan (ptrval) resume
[  181.974580] dest IP fe80::b1:fcff:fe8c:6e47
[  181.974592] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  181.974615] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  181.995568] chan (ptrval) resume
[  182.093986] chan (ptrval) resume
[  183.074512] dest IP fe80::b1:fcff:fe8c:6e47
[  183.074524] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  183.074547] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  183.095541] chan (ptrval) resume
[  183.193963] chan (ptrval) resume
[  184.174392] dest IP fe80::b1:fcff:fe8c:6e47
[  184.174406] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  184.174427] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  184.195509] chan (ptrval) resume
[  184.293925] chan (ptrval) resume
[  185.274569] dest IP fe80::b1:fcff:fe8c:6e47
[  185.274583] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  185.274604] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  185.295462] chan (ptrval) resume
[  185.393922] chan (ptrval) resume
[  186.374383] dest IP fe80::b1:fcff:fe8c:6e47
[  186.374398] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  186.374419] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  186.395446] chan (ptrval) resume
[  186.493877] chan (ptrval) resume
[  187.474422] dest IP fe80::b1:fcff:fe8c:6e47
[  187.474435] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  187.474455] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  187.495402] chan (ptrval) resume
[  187.593859] chan (ptrval) resume
[  188.574308] dest IP fe80::b1:fcff:fe8c:6e47
[  188.574322] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  188.574343] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  188.595392] chan (ptrval) resume
[  188.693827] chan (ptrval) resume
[  189.674387] dest IP fe80::b1:fcff:fe8c:6e47
[  189.674402] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  189.674422] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  189.695367] chan (ptrval) resume
[  189.793813] chan (ptrval) resume
[  190.774378] dest IP fe80::b1:fcff:fe8c:6e47
[  190.774392] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  190.774413] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  190.795345] chan (ptrval) resume
[  190.893778] chan (ptrval) resume
[  191.874297] dest IP fe80::b1:fcff:fe8c:6e47
[  191.874309] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  191.874332] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  192.244765] chan (ptrval) conn   (null)
[  192.244782] last peer
[  192.244794] dev (ptrval) removing last peer (ptrval)
[  192.244806] chan (ptrval) orig refcnt 2
[  192.247283] Unregistered netdev bt0 (ptrval)
[  235.505517] Connecting to first module while both are powered
[  236.094254] chan (ptrval) conn (ptrval) state BT_CONNECT err 0
[  236.094284] chan (ptrval) err 0
[  237.392438] chan (ptrval) suspend
[  237.392467] chan (ptrval) conn (ptrval) dev   (null)
[  237.394085] ifindex 5 peer bdaddr 00:b1:fc:8c:6e:47 type 1 my addr a4:d5:78:11:cf:6f type 1
[  237.395398] chan (ptrval) resume
[  237.395427] chan (ptrval) resume
[  237.395444] chan (ptrval) resume
[  237.406745] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  237.441843] chan (ptrval) resume
[  237.443884] chan (ptrval) resume
[  237.491867] chan (ptrval) resume
[  237.500819] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  237.591849] chan (ptrval) resume
[  237.591864] chan (ptrval) resume
[  237.614774] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  237.643441] chan (ptrval) resume
[  237.742028] chan (ptrval) resume
[  237.878768] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  237.906755] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  237.942208] chan (ptrval) resume
[  237.943815] chan (ptrval) resume
[  238.041988] chan (ptrval) resume
[  238.142563] iphc_decompress failed: -22
[  238.142584] recv pkt 1
[  238.242009] iphc_decompress failed: -22
[  238.242029] recv pkt 1
[  238.450907] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  238.541885] chan (ptrval) resume
[  238.899002] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  238.910720] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  238.910813] chan (ptrval) suspend
[  238.943481] chan (ptrval) resume
[  238.993395] chan (ptrval) resume
[  239.042020] chan (ptrval) resume
[  239.158807] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  239.241846] chan (ptrval) resume
[  239.668426] dest IP fe80::b1:fcff:fe8c:6e47
[  239.668437] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  239.668456] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  239.693478] chan (ptrval) resume
[  239.791871] chan (ptrval) resume
[  239.890701] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  239.943434] chan (ptrval) resume
[  240.041840] chan (ptrval) resume
[  240.766743] dest IP fe80::b1:fcff:fe8c:6e47
[  240.766756] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  240.766775] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  240.793412] chan (ptrval) resume
[  240.891838] chan (ptrval) resume
[  241.872089] dest IP fe80::b1:fcff:fe8c:6e47
[  241.872104] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  241.872124] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  241.893386] chan (ptrval) resume
[  241.991791] chan (ptrval) resume
[  242.356387] Connecting to second module
[  242.485165] chan (ptrval) conn (ptrval) state BT_CONNECT err 0
[  242.485196] chan (ptrval) err 0
[  242.971979] dest IP fe80::b1:fcff:fe8c:6e47
[  242.971992] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  242.972015] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan (ptrval)
[  242.993391] chan (ptrval) resume
[  243.091774] chan (ptrval) resume
[  243.547405] chan (ptrval) suspend
[  243.547424] chan (ptrval) conn (ptrval) dev (ptrval)
[  243.547457] chan (ptrval) resume
[  243.547914] chan (ptrval) resume
[  243.548452] chan (ptrval) resume
[  243.596752] chan (ptrval) resume
[  243.650843] xmit bt0 to 00:39:d3:29:92:1c type 1 IP fe80::39:d3ff:fe29:921c chan (ptrval)
[  243.650924] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  243.651026] xmit bt0 to 00:39:d3:29:92:1c type 1 IP fe80::39:d3ff:fe29:921c chan (ptrval)
[  243.651064] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  243.651383] xmit bt0 to 00:39:d3:29:92:1c type 1 IP fe80::39:d3ff:fe29:921c chan (ptrval)
[  243.651451] chan (ptrval) suspend
[  243.651476] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  243.651532] chan (ptrval) suspend
[  243.743267] chan (ptrval) resume
[  243.792076] chan (ptrval) resume
[  243.792099] chan (ptrval) resume
[  243.797091] chan (ptrval) resume
[  243.841719] chan (ptrval) resume
[  243.846699] chan (ptrval) resume
[  244.073592] dest IP fe80::b1:fcff:fe8c:6e47
[  244.073603] peers 2 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  244.073607] no such peer
[  244.447394] iphc_decompress failed: -22
[  244.447411] recv pkt 1
[  244.546813] iphc_decompress failed: -22
[  244.546830] recv pkt 1
[  244.655086] xmit bt0 to 00:39:d3:29:92:1c type 1 IP fe80::39:d3ff:fe29:921c chan (ptrval)
[  244.655150] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  244.697455] chan (ptrval) resume
[  244.742679] dest IP fe80::b1:fcff:fe8c:6e47
[  244.742700] peers 2 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  244.742711] no such peer
[  244.743025] chan (ptrval) resume
[  244.747220] chan (ptrval) resume
[  244.748301] iphc_decompress failed: -22
[  244.748315] recv pkt 1
[  244.748708] chan (ptrval) resume
[  244.786515] dest IP fe80::b1:fcff:fe8c:6e47
[  244.786560] peers 2 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  244.786576] no such peer
[  245.810500] dest IP fe80::b1:fcff:fe8c:6e47
[  245.810546] peers 2 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  245.810563] no such peer
[  246.834465] dest IP fe80::b1:fcff:fe8c:6e47
[  246.834507] peers 2 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  246.834525] no such peer
[  255.103070] xmit bt0 to 00:39:d3:29:92:1c type 1 IP fe80::39:d3ff:fe29:921c chan (ptrval)
[  255.103106] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  255.192307] dest IP fe80::b1:fcff:fe8c:6e47
[  255.192330] peers 2 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  255.192342] no such peer
[  255.192710] chan (ptrval) resume
[  255.196483] chan (ptrval) resume
[  262.413373] xmit bt0 to 00:39:d3:29:92:1c type 1 IP fe80::39:d3ff:fe29:921c chan (ptrval)
[  262.413436] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  262.442915] chan (ptrval) resume
[  262.491321] chan (ptrval) resume
[  262.491346] chan (ptrval) resume
[  262.496289] chan (ptrval) resume
[  266.131310] dest IP fe80::b1:fcff:fe8c:6e47
[  266.131323] peers 2 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  266.131330] no such peer
[  277.161382] dest IP fe80::b1:fcff:fe8c:6e47
[  277.161396] peers 2 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  277.161401] no such peer
[  278.418269] xmit bt0 to 00:39:d3:29:92:1c type 1 IP fe80::39:d3ff:fe29:921c chan (ptrval)
[  278.418339] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP fe80::b1:fcff:fe8c:6e47 chan (ptrval)
[  278.442609] chan (ptrval) resume
[  278.491020] chan (ptrval) resume
[  278.491044] chan (ptrval) resume
[  278.495989] chan (ptrval) resume
[  288.190461] dest IP fe80::b1:fcff:fe8c:6e47
[  288.190474] peers 2 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  288.190481] no such peer
[  299.218811] dest IP fe80::b1:fcff:fe8c:6e47
[  299.218826] peers 2 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  299.218831] no such peer
[  306.791799] chan (ptrval) conn   (null)
[  306.791820] dev (ptrval) removing 1 peer (ptrval)
[  306.791832] chan (ptrval) orig refcnt 2
[  308.846579] chan (ptrval) conn   (null)
[  308.846596] last peer
[  308.846608] dev (ptrval) removing last peer (ptrval)
[  308.846620] chan (ptrval) orig refcnt 2
[  308.849125] Unregistered netdev bt0 (ptrval)
[  403.231123] random: crng init done
[  403.236434] random: 7 urandom warning(s) missed due to ratelimiting



--------------06F94660B77E24F49C24DD51--
