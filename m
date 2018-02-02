Return-Path: <graeme.gregory@linaro.org>
Subject: Re: [v3,2/2] ACPI / scan: Fix enumeration for special UART devices
To: =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>
Cc: robh@kernel.org, marcel@holtmann.org, sre@kernel.org,
 loic.poulain@gmail.com, johan@kernel.org, lukas@wunner.de,
 hdegoede@redhat.com, rafael@kernel.org, greg@kroah.com,
 linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <1507710734-32520-3-git-send-email-frederic.danis.oss@gmail.com>
 <20180131142100.GE26342@xora-haswell>
 <4eb3d357-bf54-2360-f547-d0c6fbbc8396@gmail.com>
From: Graeme Gregory <graeme.gregory@linaro.org>
Message-ID: <c1e97640-f427-2d2e-6b7e-3c9a5de60897@linaro.org>
Date: Fri, 2 Feb 2018 15:28:05 +0000
MIME-Version: 1.0
In-Reply-To: <4eb3d357-bf54-2360-f547-d0c6fbbc8396@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------7191A5DB7C6FF83551FECDCB"
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------7191A5DB7C6FF83551FECDCB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 02/02/18 10:03, Frédéric Danis wrote:
> Hi Graeme,
> 
> Le 31/01/2018 à 15:21, Graeme Gregory a écrit :
>> On Wed, Oct 11, 2017 at 10:32:14AM +0200, Frédéric Danis wrote:
>>> UART devices is expected to be enumerated by SerDev subsystem.
>>>
>>> During ACPI scan, serial devices behind SPI, I2C or UART buses are not
>>> enumerated, allowing them to be enumerated by their respective parents.
>>>
>>> Rename *spi_i2c_slave* to *serial_bus_slave* as this will be used for 
>>> serial
>>> devices on serial buses (SPI, I2C or UART).
>>>
>>> On Macs an empty ResourceTemplate is returned for uart slaves.
>>> Instead the device properties "baud", "parity", "dataBits", 
>>> "stopBits" are
>>> provided. Add a check for "baud" in acpi_is_serial_bus_slave().
>>>
>> This patch appears to break UART probing in ACPI on xgene based
>> plaforms.
>>
>> The appropriate chunks of DSDT.
>>
>>      Device (_SB.AHBC)
>>      {
>>          OperationRegion (SRST, SystemMemory, 0x1F2AC000, 0x04)
>>          OperationRegion (CLKE, SystemMemory, 0x1F2AC004, 0x04)
>>          OperationRegion (SRRM, SystemMemory, 0x1F2AD070, 0x04)
>>          OperationRegion (RD2F, SystemMemory, 0x1F2AE014, 0x04)
>>
>>      ...
>>
>>          Device (UAR0)
>>          {
>>              Name (_HID, "APMC0D08")  // _HID: Hardware ID
>>              Name (_DDN, "UAR0")  // _DDN: DOS Device Name
>>              Name (_UID, "UAR0")  // _UID: Unique ID
>>              Name (_STR, Unicode ("APM88xxxx UART0 Controller"))  // 
>> _STR: Description String
>>              Name (_ADR, 0x1C021000)  // _ADR: Address
>>              Name (_CID, "NS16550A")  // _CID: Compatible ID
>>
>>      ...
>>
>>              Name (_CRS, ResourceTemplate ()  // _CRS: Current 
>> Resource Settings
>>              {
>>                  Memory32Fixed (ReadWrite,
>>                      0x1C021000,         // Address Base
>>                      0x00000100,         // Address Length
>>                      )
>>                  UartSerialBusV2 (0x00002580, DataBitsEight, StopBitsOne,
>>                      0x00, LittleEndian, ParityTypeNone, 
>> FlowControlHardware,
>>                      0x0010, 0x0010, "UAR0",
>>                      0x00, ResourceConsumer, , Exclusive,
>>                      )
>>                  Interrupt (ResourceProducer, Level, ActiveHigh, 
>> Exclusive, ,, )
>>                  {
>>                      0x0000006D,
>>                  }
>>              })
> 
> This seems to be related to 
> https://bugzilla.redhat.com/show_bug.cgi?id=1531140
> Am I correct?
> 
Ahah that is the same thing I'm pretty certain, my googling did not turn 
that up.

> The SerDev support should allow UART to appear as tty device if not used 
> by an underlying component (cf. tty_port_register_device_attr() in 
> drivers/tty/tty_port.c).
> 
> AFAIU, there is no internal device attached to this serial port.
> Is it possible to get complete ACPI DSDT?
>
Complete DSDT attached.

> Is SerDev enabled on this device?
> Boot logs with SerDev debug traces enabled can be useful to understand 
> what happens.
> 

#define DEBUG in serdev/core.c does not seem to produce much output. But 
attached bootlog anyway.

Thanks

Graeme

--------------7191A5DB7C6FF83551FECDCB
Content-Type: text/x-log;
 name="moonshot-serial-debug.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="moonshot-serial-debug.log"

EFI stub: Booting Linux Kernel...
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services and installing virtual address map...
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x500f0001]
[    0.000000] Linux version 4.15.0-dirty (linaro@debian) (gcc version 6.3.0 20170516 (Debian 6.3.0-18)) #7 SMP PREEMPT Fri Feb 2 15:07:39 GMT 2018
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.60 by HPE
[    0.000000] efi:  ACPI 2.0=0x4ff8000000  SMBIOS 3.0=0x4ff79f0000  MEMATTR=0x4ff23c0018  RNG=0x4ff7e7f498 
[    0.000000] random: fast init done
[    0.000000] efi: seeding entropy pool
[    0.000000] cma: Reserved 16 MiB at 0x00000040ff000000
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x0000004FF8000000 000024 (v02 HP    )
[    0.000000] ACPI: XSDT 0x0000004FF7FF0000 000084 (v01 HP     ProLiant 00000001      01000013)
[    0.000000] ACPI: FACP 0x0000004FF7FB0000 000114 (v06 HPE    ProLiant 00000001 HP   00000001)
[    0.000000] ACPI: DSDT 0x0000004FF7F80000 0023CA (v05 HPE    DSDT     00000001 INTL 20160527)
[    0.000000] ACPI: SSDT 0x0000004FF7FE0000 000032 (v02 HPE    UARTCLKS 00000001      01000013)
[    0.000000] ACPI: BERT 0x0000004FF7FD0000 000030 (v01 HPE    ProLiant 00000002 INTL 20160527)
[    0.000000] ACPI: HEST 0x0000004FF7FC0000 0002A8 (v01 HPE    ProLiant 00000002 INTL 20160527)
[    0.000000] ACPI: DBG2 0x0000004FF7FA0000 0000A8 (v00 HPE    ProLiant 00000000 INTL 20160527)
[    0.000000] ACPI: GTDT 0x0000004FF7F90000 0000E0 (v02 HPE    ProLiant 00000001 INTL 20160527)
[    0.000000] ACPI: APIC 0x0000004FF7F70000 0002C4 (v03 HPE    ProLiant 00000001 HP   00000001)
[    0.000000] ACPI: MCFG 0x0000004FF7F60000 00003C (v01 APM    XGENE    00000001 HP   00000001)
[    0.000000] ACPI: SPMI 0x0000004FF7F50000 000041 (v05 HPE    ProLiant 00000001 HP   00000001)
[    0.000000] ACPI: RASF 0x0000004FF7F40000 000030 (v01 HPE    ProLiant 00000001 HP   00000001)
[    0.000000] ACPI: SPCR 0x0000004FF7F30000 000050 (v02 HPE    ProLiant 00000001 HP   00000001)
[    0.000000] ACPI: SSDT 0x0000004FF7F20000 0003CA (v02 HPE    PCISSDT  00000002 HPAG 00020000)
[    0.000000] ACPI: SPCR: Unexpected SPCR Access Width.  Defaulting to byte size
[    0.000000] ACPI: SPCR: console: uart,mmio32,0x1c021000
[    0.000000] earlycon: uart0 at MMIO32 0x000000001c021000 (options '')
[    0.000000] bootconsole [uart0] enabled
[    0.000000] ACPI: NUMA: Failed to initialise from firmware
[    0.000000] NUMA: Faking a node at [mem 0x0000000000000000-0x0000004fffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x4ffffed500-0x4ffffeefff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000004000000000-0x00000040ffffffff]
[    0.000000]   Normal   [mem 0x0000004100000000-0x0000004fffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000004000000000-0x00000040001fffff]
[    0.000000]   node   0: [mem 0x0000004000200000-0x0000004001ffffff]
[    0.000000]   node   0: [mem 0x00000040023b0000-0x0000004ff733ffff]
[    0.000000]   node   0: [mem 0x0000004ff7340000-0x0000004ff77cffff]
[    0.000000]   node   0: [mem 0x0000004ff77d0000-0x0000004ff792ffff]
[    0.000000]   node   0: [mem 0x0000004ff7930000-0x0000004ff7e7ffff]
[    0.000000]   node   0: [mem 0x0000004ff7e80000-0x0000004ff7e9bfff]
[    0.000000]   node   0: [mem 0x0000004ff7e9c000-0x0000004ff7efffff]
[    0.000000]   node   0: [mem 0x0000004ff7f10000-0x0000004fffffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000004000000000-0x0000004fffffffff]
[    0.000000] psci: is not implemented in ACPI.
[    0.000000] percpu: Embedded 23 pages/cpu @        (ptrval) s55064 r8192 d30952 u94208
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 16514112
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.15.0-dirty root=UUID=c3efd764-cbb4-4b27-9e93-81a7fdb0545a ro earlycon
[    0.000000] software IO TLB [mem 0x40fafff000-0x40fefff000] (64MB) mapped at [        (ptrval)-        (ptrval)]
[    0.000000] Memory: 65936584K/67105024K available (9788K kernel code, 1152K rwdata, 4524K rodata, 1088K init, 398K bss, 1152056K reserved, 16384K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffff000000000000 - 0xffff000008000000   (   128 MB)
[    0.000000]     vmalloc : 0xffff000008000000 - 0xffff7dffbfff0000   (129022 GB)
[    0.000000]       .text : 0x        (ptrval) - 0x        (ptrval)   (  9792 KB)
[    0.000000]     .rodata : 0x        (ptrval) - 0x        (ptrval)   (  4544 KB)
[    0.000000]       .init : 0x        (ptrval) - 0x        (ptrval)   (  1088 KB)
[    0.000000]       .data : 0x        (ptrval) - 0x        (ptrval)   (  1153 KB)
[    0.000000]        .bss : 0x        (ptrval) - 0x        (ptrval)   (   399 KB)
[    0.000000]     fixed   : 0xffff7dfffe7fd000 - 0xffff7dfffec00000   (  4108 KB)
[    0.000000]     PCI I/O : 0xffff7dfffee00000 - 0xffff7dffffe00000   (    16 MB)
[    0.000000]     vmemmap : 0xffff7e0000000000 - 0xffff800000000000   (  2048 GB maximum)
[    0.000000]               0xffff7e0000000000 - 0xffff7e0040000000   (  1024 MB actual)
[    0.000000]     memory  : 0xffff800000000000 - 0xffff801000000000   ( 65536 MB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=8.
[    0.000000] 	Tasks RCU enabled.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] arch_timer: Failed to initialize memory-mapped timer.
[    0.000000] arch_timer: cp15 timer(s) running at 50.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
[    0.000002] sched_clock: 56 bits at 50MHz, resolution 20ns, wraps every 4398046511100ns
[    0.095856] Console: colour dummy device 80x25
[    0.149024] ACPI: Core revision 20170831
[    0.197490] ACPI: 3 ACPI AML tables successfully acquired and loaded
[    0.273520] Calibrating delay loop (skipped), value calculated using timer frequency.. 100.00 BogoMIPS (lpj=200000)
[    0.398426] pid_max: default: 32768 minimum: 301
[    0.453679] Security Framework initialized
[    0.507606] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes)
[    0.598601] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.686162] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.770584] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.876165] ASID allocator initialised with 65536 entries
[    0.940781] Hierarchical SRCU implementation.
[    1.000969] Remapping and enabling EFI services.
[    1.056206]   EFI remap 0x0000000010510000 =>         (ptrval)
[    1.125992]   EFI remap 0x0000000010548000 =>         (ptrval)
[    1.195775]   EFI remap 0x0000000017000000 =>         (ptrval)
[    1.265558]   EFI remap 0x000000001c024000 =>         (ptrval)
[    1.335343]   EFI remap 0x000000001f2a0000 =>         (ptrval)
[    1.405131]   EFI remap 0x0000004002330000 =>         (ptrval)
[    1.474964]   EFI remap 0x0000004ff7340000 =>         (ptrval)
[    1.544809]   EFI remap 0x0000004ff7930000 =>         (ptrval)
[    1.622602] smp: Bringing up secondary CPUs ...
[    1.704833] Detected PIPT I-cache on CPU1
[    1.704859] CPU1: Booted secondary processor 0x0000000001 [0x500f0001]
[    1.732856] Detected PIPT I-cache on CPU2
[    1.732875] CPU2: Booted secondary processor 0x0000000100 [0x500f0001]
[    1.760879] Detected PIPT I-cache on CPU3
[    1.760891] CPU3: Booted secondary processor 0x0000000101 [0x500f0001]
[    1.788907] Detected PIPT I-cache on CPU4
[    1.788925] CPU4: Booted secondary processor 0x0000000200 [0x500f0001]
[    1.816929] Detected PIPT I-cache on CPU5
[    1.816941] CPU5: Booted secondary processor 0x0000000201 [0x500f0001]
[    1.844957] Detected PIPT I-cache on CPU6
[    1.844976] CPU6: Booted secondary processor 0x0000000300 [0x500f0001]
[    1.872978] Detected PIPT I-cache on CPU7
[    1.872991] CPU7: Booted secondary processor 0x0000000301 [0x500f0001]
[    1.873023] smp: Brought up 1 node, 8 CPUs
[    2.803198] SMP: Total of 8 processors activated.
[    2.859359] CPU features: detected feature: 32-bit EL0 Support
[    2.929338] CPU: All CPU(s) started at EL2
[    2.987381] devtmpfs: initialized
[    3.027380] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    3.143988] futex hash table entries: 2048 (order: 6, 262144 bytes)
[    3.219187] pinctrl core: initialized pinctrl subsystem
[    3.282102] SMBIOS 3.0.0 present.
[    3.321738] DMI: HPE ProLiant m400 Server/ProLiant m400 Server, BIOS U02 08/19/2016
[    3.413505] NET: Registered protocol family 16
[    3.466796] audit: initializing netlink subsys (disabled)
[    3.531425] audit: type=2000 audit(0.436:1): state=initialized audit_enabled=0 res=1
[    3.624097] cpuidle: using governor menu
[    3.624184] vdso: 2 pages (1 code @ 00000000515432a4, 1 data @ 000000006f8d1dd3)
[    3.624189] hw-breakpoint: found 4 breakpoint and 4 watchpoint registers.
[    3.671359] DMA: preallocated 256 KiB pool for atomic allocations
[    3.671488] ACPI: bus type PCI registered
[    3.671491] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    3.671598] Serial: AMBA PL011 UART driver
[    3.759730] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    4.167824] ACPI: Added _OSI(Module Device)
[    4.217855] ACPI: Added _OSI(Processor Device)
[    4.270998] ACPI: Added _OSI(3.0 _SCP Extensions)
[    4.327260] ACPI: Added _OSI(Processor Aggregator Device)
[    4.391881] ACPI: Executed 1 blocks of module-level executable AML code
[    4.473652] ACPI: Interpreter enabled
[    4.517445] ACPI: Using GIC for interrupt routing
[    4.573730] ACPI: MCFG table detected, 1 entries
[    4.655675] ACPI: Power Resource [SCVR] (off)
[    4.710603] ACPI: PCI Root Bridge [PCI3] (domain 0000 [bus 00-ff])
[    4.784576] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    4.882611] acpi PNP0A08:00: _OSC: platform does not support [AER]
[    4.956697] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    5.048342] acpi PNP0A08:00: MCFG quirk: ECAM at [mem 0xa0d0000000-0xa0dfffffff] for [bus 00-ff] with xgene_v1_pcie_ecam_ops
[    5.182958] acpi PNP0A08:00: [Firmware Bug]: ECAM area [mem 0xa0d0000000-0xa0dfffffff] not reserved in ACPI namespace
[    5.309981] acpi PNP0A08:00: ECAM at [mem 0xa0d0000000-0xa0dfffffff] for [bus 00-ff]
[    5.402671] Remapped I/O 0x000000a100010000 to [io  0x0000-0xffff window]
[    5.483974] PCI host bridge to bus 0000:00
[    5.532965] pci_bus 0000:00: root bus resource [io  0x0000-0xffff window] (bus address [0x10000-0x1ffff])
[    5.647471] pci_bus 0000:00: root bus resource [mem 0xa020000000-0xa03fffffff window] (bus address [0x20000000-0x3fffffff])
[    5.780695] pci_bus 0000:00: root bus resource [mem 0xa060000000-0xa07fffffff window] (bus address [0x40000000-0x5fffffff])
[    5.913917] pci_bus 0000:00: root bus resource [mem 0xa110000000-0xa14fffffff window]
[    6.007623] pci_bus 0000:00: root bus resource [bus 00-ff]
[    6.076622] pci 0000:01:00.0: VF(n) BAR2 space: [mem 0xa114000000-0xa123ffffff 64bit pref] (contains BAR2 for 8 VFs)
[    6.204003] pci 0000:00:00.0: BAR 15: assigned [mem 0xa110000000-0xa121ffffff 64bit pref]
[    6.301868] pci 0000:00:00.0: BAR 14: assigned [mem 0xa020000000-0xa0201fffff]
[    6.388292] pci 0000:01:00.0: BAR 2: assigned [mem 0xa110000000-0xa111ffffff 64bit pref]
[    6.485257] pci 0000:01:00.0: BAR 9: assigned [mem 0xa112000000-0xa121ffffff 64bit pref]
[    6.582149] pci 0000:01:00.0: BAR 0: assigned [mem 0xa020000000-0xa0200fffff 64bit]
[    6.673922] pci 0000:01:00.0: BAR 6: assigned [mem 0xa020100000-0xa0201fffff pref]
[    6.764503] pci 0000:00:00.0: PCI bridge to [bus 01]
[    6.823888] pci 0000:00:00.0:   bridge window [mem 0xa020000000-0xa0201fffff]
[    6.909272] pci 0000:00:00.0:   bridge window [mem 0xa110000000-0xa121ffffff 64bit pref]
[    7.006536] vgaarb: loaded
[    7.039002] SCSI subsystem initialized
[    7.083989] ACPI: bus type USB registered
[    7.131981] usbcore: registered new interface driver usbfs
[    7.197621] usbcore: registered new interface driver hub
[    7.261200] usbcore: registered new device driver usb
[    7.321767] pps_core: LinuxPPS API ver. 1 registered
[    7.381152] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    7.490462] PTP clock support registered
[    7.537405] EDAC MC: Ver: 3.0.0
[    7.575123] Registered efivars operations
[    7.624472] Advanced Linux Sound Architecture Driver Initialized.
[    7.697660] clocksource: Switched to clocksource arch_sys_counter
[    7.770626] VFS: Disk quotas dquot_6.6.0
[    7.817551] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    7.899886] pnp: PnP ACPI init
[    7.936651] pnp: PnP ACPI: found 0 devices
[    7.988172] NET: Registered protocol family 2
[    8.040706] TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
[    8.131670] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    8.212227] TCP: Hash tables configured (established 524288 bind 65536)
[    8.291542] UDP hash table entries: 32768 (order: 8, 1048576 bytes)
[    8.367118] UDP-Lite hash table entries: 32768 (order: 8, 1048576 bytes)
[    8.447903] NET: Registered protocol family 1
[    8.500211] RPC: Registered named UNIX socket transport module.
[    8.571040] RPC: Registered udp transport module.
[    8.627305] RPC: Registered tcp transport module.
[    8.683567] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    8.760786] Unpacking initramfs...
[    8.886922] Freeing initrd memory: 4036K
[    8.934264] hw perfevents: enabled with armv8_pmuv3_0 PMU driver, 5 counters available
[    9.029036] kvm [1]: 8-bit VMID
[    9.066586] kvm [1]: IDMAP page: 4000bfc000
[    9.116614] kvm [1]: HYP VA range: 800000000000:ffffffffffff
[    9.184694] kvm [1]: vgic-v2@780cf000
[    9.228554] kvm [1]: vgic interrupt IRQ1
[    9.275464] kvm [1]: virtual timer IRQ3
[    9.321412] kvm [1]: Hyp mode initialized successfully
[    9.383879] Initialise system trusted keyrings
[    9.437083] workingset: timestamp_bits=44 max_order=24 bucket_order=0
[    9.516771] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    9.586829] NFS: Registering the id_resolver key type
[    9.647266] Key type id_resolver registered
[    9.697290] Key type id_legacy registered
[    9.857626] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    9.937870] 9p: Installing v9fs 9p2000 file system support
[   10.004543] Key type asymmetric registered
[   10.053533] Asymmetric key parser 'x509' registered
[   10.111949] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[   10.200458] io scheduler noop registered
[   10.247440] io scheduler cfq registered (default)
[   10.303719] io scheduler mq-deadline registered
[   10.357903] io scheduler kyber registered
[   10.406963] xgene-gpio APMC0D14:00: X-Gene GPIO driver registered.
[   10.481006] xgene-gpio-sb APMC0D15:00: unable to obtain parent domain
[   10.558269] pcieport 0000:00:00.0: can't derive routing for PCI INT A
[   10.635342] pcieport 0000:00:00.0: PCI INT A: no GSI
[   10.694897] pcie_pme: probe of 0000:00:00.0:pcie001 failed with error -22
[   10.776458] input: Power Button as /devices/LNXSYSTM:00/PNP0C0C:00/input/input0
[   10.863944] ACPI: Power Button [PWRB]
[   10.908080] ACPI GTDT: [Firmware Bug]: failed to get the Watchdog base address.
[   10.997707] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   11.073396] SuperH (H)SCI(F) driver initialized
[   11.127667] msm_serial: driver initialized
[   11.176838] cacheinfo: Unable to detect cache hierarchy for CPU 0
[   11.252470] loop: module loaded
[   11.290620] xgene-ahci APMC0D0D:00: skip clock and PHY initialization
[   11.367693] xgene-ahci APMC0D0D:00: controller can't do NCQ, turning off CAP_NCQ
[   11.456228] xgene-ahci APMC0D0D:00: AHCI 0001.0300 32 slots 2 ports 6 Gbps 0x3 impl platform mode
[   11.562415] xgene-ahci APMC0D0D:00: flags: 64bit sntf pm only pmp fbs pio slum part ccc 
[   11.659257] xgene-ahci APMC0D0D:00: port 0 is not capable of FBS
[   11.731196] xgene-ahci APMC0D0D:00: port 1 is not capable of FBS
[   11.803401] scsi host0: xgene-ahci
[   11.844199] scsi host1: xgene-ahci
[   11.884924] ata1: SATA max UDMA/133 mmio [mem 0x1a800000-0x1a800fff] port 0x100 irq 5
[   11.978631] ata2: SATA max UDMA/133 mmio [mem 0x1a800000-0x1a800fff] port 0x180 irq 5
[   12.072868] libphy: Fixed MDIO Bus: probed
[   12.121980] tun: Universal TUN/TAP device driver, 1.6
[   12.182593] thunder-xcv, ver 1.0
[   12.221199] thunder-BGX, ver 1.0
[   12.259802] thunder-nic, ver 1.0
[   12.298485] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[   12.368271] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   12.387772] ata2: SATA link down (SStatus 0 SControl 4300)
[   12.504737] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
[   12.588040] igb: Copyright (c) 2007-2014 Intel Corporation.
[   12.654719] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
[   12.709664] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 4300)
[   12.709927] ata1.00: ATA-9: XR0120GEBLT, HPS4, max UDMA/133
[   12.709929] ata1.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 0/32)
[   12.710142] ata1.00: configured for UDMA/133
[   12.710300] scsi 0:0:0:0: Direct-Access     ATA      XR0120GEBLT      HPS4 PQ: 0 ANSI: 5
[   12.710612] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB/112 GiB)
[   12.710616] sd 0:0:0:0: [sda] 4096-byte physical blocks
[   12.710641] sd 0:0:0:0: [sda] Write Protect is off
[   12.710680] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   12.712331]  sda: sda1 sda2
[   12.712769] sd 0:0:0:0: [sda] Attached SCSI disk
[   13.524683] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[   13.595599] sky2: driver version 1.30
[   13.639549] mlx4_core: Mellanox ConnectX core driver v4.0-0
[   13.706224] mlx4_core: Initializing 0000:01:00.0
[   20.170668] mlx4_core 0000:01:00.0: DMFS high rate steer mode is: disabled performance optimized steering
[   20.285547] mlx4_core 0000:01:00.0: PCIe BW is different than device's capability
[   20.375098] mlx4_core 0000:01:00.0: PCIe link speed is 5.0GT/s, device supports 8.0GT/s
[   20.470884] mlx4_core 0000:01:00.0: PCIe link width is x8, device supports x8
[   20.585866] mlx4_en: Mellanox ConnectX HCA Ethernet driver v4.0-0
[   20.658928] mlx4_en 0000:01:00.0: Activating port:1
[   20.720008] mlx4_en: 0000:01:00.0: Port 1: Using 8 TX rings
[   20.786676] mlx4_en: 0000:01:00.0: Port 1: Using 4 RX rings
[   20.853686] mlx4_en: 0000:01:00.0: Port 1: Initializing port
[   20.921690] mlx4_en 0000:01:00.0: registered PHC clock
[   20.983478] mlx4_en 0000:01:00.0: Activating port:2
[   21.043199] mlx4_en: 0000:01:00.0: Port 2: Using 8 TX rings
[   21.109872] mlx4_en: 0000:01:00.0: Port 2: Using 4 RX rings
[   21.176805] mlx4_en: 0000:01:00.0: Port 2: Initializing port
[   21.245177] VFIO - User Level meta-driver version: 0.3
[   21.306986] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   21.385091] ehci-pci: EHCI PCI platform driver
[   21.438256] ehci-platform: EHCI generic platform driver
[   21.500800] ehci-orion: EHCI orion driver
[   21.548774] ehci-exynos: EHCI EXYNOS driver
[   21.598819] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   21.672774] ohci-pci: OHCI PCI platform driver
[   21.725939] ohci-platform: OHCI generic platform driver
[   21.788477] ohci-exynos: OHCI EXYNOS driver
[   21.838638] usbcore: registered new interface driver usb-storage
[   21.911316] rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
[   21.984416] i2c /dev entries driver
[   22.026962] sdhci: Secure Digital Host Controller Interface driver
[   22.100914] sdhci: Copyright(c) Pierre Ossman
[   22.153099] Synopsys Designware Multimedia Card Interface Driver
[   22.225137] sdhci-pltfm: SDHCI platform and OF driver helper
[   22.293224] ledtrig-cpu: registered to indicate activity on CPUs
[   22.365408] usbcore: registered new interface driver usbhid
[   22.432074] usbhid: USB HID core driver
[   22.446327] mlx4_en: eth1: Link Up
[   22.519260] NET: Registered protocol family 17
[   22.572446] 9pnet: Installing 9P2000 support
[   22.623533] Key type dns_resolver registered
[   22.674823] registered taskstats version 1
[   22.723810] Loading compiled-in X.509 certificates
[   22.781449] rtc-efi rtc-efi: setting system clock to 2018-02-02 15:24:00 UTC (1517585040)
[   22.881999] ALSA device list:
[   22.917470]   No soundcards found.
[   22.958154] Warning: unable to open an initial console.
[   23.020812] Freeing unused kernel memory: 1088K
[   23.095818] systemd-udevd[1420]: starting version 236
[   23.257724] mlx4_core 0000:01:00.0 eno1d1: renamed from eth1
[   23.374621] mlx4_core 0000:01:00.0 eno1: renamed from eth0
[   28.509968] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[   28.623018] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000200
[   28.623018] 
[   28.732322] CPU: 7 PID: 1 Comm: init Not tainted 4.15.0-dirty #7
[   28.804079] Hardware name: HPE ProLiant m400 Server/ProLiant m400 Server, BIOS U02 08/19/2016
[   28.905999] Call trace:
[   28.935126]  dump_backtrace+0x0/0x168
[   28.978905]  show_stack+0x14/0x20
[   29.018425]  dump_stack+0x98/0xb8
[   29.057944]  panic+0x114/0x27c
[   29.094344]  complete_and_exit+0x0/0x20
[   29.140103]  do_group_exit+0x34/0x98
[   29.182744]  __wake_up_parent+0x0/0x28
[   29.227463]  el0_svc_naked+0x20/0x24
[   29.270108] SMP: stopping secondary CPUs
[   29.317010] Kernel Offset: disabled
[   29.358608] CPU features: 0x002000
[   29.399167] Memory Limit: none
[   29.435571] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000200
[   29.435571] 

