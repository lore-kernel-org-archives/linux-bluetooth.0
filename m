Return-Path: <cyrus@holtmann.org>
Message-ID: <49D89DCD.7090808@pook.es>
Date: Sun, 05 Apr 2009 14:02:21 +0200
From: Stuart Pook <linux-bluetooth4@pook.es>
MIME-Version: 1.0
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: bluez 4.34 + Linksys USBBT100 + hcitool scan -> core dump
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hello

I normally use a Belkin F8T017 Bluetooth Adapter (for audio) which works ok but its range is rather limited.

I have a Linksys (Cisco) USBBT100 Bluetooth 1.1 Adapter which has a 1.2 dBi antenna. I used to use it with Bluez 3 and it had a better range than my Belkin F8T017. It used to work (but not for audio) with older versions of bluez 4. I tried it again with bluez 4.34 and now a simple "hcitool scan" makes bluetoothd core dump.

Bluetoothd does not crash when I swap my USBBT100 for my F8T017. A hcitool scan does however find fewer hosts.

It would be great if my USBBT100 worked again. Please let me know if I can send any more information.

thanks
Stuart

: root; valgrind /usr/local/sbin/bluetoothd -dn
==9799== Memcheck, a memory error detector.
==9799== Copyright (C) 2002-2008, and GNU GPL'd, by Julian Seward et al.
==9799== Using LibVEX rev 1884, a library for dynamic binary translation.
==9799== Copyright (C) 2004-2008, and GNU GPL'd, by OpenWorks LLP.
==9799== Using valgrind-3.4.1-Debian, a dynamic binary instrumentation framework.
==9799== Copyright (C) 2000-2008, and GNU GPL'd, by Julian Seward et al.
==9799== For more details, rerun with: -v
==9799== 
bluetoothd[9799]: Bluetooth daemon 4.34
bluetoothd[9799]: Enabling debug information
bluetoothd[9799]: parsing main.conf
bluetoothd[9799]: discovto=0
bluetoothd[9799]: Key file does not have key 'PairableTimeout'
bluetoothd[9799]: pageto=8192
bluetoothd[9799]: name=%h-%d
bluetoothd[9799]: class=0x000100
bluetoothd[9799]: inqmode=0
bluetoothd[9799]: Key file does not have key 'InitiallyPowered'
bluetoothd[9799]: Key file does not have key 'RememberPowered'
bluetoothd[9799]: Key file does not have key 'DeviceID'
bluetoothd[9799]: Key file does not have key 'ReverseServiceDiscovery'
bluetoothd[9799]: Starting SDP server
bluetoothd[9799]: Loading plugins /usr/local/lib/bluetooth/plugins
bluetoothd[9799]: register_interface: path /org/bluez/9799/any
bluetoothd[9799]: Registered interface org.bluez.Service on path /org/bluez/9799/any
bluetoothd[9799]: Parsing /etc/bluetooth/audio.conf failed: No such file or directory
bluetoothd[9799]: Unix socket created: 11
bluetoothd[9799]: Telephony plugin initialized
bluetoothd[9799]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes" 
bluetoothd[9799]: HCI dev 0 registered
bluetoothd[9799]: child 9802 forked
bluetoothd[9799]: HCI dev 0 already up
bluetoothd[9799]: Starting security manager 0
bluetoothd[9799]: periodic_inquiry_exit at adapter startup
bluetoothd[9799]: register_interface: path /org/bluez/9799/hci0
bluetoothd[9799]: Registered interface org.bluez.Service on path /org/bluez/9799/hci0
bluetoothd[9799]: headset_server_probe: path /org/bluez/9799/hci0
bluetoothd[9799]: Adding record with handle 0x10000
bluetoothd[9799]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[9799]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[9799]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[9799]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[9799]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[9799]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[9799]: Adding record with handle 0x10001
bluetoothd[9799]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[9799]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[9799]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[9799]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[9799]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[9799]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[9799]: a2dp_server_probe: path /org/bluez/9799/hci0
bluetoothd[9799]: SEP 0x4b526f0 registered: type:0 codec:0 seid:1
bluetoothd[9799]: Adding record with handle 0x10002
bluetoothd[9799]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[9799]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[9799]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[9799]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[9799]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[9799]: avrcp_server_probe: path /org/bluez/9799/hci0
bluetoothd[9799]: Adding record with handle 0x10003
bluetoothd[9799]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[9799]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[9799]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[9799]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[9799]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[9799]: Adding record with handle 0x10004
bluetoothd[9799]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[9799]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[9799]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[9799]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[9799]: Creating device /org/bluez/9799/hci0/dev_00_1A_45_2F_49_98
bluetoothd[9799]: Probe drivers for /org/bluez/9799/hci0/dev_00_1A_45_2F_49_98
bluetoothd[9799]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[9799]: Registered interface org.bluez.Audio on path /org/bluez/9799/hci0/dev_00_1A_45_2F_49_98
bluetoothd[9799]: Found Headset record
bluetoothd[9799]: Discovered Headset service on RFCOMM channel 2
bluetoothd[9799]: Registered interface org.bluez.Headset on path /org/bluez/9799/hci0/dev_00_1A_45_2F_49_98
bluetoothd[9799]: Found Handsfree record
bluetoothd[9799]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[9799]: Creating device /org/bluez/9799/hci0/dev_00_14_A7_74_D3_AF
bluetoothd[9799]: Creating device /org/bluez/9799/hci0/dev_00_03_89_B7_F8_D3
bluetoothd[9799]: Creating device /org/bluez/9799/hci0/dev_00_0A_94_94_4F_B3
bluetoothd[9799]: Creating device /org/bluez/9799/hci0/dev_00_03_89_DC_5C_9F
bluetoothd[9799]: Creating device /org/bluez/9799/hci0/dev_00_03_89_DC_FC_EC
bluetoothd[9799]: Creating device /org/bluez/9799/hci0/dev_00_03_89_FE_E6_19
bluetoothd[9799]: Creating device /org/bluez/9799/hci0/dev_00_0E_6D_8F_91_6A
bluetoothd[9799]: Creating device /org/bluez/9799/hci0/dev_00_17_E5_E6_25_AB
bluetoothd[9799]: Creating device /org/bluez/9799/hci0/dev_00_17_E5_16_88_6C
bluetoothd[9799]: Creating device /org/bluez/9799/hci0/dev_00_17_E5_0C_EA_70
bluetoothd[9799]: Changing service classes to 0x480104
==9799== Syscall param ioctl(generic) points to unaddressable byte(s)
==9799==    at 0x40007F2: (within /lib/ld-2.9.so)
==9799==    by 0x121A6F: adapter_start (in /usr/local/stow/bluez-4.34/sbin/bluetoothd)
==9799==    by 0x11C560: manager_start_adapter (in /usr/local/stow/bluez-4.34/sbin/bluetoothd)
==9799==    by 0x111DED: device_devup_setup (in /usr/local/stow/bluez-4.34/sbin/bluetoothd)
==9799==    by 0x11280D: main (in /usr/local/stow/bluez-4.34/sbin/bluetoothd)
==9799==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
bluetoothd[9802]: Can't set link policy on hci0: No such device (19)
==9802== Syscall param ioctl(generic) points to unaddressable byte(s)
==9802==    at 0x40007F2: (within /lib/ld-2.9.so)
==9802==    by 0x1127DB: main (in /usr/local/stow/bluez-4.34/sbin/bluetoothd)
==9802==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
bluetoothd[9799]: Adapter /org/bluez/9799/hci0 has been enabled
bluetoothd[9799]: Stopping security manager 0
bluetoothd[9799]: Changing service classes to 0x480104
==9802== 
bluetoothd[9799]: Entering main loop
==9802== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 45 from 3)
==9802== malloc/free: in use at exit: 29,123 bytes in 329 blocks.
==9802== malloc/free: 641 allocs, 312 frees, 250,062 bytes allocated.
==9802== For counts of detected errors, rerun with: -v
==9802== searching for pointers to 329 not-freed blocks.
==9802== checked 114,644 bytes.
==9802== 
==9802== LEAK SUMMARY:
==9802==    definitely lost: 0 bytes in 0 blocks.
==9802==      possibly lost: 744 bytes in 3 blocks.
==9802==    still reachable: 28,379 bytes in 326 blocks.
==9802==         suppressed: 0 bytes in 0 blocks.
==9802== Rerun with --leak-check=full to see details of leaked memory.
bluetoothd[9799]: child 9802 exited
bluetoothd[9799]: HCI dev 0 down
bluetoothd[9799]: Adapter /org/bluez/9799/hci0 has been disabled
bluetoothd[9799]: HCI dev 0 up
bluetoothd[9799]: Starting security manager 0
==9799== Stack overflow in thread 1: can't grow stack to 0xbe534fc4
==9799== 
==9799== Process terminating with default action of signal 11 (SIGSEGV): dumping core
==9799==  Access not within mapped region at address 0xBE534FC4
==9799==    at 0x4A1B3BA: __xstat (in /lib/i686/cmov/libc-2.9.so)
==9799==  If you believe this happened as a result of a stack overflow in your
==9799==  program's main thread (unlikely but possible), you can try to increase
==9799==  the size of the main thread stack using the --main-stacksize= flag.
==9799==  The main thread stack size used in this run was 8388608.
==9799== Stack overflow in thread 1: can't grow stack to 0xbe534fc0
==9799== 
==9799== Process terminating with default action of signal 11 (SIGSEGV)
==9799==  Access not within mapped region at address 0xBE534FC0
==9799==    at 0x48203EC: _vgnU_freeres (vg_preloaded.c:56)
==9799==  If you believe this happened as a result of a stack overflow in your
==9799==  program's main thread (unlikely but possible), you can try to increase
==9799==  the size of the main thread stack using the --main-stacksize= flag.
==9799==  The main thread stack size used in this run was 8388608.
==9799== 
==9799== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 45 from 3)
==9799== malloc/free: in use at exit: 44,018 bytes in 679 blocks.
==9799== malloc/free: 176,416 allocs, 175,737 frees, 1,525,621 bytes allocated.
==9799== For counts of detected errors, rerun with: -v
==9799== searching for pointers to 679 not-freed blocks.
==9799== checked 5,245,628 bytes.
==9799== 
==9799== LEAK SUMMARY:
==9799==    definitely lost: 0 bytes in 0 blocks.
==9799==      possibly lost: 744 bytes in 3 blocks.
==9799==    still reachable: 43,274 bytes in 676 blocks.
==9799==         suppressed: 0 bytes in 0 blocks.
==9799== Rerun with --leak-check=full to see details of leaked memory.
Segmentation fault


:; hcitool scan
Scanning ...
	00:19:B7:49:C5:76	n/a
	00:03:C9:D4:34:E9	Wanadoo_f3ed
	00:16:AE:4C:A3:2C	Livebox-A328

:; lsusb -d  0a12:0001
Bus 003 Device 006: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)
: root; lsusb -vd  0a12:0001

Bus 003 Device 006: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x0a12 Cambridge Silicon Radio, Ltd
  idProduct          0x0001 Bluetooth Dongle (HCI mode)
  bcdDevice            5.25
  iManufacturer           0 
  iProduct                0 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          193
    bNumInterfaces          3
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0019  1x 25 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0019  1x 25 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       4
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0021  1x 33 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0021  1x 33 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       5
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0031  1x 49 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0031  1x 49 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       254 Application Specific Interface
      bInterfaceSubClass      1 Device Firmware Update
      bInterfaceProtocol      0 
      iInterface              0 
      ** UNRECOGNIZED:  07 21 07 88 13 ff 03
Device Status:     0x0001
  Self Powered

:; uname -a
Linux kooka 2.6.28-1-686 #1 SMP Mon Feb 23 03:13:24 UTC 2009 i686 GNU/Linux

-- 
If the From address bounces, please see http://www.pook.it/.
