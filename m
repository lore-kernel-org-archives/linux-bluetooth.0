Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Gary Albelli <galbelli@optonline.net>
To: bluez-users@lists.sourceforge.net
Message-id: <424d2ebf06b455eb08bddc41b243fca9@optonline.net>
MIME-version: 1.0
Content-type: multipart/alternative;
 boundary="Boundary_(ID_MvfJJit7rjmluMRD9pJjHQ)"
Subject: [Bluez-users] Problem connecting to NAP via serial null modem connection
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 03 Apr 2005 12:21:22 -0400


--Boundary_(ID_MvfJJit7rjmluMRD9pJjHQ)
Content-type: text/plain; charset=US-ASCII; format=flowed
Content-transfer-encoding: 7BIT



Begin forwarded message:

> From: Gary Albelli <galbelli@optonline.net>
> Date: April 3, 2005 12:15:14 PM EDT
> To: Gary Albelli <galbelli@optonline.net>
> Cc: bluez-users@lists.sourceforge.net
> Subject: Problem connecting to NAP via serial null modem connection
>
> I have tried to connect from both by laptop and my Palm-pilot. Each 
> device generates the same log information on the Linux box(NAP).  I am 
> not sure where this is failing or what too do next. Any suggestions on 
> what I can check or do to diagnose the problem would be greatly 
> appreciated.
>
> I have included the dmesg output, log output generated from making the 
> connection, and my hcid.conf file.
>
> Thanks
> Gary
>
> ===================== tailed from /var/log/messages ==================
>
> Apr  3 11:53:46 darthvader pppd[14136]: pppd 2.4.2 started by root, 
> uid 0
> Apr  3 11:53:46 darthvader pppd[14136]: Serial connection established.
> Apr  3 11:53:46 darthvader pppd[14136]: Using interface ppp0
> Apr  3 11:53:46 darthvader pppd[14136]: Connect: ppp0 <--> /dev/rfcomm0
> Apr  3 11:53:46 darthvader dund[14122]: New connection from 
> 00:07:E0:34:9B:13
> Apr  3 11:53:51 darthvader pam_timestamp_check: pam_timestamp: `/' 
> owner UID != 0
>
>
>
>
> ====================== DMESG OUTPUT ==========================
>
> [root@darthvader ~]# dmesg
> Linux version 2.6.8-1.541 (bhcompile@porky.build.redhat.com) (gcc 
> version 3.4.1 20040831 (Red Hat 3.4.1-10)) #1 Wed Sep 1 18:01:20 EDT 
> 2004
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000003ff77000 (usable)
>  BIOS-e820: 000000003ff77000 - 000000003ff79000 (ACPI NVS)
>  BIOS-e820: 000000003ff79000 - 0000000040000000 (reserved)
>  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
>  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
> 0MB HIGHMEM available.
> 1023MB LOWMEM available.
> zapping low mappings.
> On node 0 totalpages: 262007
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 257911 pages, LIFO batch:16
>   HighMem zone: 0 pages, LIFO batch:1
> DMI 2.3 present.
> ACPI: RSDP (v000 DELL                                      ) @ 
> 0x000fd550
> ACPI: RSDT (v001 DELL    8200    0x00000008 ASL  0x00000061) @ 
> 0x000fd564
> ACPI: FADT (v001 DELL    8200    0x00000008 ASL  0x00000061) @ 
> 0x000fd598
> ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000d) @ 
> 0xfffe5d92
> ACPI: MADT (v001 DELL    8200    0x00000008 ASL  0x00000061) @ 
> 0x000fd60c
> ACPI: BOOT (v001 DELL    8200    0x00000008 ASL  0x00000061) @ 
> 0x000fd678
> ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000d) @ 
> 0x00000000
> ACPI: PM-Timer IO Port: 0x808
> Built 1 zonelists
> Kernel command line: ro root=LABEL=/
> mapped 4G/4G trampoline to ffff4000.
> Initializing CPU#0
> CPU 0 irqstacks, hard=023c6000 soft=023c5000
> PID hash table entries: 4096 (order 12: 32768 bytes)
> Detected 2254.557 MHz processor.
> Using tsc for high-res timesource
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
> Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
> Memory: 1033872k/1048028k available (2024k kernel code, 13476k 
> reserved, 631k data, 144k init, 0k highmem)
> Calibrating delay loop... 4440.06 BogoMIPS (lpj=2220032)
> Security Scaffold v1.0.0 initialized
> SELinux:  Initializing.
> SELinux:  Starting in permissive mode
> There is already a security framework initialized, register_security 
> failed.
> selinux_register_security:  Registering secondary module capability
> Capability LSM initialized as secondary
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> CPU: After generic identify, caps: 3febfbff 00000000 00000000 00000000
> CPU: After vendor identify, caps:  3febfbff 00000000 00000000 00000000
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: After all inits, caps:        3febf3ff 00000000 00000000 00000080
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
> CPU: Intel(R) Pentium(R) 4 CPU 2.26GHz stepping 04
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> ACPI: IRQ9 SCI: Level Trigger.
> checking if image is initramfs... it is
> Freeing initrd memory: 386k freed
> NET: Registered protocol family 16
> PCI: PCI BIOS revision 2.10 entry at 0xfbe9e, last bus=2
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> ACPI: Subsystem revision 20040715
> ACPI: Interpreter enabled
> ACPI: Using PIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (00:00)
> PCI: Probing PCI hardware (bus 00)
> get_random_bytes called before random driver initialization
> PCI: Transparent bridge - 0000:00:1e.0
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
> ACPI: PCI Interrupt Link [LNKA] (IRQs *3 4 5 6 7 9 10 11 12 15)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 15)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 15)
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, 
> disabled.
> ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, 
> disabled.
> ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, 
> disabled.
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 15)
> Linux Plug and Play Support v0.97 (c) Adam Belay
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> PCI: Using ACPI for IRQ routing
> ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
> ACPI: PCI interrupt 0000:00:1f.2[D] -> GSI 11 (level, low) -> IRQ 11
> ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
> ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 10 (level, low) -> IRQ 10
> ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 9
> ACPI: PCI interrupt 0000:00:1f.4[C] -> GSI 9 (level, low) -> IRQ 9
> ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 3
> ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 3 (level, low) -> IRQ 3
> ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 3 (level, low) -> IRQ 3
> ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 10 (level, low) -> IRQ 10
> ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
> ACPI: PCI interrupt 0000:02:09.0[A] -> GSI 11 (level, low) -> IRQ 11
> get_random_bytes called before random driver initialization
> vesafb: probe of vesafb0 failed with error -6
> Simple Boot Flag at 0x7a set to 0x1
> apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
> apm: overridden by ACPI.
> audit: initializing netlink socket (disabled)
> audit(1112475725.987:0): initialized
> Total HugeTLB memory allocated, 0
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> SELinux:  Registering netfilter hooks
> Initializing Cryptographic API
> ksign: Installing public key data
> Loading keyring
> - Added public key EB180CB126A51024
> - User ID: Red Hat, Inc. (Kernel Module GPG key)
> pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> ACPI: Processor [CPU0] (supports C1)
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> Real Time Clock Driver v1.12
> Linux agpgart interface v0.100 (c) Dave Jones
> agpgart: Detected an Intel i850 Chipset.
> agpgart: Maximum main memory to use for agp memory: 941M
> agpgart: AGP aperture is 128M @ 0xe8000000
> Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing 
> enabled
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
> divert: not allocating divert_blk for non-ethernet device lo
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with 
> idebus=xx
> ICH2: IDE controller at PCI slot 0000:00:1f.1
> ICH2: chipset revision 4
> ICH2: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
> Probing IDE interface ide0...
> hda: WDC WD800JB-00CRA1, ATA DISK drive
> Using cfq io scheduler
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> hdc: _NEC CD-RW NR-7900A, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> Probing IDE interface ide2...
> ide2: Wait for ready failed before probe !
> Probing IDE interface ide3...
> ide3: Wait for ready failed before probe !
> Probing IDE interface ide4...
> ide4: Wait for ready failed before probe !
> Probing IDE interface ide5...
> ide5: Wait for ready failed before probe !
> hda: max request size: 128KiB
> hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, 
> UDMA(100)
> hda: cache flushes not supported
>  hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 > hda3
> hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> ide-floppy driver 0.99.newide
> usbcore: registered new driver hiddev
> usbcore: registered new driver usbhid
> drivers/usb/input/hid-core.c: v2.0:USB HID core driver
> mice: PS/2 mouse device common for all mice
> serio: i8042 AUX port at 0x60,0x64 irq 12
> input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
> serio: i8042 KBD port at 0x60,0x64 irq 1
> input: AT Translated Set 2 keyboard on isa0060/serio0
> md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
> NET: Registered protocol family 2
> IP: routing cache hash table of 2048 buckets, 64Kbytes
> TCP: Hash tables configured (established 262144 bind 37449)
> Initializing IPsec netlink socket
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> ACPI: (supports S0 S1 S3 S4 S5)
> ACPI wakeup devices:
> VBTN PCI0 USB0 USB1 PCI1  KBD
> Freeing unused kernel memory: 144k freed
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> inserting floppy driver for 2.6.8-1.541
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> 8139too Fast Ethernet driver 0.9.27
> ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 3 (level, low) -> IRQ 3
> divert: allocating divert_blk for eth0
> eth0: RealTek RTL8139 at 0xec00, 00:c0:a8:80:fc:3e, IRQ 3
> eth0:  Identified 8139 chip type 'RTL-8139C'
> USB Universal Host Controller Interface driver v2.2
> ACPI: PCI interrupt 0000:00:1f.2[D] -> GSI 11 (level, low) -> IRQ 11
> uhci_hcd 0000:00:1f.2: UHCI Host Controller
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> uhci_hcd 0000:00:1f.2: irq 11, io base 0000ff80
> uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 2 ports detected
> ACPI: PCI interrupt 0000:00:1f.4[C] -> GSI 9 (level, low) -> IRQ 9
> uhci_hcd 0000:00:1f.4: UHCI Host Controller
> PCI: Setting latency timer of device 0000:00:1f.4 to 64
> uhci_hcd 0000:00:1f.4: irq 9, io base 0000ff60
> uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 2 ports detected
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> usb 2-2: new full speed USB device using address 2
> Bluetooth: Core ver 2.6
> NET: Registered protocol family 31
> Bluetooth: HCI device and connection manager initialized
> Bluetooth: HCI socket layer initialized
> Bluetooth: HCI USB driver ver 2.7
> usbcore: registered new driver hci_usb
> ACPI: Power Button (FF) [PWRF]
> EXT3 FS on hda3, internal journal
> device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on hda1, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on hda9, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on hda10, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on hda6, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on hda8, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on hda7, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> Adding 1076000k swap on /dev/hda5.  Priority:-1 extents:1
> parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
> parport0: irq 7 detected
> ip_tables: (C) 2000-2002 Netfilter core team
> ip_tables: (C) 2000-2002 Netfilter core team
> eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
> Bluetooth: L2CAP ver 2.3
> Bluetooth: L2CAP socket layer initialized
> Bluetooth: RFCOMM ver 1.3
> Bluetooth: RFCOMM socket layer initialized
> Bluetooth: RFCOMM TTY layer initialized
> i2c /dev entries driver
> NET: Registered protocol family 10
> Disabled Privacy Extensions on device 02359760(lo)
> IPv6 over IPv4 tunneling driver
> divert: not allocating divert_blk for non-ethernet device sit0
> ip_tables: (C) 2000-2002 Netfilter core team
> parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
> parport0: irq 7 detected
> lp0: using parport0 (polling).
> lp0: console ready
> eth0: no IPv6 routers present
> ISO 9660 Extensions: Microsoft Joliet Level 3
> ISO 9660 Extensions: RRIP_1991A
> Bluetooth: BNEP (Ethernet Emulation) ver 1.2
> Bluetooth: BNEP filters: protocol multicast
> CSLIP: code copyright 1989 Regents of the University of California
> PPP generic driver version 2.4.2
> divert: not allocating divert_blk for non-ethernet device ppp0
> PPP Deflate Compression module registered
> divert: no divert_blk to free, ppp0 not ethernet
> divert: not allocating divert_blk for non-ethernet device ppp0
> divert: no divert_blk to free, ppp0 not ethernet
> divert: not allocating divert_blk for non-ethernet device ppp0
> divert: no divert_blk to free, ppp0 not ethernet
> divert: not allocating divert_blk for non-ethernet device ppp0
> divert: no divert_blk to free, ppp0 not ethernet
> divert: not allocating divert_blk for non-ethernet device ppp0
> divert: no divert_blk to free, ppp0 not ethernet
> divert: not allocating divert_blk for non-ethernet device ppp0
> divert: no divert_blk to free, ppp0 not ethernet
> divert: not allocating divert_blk for non-ethernet device ppp0
> divert: no divert_blk to free, ppp0 not ethernet
> divert: not allocating divert_blk for non-ethernet device ppp0
> divert: no divert_blk to free, ppp0 not ethernet
> divert: not allocating divert_blk for non-ethernet device ppp0
> divert: no divert_blk to free, ppp0 not ethernet
> divert: not allocating divert_blk for non-ethernet device ppp0
> divert: no divert_blk to free, ppp0 not ethernet
> divert: not allocating divert_blk for non-ethernet device ppp0
>
>
>
>
> ===================== hcid.conf ===================================
>
> #
> # HCI daemon configuration file.
> #
> # $Id: hcid.conf,v 1.4 2004/04/29 20:14:21 holtmann Exp $
> #
>
> # HCId options
> options {
>         # Automatically initialize new devices
>         autoinit yes;
>
>         # Security Manager mode
>         #   none - Security manager disabled
>         #   auto - Use local PIN for incoming connections
>         #   user - Always ask user for a PIN
>         #
>         security auto;
>
>         # Pairing mode
>         #   none  - Pairing disabled
>         #   multi - Allow pairing with already paired devices
>         #   once  - Pair once and deny successive attempts
>         pairing multi;
>
>         # PIN helper
>         pin_helper /usr/bin/bluepin;
>
>         # D-Bus PIN helper
>         #dbus_pin_helper;
> }
>
> # Default settings for HCI devices
> device {
>         # Local device name
>         #   %d - device id
>         #   %h - host name
>         name "%h-%d";
>
>         # Local device class
>         class 0x120104;
>
>         # Default packet type
>         #pkt_type DH1,DM1,HV1;
>
>         # Inquiry and Page scan
>         iscan enable; pscan enable;
>
>         # Default link mode
>         #   none   - no specific policy
>         #   accept - always accept incoming connections
>         #   master - become master on incoming connections,
>         #            deny role switch on outgoing connections
>         #
>         #lm accept,master;
>         #
>         lm accept;
>
>         # Default link policy
>         #   none    - no specific policy
>         #   rswitch - allow role switch
>         #   hold    - allow hold mode
>         #   sniff   - allow sniff mode
>         #   park    - allow park mode
>         #
>         #lp hold,sniff;
>         #
>         lp rswitch,hold,sniff,park;
>
>         # Authentication and Encryption
>         auth disable;
>         encrypt disable;
> }
>
>
>
>
>
>
> On Apr 2, 2005, at 9:54 AM, Gary Albelli wrote:
>
>> I have creates a Bluetooth serial connection on OSX. I am trying to 
>> connect to a BlueZ NAP on a Fedora linux box. It appears to connect, 
>> i see this in the log on the Linux box, but the OSX client shows 
>> "Authenticating" but never does.
>>
>>
>

--Boundary_(ID_MvfJJit7rjmluMRD9pJjHQ)
Content-type: text/enriched; charset=US-ASCII
Content-transfer-encoding: 7BIT




Begin forwarded message:


<excerpt><bold><color><param>0000,0000,0000</param>From:
</color></bold>Gary Albelli <<galbelli@optonline.net>

<bold><color><param>0000,0000,0000</param>Date: </color></bold>April
3, 2005 12:15:14 PM EDT

<bold><color><param>0000,0000,0000</param>To: </color></bold>Gary
Albelli <<galbelli@optonline.net>

<bold><color><param>0000,0000,0000</param>Cc:
</color></bold>bluez-users@lists.sourceforge.net

<bold><color><param>0000,0000,0000</param>Subject: </color>Problem
connecting to NAP via serial null modem connection

</bold>

I have tried to connect from both by laptop and my Palm-pilot. Each
device generates the same log information on the Linux box(NAP).  I am
not sure where this is failing or what too do next. Any suggestions on
what I can check or do to diagnose the problem would be greatly
appreciated.


I have included the dmesg output, log output generated from making the
connection, and my hcid.conf file.


Thanks

Gary


===================== tailed from /var/log/messages ==================


Apr  3 11:53:46 darthvader pppd[14136]: pppd 2.4.2 started by root,
uid 0

Apr  3 11:53:46 darthvader pppd[14136]: Serial connection established.

Apr  3 11:53:46 darthvader pppd[14136]: Using interface ppp0

Apr  3 11:53:46 darthvader pppd[14136]: Connect: ppp0 <<-->
/dev/rfcomm0

Apr  3 11:53:46 darthvader dund[14122]: New connection from
00:07:E0:34:9B:13

Apr  3 11:53:51 darthvader pam_timestamp_check: pam_timestamp: `/'
owner UID != 0