--------------7191A5DB7C6FF83551FECDCB
Content-Type: text/x-dsl;
 name="DSDT.dsl"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="DSDT.dsl"

/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20160831-64
 * Copyright (c) 2000 - 2016 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of DSDT, Tue Jan 30 14:42:50 2018
 *
 * Original Table Header:
 *     Signature        "DSDT"
 *     Length           0x000023CA (9162)
 *     Revision         0x05
 *     Checksum         0x91
 *     OEM ID           "HPE   "
 *     OEM Table ID     "DSDT    "
 *     OEM Revision     0x00000001 (1)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20160527 (538314023)
 */
DefinitionBlock ("", "DSDT", 5, "HPE   ", "DSDT    ", 0x00000001)
{
    External (UCLK, PkgObj)

    OperationRegion (PGUD, SystemMemory, 0x17000078, 0x04)
    OperationRegion (PCTL, SystemMemory, 0x1700007C, 0x04)
    Field (PGUD, DWordAcc, NoLock, Preserve)
    {
        SOCG,   1, 
        L3CG,   1, 
        PD0G,   1, 
        PD1G,   1, 
        PD2G,   1, 
        PD3G,   1
    }

    Field (PCTL, DWordAcc, NoLock, Preserve)
    {
        SOCC,   1, 
        L3CC,   1, 
        PD0C,   1, 
        PD1C,   1, 
        PD2C,   1, 
        PD3C,   1
    }

    PowerResource (SCVR, 0x02, 0x0000)
    {
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            Return ((NAnd (SOCC, One) & One))
        }

        Method (_ON, 0, NotSerialized)  // _ON_: Power On
        {
            SOCC = One
            Sleep (0x0A)
        }

        Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
        {
            SOCC = Zero
            Sleep (0x0A)
        }
    }

    Name (_S0, Package (0x02)  // _S0_: S0 System State
    {
        Zero, 
        Zero
    })
    Name (_S1, Package (0x02)  // _S1_: S1 System State
    {
        One, 
        Zero
    })
    Name (_S2, Package (0x02)  // _S2_: S2 System State
    {
        0x02, 
        Zero
    })
    Device (_SB.CPU0)
    {
        Name (_UID, Zero)  // _UID: Unique ID
        Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            Return (One)
        }

        Name (_CDM, Zero)  // _CDM: Clock Domain
        Method (_PSC, 0, NotSerialized)  // _PSC: Power State Current
        {
            Return (Zero)
        }

        Name (_S1D, 0x03)  // _S1D: S1 Device State
        Name (_S2D, 0x04)  // _S2D: S2 Device State
        Name (_S3D, 0x06)  // _S3D: S3 Device State
        Name (_PCT, Package (0x02)  // _PCT: Performance Control
        {
            ResourceTemplate ()
            {
                Register (SystemMemory, 
                    0x20,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000010550000, // Address
                    0x03,               // Access Size
                    )
            }, 

            ResourceTemplate ()
            {
                Register (SystemMemory, 
                    0x20,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000010550004, // Address
                    0x03,               // Access Size
                    )
            }
        })
        Name (_PSS, Package (0x05)  // _PSS: Performance Supported States
        {
            Package (0x06)
            {
                0x0960, 
                0x09C4, 
                0x0A, 
                0x0A, 
                0x10, 
                0x20
            }, 

            Package (0x06)
            {
                0x0960, 
                0x09C4, 
                0x0A, 
                0x0A, 
                0x11, 
                0x21
            }, 

            Package (0x06)
            {
                0x04B0, 
                0x05DC, 
                0x0A, 
                0x0A, 
                0x12, 
                0x22
            }, 

            Package (0x06)
            {
                0x0320, 
                0x03E8, 
                0x0A, 
                0x0A, 
                0x13, 
                0x23
            }, 

            Package (0x06)
            {
                0x0258, 
                0x0320, 
                0x0A, 
                0x0A, 
                0x14, 
                0x24
            }
        })
        Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
        {
            Package (0x05)
            {
                0x05, 
                Zero, 
                Zero, 
                0xFC, 
                0x02
            }
        })
        Name (_CST, Package (0x07)  // _CST: C-States
        {
            0x02, 
            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                One, 
                Zero, 
                0x09C4
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x02, 
                Zero, 
                Zero
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000010550018, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x03, 
                0x00030D40, 
                0x0708
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x000000001055001C, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x04, 
                0x0007A120, 
                0x03E8
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x05, 
                Zero, 
                Zero
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000010550020, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x06, 
                0x00989680, 
                Zero
            }
        })
        Name (_CSD, Package (0x03)  // _CSD: C-State Dependencies
        {
            Package (0x06)
            {
                0x06, 
                Zero, 
                One, 
                0xFC, 
                0x02, 
                0x02
            }, 

            Package (0x06)
            {
                0x06, 
                Zero, 
                0x05, 
                0xFC, 
                0x08, 
                0x03
            }, 

            Package (0x06)
            {
                0x06, 
                Zero, 
                0x06, 
                0xFC, 
                0x08, 
                0x05
            }
        })
    }

    Device (_SB.CPU1)
    {
        Name (_UID, One)  // _UID: Unique ID
        Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            Return (One)
        }

        Name (_CDM, Zero)  // _CDM: Clock Domain
        Method (_PSC, 0, NotSerialized)  // _PSC: Power State Current
        {
            Return (Zero)
        }

        Name (_S1D, 0x03)  // _S1D: S1 Device State
        Name (_S2D, 0x04)  // _S2D: S2 Device State
        Name (_S3D, 0x06)  // _S3D: S3 Device State
        Name (_PCT, Package (0x02)  // _PCT: Performance Control
        {
            ResourceTemplate ()
            {
                Register (SystemMemory, 
                    0x20,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000010551000, // Address
                    0x03,               // Access Size
                    )
            }, 

            ResourceTemplate ()
            {
                Register (SystemMemory, 
                    0x20,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000010551004, // Address
                    0x03,               // Access Size
                    )
            }
        })
        Name (_PSS, Package (0x05)  // _PSS: Performance Supported States
        {
            Package (0x06)
            {
                0x0960, 
                0x09C4, 
                0x0A, 
                0x0A, 
                0x10, 
                0x20
            }, 

            Package (0x06)
            {
                0x0960, 
                0x09C4, 
                0x0A, 
                0x0A, 
                0x11, 
                0x21
            }, 

            Package (0x06)
            {
                0x04B0, 
                0x05DC, 
                0x0A, 
                0x0A, 
                0x12, 
                0x22
            }, 

            Package (0x06)
            {
                0x0320, 
                0x03E8, 
                0x0A, 
                0x0A, 
                0x13, 
                0x23
            }, 

            Package (0x06)
            {
                0x0258, 
                0x0320, 
                0x0A, 
                0x0A, 
                0x14, 
                0x24
            }
        })
        Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
        {
            Package (0x05)
            {
                0x05, 
                Zero, 
                Zero, 
                0xFC, 
                0x02
            }
        })
        Name (_CST, Package (0x07)  // _CST: C-States
        {
            0x02, 
            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                One, 
                Zero, 
                0x09C4
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x02, 
                Zero, 
                Zero
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000010551018, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x03, 
                0x00030D40, 
                0x0708
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x000000001055101C, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x04, 
                0x0007A120, 
                0x03E8
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x05, 
                Zero, 
                Zero
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000010551020, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x06, 
                0x00989680, 
                Zero
            }
        })
        Name (_CSD, Package (0x03)  // _CSD: C-State Dependencies
        {
            Package (0x06)
            {
                0x06, 
                Zero, 
                One, 
                0xFC, 
                0x02, 
                0x02
            }, 

            Package (0x06)
            {
                0x06, 
                Zero, 
                0x05, 
                0xFC, 
                0x08, 
                0x03
            }, 

            Package (0x06)
            {
                0x06, 
                Zero, 
                0x06, 
                0xFC, 
                0x08, 
                0x05
            }
        })
    }

    Device (_SB.CPU2)
    {
        Name (_UID, 0x0100)  // _UID: Unique ID
        Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            Return (One)
        }

        Name (_CDM, One)  // _CDM: Clock Domain
        Method (_PSC, 0, NotSerialized)  // _PSC: Power State Current
        {
            Return (Zero)
        }

        Name (_S1D, 0x03)  // _S1D: S1 Device State
        Name (_S2D, 0x04)  // _S2D: S2 Device State
        Name (_S3D, 0x06)  // _S3D: S3 Device State
        Name (_PCT, Package (0x02)  // _PCT: Performance Control
        {
            ResourceTemplate ()
            {
                Register (SystemMemory, 
                    0x20,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000010552000, // Address
                    0x03,               // Access Size
                    )
            }, 

            ResourceTemplate ()
            {
                Register (SystemMemory, 
                    0x20,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000010552004, // Address
                    0x03,               // Access Size
                    )
            }
        })
        Name (_PSS, Package (0x05)  // _PSS: Performance Supported States
        {
            Package (0x06)
            {
                0x0960, 
                0x09C4, 
                0x0A, 
                0x0A, 
                0x10, 
                0x20
            }, 

            Package (0x06)
            {
                0x0960, 
                0x09C4, 
                0x0A, 
                0x0A, 
                0x11, 
                0x21
            }, 

            Package (0x06)
            {
                0x04B0, 
                0x05DC, 
                0x0A, 
                0x0A, 
                0x12, 
                0x22
            }, 

            Package (0x06)
            {
                0x0320, 
                0x03E8, 
                0x0A, 
                0x0A, 
                0x13, 
                0x23
            }, 

            Package (0x06)
            {
                0x0258, 
                0x0320, 
                0x0A, 
                0x0A, 
                0x14, 
                0x24
            }
        })
        Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
        {
            Package (0x05)
            {
                0x05, 
                Zero, 
                One, 
                0xFC, 
                0x02
            }
        })
        Name (_CST, Package (0x07)  // _CST: C-States
        {
            0x02, 
            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                One, 
                Zero, 
                0x09C4
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x02, 
                Zero, 
                Zero
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000010552018, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x03, 
                0x00030D40, 
                0x0708
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x000000001055201C, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x04, 
                0x0007A120, 
                0x03E8
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x05, 
                Zero, 
                Zero
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000010552020, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x06, 
                0x00989680, 
                Zero
            }
        })
        Name (_CSD, Package (0x03)  // _CSD: C-State Dependencies
        {
            Package (0x06)
            {
                0x06, 
                Zero, 
                0x02, 
                0xFC, 
                0x02, 
                0x02
            }, 

            Package (0x06)
            {
                0x06, 
                Zero, 
                0x05, 
                0xFC, 
                0x08, 
                0x03
            }, 

            Package (0x06)
            {
                0x06, 
                Zero, 
                0x06, 
                0xFC, 
                0x08, 
                0x05
            }
        })
    }

    Device (_SB.CPU3)
    {
        Name (_UID, 0x0101)  // _UID: Unique ID
        Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            Return (One)
        }

        Name (_CDM, One)  // _CDM: Clock Domain
        Method (_PSC, 0, NotSerialized)  // _PSC: Power State Current
        {
            Return (Zero)
        }

        Name (_S1D, 0x03)  // _S1D: S1 Device State
        Name (_S2D, 0x04)  // _S2D: S2 Device State
        Name (_S3D, 0x06)  // _S3D: S3 Device State
        Name (_PCT, Package (0x02)  // _PCT: Performance Control
        {
            ResourceTemplate ()
            {
                Register (SystemMemory, 
                    0x20,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000010553000, // Address
                    0x03,               // Access Size
                    )
            }, 

            ResourceTemplate ()
            {
                Register (SystemMemory, 
                    0x20,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000010553004, // Address
                    0x03,               // Access Size
                    )
            }
        })
        Name (_PSS, Package (0x05)  // _PSS: Performance Supported States
        {
            Package (0x06)
            {
                0x0960, 
                0x09C4, 
                0x0A, 
                0x0A, 
                0x10, 
                0x20
            }, 

            Package (0x06)
            {
                0x0960, 
                0x09C4, 
                0x0A, 
                0x0A, 
                0x11, 
                0x21
            }, 

            Package (0x06)
            {
                0x04B0, 
                0x05DC, 
                0x0A, 
                0x0A, 
                0x12, 
                0x22
            }, 

            Package (0x06)
            {
                0x0320, 
                0x03E8, 
                0x0A, 
                0x0A, 
                0x13, 
                0x23
            }, 

            Package (0x06)
            {
                0x0258, 
                0x0320, 
                0x0A, 
                0x0A, 
                0x14, 
                0x24
            }
        })
        Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
        {
            Package (0x05)
            {
                0x05, 
                Zero, 
                One, 
                0xFC, 
                0x02
            }
        })
        Name (_CST, Package (0x07)  // _CST: C-States
        {
            0x02, 
            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                One, 
                Zero, 
                0x09C4
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x02, 
                Zero, 
                Zero
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000010553018, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x03, 
                0x00030D40, 
                0x0708
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x000000001055301C, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x04, 
                0x0007A120, 
                0x03E8
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x05, 
                Zero, 
                Zero
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000010553020, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x06, 
                0x00989680, 
                Zero
            }
        })
        Name (_CSD, Package (0x03)  // _CSD: C-State Dependencies
        {
            Package (0x06)
            {
                0x06, 
                Zero, 
                0x02, 
                0xFC, 
                0x02, 
                0x02
            }, 

            Package (0x06)
            {
                0x06, 
                Zero, 
                0x05, 
                0xFC, 
                0x08, 
                0x03
            }, 

            Package (0x06)
            {
                0x06, 
                Zero, 
                0x06, 
                0xFC, 
                0x08, 
                0x05
            }
        })
    }

    Device (_SB.CPU4)
    {
        Name (_UID, 0x0200)  // _UID: Unique ID
        Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            Return (One)
        }

        Name (_CDM, 0x02)  // _CDM: Clock Domain
        Method (_PSC, 0, NotSerialized)  // _PSC: Power State Current
        {
            Return (Zero)
        }

        Name (_S1D, 0x03)  // _S1D: S1 Device State
        Name (_S2D, 0x04)  // _S2D: S2 Device State
        Name (_S3D, 0x06)  // _S3D: S3 Device State
        Name (_PCT, Package (0x02)  // _PCT: Performance Control
        {
            ResourceTemplate ()
            {
                Register (SystemMemory, 
                    0x20,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000010554000, // Address
                    0x03,               // Access Size
                    )
            }, 

            ResourceTemplate ()
            {
                Register (SystemMemory, 
                    0x20,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000010554004, // Address
                    0x03,               // Access Size
                    )
            }
        })
        Name (_PSS, Package (0x05)  // _PSS: Performance Supported States
        {
            Package (0x06)
            {
                0x0960, 
                0x09C4, 
                0x0A, 
                0x0A, 
                0x10, 
                0x20
            }, 

            Package (0x06)
            {
                0x0960, 
                0x09C4, 
                0x0A, 
                0x0A, 
                0x11, 
                0x21
            }, 

            Package (0x06)
            {
                0x04B0, 
                0x05DC, 
                0x0A, 
                0x0A, 
                0x12, 
                0x22
            }, 

            Package (0x06)
            {
                0x0320, 
                0x03E8, 
                0x0A, 
                0x0A, 
                0x13, 
                0x23
            }, 

            Package (0x06)
            {
                0x0258, 
                0x0320, 
                0x0A, 
                0x0A, 
                0x14, 
                0x24
            }
        })
        Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
        {
            Package (0x05)
            {
                0x05, 
                Zero, 
                0x02, 
                0xFC, 
                0x02
            }
        })
        Name (_CST, Package (0x07)  // _CST: C-States
        {
            0x02, 
            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                One, 
                Zero, 
                0x09C4
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x02, 
                Zero, 
                Zero
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000010554018, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x03, 
                0x00030D40, 
                0x0708
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x000000001055401C, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x04, 
                0x0007A120, 
                0x03E8
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x05, 
                Zero, 
                Zero
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000010554020, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x06, 
                0x00989680, 
                Zero
            }
        })
        Name (_CSD, Package (0x03)  // _CSD: C-State Dependencies
        {
            Package (0x06)
            {
                0x06, 
                Zero, 
                0x03, 
                0xFC, 
                0x02, 
                0x02
            }, 

            Package (0x06)
            {
                0x06, 
                Zero, 
                0x05, 
                0xFC, 
                0x08, 
                0x03
            }, 

            Package (0x06)
            {
                0x06, 
                Zero, 
                0x06, 
                0xFC, 
                0x08, 
                0x05
            }
        })
    }

    Device (_SB.CPU5)
    {
        Name (_UID, 0x0201)  // _UID: Unique ID
        Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            Return (One)
        }

        Name (_CDM, 0x02)  // _CDM: Clock Domain
        Method (_PSC, 0, NotSerialized)  // _PSC: Power State Current
        {
            Return (Zero)
        }

        Name (_S1D, 0x03)  // _S1D: S1 Device State
        Name (_S2D, 0x04)  // _S2D: S2 Device State
        Name (_S3D, 0x06)  // _S3D: S3 Device State
        Name (_PCT, Package (0x02)  // _PCT: Performance Control
        {
            ResourceTemplate ()
            {
                Register (SystemMemory, 
                    0x20,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000010555000, // Address
                    0x03,               // Access Size
                    )
            }, 

            ResourceTemplate ()
            {
                Register (SystemMemory, 
                    0x20,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000010555004, // Address
                    0x03,               // Access Size
                    )
            }
        })
        Name (_PSS, Package (0x05)  // _PSS: Performance Supported States
        {
            Package (0x06)
            {
                0x0960, 
                0x09C4, 
                0x0A, 
                0x0A, 
                0x10, 
                0x20
            }, 

            Package (0x06)
            {
                0x0960, 
                0x09C4, 
                0x0A, 
                0x0A, 
                0x11, 
                0x21
            }, 

            Package (0x06)
            {
                0x04B0, 
                0x05DC, 
                0x0A, 
                0x0A, 
                0x12, 
                0x22
            }, 

            Package (0x06)
            {
                0x0320, 
                0x03E8, 
                0x0A, 
                0x0A, 
                0x13, 
                0x23
            }, 

            Package (0x06)
            {
                0x0258, 
                0x0320, 
                0x0A, 
                0x0A, 
                0x14, 
                0x24
            }
        })
        Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
        {
            Package (0x05)
            {
                0x05, 
                Zero, 
                0x02, 
                0xFC, 
                0x02
            }
        })
        Name (_CST, Package (0x07)  // _CST: C-States
        {
            0x02, 
            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                One, 
                Zero, 
                0x09C4
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x02, 
                Zero, 
                Zero
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000010555018, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x03, 
                0x00030D40, 
                0x0708
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x000000001055501C, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x04, 
                0x0007A120, 
                0x03E8
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x05, 
                Zero, 
                Zero
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000010555020, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x06, 
                0x00989680, 
                Zero
            }
        })
        Name (_CSD, Package (0x03)  // _CSD: C-State Dependencies
        {
            Package (0x06)
            {
                0x06, 
                Zero, 
                0x03, 
                0xFC, 
                0x02, 
                0x02
            }, 

            Package (0x06)
            {
                0x06, 
                Zero, 
                0x05, 
                0xFC, 
                0x08, 
                0x03
            }, 

            Package (0x06)
            {
                0x06, 
                Zero, 
                0x06, 
                0xFC, 
                0x08, 
                0x05
            }
        })
    }

    Device (_SB.CPU6)
    {
        Name (_UID, 0x0300)  // _UID: Unique ID
        Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            Return (One)
        }

        Name (_CDM, 0x03)  // _CDM: Clock Domain
        Method (_PSC, 0, NotSerialized)  // _PSC: Power State Current
        {
            Return (Zero)
        }

        Name (_S1D, 0x03)  // _S1D: S1 Device State
        Name (_S2D, 0x04)  // _S2D: S2 Device State
        Name (_S3D, 0x06)  // _S3D: S3 Device State
        Name (_PCT, Package (0x02)  // _PCT: Performance Control
        {
            ResourceTemplate ()
            {
                Register (SystemMemory, 
                    0x20,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000010556000, // Address
                    0x03,               // Access Size
                    )
            }, 

            ResourceTemplate ()
            {
                Register (SystemMemory, 
                    0x20,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000010556004, // Address
                    0x03,               // Access Size
                    )
            }
        })
        Name (_PSS, Package (0x05)  // _PSS: Performance Supported States
        {
            Package (0x06)
            {
                0x0960, 
                0x09C4, 
                0x0A, 
                0x0A, 
                0x10, 
                0x20
            }, 

            Package (0x06)
            {
                0x0960, 
                0x09C4, 
                0x0A, 
                0x0A, 
                0x11, 
                0x21
            }, 

            Package (0x06)
            {
                0x04B0, 
                0x05DC, 
                0x0A, 
                0x0A, 
                0x12, 
                0x22
            }, 

            Package (0x06)
            {
                0x0320, 
                0x03E8, 
                0x0A, 
                0x0A, 
                0x13, 
                0x23
            }, 

            Package (0x06)
            {
                0x0258, 
                0x0320, 
                0x0A, 
                0x0A, 
                0x14, 
                0x24
            }
        })
        Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
        {
            Package (0x05)
            {
                0x05, 
                Zero, 
                0x03, 
                0xFC, 
                0x02
            }
        })
        Name (_CST, Package (0x07)  // _CST: C-States
        {
            0x02, 
            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                One, 
                Zero, 
                0x09C4
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x02, 
                Zero, 
                Zero
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000010556018, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x03, 
                0x00030D40, 
                0x0708
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x000000001055601C, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x04, 
                0x0007A120, 
                0x03E8
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x05, 
                Zero, 
                Zero
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000010556020, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x06, 
                0x00989680, 
                Zero
            }
        })
        Name (_CSD, Package (0x03)  // _CSD: C-State Dependencies
        {
            Package (0x06)
            {
                0x06, 
                Zero, 
                0x04, 
                0xFC, 
                0x02, 
                0x02
            }, 

            Package (0x06)
            {
                0x06, 
                Zero, 
                0x05, 
                0xFC, 
                0x08, 
                0x03
            }, 

            Package (0x06)
            {
                0x06, 
                Zero, 
                0x06, 
                0xFC, 
                0x08, 
                0x05
            }
        })
    }

    Device (_SB.CPU7)
    {
        Name (_UID, 0x0301)  // _UID: Unique ID
        Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            Return (One)
        }

        Name (_CDM, 0x03)  // _CDM: Clock Domain
        Method (_PSC, 0, NotSerialized)  // _PSC: Power State Current
        {
            Return (Zero)
        }

        Name (_S1D, 0x03)  // _S1D: S1 Device State
        Name (_S2D, 0x04)  // _S2D: S2 Device State
        Name (_S3D, 0x06)  // _S3D: S3 Device State
        Name (_PCT, Package (0x02)  // _PCT: Performance Control
        {
            ResourceTemplate ()
            {
                Register (SystemMemory, 
                    0x20,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000010557000, // Address
                    0x03,               // Access Size
                    )
            }, 

            ResourceTemplate ()
            {
                Register (SystemMemory, 
                    0x20,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000010557004, // Address
                    0x03,               // Access Size
                    )
            }
        })
        Name (_PSS, Package (0x05)  // _PSS: Performance Supported States
        {
            Package (0x06)
            {
                0x0960, 
                0x09C4, 
                0x0A, 
                0x0A, 
                0x10, 
                0x20
            }, 

            Package (0x06)
            {
                0x0960, 
                0x09C4, 
                0x0A, 
                0x0A, 
                0x11, 
                0x21
            }, 

            Package (0x06)
            {
                0x04B0, 
                0x05DC, 
                0x0A, 
                0x0A, 
                0x12, 
                0x22
            }, 

            Package (0x06)
            {
                0x0320, 
                0x03E8, 
                0x0A, 
                0x0A, 
                0x13, 
                0x23
            }, 

            Package (0x06)
            {
                0x0258, 
                0x0320, 
                0x0A, 
                0x0A, 
                0x14, 
                0x24
            }
        })
        Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
        {
            Package (0x05)
            {
                0x05, 
                Zero, 
                0x03, 
                0xFC, 
                0x02
            }
        })
        Name (_CST, Package (0x07)  // _CST: C-States
        {
            0x02, 
            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                One, 
                Zero, 
                0x09C4
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x02, 
                Zero, 
                Zero
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000010557018, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x03, 
                0x00030D40, 
                0x0708
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x000000001055701C, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x04, 
                0x0007A120, 
                0x03E8
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x05, 
                Zero, 
                Zero
            }, 

            Package (0x04)
            {
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000010557020, // Address
                        0x03,               // Access Size
                        )
                }, 

                0x06, 
                0x00989680, 
                Zero
            }
        })
        Name (_CSD, Package (0x03)  // _CSD: C-State Dependencies
        {
            Package (0x06)
            {
                0x06, 
                Zero, 
                0x04, 
                0xFC, 
                0x02, 
                0x02
            }, 

            Package (0x06)
            {
                0x06, 
                Zero, 
                0x05, 
                0xFC, 
                0x08, 
                0x03
            }, 

            Package (0x06)
            {
                0x06, 
                Zero, 
                0x06, 
                0xFC, 
                0x08, 
                0x05
            }
        })
    }

    Method (DTGP, 5, NotSerialized)
    {
        If (Arg0 == Buffer (0x10)
                {
                    /* 0000 */  0xA7, 0x06, 0xB1, 0x12, 0xBF, 0x0B, 0x48, 0xD2,  /* ......H. */
                    /* 0008 */  0x9F, 0xA3, 0x95, 0x59, 0x1A, 0x3C, 0x4C, 0x06   /* ...Y.<L. */
                })
        {
            If (Arg1 == One)
            {
                If (Arg2 == Zero)
                {
                    Arg4 = Buffer (One)
                        {
                             0x03                                             /* . */
                        }
                    Return (One)
                }

                If (Arg2 == One)
                {
                    Return (One)
                }
            }
        }

        Arg4 = Buffer (One)
            {
                 0x00                                             /* . */
            }
        Return (Zero)
    }

    Device (_SB.SLIM)
    {
        Name (_HID, "APMC0D01")  // _HID: Hardware ID
        Name (_DDN, "SLIM")  // _DDN: DOS Device Name
        Name (_UID, "SLIM")  // _UID: Unique ID
        Name (_STR, Unicode ("SLIMpro Device"))  // _STR: Description String
        Name (_CID, "APMC0D01")  // _CID: Compatible ID
        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            Memory32Fixed (ReadWrite,
                0x10540000,         // Address Base
                0x0000A100,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x17000000,         // Address Base
                0x00001000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x17001000,         // Address Base
                0x00001000,         // Address Length
                )
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000020,
            }
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000021,
            }
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000022,
            }
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000023,
            }
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000024,
            }
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000025,
            }
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000026,
            }
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000027,
            }
        })
        Name (DBST, Zero)
        Name (DBEN, 0x07)
        Name (DBRT, 0x05)
        Name (DBEV, 0x07)
        Name (DBIC, Zero)
    }

    Device (_SB.EMC0)
    {
        Name (_HID, "APMC0D10")  // _HID: Hardware ID
        Name (_DDN, "EMC0")  // _DDN: DOS Device Name
        Name (_UID, "EMC0")  // _UID: Unique ID
        Name (_STR, Unicode ("EDAC MC0 Device"))  // _STR: Description String
        Name (_ADR, 0x7E800000)  // _ADR: Address
        Name (_CID, "APMC0D10")  // _CID: Compatible ID
        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            Memory32Fixed (ReadWrite,
                0x78800000,         // Address Base
                0x00001000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x7E200000,         // Address Base
                0x00001000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x7E700000,         // Address Base
                0x00001000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x7E720000,         // Address Base
                0x00001000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x7E800000,         // Address Base
                0x00001000,         // Address Length
                )
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000040,
            }
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000041,
            }
        })
    }

    Device (_SB.EMC1)
    {
        Name (_HID, "APMC0D10")  // _HID: Hardware ID
        Name (_DDN, "EMC1")  // _DDN: DOS Device Name
        Name (_UID, "EMC1")  // _UID: Unique ID
        Name (_STR, Unicode ("EDAC MC1 Device"))  // _STR: Description String
        Name (_ADR, 0x7E840000)  // _ADR: Address
        Name (_CID, "APMC0D10")  // _CID: Compatible ID
        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            Memory32Fixed (ReadWrite,
                0x78800000,         // Address Base
                0x00001000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x7E200000,         // Address Base
                0x00001000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x7E700000,         // Address Base
                0x00001000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x7E720000,         // Address Base
                0x00001000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x7E840000,         // Address Base
                0x00001000,         // Address Length
                )
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000040,
            }
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000041,
            }
        })
    }

    Device (_SB.EMC2)
    {
        Name (_HID, "APMC0D10")  // _HID: Hardware ID
        Name (_DDN, "EMC2")  // _DDN: DOS Device Name
        Name (_UID, "EMC2")  // _UID: Unique ID
        Name (_STR, Unicode ("EDAC MC2 Device"))  // _STR: Description String
        Name (_ADR, 0x7E880000)  // _ADR: Address
        Name (_CID, "APMC0D10")  // _CID: Compatible ID
        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            Memory32Fixed (ReadWrite,
                0x78800000,         // Address Base
                0x00001000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x7E200000,         // Address Base
                0x00001000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x7E700000,         // Address Base
                0x00001000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x7E720000,         // Address Base
                0x00001000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x7E880000,         // Address Base
                0x00001000,         // Address Length
                )
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000040,
            }
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000041,
            }
        })
    }

    Device (_SB.EMC3)
    {
        Name (_HID, "APMC0D10")  // _HID: Hardware ID
        Name (_DDN, "EMC3")  // _DDN: DOS Device Name
        Name (_UID, "EMC3")  // _UID: Unique ID
        Name (_STR, Unicode ("EDAC MC3 Device"))  // _STR: Description String
        Name (_ADR, 0x7E8C0000)  // _ADR: Address
        Name (_CID, "APMC0D10")  // _CID: Compatible ID
        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            Memory32Fixed (ReadWrite,
                0x78800000,         // Address Base
                0x00001000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x7E200000,         // Address Base
                0x00001000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x7E700000,         // Address Base
                0x00001000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x7E720000,         // Address Base
                0x00001000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x7E8C0000,         // Address Base
                0x00001000,         // Address Length
                )
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000040,
            }
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000041,
            }
        })
    }

    Device (_SB.EL3)
    {
        Name (_HID, "APMC0D11")  // _HID: Hardware ID
        Name (_DDN, "EL3")  // _DDN: DOS Device Name
        Name (_UID, "EL3")  // _UID: Unique ID
        Name (_STR, Unicode ("EDAC L3 Device"))  // _STR: Description String
        Name (_ADR, 0x7E600000)  // _ADR: Address
        Name (_CID, "APMC0D11")  // _CID: Compatible ID
        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            Memory32Fixed (ReadWrite,
                0x78800000,         // Address Base
                0x00001000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x7E600000,         // Address Base
                0x00001000,         // Address Length
                )
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000040,
            }
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000041,
            }
        })
    }

    Device (_SB.PMD0)
    {
        Name (_HID, "APMC0D12")  // _HID: Hardware ID
        Name (_DDN, "PMD0")  // _DDN: DOS Device Name
        Name (_UID, "PMD0")  // _UID: Unique ID
        Name (_STR, Unicode ("EDAC PMD0 Device"))  // _STR: Description String
        Name (_ADR, 0x7C000000)  // _ADR: Address
        Name (_CID, "APMC0D12")  // _CID: Compatible ID
        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            Memory32Fixed (ReadWrite,
                0x78800000,         // Address Base
                0x00001000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x7C000000,         // Address Base
                0x00200000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x1054A000,         // Address Base
                0x00000010,         // Address Length
                )
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000040,
            }
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000041,
            }
        })
    }

    Device (_SB.PMD1)
    {
        Name (_HID, "APMC0D12")  // _HID: Hardware ID
        Name (_DDN, "PMD1")  // _DDN: DOS Device Name
        Name (_UID, "PMD1")  // _UID: Unique ID
        Name (_STR, Unicode ("EDAC PMD1 Device"))  // _STR: Description String
        Name (_ADR, 0x7C200000)  // _ADR: Address
        Name (_CID, "APMC0D12")  // _CID: Compatible ID
        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            Memory32Fixed (ReadWrite,
                0x78800000,         // Address Base
                0x00001000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x7C200000,         // Address Base
                0x00200000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x1054A000,         // Address Base
                0x00000010,         // Address Length
                )
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000040,
            }
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000041,
            }
        })
    }

    Device (_SB.PMD2)
    {
        Name (_HID, "APMC0D12")  // _HID: Hardware ID
        Name (_DDN, "PMD2")  // _DDN: DOS Device Name
        Name (_UID, "PMD2")  // _UID: Unique ID
        Name (_STR, Unicode ("EDAC PMD2 Device"))  // _STR: Description String
        Name (_ADR, 0x7C400000)  // _ADR: Address
        Name (_CID, "APMC0D12")  // _CID: Compatible ID
        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            Memory32Fixed (ReadWrite,
                0x78800000,         // Address Base
                0x00001000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x7C400000,         // Address Base
                0x00200000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x1054A000,         // Address Base
                0x00000010,         // Address Length
                )
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000040,
            }
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000041,
            }
        })
    }

    Device (_SB.PMD3)
    {
        Name (_HID, "APMC0D12")  // _HID: Hardware ID
        Name (_DDN, "PMD3")  // _DDN: DOS Device Name
        Name (_UID, "PMD3")  // _UID: Unique ID
        Name (_STR, Unicode ("EDAC PMD3 Device"))  // _STR: Description String
        Name (_ADR, 0x7C600000)  // _ADR: Address
        Name (_CID, "APMC0D12")  // _CID: Compatible ID
        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            Memory32Fixed (ReadWrite,
                0x78800000,         // Address Base
                0x00001000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x7C600000,         // Address Base
                0x00200000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x1054A000,         // Address Base
                0x00000010,         // Address Length
                )
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000040,
            }
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000041,
            }
        })
    }

    Device (_SB.ESOC)
    {
        Name (_HID, "APMC0D13")  // _HID: Hardware ID
        Name (_DDN, "ESOC")  // _DDN: DOS Device Name
        Name (_UID, "ESOC")  // _UID: Unique ID
        Name (_STR, Unicode ("EDAC SOC Device"))  // _STR: Description String
        Name (_ADR, 0x7E930000)  // _ADR: Address
        Name (_CID, "APMC0D13")  // _CID: Compatible ID
        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            Memory32Fixed (ReadWrite,
                0x78800000,         // Address Base
                0x00001000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x7E930000,         // Address Base
                0x00001000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x7E000000,         // Address Base
                0x00001000,         // Address Length
                )
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000040,
            }
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000041,
            }
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000047,
            }
        })
    }

    Device (_SB.GP00)
    {
        Name (_HID, "APMC0D07")  // _HID: Hardware ID
        Name (_CID, "APMC0D07")  // _CID: Compatible ID
        Name (_UID, "GPIO0")  // _UID: Unique ID
        Name (_STR, Unicode ("GPIO Device"))  // _STR: Description String
        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            Memory32Fixed (ReadWrite,
                0x1C024000,         // Address Base
                0x00001000,         // Address Length
                )
        })
    }

    Device (_SB.GPSB)
    {
        Name (_HID, "APMC0D15")  // _HID: Hardware ID
        Name (_CID, "APMC0D15")  // _CID: Compatible ID
        Name (_UID, "GPIOSB")  // _UID: Unique ID
        Name (_STR, Unicode ("GPIOSB Device"))  // _STR: Description String
        Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
        {
            Local0 = Package (0x06)
                {
                    "ngpio", 
                    "22", 
                    "nirq", 
                    "6", 
                    "irq_pins", 
                    "8 9 10 11 12 13"
                }
            Return (Local0)
        }

        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            Memory32Fixed (ReadWrite,
                0x17001000,         // Address Base
                0x00000400,         // Address Length
                )
            Interrupt (ResourceProducer, Edge, ActiveHigh, Exclusive, ,, )
            {
                0x00000048,
            }
            Interrupt (ResourceProducer, Edge, ActiveHigh, Exclusive, ,, )
            {
                0x00000049,
            }
            Interrupt (ResourceProducer, Edge, ActiveHigh, Exclusive, ,, )
            {
                0x0000004A,
            }
            Interrupt (ResourceProducer, Edge, ActiveHigh, Exclusive, ,, )
            {
                0x0000004B,
            }
            Interrupt (ResourceProducer, Edge, ActiveHigh, Exclusive, ,, )
            {
                0x0000004C,
            }
            Interrupt (ResourceProducer, Edge, ActiveHigh, Exclusive, ,, )
            {
                0x0000004D,
            }
        })
        Name (_AEI, ResourceTemplate ()  // _AEI: ACPI Event Interrupts
        {
            GpioInt (Edge, ActiveHigh, ExclusiveAndWake, PullDown, 0x0000,
                "\\_SB.GPSB", 0x00, ResourceConsumer, ,
                )
                {   // Pin list
                    0x000A
                }
        })
        Method (_EVT, 1, Serialized)  // _EVT: Event
        {
            Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
            While (One)
            {
                _T_0 = ToInteger (Arg0)
                If (_T_0 == 0x0A)
                {
                    Notify (PWRB, 0x80) // Status Change
                }
                Else
                {
                }

                Break
            }
        }
    }

    Device (PWRB)
    {
        Name (_HID, EisaId ("PNP0C0C") /* Power Button Device */)  // _HID: Hardware ID
        Name (_ADR, Zero)  // _ADR: Address
        Name (_UID, Zero)  // _UID: Unique ID
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            Return (0x0F)
        }
    }

    Device (_SB.AHBC)
    {
        OperationRegion (SRST, SystemMemory, 0x1F2AC000, 0x04)
        OperationRegion (CLKE, SystemMemory, 0x1F2AC004, 0x04)
        OperationRegion (SRRM, SystemMemory, 0x1F2AD070, 0x04)
        OperationRegion (RD2F, SystemMemory, 0x1F2AE014, 0x04)
        Field (SRST, DWordAcc, NoLock, Preserve)
        {
            ACSR,   1, 
            SDRS,   1, 
            IORS,   1, 
            U0RS,   1, 
            U1RS,   1, 
            U2RS,   1, 
            U3RS,   1, 
            S0RS,   1, 
            S1RS,   1, 
            APRS,   1
        }

        Field (CLKE, DWordAcc, NoLock, Preserve)
        {
            ACCE,   1, 
            SDCE,   1, 
            IOCE,   1, 
            U0CE,   1, 
            U1CE,   1, 
            U2CE,   1, 
            U3CE,   1, 
            S0CE,   1, 
            S1CE,   1, 
            APCE,   1
        }

        Field (SRRM, DWordAcc, NoLock, Preserve)
        {
            RMSH,   32
        }

        Field (RD2F, DWordAcc, NoLock, Preserve)
        {
            RSV9,   1, 
            RDFL,   1, 
            RSVA,   30
        }

        Name (_HID, "APMC0D06")  // _HID: Hardware ID
        Name (_DDN, "AHBC")  // _DDN: DOS Device Name
        Name (_UID, "AHBC")  // _UID: Unique ID
        Name (_CID, "APMC0D06")  // _CID: Compatible ID
        Name (_STR, Unicode ("AHBC Peripheral Bus"))  // _STR: Description String
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If ((NAnd (ACSR, One) || NAnd (APRS, One)) || (
                (ACCE == Zero) || (APCE == Zero)))
            {
                Return (One)
            }

            Return (0x03)
        }

        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            Memory32Fixed (ReadWrite,
                0x1F2A0000,         // Address Base
                0x00080000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x1C000200,         // Address Base
                0x00000100,         // Address Length
                )
        })
        Device (UAR0)
        {
            Name (_HID, "APMC0D08")  // _HID: Hardware ID
            Name (_DDN, "UAR0")  // _DDN: DOS Device Name
            Name (_UID, "UAR0")  // _UID: Unique ID
            Name (_STR, Unicode ("APM88xxxx UART0 Controller"))  // _STR: Description String
            Name (_ADR, 0x1C021000)  // _ADR: Address
            Name (_CID, "NS16550A")  // _CID: Compatible ID
            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                U1CE = Zero
                U1RS = One
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (NAnd (U1RS, One) || (U1CE == Zero))
                {
                    Return (One)
                }

                Return (0x03)
            }

            Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
            {
                U1CE = One
                U1RS = Zero
            }

            Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
            {
                U1CE = Zero
                U1RS = One
            }

            Method (_PSC, 0, NotSerialized)  // _PSC: Power State Current
            {
                If (NAnd (U1RS, One) || (U1CE == Zero))
                {
                    Return (0x03)
                }

                Return (Zero)
            }

            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                SCVR
            })
            Name (_S1D, 0x03)  // _S1D: S1 Device State
            Name (_S1W, Zero)  // _S1W: S1 Device Wake State
            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                Zero, 
                0x03
            })
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x1C021000,         // Address Base
                    0x00000100,         // Address Length
                    )
                UartSerialBusV2 (0x00002580, DataBitsEight, StopBitsOne,
                    0x00, LittleEndian, ParityTypeNone, FlowControlHardware,
                    0x0010, 0x0010, "UAR0",
                    0x00, ResourceConsumer, , Exclusive,
                    )
                Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x0000006D,
                }
            })
            Method (_DSD, 0, NotSerialized)  // _DSD: Device-Specific Data
            {
                Local0 = Package (0x02)
                    {
                        ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                        Package (0x01)
                        {
                            Package (0x02)
                            {
                                "clock-frequency", 
                                Zero
                            }
                        }
                    }
                DerefOf (DerefOf (Local0 [One]) [Zero]) [One]
                     = UCLK /* External reference */
                Return (Local0)
            }
        }

        Device (^GP01)
        {
            Name (_HID, "APMC0D14")  // _HID: Hardware ID
            Name (_DDN, "GP01")  // _DDN: DOS Device Name
            Name (_UID, "GP01")  // _UID: Unique ID
            Name (_STR, Unicode ("GFC GPIO Device Port"))  // _STR: Description String
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x1701C000,         // Address Base
                    0x00001000,         // Address Length
                    )
            })
        }
    }

    Device (I2C0)
    {
        Name (_HID, "APMC0D0F")  // _HID: Hardware ID
        Name (_CID, "APMC0D0F")  // _CID: Compatible ID
        Name (_UID, One)  // _UID: Unique ID
        Name (_ADR, 0x00150001)  // _ADR: Address
        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            Memory32Fixed (ReadWrite,
                0x10512000,         // Address Base
                0x00010000,         // Address Length
                )
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000064,
            }
        })
        OperationRegion (SMEM, SystemMemory, 0x1051E008, 0x04)
        Field (SMEM, DWordAcc, NoLock, Preserve)
        {
            CLK0,   2
        }

        Method (SPD, 0, NotSerialized)
        {
            CLK0 = 0x000F4240
        }

        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            Return (Zero)
        }
    }

    Device (_SB.I2CS)
    {
        Name (_HID, "APMC0D40")  // _HID: Hardware ID
        Name (_DDN, "I2CS")  // _DDN: DOS Device Name
        Name (_UID, "I2CS")  // _UID: Unique ID
        Name (_STR, Unicode ("SLIMpro IIC1 Serial Bus"))  // _STR: Description String
        Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
        {
            ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
            Package (0x01)
            {
                Package (0x02)
                {
                    "mboxes", 
                    Package (0x02)
                    {
                        SLIM, 
                        Zero
                    }
                }
            }
        })
    }

    Device (_SB.SAT2)
    {
        Name (_HID, "APMC0D0D")  // _HID: Hardware ID
        Name (_UID, 0x03)  // _UID: Unique ID
        Name (_STR, Unicode ("X-Gene SATA"))  // _STR: Description String
        Name (_CCA, One)  // _CCA: Cache Coherency Attribute
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            Return (One)
        }

        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            Memory32Fixed (ReadWrite,
                0x1A800000,         // Address Base
                0x00001000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x1F230000,         // Address Base
                0x00001000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x1F23D000,         // Address Base
                0x00001000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x1F23E000,         // Address Base
                0x00001000,         // Address Length
                )
            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x000000A8,
            }
        })
    }

    Device (_SB.MSIX)
    {
        Name (_HID, "APMC0D0E")  // _HID: Hardware ID
        Name (_UID, Zero)  // _UID: Unique ID
        Name (_STR, Unicode ("X-Gene MSI/MSIX"))  // _STR: Description String
        Name (_CCA, One)  // _CCA: Cache Coherency Attribute
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            Return (One)
        }

        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            Memory32Fixed (ReadWrite,
                0x79000000,         // Address Base
                0x00900000,         // Address Length
                )
            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000030,
            }
            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000031,
            }
            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000032,
            }
            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000033,
            }
            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000034,
            }
            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000035,
            }
            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000036,
            }
            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000037,
            }
            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000038,
            }
            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000039,
            }
            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x0000003A,
            }
            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x0000003B,
            }
            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x0000003C,
            }
            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x0000003D,
            }
            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x0000003E,
            }
            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x0000003F,
            }
        })
        Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
        {
            Local0 = Package (0x02)
                {
                    "msi-available-ranges", 
                    "0x0 0x1000"
                }
            DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
            Return (Local0)
        }
    }

    Device (_SB.PKA)
    {
        Name (_HID, "APMC0D17")  // _HID: Hardware ID
        Name (_UID, Zero)  // _UID: Unique ID
        Name (_STR, Unicode ("X-Gene Pka"))  // _STR: Description String
        Name (_CCA, One)  // _CCA: Cache Coherency Attribute
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            Return (One)
        }

        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            Memory32Fixed (ReadWrite,
                0x10524000,         // Address Base
                0x00004000,         // Address Length
                )
            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000063,
            }
        })
        OperationRegion (RSTQ, SystemMemory, 0x1700000C, 0x04)
        Field (RSTQ, DWordAcc, NoLock, Preserve)
        {
            RSV1,   4, 
            RSTE,   1
        }

        OperationRegion (CLKQ, SystemMemory, 0x17000010, 0x04)
        Field (CLKQ, DWordAcc, NoLock, Preserve)
        {
            RSV2,   4, 
            CLKE,   1
        }

        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            If (!CLKE)
            {
                RSTE = One
                Stall (0x64)
                RSTE = Zero
                Stall (0x64)
                CLKE = One
                Stall (0x64)
            }
        }
    }

    Device (_SB.TRNG)
    {
        Name (_HID, "APMC0D18")  // _HID: Hardware ID
        Name (_UID, Zero)  // _UID: Unique ID
        Name (_STR, Unicode ("X-Gene TRNG"))  // _STR: Description String
        Name (_CCA, One)  // _CCA: Cache Coherency Attribute
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            Return (One)
        }

        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            Memory32Fixed (ReadWrite,
                0x10520000,         // Address Base
                0x00004000,         // Address Length
                )
            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000061,
            }
        })
        OperationRegion (RSTQ, SystemMemory, 0x1700000C, 0x04)
        Field (RSTQ, DWordAcc, NoLock, Preserve)
        {
            RSV1,   4, 
            RSTE,   1
        }

        OperationRegion (CLKQ, SystemMemory, 0x17000010, 0x04)
        Field (CLKQ, DWordAcc, NoLock, Preserve)
        {
            RSV2,   4, 
            CLKE,   1
        }

        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            If (!CLKE)
            {
                RSTE = One
                Stall (0x64)
                RSTE = Zero
                Stall (0x64)
                CLKE = One
                Stall (0x64)
            }
        }
    }

    Device (HED)
    {
        Name (_HID, EisaId ("PNP0C33") /* Error Device */)  // _HID: Hardware ID
        Name (_UID, Zero)  // _UID: Unique ID
    }

    Device (_SB.APEI)
    {
        Name (_HID, "APMC0D50")  // _HID: Hardware ID
        Name (_UID, Zero)  // _UID: Unique ID
        Name (_STR, Unicode ("X-Gene APEI"))  // _STR: Description String
        Name (_CCA, One)  // _CCA: Cache Coherency Attribute
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            Return (One)
        }

        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            Memory32Fixed (ReadWrite,
                0x10546000,         // Address Base
                0x00001000,         // Address Length
                )
            Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x00000026,
            }
        })
        Method (_EVT, 1, Serialized)  // _EVT: Event
        {
            Notify (HED, 0x80) // Status Change
        }
    }
}


--------------7191A5DB7C6FF83551FECDCB--
