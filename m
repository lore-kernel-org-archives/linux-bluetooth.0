Return-Path: <cyrus@holtmann.org>
Message-ID: <5353FDE4.2030207@gmail.com>
Date: Sun, 20 Apr 2014 21:03:32 +0400
From: Dmitry Grebennikov <dmitry.ew@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: bluetooth support of intel 7260ac adapter
Content-Type: multipart/mixed;
 boundary="------------070902060900020100010205"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------070902060900020100010205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Could you help me please to make my intel 7260ac wifi+bt adapter work 
correctly?

I bought it recently and installed in my laptop. Wifi works perfectly 
(iwlwifi + firmware), while bluetooth controller isn't detected with 
lspci, lshw completely.

I found that Tedd Ho-Jeong An released bluetooth firmware for this card.
So I installed linux-firmware-git package, which contain needed 
intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq file.
I wrote to load btusb module in /etc/modules-load/
I don't know how to force btusb driver to load firmware file.
What could be the problem with detection only wireless network 
controller, but not bluetooth?

I attach lspci -v, lshw and dmesg output for completeness.

Thank you in advance.

--------------070902060900020100010205
Content-Type: text/plain; charset=UTF-8;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.txt"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.14.1-1-ARCH (nobody@var-lib-archbuild-testing-x86_64-tobias) (gcc version 4.8.2 20140206 (prerelease) (GCC) ) #1 SMP PREEMPT Mon Apr 14 20:40:47 CEST 2014
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-linux root=UUID=9b8fb112-6e01-4e0d-8884-886569810475 rw quiet nmi_watchdog=0 i915.i915_enable_rc6=7 intel_pstate=disable
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009e7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000201fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000020200000-0x000000003fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000040000000-0x00000000401fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000040200000-0x00000000bad35fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bad36000-0x00000000bad8dfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bad8e000-0x00000000bad9dfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bad9e000-0x00000000bad9ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bada0000-0x00000000bada1fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bada2000-0x00000000badb7fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000badb8000-0x00000000badbdfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000badbe000-0x00000000bade7fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bade8000-0x00000000baf31fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000baf32000-0x00000000bafe7fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bafe8000-0x00000000baffcfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000baffd000-0x00000000baffffff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bb000000-0x00000000bf9fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed10000-0x00000000fed13fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed18000-0x00000000fed19fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff980000-0x00000000ffbfffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffd80000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000023fdfffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: SAMSUNG ELECTRONICS CO., LTD. RF511/RF411/RF711/RF511/RF411/RF711, BIOS 10HX.M034.20110426.SSH 04/26/2011
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] No AGP bridge found
[    0.000000] e820: last_pfn = 0x23fe00 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-E7FFF uncachable
[    0.000000]   E8000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask F80000000 write-back
[    0.000000]   1 base 080000000 mask FC0000000 write-back
[    0.000000]   2 base 0BC000000 mask FFC000000 uncachable
[    0.000000]   3 base 0BB000000 mask FFF000000 uncachable
[    0.000000]   4 base 100000000 mask F00000000 write-back
[    0.000000]   5 base 200000000 mask FC0000000 write-back
[    0.000000]   6 base 23FE00000 mask FFFE00000 uncachable
[    0.000000]   7 base 0FFC00000 mask FFFC00000 write-protect
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] e820: last_pfn = 0xbaffd max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000fccc0-0x000fcccf] mapped at [ffff8800000fccc0]
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
[    0.000000] reserving inaccessible SNB gfx pages
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x01b28000, 0x01b28fff] PGTABLE
[    0.000000] BRK [0x01b29000, 0x01b29fff] PGTABLE
[    0.000000] BRK [0x01b2a000, 0x01b2afff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x23fc00000-0x23fdfffff]
[    0.000000]  [mem 0x23fc00000-0x23fdfffff] page 2M
[    0.000000] BRK [0x01b2b000, 0x01b2bfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x23c000000-0x23fbfffff]
[    0.000000]  [mem 0x23c000000-0x23fbfffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x200000000-0x23bffffff]
[    0.000000]  [mem 0x200000000-0x23bffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0x1fffffff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x1fffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x20200000-0x3fffffff]
[    0.000000]  [mem 0x20200000-0x3fffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x40200000-0xbad35fff]
[    0.000000]  [mem 0x40200000-0xbabfffff] page 2M
[    0.000000]  [mem 0xbac00000-0xbad35fff] page 4k
[    0.000000] BRK [0x01b2c000, 0x01b2cfff] PGTABLE
[    0.000000] BRK [0x01b2d000, 0x01b2dfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0xbad8e000-0xbad9dfff]
[    0.000000]  [mem 0xbad8e000-0xbad9dfff] page 4k
[    0.000000] init_memory_mapping: [mem 0xbada0000-0xbada1fff]
[    0.000000]  [mem 0xbada0000-0xbada1fff] page 4k
[    0.000000] init_memory_mapping: [mem 0xbadb8000-0xbadbdfff]
[    0.000000]  [mem 0xbadb8000-0xbadbdfff] page 4k
[    0.000000] init_memory_mapping: [mem 0xbade8000-0xbaf31fff]
[    0.000000]  [mem 0xbade8000-0xbaf31fff] page 4k
[    0.000000] init_memory_mapping: [mem 0xbafe8000-0xbaffcfff]
[    0.000000]  [mem 0xbafe8000-0xbaffcfff] page 4k
[    0.000000] init_memory_mapping: [mem 0x100000000-0x1ffffffff]
[    0.000000]  [mem 0x100000000-0x1ffffffff] page 2M
[    0.000000] RAMDISK: [mem 0x379e0000-0x37ce7fff]
[    0.000000] ACPI: RSDP 00000000000f0430 000024 (v02 SECCSD)
[    0.000000] ACPI: XSDT 00000000baffee18 00006C (v01 SECCSD LH43STAR 06222004 MSFT 00010013)
[    0.000000] ACPI: FACP 00000000baf9bd98 0000F4 (v04 SECCSD LH43STAR 06222004 MSFT 00010013)
[    0.000000] ACPI BIOS Warning (bug): 32/64X FACS address mismatch in FADT: 0xBAFE5E40/0x00000000BAFE5D40, using 64-bit address (20131218/tbfadt-271)
[    0.000000] ACPI: DSDT 00000000baf92018 00855D (v01 SECCSD LH43STAR 00000000 INTL 20091112)
[    0.000000] ACPI: FACS 00000000bafe5d40 000040
[    0.000000] ACPI: APIC 00000000baffdf18 0000CC (v02 SECCSD LH43STAR 06222004 MSFT 00010013)
[    0.000000] ACPI: HPET 00000000bafe6d18 000038 (v01 SECCSD LH43STAR 06222004 AMI. 00000003)
[    0.000000] ACPI: SLIC 00000000baf9cc18 000176 (v01 SECCSD LH43STAR 06222004 AMI  00010013)
[    0.000000] ACPI: MCFG 00000000bafe6c98 00003C (v01 SECCSD LH43STAR 06222004 MSFT 00000097)
[    0.000000] ACPI: SSDT 00000000baf91018 000891 (v01  PmRef  Cpu0Ist 00003000 INTL 20091112)
[    0.000000] ACPI: SSDT 00000000baf90018 000996 (v01  PmRef    CpuPm 00003000 INTL 20091112)
[    0.000000] ACPI: SSDT 00000000baf8c018 000D80 (v01  SgRef   SgTabl 00001000 INTL 20091112)
[    0.000000] ACPI: SSDT 00000000baf79018 0011E8 (v01 OptRef  OptTabl 00001000 INTL 20091112)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000023fdfffff]
[    0.000000] Initmem setup node 0 [mem 0x00000000-0x23fdfffff]
[    0.000000]   NODE_DATA [mem 0x23fdf5000-0x23fdf9fff]
[    0.000000]  [ffffea0000000000-ffffea0008ffffff] PMD -> [ffff880237400000-ffff88023f3fffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x23fdfffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0009dfff]
[    0.000000]   node   0: [mem 0x00100000-0x1fffffff]
[    0.000000]   node   0: [mem 0x20200000-0x3fffffff]
[    0.000000]   node   0: [mem 0x40200000-0xbad35fff]
[    0.000000]   node   0: [mem 0xbad8e000-0xbad9dfff]
[    0.000000]   node   0: [mem 0xbada0000-0xbada1fff]
[    0.000000]   node   0: [mem 0xbadb8000-0xbadbdfff]
[    0.000000]   node   0: [mem 0xbade8000-0xbaf31fff]
[    0.000000]   node   0: [mem 0xbafe8000-0xbaffcfff]
[    0.000000]   node   0: [mem 0x100000000-0x23fdfffff]
[    0.000000] On node 0 totalpages: 2074698
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 157 pages reserved
[    0.000000]   DMA zone: 3997 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 11883 pages used for memmap
[    0.000000]   DMA32 zone: 760493 pages, LIFO batch:31
[    0.000000]   Normal zone: 20472 pages used for memmap
[    0.000000]   Normal zone: 1310208 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x04] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x05] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x06] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x07] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x09] lapic_id[0x08] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x09] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x0a] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x0b] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x0c] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x0d] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x0e] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x10] lapic_id[0x0f] disabled)
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 16 CPUs, 12 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009efff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x20000000-0x201fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x40000000-0x401fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xbad36000-0xbad8dfff]
[    0.000000] PM: Registered nosave memory: [mem 0xbad9e000-0xbad9ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xbada2000-0xbadb7fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbadbe000-0xbade7fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbaf32000-0xbafe7fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbaffd000-0xbaffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xbb000000-0xbf9fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xbfa00000-0xf7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfc000000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfed0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed10000-0xfed13fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed14000-0xfed17fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed18000-0xfed19fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1a000-0xfed1bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed20000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xff97ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff980000-0xffbfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xffc00000-0xffd7ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xffd80000-0xffffffff]
[    0.000000] e820: [mem 0xbfa00000-0xf7ffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:128 nr_cpumask_bits:128 nr_cpu_ids:16 nr_node_ids:1
[    0.000000] PERCPU: Embedded 28 pages/cpu @ffff88023fa00000 s86016 r8192 d20480 u131072
[    0.000000] pcpu-alloc: s86016 r8192 d20480 u131072 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 2042122
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-linux root=UUID=9b8fb112-6e01-4e0d-8884-886569810475 rw quiet nmi_watchdog=0 i915.i915_enable_rc6=7 intel_pstate=disable
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 8084396K/8298792K available (5020K kernel code, 802K rwdata, 1612K rodata, 1112K init, 1284K bss, 214396K reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] 	Dump stacks of tasks blocking RCU-preempt GP.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=128 to nr_cpu_ids=16.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.000000] NR_IRQS:8448 nr_irqs:808 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 33554432 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2294.774 MHz processor
[    0.000037] Calibrating delay loop (skipped), value calculated using timer frequency.. 4591.77 BogoMIPS (lpj=7649246)
[    0.000039] pid_max: default: 32768 minimum: 301
[    0.000047] ACPI: Core revision 20131218
[    0.006006] ACPI: All ACPI Tables successfully acquired
[    0.010294] Security Framework initialized
[    0.010299] Yama: becoming mindful.
[    0.010850] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.012555] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.013312] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.013323] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.013523] Initializing cgroup subsys memory
[    0.013528] Initializing cgroup subsys devices
[    0.013529] Initializing cgroup subsys freezer
[    0.013531] Initializing cgroup subsys net_cls
[    0.013532] Initializing cgroup subsys blkio
[    0.013557] CPU: Physical Processor ID: 0
[    0.013558] CPU: Processor Core ID: 0
[    0.013562] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.013566] mce: CPU supports 7 MCE banks
[    0.013577] CPU0: Thermal monitoring enabled (TM1)
[    0.013585] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
tlb_flushall_shift: 6
[    0.013684] Freeing SMP alternatives memory: 20K (ffffffff819e0000 - ffffffff819e5000)
[    0.014979] ftrace: allocating 19978 entries in 79 pages
[    0.025341] Switched APIC routing to physical flat.
[    0.025758] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.058745] smpboot: CPU0: Intel(R) Core(TM) i5-2410M CPU @ 2.30GHz (fam: 06, model: 2a, stepping: 07)
[    0.058752] TSC deadline timer enabled
[    0.058765] Performance Events: PEBS fmt1+, 16-deep LBR, SandyBridge events, full-width counters, Intel PMU driver.
[    0.058772] perf_event_intel: PEBS disabled due to CPU errata, please upgrade microcode
[    0.058774] ... version:                3
[    0.058775] ... bit width:              48
[    0.058776] ... generic registers:      4
[    0.058777] ... value mask:             0000ffffffffffff
[    0.058778] ... max period:             0000ffffffffffff
[    0.058779] ... fixed-purpose events:   3
[    0.058780] ... event mask:             000000070000000f
[    0.078895] x86: Booting SMP configuration:
[    0.078906] .... node  #0, CPUs:        #1  #2  #3
[    0.132190] x86: Booted up 1 node, 4 CPUs
[    0.132193] smpboot: Total of 4 processors activated (18365.11 BogoMIPS)
[    0.135627] devtmpfs: initialized
[    0.140015] PM: Registering ACPI NVS region [mem 0xbaf32000-0xbafe7fff] (745472 bytes)
[    0.140890] pinctrl core: initialized pinctrl subsystem
[    0.140929] RTC time: 14:06:52, date: 04/19/14
[    0.140966] NET: Registered protocol family 16
[    0.141052] cpuidle: using governor ladder
[    0.141053] cpuidle: using governor menu
[    0.141071] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.141072] ACPI: bus type PCI registered
[    0.141074] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.141144] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.141146] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.149359] PCI: Using configuration type 1 for base access
[    0.149582] mtrr: your CPUs had inconsistent variable MTRR settings
[    0.149583] mtrr: probably your BIOS does not setup all CPUs.
[    0.149584] mtrr: corrected configuration.
[    0.150120] bio: create slab <bio-0> at 0
[    0.150220] ACPI: Added _OSI(Module Device)
[    0.150221] ACPI: Added _OSI(Processor Device)
[    0.150222] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.150224] ACPI: Added _OSI(Processor Aggregator Device)
[    0.153068] ACPI: Executed 1 blocks of module-level executable AML code
[    0.192244] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.194769] ACPI: SSDT 00000000badd3718 000661 (v01  PmRef  Cpu0Cst 00003001 INTL 20091112)
[    0.195142] ACPI: Dynamic OEM Table Load:
[    0.195144] ACPI: SSDT           (null) 000661 (v01  PmRef  Cpu0Cst 00003001 INTL 20091112)
[    0.202474] ACPI: SSDT 00000000badd4a98 000303 (v01  PmRef    ApIst 00003000 INTL 20091112)
[    0.202868] ACPI: Dynamic OEM Table Load:
[    0.202870] ACPI: SSDT           (null) 000303 (v01  PmRef    ApIst 00003000 INTL 20091112)
[    0.212355] ACPI: SSDT 00000000badd2d98 000119 (v01  PmRef    ApCst 00003000 INTL 20091112)
[    0.212715] ACPI: Dynamic OEM Table Load:
[    0.212717] ACPI: SSDT           (null) 000119 (v01  PmRef    ApCst 00003000 INTL 20091112)
[    0.646949] ACPI: Interpreter enabled
[    0.646961] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20131218/hwxface-580)
[    0.646975] ACPI: (supports S0 S1 S3 S4 S5)
[    0.646976] ACPI: Using IOAPIC for interrupt routing
[    0.647005] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.647170] ACPI: No dock devices found.
[    0.662668] ACPI: Power Resource [FN00] (off)
[    0.662754] ACPI: Power Resource [FN01] (off)
[    0.663099] ACPI: \_PR_.CPU4: failed to get CPU APIC ID.
[    0.663103] ACPI: \_PR_.CPU5: failed to get CPU APIC ID.
[    0.663106] ACPI: \_PR_.CPU6: failed to get CPU APIC ID.
[    0.663109] ACPI: \_PR_.CPU7: failed to get CPU APIC ID.
[    0.663314] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.663319] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.663352] \_SB_.PCI0:_OSC invalid UUID
[    0.663354] _OSC request data:1 1f 0 
[    0.663357] acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
[    0.663919] PCI host bridge to bus 0000:00
[    0.663922] pci_bus 0000:00: root bus resource [bus 00-3e]
[    0.663924] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    0.663926] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.663928] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    0.663930] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff]
[    0.663932] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff]
[    0.663933] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff]
[    0.663935] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff]
[    0.663937] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff]
[    0.663938] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff]
[    0.663940] pci_bus 0000:00: root bus resource [mem 0xbfa00000-0xfeafffff]
[    0.663948] pci 0000:00:00.0: [8086:0104] type 00 class 0x060000
[    0.664037] pci 0000:00:01.0: [8086:0101] type 01 class 0x060400
[    0.664071] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.664147] pci 0000:00:02.0: [8086:0116] type 00 class 0x030000
[    0.664158] pci 0000:00:02.0: reg 0x10: [mem 0xf5400000-0xf57fffff 64bit]
[    0.664164] pci 0000:00:02.0: reg 0x18: [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.664169] pci 0000:00:02.0: reg 0x20: [io  0xe000-0xe03f]
[    0.664275] pci 0000:00:16.0: [8086:1c3a] type 00 class 0x078000
[    0.664300] pci 0000:00:16.0: reg 0x10: [mem 0xf760a000-0xf760a00f 64bit]
[    0.664378] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.664467] pci 0000:00:1a.0: [8086:1c2d] type 00 class 0x0c0320
[    0.664489] pci 0000:00:1a.0: reg 0x10: [mem 0xf7608000-0xf76083ff]
[    0.664582] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.664665] pci 0000:00:1b.0: [8086:1c20] type 00 class 0x040300
[    0.664682] pci 0000:00:1b.0: reg 0x10: [mem 0xf7600000-0xf7603fff 64bit]
[    0.664758] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.664837] pci 0000:00:1c.0: [8086:1c10] type 01 class 0x060400
[    0.664920] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.664966] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    0.665008] pci 0000:00:1c.3: [8086:1c16] type 01 class 0x060400
[    0.665090] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.665137] pci 0000:00:1c.3: System wakeup disabled by ACPI
[    0.665176] pci 0000:00:1c.4: [8086:1c18] type 01 class 0x060400
[    0.665258] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.665345] pci 0000:00:1d.0: [8086:1c26] type 00 class 0x0c0320
[    0.665368] pci 0000:00:1d.0: reg 0x10: [mem 0xf7607000-0xf76073ff]
[    0.665461] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.665541] pci 0000:00:1f.0: [8086:1c49] type 00 class 0x060100
[    0.665723] pci 0000:00:1f.2: [8086:1c03] type 00 class 0x010601
[    0.665744] pci 0000:00:1f.2: reg 0x10: [io  0xe0b0-0xe0b7]
[    0.665753] pci 0000:00:1f.2: reg 0x14: [io  0xe0a0-0xe0a3]
[    0.665761] pci 0000:00:1f.2: reg 0x18: [io  0xe090-0xe097]
[    0.665770] pci 0000:00:1f.2: reg 0x1c: [io  0xe080-0xe083]
[    0.665778] pci 0000:00:1f.2: reg 0x20: [io  0xe060-0xe07f]
[    0.665787] pci 0000:00:1f.2: reg 0x24: [mem 0xf7606000-0xf76067ff]
[    0.665834] pci 0000:00:1f.2: PME# supported from D3hot
[    0.665908] pci 0000:00:1f.3: [8086:1c22] type 00 class 0x0c0500
[    0.665925] pci 0000:00:1f.3: reg 0x10: [mem 0xf7605000-0xf76050ff 64bit]
[    0.665947] pci 0000:00:1f.3: reg 0x20: [io  0xe040-0xe05f]
[    0.666080] pci 0000:01:00.0: [10de:0df4] type 00 class 0x030200
[    0.666089] pci 0000:01:00.0: reg 0x10: [mem 0xf4000000-0xf4ffffff]
[    0.666098] pci 0000:01:00.0: reg 0x14: [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.666107] pci 0000:01:00.0: reg 0x1c: [mem 0xe0000000-0xe1ffffff 64bit pref]
[    0.666113] pci 0000:01:00.0: reg 0x24: [io  0xd000-0xd07f]
[    0.666119] pci 0000:01:00.0: reg 0x30: [mem 0xf5000000-0xf507ffff pref]
[    0.672357] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.672365] pci 0000:00:01.0:   bridge window [io  0xd000-0xdfff]
[    0.672372] pci 0000:00:01.0:   bridge window [mem 0xf4000000-0xf50fffff]
[    0.672382] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xe1ffffff 64bit pref]
[    0.672569] pci 0000:02:00.0: [8086:08b1] type 00 class 0x028000
[    0.672717] pci 0000:02:00.0: reg 0x10: [mem 0xf6c00000-0xf6c01fff 64bit]
[    0.673022] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.679082] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.679092] pci 0000:00:1c.0:   bridge window [io  0xc000-0xcfff]
[    0.679102] pci 0000:00:1c.0:   bridge window [mem 0xf6c00000-0xf75fffff]
[    0.679117] pci 0000:00:1c.0:   bridge window [mem 0xe3700000-0xe40fffff 64bit pref]
[    0.679285] pci 0000:03:00.0: [10ec:8168] type 00 class 0x020000
[    0.679354] pci 0000:03:00.0: reg 0x10: [io  0xb000-0xb0ff]
[    0.679475] pci 0000:03:00.0: reg 0x18: [mem 0xe2c04000-0xe2c04fff 64bit pref]
[    0.679545] pci 0000:03:00.0: reg 0x20: [mem 0xe2c00000-0xe2c03fff 64bit pref]
[    0.679948] pci 0000:03:00.0: supports D1 D2
[    0.679950] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.685729] pci 0000:00:1c.3: PCI bridge to [bus 03]
[    0.685739] pci 0000:00:1c.3:   bridge window [io  0xb000-0xbfff]
[    0.685749] pci 0000:00:1c.3:   bridge window [mem 0xf6200000-0xf6bfffff]
[    0.685763] pci 0000:00:1c.3:   bridge window [mem 0xe2c00000-0xe35fffff 64bit pref]
[    0.685886] pci 0000:04:00.0: [1033:0194] type 00 class 0x0c0330
[    0.685914] pci 0000:04:00.0: reg 0x10: [mem 0xf5800000-0xf5801fff 64bit]
[    0.686063] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    0.692374] pci 0000:00:1c.4: PCI bridge to [bus 04]
[    0.692384] pci 0000:00:1c.4:   bridge window [io  0xa000-0xafff]
[    0.692394] pci 0000:00:1c.4:   bridge window [mem 0xf5800000-0xf61fffff]
[    0.692408] pci 0000:00:1c.4:   bridge window [mem 0xe2100000-0xe2afffff 64bit pref]
[    0.692656] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 10 *11 12 14 15)
[    0.692709] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 *10 11 12 14 15)
[    0.692757] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 10 *11 12 14 15)
[    0.692804] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 10 11 12 14 15)
[    0.692851] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.692899] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.692949] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 *3 4 5 6 10 11 12 14 15)
[    0.692996] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 *4 5 6 10 11 12 14 15)
[    0.693496] ACPI: Enabled 6 GPEs in block 00 to 3F
[    0.693538] ACPI : EC: GPE = 0x17, I/O: command/status = 0x66, data = 0x62
[    0.696745] ACPI : EC: 0 stale EC events cleared
[    0.696889] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.696892] vgaarb: loaded
[    0.696893] vgaarb: bridge control possible 0000:00:02.0
[    0.696913] PCI: Using ACPI for IRQ routing
[    0.698471] PCI: pci_cache_line_size set to 64 bytes
[    0.698556] e820: reserve RAM buffer [mem 0x0009e800-0x0009ffff]
[    0.698558] e820: reserve RAM buffer [mem 0xbad36000-0xbbffffff]
[    0.698560] e820: reserve RAM buffer [mem 0xbad9e000-0xbbffffff]
[    0.698562] e820: reserve RAM buffer [mem 0xbada2000-0xbbffffff]
[    0.698564] e820: reserve RAM buffer [mem 0xbadbe000-0xbbffffff]
[    0.698566] e820: reserve RAM buffer [mem 0xbaf32000-0xbbffffff]
[    0.698567] e820: reserve RAM buffer [mem 0xbaffd000-0xbbffffff]
[    0.698569] e820: reserve RAM buffer [mem 0x23fe00000-0x23fffffff]
[    0.698660] NetLabel: Initializing
[    0.698662] NetLabel:  domain hash size = 128
[    0.698662] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.698675] NetLabel:  unlabeled traffic allowed by default
[    0.698697] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.698703] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.701730] Switched to clocksource hpet
[    0.706216] pnp: PnP ACPI init
[    0.706231] ACPI: bus type PNP registered
[    0.706301] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.706375] system 00:01: [io  0x06a4] has been reserved
[    0.706377] system 00:01: [io  0x06a0] has been reserved
[    0.706380] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.706390] pnp 00:02: [dma 4]
[    0.706411] pnp 00:02: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.706435] pnp 00:03: Plug and Play ACPI device, IDs INT0800 (active)
[    0.706535] pnp 00:04: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.706565] pnp 00:05: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.706606] system 00:06: [io  0x0680-0x069f] has been reserved
[    0.706608] system 00:06: [io  0x1000-0x100f] has been reserved
[    0.706610] system 00:06: [io  0xffff] has been reserved
[    0.706612] system 00:06: [io  0xffff] has been reserved
[    0.706614] system 00:06: [io  0x0400-0x0453] could not be reserved
[    0.706616] system 00:06: [io  0x0458-0x047f] has been reserved
[    0.706618] system 00:06: [io  0x0500-0x057f] has been reserved
[    0.706620] system 00:06: [io  0x0a00-0x0a03] has been reserved
[    0.706622] system 00:06: [io  0x164e-0x164f] has been reserved
[    0.706624] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.706669] pnp 00:07: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.706710] system 00:08: [io  0x0454-0x0457] has been reserved
[    0.706713] system 00:08: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    0.706761] pnp 00:09: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.706809] pnp 00:0a: Plug and Play ACPI device, IDs ETD0b00 SYN0002 PNP0f13 (active)
[    0.707018] system 00:0b: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.707021] system 00:0b: [mem 0xfed10000-0xfed17fff] could not be reserved
[    0.707023] system 00:0b: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.707025] system 00:0b: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.707027] system 00:0b: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.707029] system 00:0b: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.707031] system 00:0b: [mem 0xfed90000-0xfed93fff] has been reserved
[    0.707033] system 00:0b: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.707035] system 00:0b: [mem 0xff000000-0xffffffff] could not be reserved
[    0.707037] system 00:0b: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.707039] system 00:0b: [mem 0xbfa00000-0xbfa00fff] has been reserved
[    0.707042] system 00:0b: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.711788] system 00:0c: [mem 0x20000000-0x201fffff] has been reserved
[    0.711790] system 00:0c: [mem 0x40000000-0x401fffff] has been reserved
[    0.711792] system 00:0c: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.711803] pnp: PnP ACPI: found 13 devices
[    0.711805] ACPI: bus type PNP unregistered
[    0.718291] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.718295] pci 0000:00:01.0:   bridge window [io  0xd000-0xdfff]
[    0.718298] pci 0000:00:01.0:   bridge window [mem 0xf4000000-0xf50fffff]
[    0.718301] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xe1ffffff 64bit pref]
[    0.718305] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.718308] pci 0000:00:1c.0:   bridge window [io  0xc000-0xcfff]
[    0.718313] pci 0000:00:1c.0:   bridge window [mem 0xf6c00000-0xf75fffff]
[    0.718318] pci 0000:00:1c.0:   bridge window [mem 0xe3700000-0xe40fffff 64bit pref]
[    0.718324] pci 0000:00:1c.3: PCI bridge to [bus 03]
[    0.718328] pci 0000:00:1c.3:   bridge window [io  0xb000-0xbfff]
[    0.718333] pci 0000:00:1c.3:   bridge window [mem 0xf6200000-0xf6bfffff]
[    0.718338] pci 0000:00:1c.3:   bridge window [mem 0xe2c00000-0xe35fffff 64bit pref]
[    0.718344] pci 0000:00:1c.4: PCI bridge to [bus 04]
[    0.718347] pci 0000:00:1c.4:   bridge window [io  0xa000-0xafff]
[    0.718353] pci 0000:00:1c.4:   bridge window [mem 0xf5800000-0xf61fffff]
[    0.718357] pci 0000:00:1c.4:   bridge window [mem 0xe2100000-0xe2afffff 64bit pref]
[    0.718365] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.718367] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.718368] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.718370] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000d3fff]
[    0.718372] pci_bus 0000:00: resource 8 [mem 0x000d4000-0x000d7fff]
[    0.718374] pci_bus 0000:00: resource 9 [mem 0x000d8000-0x000dbfff]
[    0.718376] pci_bus 0000:00: resource 10 [mem 0x000dc000-0x000dffff]
[    0.718377] pci_bus 0000:00: resource 11 [mem 0x000e0000-0x000e3fff]
[    0.718379] pci_bus 0000:00: resource 12 [mem 0x000e4000-0x000e7fff]
[    0.718381] pci_bus 0000:00: resource 13 [mem 0xbfa00000-0xfeafffff]
[    0.718383] pci_bus 0000:01: resource 0 [io  0xd000-0xdfff]
[    0.718391] pci_bus 0000:01: resource 1 [mem 0xf4000000-0xf50fffff]
[    0.718393] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xe1ffffff 64bit pref]
[    0.718395] pci_bus 0000:02: resource 0 [io  0xc000-0xcfff]
[    0.718396] pci_bus 0000:02: resource 1 [mem 0xf6c00000-0xf75fffff]
[    0.718398] pci_bus 0000:02: resource 2 [mem 0xe3700000-0xe40fffff 64bit pref]
[    0.718400] pci_bus 0000:03: resource 0 [io  0xb000-0xbfff]
[    0.718402] pci_bus 0000:03: resource 1 [mem 0xf6200000-0xf6bfffff]
[    0.718404] pci_bus 0000:03: resource 2 [mem 0xe2c00000-0xe35fffff 64bit pref]
[    0.718405] pci_bus 0000:04: resource 0 [io  0xa000-0xafff]
[    0.718407] pci_bus 0000:04: resource 1 [mem 0xf5800000-0xf61fffff]
[    0.718409] pci_bus 0000:04: resource 2 [mem 0xe2100000-0xe2afffff 64bit pref]
[    0.718434] NET: Registered protocol family 2
[    0.718601] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    0.718763] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.718890] TCP: Hash tables configured (established 65536 bind 65536)
[    0.718913] TCP: reno registered
[    0.718925] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.718958] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.719045] NET: Registered protocol family 1
[    0.719058] pci 0000:00:02.0: Boot video device
[    0.719544] PCI: CLS 64 bytes, default 64
[    0.719588] Unpacking initramfs...
[    0.775640] Freeing initrd memory: 3104K (ffff8800379e0000 - ffff880037ce8000)
[    0.775645] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.775648] software IO TLB [mem 0xb6d36000-0xbad36000] (64MB) mapped at [ffff8800b6d36000-ffff8800bad35fff]
[    0.775856] RAPL PMU detected, hw unit 2^-16 Joules, API unit is 2^-32 Joules, 3 fixed counters 163840 ms ovfl timer
[    0.775891] Scanning for low memory corruption every 60 seconds
[    0.776267] futex hash table entries: 4096 (order: 6, 262144 bytes)
[    0.788274] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.789587] zbud: loaded
[    0.789733] VFS: Disk quotas dquot_6.5.2
[    0.789782] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.789909] msgmni has been set to 15795
[    0.789961] Key type big_key registered
[    0.790133] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    0.790168] io scheduler noop registered
[    0.790171] io scheduler deadline registered
[    0.790201] io scheduler cfq registered (default)
[    0.790358] pcieport 0000:00:01.0: irq 40 for MSI/MSI-X
[    0.790670] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.790684] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.790710] vesafb: mode is 1024x768x32, linelength=4096, pages=0
[    0.790711] vesafb: scrolling: redraw
[    0.790713] vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.791130] vesafb: framebuffer at 0xc0000000, mapped to 0xffffc90004f00000, using 3072k, total 3072k
[    0.847193] Console: switching to colour frame buffer device 128x48
[    0.903194] fb0: VESA VGA frame buffer device
[    0.903209] intel_idle: MWAIT substates: 0x21120
[    0.903211] intel_idle: v0.4 model 0x2A
[    0.903212] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.903379] GHES: HEST is not enabled!
[    0.903426] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.903834] Linux agpgart interface v0.103
[    0.904000] rtc_cmos 00:07: rtc core: registered rtc_cmos as rtc0
[    0.904031] rtc_cmos 00:07: alarms up to one year, y3k, 242 bytes nvram, hpet irqs
[    0.904044] ledtrig-cpu: registered to indicate activity on CPUs
[    0.904166] TCP: cubic registered
[    0.904262] NET: Registered protocol family 10
[    0.904453] NET: Registered protocol family 17
[    0.904690] registered taskstats version 1
[    0.905255]   Magic number: 10:962:131
[    0.905285] acpi device:06: hash matches
[    0.905334] rtc_cmos 00:07: setting system clock to 2014-04-19 14:06:52 UTC (1397916412)
[    0.905416] PM: Hibernation image not present or could not be loaded.
[    0.906515] Freeing unused kernel memory: 1112K (ffffffff818ca000 - ffffffff819e0000)
[    0.906517] Write protecting the kernel read-only data: 8192k
[    0.909266] Freeing unused kernel memory: 1112K (ffff8800014ea000 - ffff880001600000)
[    0.910346] Freeing unused kernel memory: 436K (ffff880001793000 - ffff880001800000)
[    0.916907] random: systemd-tmpfile urandom read with 2 bits of entropy available
[    0.918200] systemd-udevd[53]: starting version 212
[    0.932716] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PSM1] at 0x60,0x64 irq 1,12
[    0.935827] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.935843] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.939694] ACPI: bus type USB registered
[    0.939720] usbcore: registered new interface driver usbfs
[    0.939731] usbcore: registered new interface driver hub
[    0.939810] usbcore: registered new device driver usb
[    0.940144] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.940287] ehci-pci: EHCI PCI platform driver
[    0.940426] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    0.940433] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    0.940447] ehci-pci 0000:00:1a.0: debug port 2
[    0.941430] SCSI subsystem initialized
[    0.942724] libata version 3.00 loaded.
[    0.944344] ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
[    0.944362] ehci-pci 0000:00:1a.0: irq 16, io mem 0xf7608000
[    0.951625] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    0.951841] hub 1-0:1.0: USB hub found
[    0.951848] hub 1-0:1.0: 2 ports detected
[    0.951963] xhci_hcd 0000:04:00.0: xHCI Host Controller
[    0.951973] xhci_hcd 0000:04:00.0: new USB bus registered, assigned bus number 2
[    0.952189] xhci_hcd 0000:04:00.0: irq 41 for MSI/MSI-X
[    0.952200] xhci_hcd 0000:04:00.0: irq 42 for MSI/MSI-X
[    0.952208] xhci_hcd 0000:04:00.0: irq 43 for MSI/MSI-X
[    0.952217] xhci_hcd 0000:04:00.0: irq 44 for MSI/MSI-X
[    0.952226] xhci_hcd 0000:04:00.0: irq 45 for MSI/MSI-X
[    0.952524] hub 2-0:1.0: USB hub found
[    0.952535] hub 2-0:1.0: 2 ports detected
[    0.952623] xhci_hcd 0000:04:00.0: xHCI Host Controller
[    0.952628] xhci_hcd 0000:04:00.0: new USB bus registered, assigned bus number 3
[    0.952630] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    0.952640] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 4
[    0.952811] ehci-pci 0000:00:1d.0: debug port 2
[    0.955749] hub 3-0:1.0: USB hub found
[    0.955763] hub 3-0:1.0: 2 ports detected
[    0.956729] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
[    0.956750] ehci-pci 0000:00:1d.0: irq 23, io mem 0xf7607000
[    0.961283] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    0.966283] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    0.966474] hub 4-0:1.0: USB hub found
[    0.966485] hub 4-0:1.0: 2 ports detected
[    0.966629] ahci 0000:00:1f.2: version 3.0
[    0.966802] ahci 0000:00:1f.2: irq 46 for MSI/MSI-X
[    0.966858] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x1 impl SATA mode
[    0.966863] ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part ems apst 
[    0.967813] scsi0 : ahci
[    0.967935] scsi1 : ahci
[    0.968044] scsi2 : ahci
[    0.968146] scsi3 : ahci
[    0.968246] scsi4 : ahci
[    0.968412] scsi5 : ahci
[    0.968459] ata1: SATA max UDMA/133 abar m2048@0xf7606000 port 0xf7606100 irq 46
[    0.968461] ata2: DUMMY
[    0.968462] ata3: DUMMY
[    0.968463] ata4: DUMMY
[    0.968464] ata5: DUMMY
[    0.968465] ata6: DUMMY
[    1.258151] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    1.288128] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.288989] ata1.00: ATA-8: Hitachi HTS725050A9A364, PC4OC70E, max UDMA/133
[    1.288992] ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    1.289997] ata1.00: configured for UDMA/133
[    1.290177] scsi 0:0:0:0: Direct-Access     ATA      Hitachi HTS72505 PC4O PQ: 0 ANSI: 5
[    1.294362] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[    1.294457] sd 0:0:0:0: [sda] Write Protect is off
[    1.294460] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.294492] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.318252]  sda: sda1 sda2
[    1.319064] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.382393] hub 1-1:1.0: USB hub found
[    1.382623] hub 1-1:1.0: 6 ports detected
[    1.488143] usb 4-1: new high-speed USB device number 2 using ehci-pci
[    1.612297] hub 4-1:1.0: USB hub found
[    1.612590] hub 4-1:1.0: 6 ports detected
[    1.681545] usb 1-1.4: new high-speed USB device number 3 using ehci-pci
[    1.771691] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    1.777887] tsc: Refined TSC clocksource calibration: 2294.787 MHz
[    2.303683] systemd[1]: RTC configured in localtime, applying delta of 240 minutes to system time.
[    2.314111] systemd[1]: systemd 212 running in system mode. (+PAM -AUDIT -SELINUX -IMA -SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ +SECCOMP -APPARMOR)
[    2.314276] systemd[1]: Detected architecture 'x86-64'.
[    2.319009] systemd[1]: Set hostname to <ew>.
[    2.774165] random: nonblocking pool is initialized
[    2.777468] Switched to clocksource tsc
[    3.352583] systemd[1]: Cannot add dependency job for unit calised.service, ignoring: Unit calised.service failed to load: No such file or directory.
[    3.353042] systemd[1]: Starting Forward Password Requests to Wall Directory Watch.
[    3.353097] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    3.353107] systemd[1]: Expecting device sys-subsystem-net-devices-multi-user.device...
[    3.353120] systemd[1]: Expecting device sys-subsystem-net-devices-ethernet-dhcp.device...
[    3.353128] systemd[1]: Expecting device sys-subsystem-net-devices-wlan0.device...
[    3.353136] systemd[1]: Starting Remote File Systems.
[    3.353144] systemd[1]: Reached target Remote File Systems.
[    3.353153] systemd[1]: Expecting device sys-subsystem-net-devices-neteth0.device...
[    3.353160] systemd[1]: Expecting device sys-subsystem-net-devices-netwlan0.device...
[    3.353171] systemd[1]: Starting Dispatch Password Requests to Console Directory Watch.
[    3.353195] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    3.353213] systemd[1]: Starting Arbitrary Executable File Formats File System Automount Point.
[    3.353294] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    3.353306] systemd[1]: Starting Encrypted Volumes.
[    3.353314] systemd[1]: Reached target Encrypted Volumes.
[    3.353321] systemd[1]: Starting Swap.
[    3.353328] systemd[1]: Reached target Swap.
[    3.353336] systemd[1]: Expecting device dev-sda2.device...
[    3.353344] systemd[1]: Starting Root Slice.
[    3.358449] systemd[1]: Created slice Root Slice.
[    3.358460] systemd[1]: Starting User and Session Slice.
[    3.358581] systemd[1]: Created slice User and Session Slice.
[    3.358590] systemd[1]: Starting Device-mapper event daemon FIFOs.
[    3.358618] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    3.358626] systemd[1]: Starting /dev/initctl Compatibility Named Pipe.
[    3.358641] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[    3.358648] systemd[1]: Starting Delayed Shutdown Socket.
[    3.358666] systemd[1]: Listening on Delayed Shutdown Socket.
[    3.358674] systemd[1]: Starting LVM2 metadata daemon socket.
[    3.358692] systemd[1]: Listening on LVM2 metadata daemon socket.
[    3.358703] systemd[1]: Starting udev Kernel Socket.
[    3.358719] systemd[1]: Listening on udev Kernel Socket.
[    3.358728] systemd[1]: Starting udev Control Socket.
[    3.358743] systemd[1]: Listening on udev Control Socket.
[    3.358753] systemd[1]: Starting Journal Socket.
[    3.358783] systemd[1]: Listening on Journal Socket.
[    3.358798] systemd[1]: Starting System Slice.
[    3.358921] systemd[1]: Created slice System Slice.
[    3.358936] systemd[1]: Started File System Check on Root Device.
[    3.358943] systemd[1]: Starting system-netctl\x2dauto.slice.
[    3.359068] systemd[1]: Created slice system-netctl\x2dauto.slice.
[    3.359077] systemd[1]: Starting system-netctl\x2difplugd.slice.
[    3.359199] systemd[1]: Created slice system-netctl\x2difplugd.slice.
[    3.359208] systemd[1]: Starting system-getty.slice.
[    3.359329] systemd[1]: Created slice system-getty.slice.
[    3.359344] systemd[1]: Mounting Debug File System...
[    3.535461] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[    3.633192] systemd[1]: Starting Load Kernel Modules...
[    3.633616] systemd[1]: Starting Setup Virtual Console...
[    3.633954] systemd[1]: Mounting POSIX Message Queue File System...
[    3.634292] systemd[1]: Starting udev Coldplug all Devices...
[    3.634705] systemd[1]: Mounting Huge Pages File System...
[    3.690587] systemd[1]: Starting Set Up Additional Binary Formats...
[    3.707143] systemd[1]: Starting Apply Kernel Variables...
[    3.707596] systemd[1]: Starting Journal Service...
[    3.707942] systemd[1]: Started Journal Service.
[    4.137451] EXT4-fs (sda1): re-mounted. Opts: data=ordered
[    4.642892] systemd-udevd[157]: starting version 212
[    5.141625] Bluetooth: Core ver 2.18
[    5.141638] NET: Registered protocol family 31
[    5.141640] Bluetooth: HCI device and connection manager initialized
[    5.141644] Bluetooth: HCI socket layer initialized
[    5.141646] Bluetooth: L2CAP socket layer initialized
[    5.141652] Bluetooth: SCO socket layer initialized
[    5.191728] usbcore: registered new interface driver btusb
[    5.327565] loop: module loaded
[    5.596390] cfg80211: Calling CRDA to update world regulatory domain
[    5.723351] Intel(R) Wireless WiFi driver for Linux, in-tree:
[    5.723354] Copyright(c) 2003- 2014 Intel Corporation
[    5.723567] iwlwifi 0000:02:00.0: irq 47 for MSI/MSI-X
[    5.978156] iwlwifi 0000:02:00.0: loaded firmware version 22.24.8.0 op_mode iwlmvm
[    6.144448] iwlwifi 0000:02:00.0: Detected Intel(R) Dual Band Wireless AC 7260, REV=0x144
[    6.144537] iwlwifi 0000:02:00.0: L1 Enabled; Disabling L0S
[    6.144851] iwlwifi 0000:02:00.0: L1 Enabled; Disabling L0S
[    6.253849] input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input2
[    6.253879] ACPI: Lid Switch [LID0]
[    6.253919] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input3
[    6.253922] ACPI: Power Button [PWRB]
[    6.253955] input: Sleep Button as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input4
[    6.253957] ACPI: Sleep Button [SLPB]
[    6.253990] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input5
[    6.253992] ACPI: Power Button [PWRF]
[    6.359380] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[    6.372389] ACPI: AC Adapter [ADP1] (on-line)
[    6.387290] ACPI: Battery Slot [BAT1] (battery present)
[    6.389553] ACPI Warning: SystemIO range 0x0000000000000428-0x000000000000042f conflicts with OpRegion 0x0000000000000400-0x000000000000047f (\PMIO) (20131218/utaddress-258)
[    6.389561] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    6.389565] ACPI Warning: SystemIO range 0x0000000000000540-0x000000000000054f conflicts with OpRegion 0x0000000000000500-0x0000000000000563 (\GPIO) (20131218/utaddress-258)
[    6.389569] ACPI Warning: SystemIO range 0x0000000000000540-0x000000000000054f conflicts with OpRegion 0x0000000000000500-0x000000000000055f (\_SB_.PCI0.PEG0.PEGP.GPIO) (20131218/utaddress-258)
[    6.389574] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    6.389575] ACPI Warning: SystemIO range 0x0000000000000530-0x000000000000053f conflicts with OpRegion 0x0000000000000500-0x0000000000000563 (\GPIO) (20131218/utaddress-258)
[    6.389579] ACPI Warning: SystemIO range 0x0000000000000530-0x000000000000053f conflicts with OpRegion 0x0000000000000500-0x000000000000055f (\_SB_.PCI0.PEG0.PEGP.GPIO) (20131218/utaddress-258)
[    6.389583] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    6.389585] ACPI Warning: SystemIO range 0x0000000000000500-0x000000000000052f conflicts with OpRegion 0x0000000000000500-0x0000000000000563 (\GPIO) (20131218/utaddress-258)
[    6.389589] ACPI Warning: SystemIO range 0x0000000000000500-0x000000000000052f conflicts with OpRegion 0x0000000000000500-0x000000000000055f (\_SB_.PCI0.PEG0.PEGP.GPIO) (20131218/utaddress-258)
[    6.389593] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    6.389595] lpc_ich: Resource conflict(s) found affecting gpio_ich
[    6.470704] mei_me 0000:00:16.0: irq 48 for MSI/MSI-X
[    6.475962] ACPI: Fan [FAN0] (off)
[    6.476001] ACPI: Fan [FAN1] (off)
[    6.534167] input: PC Speaker as /devices/platform/pcspkr/input/input6
[    6.545932] ACPI: Invalid active2 threshold
[    6.551488] thermal LNXTHERM:00: registered as thermal_zone0
[    6.551491] ACPI: Thermal Zone [TZ00] (46 C)
[    6.566229] thermal LNXTHERM:01: registered as thermal_zone1
[    6.566231] ACPI: Thermal Zone [TZ01] (46 C)
[    6.679952] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    6.680198] wmi: Mapper loaded
[    6.692558] ACPI Warning: SystemIO range 0x000000000000e040-0x000000000000e05f conflicts with OpRegion 0x000000000000e040-0x000000000000e04f (\_SB_.PCI0.SBUS.SMBI) (20131218/utaddress-258)
[    6.692566] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    6.719647] microcode: CPU0 sig=0x206a7, pf=0x10, revision=0x12
[    6.741160] microcode: CPU0 sig=0x206a7, pf=0x10, revision=0x12
[    6.741686] microcode: CPU0 updated to revision 0x29, date = 2013-06-12
[    6.741695] microcode: CPU1 sig=0x206a7, pf=0x10, revision=0x12
[    6.741722] microcode: CPU1 sig=0x206a7, pf=0x10, revision=0x12
[    6.742014] microcode: CPU1 updated to revision 0x29, date = 2013-06-12
[    6.742020] microcode: CPU2 sig=0x206a7, pf=0x10, revision=0x12
[    6.742042] microcode: CPU2 sig=0x206a7, pf=0x10, revision=0x12
[    6.742351] microcode: CPU2 updated to revision 0x29, date = 2013-06-12
[    6.742361] microcode: CPU3 sig=0x206a7, pf=0x10, revision=0x12
[    6.742387] microcode: CPU3 sig=0x206a7, pf=0x10, revision=0x12
[    6.742745] microcode: CPU3 updated to revision 0x29, date = 2013-06-12
[    6.742748] perf_event_intel: PEBS enabled due to microcode update
[    6.742806] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    6.793029] samsung_laptop: detected SABI interface: SwSmi@
[    6.793032] samsung_laptop: Backlight controlled by ACPI video driver
[    7.184286] [drm] Initialized drm 1.1.0 20060810
[    7.306944] snd_hda_intel 0000:00:1b.0: irq 49 for MSI/MSI-X
[    7.312538] [drm] Memory usable by graphics device = 2048M
[    7.312542] checking generic (c0000000 300000) vs hw (c0000000 10000000)
[    7.312543] fb: conflicting fb hw usage inteldrmfb vs VESA VGA - removing generic driver
[    7.312555] Console: switching to colour dummy device 80x25
[    7.332582] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    7.332593] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
[    7.335252] r8169 0000:03:00.0: irq 50 for MSI/MSI-X
[    7.335485] r8169 0000:03:00.0 eth0: RTL8168e/8111e at 0xffffc90000c68000, e8:11:32:4c:ea:ba, XID 0c200000 IRQ 50
[    7.335489] r8169 0000:03:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[    7.365101] i915 0000:00:02.0: irq 51 for MSI/MSI-X
[    7.365129] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    7.365130] [drm] Driver supports precise vblank timestamp query.
[    7.365233] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    7.391798] [drm] Wrong MCH_SSKPD value: 0x16040307
[    7.391801] [drm] This can cause pipe underruns and display issues.
[    7.391802] [drm] Please upgrade your BIOS to fix this.
[    7.407122] fbcon: inteldrmfb (fb0) is primary device
[    7.420980] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1b.0/sound/card0/input10
[    7.421075] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input9
[    7.421147] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input8
[    7.525070] psmouse serio1: elantech: assuming hardware version 3 (with firmware version 0x450f00)
[    7.538614] psmouse serio1: elantech: Synaptics capabilities query result 0x08, 0x15, 0x0c.
[    7.609846] input: ETPS/2 Elantech Touchpad as /devices/platform/i8042/serio1/input/input7
[    7.843475] iTCO_vendor_support: vendor-support=0
[    7.868528] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.10
[    7.868567] iTCO_wdt: Found a Cougar Point TCO device (Version=2, TCOBASE=0x0460)
[    7.868666] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    8.013997] mousedev: PS/2 mouse device common for all mice
[    8.358013] Console: switching to colour frame buffer device 170x48
[    8.360313] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    8.360314] i915 0000:00:02.0: registered panic notifier
[    8.360480] [Firmware Bug]: ACPI(PEGP) defines _DOD but not _DOS
[    8.398422] ACPI: Video Device [PEGP] (multi-head: yes  rom: yes  post: no)
[    8.400249] acpi device:47: registered as cooling_device7
[    8.400349] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/device:45/LNXVIDEO:00/input/input11
[    8.401687] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    8.403345] acpi device:51: registered as cooling_device8
[    8.403488] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:01/input/input12
[    8.403546] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
[    8.885870] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: data=ordered
[    8.903852] media: Linux media interface: v0.10
[    8.981105] Linux video capture interface: v2.00
[    9.008547] systemd-journald[138]: Received request to flush runtime journal from PID 1
[    9.106289] uvcvideo: Found UVC 1.00 device WebCam SCB-1100N (2232:1008)
[    9.127921] input: WebCam SCB-1100N as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4/1-1.4:1.0/input/input13
[    9.128097] usbcore: registered new interface driver uvcvideo
[    9.128099] USB Video Class driver (1.1.1)
[    9.351030] [drm] Enabling RC6 states: RC6 on, RC6p on, RC6pp on
[   14.436003] iwlwifi 0000:02:00.0: L1 Enabled; Disabling L0S
[   14.436308] iwlwifi 0000:02:00.0: L1 Enabled; Disabling L0S
[   14.456908] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   15.733929] iwlwifi 0000:02:00.0: L1 Enabled; Disabling L0S
[   15.734240] iwlwifi 0000:02:00.0: L1 Enabled; Disabling L0S
[   15.747104] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   16.163630] vboxguest: PCI device not found, probably running on physical hardware.
[   16.200976] vboxguest: PCI device not found, probably running on physical hardware.
[   16.981153] bbswitch: version 0.8
[   16.981160] bbswitch: Found integrated VGA device 0000:00:02.0: \_SB_.PCI0.GFX0
[   16.981164] bbswitch: Found discrete VGA device 0000:01:00.0: \_SB_.PCI0.PEG0.PEGP
[   16.981173] ACPI Warning: \_SB_.PCI0.PEG0.PEGP._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20131218/nsarguments-95)
[   16.981237] bbswitch: detected an Optimus _DSM function
[   16.981276] bbswitch: disabling discrete graphics
[   16.981279] ACPI Warning: \_SB_.PCI0.PEG0.PEGP._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20131218/nsarguments-95)
[   17.010280] bbswitch: Succesfully loaded. Discrete card 0000:01:00.0 is off
[   19.463995] wlan0: authenticate with f8:1a:67:da:37:32
[   19.468218] wlan0: send auth to f8:1a:67:da:37:32 (try 1/3)
[   19.470573] wlan0: authenticated
[   19.472137] wlan0: associate with f8:1a:67:da:37:32 (try 1/3)
[   19.478368] wlan0: RX AssocResp from f8:1a:67:da:37:32 (capab=0x431 status=0 aid=1)
[   19.482142] wlan0: associated
[   19.482217] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready

--------------070902060900020100010205
Content-Type: text/plain; charset=UTF-8;
 name="lshw.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="lshw.txt"

ew
    description: Laptop
    product: RF511/RF411/RF711 (To be filled by O.E.M.)
    vendor: SAMSUNG ELECTRONICS CO., LTD.
    version: 10HX
    serial: ZZ7N93DB400394
    width: 64 bits
    capabilities: smbios-2.7 dmi-2.7 vsyscall32
    configuration: boot=normal chassis=laptop family=To be filled by O.E.M. sku=To be filled by O.E.M. uuid=302AA56F-D961-E011-A3AF-01E13D49692B
  *-core
       description: Motherboard
       product: RF511/RF411/RF711
       vendor: SAMSUNG ELECTRONICS CO., LTD.
       physical id: 0
       version: 10HX
       serial: 123490EN400015
       slot: To be filled by O.E.M.
     *-firmware
          description: BIOS
          vendor: American Megatrends Inc.
          physical id: 0
          version: 10HX.M034.20110426.SSH
          date: 04/26/2011
          size: 64KiB
          capacity: 1984KiB
          capabilities: pci upgrade shadowing cdboot bootselect edd int13floppy1200 int13floppy720 int13floppy2880 int5printscreen int9keyboard int14serial int17printer acpi usb biosbootspecification uefi
     *-cpu
          description: CPU
          product: Core 2 Duo (Not Specified)
          vendor: Intel Corp.
          physical id: 4
          bus info: cpu@0
          version: Intel(R) Core(TM) i5-2410M CPU @ 2.30GHz
          serial: Not Specified
          slot: CPU 1
          size: 800MHz
          capacity: 4GHz
          width: 64 bits
          clock: 100MHz
          capabilities: x86-64 fpu fpu_exception wp vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer xsave avx lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid aes cpufreq
          configuration: cores=2 enabledcores=1 threads=2
        *-cache
             description: L1 cache
             physical id: 5
             slot: L1-Cache
             size: 32KiB
             capacity: 32KiB
             capabilities: internal write-back instruction
     *-memory
          description: System Memory
          physical id: 41
          slot: System board or motherboard
          size: 8GiB
        *-bank:0
             description: SODIMM DDR3 Synchronous 1333 MHz (0,8 ns)
             product: M2S4G64CB8HG5N-CG
             vendor: Nanya Technology
             physical id: 0
             serial: F7243901
             slot: ChannelA-DIMM0
             size: 4GiB
             width: 64 bits
             clock: 1333MHz (0.8ns)
        *-bank:1
             description: SODIMM DDR3 Synchronous 1333 MHz (0,8 ns)
             product: M471B5273CH0-CH9
             vendor: Samsung
             physical id: 1
             serial: 943B5B11
             slot: ChannelB-DIMM0
             size: 4GiB
             width: 64 bits
             clock: 1333MHz (0.8ns)
     *-pci
          description: Host bridge
          product: 2nd Generation Core Processor Family DRAM Controller
          vendor: Intel Corporation
          physical id: 100
          bus info: pci@0000:00:00.0
          version: 09
          width: 32 bits
          clock: 33MHz
        *-pci:0
             description: PCI bridge
             product: Xeon E3-1200/2nd Generation Core Processor Family PCI Express Root Port
             vendor: Intel Corporation
             physical id: 1
             bus info: pci@0000:00:01.0
             version: 09
             width: 32 bits
             clock: 33MHz
             capabilities: pci pm msi pciexpress normal_decode bus_master cap_list
             configuration: driver=pcieport
             resources: irq:40 ioport:d000(size=4096) memory:f4000000-f50fffff ioport:d0000000(size=301989888)
           *-generic UNCLAIMED
                description: Unassigned class
                product: Illegal Vendor ID
                vendor: Illegal Vendor ID
                physical id: 0
                bus info: pci@0000:01:00.0
                version: ff
                width: 32 bits
                clock: 66MHz
                capabilities: bus_master vga_palette cap_list
                configuration: latency=255 maxlatency=255 mingnt=255
                resources: memory:f4000000-f4ffffff memory:d0000000-dfffffff memory:e0000000-e1ffffff ioport:d000(size=128) memory:f5000000-f507ffff
        *-display
             description: VGA compatible controller
             product: 2nd Generation Core Processor Family Integrated Graphics Controller
             vendor: Intel Corporation
             physical id: 2
             bus info: pci@0000:00:02.0
             version: 09
             width: 64 bits
             clock: 33MHz
             capabilities: msi pm vga_controller bus_master cap_list rom
             configuration: driver=i915 latency=0
             resources: irq:49 memory:f5400000-f57fffff memory:c0000000-cfffffff ioport:e000(size=64)
        *-communication
             description: Communication controller
             product: 6 Series/C200 Series Chipset Family MEI Controller #1
             vendor: Intel Corporation
             physical id: 16
             bus info: pci@0000:00:16.0
             version: 04
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi bus_master cap_list
             configuration: driver=mei_me latency=0
             resources: irq:50 memory:f760a000-f760a00f
        *-usb:0
             description: USB controller
             product: 6 Series/C200 Series Chipset Family USB Enhanced Host Controller #2
             vendor: Intel Corporation
             physical id: 1a
             bus info: pci@0000:00:1a.0
             version: 04
             width: 32 bits
             clock: 33MHz
             capabilities: pm debug ehci bus_master cap_list
             configuration: driver=ehci-pci latency=0
             resources: irq:16 memory:f7608000-f76083ff
           *-usbhost
                product: EHCI Host Controller
                vendor: Linux 3.14.1-1-ARCH ehci_hcd
                physical id: 1
                bus info: usb@3
                logical name: usb3
                version: 3.14
                capabilities: usb-2.00
                configuration: driver=hub slots=2 speed=480Mbit/s
              *-usb
                   description: USB hub
                   product: Integrated Rate Matching Hub
                   vendor: Intel Corp.
                   physical id: 1
                   bus info: usb@3:1
                   version: 0.00
                   capabilities: usb-2.00
                   configuration: driver=hub slots=6 speed=480Mbit/s
                 *-usb
                      description: Video
                      product: WebCam SCB-1100N
                      vendor: 123
                      physical id: 4
                      bus info: usb@3:1.4
                      version: 0.15
                      capabilities: usb-2.00
                      configuration: driver=uvcvideo maxpower=500mA speed=480Mbit/s
        *-multimedia
             description: Audio device
             product: 6 Series/C200 Series Chipset Family High Definition Audio Controller
             vendor: Intel Corporation
             physical id: 1b
             bus info: pci@0000:00:1b.0
             version: 04
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi pciexpress bus_master cap_list
             configuration: driver=snd_hda_intel latency=0
             resources: irq:51 memory:f7600000-f7603fff
        *-pci:1
             description: PCI bridge
             product: 6 Series/C200 Series Chipset Family PCI Express Root Port 1
             vendor: Intel Corporation
             physical id: 1c
             bus info: pci@0000:00:1c.0
             version: b4
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm normal_decode bus_master cap_list
             configuration: driver=pcieport
             resources: irq:16 ioport:c000(size=4096) memory:f6c00000-f75fffff ioport:e3700000(size=10485760)
           *-network
                description: Wireless interface
                product: Wireless 7260
                vendor: Intel Corporation
                physical id: 0
                bus info: pci@0000:02:00.0
                logical name: wlan0
                version: 73
                serial: ac:7b:a1:4e:85:45
                width: 64 bits
                clock: 33MHz
                capabilities: pm msi pciexpress bus_master cap_list ethernet physical wireless
                configuration: broadcast=yes driver=iwlwifi driverversion=3.14.1-1-ARCH firmware=22.24.8.0 ip=192.168.0.100 latency=0 link=yes multicast=yes wireless=IEEE 802.11abgn
                resources: irq:47 memory:f6c00000-f6c01fff
        *-pci:2
             description: PCI bridge
             product: 6 Series/C200 Series Chipset Family PCI Express Root Port 4
             vendor: Intel Corporation
             physical id: 1c.3
             bus info: pci@0000:00:1c.3
             version: b4
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm normal_decode bus_master cap_list
             configuration: driver=pcieport
             resources: irq:19 ioport:b000(size=4096) memory:f6200000-f6bfffff ioport:e2c00000(size=10485760)
           *-network DISABLED
                description: Ethernet interface
                product: RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
                vendor: Realtek Semiconductor Co., Ltd.
                physical id: 0
                bus info: pci@0000:03:00.0
                logical name: eth0
                version: 06
                serial: e8:11:32:4c:ea:ba
                size: 10Mbit/s
                capacity: 1Gbit/s
                width: 64 bits
                clock: 33MHz
                capabilities: pm msi pciexpress msix vpd bus_master cap_list ethernet physical tp mii 10bt 10bt-fd 100bt 100bt-fd 1000bt 1000bt-fd autonegotiation
                configuration: autonegotiation=on broadcast=yes driver=r8169 driverversion=2.3LK-NAPI duplex=half latency=0 link=no multicast=yes port=MII speed=10Mbit/s
                resources: irq:48 ioport:b000(size=256) memory:e2c04000-e2c04fff memory:e2c00000-e2c03fff
        *-pci:3
             description: PCI bridge
             product: 6 Series/C200 Series Chipset Family PCI Express Root Port 5
             vendor: Intel Corporation
             physical id: 1c.4
             bus info: pci@0000:00:1c.4
             version: b4
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm normal_decode bus_master cap_list
             configuration: driver=pcieport
             resources: irq:17 ioport:a000(size=4096) memory:f5800000-f61fffff ioport:e2100000(size=10485760)
           *-usb
                description: USB controller
                product: uPD720200 USB 3.0 Host Controller
                vendor: NEC Corporation
                physical id: 0
                bus info: pci@0000:04:00.0
                version: 04
                width: 64 bits
                clock: 33MHz
                capabilities: pm msi msix pciexpress xhci bus_master cap_list
                configuration: driver=xhci_hcd latency=0
                resources: irq:16 memory:f5800000-f5801fff
              *-usbhost:0
                   product: xHCI Host Controller
                   vendor: Linux 3.14.1-1-ARCH xhci_hcd
                   physical id: 0
                   bus info: usb@2
                   logical name: usb2
                   version: 3.14
                   capabilities: usb-3.00
                   configuration: driver=hub slots=2 speed=5000Mbit/s
              *-usbhost:1
                   product: xHCI Host Controller
                   vendor: Linux 3.14.1-1-ARCH xhci_hcd
                   physical id: 1
                   bus info: usb@1
                   logical name: usb1
                   version: 3.14
                   capabilities: usb-2.00
                   configuration: driver=hub slots=2 speed=480Mbit/s
        *-usb:1
             description: USB controller
             product: 6 Series/C200 Series Chipset Family USB Enhanced Host Controller #1
             vendor: Intel Corporation
             physical id: 1d
             bus info: pci@0000:00:1d.0
             version: 04
             width: 32 bits
             clock: 33MHz
             capabilities: pm debug ehci bus_master cap_list
             configuration: driver=ehci-pci latency=0
             resources: irq:23 memory:f7607000-f76073ff
           *-usbhost
                product: EHCI Host Controller
                vendor: Linux 3.14.1-1-ARCH ehci_hcd
                physical id: 1
                bus info: usb@4
                logical name: usb4
                version: 3.14
                capabilities: usb-2.00
                configuration: driver=hub slots=2 speed=480Mbit/s
              *-usb
                   description: USB hub
                   product: Integrated Rate Matching Hub
                   vendor: Intel Corp.
                   physical id: 1
                   bus info: usb@4:1
                   version: 0.00
                   capabilities: usb-2.00
                   configuration: driver=hub slots=6 speed=480Mbit/s
        *-isa
             description: ISA bridge
             product: HM65 Express Chipset Family LPC Controller
             vendor: Intel Corporation
             physical id: 1f
             bus info: pci@0000:00:1f.0
             version: 04
             width: 32 bits
             clock: 33MHz
             capabilities: isa bus_master cap_list
             configuration: driver=lpc_ich latency=0
             resources: irq:0
        *-storage
             description: SATA controller
             product: 6 Series/C200 Series Chipset Family 6 port SATA AHCI Controller
             vendor: Intel Corporation
             physical id: 1f.2
             bus info: pci@0000:00:1f.2
             version: 04
             width: 32 bits
             clock: 66MHz
             capabilities: storage msi pm ahci_1.0 bus_master cap_list
             configuration: driver=ahci latency=0
             resources: irq:46 ioport:e0b0(size=8) ioport:e0a0(size=4) ioport:e090(size=8) ioport:e080(size=4) ioport:e060(size=32) memory:f7606000-f76067ff
        *-serial UNCLAIMED
             description: SMBus
             product: 6 Series/C200 Series Chipset Family SMBus Controller
             vendor: Intel Corporation
             physical id: 1f.3
             bus info: pci@0000:00:1f.3
             version: 04
             width: 64 bits
             clock: 33MHz
             configuration: latency=0
             resources: memory:f7605000-f76050ff ioport:e040(size=32)
  *-power UNCLAIMED
       description: To Be Filled By O.E.M.
       product: To Be Filled By O.E.M.
       vendor: To Be Filled By O.E.M.
       physical id: 1
       version: To Be Filled By O.E.M.
       serial: To Be Filled By O.E.M.
       capacity: 32768mWh

