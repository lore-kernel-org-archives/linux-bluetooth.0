Return-Path: <cyrus@holtmann.org>
From: "Will Tucker" <wtucker@blueradios.com>
To: "'Peter Hurley'" <peter@hurleysoftware.com>,
	"'linux-bluetooth'" <linux-bluetooth@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
References: <003001d0714f$b67cc650$237652f0$@blueradios.com> <55241236.8060501@hurleysoftware.com>
In-Reply-To: <55241236.8060501@hurleysoftware.com>
Subject: RE: Linux version 3.18.10 Bluez ver 5.28 security level crashing system
Date: Wed, 8 Apr 2015 10:20:53 -0600
Message-ID: <001801d07217$fca23ed0$f5e6bc70$@blueradios.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

More information:

OpenWrt Migrated to new Kernel and new blueZ.
   Image Name:   MIPS OpenWrt Linux-3.18.11
   hcitool - HCI Tool ver 5.30

Got a little further and a possible workaround for the gatttool "sec-level medium' issue as shown in Example 1 and 2.
Example 3 with pairing concerns me the most since it gives an Oops[#1];. 

Thanks! 

reboot
root@OpenWrt:/# [   61.170000] br-lan: port 1(eth1) entered disabled state
[   61.170000] device eth1 left promiscuous mode
[   61.180000] br-lan: port 1(eth1) entered disabled state
[   61.190000] eth1: link down
[   61.190000] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[   65.380000] Removing MTD device #8 (rootfs_data) with use count 1
[   65.410000] reboot: Reÿÿ

U-Boot 1.1.4 (Feb  9 2012 - 20:12:45)

AP121 (ar9331) U-boot

DRAM:  64 MB
Top of RAM usable for U-Boot at: 84000000
Reserving 161k for U-Boot at: 83fd4000
Reserving 192k for malloc() at: 83fa4000
Reserving 44 Bytes for Board Info at: 83fa3fd4
Reserving 36 Bytes for Global Data at: 83fa3fb0
Reserving 128k for boot params() at: 83f83fb0
Stack Pointer at: 83f83f98
Now running in RAM - U-Boot at: 83fd4000
============================================
Date:Feb  9 2012  Time:20:12:45
Cameo Version: v1.00 Build:03
Module Name: D-Link DIR-505A1
============================================
id read 0x100000ff
flash size 8388608, sector count = 128
Flash:  8 MB
Using default environment

In:    serial
Out:   serial
Err:   serial
Net:   ag7240_enet_initialize...
: cfg1 0x5 cfg2 0x7114
eth0: 00:03:7f:ff:ff:ff
eth0 up
: cfg1 0xf cfg2 0x7214
eth1: 00:03:7f:ff:ff:fe
athrs26_reg_init_lan
ATHRS26: resetting s26
ATHRS26: s26 reset done
eth1 up
eth0, eth1
Hit any key to stop autoboot:  0
## Booting image at 9f080000 ...
   Image Name:   MIPS OpenWrt Linux-3.18.11
   Created:      2015-04-08  13:38:53 UTC
   Image Type:   MIPS Linux Kernel Image (lzma compressed)
   Data Size:    1151178 Bytes =  1.1 MB
   Load Address: 80060000
   Entry Point:  80060000
   Verifying Checksum at 0x9f080040 ...OK
   Uncompressing Kernel Image ... OK
No initrd
## Transferring control to Linux (at address 80060000) ...
## Giving linux memsize in bytes, 67108864

Starting kernel ...

[    0.000000] Linux version 3.18.11 (guest@WILLS-LINUX-BOX) (gcc version 4.8.3
(OpenWrt/Linaro GCC 4.8-2014.04 r44873) ) #1 Wed Apr 8 07:38:24 MDT 2015
[    0.000000] bootconsole [early0] enabled
[    0.000000] CPU0 revision is: 00019374 (MIPS 24Kc)
[    0.000000] SoC: Atheros AR9330 rev 1
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 04000000 @ 00000000 (usable)
[    0.000000] Initrd not found or empty - disabling initrd
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x00000000-0x03ffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00000000-0x03ffffff]
[    0.000000] Initmem setup node 0 [mem 0x00000000-0x03ffffff]
[    0.000000] Primary instruction cache 64kB, VIPT, 4-way, linesize 32 bytes.
[    0.000000] Primary data cache 32kB, 4-way, VIPT, cache aliases, linesize 32
bytes
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pag
es: 16256
[    0.000000] Kernel command line:  board=DIR-505-A1 console=ttyATH0,115200 mtd
parts=spi0.0:64k(u-boot)ro,64k(art)ro,64k(mac)ro,64k(nvram)ro,256k(language)ro,7
680k@0x80000(firmware) rootfstype=squashfs,jffs2 noinitrd
[    0.000000] PID hash table entries: 256 (order: -2, 1024 bytes)
[    0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Writing ErrCtl register=00000000
[    0.000000] Readback ErrCtl register=00000000
[    0.000000] Memory: 60944K/65536K available (2484K kernel code, 125K rwdata,
528K rodata, 244K init, 188K bss, 4592K reserved)
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS:51
[    0.000000] Clocks: CPU:400.000MHz, DDR:400.000MHz, AHB:200.000MHz, Ref:25.00
0MHz
[    0.000000] Calibrating delay loop... 265.42 BogoMIPS (lpj=1327104)
[    0.080000] pid_max: default: 32768 minimum: 301
[    0.080000] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.090000] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.100000] NET: Registered protocol family 16
[    0.100000] MIPS: machine is D-Link DIR-505 rev. A1
[    0.610000] Switched to clocksource MIPS
[    0.610000] NET: Registered protocol family 2
[    0.620000] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    0.620000] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    0.620000] TCP: Hash tables configured (established 1024 bind 1024)
[    0.630000] TCP: reno registered
[    0.630000] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.640000] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.650000] NET: Registered protocol family 1
[    0.650000] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.670000] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.670000] jffs2: version 2.2 (NAND) (SUMMARY) (LZMA) (RTIME) (CMODE_PRIORIT
Y) (c) 2001-2006 Red Hat, Inc.
[    0.680000] msgmni has been set to 119
[    0.680000] io scheduler noop registered
[    0.690000] io scheduler deadline registered (default)
[    0.690000] Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
[    0.700000] ar933x-uart: ttyATH0 at MMIO 0x18020000 (irq = 11, base_baud = 15
62500) is a AR933X UART
[    0.710000] console [ttyATH0] enabled
[    0.710000] console [ttyATH0] enabled
[    0.710000] bootconsole [early0] disabled
[    0.710000] bootconsole [early0] disabled
[    0.720000] m25p80 spi0.0: found mx25l6405d, expected m25p80
[    0.730000] m25p80 spi0.0: mx25l6405d (8192 Kbytes)
[    0.730000] 6 cmdlinepart partitions found on MTD device spi0.0
[    0.740000] Creating 6 MTD partitions on "spi0.0":
[    0.740000] 0x000000000000-0x000000010000 : "u-boot"
[    0.750000] 0x000000010000-0x000000020000 : "art"
[    0.760000] 0x000000020000-0x000000030000 : "mac"
[    0.760000] 0x000000030000-0x000000040000 : "nvram"
[    0.760000] 0x000000040000-0x000000080000 : "language"
[    0.770000] 0x000000080000-0x000000800000 : "firmware"
[    0.790000] 2 uimage-fw partitions found on MTD device firmware
[    0.800000] 0x000000080000-0x00000019910a : "kernel"
[    0.800000] mtd: partition "kernel" must either start or end on erase block b
oundary or be smaller than an erase block -- forcing read-only
[    0.810000] 0x00000019910a-0x000000800000 : "rootfs"
[    0.820000] mtd: partition "rootfs" must either start or end on erase block b
oundary or be smaller than an erase block -- forcing read-only
[    0.830000] mtd: device 7 (rootfs) set to be root filesystem
[    0.860000] 1 squashfs-split partitions found on MTD device rootfs
[    0.860000] 0x000000660000-0x000000800000 : "rootfs_data"
[    0.880000] libphy: ag71xx_mdio: probed
[    1.470000] ag71xx-mdio.1: Found an AR7240/AR9330 built-in switch
[    1.500000] eth0: Atheros AG71xx at 0xba000000, irq 5, mode:GMII
[    2.090000] ag71xx ag71xx.0: connected to PHY at ag71xx-mdio.1:04 [uid=004dd0
41, driver=Generic PHY]
[    2.100000] eth1: Atheros AG71xx at 0xb9000000, irq 4, mode:MII
[    2.100000] TCP: cubic registered
[    2.100000] NET: Registered protocol family 17
[    2.110000] bridge: automatic filtering via arp/ip/ip6tables has been depreca
ted. Update your scripts to load br_netfilter if you need this.
[    2.120000] 8021q: 802.1Q VLAN Support v1.8
[    2.140000] VFS: Mounted root (squashfs filesystem) readonly on device 31:7.
[    2.140000] Freeing unused kernel memory: 244K (80373000 - 803b0000)
[    3.550000] init: failed to symlink /tmp -> /var
[    3.550000] init: Console is alive
[    3.560000] init: - watchdog -
[    5.980000] usbcore: registered new interface driver usbfs
[    5.990000] usbcore: registered new interface driver hub
[    5.990000] usbcore: registered new device driver usb
[    6.050000] SCSI subsystem initialized
[    6.060000] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    6.060000] ehci-platform: EHCI generic platform driver
[    6.070000] ehci-platform ehci-platform: EHCI Host Controller
[    6.070000] ehci-platform ehci-platform: new USB bus registered, assigned bus
 number 1
[    6.080000] ehci-platform ehci-platform: irq 3, io mem 0x1b000000
[    6.110000] ehci-platform ehci-platform: USB 2.0 started, EHCI 1.00
[    6.110000] hub 1-0:1.0: USB hub found
[    6.110000] hub 1-0:1.0: 1 port detected
[    6.120000] usbcore: registered new interface driver usb-storage
[    6.440000] usb 1-1: new full-speed USB device number 2 using ehci-platform
[    6.610000] init: - preinit -
[    7.310000] random: procd urandom read with 12 bits of entropy available
Press the [f] key and hit [enter] to enter failsafe mode
Press the [1], [2], [3] or [4] key and hit [enter] to select the debug level
[    9.680000] mount_root: loading kmods from internal overlay
[   10.070000] jffs2: notice: (353) jffs2_build_xattr_subsystem: complete buildi
ng xattr subsystem, 1 of xdatum (1 unchecked, 0 orphan) and 1 of xref (0 dead, 0
 orphan) found.
[   10.090000] block: attempting to load /tmp/jffs_cfg/upper/etc/config/fstab
[   10.100000] block: extroot: not configured
[   10.140000] jffs2: notice: (350) jffs2_build_xattr_subsystem: complete buildi
ng xattr subsystem, 1 of xdatum (1 unchecked, 0 orphan) and 1 of xref (0 dead, 0
 orphan) found.
