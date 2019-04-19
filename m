Return-Path: <SRS0=AkUh=SV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22318C282DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Apr 2019 00:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B4821736
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Apr 2019 00:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfDSADC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:03:02 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:54068 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725917AbfDSADC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Apr 2019 20:03:02 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id C776D28D6C
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2019 00:03:00 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id BBC7828D71; Fri, 19 Apr 2019 00:03:00 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203355] New: Bluetooth (sound stuttering)
Date:   Fri, 19 Apr 2019 00:02:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mamutin.v@yandex.ru
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-203355-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=203355

            Bug ID: 203355
           Summary: Bluetooth (sound stuttering)
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.0.0-13-generic
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: mamutin.v@yandex.ru
        Regression: No

Created attachment 282397
  --> https://bugzilla.kernel.org/attachment.cgi?id=282397&action=edit
bt settings

The problem occurs when you listen to media through the bluetooth speaker. When
i open system bluetooth connection settings, sound in my BT speaker start
stuttering.
BT Speaker model: Sony SRS-XB30


sudo lshw
ubuntu                      
    description: Notebook
    product: TravelMate P259-MG (TravelMate P259-MG_1134_1.49)
    vendor: Acer
    version: V1.49
    serial: NXVE2ER0137210FF677600
    width: 64 bits
    capabilities: smbios-3.0 dmi-3.0 smp vsyscall32
    configuration: chassis=notebook family=SKL sku=TravelMate P259-MG_1134_1.49
uuid=86A2CB52-E55D-45AF-A5D5-A81E848CC4A5
  *-core
       description: Motherboard
       product: Lyra_SK
       vendor: Acer
       physical id: 0
       version: V1.49
       serial: NBVDH110017210FF677600
       slot: Type2 - Board Chassis Location
     *-firmware
          description: BIOS
          vendor: Insyde Corp.
          physical id: 0
          version: V1.49
          date: 12/11/2018
          size: 128KiB
          capacity: 4544KiB
          capabilities: pci upgrade shadowing cdboot bootselect edd
int13floppynec int13floppytoshiba int13floppy360 int13floppy1200 int13floppy720
int13floppy2880 int9keyboard int10video acpi usb biosbootspecification uefi
     *-cpu
          description: CPU
          product: Intel(R) Core(TM) i5-6200U CPU @ 2.30GHz
          vendor: Intel Corp.
          physical id: 4
          bus info: cpu@0
          version: Intel(R) Core(TM) i5-6200U CPU @ 2.30GHz
          serial: To Be Filled By O.E.M.
          slot: U3E1
          size: 1332MHz
          capacity: 4005MHz
          width: 64 bits
          clock: 100MHz
          capabilities: x86-64 fpu fpu_exception wp vme de pse tsc msr pae mce
cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss
ht tm pbe syscall nx pdpe1gb rdtscp constant_tsc art arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni
pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
lahf_lm abm 3dnowprefetch cpuid_fault epb invpcid_single pti ssbd ibrs ibpb
stibp tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1
avx2 smep bmi2 erms invpcid mpx rdseed adx smap clflushopt intel_pt xsaveopt
xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window
hwp_epp flush_l1d cpufreq
          configuration: cores=2 enabledcores=2 threads=4
        *-cache:0
             description: L1 cache
             physical id: 6
             slot: L1 Cache
             size: 64KiB
             capacity: 64KiB
             capabilities: synchronous internal write-back instruction
             configuration: level=1
        *-cache:1
             description: L2 cache
             physical id: 7
             slot: L2 Cache
             size: 512KiB
             capacity: 512KiB
             capabilities: synchronous internal write-back unified
             configuration: level=2
        *-cache:2
             description: L3 cache
             physical id: 8
             slot: L3 Cache
             size: 3MiB
             capacity: 3MiB
             capabilities: synchronous internal write-back unified
             configuration: level=3
     *-cache
          description: L1 cache
          physical id: 5
          slot: L1 Cache
          size: 64KiB
          capacity: 64KiB
          capabilities: synchronous internal write-back data
          configuration: level=1
     *-memory
          description: System Memory
          physical id: f
          slot: System board or motherboard
          size: 12GiB
        *-bank:0
             description: SODIMM DDR4 Synchronous 2133 MHz (0.5 ns)
             product: AM1P24HC4U1-B9RS
             vendor: Fujitsu
             physical id: 0
             serial: 78460200
             slot: ChannelA-DIMM0
             size: 4GiB
             width: 64 bits
             clock: 2133MHz (0.5ns)
        *-bank:1
             description: [empty]
             physical id: 1
             slot: ChannelA-DIMM1
        *-bank:2
             description: SODIMM DDR4 Synchronous 2133 MHz (0.5 ns)
             product: 9905668-002.A00G
             vendor: Kingston
             physical id: 2
             serial: 28162309
             slot: ChannelB-DIMM0
             size: 8GiB
             width: 64 bits
             clock: 2133MHz (0.5ns)
        *-bank:3
             description: [empty]
             physical id: 3
             slot: ChannelB-DIMM1
     *-pci
          description: Host bridge
          product: Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Host