--------------070902060900020100010205
Content-Type: text/plain; charset=UTF-8;
 name="lspci.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="lspci.txt"

00:00.0 Host bridge: Intel Corporation 2nd Generation Core Processor Family DRAM Controller (rev 09)
	Subsystem: Samsung Electronics Co Ltd Device c0a5
	Flags: bus master, fast devsel, latency 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>

00:01.0 PCI bridge: Intel Corporation Xeon E3-1200/2nd Generation Core Processor Family PCI Express Root Port (rev 09) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: f4000000-f50fffff
	Prefetchable memory behind bridge: 00000000d0000000-00000000e1ffffff
	Capabilities: [88] Subsystem: Samsung Electronics Co Ltd Device c0a5
	Capabilities: [80] Power Management version 3
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
	Capabilities: [a0] Express Root Port (Slot+), MSI 00
	Capabilities: [100] Virtual Channel
	Capabilities: [140] Root Complex Link
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:02.0 VGA compatible controller: Intel Corporation 2nd Generation Core Processor Family Integrated Graphics Controller (rev 09) (prog-if 00 [VGA controller])
	Subsystem: Samsung Electronics Co Ltd Device c0a5
	Flags: bus master, fast devsel, latency 0, IRQ 49
	Memory at f5400000 (64-bit, non-prefetchable) [size=4M]
	Memory at c0000000 (64-bit, prefetchable) [size=256M]
	I/O ports at e000 [size=64]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
	Capabilities: [d0] Power Management version 2
	Capabilities: [a4] PCI Advanced Features
	Kernel driver in use: i915
	Kernel modules: i915