====================== DMESG OUTPUT ==========================


[root@darthvader ~]# dmesg

Linux version 2.6.8-1.541 (bhcompile@porky.build.redhat.com) (gcc
version 3.4.1 20040831 (Red Hat 3.4.1-10)) #1 Wed Sep 1 18:01:20 EDT
2004

BIOS-provided physical RAM map:

 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)

 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)

 BIOS-e820: 0000000000100000 - 000000003ff77000 (usable)

 BIOS-e820: 000000003ff77000 - 000000003ff79000 (ACPI NVS)

 BIOS-e820: 000000003ff79000 - 0000000040000000 (reserved)

 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)

 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)

 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)

0MB HIGHMEM available.

1023MB LOWMEM available.

zapping low mappings.

On node 0 totalpages: 262007

  DMA zone: 4096 pages, LIFO batch:1

  Normal zone: 257911 pages, LIFO batch:16

  HighMem zone: 0 pages, LIFO batch:1

DMI 2.3 present.

ACPI: RSDP (v000 DELL                                      ) @
0x000fd550

ACPI: RSDT (v001 DELL    8200    0x00000008 ASL  0x00000061) @
0x000fd564

ACPI: FADT (v001 DELL    8200    0x00000008 ASL  0x00000061) @
0x000fd598

ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000d) @
0xfffe5d92

