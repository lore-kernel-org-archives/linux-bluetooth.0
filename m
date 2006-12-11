Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <20061211052243.12680.qmail@web50202.mail.yahoo.com>
Date: Sun, 10 Dec 2006 21:22:43 -0800 (PST)
From: Will Tucker <witucker@yahoo.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] BlueZ usb hciconfig timeout - I included debug
	printouts
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1765004165=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1765004165==
Content-Type: multipart/alternative; boundary="0-1719768384-1165814563=:12200"
Content-Transfer-Encoding: 8bit

--0-1719768384-1165814563=:12200
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,
   
  I'm new to this list and I'm trying to get my linux board running using usb bluez.
   
  I ran into the following issue of a timeout (110) when performing "hciconfig hci0 up". 
   
  You will notice I turned on debug in hope that someone could see my error and help me correct it. 
   
  I have tried 5 different dongle types with no luck.
   
  I would appreciate any ideas or other things to try.
   
  Thanks Will
   
  U-Boot 1.1.3 (Mar  3 2006 - 01:16:59)
  U-Boot code: 81080000 -> 810973A8  BSS: -> 810A02B8
RAM Configuration:
Bank #0: 80000000 256 MB
MY AMD Flash: 16 MB
In:    serial
Out:   serial
Err:   serial
ARM Clock :- 283MZ
DDR Clock :- 189MZ
Hit any key to stop autoboot:  0
BOOTP broadcast 1
DHCP client bound to address 192.168.55.112
TFTP from server 192.168.55.114; our IP address is 192.168.55.112
Filename 'uImage'.
Load address: 0x80700000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #######################
done
Bytes transferred = 1444884 (160c14 hex)
## Booting image at 80700000 ...
   Image Name:   Linux-2.6.10_mvl401-davinci_evm
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1444820 Bytes =  1.4 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
OK
  Starting kernel ...
  Uncompressing Linux.............................................................