00:16.0 Communication controller: Intel Corporation 6 Series/C200 Series Chipset Family MEI Controller #1 (rev 04)
	Subsystem: Samsung Electronics Co Ltd Device c0a5
	Flags: bus master, fast devsel, latency 0, IRQ 50
	Memory at f760a000 (64-bit, non-prefetchable) [size=16]
	Capabilities: [50] Power Management version 3
	Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Kernel driver in use: mei_me
	Kernel modules: mei_me

00:1a.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset Family USB Enhanced Host Controller #2 (rev 04) (prog-if 20 [EHCI])
	Subsystem: Samsung Electronics Co Ltd Device c0a5
	Flags: bus master, medium devsel, latency 0, IRQ 16
	Memory at f7608000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] PCI Advanced Features
	Kernel driver in use: ehci-pci
	Kernel modules: ehci_pci

00:1b.0 Audio device: Intel Corporation 6 Series/C200 Series Chipset Family High Definition Audio Controller (rev 04)
	Subsystem: Samsung Electronics Co Ltd Device c0a5
	Flags: bus master, fast devsel, latency 0, IRQ 51
	Memory at f7600000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00
	Capabilities: [100] Virtual Channel
	Capabilities: [130] Root Complex Link
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 1 (rev b4) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: f6c00000-f75fffff
	Prefetchable memory behind bridge: 00000000e3700000-00000000e40fffff
	Capabilities: [40] Express Root Port (Slot+), MSI 00
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
	Capabilities: [90] Subsystem: Samsung Electronics Co Ltd Device c0a5
	Capabilities: [a0] Power Management version 2
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1c.3 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 4 (rev b4) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: f6200000-f6bfffff
	Prefetchable memory behind bridge: 00000000e2c00000-00000000e35fffff
	Capabilities: [40] Express Root Port (Slot+), MSI 00
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
	Capabilities: [90] Subsystem: Samsung Electronics Co Ltd Device c0a5
	Capabilities: [a0] Power Management version 2
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1c.4 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 5 (rev b4) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: f5800000-f61fffff
	Prefetchable memory behind bridge: 00000000e2100000-00000000e2afffff
	Capabilities: [40] Express Root Port (Slot+), MSI 00
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
	Capabilities: [90] Subsystem: Samsung Electronics Co Ltd Device c0a5
	Capabilities: [a0] Power Management version 2
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1d.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset Family USB Enhanced Host Controller #1 (rev 04) (prog-if 20 [EHCI])
	Subsystem: Samsung Electronics Co Ltd Device c0a5
	Flags: bus master, medium devsel, latency 0, IRQ 23
	Memory at f7607000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] PCI Advanced Features
	Kernel driver in use: ehci-pci
	Kernel modules: ehci_pci

