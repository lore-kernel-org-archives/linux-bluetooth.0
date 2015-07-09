Return-Path: <cyrus@holtmann.org>
Message-ID: <a48f30f621c508955ba989117690fe73.squirrel@mungewell.org>
Date: Thu, 9 Jul 2015 19:29:20 -0400
Subject: [Fwd: BUG: 4.2rc1 System lockup with BT dongle insert]
From: simon@mungewell.org
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Resending as original post did not appear on list/archives.... maybe
attachments are blocked.

Cheers,
Simon.

---------------------------- Original Message ----------------------------
Subject: BUG: 4.2rc1 System lockup with BT dongle insert
From:    simon@mungewell.org
Date:    Wed, July 8, 2015 11:08 am
To:      linux-bluetooth@vger.kernel.org
Cc:      simon@mungewell.org
--------------------------------------------------------------------------

Hi,
Noticed that 4.2rc1 is locking up when I insert my USB BT dongle, this did
not occur on 4.1 and older kernels. I've seen this on both 64 and 32 bit
kernels on different machines (all on Xubuntu 15.04, ie with older Bluez
if that makes a difference).

Dongle is:
http://www.memoryexpress.com/Products/MX43823

Below are image showing last reports of syslog, a 'complete' syslog
insertion with 3.19 kernel and a lsusb log.

https://www.flickr.com/photos/24244464@N03/19375918529/sizes/o/

Cheers,
Simon.

lsusb
--
Bus 002 Device 002: ID 0a5c:21e8 Broadcom Corp. BCM20702A0 Bluetooth 4.0
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass         1
  bDeviceProtocol         1
  bMaxPacketSize0        64
  idVendor           0x0a5c Broadcom Corp.
  idProduct          0x21e8 BCM20702A0 Bluetooth 4.0
  bcdDevice            1.12
  iManufacturer           1
  iProduct                2
  iSerial                 3
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          218
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      1
      bInterfaceProtocol      1
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
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
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
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      1
      bInterfaceProtocol      1
      iInterface              0
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
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      1
      bInterfaceProtocol      1
      iInterface              0
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
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      1
      bInterfaceProtocol      1
      iInterface              0
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
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      1
      bInterfaceProtocol      1
      iInterface              0
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
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       4
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      1
      bInterfaceProtocol      1
      iInterface              0
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
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       5
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      1
      bInterfaceProtocol      1
      iInterface              0
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
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       254 Application Specific Interface
      bInterfaceSubClass      1 Device Firmware Update
      bInterfaceProtocol      1
      iInterface              0
      Device Firmware Upgrade Interface Descriptor:
        bLength                             9
        bDescriptorType                    33
        bmAttributes                        5
          Will Not Detach
          Manifestation Tolerant
          Upload Unsupported
          Download Supported
        wDetachTimeout                   5000 milliseconds
        wTransferSize                      64 bytes
        bcdDFUVersion                   1.10
--