ACPI: MADT (v001 DELL    8200    0x00000008 ASL  0x00000061) @
0x000fd60c

ACPI: BOOT (v001 DELL    8200    0x00000008 ASL  0x00000061) @
0x000fd678

ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000d) @
0x00000000

ACPI: PM-Timer IO Port: 0x808

Built 1 zonelists

Kernel command line: ro root=LABEL=/

mapped 4G/4G trampoline to ffff4000.

Initializing CPU#0

CPU 0 irqstacks, hard=023c6000 soft=023c5000

PID hash table entries: 4096 (order 12: 32768 bytes)

Detected 2254.557 MHz processor.

Using tsc for high-res timesource

Console: colour VGA+ 80x25

Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)

Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)

Memory: 1033872k/1048028k available (2024k kernel code, 13476k
reserved, 631k data, 144k init, 0k highmem)

Calibrating delay loop... 4440.06 BogoMIPS (lpj=2220032)

Security Scaffold v1.0.0 initialized

SELinux:  Initializing.

SELinux:  Starting in permissive mode

There is already a security framework initialized, register_security
failed.

selinux_register_security:  Registering secondary module capability

Capability LSM initialized as secondary

Mount-cache hash table entries: 512 (order: 0, 4096 bytes)

CPU: After generic identify, caps: 3febfbff 00000000 00000000 00000000