00:1f.0 ISA bridge: Intel Corporation HM65 Express Chipset Family LPC Controller (rev 04)
	Subsystem: Samsung Electronics Co Ltd Device c0a5
	Flags: bus master, medium devsel, latency 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	Kernel driver in use: lpc_ich
	Kernel modules: lpc_ich

00:1f.2 SATA controller: Intel Corporation 6 Series/C200 Series Chipset Family 6 port SATA AHCI Controller (rev 04) (prog-if 01 [AHCI 1.0])
	Subsystem: Samsung Electronics Co Ltd Device c0a5
	Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 46
	I/O ports at e0b0 [size=8]
	I/O ports at e0a0 [size=4]
	I/O ports at e090 [size=8]
	I/O ports at e080 [size=4]
	I/O ports at e060 [size=32]
	Memory at f7606000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
	Capabilities: [70] Power Management version 3
	Capabilities: [a8] SATA HBA v1.0
	Capabilities: [b0] PCI Advanced Features
	Kernel driver in use: ahci
	Kernel modules: ahci

00:1f.3 SMBus: Intel Corporation 6 Series/C200 Series Chipset Family SMBus Controller (rev 04)
	Subsystem: Samsung Electronics Co Ltd Device c0a5
	Flags: medium devsel, IRQ 18
	Memory at f7605000 (64-bit, non-prefetchable) [size=256]
	I/O ports at e040 [size=32]
	Kernel modules: i2c_i801