Bridge/DRAM Registers
          vendor: Intel Corporation
          physical id: 100
          bus info: pci@0000:00:00.0
          version: 08
          width: 32 bits
          clock: 33MHz
          configuration: driver=skl_uncore
          resources: irq:0
        *-display
             description: VGA compatible controller
             product: Skylake GT2 [HD Graphics 520]
             vendor: Intel Corporation
             physical id: 2
             bus info: pci@0000:00:02.0
             version: 07
             width: 64 bits
             clock: 33MHz
             capabilities: pciexpress msi pm vga_controller bus_master cap_list
rom
             configuration: driver=i915 latency=0
             resources: irq:131 memory:c2000000-c2ffffff
memory:d0000000-dfffffff ioport:5000(size=64) memory:c0000-dffff
        *-usb
             description: USB controller
             product: Sunrise Point-LP USB 3.0 xHCI Controller
             vendor: Intel Corporation
             physical id: 14
             bus info: pci@0000:00:14.0
             version: 21
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi xhci bus_master cap_list
             configuration: driver=xhci_hcd latency=0
             resources: irq:126 memory:c4200000-c420ffff
           *-usbhost:0
                product: xHCI Host Controller
                vendor: Linux 5.0.0-13-generic xhci-hcd
                physical id: 0
                bus info: usb@1
                logical name: usb1
                version: 5.00
                capabilities: usb-2.00
                configuration: driver=hub slots=12 speed=480Mbit/s
              *-usb:0
                   description: Keyboard
                   product: USB Receiver
                   vendor: Logitech
                   physical id: 1
                   bus info: usb@1:1
                   version: 44.00
                   capabilities: usb-2.00
                   configuration: driver=usbhid maxpower=98mA speed=12Mbit/s
              *-usb:1
                   description: Mass storage device
                   product: USB DISK 50X
                   vendor: Phison
                   physical id: 4
                   bus info: usb@1:4
                   logical name: scsi2
                   version: 1.10
                   serial: 100000008299
                   capabilities: usb-2.10 scsi emulated scsi-host
                   configuration: driver=usb-storage maxpower=498mA
speed=480Mbit/s
                 *-disk
                      description: SCSI Disk
                      product: USB DISK 50X
                      vendor: Phison
                      physical id: 0.0.0
                      bus info: scsi@2:0.0.0
                      logical name: /dev/sdb
                      version: PMAP
                      serial: 1 0 0 0 0 0
                      size: 14GiB (15GB)
                      capabilities: removable
                      configuration: ansiversion=6 logicalsectorsize=512
sectorsize=512
                    *-medium
                         physical id: 0
                         logical name: /dev/sdb
                         size: 14GiB (15GB)
                         capabilities: partitioned partitioned:dos
                         configuration: signature=002424ee
                       *-volume
                            description: Windows FAT volume
                            vendor: SYSLINUX
                            physical id: 1
                            logical name: /dev/sdb1
                            logical name: /cdrom
                            version: FAT32
                            serial: ec30-f8e6
                            size: 14GiB
                            capacity: 14GiB
                            capabilities: primary bootable fat initialized
                            configuration: FATs=2 filesystem=fat label=UBUNTU