CPU: After vendor identify, caps:  3febfbff 00000000 00000000 00000000

CPU: Trace cache: 12K uops, L1 D cache: 8K

CPU: L2 cache: 512K

CPU: After all inits, caps:        3febf3ff 00000000 00000000 00000080

Intel machine check architecture supported.

Intel machine check reporting enabled on CPU#0.

CPU0: Intel P4/Xeon Extended MCE MSRs (12) available

CPU: Intel(R) Pentium(R) 4 CPU 2.26GHz stepping 04

Enabling fast FPU save and restore... done.

Enabling unmasked SIMD FPU exception support... done.

Checking 'hlt' instruction... OK.

ACPI: IRQ9 SCI: Level Trigger.

checking if image is initramfs... it is

Freeing initrd memory: 386k freed

NET: Registered protocol family 16

PCI: PCI BIOS revision 2.10 entry at 0xfbe9e, last bus=2

PCI: Using configuration type 1

mtrr: v2.0 (20020519)

ACPI: Subsystem revision 20040715

ACPI: Interpreter enabled

ACPI: Using PIC for interrupt routing

ACPI: PCI Root Bridge [PCI0] (00:00)

PCI: Probing PCI hardware (bus 00)

get_random_bytes called before random driver initialization

PCI: Transparent bridge - 0000:00:1e.0

ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]

ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]

