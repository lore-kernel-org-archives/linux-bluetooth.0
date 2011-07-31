Return-Path: <cyrus@holtmann.org>
Message-ID: <4E354FC7.9000307@powercraft.nl>
Date: Sun, 31 Jul 2011 14:51:19 +0200
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Latitude D531 bluetooth 413c:8141 not working...
References: <4E312F5A.6090402@powercraft.nl>
In-Reply-To: <4E312F5A.6090402@powercraft.nl>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDE9DB34D5C21455004F3E0CF"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDE9DB34D5C21455004F3E0CF
Content-Type: multipart/mixed;
 boundary="------------070604060308070600010001"

This is a multi-part message in MIME format.
--------------070604060308070600010001
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 28-07-11 11:43, Jelle de Jong wrote:
> Could somebody have a look at the pastebin or attachment.
>=20
> http://paste.debian.net/124343/ (see attachment)
>=20
> The adapter is not working, but the led is on and I can turn the device=

> on and off.
>=20
> I tried A08 bios and the latest A10. I also tried the 3.0 kernel (ubunt=
u
> daily live) and the debian 2.6.39 kernels.
>=20
> I asked some questions on #bluez they advices me to sent a mail here. I=

> don't have time to build and test my own kernels. So I hope somebody
> sees what is is wrong here and hopefully come up with a fix.

Somebody able to help? (see attachment)

Kind regards,

Jelle de Jong

--------------070604060308070600010001
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


--------------070604060308070600010001--

--------------enigDE9DB34D5C21455004F3E0CF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iJwEAQECAAYFAk41T88ACgkQ1WclBW9j5HktzQP/ZM46SYTEOmx+h6zVz0JKRhK4
AorSVwZorj8iD5lPe2W+2m5l2xx6+5G2l0ke1vJfpD6ruEgy8ZKcFsxKapg/ZeL2
PzVCU5JKDDunlZP7v2U1JrVgKsBotBOjFpZCaKrHMV4a44TaFlPULkL7WPDrH0tc
nS8ydXfLa9Vz6eR3t3I=
=hiy1
-----END PGP SIGNATURE-----

--------------enigDE9DB34D5C21455004F3E0CF--
