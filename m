Return-Path: <cyrus@holtmann.org>
Message-ID: <55241236.8060501@hurleysoftware.com>
Date: Tue, 07 Apr 2015 13:21:58 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Will Tucker <wtucker@blueradios.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux version 3.18.10 Bluez ver 5.28 security level crashing
 system
References: <003001d0714f$b67cc650$237652f0$@blueradios.com>
In-Reply-To: <003001d0714f$b67cc650$237652f0$@blueradios.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

[ +linux-bluetooth]

On 04/07/2015 12:27 PM, Will Tucker wrote:
> Hi 
> Trying to get Bluez 5.28  pairing to work on openwrt. Using Linux version
> 3.18.10.
> 
> I would use Bluez 5.30 but I read a post that stated it needed Linux 3.19
> and that may be long tedious job to update openwrt. Below is the sequence
> and result of trying to set the security level using bluetoothctl
> interactively.
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
> parts=spi0.0:64k(u-boot)ro,64k(art)ro,64k(mac)ro,64k(nvram)ro,256k(language)
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
> Press the [f] key and hit [enter] to enter failsafe mode
> Press the [1], [2], [3] or [4] key and hit [enter] to select the debug level
> [   10.660000] mount_root: loading kmods from internal overlay
> [   11.060000] jffs2: notice: (353) jffs2_build_xattr_subsystem: complete
> buildi
> ng xattr subsystem, 1 of xdatum (1 unchecked, 0 orphan) and 1 of xref (0
> dead, 0
> orphan) found.
> [   11.070000] block: attempting to load
> /tmp/jffs_cfg/upper/etc/config/fstab
> [   11.080000] block: extroot: not configured
> [   11.120000] jffs2: notice: (350) jffs2_build_xattr_subsystem: complete
> buildi
> ng xattr subsystem, 1 of xdatum (1 unchecked, 0 orphan) and 1 of xref (0
> dead, 0
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
> Attempting to connect to EC:FE:7E:10:95:1F
> Connection successful
> [EC:FE:7E:10:95:1F][LE]> sec-level medium
> [  334.770000] CPU 0 Unable to handle kernel paging request at virtual
> address 0
> 0000200, epc == 80067e20, ra == 83231668
> [  334.770000] Oops[#1]:
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
> [  334.770000] Status: 1000fc03 KERNEL EXL IE
> [  334.770000] Cause : 00800008
> [  334.770000] BadVA : 00000200
> [  334.770000] PrId  : 00019374 (MIPS 24Kc)
> [  334.770000] Modules linked in: ath9k ath9k_common pppoe ppp_async
> iptable_nat
> ath9k_hw ath pppox ppp_generic nf_nat_ipv4 nf_conntrack_ipv6
> nf_conntrack_ipv4
> mac80211 ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_tcpmss
> xt_strin
> g xt_statistic xt_state xt_recent xt_nat xt_multiport xt_mark xt_mac
> xt_limit xt
> _length xt_id xt_hl xt_helper xt_ecn xt_dscp xt_conntrack xt_connmark
> xt_connlim
> it xt_connbytes xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_HL xt_DSCP xt_CT
> xt_C
> LASSIFY ts_kmp ts_fsm ts_bm slhc rfcomm nf_reject_ipv4
> nf_nat_masquerade_ipv4 nf
> _nat_irc nf_nat_ftp nf_nat nf_log_ipv4 nf_defrag_ipv6 nf_defrag_ipv4
> nf_conntrac
> k_rtcache nf_conntrack_irc nf_conntrack_ftp iptable_raw iptable_mangle
> iptable_f
> ilter ipt_ECN ip_tables hidp hci_uart crc_ccitt compat btusb bnep bluetooth
> act_
> connmark nf_conntrack act_skbedit act_mirred em_u32 cls_u32 cls_tcindex
> cls_flow
> cls_route cls_fw sch_hfsc sch_ingress hid evdev input_core ledtrig_usbdev
> ip6t_
> REJECT nf_reject_ipv6 nf_log_ipv6 nf_log_common ip6table_raw ip6table_mangle
> ip6
> table_filter ip6_tables x_tables ifb ipv6 arc4 crypto_blkcipher usb_storage
> ehci
> _platform ehci_hcd sd_mod scsi_mod gpio_button_hotplug ext4 jbd2 mbcache
> usbcore
> nls_base usb_common crc16 crypto_hash
> [  334.770000] Process gatttool (pid: 1553, threadinfo=829a8000,
> task=82a43548,
> tls=772c4750)
> [  334.770000] Stack : 829a9f00 80134464 0000540f 00000000 7ffaedb8 801381f4
> 829
> 9d400 7ffaed04
>           82ade200 ffffffea 83237b50 8322e274 77209118 7ffaee20 829a9ee8
> 006af8a
> 8
>           02000000 80269348 00000004 800796d4 83550b00 00000002 7ffaed04
> 0000000
> 4
>           00000112 8007c714 00000000 00000000 00000000 00000000 00000002
> 0000000
> 0
>           00000000 00000000 00000005 00000002 006af8a8 77294b70 00000000
> 80062b5
> c
>           ...
> [  334.770000] Call Trace:
> [  334.770000] [<80067e20>] mutex_lock+0x0/0x30
> [  334.770000] [<83231668>] smp_conn_security+0x88/0x200 [bluetooth]
> [  334.770000] [<8322e274>] l2cap_is_socket+0x1514/0x242c [bluetooth]
> [  334.770000]
> [  334.770000]
> Code: 8fb00024  03e00008  27bd0040 <c0820000> 2443ffff  e0830000  1060fffc
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

