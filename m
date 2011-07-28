Return-Path: <cyrus@holtmann.org>
Message-ID: <4E312F5A.6090402@powercraft.nl>
Date: Thu, 28 Jul 2011 11:43:54 +0200
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Latitude D531 bluetooth 413c:8141 not working...
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBDED3512F2FB8DF090D1F23E"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBDED3512F2FB8DF090D1F23E
Content-Type: multipart/mixed;
 boundary="------------010400010905010903060309"

This is a multi-part message in MIME format.
--------------010400010905010903060309
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,

Could somebody have a look at the pastebin or attachment.

http://paste.debian.net/124343/

The adapter is not working, but the led is on and I can turn the device
on and off.

I tried A08 bios and the latest A10. I also tried the 3.0 kernel (ubuntu
daily live) and the debian 2.6.39 kernels.

I asked some questions on #bluez they advices me to sent a mail here. I
don't have time to build and test my own kernels. So I hope somebody
sees what is is wrong here and hopefully come up with a fix.

Thanks in advance,

Kind regards,

Jelle de Jong

--------------010400010905010903060309
Content-Type: text/plain;
 name="bt-debug-dell-latitude-d531.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="bt-debug-dell-latitude-d531.txt"

$ sudo dmidecode -t system
# dmidecode 2.9
SMBIOS 2.4 present.

Handle 0x0100, DMI type 1, 27 bytes
System Information
    Manufacturer: Dell Inc.
    Product Name: Latitude D531
    Version: Not Specified
    Serial Number: J2XLY2J
    UUID: 44454C4C-3200-1058-804C-CAC04F59324A
    Wake-up Type: Power Switch
    SKU Number: Not Specified
    Family:

Handle 0x2000, DMI type 32, 11 bytes
System Boot Information
    Status: No errors detected


$ sudo getSystemId
Libsmbios:    2.0.3
System ID:    0x0206
Service Tag:  J2XLY2J
Express Service Code: 41536247995
Product Name: Latitude D531
BIOS Version: A10
Vendor:       Dell Inc.
Is Dell:      1

$ sudo lsusb -d 413c:8141 -vvv

Bus 005 Device 002: ID 413c:8141 Dell Computer Corp.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x413c Dell Computer Corp.
  idProduct          0x8141
  bcdDevice           43.15
  iManufacturer           0
  iProduct                0
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           59
    bNumInterfaces          2
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
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      1 Keyboard
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      74
         Report Descriptors:
           ** UNAVAILABLE **
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
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      63
         Report Descriptors:
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               1
Device Status:     0x0001
  Self Powered

$ sudo dellWirelessCtl --sw_bt 1 --bt 1
Wireless Info:
    Hardware switch not supported
    WiFi Locator not supported
    Wireless Keyboard not supported
    NVRAM Size: 0 bytes
    NVRAM format version: 0

Radio Status for WLAN:
    WLAN supported
    WLAN installed
    WLAN enabled
    Status Code: 0

Radio Status for Bluetooth:
    Bluetooth supported
    Bluetooth installed
    Bluetooth enabled
    Status Code: 0

Radio Status for WWAN:
    WWAN not supported
    Status Code: 3

Wireless Switch Configuration
    WLAN switch control on
    Bluetooth switch control on
    WWAN switch control off
    switch config not locked
    WiFi locator disabled
    WiFi Locator config not locked

$ sudo modprobe btusb

$ modinfo btusb
filename:       /lib/modules/2.6.39-2-686-pae/kernel/drivers/bluetooth/bt=
usb.ko
license:        GPL
version:        0.6
description:    Generic Bluetooth USB driver ver 0.6
author:         Marcel Holtmann <marcel@holtmann.org>
srcversion:     7BA5480215E4B8ADB9DFB5B
alias:          usb:v0C10p0000d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0BDBp1002d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v044Ep3002d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v044Ep3001d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v04BFp030Ad*dc*dsc*dp*ic*isc*ip*
alias:          usb:v057Cp3800d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v05ACp821Ad*dc*dsc*dp*ic*isc*ip*
alias:          usb:v05ACp821Bd*dc*dsc*dp*ic*isc*ip*
alias:          usb:v05ACp8218d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v05ACp8215d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v05ACp8213d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v*p*d*dcE0dsc01dp01ic*isc*ip*
depends:        usbcore,bluetooth
intree:         Y
vermagic:       2.6.39-2-686-pae SMP mod_unload modversions 686
parm:           ignore_dga:Ignore devices with id 08fd:0001 (bool)
parm:           ignore_csr:Ignore devices with id 0a12:0001 (bool)
parm:           ignore_sniffer:Ignore devices with id 0a12:0002 (bool)
parm:           disable_scofix:Disable fixup of wrong SCO buffer size (bo=
ol)
parm:           force_scofix:Force fixup of wrong SCO buffers size (bool)=

parm:           reset:Send HCI reset command on initialization (bool)

$ hcitool dev
Devices:


--------------010400010905010903060309--

--------------enigBDED3512F2FB8DF090D1F23E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iJwEAQECAAYFAk4xL2MACgkQ1WclBW9j5HkVRQP/So+CsCYsGMDdXlDw6jVmIGGc
mhDgIXE6wr1kMYP+lc5laFcseoODI10V8IgHOML2i1JzULFDeCU1QDuasM2ItJK0
RLzNXlGjMLjlCS7Fn5Cf2u3FBIQUVU/zO8EsK3vF1Kqe8EjGi4v2euryezWAs+io
Si8Zd5+4n0iYG9+U2sc=
=H/vG
-----END PGP SIGNATURE-----

--------------enigBDED3512F2FB8DF090D1F23E--