ACPI: PCI Interrupt Link [LNKA] (IRQs *3 4 5 6 7 9 10 11 12 15)

ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)

ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 15)

ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 15)

ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 15) *0,
disabled.

ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 15) *0,
disabled.

ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 15) *0,
disabled.

ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 15)

Linux Plug and Play Support v0.97 (c) Adam Belay

usbcore: registered new driver usbfs

usbcore: registered new driver hub

PCI: Using ACPI for IRQ routing

ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11

ACPI: PCI interrupt 0000:00:1f.2[D] -> GSI 11 (level, low) -> IRQ 11

ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10

ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 10 (level, low) -> IRQ 10

ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 9

ACPI: PCI interrupt 0000:00:1f.4[C] -> GSI 9 (level, low) -> IRQ 9

ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 3

ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 3 (level, low) -> IRQ 3

ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 3 (level, low) -> IRQ 3

ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 10 (level, low) -> IRQ 10

ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11

ACPI: PCI interrupt 0000:02:09.0[A] -> GSI 11 (level, low) -> IRQ 11

get_random_bytes called before random driver initialization

vesafb: probe of vesafb0 failed with error -6

Simple Boot Flag at 0x7a set to 0x1

apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)

apm: overridden by ACPI.

audit: initializing netlink socket (disabled)

audit(1112475725.987:0): initialized