[   10.250000] eth1: link up (100Mbps/Full duplex)
[   10.380000] block: attempting to load /tmp/jffs_cfg/upper/etc/config/fstab
[   10.390000] block: extroot: not configured
[   10.400000] mount_root: switching to jffs2 overlay
[   10.450000] eth1: link down
[   10.460000] procd: - early -
[   10.460000] procd: - watchdog -
[   11.370000] procd: - ubus -
[   12.380000] procd: - init -
Please press Enter to activate this console.
[   13.890000] NET: Registered protocol family 10
[   13.920000] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   13.990000] hidraw: raw HID events driver (C) Jiri Kosina
[   14.040000] u32 classifier
[   14.040000]     input device check on
[   14.040000]     Actions configured
[   14.050000] Mirror/redirect action on
[   14.060000] nf_conntrack version 0.5.0 (956 buckets, 3824 max)
[   14.150000] Bluetooth: Core ver 2.19
[   14.160000] NET: Registered protocol family 31
[   14.160000] Bluetooth: HCI device and connection manager initialized
[   14.170000] Bluetooth: HCI socket layer initialized
[   14.170000] Bluetooth: L2CAP socket layer initialized
[   14.180000] Bluetooth: SCO socket layer initialized
[   14.190000] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   14.190000] Bluetooth: BNEP filters: protocol multicast
[   14.200000] Bluetooth: BNEP socket layer initialized
[   14.210000] usbcore: registered new interface driver btusb
[   14.210000] Loading modules backported from Linux version master-2015-03-09-0
-g141f155
[   14.220000] Backport generated by backports.git backports-20150129-0-gdd4a670

[   14.230000] bluetooth hci0: Direct firmware load for brcm/BCM20702A0-0a5c-21e
8.hcd failed with error -2
[   14.230000] bluetooth hci0: Falling back to user helper
[   14.260000] Bluetooth: HCI UART driver ver 2.2
[   14.260000] Bluetooth: HCI H4 protocol initialized
[   14.270000] Bluetooth: HCI BCSP protocol initialized
[   14.270000] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   14.280000] Bluetooth: HIDP socket layer initialized
[   14.290000] ip_tables: (C) 2000-2006 Netfilter Core Team
[   14.400000] Bluetooth: RFCOMM TTY layer initialized
[   14.400000] Bluetooth: RFCOMM socket layer initialized
[   14.400000] Bluetooth: RFCOMM ver 1.11
[   14.500000] xt_time: kernel timezone is -0000
[   14.570000] cfg80211: Calling CRDA to update world regulatory domain
[   14.640000] cfg80211: World regulatory domain updated:
[   14.650000] cfg80211:  DFS Master region: unset
[   14.650000] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gai
n, max_eirp), (dfs_cac_time)
[   14.660000] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (N/A, 2000 m
Bm), (N/A)
[   14.670000] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz), (N/A, 2000 m
Bm), (N/A)
[   14.680000] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (N/A, 2000 m
Bm), (N/A)
[   14.690000] cfg80211:   (5170000 KHz - 5250000 KHz @ 80000 KHz), (N/A, 2000 m
Bm), (N/A)
[   14.690000] cfg80211:   (5250000 KHz - 5330000 KHz @ 80000 KHz, 160000 KHz AU
TO), (N/A, 2000 mBm), (0 s)
[   14.700000] cfg80211:   (5490000 KHz - 5730000 KHz @ 160000 KHz), (N/A, 2000
mBm), (0 s)
[   14.710000] cfg80211:   (5735000 KHz - 5835000 KHz @ 80000 KHz), (N/A, 2000 m
Bm), (N/A)
[   14.720000] cfg80211:   (57240000 KHz - 63720000 KHz @ 2160000 KHz), (N/A, 0
mBm), (N/A)
[   14.760000] firmware brcm!BCM20702A0-0a5c-21e8.hcd: firmware_loading_store: m
ap pages failed
[   14.770000] Bluetooth: hci0: BCM: patch brcm/BCM20702A0-0a5c-21e8.hcd not fou
nd
[   14.790000] PPP generic driver version 2.4.2
[   14.810000] NET: Registered protocol family 24
[   14.910000] Bluetooth: Unable to create crypto context
[   14.940000] ieee80211 phy0: Atheros AR9330 Rev:1 mem=0xb8100000, irq=2
[   14.960000] cfg80211: Calling CRDA for country: US
[   14.960000] cfg80211: Regulatory domain changed to country: US
[   14.970000] cfg80211:  DFS Master region: FCC
[   14.970000] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gai
n, max_eirp), (dfs_cac_time)
[   14.980000] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (N/A, 3000 m
Bm), (N/A)
[   14.990000] cfg80211:   (5170000 KHz - 5250000 KHz @ 80000 KHz, 160000 KHz AU
TO), (N/A, 1700 mBm), (N/A)
[   15.000000] cfg80211:   (5250000 KHz - 5330000 KHz @ 80000 KHz, 160000 KHz AU
TO), (N/A, 2300 mBm), (0 s)
[   15.010000] cfg80211:   (5735000 KHz - 5835000 KHz @ 80000 KHz), (N/A, 3000 m
Bm), (N/A)
[   15.010000] cfg80211:   (57240000 KHz - 63720000 KHz @ 2160000 KHz), (N/A, 40
00 mBm), (N/A)
[   25.940000] device eth1 entered promiscuous mode
[   25.970000] IPv6: ADDRCONF(NETDEV_UP): br-lan: link is not ready
[   28.690000] eth1: link up (100Mbps/Full duplex)
[   28.690000] br-lan: port 1(eth1) entered forwarding state
[   28.700000] br-lan: port 1(eth1) entered forwarding state
[   28.710000] IPv6: ADDRCONF(NETDEV_CHANGE): br-lan: link becomes ready
[   30.700000] br-lan: port 1(eth1) entered forwarding state

BusyBox v1.23.2 (2015-04-06 07:12:41 MDT) built-in shell (ash)

  _______                     ________        __
 |       |.-----.-----.-----.|  |  |  |.----.|  |_
 |   -   ||  _  |  -__|     ||  |  |  ||   _||   _|
 |_______||   __|_____|__|__||________||__|  |____|
          |__| W I R E L E S S   F R E E D O M
 -----------------------------------------------------
 CHAOS CALMER (Bleeding Edge, r45313)
 -----------------------------------------------------
  * 1 1/2 oz Gin            Shake with a glassful
  * 1/4 oz Triple Sec       of broken ice and pour
  * 3/4 oz Lime Juice       unstrained into a goblet.
  * 1 1/2 oz Orange Juice
  * 1 tsp. Grenadine Syrup
 -----------------------------------------------------
root@OpenWrt:/#


EXAMPLE 1:
root@OpenWrt:/# hciconfig hci0 up
root@OpenWrt:/# gatttool --adapter=hci0 --sec-level=medium -I
[                 ][LE]> connect EC:FE:7E:10:95:1F
Attempting to connect to EC:FE:7E:10:95:1F
Connection successful
[EC:FE:7E:10:95:1F][LE]>
[EC:FE:7E:10:95:1F][LE]> disconnect
(gatttool:2082): GLib-WARNING **: Invalid file descriptor.
[EC:FE:7E:10:95:1F][LE]>