................................. done, booting the.Linux version 2.6.10_mvl401-
davinci_evm (root@linux) (gcc version 3.4.3 (MontaVista 3.4.3-25.0.30.0501131 20
05-07-23)) #29 Sun Dec 10 06:23:18 MST 2006
CPU: ARM926EJ-Sid(wb) [41069265] revision 5 (ARMv5TEJ)
CPU0: D VIVT write-back cache
CPU0: I cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
CPU0: D cache: 8192 bytes, associativity 4, 32 byte lines, 64 sets
Machine: DaVinci EVM
Memory policy: ECC disabled, Data cache writeback
Built 1 zonelists
Kernel command line: console=ttyS0,115200n8 noinitrd rw ip=dhcp root=/dev/nfs nf
sroot=192.168.55.114:/home/guest/workdir/filesys,nolock mem=120M
PID hash table entries: 512 (order: 9, 8192 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 120MB = 120MB total
Memory: 118528KB available (2477K code, 509K data, 144K init)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Testing write buffer coherency: ok
spawn_desched_task(00000000)
desched cpu_callback 3/00000000
ksoftirqd started up.
desched cpu_callback 2/00000000
desched thread 0 started up.
NET: Registered protocol family 16
Registering platform device 'musb_hdrc'. Parent at platform
DaVinci I2C DEBUG: 12:57:03 Dec  9 2006
Registering platform device 'i2c'. Parent at platform
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
yaffs Dec  9 2006 12:56:10 Installing.
Registering platform device 'davincifb.0'. Parent at platform
Setting Up Clocks for DM420 OSD
Console: switching to colour frame buffer device 90x30
fb0: dm_osd0_fb frame buffer device
fb1: dm_vid0_fb frame buffer device
fb2: dm_osd1_fb frame buffer device
fb3: dm_vid1_fb frame buffer device
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
Registering platform device 'serial8250'. Parent at platform
ttyS0 at MMIO 0x1c20000 (irq = 40) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
RAMDISK driver initialized: 1 RAM disks of 32768K size 1024 blocksize
Registering platform device 'ti_davinci_emac'. Parent at platform
TI DaVinci EMAC: MAC address is 00:0e:99:02:55:0b
TI DaVinci EMAC Linux version updated 4.0
TI DaVinci EMAC: Installed 1 instances.
netconsole: not configured, aborting
i2c /dev entries driver
Linux video capture interface: v1.00
Registering platform device 'vpfe.1'. Parent at platform
DaVinci v4l2 capture driver V1.0 loaded
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
hda: TOSHIBA MK4032GAX, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0xe10661f0-0xe10661f7,0xe10663f6 on irq 22
hda: max request size: 1024KiB
hda: 78140160 sectors (40007 MB), CHS=16383/255/63
 hda: hda1 hda2
    ide0: BM-DMA at 0xe1066000-0xe1066007, BIOS settings: hda:pio, hdb:pio
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
ics TIRA-1 IR Transceiver
usbcore: registered new driver ftdi_sio
drivers/usb/serial/ftdi_sio.c: v1.4.1:USB FTDI Serial Converters Driver
mice: PS/2 mouse device common for all mice
musb_hdrc: version 2.2a/db-0.4.8 [pio] [host] [debug=3]
musb_hdrc: USB Host mode controller at c8060000 using PIO, IRQ 12
musb_hdrc musb_hdrc: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
Bluetooth: HCI USB driver ver 2.7
usbcore: registered new driver hci_usb
Bluetooth: HCI UART driver ver 2.1
Bluetooth: HCI H4 protocol initialized
Bluetooth: HCI BCSP protocol initialized
Registering platform device 'davinci-audio.0'. Parent at platform
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
hci_register_proto: c02b71a8 name L2CAP id 0
Bluetooth: L2CAP ver 2.6
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.3
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Bluetooth: HIDP (Human Interface Emulation) ver 1.0
usb 1-1: new full speed USB device using musb_hdrc and address 2
hci_usb_probe: udev c7269200 intf c7268160
hci_register_dev: c07abe00 name  type 1 owner 00000000
hci_sock_dev_event: hdev hci0 event 1
hci_send_to_sock: hdev 00000000 len 8
hci_usb_probe: udev c7269200 intf c72680a0
hci_usb_probe: udev c7269200 intf c7268be0
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 0.0.0.0, my address is 192.168.5.102
IP-Config: Complete:
      device=eth0, addr=192.168.55.112, mask=255.255.255.0, gw=192.168.55.1,
     host=192.168.55.112, domain=, nis-domain=(none),
     bootserver=0.0.0.0, rootserver=192.168.55.114, rootpath=
Looking up port of RPC 100003/2 on 192.168.55.114
Looking up port of RPC 100005/1 on 192.168.55.114
VFS: Mounted root (nfs filesystem).
Freeing init memory: 144K
INIT: version 2.85 booting
Mounting a tmpfs over /dev...done.
Creating initial device nodes...done.
Activating swap...done.
Remounting root filesystem...done.
Calculating module dependencies
Loading modules:
Starting checking all file systems: fsck
fsck 1.35 (28-Feb-2004)
Starting mounting local filesystems: mount nothing was mounted
Cleaning: /etc/network/ifstate.
Setting up IP spoofing protection: rp_filter.
Disable TCP/IP Explicit Congestion Notification: done.
Starting network interfaces: done.
Starting hotplug subsystem:
   pci
   pci      [success]
   usb
   usb      [success]
   isapnp
   isapnp   [success]
   ide
   ide      [success]
   input
   input    [success]
   scsi
   scsi     [success]
done.
Starting portmap daemon: portmap.
Cleaning: /tmp /var/lock /var/run done.
Setting pseudo-terminal access permissions...done.
Updating /etc/motd...done.
INIT: Entering runlevel: 3
Starting system log daemon: syslogd klogd.
Starting NFS common utilities: statd lockd.
Starting internet superserver: inetd.
Starting MontaVista target tools daemon: mvltdmvltd version 2.1 MontaVista Softw
are,Inc.
.
MontaVista(R) Linux(R) Professional Edition 4.0 (0501140)
  192.168.55.112 login: root
Last login: Thu Jan  1 12:00:36 2004 on console
Linux 192.168.55.112 2.6.10_mvl401-davinci_evm #29 Sun Dec 10 06:23:18 MST 2006 a
rmv5tejl GNU/Linux
  Welcome to MontaVista(R) Linux(R) Professional Edition 4.0 (0501140).
  root@192.168.55.112:~# lsusb
Bus 001 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle
Bus 001 Device 001: ID 04d6:0000 Mentor Graphics
root@192.168.55.112:~# hciconfig
hci_sock_create: sock c6724a00
hci_sock_ioctl: cmd 800448d2 arg 26008
hci_sock_ioctl: cmd 800448d3 arg 253e4
hci_dev_get: 0
hci0:   Type: USB
        BDhci_sock_release: sock c6724a00 sk c07aab60
 Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
        DOWN
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:0 acl:0 sco:0 commands:0 errors:0
  root@192.168.55.112:~# hciconfig hci0 up
hci_sock_create: sock c66c0a20
hci_sock_ioctl: cmd 800448d3 arg 253e4
hci_dev_get: 0
Mainhci_sock_ioctl: cmd 400448c9 arg 0
:1
hci_dev_get: 0
hci_dev_open: hci0 c07abe00
hci_usb_open: hci0
hci_usb_intr_rx_submit: hci0
hci_usb_bulk_rx_submit: hci0 urb c6a265b4
hci_usb_rx_complete: hci0 urb c6a26734 type 4 status 0 count 6 flags 0
__recv_frame: hci0 type 4 data c000b3c0 count 6
__recv_frame: new packet len 6
hci_usb_rx_complete: hci0 urb c6a26734 type 4 resubmit status 0
__hci_request: hci0 start
hci_init_req: hci0 0
hci_send_cmd: hci0 ogf 0x4 ocf 0x3 plen 0
hci_send_cmd: skb len 3
hci_send_cmd: hci0 ogf 0x4 ocf 0x5 plen 0
hci_cmd_task: hci0 cmd 1
hci_send_frame: hci0 type 1 len 3
hci_usb_send_frame: hci0 type 1 len 3
hci_usb_tx_process: hci0
hci_usb_send_ctrl: :1
hci_usb_send_ctrl: hci0 skb c046a140 len 3
__tx_submit: hci0 urb c6a26534 type 1
hci_send_cmd: skb len 3
hci_send_cmd: hci0 ogf 0x4 ocf 0x9 plen 0
hci_cmd_task: hci0 cmd 0
hci_send_cmd: skb len 3
hci_send_cmd: hci0 ogf 0x3 ocf 0x25 plen 0
hci_cmd_task: hci0 cmd 0
hci_send_cmd: skb len 3
hci_send_cmd: hci0 ogf 0x3 ocf 0x5 plen 2
hci_cmd_task: hci0 cmd 0
hci_send_cmd: skb len 5
hci_send_cmd: hci0 ogf 0x3 ocf 0x18 plen 2
hci_cmd_task: hci0 cmd 0
hci_send_cmd: skb len 5
hci_send_cmd: hci0 ogf 0x3 ocf 0x16 plen 2
hci_cmd_task: hci0 cmd 0
hci_send_cmd: skb len 5
hci_cmd_task: hci0 cmd 0
__hci_request: hci0 end: err -110
hci_usb_flush: hci0
hci_usb_close: hci0
hci_usb_unlink_urbs: hci0
hci_usb_unlink_urbs: hci0 unlinking _urb c6a26520 type 1 urb c6a26534
hci_usb_tx_complete: hci0 urb c6a26534 status -2 flags 0
hci_usb_unlink_urbs: hci0 freeing _urb c6a26520 type 1 urb c6a26534
hci_usb_unlink_urbs: hci0 unlinking _urb c6a265a0 type 2 urb c6a265b4
hci_usb_rx_complete: hci0 urb c6a265b4 type 2 status -2 count 0 flags 0
hci_usb_unlink_urbs: hci0 freeing _urb c6a265a0 type 2 urb c6a265b4
hci_usb_unlink_urbs: hci0 unlinking _urb c6a26720 type 4 urb c6a26734
hci_usb_rx_complete: hci0 urb c6a26734 type 4 status -2 count 0 flags 0
hci_usb_unlink_urbs: hci0 freeing _urb c6a26720 type 4 urb c6a26734
hci_usb_flush: hci0
Can't init device hchci_sock_release: sock c66c0a20 sk c07aa8a0
i0: Connection timed out (110)
root@192.168.55.112:~#

 
---------------------------------
Everyone is raving about the all-new Yahoo! Mail beta.
--0-1719768384-1165814563=:12200
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi,</div>  <div>&nbsp;</div>  <div>I'm new to this list and I'm trying to get my linux board running using usb bluez.</div>  <div>&nbsp;</div>  <div>I ran into the following issue of a timeout (110) when performing "hciconfig hci0 up". </div>  <div>&nbsp;</div>  <div>You will notice I turned on&nbsp;debug in hope that&nbsp;someone could see my error and help me correct it. </div>  <div>&nbsp;</div>  <div>I have tried 5 different dongle types with no luck.</div>  <div>&nbsp;</div>  <div>I would appreciate any ideas or other things to try.</div>  <div>&nbsp;</div>  <div>Thanks Will</div>  <div>&nbsp;</div>  <DIV>U-Boot 1.1.3 (Mar&nbsp; 3 2006 - 01:16:59)</DIV>  <DIV>U-Boot code: 81080000 -&gt; 810973A8&nbsp; BSS: -&gt; 810A02B8<BR>RAM Configuration:<BR>Bank #0: 80000000 256 MB<BR>MY AMD Flash: 16 MB<BR>In:&nbsp;&nbsp;&nbsp; serial<BR>Out:&nbsp;&nbsp; serial<BR>Err:&nbsp;&nbsp; serial<BR>ARM Clock :- 283MZ<BR>DDR Clock :- 189MZ<BR>Hit any key to stop autoboot:&nbsp;
 0<BR>BOOTP broadcast 1<BR>DHCP client bound to address 192.168.55.112<BR>TFTP from server 192.168.55.114; our IP address is 192.168.55.112<BR>Filename 'uImage'.<BR>Load address: 0x80700000<BR>Loading: #################################################################<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #################################################################<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #################################################################<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #################################################################<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #######################<BR>done<BR>Bytes transferred = 1444884 (160c14 hex)<BR>## Booting image at 80700000 ...<BR>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.10_mvl401-davinci_evm<BR>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; ARM Linux Kernel Image (uncompressed)<BR>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1444820
 Bytes =&nbsp; 1.4 MB<BR>&nbsp;&nbsp; Load Address: 80008000<BR>&nbsp;&nbsp; Entry Point:&nbsp; 80008000<BR>&nbsp;&nbsp; Verifying Checksum ... OK<BR>OK</DIV>  <DIV>Starting kernel ...</DIV>  <DIV>Uncompressing Linux.............................................................<BR>................................. done, booting the.Linux version 2.6.10_mvl401-<BR>davinci_evm (<A href="http://us.f502.mail.yahoo.com/ym/Compose?To=root@linux" target=_blank rel=nofollow><FONT color=#003399>root@linux</FONT></A>) (gcc version 3.4.3 (MontaVista 3.4.3-25.0.30.0501131 20<BR>05-07-23)) #29 Sun Dec 10 06:23:18 MST 2006<BR>CPU: ARM926EJ-Sid(wb) [41069265] revision 5 (ARMv5TEJ)<BR>CPU0: D VIVT write-back cache<BR>CPU0: I cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets<BR>CPU0: D cache: 8192 bytes, associativity 4, 32 byte lines, 64 sets<BR>Machine: DaVinci EVM<BR>Memory policy: ECC disabled, Data cache writeback<BR>Built 1 zonelists<BR>Kernel command line:
 console=ttyS0,115200n8 noinitrd rw ip=dhcp root=/dev/nfs nf<BR>sroot=192.168.55.114:/home/guest/workdir/filesys,nolock mem=120M<BR>PID hash table entries: 512 (order: 9, 8192 bytes)<BR>Console: colour dummy device 80x30<BR>Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)<BR>Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)<BR>Memory: 120MB = 120MB total<BR>Memory: 118528KB available (2477K code, 509K data, 144K init)<BR>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)<BR>CPU: Testing write buffer coherency: ok<BR>spawn_desched_task(00000000)<BR>desched cpu_callback 3/00000000<BR>ksoftirqd started up.<BR>desched cpu_callback 2/00000000<BR>desched thread 0 started up.<BR>NET: Registered protocol family 16<BR>Registering platform device 'musb_hdrc'. Parent at platform<BR>DaVinci I2C DEBUG: 12:57:03 Dec&nbsp; 9 2006<BR>Registering platform device 'i2c'. Parent at platform<BR>SCSI subsystem initialized<BR>usbcore: registered new driver
 usbfs<BR>usbcore: registered new driver hub<BR>Bluetooth: Core ver 2.7<BR>NET: Registered protocol family 31<BR>Bluetooth: HCI device and connection manager initialized<BR>Bluetooth: HCI socket layer initialized<BR>JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.<BR>yaffs Dec&nbsp; 9 2006 12:56:10 Installing.<BR>Registering platform device 'davincifb.0'. Parent at platform<BR>Setting Up Clocks for DM420 OSD<BR>Console: switching to colour frame buffer device 90x30<BR>fb0: dm_osd0_fb frame buffer device<BR>fb1: dm_vid0_fb frame buffer device<BR>fb2: dm_osd1_fb frame buffer device<BR>fb3: dm_vid1_fb frame buffer device<BR>Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled<BR>Registering platform device 'serial8250'. Parent at platform<BR>ttyS0 at MMIO 0x1c20000 (irq = 40) is a 16550A<BR>io scheduler noop registered<BR>io scheduler anticipatory registered<BR>RAMDISK driver initialized: 1 RAM disks of 32768K size 1024 blocksize<BR>Registering
 platform device 'ti_davinci_emac'. Parent at platform<BR>TI DaVinci EMAC: MAC address is 00:0e:99:02:55:0b<BR>TI DaVinci EMAC Linux version updated 4.0<BR>TI DaVinci EMAC: Installed 1 instances.<BR>netconsole: not configured, aborting<BR>i2c /dev entries driver<BR>Linux video capture interface: v1.00<BR>Registering platform device 'vpfe.1'. Parent at platform<BR>DaVinci v4l2 capture driver V1.0 loaded<BR>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2<BR>ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx<BR>hda: TOSHIBA MK4032GAX, ATA DISK drive<BR>elevator: using anticipatory as default io scheduler<BR>ide0 at 0xe10661f0-0xe10661f7,0xe10663f6 on irq 22<BR>hda: max request size: 1024KiB<BR>hda: 78140160 sectors (40007 MB), CHS=16383/255/63<BR>&nbsp;hda: hda1 hda2<BR>&nbsp;&nbsp;&nbsp; ide0: BM-DMA at 0xe1066000-0xe1066007, BIOS settings: hda:pio, hdb:pio<BR>usbcore: registered new driver usbserial<BR>drivers/usb/serial/usb-serial.c: USB
 Serial Driver core v2.0<BR>ics TIRA-1 IR Transceiver<BR>usbcore: registered new driver ftdi_sio<BR>drivers/usb/serial/ftdi_sio.c: v1.4.1:USB FTDI Serial Converters Driver<BR>mice: PS/2 mouse device common for all mice<BR>musb_hdrc: version 2.2a/db-0.4.8 [pio] [host] [debug=3]<BR>musb_hdrc: USB Host mode controller at c8060000 using PIO, IRQ 12<BR>musb_hdrc musb_hdrc: new USB bus registered, assigned bus number 1<BR>hub 1-0:1.0: USB hub found<BR>hub 1-0:1.0: 1 port detected<BR>Bluetooth: HCI USB driver ver 2.7<BR>usbcore: registered new driver hci_usb<BR>Bluetooth: HCI UART driver ver 2.1<BR>Bluetooth: HCI H4 protocol initialized<BR>Bluetooth: HCI BCSP protocol initialized<BR>Registering platform device 'davinci-audio.0'. Parent at platform<BR>NET: Registered protocol family 2<BR>IP: routing cache hash table of 512 buckets, 4Kbytes<BR>TCP: Hash tables configured (established 8192 bind 16384)<BR>NET: Registered protocol family 1<BR>NET: Registered protocol family
 17<BR>hci_register_proto: c02b71a8 name L2CAP id 0<BR>Bluetooth: L2CAP ver 2.6<BR>Bluetooth: L2CAP socket layer initialized<BR>Bluetooth: RFCOMM ver 1.3<BR>Bluetooth: RFCOMM socket layer initialized<BR>Bluetooth: RFCOMM TTY layer initialized<BR>Bluetooth: BNEP (Ethernet Emulation) ver 1.2<BR>Bluetooth: HIDP (Human Interface Emulation) ver 1.0<BR>usb 1-1: new full speed USB device using musb_hdrc and address 2<BR>hci_usb_probe: udev c7269200 intf c7268160<BR>hci_register_dev: c07abe00 name&nbsp; type 1 owner 00000000<BR>hci_sock_dev_event: hdev hci0 event 1<BR>hci_send_to_sock: hdev 00000000 len 8<BR>hci_usb_probe: udev c7269200 intf c72680a0<BR>hci_usb_probe: udev c7269200 intf c7268be0<BR>Sending DHCP requests ., OK<BR>IP-Config: Got DHCP answer from 0.0.0.0, my address is 192.168.5.102<BR>IP-Config: Complete:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=eth0, addr=192.168.55.112, mask=255.255.255.0, gw=192.168.55.1,<BR>&nbsp;&nbsp;&nbsp;&nbsp; host=192.168.55.112, domain=,
 nis-domain=(none),<BR>&nbsp;&nbsp;&nbsp;&nbsp; bootserver=0.0.0.0, rootserver=192.168.55.114, rootpath=<BR>Looking up port of RPC 100003/2 on 192.168.55.114<BR>Looking up port of RPC 100005/1 on 192.168.55.114<BR>VFS: Mounted root (nfs filesystem).<BR>Freeing init memory: 144K<BR>INIT: version 2.85 booting<BR>Mounting a tmpfs over /dev...done.<BR>Creating initial device nodes...done.<BR>Activating swap...done.<BR>Remounting root filesystem...done.<BR>Calculating module dependencies<BR>Loading modules:<BR>Starting checking all file systems: fsck<BR>fsck 1.35 (28-Feb-2004)<BR>Starting mounting local filesystems: mount nothing was mounted<BR>Cleaning: /etc/network/ifstate.<BR>Setting up IP spoofing protection: rp_filter.<BR>Disable TCP/IP Explicit Congestion Notification: done.<BR>Starting network interfaces: done.<BR>Starting hotplug subsystem:<BR>&nbsp;&nbsp; pci<BR>&nbsp;&nbsp; pci&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [success]<BR>&nbsp;&nbsp; usb<BR>&nbsp;&nbsp;
 usb&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [success]<BR>&nbsp;&nbsp; isapnp<BR>&nbsp;&nbsp; isapnp&nbsp;&nbsp; [success]<BR>&nbsp;&nbsp; ide<BR>&nbsp;&nbsp; ide&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [success]<BR>&nbsp;&nbsp; input<BR>&nbsp;&nbsp; input&nbsp;&nbsp;&nbsp; [success]<BR>&nbsp;&nbsp; scsi<BR>&nbsp;&nbsp; scsi&nbsp;&nbsp;&nbsp;&nbsp; [success]<BR>done.<BR>Starting portmap daemon: portmap.<BR>Cleaning: /tmp /var/lock /var/run done.<BR>Setting pseudo-terminal access permissions...done.<BR>Updating /etc/motd...done.<BR>INIT: Entering runlevel: 3<BR>Starting system log daemon: syslogd klogd.<BR>Starting NFS common utilities: statd lockd.<BR>Starting internet superserver: inetd.<BR>Starting MontaVista target tools daemon: mvltdmvltd version 2.1 MontaVista Softw<BR>are,Inc.<BR>.<BR>MontaVista(R) Linux(R) Professional Edition 4.0 (0501140)</DIV>  <DIV>192.168.55.112 login: root<BR>Last login: Thu Jan&nbsp; 1 12:00:36 2004 on console<BR>Linux 192.168.55.112 2.6.10_mvl401-davinci_evm #29
 Sun Dec 10 06:23:18 MST 2006 a<BR>rmv5tejl GNU/Linux</DIV>  <DIV>Welcome to MontaVista(R) Linux(R) Professional Edition 4.0 (0501140).</DIV>  <DIV><A href="mailto:root@192.168.55.112" target=_blank rel=nofollow><FONT color=#003399>root@192.168.55.112</FONT></A>:~# lsusb<BR>Bus 001 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle<BR>Bus 001 Device 001: ID 04d6:0000 Mentor Graphics<BR><A href="mailto:root@192.168.55.112" target=_blank rel=nofollow><FONT color=#003399>root@192.168.55.112</FONT></A>:~# hciconfig<BR>hci_sock_create: sock c6724a00<BR>hci_sock_ioctl: cmd 800448d2 arg 26008<BR>hci_sock_ioctl: cmd 800448d3 arg 253e4<BR>hci_dev_get: 0<BR>hci0:&nbsp;&nbsp; Type: USB<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BDhci_sock_release: sock c6724a00 sk c07aab60<BR>&nbsp;Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DOWN<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:0 acl:0 sco:0 events:0
 errors:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <SPAN id=lw_1165813755_0 style="BORDER-BOTTOM: #0066cc 1px dashed">TX</SPAN> bytes:0 acl:0 sco:0 commands:0 errors:0</DIV>  <DIV><A href="mailto:root@192.168.55.112" target=_blank rel=nofollow><FONT color=#003399>root@192.168.55.112</FONT></A>:~# hciconfig hci0 up<BR>hci_sock_create: sock c66c0a20<BR>hci_sock_ioctl: cmd 800448d3 arg 253e4<BR>hci_dev_get: 0<BR>Mainhci_sock_ioctl: cmd 400448c9 arg 0<BR>:1<BR>hci_dev_get: 0<BR>hci_dev_open: hci0 c07abe00<BR>hci_usb_open: hci0<BR>hci_usb_intr_rx_submit: hci0<BR>hci_usb_bulk_rx_submit: hci0 urb c6a265b4<BR>hci_usb_rx_complete: hci0 urb c6a26734 type 4 status 0 count 6 flags 0<BR>__recv_frame: hci0 type 4 data c000b3c0 count 6<BR>__recv_frame: new packet len 6<BR>hci_usb_rx_complete: hci0 urb c6a26734 type 4 resubmit status 0<BR>__hci_request: hci0 start<BR>hci_init_req: hci0 0<BR>hci_send_cmd: hci0 ogf 0x4 ocf 0x3 plen 0<BR>hci_send_cmd: skb len 3<BR>hci_send_cmd: hci0 ogf
 0x4 ocf 0x5 plen 0<BR>hci_cmd_task: hci0 cmd 1<BR>hci_send_frame: hci0 type 1 len 3<BR>hci_usb_send_frame: hci0 type 1 len 3<BR>hci_usb_tx_process: hci0<BR>hci_usb_send_ctrl: :1<BR>hci_usb_send_ctrl: hci0 skb c046a140 len 3<BR>__tx_submit: hci0 urb c6a26534 type 1<BR>hci_send_cmd: skb len 3<BR>hci_send_cmd: hci0 ogf 0x4 ocf 0x9 plen 0<BR>hci_cmd_task: hci0 cmd 0<BR>hci_send_cmd: skb len 3<BR>hci_send_cmd: hci0 ogf 0x3 ocf 0x25 plen 0<BR>hci_cmd_task: hci0 cmd 0<BR>hci_send_cmd: skb len 3<BR>hci_send_cmd: hci0 ogf 0x3 ocf 0x5 plen 2<BR>hci_cmd_task: hci0 cmd 0<BR>hci_send_cmd: skb len 5<BR>hci_send_cmd: hci0 ogf 0x3 ocf 0x18 plen 2<BR>hci_cmd_task: hci0 cmd 0<BR>hci_send_cmd: skb len 5<BR>hci_send_cmd: hci0 ogf 0x3 ocf 0x16 plen 2<BR>hci_cmd_task: hci0 cmd 0<BR>hci_send_cmd: skb len 5<BR>hci_cmd_task: hci0 cmd 0<BR>__hci_request: hci0 end: err -110<BR>hci_usb_flush: hci0<BR>hci_usb_close: hci0<BR>hci_usb_unlink_urbs: hci0<BR>hci_usb_unlink_urbs: hci0 unlinking _urb c6a26520
 type 1 urb c6a26534<BR>hci_usb_tx_complete: hci0 urb c6a26534 status -2 flags 0<BR>hci_usb_unlink_urbs: hci0 freeing _urb c6a26520 type 1 urb c6a26534<BR>hci_usb_unlink_urbs: hci0 unlinking _urb c6a265a0 type 2 urb c6a265b4<BR>hci_usb_rx_complete: hci0 urb c6a265b4 type 2 status -2 count 0 flags 0<BR>hci_usb_unlink_urbs: hci0 freeing _urb c6a265a0 type 2 urb c6a265b4<BR>hci_usb_unlink_urbs: hci0 unlinking _urb c6a26720 type 4 urb c6a26734<BR>hci_usb_rx_complete: hci0 urb c6a26734 type 4 status -2 count 0 flags 0<BR>hci_usb_unlink_urbs: hci0 freeing _urb c6a26720 type 4 urb c6a26734<BR>hci_usb_flush: hci0<BR>Can't init device hchci_sock_release: sock c66c0a20 sk c07aa8a0<BR>i0: Connection timed out (110)<BR><A href="mailto:root@192.168.55.112" target=_blank rel=nofollow><FONT color=#003399>root@192.168.55.112</FONT></A>:~#</DIV><p>&#32;


<hr size=1>Everyone is raving about <a href="http://us.rd.yahoo.com/evt=42297/*http://advision.webevents.yahoo.com/mailbeta">the all-new Yahoo! Mail beta.</a>
--0-1719768384-1165814563=:12200--


--===============1765004165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1765004165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1765004165==--