Total HugeTLB memory allocated, 0

VFS: Disk quotas dquot_6.5.1

Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)

SELinux:  Registering netfilter hooks

Initializing Cryptographic API

ksign: Installing public key data

Loading keyring

- Added public key EB180CB126A51024

- User ID: Red Hat, Inc. (Kernel Module GPG key)

pci_hotplug: PCI Hot Plug PCI Core version: 0.5

ACPI: Processor [CPU0] (supports C1)

isapnp: Scanning for PnP cards...

isapnp: No Plug & Play device found

Real Time Clock Driver v1.12

Linux agpgart interface v0.100 (c) Dave Jones

agpgart: Detected an Intel i850 Chipset.

agpgart: Maximum main memory to use for agp memory: 941M

agpgart: AGP aperture is 128M @ 0xe8000000

Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing
enabled

ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A

RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize

divert: not allocating divert_blk for non-ethernet device lo

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2

ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx

ICH2: IDE controller at PCI slot 0000:00:1f.1

ICH2: chipset revision 4

ICH2: not 100% native mode: will probe irqs later

    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio

    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio

Probing IDE interface ide0...

hda: WDC WD800JB-00CRA1, ATA DISK drive

Using cfq io scheduler

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

Probing IDE interface ide1...

hdc: _NEC CD-RW NR-7900A, ATAPI CD/DVD-ROM drive

ide1 at 0x170-0x177,0x376 on irq 15

Probing IDE interface ide2...

ide2: Wait for ready failed before probe !

Probing IDE interface ide3...

ide3: Wait for ready failed before probe !

Probing IDE interface ide4...

ide4: Wait for ready failed before probe !

Probing IDE interface ide5...

ide5: Wait for ready failed before probe !

hda: max request size: 128KiB

hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63,
UDMA(100)

hda: cache flushes not supported

 hda: hda1 hda2 << hda5 hda6 hda7 hda8 hda9 hda10 > hda3

hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)

Uniform CD-ROM driver Revision: 3.20

ide-floppy driver 0.99.newide

usbcore: registered new driver hiddev

usbcore: registered new driver usbhid

drivers/usb/input/hid-core.c: v2.0:USB HID core driver