19_0 mount.fstype=vfat
mount.options=ro,noatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro
state=mounted
              *-usb:2
                   description: Bluetooth wireless interface
                   vendor: Intel Corp.
                   physical id: 5
                   bus info: usb@1:5
                   version: 0.01
                   capabilities: bluetooth usb-2.01
                   configuration: driver=btusb maxpower=100mA speed=12Mbit/s
              *-usb:3
                   description: Video
                   product: HD WebCam
                   vendor: Generic
                   physical id: 7
                   bus info: usb@1:7
                   version: 0.07
                   serial: 200901010001
                   capabilities: usb-2.00
                   configuration: driver=uvcvideo maxpower=500mA
speed=480Mbit/s
           *-usbhost:1
                product: xHCI Host Controller
                vendor: Linux 5.0.0-13-generic xhci-hcd
                physical id: 1
                bus info: usb@2
                logical name: usb2
                version: 5.00
                capabilities: usb-3.00
                configuration: driver=hub slots=6 speed=5000Mbit/s
        *-generic:0
             description: Signal processing controller
             product: Sunrise Point-LP Thermal subsystem
             vendor: Intel Corporation
             physical id: 14.2
             bus info: pci@0000:00:14.2
             version: 21
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi bus_master cap_list
             configuration: driver=intel_pch_thermal latency=0
             resources: irq:18 memory:c422a000-c422afff
        *-generic:1
             description: Signal processing controller
             product: Sunrise Point-LP Serial IO I2C Controller #0
             vendor: Intel Corporation
             physical id: 15
             bus info: pci@0000:00:15.0
             version: 21
             width: 64 bits
             clock: 33MHz
             capabilities: pm bus_master cap_list
             configuration: driver=intel-lpss latency=0
             resources: irq:16 memory:c422b000-c422bfff
        *-communication
             description: Communication controller
             product: Sunrise Point-LP CSME HECI #1
             vendor: Intel Corporation
             physical id: 16
             bus info: pci@0000:00:16.0
             version: 21
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi bus_master cap_list
             configuration: driver=mei_me latency=0
             resources: irq:132 memory:c422c000-c422cfff
        *-storage
             description: SATA controller
             product: Sunrise Point-LP SATA Controller [AHCI mode]
             vendor: Intel Corporation
             physical id: 17
             bus info: pci@0000:00:17.0
             version: 21
             width: 32 bits
             clock: 66MHz
             capabilities: storage msi pm ahci_1.0 bus_master cap_list
             configuration: driver=ahci latency=0
             resources: irq:127 memory:c4228000-c4229fff
memory:c422f000-c422f0ff ioport:5080(size=8) ioport:5088(size=4)
ioport:5060(size=32) memory:c422d000-c422d7ff
        *-pci:0
             description: PCI bridge
             product: Sunrise Point-LP PCI Express Root Port #1
             vendor: Intel Corporation
             physical id: 1c
             bus info: pci@0000:00:1c.0
             version: f1
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm normal_decode bus_master
cap_list
             configuration: driver=pcieport
             resources: irq:122 ioport:4000(size=4096) memory:c3000000-c3ffffff
ioport:b0000000(size=301989888)
           *-display
                description: 3D controller
                product: GM108M [GeForce 940MX]
                vendor: NVIDIA Corporation
                physical id: 0
                bus info: pci@0000:01:00.0
                version: a2
                width: 64 bits
                clock: 33MHz
                capabilities: pm msi pciexpress bus_master cap_list
                configuration: driver=nouveau latency=0
                resources: irq:130 memory:c3000000-c3ffffff
memory:b0000000-bfffffff memory:c0000000-c1ffffff ioport:4000(size=128)
        *-pci:1
             description: PCI bridge
             product: Sunrise Point-LP PCI Express Root Port #9
             vendor: Intel Corporation
             physical id: 1d
             bus info: pci@0000:00:1d.0
             version: f1
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm normal_decode bus_master
cap_list
             configuration: driver=pcieport
             resources: irq:123 ioport:6000(size=4096) memory:ad900000-adafffff