01:00.0 3D controller: NVIDIA Corporation GF108M [GeForce GT 540M] (rev ff) (prog-if ff)
	!!! Unknown header type 7f
	Kernel modules: nouveau, nvidia

02:00.0 Network controller: Intel Corporation Wireless 7260 (rev 73)
	Subsystem: Intel Corporation Dual Band Wireless-AC 7260
	Flags: bus master, fast devsel, latency 0, IRQ 47
	Memory at f6c00000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [c8] Power Management version 3
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [40] Express Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Device Serial Number ac-7b-a1-ff-ff-4e-85-45
	Capabilities: [14c] Latency Tolerance Reporting
	Capabilities: [154] Vendor Specific Information: ID=cafe Rev=1 Len=014 <?>
	Kernel driver in use: iwlwifi
	Kernel modules: iwlwifi

03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 06)
	Subsystem: Samsung Electronics Co Ltd Device c0a5
	Flags: bus master, fast devsel, latency 0, IRQ 48
	I/O ports at b000 [size=256]
	Memory at e2c04000 (64-bit, prefetchable) [size=4K]
	Memory at e2c00000 (64-bit, prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [70] Express Endpoint, MSI 01
	Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
	Capabilities: [d0] Vital Product Data
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Virtual Channel
	Capabilities: [160] Device Serial Number 01-00-00-00-68-4c-e0-00
	Kernel driver in use: r8169
	Kernel modules: r8169

04:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host Controller (rev 04) (prog-if 30 [XHCI])
	Subsystem: Samsung Electronics Co Ltd Device c0a5
	Flags: bus master, fast devsel, latency 0, IRQ 16
	Memory at f5800000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [50] Power Management version 3
	Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
	Capabilities: [90] MSI-X: Enable+ Count=8 Masked-
	Capabilities: [a0] Express Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Device Serial Number ff-ff-ff-ff-ff-ff-ff-ff
	Capabilities: [150] Latency Tolerance Reporting
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_hcd


--------------070902060900020100010205--