mice: PS/2 mouse device common for all mice

serio: i8042 AUX port at 0x60,0x64 irq 12

input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1

serio: i8042 KBD port at 0x60,0x64 irq 1

input: AT Translated Set 2 keyboard on isa0060/serio0

md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27

NET: Registered protocol family 2

IP: routing cache hash table of 2048 buckets, 64Kbytes

TCP: Hash tables configured (established 262144 bind 37449)

Initializing IPsec netlink socket

NET: Registered protocol family 1

NET: Registered protocol family 17

ACPI: (supports S0 S1 S3 S4 S5)

ACPI wakeup devices:

VBTN PCI0 USB0 USB1 PCI1  KBD

Freeing unused kernel memory: 144k freed

kjournald starting.  Commit interval 5 seconds

EXT3-fs: mounted filesystem with ordered data mode.

inserting floppy driver for 2.6.8-1.541

Floppy drive(s): fd0 is 1.44M

FDC 0 is a post-1991 82077

8139too Fast Ethernet driver 0.9.27

ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 3 (level, low) -> IRQ 3

divert: allocating divert_blk for eth0

eth0: RealTek RTL8139 at 0xec00, 00:c0:a8:80:fc:3e, IRQ 3

eth0:  Identified 8139 chip type 'RTL-8139C'

USB Universal Host Controller Interface driver v2.2

ACPI: PCI interrupt 0000:00:1f.2[D] -> GSI 11 (level, low) -> IRQ 11

uhci_hcd 0000:00:1f.2: UHCI Host Controller

PCI: Setting latency timer of device 0000:00:1f.2 to 64

uhci_hcd 0000:00:1f.2: irq 11, io base 0000ff80

uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1

hub 1-0:1.0: USB hub found

hub 1-0:1.0: 2 ports detected

ACPI: PCI interrupt 0000:00:1f.4[C] -> GSI 9 (level, low) -> IRQ 9

uhci_hcd 0000:00:1f.4: UHCI Host Controller

PCI: Setting latency timer of device 0000:00:1f.4 to 64

uhci_hcd 0000:00:1f.4: irq 9, io base 0000ff60

uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2

hub 2-0:1.0: USB hub found

hub 2-0:1.0: 2 ports detected

md: Autodetecting RAID arrays.

md: autorun ...

md: ... autorun DONE.

usb 2-2: new full speed USB device using address 2

Bluetooth: Core ver 2.6

NET: Registered protocol family 31

Bluetooth: HCI device and connection manager initialized

Bluetooth: HCI socket layer initialized

Bluetooth: HCI USB driver ver 2.7

usbcore: registered new driver hci_usb

ACPI: Power Button (FF) [PWRF]

EXT3 FS on hda3, internal journal

device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com

kjournald starting.  Commit interval 5 seconds

EXT3 FS on hda1, internal journal

EXT3-fs: mounted filesystem with ordered data mode.

kjournald starting.  Commit interval 5 seconds

EXT3 FS on hda9, internal journal

EXT3-fs: mounted filesystem with ordered data mode.

kjournald starting.  Commit interval 5 seconds

EXT3 FS on hda10, internal journal

EXT3-fs: mounted filesystem with ordered data mode.

kjournald starting.  Commit interval 5 seconds

EXT3 FS on hda6, internal journal

EXT3-fs: mounted filesystem with ordered data mode.

kjournald starting.  Commit interval 5 seconds

EXT3 FS on hda8, internal journal

EXT3-fs: mounted filesystem with ordered data mode.

kjournald starting.  Commit interval 5 seconds

EXT3 FS on hda7, internal journal

EXT3-fs: mounted filesystem with ordered data mode.

Adding 1076000k swap on /dev/hda5.  Priority:-1 extents:1

parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]

parport0: irq 7 detected

ip_tables: (C) 2000-2002 Netfilter core team

ip_tables: (C) 2000-2002 Netfilter core team

eth0: link up, 100Mbps, full-duplex, lpa 0x45E1

Bluetooth: L2CAP ver 2.3

Bluetooth: L2CAP socket layer initialized

Bluetooth: RFCOMM ver 1.3

Bluetooth: RFCOMM socket layer initialized