expected log from 3.19 kernel
--
Jul  7 21:42:56 retrobox kernel: [  107.180094] usb 2-1: new full-speed
USB device
number 2 using uhci_hcd
Jul  7 21:42:56 retrobox kernel: [  107.348165] usb 2-1: New USB device
found,
idVendor=0a5c, idProduct=21e8
Jul  7 21:42:56 retrobox kernel: [  107.348176] usb 2-1: New USB device
strings:
Mfr=1, Product=2, SerialNumber=3
Jul  7 21:42:56 retrobox kernel: [  107.348182] usb 2-1: Product: BCM20702A0
Jul  7 21:42:56 retrobox kernel: [  107.348188] usb 2-1: Manufacturer:
Broadcom Corp
Jul  7 21:42:56 retrobox kernel: [  107.348194] usb 2-1: SerialNumber:
5CF37065AA85
Jul  7 21:42:56 retrobox mtp-probe: checking bus 2, device 2:
"/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1"
Jul  7 21:42:56 retrobox mtp-probe: bus: 2, device: 2 was not an MTP device
Jul  7 21:42:57 retrobox kernel: [  107.514535] Bluetooth: Core ver 2.20
Jul  7 21:42:57 retrobox kernel: [  107.514571] NET: Registered protocol
family 31
Jul  7 21:42:57 retrobox kernel: [  107.514573] Bluetooth: HCI device and
connection
manager initialized
Jul  7 21:42:57 retrobox kernel: [  107.514580] Bluetooth: HCI socket
layer initialized
Jul  7 21:42:57 retrobox kernel: [  107.514585] Bluetooth: L2CAP socket layer
initialized
Jul  7 21:42:57 retrobox kernel: [  107.514595] Bluetooth: SCO socket
layer initialized
Jul  7 21:42:57 retrobox kernel: [  107.546061] usbcore: registered new
interface
driver btusb
Jul  7 21:42:57 retrobox kernel: [  107.562441] bluetooth hci0: Direct
firmware load
for brcm/BCM20702A0-0a5c-21e8.hcd failed with error -2
Jul  7 21:42:57 retrobox kernel: [  107.562452] Bluetooth: hci0: BCM: patch
brcm/BCM20702A0-0a5c-21e8.hcd not found
Jul  7 21:42:58 retrobox systemd[1]: Starting Load/Save RF Kill Switch
Status of
rfkill1...
Jul  7 21:42:58 retrobox systemd[1]: Starting Bluetooth service...
Jul  7 21:42:58 retrobox systemd[1]: Started Load/Save RF Kill Switch
Status of
rfkill1.
Jul  7 21:42:58 retrobox bluetoothd[1477]: Bluetooth daemon 4.101
Jul  7 21:42:58 retrobox bluetoothd[1477]: bluetoothd[1477]: Bluetooth
daemon 4.101
Jul  7 21:42:58 retrobox systemd[1]: Started Bluetooth service.
Jul  7 21:42:58 retrobox systemd[1]: Reached target Bluetooth.
Jul  7 21:42:58 retrobox systemd[1]: Starting Bluetooth.
Jul  7 21:42:58 retrobox bluetoothd[1477]: Starting SDP server
Jul  7 21:42:58 retrobox bluetoothd[1477]: bluetoothd[1477]: Starting SDP
server
Jul  7 21:42:58 retrobox bluetoothd[1477]: DIS cannot start: GATT is disabled
Jul  7 21:42:58 retrobox bluetoothd[1477]: Failed to init deviceinfo plugin
Jul  7 21:42:58 retrobox bluetoothd[1477]: Failed to init proximity plugin
Jul  7 21:42:58 retrobox bluetoothd[1477]: Failed to init time plugin
Jul  7 21:42:58 retrobox bluetoothd[1477]: Failed to init alert plugin
Jul  7 21:42:58 retrobox bluetoothd[1477]: Failed to init thermometer plugin
Jul  7 21:42:58 retrobox bluetoothd[1477]: bluetoothd[1477]: DIS cannot
start: GATT
is disabled
Jul  7 21:42:58 retrobox bluetoothd[1477]: bluetoothd[1477]: Failed to init
deviceinfo plugin
Jul  7 21:42:58 retrobox bluetoothd[1477]: bluetoothd[1477]: Failed to init
proximity plugin
Jul  7 21:42:58 retrobox bluetoothd[1477]: bluetoothd[1477]: Failed to
init time plugin
Jul  7 21:42:58 retrobox bluetoothd[1477]: bluetoothd[1477]: Failed to
init alert
plugin
Jul  7 21:42:58 retrobox bluetoothd[1477]: bluetoothd[1477]: Failed to init
thermometer plugin
Jul  7 21:42:58 retrobox kernel: [  108.618280] Bluetooth: BNEP (Ethernet
Emulation)
ver 1.3
Jul  7 21:42:58 retrobox kernel: [  108.618286] Bluetooth: BNEP filters:
protocol
multicast
Jul  7 21:42:58 retrobox kernel: [  108.618294] Bluetooth: BNEP socket layer
initialized
Jul  7 21:42:58 retrobox bluetoothd[1477]: bluetoothd[1477]: Failed to init
gatt_example plugin
Jul  7 21:42:58 retrobox bluetoothd[1477]: Failed to init gatt_example plugin
Jul  7 21:42:58 retrobox bluetoothd[1477]: Bluetooth Management interface
initialized
Jul  7 21:42:58 retrobox bluetoothd[1477]: bluetoothd[1477]: Bluetooth
Management
interface initialized
Jul  7 21:42:58 retrobox NetworkManager[586]: <info> use BlueZ version 4
Jul  7 21:42:58 retrobox kernel: [  108.637945] Bluetooth: RFCOMM TTY
layer initialized
Jul  7 21:42:58 retrobox kernel: [  108.637959] Bluetooth: RFCOMM socket
layer
initialized
Jul  7 21:42:58 retrobox kernel: [  108.637970] Bluetooth: RFCOMM ver 1.11
Jul  7 21:42:58 retrobox bluetoothd[1477]: Unknown command complete for
opcode 19
Jul  7 21:42:58 retrobox bluetoothd[1477]: bluetoothd[1477]: Unknown command
complete for opcode 19
Jul  7 21:42:58 retrobox bluetoothd[1477]: bluetoothd[1477]: Adapter
/org/bluez/1477/hci0 has been enabled
Jul  7 21:42:58 retrobox bluetoothd[1477]: Adapter /org/bluez/1477/hci0
has been
enabled
--