ioport:adb00000(size=2097152)
        *-pci:2
             description: PCI bridge
             product: Intel Corporation
             vendor: Intel Corporation
             physical id: 1d.2
             bus info: pci@0000:00:1d.2
             version: f1
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm normal_decode bus_master
cap_list
             configuration: driver=pcieport
             resources: irq:124 memory:c4100000-c41fffff
           *-network
                description: Wireless interface
                product: Wireless 7265
                vendor: Intel Corporation
                physical id: 0
                bus info: pci@0000:03:00.0
                logical name: wlp3s0
                version: 59
                serial: e4:42:a6:38:51:6c
                width: 64 bits
                clock: 33MHz
                capabilities: pm msi pciexpress bus_master cap_list ethernet
physical wireless
                configuration: broadcast=yes driver=iwlwifi
driverversion=5.0.0-13-generic firmware=29.1044073957.0 ip=192.168.0.97
latency=0 link=yes multicast=yes wireless=IEEE 802.11
                resources: irq:133 memory:c4100000-c4101fff
        *-pci:3
             description: PCI bridge
             product: Intel Corporation
             vendor: Intel Corporation
             physical id: 1d.3
             bus info: pci@0000:00:1d.3
             version: f1
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm normal_decode bus_master
cap_list
             configuration: driver=pcieport
             resources: irq:125 ioport:3000(size=4096) memory:c4000000-c40fffff
           *-generic
                description: Unassigned class
                product: RTL8411B PCI Express Card Reader
                vendor: Realtek Semiconductor Co., Ltd.
                physical id: 0
                bus info: pci@0000:04:00.0
                version: 01
                width: 32 bits
                clock: 33MHz
                capabilities: pm msi pciexpress msix vpd bus_master cap_list
rom
                configuration: driver=rtsx_pci latency=0
                resources: irq:128 memory:c4005000-c4005fff
memory:c4010000-c401ffff
           *-network
                description: Ethernet interface
                product: RTL8111/8168/8411 PCI Express Gigabit Ethernet
Controller
                vendor: Realtek Semiconductor Co., Ltd.
                physical id: 0.1
                bus info: pci@0000:04:00.1
                logical name: enp4s0f1
                version: 12
                serial: a8:1e:84:8c:c4:a5
                size: 10Mbit/s
                capacity: 1Gbit/s
                width: 64 bits
                clock: 33MHz
                capabilities: pm msi pciexpress msix vpd bus_master cap_list
ethernet physical tp mii 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd autonegotiation
                configuration: autonegotiation=on broadcast=yes driver=r8169
duplex=half firmware=rtl8411-2_0.0.1 07/08/13 latency=0 link=no multicast=yes
port=MII speed=10Mbit/s
                resources: irq:19 ioport:3000(size=256)
memory:c4004000-c4004fff memory:c4000000-c4003fff
        *-isa
             description: ISA bridge
             product: Sunrise Point-LP LPC Controller
             vendor: Intel Corporation
             physical id: 1f
             bus info: pci@0000:00:1f.0
             version: 21
             width: 32 bits
             clock: 33MHz
             capabilities: isa bus_master
             configuration: latency=0
        *-memory UNCLAIMED
             description: Memory controller
             product: Sunrise Point-LP PMC
             vendor: Intel Corporation
             physical id: 1f.2
             bus info: pci@0000:00:1f.2
             version: 21
             width: 32 bits
             clock: 33MHz (30.3ns)
             capabilities: bus_master
             configuration: latency=0
             resources: memory:c4224000-c4227fff
        *-multimedia
             description: Audio device
             product: Sunrise Point-LP HD Audio
             vendor: Intel Corporation
             physical id: 1f.3
             bus info: pci@0000:00:1f.3
             version: 21
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi bus_master cap_list
             configuration: driver=snd_hda_intel latency=32
             resources: irq:134 memory:c4220000-c4223fff
memory:c4210000-c421ffff
        *-serial
             description: SMBus
             product: Sunrise Point-LP SMBus
             vendor: Intel Corporation
             physical id: 1f.4
             bus info: pci@0000:00:1f.4
             version: 21
             width: 64 bits
             clock: 33MHz
             configuration: driver=i801_smbus latency=0
             resources: irq:16 memory:c422e000-c422e0ff ioport:5040(size=32)

-- 
You are receiving this mail because:
You are the assignee for the bug.