Bluetooth: RFCOMM TTY layer initialized

i2c /dev entries driver

NET: Registered protocol family 10

Disabled Privacy Extensions on device 02359760(lo)

IPv6 over IPv4 tunneling driver

divert: not allocating divert_blk for non-ethernet device sit0

ip_tables: (C) 2000-2002 Netfilter core team

parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]

parport0: irq 7 detected

lp0: using parport0 (polling).

lp0: console ready

eth0: no IPv6 routers present

ISO 9660 Extensions: Microsoft Joliet Level 3

ISO 9660 Extensions: RRIP_1991A

Bluetooth: BNEP (Ethernet Emulation) ver 1.2

Bluetooth: BNEP filters: protocol multicast

CSLIP: code copyright 1989 Regents of the University of California

PPP generic driver version 2.4.2

divert: not allocating divert_blk for non-ethernet device ppp0

PPP Deflate Compression module registered

divert: no divert_blk to free, ppp0 not ethernet

divert: not allocating divert_blk for non-ethernet device ppp0

divert: no divert_blk to free, ppp0 not ethernet

divert: not allocating divert_blk for non-ethernet device ppp0

divert: no divert_blk to free, ppp0 not ethernet

divert: not allocating divert_blk for non-ethernet device ppp0

divert: no divert_blk to free, ppp0 not ethernet

divert: not allocating divert_blk for non-ethernet device ppp0

divert: no divert_blk to free, ppp0 not ethernet

divert: not allocating divert_blk for non-ethernet device ppp0

divert: no divert_blk to free, ppp0 not ethernet

divert: not allocating divert_blk for non-ethernet device ppp0

divert: no divert_blk to free, ppp0 not ethernet

divert: not allocating divert_blk for non-ethernet device ppp0

divert: no divert_blk to free, ppp0 not ethernet

divert: not allocating divert_blk for non-ethernet device ppp0

divert: no divert_blk to free, ppp0 not ethernet

divert: not allocating divert_blk for non-ethernet device ppp0

divert: no divert_blk to free, ppp0 not ethernet

divert: not allocating divert_blk for non-ethernet device ppp0





===================== hcid.conf ===================================


#

# HCI daemon configuration file.

#

# $Id: hcid.conf,v 1.4 2004/04/29 20:14:21 holtmann Exp $

#


# HCId options

options {

        # Automatically initialize new devices

        autoinit yes;


        # Security Manager mode

        #   none - Security manager disabled

        #   auto - Use local PIN for incoming connections

        #   user - Always ask user for a PIN

        #

        security auto;


        # Pairing mode

        #   none  - Pairing disabled

        #   multi - Allow pairing with already paired devices

        #   once  - Pair once and deny successive attempts

        pairing multi;


        # PIN helper

        pin_helper /usr/bin/bluepin;


        # D-Bus PIN helper

        #dbus_pin_helper;

}


# Default settings for HCI devices

device {

        # Local device name

        #   %d - device id

        #   %h - host name

        name "%h-%d";


        # Local device class

        class 0x120104;


        # Default packet type

        #pkt_type DH1,DM1,HV1;


        # Inquiry and Page scan

        iscan enable; pscan enable;


        # Default link mode

        #   none   - no specific policy

        #   accept - always accept incoming connections

        #   master - become master on incoming connections,

        #            deny role switch on outgoing connections

        #

        #lm accept,master;

        #

        lm accept;


        # Default link policy

        #   none    - no specific policy

        #   rswitch - allow role switch

        #   hold    - allow hold mode

        #   sniff   - allow sniff mode

        #   park    - allow park mode

        #

        #lp hold,sniff;

        #

        lp rswitch,hold,sniff,park;


        # Authentication and Encryption

        auth disable;

        encrypt disable;

}







On Apr 2, 2005, at 9:54 AM, Gary Albelli wrote:


<excerpt>I have creates a Bluetooth serial connection on OSX. I am
trying to connect to a BlueZ NAP on a Fedora linux box. It appears to
connect, i see this in the log on the Linux box, but the OSX client
shows "Authenticating" but never does.



</excerpt>

</excerpt>

--Boundary_(ID_MvfJJit7rjmluMRD9pJjHQ)--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
