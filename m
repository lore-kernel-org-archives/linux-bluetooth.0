Return-Path: <cyrus@holtmann.org>
Message-ID: <5560B724.7020404@gmail.com>
Date: Sat, 23 May 2015 22:21:40 +0500
From: Sergey Kondakov <virtuousfox@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Bug in sixaxis plugin: stick axises are "jumping" from bogus input
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mNNuS69IDkkrwcIXc05STOOtT4I8p2ART"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mNNuS69IDkkrwcIXc05STOOtT4I8p2ART
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pretty much since update to Bluez-5 with its in-tree SixAxis/DS3 support
I've been experiencing this strange bug: about every minute both axises
of both sticks "jump" to their lowest position for one "frame" and then
back to normal. It only behaves like that under bluez 5, connected
wirelessly, and never under Windows=C2=AE or via USB.

Here's some data:

`sdl2-jstest` output:
[ ~ ] % sdl2-jstest --event 0
Joystick Name:     'PLAYSTATION(R)3 Controller'
Joystick GUID:     050000004c0500006802000000010000
Joystick Number:    0
Number of Axes:     4
Number of Buttons: 19
Number of Hats:     0
Number of Balls:    0
GameController:
  not a gamepad

Entering joystick test loop, press Ctrl-c to exit
SDL_JOYDEVICEADDED which:0
SDL_JOYAXISMOTION: joystick: 0 axis: 0 value: -32768
SDL_JOYAXISMOTION: joystick: 0 axis: 1 value: -32768
SDL_JOYAXISMOTION: joystick: 0 axis: 2 value: -32768
SDL_JOYAXISMOTION: joystick: 0 axis: 3 value: -32768
SDL_JOYAXISMOTION: joystick: 0 axis: 0 value: 0
SDL_JOYAXISMOTION: joystick: 0 axis: 1 value: 0
SDL_JOYAXISMOTION: joystick: 0 axis: 2 value: 0
SDL_JOYAXISMOTION: joystick: 0 axis: 3 value: 0

`evtest /dev/input/event15|grep ABS_X` output:
Event: time 1415565008.363798, type 3 (EV_ABS), code 0 (ABS_X), value 130=

Event: time 1415565008.394811, type 3 (EV_ABS), code 0 (ABS_X), value 129=

Event: time 1415565008.498793, type 3 (EV_ABS), code 0 (ABS_X), value 0
Event: time 1415565008.529810, type 3 (EV_ABS), code 0 (ABS_X), value 129=

Event: time 1415565008.734837, type 3 (EV_ABS), code 0 (ABS_X), value 130=


`jstest` output:
[ ~ ] % jstest --event /dev/input/js0| grep 'number 1'
Event: type 129, time 72291033, number 1, value 0
=2E..
Event: type 2, time 72508989, number 1, value -32767
Event: type 2, time 72509007, number 1, value 0
Event: type 2, time 72567545, number 1, value -32767
Event: type 2, time 72567577, number 1, value 0
Event: type 2, time 72649514, number 1, value -32767
Event: type 2, time 72649545, number 1, value 0

`lsusb -vvv` output on BT USB dongle:
Bus 007 Device 002: ID 1131:1004 Integrated System Solution Corp.
Bluetooth Device
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        16
  idVendor           0x1131 Integrated System Solution Corp.
  idProduct          0x1004 Bluetooth Device
  bcdDevice            3.73
  iManufacturer           1 ISSC
  iProduct                2 ISSCBTA
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          186
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
Device Status:     0x0000
  (Bus Powered)

Surely I don't need to elaborate on how useless it makes the device.

PS: Isn't its time already to get bluez a bugtracker ? It's unbelievable
how much bullshit one has to hoop over just to officially complain on
it. No wonder that bluez userspace always has been one of most broken,
unfinished, unreliable, un-userfriendly pieces of FOSS code ever. Or
maybe it's all inherited from Bluetooth=C2=AE mess of a standard and it's=

destined to suck.


--mNNuS69IDkkrwcIXc05STOOtT4I8p2ART
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlVgtyQACgkQrPLi+0dgLoawBwD+Nek8IPUMGT78fhB/DZmRUbQt
gCxeg4u5FBV/bAyxybIA/i+uzNEm1d0diOqIdZ5HOONHbrU+MM6/9tep5N2zn6vP
=3GUF
-----END PGP SIGNATURE-----

--mNNuS69IDkkrwcIXc05STOOtT4I8p2ART--