EXAMPLE 2:
root@OpenWrt:/# hciconfig hci0 up
root@OpenWrt:/# gatttool --adapter=hci0 --sec-level=medium -I
[                 ][LE]> connect EC:FE:7E:10:95:1F
Attempting to connect to EC:FE:7E:10:95:1F
Connection successful
[EC:FE:7E:10:95:1F][LE]>
[EC:FE:7E:10:95:1F][LE]> sec-level medium
[  583.700000] CPU 0 Unable to handle kernel paging request at virtual address 0
0000200, epc == 80067e20, ra == 831f1668
[  583.700000] Oops[#1]:
[  583.700000] CPU: 0 PID: 2457 Comm: gatttool Not tainted 3.18.11 #1
[  583.700000] task: 82b40000 ti: 8383c000 task.ti: 8383c000
[  583.700000] $ 0   : 00000000 7fb6dac6 00000000 00000000
[  583.700000] $ 4   : 00000200 8292a40c 00000000 00000000
[  583.700000] $ 8   : 00000000 00000000 00000001 00000057
[  583.700000] $12   : 7fb6da90 00000002 00000000 00000000
[  583.700000] $16   : 8292a400 82ae9400 00000000 00000002
[  583.700000] $20   : 00000200 006f5ba0 7709d118 00000000
[  583.700000] $24   : 00000000 76f30a40
[  583.700000] $28   : 8383c000 8383de88 00000000 831f1668
[  583.700000] Hi    : 00000020
[  583.700000] Lo    : 00000033
[  583.700000] epc   : 80067e20 mutex_lock+0x0/0x30
[  583.700000]     Not tainted
[  583.700000] ra    : 831f1668 smp_conn_security+0x88/0x200 [bluetooth]
[  583.700000] Status: 1000fc03 KERNEL EXL IE
[  583.700000] Cause : 00800008
[  583.700000] BadVA : 00000200
[  583.700000] PrId  : 00019374 (MIPS 24Kc)
[  583.700000] Modules linked in: ath9k ath9k_common pppoe ppp_async iptable_nat
 ath9k_hw ath pppox ppp_generic nf_nat_ipv4 nf_conntrack_ipv6 nf_conntrack_ipv4
mac80211 ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_tcpmss xt_strin
g xt_statistic xt_state xt_recent xt_nat xt_multiport xt_mark xt_mac xt_limit xt
_length xt_id xt_hl xt_helper xt_ecn xt_dscp xt_conntrack xt_connmark xt_connlim
it xt_connbytes xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_HL xt_DSCP xt_CT xt_C
LASSIFY ts_kmp ts_fsm ts_bm slhc rfcomm nf_reject_ipv4 nf_nat_masquerade_ipv4 nf
_nat_irc nf_nat_ftp nf_nat nf_log_ipv4 nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrac
k_rtcache nf_conntrack_irc nf_conntrack_ftp iptable_raw iptable_mangle iptable_f
ilter ipt_ECN ip_tables hidp hci_uart crc_ccitt compat btusb bnep bluetooth act_
connmark nf_conntrack act_skbedit act_mirred em_u32 cls_u32 cls_tcindex cls_flow
 cls_route cls_fw sch_hfsc sch_ingress hid evdev input_core ledtrig_usbdev ip6t_
REJECT nf_reject_ipv6 nf_log_ipv6 nf_log_common ip6table_raw ip6table_mangle ip6
table_filter ip6_tables x_tables ifb ipv6 arc4 crypto_blkcipher usb_storage ehci
_platform ehci_hcd sd_mod scsi_mod gpio_button_hotplug ext4 jbd2 mbcache usbcore
 nls_base usb_common crc16 crypto_hash
[  583.700000] Process gatttool (pid: 2457, threadinfo=8383c000, task=82b40000,
tls=77158750)
[  583.700000] Stack : 8383df00 80134510 0000540f 00000000 7fb6db78 801382a0 829
2a800 7fb6dac4
          82a46e00 ffffffea 831f7b50 831ee274 7709d118 7fb6dbe0 8383dee8 006f58a
8
          02000000 802693f8 00000004 800796d4 83587580 00000002 7fb6dac4 0000000
4
          00000112 8007c714 00000000 00000000 00000000 00000000 00000002 0000000
0
          00000000 00000000 00000005 00000002 006f58a8 77128b70 00000000 80062b5
c
          ...
[  583.700000] Call Trace:
[  583.700000] [<80067e20>] mutex_lock+0x0/0x30
[  583.700000] [<831f1668>] smp_conn_security+0x88/0x200 [bluetooth]
[  583.700000] [<831ee274>] l2cap_is_socket+0x1514/0x242c [bluetooth]
[  583.700000]
[  583.700000]
Code: 8fb00024  03e00008  27bd0040 <c0820000> 2443ffff  e0830000  1060fffc  0000
0000  2442ffff
[  583.980000] ---[ end trace 8f75012237ecc092 ]---


EXAMPLE 3:
[bluetooth]#
root@OpenWrt:/# bluetoothctl
[bluetooth]#
[NEW] Controller 00:19:0E:12:46:8A BlueZ 5.30 [default]
[bluetooth]#
[bluetooth]# power on
[bluetooth]#
Changing power on succeeded
[bluetooth]#
[CHG] Controller 00:19:0E:12:46:8A Powered: yes
[bluetooth]#
[bluetooth]# [   67.640000] random: nonblocking pool is initialized
[bluetooth]#
scan on
[bluetooth]#
Discovery started
[bluetooth]#
[CHG] Controller 00:19:0E:12:46:8A Discovering: yes
[bluetooth]#
[NEW] Device EC:FE:7E:00:00:22 BlueRadios000022
[bluetooth]# scan o
[NEW] Device 6A:F4:BB:1F:8C:14 6A-F4-BB-1F-8C-14
[NEW] Device 67:89:36:EB:AF:2C 67-89-36-EB-AF-2C
[bluetooth]#
[NEW] Device 41:AF:82:1F:33:EC 41-AF-82-1F-33-EC
[bluetooth]#
[NEW] Device EC:FE:7E:11:6C:41 BLEbeacon116C41
[bluetooth]#
[NEW] Device EC:FE:7E:10:68:23 EC-FE-7E-10-68-23
[bluetooth]#
[NEW] Device 5C:31:3E:55:26:9D MagAlert55269D
[bluetooth]#
[NEW] Device 6D:1B:7B:30:05:0D 6D-1B-7B-30-05-0D
[bluetooth]#
[NEW] Device EC:FE:7E:10:AD:99 SensorBug10AD99
[bluetooth]#
[NEW] Device EC:FE:7E:0F:13:FE EC-FE-7E-0F-13-FE
[bluetooth]#
[NEW] Device FD:0C:87:41:62:10 FD-0C-87-41-62-10
[bluetooth]#
[NEW] Device D8:6B:89:E7:B8:88 estimote
[bluetooth]#
[NEW] Device EC:FE:7E:10:95:1F SensorBug10951F
[bluetooth]#
[NEW] Device F7:8D:75:19:38:CA F7-8D-75-19-38-CA
[bluetooth]#
[NEW] Device EC:FE:7E:12:4B:9D EC-FE-7E-12-4B-9D
[bluetooth]#
[NEW] Device EC:FE:7E:10:E5:51 EC-FE-7E-10-E5-51
[bluetooth]#
[NEW] Device EC:FE:7E:10:86:62 BlueRadios108662
[bluetooth]#
[CHG] Device EC:FE:7E:10:E5:51 Name: BlueRadios10E551
[bluetooth]#
[CHG] Device EC:FE:7E:10:E5:51 Alias: BlueRadios10E551
[bluetooth]#
[NEW] Device EC:FE:7E:10:AD:3E EC-FE-7E-10-AD-3E
[bluetooth]#
[CHG] Device EC:FE:7E:0F:13:FE Name: Mongoose0F13FE
[bluetooth]#
[CHG] Device EC:FE:7E:0F:13:FE Alias: Mongoose0F13FE
[bluetooth]#
[CHG] Device FD:0C:87:41:62:10 Name: estimote
[bluetooth]#
[CHG] Device FD:0C:87:41:62:10 Alias: estimote
[NEW] Device 00:19:0E:12:46:49 00-19-0E-12-46-49
[bluetooth]# scan off
[CHG] Device 00:19:0E:12:46:49 RSSI is nil
[CHG] Device EC:FE:7E:10:AD:3E RSSI is nil
[CHG] Device EC:FE:7E:10:86:62 RSSI is nil
[CHG] Device EC:FE:7E:10:E5:51 RSSI is nil
[CHG] Device EC:FE:7E:12:4B:9D RSSI is nil
[CHG] Device F7:8D:75:19:38:CA RSSI is nil
[CHG] Device EC:FE:7E:10:95:1F RSSI is nil
[CHG] Device D8:6B:89:E7:B8:88 RSSI is nil
[CHG] Device FD:0C:87:41:62:10 RSSI is nil
[CHG] Device EC:FE:7E:0F:13:FE RSSI is nil
[CHG] Device EC:FE:7E:10:AD:99 RSSI is nil
[CHG] Device 6D:1B:7B:30:05:0D RSSI is nil
[CHG] Device 5C:31:3E:55:26:9D RSSI is nil
[CHG] Device EC:FE:7E:10:68:23 RSSI is nil
[CHG] Device EC:FE:7E:11:6C:41 RSSI is nil
[CHG] Device 41:AF:82:1F:33:EC RSSI is nil
[CHG] Device 67:89:36:EB:AF:2C RSSI is nil
[CHG] Device 6A:F4:BB:1F:8C:14 RSSI is nil
[CHG] Device EC:FE:7E:00:00:22 RSSI is nil
Discovery stopped
[CHG] Controller 00:19:0E:12:46:8A Discovering: no
[bluetooth]#
 [bluetooth]# pair EC:FE:7E:10:95:1F
Attempting to pair with EC:FE:7E:10:95:1F
[  219.850000] CPU 0 Unable to handle kernel paging request at virtual address 0
0000200, epc == 80067e20, ra == 83231668
[  219.860000] Oops[#1]:
[  219.860000] CPU: 0 PID: 685 Comm: kworker/u3:0 Not tainted 3.18.11 #1
[  219.860000] Workqueue: hci0 hci_alloc_dev [bluetooth]
[  219.860000] task: 8305dd10 ti: 8316c000 task.ti: 8316c000
[  219.860000] $ 0   : 00000000 00000000 00000000 00000000
[  219.860000] $ 4   : 00000200 82a2400c 00000000 00000000
[  219.860000] $ 8   : ffffffec 00000001 00000003 1f95107e
[  219.860000] $12   : 00000000 00000000 00000000 00000000
[  219.860000] $16   : 82a24000 8297bb00 00000000 00000002
[  219.860000] $20   : 00000200 00000003 8297bb94 00000080
[  219.860000] $24   : 00000003 8322cf20
[  219.860000] $28   : 8316c000 8316dc90 00000005 83231668
[  219.860000] Hi    : 00000009
[  219.860000] Lo    : 00000fa0
[  219.860000] epc   : 80067e20 mutex_lock+0x0/0x30
[  219.860000]     Not tainted
[  219.860000] ra    : 83231668 smp_conn_security+0x88/0x200 [bluetooth]
[  219.860000] Status: 1000fc03 KERNEL EXL IE
[  219.860000] Cause : 00800008
[  219.860000] BadVA : 00000200
[  219.860000] PrId  : 00019374 (MIPS 24Kc)
[  219.860000] Modules linked in: ath9k ath9k_common pppoe ppp_async iptable_nat
 ath9k_hw ath pppox ppp_generic nf_nat_ipv4 nf_conntrack_ipv6 nf_conntrack_ipv4
mac80211 ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_tcpmss xt_strin
g xt_statistic xt_state xt_recent xt_nat xt_multiport xt_mark xt_mac xt_limit xt
_length xt_id xt_hl xt_helper xt_ecn xt_dscp xt_conntrack xt_connmark xt_connlim
it xt_connbytes xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_HL xt_DSCP xt_CT xt_C
LASSIFY ts_kmp ts_fsm ts_bm slhc rfcomm nf_reject_ipv4 nf_nat_masquerade_ipv4 nf
_nat_irc nf_nat_ftp nf_nat nf_log_ipv4 nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrac
k_rtcache nf_conntrack_irc nf_conntrack_ftp iptable_raw iptable_mangle iptable_f
ilter ipt_ECN ip_tables hidp hci_uart crc_ccitt compat btusb bnep bluetooth act_
connmark nf_conntrack act_skbedit act_mirred em_u32 cls_u32 cls_tcindex cls_flow
 cls_route cls_fw sch_hfsc sch_ingress hid evdev input_core ledtrig_usbdev ip6t_
REJECT nf_reject_ipv6 nf_log_ipv6 nf_log_common ip6table_raw ip6table_mangle ip6
table_filter ip6_tables x_tables ifb ipv6 arc4 crypto_blkcipher usb_storage ehci
_platform ehci_hcd sd_mod scsi_mod gpio_button_hotplug ext4 jbd2 mbcache usbcore
 nls_base usb_common crc16 crypto_hash
[  219.860000] Process kworker/u3:0 (pid: 685, threadinfo=8316c000, task=8305dd1
0, tls=00000000)
[  219.860000] Stack : 82949c00 832283f0 82a42600 8297bb00 82a24000 82949c00 829
7bb00 82a24000
          82a24000 8297bbac 8297bb9c 8322c69c 83bf7000 82a24170 82a4280b 8011d22
8
          83bf7000 82a24170 82a4280b 82a2400c 82a24013 00000000 83bf7000 82a2400
0
          00000000 82a2400c 83bf7008 00000000 832381e8 832381b8 00000088 83211f5
8
          fffffff5 800f9b18 83bf7000 83bf76bc 00000000 00000000 00000000 0000000
0
          ...
[  219.860000] Call Trace:
[  219.860000] [<80067e20>] mutex_lock+0x0/0x30
[  219.860000] [<83231668>] smp_conn_security+0x88/0x200 [bluetooth]
[  219.860000] [<8322c69c>] l2cap_connect_cfm+0x290/0x354 [bluetooth]
[  219.860000] [<83211f58>] hci_chan_lookup_handle+0x4fec/0x5968 [bluetooth]
[  219.860000]
[  219.860000]
Code: 8fb00024  03e00008  27bd0040 <c0820000> 2443ffff  e0830000  1060fffc  0000
0000  2442ffff
[  220.150000] ---[ end trace 8f75012237ecc092 ]---
[bluetooth]# [  220.160000] CPU 0 Unable to handle kernel paging request at virt
ual address fffffff0, epc == 801b57ac, ra == 802c91b8
[  220.160000] Oops[#2]:
[  220.160000] CPU: 0 PID: 685 Comm: kworker/u3:0 Tainted: G      D        3.18.
11 #1
[  220.160000] task: 8305dd10 ti: 8316c000 task.ti: 8316c000
[  220.160000] $ 0   : 00000000 803d0000 00000000 0f003f70
[  220.160000] $ 4   : 8305dd10 00000000 80359590 0f003f70
[  220.160000] $ 8   : 00000008 00000000 00000000 00090014
[  220.160000] $12   : 0000000e 00000007 00000001 80337ed4
[  220.160000] $16   : 00000000 00000001 80359590 83828000
[  220.160000] $20   : 8305df0c 80360000 80359590 00000000
[  220.160000] $24   : 0000000e 801176a0
[  220.160000] $28   : 8316c000 8316da48 00000010 802c91b8
[  220.160000] Hi    : 00000033
[  220.160000] Lo    : 428f0000
[  220.160000] epc   : 801b57ac kthread_data+0x4/0xc
[  220.160000]     Tainted: G      D
[  220.160000] ra    : 802c91b8 wq_worker_sleeping+0x14/0xc0
[  220.160000] Status: 1000fc02 KERNEL EXL
[  220.160000] Cause : 80800008
[  220.160000] BadVA : fffffff0
[  220.160000] PrId  : 00019374 (MIPS 24Kc)
[  220.160000] Modules linked in: ath9k ath9k_common pppoe ppp_async iptable_nat
 ath9k_hw ath pppox ppp_generic nf_nat_ipv4 nf_conntrack_ipv6 nf_conntrack_ipv4
mac80211 ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_tcpmss xt_strin
g xt_statistic xt_state xt_recent xt_nat xt_multiport xt_mark xt_mac xt_limit xt
_length xt_id xt_hl xt_helper xt_ecn xt_dscp xt_conntrack xt_connmark xt_connlim
it xt_connbytes xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_HL xt_DSCP xt_CT xt_C
LASSIFY ts_kmp ts_fsm ts_bm slhc rfcomm nf_reject_ipv4 nf_nat_masquerade_ipv4 nf
_nat_irc nf_nat_ftp nf_nat nf_log_ipv4 nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrac
k_rtcache nf_conntrack_irc nf_conntrack_ftp iptable_raw iptable_mangle iptable_f
ilter ipt_ECN ip_tables hidp hci_uart crc_ccitt compat btusb bnep bluetooth act_
connmark nf_conntrack act_skbedit act_mirred em_u32 cls_u32 cls_tcindex cls_flow
 cls_route cls_fw sch_hfsc sch_ingress hid evdev input_core ledtrig_usbdev ip6t_
REJECT nf_reject_ipv6 nf_log_ipv6 nf_log_common ip6table_raw ip6table_mangle ip6
table_filter ip6_tables x_tables ifb ipv6 arc4 crypto_blkcipher usb_storage ehci
_platform ehci_hcd sd_mod scsi_mod gpio_button_hotplug ext4 jbd2 mbcache usbcore
 nls_base usb_common crc16 crypto_hash
[  220.160000] Process kworker/u3:0 (pid: 685, threadinfo=8316c000, task=8305dd1
0, tls=00000000)
[  220.160000] Stack : 00000001 80359590 83828000 8305df0c 8305dd10 80066278 803
d0000 00000000
          8316da68 8316da68 8305dd10 00000001 8305dd08 83828000 8305de88 0000000
1
          8305dd08 00000000 00000010 80129764 803d48c0 00000002 80362a9c 803d000
0
          8316daa8 8316daa8 8305ded0 08000000 8316daa8 8316dad4 8316dbd8 8031896
4
          0000000b 00000028 00000200 00000003 00000000 00000000 00030000 80122df
c
          ...
[  220.160000] Call Trace:
[  220.160000] [<801b57ac>] kthread_data+0x4/0xc
[  220.160000] [<802c91b8>] wq_worker_sleeping+0x14/0xc0
[  220.160000] [<80066278>] __schedule+0x108/0x5b4
[  220.160000] [<80129764>] do_exit+0x74c/0x764
[  220.160000] [<80122dfc>] direct_finish_page+0x0/0x20
[  220.160000]
[  220.160000]
Code: 03e00008  27bd0040  8c8201d0 <03e00008> 8c42fff0  08041103  24840010  1080
0002  00000000
[  220.450000] ---[ end trace 8f75012237ecc093 ]---
[  220.460000] Fixing recursive fault but reboot is needed!
[  220.460000] CPU 0 Unable to handle kernel paging request at virtual address f
ffffff0, epc == 801b57ac, ra == 802c91b8
[  220.460000] Oops[#3]:
[  220.460000] CPU: 0 PID: 685 Comm: kworker/u3:0 Tainted: G      D        3.18.
11 #1
[  220.460000] task: 8305dd10 ti: 8316c000 task.ti: 8316c000
[  220.460000] $ 0   : 00000000 00000001 00000000 0f003f70
[  220.460000] $ 4   : 8305dd10 00000000 80359590 0f003f70
[  220.460000] $ 8   : 00000008 00000000 00000000 626f6f74
[  220.460000] $12   : 00000000 03bf0000 00000000 61756c74
[  220.460000] $16   : 00000000 0000000b 80359590 00000028
[  220.460000] $20   : 8305df0c 80360000 80359590 00000000
[  220.460000] $24   : 00000003 801176a0
[  220.460000] $28   : 8316c000 8316d800 00030000 802c91b8
[  220.460000] Hi    : 00000033
[  220.460000] Lo    : 5470a300
[  220.460000] epc   : 801b57ac kthread_data+0x4/0xc
[  220.460000]     Tainted: G      D
[  220.460000] ra    : 802c91b8 wq_worker_sleeping+0x14/0xc0
[  220.460000] Status: 1000fc02 KERNEL EXL
[  220.460000] Cause : 80800008
[  220.460000] BadVA : fffffff0
[  220.460000] PrId  : 00019374 (MIPS 24Kc)
[  220.460000] Modules linked in: ath9k ath9k_common pppoe ppp_async iptable_nat
 ath9k_hw ath pppox ppp_generic nf_nat_ipv4 nf_conntrack_ipv6 nf_conntrack_ipv4
mac80211 ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_tcpmss xt_strin
g xt_statistic xt_state xt_recent xt_nat xt_multiport xt_mark xt_mac xt_limit xt
_length xt_id xt_hl xt_helper xt_ecn xt_dscp xt_conntrack xt_connmark xt_connlim
it xt_connbytes xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_HL xt_DSCP xt_CT xt_C
LASSIFY ts_kmp ts_fsm ts_bm slhc rfcomm nf_reject_ipv4 nf_nat_masquerade_ipv4 nf
_nat_irc nf_nat_ftp nf_nat nf_log_ipv4 nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrac
k_rtcache nf_conntrack_irc nf_conntrack_ftp iptable_raw iptable_mangle iptable_f
ilter ipt_ECN ip_tables hidp hci_uart crc_ccitt compat btusb bnep bluetooth act_
connmark nf_conntrack act_skbedit act_mirred em_u32 cls_u32 cls_tcindex cls_flow
 cls_route cls_fw sch_hfsc sch_ingress hid evdev input_core ledtrig_usbdev ip6t_
REJECT nf_reject_ipv6 nf_log_ipv6 nf_log_common ip6table_raw ip6table_mangle ip6
table_filter ip6_tables x_tables ifb ipv6 arc4 crypto_blkcipher usb_storage ehci
_platform ehci_hcd sd_mod scsi_mod gpio_button_hotplug ext4 jbd2 mbcache usbcore
 nls_base usb_common crc16 crypto_hash
[  220.460000] Process kworker/u3:0 (pid: 685, threadinfo=8316c000, task=8305dd1
0, tls=00000000)
[  220.460000] Stack : 0000000b 80359590 00000028 8305df0c 8305dd10 80066278 000
00000 00000000
          00030000 802b64b4 8305dd10 0000000b 0000000b 00000028 8305df0c 8036000
0
          00000000 00000000 00030000 80129114 803d48c0 00000038 00000014 0000003
2
          803d0000 801b1cb8 00000000 00000050 80319e80 8316d88c 8316d990 8031896
4
          0000000b 00000028 8305df0c 80360000 00000000 00000000 00030000 80122df
c
          ...
[  220.460000] Call Trace:
[  220.460000] [<801b57ac>] kthread_data+0x4/0xc
[  220.460000] [<802c91b8>] wq_worker_sleeping+0x14/0xc0
[  220.460000] [<80066278>] __schedule+0x108/0x5b4
[  220.460000] [<80129114>] do_exit+0xfc/0x764
[  220.460000] [<80122dfc>] direct_finish_page+0x0/0x20
[  220.460000]
[  220.460000]
Code: 03e00008  27bd0040  8c8201d0 <03e00008> 8c42fff0  08041103  24840010  1080
0002  00000000
[  220.750000] ---[ end trace 8f75012237ecc094 ]---
[  220.760000] Fixing recursive fault but reboot is needed!
[  220.760000] CPU 0 Unable to handle kernel paging request at virtual address f
ffffff0, epc == 801b57ac, ra == 802c91b8
[  220.760000] Oops[#4]:
[  220.760000] CPU: 0 PID: 685 Comm: kworker/u3:0 Tainted: G      D        3.18.
11 #1
[  220.760000] task: 8305dd10 ti: 8316c000 task.ti: 8316c000
[  220.760000] $ 0   : 00000000 00000001 00000000 0f003f70
[  220.760000] $ 4   : 8305dd10 00000000 80359590 0f003f70
[  220.760000] $ 8   : 00000008 00000000 00000000 626f6f74
[  220.760000] $12   : 00000000 03bf0000 00000000 61756c74
[  220.760000] $16   : 00000000 0000000b 80359590 00000028
[  220.760000] $20   : 8305df0c 80360000 80359590 00000000
[  220.760000] $24   : 00000003 801176a0
[  220.760000] $28   : 8316c000 8316d5b8 00030000 802c91b8
[  220.760000] Hi    : 00000033
[  220.760000] Lo    : 66524600
[  220.760000] epc   : 801b57ac kthread_data+0x4/0xc
[  220.760000]     Tainted: G      D
[  220.760000] ra    : 802c91b8 wq_worker_sleeping+0x14/0xc0
[  220.760000] Status: 1000fc02 KERNEL EXL
[  220.760000] Cause : 80800008
[  220.760000] BadVA : fffffff0
[  220.760000] PrId  : 00019374 (MIPS 24Kc)
[  220.760000] Modules linked in: ath9k ath9k_common pppoe ppp_async iptable_nat
 ath9k_hw ath pppox ppp_generic nf_nat_ipv4 nf_conntrack_ipv6 nf_conntrack_ipv4
mac80211 ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_tcpmss xt_strin
g xt_statistic xt_state xt_recent xt_nat xt_multiport xt_mark xt_mac xt_limit xt
_length xt_id xt_hl xt_helper xt_ecn xt_dscp xt_conntrack xt_connmark xt_connlim
it xt_connbytes xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_HL xt_DSCP xt_CT xt_C
LASSIFY ts_kmp ts_fsm ts_bm slhc rfcomm nf_reject_ipv4 nf_nat_masquerade_ipv4 nf
_nat_irc nf_nat_ftp nf_nat nf_log_ipv4 nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrac
k_rtcache nf_conntrack_irc nf_conntrack_ftp iptable_raw iptable_mangle iptable_f
ilter ipt_ECN ip_tables hidp hci_uart crc_ccitt compat btusb bnep bluetooth act_
connmark nf_conntrack act_skbedit act_mirred em_u32 cls_u32 cls_tcindex cls_flow
 cls_route cls_fw sch_hfsc sch_ingress hid evdev input_core ledtrig_usbdev ip6t_
REJECT nf_reject_ipv6 nf_log_ipv6 nf_log_common ip6table_raw ip6table_mangle ip6
table_filter ip6_tables x_tables ifb ipv6 arc4 crypto_blkcipher usb_storage ehci
_platform ehci_hcd sd_mod scsi_mod gpio_button_hotplug ext4 jbd2 mbcache usbcore
 nls_base usb_common crc16 crypto_hash
[  220.760000] Process kworker/u3:0 (pid: 685, threadinfo=8316c000, task=8305dd1
0, tls=00000000)
[  220.760000] Stack : 0000000b 80359590 00000028 8305df0c 8305dd10 80066278 000
00000 00000000
          00030000 802b64b4 8305dd10 0000000b 0000000b 00000028 8305df0c 8036000
0
          00000000 00000000 00030000 80129114 803d48c0 00000038 00000014 0000003
2
          803d0000 801b1cb8 00000000 00000050 80319e80 8316d644 8316d748 8031896
4
          0000000b 00000028 8305df0c 80360000 00000000 00000000 00030000 80122df
c
          ...
[  220.760000] Call Trace:
[  220.760000] [<801b57ac>] kthread_data+0x4/0xc
[  220.760000] [<802c91b8>] wq_worker_sleeping+0x14/0xc0
[  220.760000] [<80066278>] __schedule+0x108/0x5b4
[  220.760000] [<80129114>] do_exit+0xfc/0x764
[  220.760000] [<80122dfc>] direct_finish_page+0x0/0x20
[  220.760000]
[  220.760000]
Code: 03e00008  27bd0040  8c8201d0 <03e00008> 8c42fff0  08041103  24840010  1080
0002  00000000
[  221.050000] ---[ end trace 8f75012237ecc095 ]---
[  221.060000] Fixing recursive fault but reboot is needed!
[  221.060000] CPU 0 Unable to handle kernel paging request at virtual address f
ffffff0, epc == 801b57ac, ra == 802c91b8
[  221.060000] Oops[#5]:
[  221.060000] CPU: 0 PID: 685 Comm: kworker/u3:0 Tainted: G      D        3.18.
11 #1
[  221.060000] task: 8305dd10 ti: 8316c000 task.ti: 8316c000
[  221.060000] $ 0   : 00000000 00000001 00000000 0f003f70
[  221.060000] $ 4   : 8305dd10 00000000 80359590 0f003f70
[  221.060000] $ 8   : 00000008 00000000 00000000 626f6f74
[  221.060000] $12   : 00000000 03bf0000 00000000 61756c74
[  221.060000] $16   : 00000000 0000000b 80359590 00000028
[  221.060000] $20   : 8305df0c 80360000 80359590 00000000
[  221.060000] $24   : 00000003 801176a0
[  221.060000] $28   : 8316c000 8316d370 00030000 802c91b8
[  221.060000] Hi    : 00000033
[  221.060000] Lo    : 7833e900
[  221.060000] epc   : 801b57ac kthread_data+0x4/0xc
[  221.060000]     Tainted: G      D
[  221.060000] ra    : 802c91b8 wq_worker_sleeping+0x14/0xc0
[  221.060000] Status: 1000fc02 KERNEL EXL
[  221.060000] Cause : 80800008
[  221.060000] BadVA : fffffff0
[  221.060000] PrId  : 00019374 (MIPS 24Kc)
[  221.060000] Modules linked in: ath9k ath9k_common pppoe ppp_async iptable_nat
 ath9k_hw ath pppox ppp_generic nf_nat_ipv4 nf_conntrack_ipv6 nf_conntrack_ipv4
mac80211 ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_tcpmss xt_strin
g xt_statistic xt_state xt_recent xt_nat xt_multiport xt_mark xt_mac xt_limit xt
_length xt_id xt_hl xt_helper xt_ecn xt_dscp xt_conntrack xt_connmark xt_connlim
it xt_connbytes xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_HL xt_DSCP xt_CT xt_C
LASSIFY ts_kmp ts_fsm ts_bm slhc rfcomm nf_reject_ipv4 nf_nat_masquerade_ipv4 nf
_nat_irc nf_nat_ftp nf_nat nf_log_ipv4 nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrac
k_rtcache nf_conntrack_irc nf_conntrack_ftp iptable_raw iptable_mangle iptable_f
ilter ipt_ECN ip_tables hidp hci_uart crc_ccitt compat btusb bnep bluetooth act_
connmark nf_conntrack act_skbedit act_mirred em_u32 cls_u32 cls_tcindex cls_flow
 cls_route cls_fw sch_hfsc sch_ingress hid evdev input_core ledtrig_usbdev ip6t_
REJECT nf_reject_ipv6 nf_log_ipv6 nf_log_common ip6table_raw ip6table_mangle ip6
table_filter ip6_tables x_tables ifb ipv6 arc4 crypto_blkcipher usb_storage ehci
_platform ehci_hcd sd_mod scsi_mod gpio_button_hotplug ext4 jbd2 mbcache usbcore
 nls_base usb_common crc16 crypto_hash
[  221.060000] Process kworker/u3:0 (pid: 685, threadinfo=8316c000, task=8305dd1
0, tls=00000000)
[  221.060000] Stack : 0000000b 80359590 00000028 8305df0c 8305dd10 80066278 000
00000 00000000
          00030000 802b64b4 8305dd10 0000000b 0000000b 00000028 8305df0c 8036000
0
          00000000 00000000 00030000 80129114 803d48c0 00000038 00000014 0000003
2
          803d0000 801b1cb8 00000000 00000050 80319e80 8316d3fc 8316d500 8031896
4
          0000000b 00000028 8305df0c 80360000 00000000 00000000 00030000 80122df
c
          ...
[  221.060000] Call Trace:
[  221.060000] [<801b57ac>] kthread_data+0x4/0xc
[  221.060000] [<802c91b8>] wq_worker_sleeping+0x14/0xc0
[  221.060000] [<80066278>] __schedule+0x108/0x5b4
[  221.060000] [<80129114>] do_exit+0xfc/0x764
[  221.060000] [<80122dfc>] direct_finish_page+0x0/0x20
[  221.060000]
[  221.060000]
Code: 03e00008  27bd0040  8c8201d0 <03e00008> 8c42fff0  08041103  24840010  1080
0002  00000000
[  221.350000] ---[ end trace 8f75012237ecc096 ]---
[  221.360000] Fixing recursive fault but reboot is needed!
[  221.360000] CPU 0 Unable to handle kernel paging request at virtual address f
ffffff0, epc == 801b57ac, ra == 802c91b8
[  221.360000] Oops[#6]:
[  221.360000] CPU: 0 PID: 685 Comm: kworker/u3:0 Tainted: G      D        3.18.
11 #1
[  221.360000] task: 8305dd10 ti: 8316c000 task.ti: 8316c000
[  221.360000] $ 0   : 00000000 00000001 00000000 0f003f70
[  221.360000] $ 4   : 8305dd10 00000000 80359590 0f003f70
[  221.360000] $ 8   : 00000008 00000000 00000000 626f6f74
[  221.360000] $12   : 00000000 03bf0000 00000000 61756c74
[  221.360000] $16   : 00000000 0000000b 80359590 00000028
[  221.360000] $20   : 8305df0c 80360000 80359590 00000000
[  221.360000] $24   : 00000003 801176a0
[  221.360000] $28   : 8316c000 8316d128 00030000 802c91b8
[  221.360000] Hi    : 00000033
[  221.360000] Lo    : 8a158c00
[  221.360000] epc   : 801b57ac kthread_data+0x4/0xc
[  221.360000]     Tainted: G      D
[  221.360000] ra    : 802c91b8 wq_worker_sleeping+0x14/0xc0
[  221.360000] Status: 1000fc02 KERNEL EXL
[  221.360000] Cause : 80800008
[  221.360000] BadVA : fffffff0
[  221.360000] PrId  : 00019374 (MIPS 24Kc)
[  221.360000] Modules linked in: ath9k ath9k_common pppoe ppp_async iptable_nat
 ath9k_hw ath pppox ppp_generic nf_nat_ipv4 nf_conntrack_ipv6 nf_conntrack_ipv4
mac80211 ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_tcpmss xt_strin
g xt_statistic xt_state xt_recent xt_nat xt_multiport xt_mark xt_mac xt_limit xt
_length xt_id xt_hl xt_helper xt_ecn xt_dscp xt_conntrack xt_connmark xt_connlim
it xt_connbytes xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_HL xt_DSCP xt_CT xt_C
LASSIFY ts_kmp ts_fsm ts_bm slhc rfcomm nf_reject_ipv4 nf_nat_masquerade_ipv4 nf
_nat_irc nf_nat_ftp nf_nat nf_log_ipv4 nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrac
k_rtcache nf_conntrack_irc nf_conntrack_ftp iptable_raw iptable_mangle iptable_f
ilter ipt_ECN ip_tables hidp hci_uart crc_ccitt compat btusb bnep bluetooth act_
connmark nf_conntrack act_skbedit act_mirred em_u32 cls_u32 cls_tcindex cls_flow
 cls_route cls_fw sch_hfsc sch_ingress hid evdev input_core ledtrig_usbdev ip6t_
REJECT nf_reject_ipv6 nf_log_ipv6 nf_log_common ip6table_raw ip6table_mangle ip6
table_filter ip6_tables x_tables ifb ipv6 arc4 crypto_blkcipher usb_storage ehci
_platform ehci_hcd sd_mod scsi_mod gpio_button_hotplug ext4 jbd2 mbcache usbcore
 nls_base usb_common crc16 crypto_hash
[  221.360000] Process kworker/u3:0 (pid: 685, threadinfo=8316c000, task=8305dd1
0, tls=00000000)
[  221.360000] Stack : 0000000b 80359590 00000028 8305df0c 8305dd10 80066278 000
00000 00000000
          00030000 802b64b4 8305dd10 0000000b 0000000b 00000028 8305df0c 8036000
0
          00000000 00000000 00030000 80129114 803d48c0 00000038 00000014 0000003
2
          803d0000 801b1cb8 00000000 00000050 80319e80 8316d1b4 8316d2b8 8031896
4
          0000000b 00000028 8305df0c 80360000 00000000 00000000 00030000 80122df
c
          ...
[  221.360000] Call Trace:
[  221.360000] [<801b57ac>] kthread_data+0x4/0xc
[  221.360000] [<802c91b8>] wq_worker_sleeping+0x14/0xc0
[  221.360000] [<80066278>] __schedule+0x108/0x5b4
[  221.360000] [<80129114>] do_exit+0xfc/0x764
[  221.360000] [<80122dfc>] direct_finish_page+0x0/0x20
[  221.360000]
[  221.360000]
Code: 03e00008  27bd0040  8c8201d0 <03e00008> 8c42fff0  08041103  24840010  1080
0002  00000000
[  221.650000] ---[ end trace 8f75012237ecc097 ]---
[  221.660000] Fixing recursive fault but reboot is needed!
[  221.660000] CPU 0 Unable to handle kernel paging request at virtual address f
ffffff0, epc == 801b57ac, ra == 802c91b8
[  221.660000] Oops[#7]:
[  221.660000] CPU: 0 PID: 685 Comm: kworker/u3:0 Tainted: G      D        3.18.
11 #1
[  221.660000] task: 8305dd10 ti: 8316c000 task.ti: 8316c000
[  221.660000] $ 0   : 00000000 00000001 00000000 0f003f70
[  221.660000] $ 4   : 8305dd10 00000000 80359590 0f003f70
[  221.660000] $ 8   : 00000008 00000000 00000000 626f6f74
[  221.660000] $12   : 00000000 03bf0000 00000000 61756c74
[  221.660000] $16   : 00000000 0000000b 80359590 00000028
[  221.660000] $20   : 8305df0c 80360000 80359590 00000000
[  221.660000] $24   : 00000003 801176a0
[  221.660000] $28   : 8316c000 8316cee0 00030000 802c91b8
[  221.660000] Hi    : 00000033
[  221.660000] Lo    : 9bf72f00
[  221.660000] epc   : 801b57ac kthread_data+0x4/0xc
[  221.660000]     Tainted: G      D
[  221.660000] ra    : 802c91b8 wq_worker_sleeping+0x14/0xc0
[  221.660000] Status: 1000fc02 KERNEL EXL
[  221.660000] Cause : 80800008
[  221.660000] BadVA : fffffff0
[  221.660000] PrId  : 00019374 (MIPS 24Kc)
[  221.660000] Modules linked in: ath9k ath9k_common pppoe ppp_async iptable_nat
 ath9k_hw ath pppox ppp_generic nf_nat_ipv4 nf_conntrack_ipv6 nf_conntrack_ipv4
mac80211 ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_tcpmss xt_strin
g xt_statistic xt_state xt_recent xt_nat xt_multiport xt_mark xt_mac xt_limit xt
_length xt_id xt_hl xt_helper xt_ecn xt_dscp xt_conntrack xt_connmark xt_connlim
it xt_connbytes xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_HL xt_DSCP xt_CT xt_C
LASSIFY ts_kmp ts_fsm ts_bm slhc rfcomm nf_reject_ipv4 nf_nat_masquerade_ipv4 nf
_nat_irc nf_nat_ftp nf_nat nf_log_ipv4 nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrac
k_rtcache nf_conntrack_irc nf_conntrack_ftp iptable_raw iptable_mangle iptable_f
ilter ipt_ECN ip_tables hidp hci_uart crc_ccitt compat btusb bnep bluetooth act_
connmark nf_conntrack act_skbedit act_mirred em_u32 cls_u32 cls_tcindex cls_flow
 cls_route cls_fw sch_hfsc sch_ingress hid evdev input_core ledtrig_usbdev ip6t_
REJECT nf_reject_ipv6 nf_log_ipv6 nf_log_common ip6table_raw ip6table_mangle ip6
table_filter ip6_tables x_tables ifb ipv6 arc4 crypto_blkcipher usb_storage ehci
_platform ehci_hcd sd_mod scsi_mod gpio_button_hotplug ext4 jbd2 mbcache usbcore
 nls_base usb_common crc16 crypto_hash
[  221.660000] Process kworker/u3:0 (pid: 685, threadinfo=8316c000, task=8305dd1
0, tls=00000000)
[  221.660000] Stack : 0000000b 80359590 00000028 8305df0c 8305dd10 80066278 000
00000 00000000
          00030000 802b64b4 8305dd10 0000000b 0000000b 00000028 8305df0c 8036000
0
          00000000 00000000 00030000 80129114 803d48c0 00000038 00000014 0000003
2
          803d0000 801b1cb8 00000000 00000050 80319e80 8316cf6c 8316d070 8031896
4
          0000000b 00000028 8305df0c 80360000 00000000 00000000 00030000 80122df
c
          ...
[  221.660000] Call Trace:
[  221.660000] [<801b57ac>] kthread_data+0x4/0xc
[  221.660000] [<802c91b8>] wq_worker_sleeping+0x14/0xc0
[  221.660000] [<80066278>] __schedule+0x108/0x5b4
[  221.660000] [<80129114>] do_exit+0xfc/0x764
[  221.660000] [<80122dfc>] direct_finish_page+0x0/0x20
[  221.660000]
[  221.660000]
Code: 03e00008  27bd0040  8c8201d0 <03e00008> 8c42fff0  08041103  24840010  1080
0002  00000000
[  221.950000] ---[ end trace 8f75012237ecc098 ]---
[  221.960000] Fixing recursive fault but reboot is needed!
[  221.970000] CPU 0 Unable to handle kernel paging request at virtual address f
ffffff0, epc == 801b57ac, ra == 802c91b8
[  221.970000] Oops[#8]:
[  221.970000] CPU: 0 PID: 685 Comm: kworker/u3:0 Tainted: G      D        3.18.
11 #1
[  221.970000] task: 8305dd10 ti: 8316c000 task.ti: 8316c000
[  221.970000] $ 0   : 00000000 00000001 00000000 0f003f70
[  221.970000] $ 4   : 8305dd10 00000000 80359590 0f003f70
[  221.970000] $ 8   : 00000008 00000000 00000000 626f6f74
[  221.970000] $12   : 00000000 03bf0000 00000000 61756c74
[  221.970000] $16   : 00000000 0000000b 80359590 00000028
[  221.970000] $20   : 8305df0c 80360000 80359590 00000000
[  221.970000] $24   : 00000003 801176a0
[  221.970000] $28   : 8316c000 8316cc98 00030000 802c91b8
[  221.970000] Hi    : 00000033
[  221.970000] Lo    : ae716880
[  221.970000] epc   : 801b57ac kthread_data+0x4/0xc
[  221.970000]     Tainted: G      D
[  221.970000] ra    : 802c91b8 wq_worker_sleeping+0x14/0xc0
[  221.970000] Status: 1000fc02 KERNEL EXL
[  221.970000] Cause : 80800008
[  221.970000] BadVA : fffffff0
[  221.970000] PrId  : 00019374 (MIPS 24Kc)
[  221.970000] Modules linked in: ath9k ath9k_common pppoe ppp_async iptable_nat
 ath9k_hw ath pppox ppp_generic nf_nat_ipv4 nf_conntrack_ipv6 nf_conntrack_ipv4
mac80211 ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_tcpmss xt_strin
g xt_statistic xt_state xt_recent xt_nat xt_multiport xt_mark xt_mac xt_limit xt
_length xt_id xt_hl xt_helper xt_ecn xt_dscp xt_conntrack xt_connmark xt_connlim
it xt_connbytes xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_HL xt_DSCP xt_CT xt_C
LASSIFY ts_kmp ts_fsm ts_bm slhc rfcomm nf_reject_ipv4 nf_nat_masquerade_ipv4 nf
_nat_irc nf_nat_ftp nf_nat nf_log_ipv4 nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrac
k_rtcache nf_conntrack_irc nf_conntrack_ftp iptable_raw iptable_mangle iptable_f
ilter ipt_ECN ip_tables hidp hci_uart crc_ccitt compat btusb bnep bluetooth act_
connmark nf_conntrack act_skbedit act_mirred em_u32 cls_u32 cls_tcindex cls_flow
 cls_route cls_fw sch_hfsc sch_ingress hid evdev input_core ledtrig_usbdev ip6t_
REJECT nf_reject_ipv6 nf_log_ipv6 nf_log_common ip6table_raw ip6table_mangle ip6
table_filter ip6_tables x_tables ifb ipv6 arc4 crypto_blkcipher usb_storage ehci
_platform ehci_hcd sd_mod scsi_mod gpio_button_hotplug ext4 jbd2 mbcache usbcore
 nls_base usb_common crc16 crypto_hash
[  221.970000] Process kworker/u3:0 (pid: 685, threadinfo=8316c000, task=8305dd1
0, tls=00000000)
[  221.970000] Stack : 0000000b 80359590 00000028 8305df0c 8305dd10 80066278 000
00000 00000000
          00030000 802b64b4 8305dd10 0000000b 0000000b 00000028 8305df0c 8036000
0
          00000000 00000000 00030000 80129114 803d48c0 00000038 00000014 0000003
2
          803d0000 801b1cb8 00000000 00000050 80319e80 8316cd24 8316ce28 8031896
4
          0000000b 00000028 8305df0c 80360000 00000000 00000000 00030000 80122df
c
          ...
[  221.970000] Call Trace:
[  221.970000] [<801b57ac>] kthread_data+0x4/0xc
[  221.970000] [<802c91b8>] wq_worker_sleeping+0x14/0xc0
[  221.970000] [<80066278>] __schedule+0x108/0x5b4
[  221.970000] [<80129114>] do_exit+0xfc/0x764
[  221.970000] [<80122dfc>] direct_finish_page+0x0/0x20
[  221.970000]
[  221.970000]
Code: 03e00008  27bd0040  8c8201d0 <03e00008> 8c42fff0  08041103  24840010  1080
0002  00000000
[  222.260000] ---[ end trace 8f75012237ecc099 ]---
[  222.270000] Fixing recursive fault but reboot is needed!
[  222.270000] CPU 0 Unable to handle kernel paging request at virtual address f
ffffff0, epc == 801b57ac, ra == 802c91b8
[  222.270000] Oops[#9]:
[  222.270000] CPU: 0 PID: 685 Comm: kworker/u3:0 Tainted: G      D        3.18.
11 #1
...



-----Original Message-----
From: Peter Hurley [mailto:peter@hurleysoftware.com] 
Sent: Tuesday, April 07, 2015 11:22 AM
To: Will Tucker; linux-bluetooth
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux version 3.18.10 Bluez ver 5.28 security level crashing system

[ +linux-bluetooth]

On 04/07/2015 12:27 PM, Will Tucker wrote:
> Hi
> Trying to get Bluez 5.28  pairing to work on openwrt. Using Linux 
> version 3.18.10.
> 
> I would use Bluez 5.30 but I read a post that stated it needed Linux 
> 3.19 and that may be long tedious job to update openwrt. Below is the 
> sequence and result of trying to set the security level using 
> bluetoothctl interactively.
> 
> eth0: 00:03:7f:ff:ff:ff
> eth0 up
> : cfg1 0xf cfg2 0x7214
> eth1: 00:03:7f:ff:ff:fe
> athrs26_reg_init_lan
> ATHRS26: resetting s26
> ATHRS26: s26 reset done
> eth1 up
> eth0, eth1
> Hit any key to stop autoboot:  0
> ## Booting image at 9f080000 ...
>    Image Name:   MIPS OpenWrt Linux-3.18.10
>    Created:      2015-04-07  13:03:05 UTC
>    Image Type:   MIPS Linux Kernel Image (lzma compressed)
>    Data Size:    1151316 Bytes =  1.1 MB
>    Load Address: 80060000
>    Entry Point:  80060000
>    Verifying Checksum at 0x9f080040 ...OK
>    Uncompressing Kernel Image ... OK
> No initrd
> ## Transferring control to Linux (at address 80060000) ...
> ## Giving linux memsize in bytes, 67108864
> 
> Starting kernel ...
> 
> [    0.000000] Linux version 3.18.10 (guest@WILLS-LINUX-BOX) (gcc version
> 4.8.3
> (OpenWrt/Linaro GCC 4.8-2014.04 r44873) ) #7 Tue Apr 7 07:02:38 MDT 2015
> [    0.000000] bootconsole [early0] enabled
> [    0.000000] CPU0 revision is: 00019374 (MIPS 24Kc)
> [    0.000000] SoC: Atheros AR9330 rev 1
> [    0.000000] Determined physical RAM map:
> [    0.000000]  memory: 04000000 @ 00000000 (usable)
> [    0.000000] Initrd not found or empty - disabling initrd
> [    0.000000] Zone ranges:
> [    0.000000]   Normal   [mem 0x00000000-0x03ffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x00000000-0x03ffffff]
> [    0.000000] Initmem setup node 0 [mem 0x00000000-0x03ffffff]
> [    0.000000] Primary instruction cache 64kB, VIPT, 4-way, linesize 32
> bytes.
> [    0.000000] Primary data cache 32kB, 4-way, VIPT, cache aliases, linesize
> 32
> bytes
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total
> pag
> es: 16256
> [    0.000000] Kernel command line:  board=DIR-505-A1 console=ttyATH0,115200
> mtd
> parts=spi0.0:64k(u-boot)ro,64k(art)ro,64k(mac)ro,64k(nvram)ro,256k(lan
> guage)
> ro,7
> 680k@0x80000(firmware) rootfstype=squashfs,jffs2 noinitrd
> [    0.000000] PID hash table entries: 256 (order: -2, 1024 bytes)
> [    0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> [    0.000000] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> [    0.000000] Writing ErrCtl register=00000000
> [    0.000000] Readback ErrCtl register=00000000
> [    0.000000] Memory: 60944K/65536K available (2485K kernel code, 125K
> rwdata,
> 528K rodata, 244K init, 188K bss, 4592K reserved)
> [    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> [    0.000000] NR_IRQS:51
> [    0.000000] Clocks: CPU:400.000MHz, DDR:400.000MHz, AHB:200.000MHz,
> Ref:25.00
> 0MHz
> [    0.000000] Calibrating delay loop... 265.42 BogoMIPS (lpj=1327104)
> [    0.080000] pid_max: default: 32768 minimum: 301
> [    0.080000] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
> [    0.090000] Mountpoint-cache hash table entries: 1024 (order: 0, 4096
> bytes)
> [    0.100000] NET: Registered protocol family 16
> [    0.100000] MIPS: machine is D-Link DIR-505 rev. A1
> [    0.610000] Switched to clocksource MIPS
> [    0.610000] NET: Registered protocol family 2
> [    0.620000] TCP established hash table entries: 1024 (order: 0, 4096
> bytes)
> [    0.620000] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
> [    0.620000] TCP: Hash tables configured (established 1024 bind 1024)
> [    0.630000] TCP: reno registered
> [    0.630000] UDP hash table entries: 256 (order: 0, 4096 bytes)
> [    0.640000] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
> [    0.650000] NET: Registered protocol family 1
> [    0.650000] futex hash table entries: 256 (order: -1, 3072 bytes)
> [    0.670000] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [    0.670000] jffs2: version 2.2 (NAND) (SUMMARY) (LZMA) (RTIME)
> (CMODE_PRIORIT
> Y) (c) 2001-2006 Red Hat, Inc.
> [    0.680000] msgmni has been set to 119
> [    0.680000] io scheduler noop registered
> [    0.690000] io scheduler deadline registered (default)
> [    0.690000] Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
> [    0.700000] ar933x-uart: ttyATH0 at MMIO 0x18020000 (irq = 11, base_baud
> = 15
> 62500) is a AR933X UART
> [    0.710000] console [ttyATH0] enabled
> [    0.710000] console [ttyATH0] enabled
> [    0.710000] bootconsole [early0] disabled
> [    0.710000] bootconsole [early0] disabled
> [    0.720000] m25p80 spi0.0: found mx25l6405d, expected m25p80
> [    0.730000] m25p80 spi0.0: mx25l6405d (8192 Kbytes)
> [    0.730000] 6 cmdlinepart partitions found on MTD device spi0.0
> [    0.740000] Creating 6 MTD partitions on "spi0.0":
> [    0.740000] 0x000000000000-0x000000010000 : "u-boot"
> [    0.750000] 0x000000010000-0x000000020000 : "art"
> [    0.760000] 0x000000020000-0x000000030000 : "mac"
> [    0.760000] 0x000000030000-0x000000040000 : "nvram"
> [    0.760000] 0x000000040000-0x000000080000 : "language"
> [    0.770000] 0x000000080000-0x000000800000 : "firmware"
> [    0.810000] 2 uimage-fw partitions found on MTD device firmware
> [    0.810000] 0x000000080000-0x000000199194 : "kernel"
> [    0.820000] mtd: partition "kernel" must either start or end on erase
> block b
> oundary or be smaller than an erase block -- forcing read-only
> [    0.830000] 0x000000199194-0x000000800000 : "rootfs"
> [    0.840000] mtd: partition "rootfs" must either start or end on erase
> block b
> oundary or be smaller than an erase block -- forcing read-only
> [    0.850000] mtd: device 7 (rootfs) set to be root filesystem
> [    0.860000] 1 squashfs-split partitions found on MTD device rootfs
> [    0.860000] 0x000000610000-0x000000800000 : "rootfs_data"
> [    0.880000] libphy: ag71xx_mdio: probed
> [    1.480000] ag71xx-mdio.1: Found an AR7240/AR9330 built-in switch
> [    1.510000] eth0: Atheros AG71xx at 0xba000000, irq 5, mode:GMII
> [    2.100000] ag71xx ag71xx.0: connected to PHY at ag71xx-mdio.1:04
> [uid=004dd0
> 41, driver=Generic PHY]
> [    2.110000] eth1: Atheros AG71xx at 0xb9000000, irq 4, mode:MII
> [    2.110000] TCP: cubic registered
> [    2.110000] NET: Registered protocol family 17
> [    2.120000] bridge: automatic filtering via arp/ip/ip6tables has been
> depreca
> ted. Update your scripts to load br_netfilter if you need this.
> [    2.130000] 8021q: 802.1Q VLAN Support v1.8
> [    2.150000] VFS: Mounted root (squashfs filesystem) readonly on device
> 31:7.
> [    2.150000] Freeing unused kernel memory: 244K (80373000 - 803b0000)
> [    3.540000] init: failed to symlink /tmp -> /var
> [    3.550000] init: Console is alive
> [    3.550000] init: - watchdog -
> [    5.960000] usbcore: registered new interface driver usbfs
> [    5.960000] usbcore: registered new interface driver hub
> [    5.970000] usbcore: registered new device driver usb
> [    6.020000] SCSI subsystem initialized
> [    6.030000] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    6.040000] ehci-platform: EHCI generic platform driver
> [    6.040000] ehci-platform ehci-platform: EHCI Host Controller
> [    6.050000] ehci-platform ehci-platform: new USB bus registered, assigned
> bus
> number 1
> [    6.060000] ehci-platform ehci-platform: irq 3, io mem 0x1b000000
> [    6.080000] ehci-platform ehci-platform: USB 2.0 started, EHCI 1.00
> [    6.080000] hub 1-0:1.0: USB hub found
> [    6.080000] hub 1-0:1.0: 1 port detected
> [    6.090000] usbcore: registered new interface driver usb-storage
> [    6.410000] usb 1-1: new full-speed USB device number 2 using
> ehci-platform
> [    6.600000] init: - preinit -
> [    7.290000] random: procd urandom read with 12 bits of entropy available
> Press the [f] key and hit [enter] to enter failsafe mode Press the 
> [1], [2], [3] or [4] key and hit [enter] to select the debug level
> [   10.660000] mount_root: loading kmods from internal overlay
> [   11.060000] jffs2: notice: (353) jffs2_build_xattr_subsystem: complete
> buildi
> ng xattr subsystem, 1 of xdatum (1 unchecked, 0 orphan) and 1 of xref 
> (0 dead, 0
> orphan) found.
> [   11.070000] block: attempting to load
> /tmp/jffs_cfg/upper/etc/config/fstab
> [   11.080000] block: extroot: not configured
> [   11.120000] jffs2: notice: (350) jffs2_build_xattr_subsystem: complete
> buildi
> ng xattr subsystem, 1 of xdatum (1 unchecked, 0 orphan) and 1 of xref 
> (0 dead, 0
> orphan) found.
> [   11.270000] eth1: link up (100Mbps/Full duplex)
> [   11.370000] block: attempting to load
> /tmp/jffs_cfg/upper/etc/config/fstab
> [   11.380000] block: extroot: not configured
> [   11.380000] mount_root: switching to jffs2 overlay
> [   11.430000] eth1: link down
> [   11.450000] procd: - early -
> [   11.450000] procd: - watchdog -
> [   12.360000] procd: - ubus -
> [   13.370000] procd: - init -
> Please press Enter to activate this console.
> [   14.980000] NET: Registered protocol family 10
> [   15.000000] ip6_tables: (C) 2000-2006 Netfilter Core Team
> [   15.050000] hidraw: raw HID events driver (C) Jiri Kosina
> [   15.070000] u32 classifier
> [   15.070000]     input device check on
> [   15.070000]     Actions configured
> [   15.080000] Mirror/redirect action on
> [   15.090000] nf_conntrack version 0.5.0 (956 buckets, 3824 max)
> [   15.200000] Bluetooth: Core ver 2.19
> [   15.210000] NET: Registered protocol family 31
> [   15.210000] Bluetooth: HCI device and connection manager initialized
> [   15.220000] Bluetooth: HCI socket layer initialized
> [   15.220000] Bluetooth: L2CAP socket layer initialized
> [   15.230000] Bluetooth: SCO socket layer initialized
> [   15.240000] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [   15.240000] Bluetooth: BNEP filters: protocol multicast
> [   15.250000] Bluetooth: BNEP socket layer initialized
> [   15.260000] usbcore: registered new interface driver btusb
> [   15.260000] Loading modules backported from Linux version
> master-2015-03-09-0
> -g141f155
> [   15.270000] Backport generated by backports.git
> backports-20150129-0-gdd4a670
> 
> [   15.280000] bluetooth hci0: Direct firmware load for
> brcm/BCM20702A0-0a5c-21e
> 8.hcd failed with error -2
> [   15.280000] bluetooth hci0: Falling back to user helper
> [   15.300000] Bluetooth: HCI UART driver ver 2.2
> [   15.300000] Bluetooth: HCI H4 protocol initialized
> [   15.310000] Bluetooth: HCI BCSP protocol initialized
> [   15.330000] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> [   15.330000] Bluetooth: HIDP socket layer initialized
> [   15.340000] ip_tables: (C) 2000-2006 Netfilter Core Team
> [   15.430000] Bluetooth: RFCOMM TTY layer initialized
> [   15.440000] Bluetooth: RFCOMM socket layer initialized
> [   15.440000] Bluetooth: RFCOMM ver 1.11
> [   15.540000] xt_time: kernel timezone is -0000
> [   15.600000] cfg80211: Calling CRDA to update world regulatory domain
> [   15.620000] cfg80211: World regulatory domain updated:
> [   15.620000] cfg80211:  DFS Master region: unset
> [   15.620000] cfg80211:   (start_freq - end_freq @ bandwidth),
> (max_antenna_gai
> n, max_eirp), (dfs_cac_time)
> [   15.630000] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (N/A,
> 2000 m
> Bm), (N/A)
> [   15.640000] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz), (N/A,
> 2000 m
> Bm), (N/A)
> [   15.650000] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (N/A,
> 2000 m
> Bm), (N/A)
> [   15.660000] cfg80211:   (5170000 KHz - 5250000 KHz @ 80000 KHz), (N/A,
> 2000 m
> Bm), (N/A)
> [   15.670000] cfg80211:   (5250000 KHz - 5330000 KHz @ 80000 KHz, 160000
> KHz AU
> TO), (N/A, 2000 mBm), (0 s)
> [   15.680000] cfg80211:   (5490000 KHz - 5730000 KHz @ 160000 KHz), (N/A,
> 2000
> mBm), (0 s)
> [   15.680000] cfg80211:   (5735000 KHz - 5835000 KHz @ 80000 KHz), (N/A,
> 2000 m
> Bm), (N/A)
> [   15.690000] cfg80211:   (57240000 KHz - 63720000 KHz @ 2160000 KHz),
> (N/A, 0
> mBm), (N/A)
> [   15.800000] PPP generic driver version 2.4.2
> [   15.810000] NET: Registered protocol family 24
> [   15.870000] firmware brcm!BCM20702A0-0a5c-21e8.hcd:
> firmware_loading_store: m
> ap pages failed
> [   15.880000] Bluetooth: hci0: BCM: patch brcm/BCM20702A0-0a5c-21e8.hcd not
> fou
> nd
> [   15.940000] ieee80211 phy0: Atheros AR9330 Rev:1 mem=0xb8100000, irq=2
> [   15.950000] cfg80211: Calling CRDA for country: US
> [   15.950000] cfg80211: Regulatory domain changed to country: US
> [   15.960000] cfg80211:  DFS Master region: FCC
> [   15.960000] cfg80211:   (start_freq - end_freq @ bandwidth),
> (max_antenna_gai
> n, max_eirp), (dfs_cac_time)
> [   15.970000] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (N/A,
> 3000 m
> Bm), (N/A)
> [   15.980000] cfg80211:   (5170000 KHz - 5250000 KHz @ 80000 KHz, 160000
> KHz AU
> TO), (N/A, 1700 mBm), (N/A)
> [   15.990000] cfg80211:   (5250000 KHz - 5330000 KHz @ 80000 KHz, 160000
> KHz AU
> TO), (N/A, 2300 mBm), (0 s)
> [   16.000000] cfg80211:   (5735000 KHz - 5835000 KHz @ 80000 KHz), (N/A,
> 3000 m
> Bm), (N/A)
> [   16.010000] cfg80211:   (57240000 KHz - 63720000 KHz @ 2160000 KHz),
> (N/A, 40
> 00 mBm), (N/A)
> [   16.060000] Bluetooth: Unable to create crypto context
> 
> 
> 
> BusyBox v1.23.2 (2015-04-06 07:12:41 MDT) built-in shell (ash)
> 
>   _______                     ________        __
> |       |.-----.-----.-----.|  |  |  |.----.|  |_
> |   -   ||  _  |  -__|     ||  |  |  ||   _||   _|
> |_______||   __|_____|__|__||________||__|  |____|
>           |__| W I R E L E S S   F R E E D O M
> -----------------------------------------------------
> CHAOS CALMER (Bleeding Edge, r45288)
> -----------------------------------------------------
>   * 1 1/2 oz Gin            Shake with a glassful
>   * 1/4 oz Triple Sec       of broken ice and pour
>   * 3/4 oz Lime Juice       unstrained into a goblet.
>   * 1 1/2 oz Orange Juice
>   * 1 tsp. Grenadine Syrup
> -----------------------------------------------------
> root@OpenWrt:/#
> root@OpenWrt:/#
> root@OpenWrt:/#
> root@OpenWrt:/# [   27.080000] device eth1 entered promiscuous mode
> [   27.080000] IPv6: ADDRCONF(NETDEV_UP): br-lan: link is not ready
> 
> root@OpenWrt:/# [   29.870000] eth1: link up (100Mbps/Full duplex)
> [   29.870000] br-lan: port 1(eth1) entered forwarding state
> [   29.880000] br-lan: port 1(eth1) entered forwarding state
> [   29.880000] IPv6: ADDRCONF(NETDEV_CHANGE): br-lan: link becomes ready
> [   31.880000] br-lan: port 1(eth1) entered forwarding state
> 
> 
> root@OpenWrt:/# hciconfig hci0 up
> root@OpenWrt:/# hciconfig
> hci0:   Type: BR/EDR  Bus: USB
>         BD Address: 00:19:0E:12:46:8A  ACL MTU: 1021:8  SCO MTU: 64:1
>         UP RUNNING
>         RX bytes:1158 acl:0 sco:0 events:63 errors:0
>         TX bytes:1046 acl:0 sco:0 commands:63 errors:0
> 
> 
> root@OpenWrt:/# gatttool --adapter=hci0 -I
> [                 ][LE]> connect EC:FE:7E:10:95:1F
> Attempting to connect to EC:FE:7E:10:95:1F Connection successful 
> [EC:FE:7E:10:95:1F][LE]> sec-level medium [  334.770000] CPU 0 Unable 
> to handle kernel paging request at virtual address 0 0000200, epc == 
> 80067e20, ra == 83231668 [  334.770000] Oops[#1]:
> [  334.770000] CPU: 0 PID: 1553 Comm: gatttool Not tainted 3.18.10 #7 
> [  334.770000] task: 82a43548 ti: 829a8000 task.ti: 829a8000
> [  334.770000] $ 0   : 00000000 7ffaed06 00000000 00000000
> [  334.770000] $ 4   : 00000200 830bcc0c 00000000 00000000
> [  334.770000] $ 8   : 00000000 00000000 00000001 00000057
> [  334.770000] $12   : 7ffaecd0 00000002 00000000 00000000
> [  334.770000] $16   : 830bcc00 829d1700 00000000 00000002
> [  334.770000] $20   : 00000200 006afb50 77209118 00000000
> [  334.770000] $24   : 00000000 7709ca40
> [  334.770000] $28   : 829a8000 829a9e88 00000000 83231668
> [  334.770000] Hi    : 00000020
> [  334.770000] Lo    : 00000033
> [  334.770000] epc   : 80067e20 mutex_lock+0x0/0x30
> [  334.770000]     Not tainted
> [  334.770000] ra    : 83231668 smp_conn_security+0x88/0x200 [bluetooth]
> [  334.770000] Status: 1000fc03 KERNEL EXL IE [  334.770000] Cause : 
> 00800008 [  334.770000] BadVA : 00000200 [  334.770000] PrId  : 
> 00019374 (MIPS 24Kc) [  334.770000] Modules linked in: ath9k 
> ath9k_common pppoe ppp_async iptable_nat ath9k_hw ath pppox 
> ppp_generic nf_nat_ipv4 nf_conntrack_ipv6
> nf_conntrack_ipv4
> mac80211 ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp 
> xt_tcpmss xt_strin g xt_statistic xt_state xt_recent xt_nat 
> xt_multiport xt_mark xt_mac xt_limit xt _length xt_id xt_hl xt_helper 
> xt_ecn xt_dscp xt_conntrack xt_connmark xt_connlim it xt_connbytes 
> xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_HL xt_DSCP xt_CT xt_C 
> LASSIFY ts_kmp ts_fsm ts_bm slhc rfcomm nf_reject_ipv4
> nf_nat_masquerade_ipv4 nf
> _nat_irc nf_nat_ftp nf_nat nf_log_ipv4 nf_defrag_ipv6 nf_defrag_ipv4 
> nf_conntrac k_rtcache nf_conntrack_irc nf_conntrack_ftp iptable_raw 
> iptable_mangle iptable_f ilter ipt_ECN ip_tables hidp hci_uart 
> crc_ccitt compat btusb bnep bluetooth act_ connmark nf_conntrack 
> act_skbedit act_mirred em_u32 cls_u32 cls_tcindex cls_flow cls_route 
> cls_fw sch_hfsc sch_ingress hid evdev input_core ledtrig_usbdev ip6t_ 
> REJECT nf_reject_ipv6 nf_log_ipv6 nf_log_common ip6table_raw 
> ip6table_mangle
> ip6
> table_filter ip6_tables x_tables ifb ipv6 arc4 crypto_blkcipher 
> usb_storage ehci _platform ehci_hcd sd_mod scsi_mod 
> gpio_button_hotplug ext4 jbd2 mbcache usbcore nls_base usb_common 
> crc16 crypto_hash [  334.770000] Process gatttool (pid: 1553, 
> threadinfo=829a8000, task=82a43548,
> tls=772c4750)
> [  334.770000] Stack : 829a9f00 80134464 0000540f 00000000 7ffaedb8 
> 801381f4
> 829
> 9d400 7ffaed04
>           82ade200 ffffffea 83237b50 8322e274 77209118 7ffaee20 
> 829a9ee8 006af8a
> 8
>           02000000 80269348 00000004 800796d4 83550b00 00000002 
> 7ffaed04
> 0000000
> 4
>           00000112 8007c714 00000000 00000000 00000000 00000000 
> 00000002
> 0000000
> 0
>           00000000 00000000 00000005 00000002 006af8a8 77294b70 
> 00000000
> 80062b5
> c
>           ...
> [  334.770000] Call Trace:
> [  334.770000] [<80067e20>] mutex_lock+0x0/0x30 [  334.770000] 
> [<83231668>] smp_conn_security+0x88/0x200 [bluetooth] [  334.770000] 
> [<8322e274>] l2cap_is_socket+0x1514/0x242c [bluetooth] [  334.770000] 
> [  334.770000]
> Code: 8fb00024  03e00008  27bd0040 <c0820000> 2443ffff  e0830000  
> 1060fffc
> 0000
> 0000  2442ffff
> [  335.050000] ---[ end trace fe8f2f0ed758dfcc ]---
> 
> Will Tucker
> BlueRadios, Inc.
> 8310 South Valley Highway, Suite 275
> Englewood, Colorado 80112
> USA
> wtucker@BlueRadios.com
> www.BlueRadios.com


