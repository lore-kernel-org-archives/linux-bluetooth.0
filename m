Return-Path: <home@chrisaw.com>
MIME-Version: 1.0
In-Reply-To: <09f20b44-290f-3bbf-b52e-22c3b76cfc7a@redhat.com>
References: <20170706140845.11508-1-hdegoede@redhat.com> <B5854943-47D2-494F-9D56-80226FE66F38@holtmann.org>
 <09f20b44-290f-3bbf-b52e-22c3b76cfc7a@redhat.com>
From: Christopher Williamson <home@chrisaw.com>
Date: Fri, 7 Jul 2017 05:55:00 -0400
Message-ID: <CAAYJcCVS584Dm-_ZBJuWxehupkd1jddmo_g0xqmejjtnYzt8Yg@mail.gmail.com>
Subject: Re: [PATCH] bluetooth: btusb: Add support for BCM2045 HCI with
 vend:prod ids set to 0000:0000
To: Hans de Goede <hdegoede@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary="94eb2c124cb800e9d80553b73a09"
List-ID: <linux-bluetooth.vger.kernel.org>

--94eb2c124cb800e9d80553b73a09
Content-Type: text/plain; charset="UTF-8"

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480  MxCh= 7
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1d6b ProdID=0002 Rev= 4.12
S:  Manufacturer=Linux 4.12.0-custom xhci-hcd
S:  Product=xHCI Host Controller
S:  SerialNumber=0000:00:14.0
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=1.5  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=258a ProdID=0111 Rev= 1.00
S:  Manufacturer=SINO WEALTH
S:  Product=Gaming Keyboard
C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=8ms
I:* If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=8ms

T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=02 Dev#=  3 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 1.12
S:  Manufacturer=Broadcom Corp
S:  Product=BCM2045A0
S:  SerialNumber=AC83F30677CB
C:* #Ifs= 4 Cfg#= 1 Atr=80 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=5000 MxCh= 6
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 3.00 Cls=09(hub  ) Sub=00 Prot=03 MxPS= 9 #Cfgs=  1
P:  Vendor=1d6b ProdID=0003 Rev= 4.12
S:  Manufacturer=Linux 4.12.0-custom xhci-hcd
S:  Product=xHCI Host Controller
S:  SerialNumber=0000:00:14.0
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms

On Thu, Jul 6, 2017 at 12:43 PM, Hans de Goede <hdegoede@redhat.com> wrote:

> Hi all,
>
> Christopher, can you do: "sudo cat /sys/kernel/debug/usb/devices"
> and copy and paste the contents in a reply to this mail
> (using reply-to-all) ?
>
> On 06-07-17 17:22, Marcel Holtmann wrote:
>
>> Hi Hans,
>>
>> The GPD Pocket is shipping with a BCM2045 USB HCI with its vend:prod
>>> ids set to 0000:0000 and also has its interface class set to 255 (Vendor
>>> Specific Class).
>>>
>>> Which, well sucks. Luckily it does advertise usable manufacturer and
>>> product strings, so this commit adds 0000:0000 to the usb_device_id
>>> table, with a special flag of BTUSB_BCM2045_0000_0000, if this flag
>>> is set btusb_probe will check the strings and if they don't match
>>> return -ENODEV.
>>>
>>> This is not pretty, but it fixes bluetooth not working under Linux.
>>>
>>
>> can you send around /sys/kernel/debug/usb/devices for this device.
>>
>
> As you can see I've just asked the reported to provide this :)
>
> I already have lsusb -v output for the btusb device:
>
> Bus 001 Device 003: ID 0000:0000
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass          255 Vendor Specific Class
>   bDeviceSubClass         1
>   bDeviceProtocol         1
>   bMaxPacketSize0        64
>   idVendor           0x0000
>   idProduct          0x0000
>   bcdDevice            1.12
>   iManufacturer           1 Broadcom Corp
>   iProduct                2 BCM2045A0
>   iSerial                 3 AC83F30677CB
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength          218
>     bNumInterfaces          4
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0x80
>       (Bus Powered)
>     MaxPower              100mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           3
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      1
>       bInterfaceProtocol      1
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0010  1x 16 bytes
>         bInterval               1
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x82  EP 2 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               1
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x02  EP 2 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               1
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      1
>       bInterfaceProtocol      1
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x83  EP 3 IN
>         bmAttributes            1
>           Transfer Type            Isochronous
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0000  1x 0 bytes
>         bInterval               1
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x03  EP 3 OUT
>         bmAttributes            1
>           Transfer Type            Isochronous
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0000  1x 0 bytes
>         bInterval               1
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       1
>       bNumEndpoints           2
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      1
>       bInterfaceProtocol      1
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x83  EP 3 IN
>         bmAttributes            1
>           Transfer Type            Isochronous
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0009  1x 9 bytes
>         bInterval               1
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x03  EP 3 OUT
>         bmAttributes            1
>           Transfer Type            Isochronous
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0009  1x 9 bytes
>         bInterval               1
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       2
>       bNumEndpoints           2
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      1
>       bInterfaceProtocol      1
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x83  EP 3 IN
>         bmAttributes            1
>           Transfer Type            Isochronous
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0011  1x 17 bytes
>         bInterval               1
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x03  EP 3 OUT
>         bmAttributes            1
>           Transfer Type            Isochronous
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0011  1x 17 bytes
>         bInterval               1
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       3
>       bNumEndpoints           2
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      1
>       bInterfaceProtocol      1
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x83  EP 3 IN
>         bmAttributes            1
>           Transfer Type            Isochronous
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0019  1x 25 bytes
>         bInterval               1
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x03  EP 3 OUT
>         bmAttributes            1
>           Transfer Type            Isochronous
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0019  1x 25 bytes
>         bInterval               1
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       4
>       bNumEndpoints           2
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      1
>       bInterfaceProtocol      1
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x83  EP 3 IN
>         bmAttributes            1
>           Transfer Type            Isochronous
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0021  1x 33 bytes
>         bInterval               1
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x03  EP 3 OUT
>         bmAttributes            1
>           Transfer Type            Isochronous
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0021  1x 33 bytes
>         bInterval               1
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       5
>       bNumEndpoints           2
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      1
>       bInterfaceProtocol      1
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x83  EP 3 IN
>         bmAttributes            1
>           Transfer Type            Isochronous
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0031  1x 49 bytes
>         bInterval               1
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x03  EP 3 OUT
>         bmAttributes            1
>           Transfer Type            Isochronous
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0031  1x 49 bytes
>         bInterval               1
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        2
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass    255 Vendor Specific Subclass
>       bInterfaceProtocol    255 Vendor Specific Protocol
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x84  EP 4 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0020  1x 32 bytes
>         bInterval               1
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x04  EP 4 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0020  1x 32 bytes
>         bInterval               1
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        3
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass       254 Application Specific Interface
>       bInterfaceSubClass      1 Device Firmware Update
>       bInterfaceProtocol      1
>       iInterface              0
>       Device Firmware Upgrade Interface Descriptor:
>         bLength                             9
>         bDescriptorType                    33
>         bmAttributes                        5
>           Will Not Detach
>           Manifestation Tolerant
>           Upload Unsupported
>           Download Supported
>         wDetachTimeout                   5000 milliseconds
>         wTransferSize                      64 bytes
>         bcdDFUVersion                   1.10
> Device Status:     0x0000
>   (Bus Powered)
>
> Regards,
>
> Hans
>

--94eb2c124cb800e9d80553b73a09
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGJyPlQ6wqAgQnVzPTAxIExldj0wMCBQcm50PTAwIFBvcnQ9MDAgQ250
PTAwIERldiM9wqAgMSBTcGQ9NDgwwqAgTXhDaD0gNzxicj5COsKgIEFsbG9jPcKgIDAvODAwIHVz
ICggMCUpLCAjSW50PcKgIDAsICNJc289wqAgMDxicj5EOsKgIFZlcj0gMi4wMCBDbHM9MDkoaHVi
wqAgKSBTdWI9MDAgUHJvdD0wMSBNeFBTPTY0ICNDZmdzPcKgIDE8YnI+UDrCoCBWZW5kb3I9MWQ2
YiBQcm9kSUQ9MDAwMiBSZXY9IDQuMTI8YnI+UzrCoCBNYW51ZmFjdHVyZXI9TGludXggNC4xMi4w
LWN1c3RvbSB4aGNpLWhjZDxicj5TOsKgIFByb2R1Y3Q9eEhDSSBIb3N0IENvbnRyb2xsZXI8YnI+
UzrCoCBTZXJpYWxOdW1iZXI9MDAwMDowMDoxNC4wPGJyPkM6KiAjSWZzPSAxIENmZyM9IDEgQXRy
PWUwIE14UHdyPcKgIDBtQTxicj5JOiogSWYjPSAwIEFsdD0gMCAjRVBzPSAxIENscz0wOShodWLC
oCApIFN1Yj0wMCBQcm90PTAwIERyaXZlcj1odWI8YnI+RTrCoCBBZD04MShJKSBBdHI9MDMoSW50
LikgTXhQUz3CoMKgIDQgSXZsPTI1Nm1zPGJyPjxicj5UOsKgIEJ1cz0wMSBMZXY9MDEgUHJudD0w
MSBQb3J0PTAxIENudD0wMSBEZXYjPcKgIDIgU3BkPTEuNcKgIE14Q2g9IDA8YnI+RDrCoCBWZXI9
IDEuMTAgQ2xzPTAwKCZndDtpZmMgKSBTdWI9MDAgUHJvdD0wMCBNeFBTPSA4ICNDZmdzPcKgIDE8
YnI+UDrCoCBWZW5kb3I9MjU4YSBQcm9kSUQ9MDExMSBSZXY9IDEuMDA8YnI+UzrCoCBNYW51ZmFj
dHVyZXI9U0lOTyBXRUFMVEg8YnI+UzrCoCBQcm9kdWN0PUdhbWluZyBLZXlib2FyZDxicj5DOiog
I0lmcz0gMiBDZmcjPSAxIEF0cj1hMCBNeFB3cj0xMDBtQTxicj5JOiogSWYjPSAwIEFsdD0gMCAj
RVBzPSAxIENscz0wMyhISUTCoCApIFN1Yj0wMSBQcm90PTAxIERyaXZlcj11c2JoaWQ8YnI+RTrC
oCBBZD04MShJKSBBdHI9MDMoSW50LikgTXhQUz3CoMKgIDggSXZsPThtczxicj5JOiogSWYjPSAx
IEFsdD0gMCAjRVBzPSAxIENscz0wMyhISUTCoCApIFN1Yj0wMCBQcm90PTAwIERyaXZlcj11c2Jo
aWQ8YnI+RTrCoCBBZD04MihJKSBBdHI9MDMoSW50LikgTXhQUz3CoMKgIDggSXZsPThtczxicj48
YnI+VDrCoCBCdXM9MDEgTGV2PTAxIFBybnQ9MDEgUG9ydD0wMiBDbnQ9MDIgRGV2Iz3CoCAzIFNw
ZD0xMsKgwqAgTXhDaD0gMDxicj5EOsKgIFZlcj0gMi4wMCBDbHM9ZmYodmVuZC4pIFN1Yj0wMSBQ
cm90PTAxIE14UFM9NjQgI0NmZ3M9wqAgMTxicj5QOsKgIFZlbmRvcj0wMDAwIFByb2RJRD0wMDAw
IFJldj0gMS4xMjxicj5TOsKgIE1hbnVmYWN0dXJlcj1Ccm9hZGNvbSBDb3JwPGJyPlM6wqAgUHJv
ZHVjdD1CQ00yMDQ1QTA8YnI+UzrCoCBTZXJpYWxOdW1iZXI9QUM4M0YzMDY3N0NCPGJyPkM6KiAj
SWZzPSA0IENmZyM9IDEgQXRyPTgwIE14UHdyPTEwMG1BPGJyPkk6KiBJZiM9IDAgQWx0PSAwICNF
UHM9IDMgQ2xzPWZmKHZlbmQuKSBTdWI9MDEgUHJvdD0wMSBEcml2ZXI9YnR1c2I8YnI+RTrCoCBB
ZD04MShJKSBBdHI9MDMoSW50LikgTXhQUz3CoCAxNiBJdmw9MW1zPGJyPkU6wqAgQWQ9ODIoSSkg
QXRyPTAyKEJ1bGspIE14UFM9wqAgNjQgSXZsPTBtczxicj5FOsKgIEFkPTAyKE8pIEF0cj0wMihC
dWxrKSBNeFBTPcKgIDY0IEl2bD0wbXM8YnI+SToqIElmIz0gMSBBbHQ9IDAgI0VQcz0gMiBDbHM9
ZmYodmVuZC4pIFN1Yj0wMSBQcm90PTAxIERyaXZlcj1idHVzYjxicj5FOsKgIEFkPTgzKEkpIEF0
cj0wMShJc29jKSBNeFBTPcKgwqAgMCBJdmw9MW1zPGJyPkU6wqAgQWQ9MDMoTykgQXRyPTAxKElz
b2MpIE14UFM9wqDCoCAwIEl2bD0xbXM8YnI+STrCoCBJZiM9IDEgQWx0PSAxICNFUHM9IDIgQ2xz
PWZmKHZlbmQuKSBTdWI9MDEgUHJvdD0wMSBEcml2ZXI9YnR1c2I8YnI+RTrCoCBBZD04MyhJKSBB
dHI9MDEoSXNvYykgTXhQUz3CoMKgIDkgSXZsPTFtczxicj5FOsKgIEFkPTAzKE8pIEF0cj0wMShJ
c29jKSBNeFBTPcKgwqAgOSBJdmw9MW1zPGJyPkk6wqAgSWYjPSAxIEFsdD0gMiAjRVBzPSAyIENs
cz1mZih2ZW5kLikgU3ViPTAxIFByb3Q9MDEgRHJpdmVyPWJ0dXNiPGJyPkU6wqAgQWQ9ODMoSSkg
QXRyPTAxKElzb2MpIE14UFM9wqAgMTcgSXZsPTFtczxicj5FOsKgIEFkPTAzKE8pIEF0cj0wMShJ
c29jKSBNeFBTPcKgIDE3IEl2bD0xbXM8YnI+STrCoCBJZiM9IDEgQWx0PSAzICNFUHM9IDIgQ2xz
PWZmKHZlbmQuKSBTdWI9MDEgUHJvdD0wMSBEcml2ZXI9YnR1c2I8YnI+RTrCoCBBZD04MyhJKSBB
dHI9MDEoSXNvYykgTXhQUz3CoCAyNSBJdmw9MW1zPGJyPkU6wqAgQWQ9MDMoTykgQXRyPTAxKElz
b2MpIE14UFM9wqAgMjUgSXZsPTFtczxicj5JOsKgIElmIz0gMSBBbHQ9IDQgI0VQcz0gMiBDbHM9
ZmYodmVuZC4pIFN1Yj0wMSBQcm90PTAxIERyaXZlcj1idHVzYjxicj5FOsKgIEFkPTgzKEkpIEF0
cj0wMShJc29jKSBNeFBTPcKgIDMzIEl2bD0xbXM8YnI+RTrCoCBBZD0wMyhPKSBBdHI9MDEoSXNv
YykgTXhQUz3CoCAzMyBJdmw9MW1zPGJyPkk6wqAgSWYjPSAxIEFsdD0gNSAjRVBzPSAyIENscz1m
Zih2ZW5kLikgU3ViPTAxIFByb3Q9MDEgRHJpdmVyPWJ0dXNiPGJyPkU6wqAgQWQ9ODMoSSkgQXRy
PTAxKElzb2MpIE14UFM9wqAgNDkgSXZsPTFtczxicj5FOsKgIEFkPTAzKE8pIEF0cj0wMShJc29j
KSBNeFBTPcKgIDQ5IEl2bD0xbXM8YnI+SToqIElmIz0gMiBBbHQ9IDAgI0VQcz0gMiBDbHM9ZmYo
dmVuZC4pIFN1Yj1mZiBQcm90PWZmIERyaXZlcj0obm9uZSk8YnI+RTrCoCBBZD04NChJKSBBdHI9
MDIoQnVsaykgTXhQUz3CoCAzMiBJdmw9MG1zPGJyPkU6wqAgQWQ9MDQoTykgQXRyPTAyKEJ1bGsp
IE14UFM9wqAgMzIgSXZsPTBtczxicj5JOiogSWYjPSAzIEFsdD0gMCAjRVBzPSAwIENscz1mZShh
cHAuICkgU3ViPTAxIFByb3Q9MDEgRHJpdmVyPShub25lKTxicj48YnI+VDrCoCBCdXM9MDIgTGV2
PTAwIFBybnQ9MDAgUG9ydD0wMCBDbnQ9MDAgRGV2Iz3CoCAxIFNwZD01MDAwIE14Q2g9IDY8YnI+
QjrCoCBBbGxvYz3CoCAwLzgwMCB1cyAoIDAlKSwgI0ludD3CoCAwLCAjSXNvPcKgIDA8YnI+RDrC
oCBWZXI9IDMuMDAgQ2xzPTA5KGh1YsKgICkgU3ViPTAwIFByb3Q9MDMgTXhQUz0gOSAjQ2Zncz3C
oCAxPGJyPlA6wqAgVmVuZG9yPTFkNmIgUHJvZElEPTAwMDMgUmV2PSA0LjEyPGJyPlM6wqAgTWFu
dWZhY3R1cmVyPUxpbnV4IDQuMTIuMC1jdXN0b20geGhjaS1oY2Q8YnI+UzrCoCBQcm9kdWN0PXhI
Q0kgSG9zdCBDb250cm9sbGVyPGJyPlM6wqAgU2VyaWFsTnVtYmVyPTAwMDA6MDA6MTQuMDxicj5D
OiogI0lmcz0gMSBDZmcjPSAxIEF0cj1lMCBNeFB3cj3CoCAwbUE8YnI+SToqIElmIz0gMCBBbHQ9
IDAgI0VQcz0gMSBDbHM9MDkoaHViwqAgKSBTdWI9MDAgUHJvdD0wMCBEcml2ZXI9aHViPGJyPkU6
wqAgQWQ9ODEoSSkgQXRyPTAzKEludC4pIE14UFM9wqDCoCA0IEl2bD0yNTZtczxicj48L2Rpdj48
ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBU
aHUsIEp1bCA2LCAyMDE3IGF0IDEyOjQzIFBNLCBIYW5zIGRlIEdvZWRlIDxzcGFuIGRpcj0ibHRy
Ij4mbHQ7PGEgaHJlZj0ibWFpbHRvOmhkZWdvZWRlQHJlZGhhdC5jb20iIHRhcmdldD0iX2JsYW5r
Ij5oZGVnb2VkZUByZWRoYXQuY29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90
ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVm
dDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij5IaSBhbGwsPGJyPg0KPGJyPg0KQ2hy
aXN0b3BoZXIsIGNhbiB5b3UgZG86ICZxdW90O3N1ZG8gY2F0IC9zeXMva2VybmVsL2RlYnVnL3Vz
Yi9kZXZpY2VzJnF1b3Q7PGJyPg0KYW5kIGNvcHkgYW5kIHBhc3RlIHRoZSBjb250ZW50cyBpbiBh
IHJlcGx5IHRvIHRoaXMgbWFpbDxicj4NCih1c2luZyByZXBseS10by1hbGwpID88YnI+DQo8YnI+
DQpPbiAwNi0wNy0xNyAxNzoyMiwgTWFyY2VsIEhvbHRtYW5uIHdyb3RlOjxicj4NCjxibG9ja3F1
b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1s
ZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPg0KSGkgSGFucyw8YnI+DQo8YnI+
DQo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhl
eDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4NClRoZSBHUEQg
UG9ja2V0IGlzIHNoaXBwaW5nIHdpdGggYSBCQ00yMDQ1IFVTQiBIQ0kgd2l0aCBpdHMgdmVuZDpw
cm9kPGJyPg0KaWRzIHNldCB0byAwMDAwOjAwMDAgYW5kIGFsc28gaGFzIGl0cyBpbnRlcmZhY2Ug
Y2xhc3Mgc2V0IHRvIDI1NSAoVmVuZG9yPGJyPg0KU3BlY2lmaWMgQ2xhc3MpLjxicj4NCjxicj4N
CldoaWNoLCB3ZWxsIHN1Y2tzLiBMdWNraWx5IGl0IGRvZXMgYWR2ZXJ0aXNlIHVzYWJsZSBtYW51
ZmFjdHVyZXIgYW5kPGJyPg0KcHJvZHVjdCBzdHJpbmdzLCBzbyB0aGlzIGNvbW1pdCBhZGRzIDAw
MDA6MDAwMCB0byB0aGUgdXNiX2RldmljZV9pZDxicj4NCnRhYmxlLCB3aXRoIGEgc3BlY2lhbCBm
bGFnIG9mIEJUVVNCX0JDTTIwNDVfMDAwMF8wMDAwLCBpZiB0aGlzIGZsYWc8YnI+DQppcyBzZXQg
YnR1c2JfcHJvYmUgd2lsbCBjaGVjayB0aGUgc3RyaW5ncyBhbmQgaWYgdGhleSBkb24mIzM5O3Qg
bWF0Y2g8YnI+DQpyZXR1cm4gLUVOT0RFVi48YnI+DQo8YnI+DQpUaGlzIGlzIG5vdCBwcmV0dHks
IGJ1dCBpdCBmaXhlcyBibHVldG9vdGggbm90IHdvcmtpbmcgdW5kZXIgTGludXguPGJyPg0KPC9i
bG9ja3F1b3RlPg0KPGJyPg0KY2FuIHlvdSBzZW5kIGFyb3VuZCAvc3lzL2tlcm5lbC9kZWJ1Zy91
c2IvZGV2aWNlcyBmb3IgdGhpcyBkZXZpY2UuPGJyPg0KPC9ibG9ja3F1b3RlPg0KPGJyPg0KQXMg
eW91IGNhbiBzZWUgSSYjMzk7dmUganVzdCBhc2tlZCB0aGUgcmVwb3J0ZWQgdG8gcHJvdmlkZSB0
aGlzIDopPGJyPg0KPGJyPg0KSSBhbHJlYWR5IGhhdmUgbHN1c2IgLXYgb3V0cHV0IGZvciB0aGUg
YnR1c2IgZGV2aWNlOjxicj4NCjxicj4NCkJ1cyAwMDEgRGV2aWNlIDAwMzogSUQgMDAwMDowMDAw
PGJyPg0KRGV2aWNlIERlc2NyaXB0b3I6PGJyPg0KwqAgYkxlbmd0aMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIDE4PGJyPg0KwqAgYkRlc2NyaXB0b3JUeXBlwqAgwqAgwqAgwqAgwqAxPGJyPg0KwqAg
YmNkVVNCwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAyLjAwPGJyPg0KwqAgYkRldmljZUNsYXNzwqAg
wqAgwqAgwqAgwqAgMjU1IFZlbmRvciBTcGVjaWZpYyBDbGFzczxicj4NCsKgIGJEZXZpY2VTdWJD
bGFzc8KgIMKgIMKgIMKgIMKgMTxicj4NCsKgIGJEZXZpY2VQcm90b2NvbMKgIMKgIMKgIMKgIMKg
MTxicj4NCsKgIGJNYXhQYWNrZXRTaXplMMKgIMKgIMKgIMKgIDY0PGJyPg0KwqAgaWRWZW5kb3LC
oCDCoCDCoCDCoCDCoCDCoDB4MDAwMDxicj4NCsKgIGlkUHJvZHVjdMKgIMKgIMKgIMKgIMKgIDB4
MDAwMDxicj4NCsKgIGJjZERldmljZcKgIMKgIMKgIMKgIMKgIMKgIDEuMTI8YnI+DQrCoCBpTWFu
dWZhY3R1cmVywqAgwqAgwqAgwqAgwqAgwqAxIEJyb2FkY29tIENvcnA8YnI+DQrCoCBpUHJvZHVj
dMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDIgQkNNMjA0NUEwPGJyPg0KwqAgaVNlcmlhbMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgMyBBQzgzRjMwNjc3Q0I8YnI+DQrCoCBiTnVtQ29uZmlndXJh
dGlvbnPCoCDCoCDCoCAxPGJyPg0KwqAgQ29uZmlndXJhdGlvbiBEZXNjcmlwdG9yOjxicj4NCsKg
IMKgIGJMZW5ndGjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDk8YnI+DQrCoCDCoCBiRGVzY3Jp
cHRvclR5cGXCoCDCoCDCoCDCoCDCoDI8YnI+DQrCoCDCoCB3VG90YWxMZW5ndGjCoCDCoCDCoCDC
oCDCoCAyMTg8YnI+DQrCoCDCoCBiTnVtSW50ZXJmYWNlc8KgIMKgIMKgIMKgIMKgIDQ8YnI+DQrC
oCDCoCBiQ29uZmlndXJhdGlvblZhbHVlwqAgwqAgwqAxPGJyPg0KwqAgwqAgaUNvbmZpZ3VyYXRp
b27CoCDCoCDCoCDCoCDCoCAwPGJyPg0KwqAgwqAgYm1BdHRyaWJ1dGVzwqAgwqAgwqAgwqAgwqAw
eDgwPGJyPg0KwqAgwqAgwqAgKEJ1cyBQb3dlcmVkKTxicj4NCsKgIMKgIE1heFBvd2VywqAgwqAg
wqAgwqAgwqAgwqAgwqAgMTAwbUE8YnI+DQrCoCDCoCBJbnRlcmZhY2UgRGVzY3JpcHRvcjo8YnI+
DQrCoCDCoCDCoCBiTGVuZ3RowqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA5PGJyPg0KwqAgwqAg
wqAgYkRlc2NyaXB0b3JUeXBlwqAgwqAgwqAgwqAgwqA0PGJyPg0KwqAgwqAgwqAgYkludGVyZmFj
ZU51bWJlcsKgIMKgIMKgIMKgIDA8YnI+DQrCoCDCoCDCoCBiQWx0ZXJuYXRlU2V0dGluZ8KgIMKg
IMKgIMKgMDxicj4NCsKgIMKgIMKgIGJOdW1FbmRwb2ludHPCoCDCoCDCoCDCoCDCoCDCoDM8YnI+
DQrCoCDCoCDCoCBiSW50ZXJmYWNlQ2xhc3PCoCDCoCDCoCDCoDI1NSBWZW5kb3IgU3BlY2lmaWMg
Q2xhc3M8YnI+DQrCoCDCoCDCoCBiSW50ZXJmYWNlU3ViQ2xhc3PCoCDCoCDCoCAxPGJyPg0KwqAg
wqAgwqAgYkludGVyZmFjZVByb3RvY29swqAgwqAgwqAgMTxicj4NCsKgIMKgIMKgIGlJbnRlcmZh
Y2XCoCDCoCDCoCDCoCDCoCDCoCDCoCAwPGJyPg0KwqAgwqAgwqAgRW5kcG9pbnQgRGVzY3JpcHRv
cjo8YnI+DQrCoCDCoCDCoCDCoCBiTGVuZ3RowqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA3PGJy
Pg0KwqAgwqAgwqAgwqAgYkRlc2NyaXB0b3JUeXBlwqAgwqAgwqAgwqAgwqA1PGJyPg0KwqAgwqAg
wqAgwqAgYkVuZHBvaW50QWRkcmVzc8KgIMKgIMKgMHg4McKgIEVQIDEgSU48YnI+DQrCoCDCoCDC
oCDCoCBibUF0dHJpYnV0ZXPCoCDCoCDCoCDCoCDCoCDCoCAzPGJyPg0KwqAgwqAgwqAgwqAgwqAg
VHJhbnNmZXIgVHlwZcKgIMKgIMKgIMKgIMKgIMKgIEludGVycnVwdDxicj4NCsKgIMKgIMKgIMKg
IMKgIFN5bmNoIFR5cGXCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE5vbmU8YnI+DQrCoCDCoCDCoCDC
oCDCoCBVc2FnZSBUeXBlwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBEYXRhPGJyPg0KwqAgwqAgwqAg
wqAgd01heFBhY2tldFNpemXCoCDCoCDCoDB4MDAxMMKgIDF4IDE2IGJ5dGVzPGJyPg0KwqAgwqAg
wqAgwqAgYkludGVydmFswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAxPGJyPg0KwqAgwqAgwqAgRW5k
cG9pbnQgRGVzY3JpcHRvcjo8YnI+DQrCoCDCoCDCoCDCoCBiTGVuZ3RowqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqA3PGJyPg0KwqAgwqAgwqAgwqAgYkRlc2NyaXB0b3JUeXBlwqAgwqAgwqAgwqAg
wqA1PGJyPg0KwqAgwqAgwqAgwqAgYkVuZHBvaW50QWRkcmVzc8KgIMKgIMKgMHg4MsKgIEVQIDIg
SU48YnI+DQrCoCDCoCDCoCDCoCBibUF0dHJpYnV0ZXPCoCDCoCDCoCDCoCDCoCDCoCAyPGJyPg0K
wqAgwqAgwqAgwqAgwqAgVHJhbnNmZXIgVHlwZcKgIMKgIMKgIMKgIMKgIMKgIEJ1bGs8YnI+DQrC
oCDCoCDCoCDCoCDCoCBTeW5jaCBUeXBlwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBOb25lPGJyPg0K
wqAgwqAgwqAgwqAgwqAgVXNhZ2UgVHlwZcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgRGF0YTxicj4N
CsKgIMKgIMKgIMKgIHdNYXhQYWNrZXRTaXplwqAgwqAgwqAweDAwNDDCoCAxeCA2NCBieXRlczxi
cj4NCsKgIMKgIMKgIMKgIGJJbnRlcnZhbMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMTxicj4NCsKg
IMKgIMKgIEVuZHBvaW50IERlc2NyaXB0b3I6PGJyPg0KwqAgwqAgwqAgwqAgYkxlbmd0aMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgNzxicj4NCsKgIMKgIMKgIMKgIGJEZXNjcmlwdG9yVHlwZcKg
IMKgIMKgIMKgIMKgNTxicj4NCsKgIMKgIMKgIMKgIGJFbmRwb2ludEFkZHJlc3PCoCDCoCDCoDB4
MDLCoCBFUCAyIE9VVDxicj4NCsKgIMKgIMKgIMKgIGJtQXR0cmlidXRlc8KgIMKgIMKgIMKgIMKg
IMKgIDI8YnI+DQrCoCDCoCDCoCDCoCDCoCBUcmFuc2ZlciBUeXBlwqAgwqAgwqAgwqAgwqAgwqAg
QnVsazxicj4NCsKgIMKgIMKgIMKgIMKgIFN5bmNoIFR5cGXCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oE5vbmU8YnI+DQrCoCDCoCDCoCDCoCDCoCBVc2FnZSBUeXBlwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBEYXRhPGJyPg0KwqAgwqAgwqAgwqAgd01heFBhY2tldFNpemXCoCDCoCDCoDB4MDA0MMKgIDF4
IDY0IGJ5dGVzPGJyPg0KwqAgwqAgwqAgwqAgYkludGVydmFswqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAxPGJyPg0KwqAgwqAgSW50ZXJmYWNlIERlc2NyaXB0b3I6PGJyPg0KwqAgwqAgwqAgYkxlbmd0
aMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgOTxicj4NCsKgIMKgIMKgIGJEZXNjcmlwdG9yVHlw
ZcKgIMKgIMKgIMKgIMKgNDxicj4NCsKgIMKgIMKgIGJJbnRlcmZhY2VOdW1iZXLCoCDCoCDCoCDC
oCAxPGJyPg0KwqAgwqAgwqAgYkFsdGVybmF0ZVNldHRpbmfCoCDCoCDCoCDCoDA8YnI+DQrCoCDC
oCDCoCBiTnVtRW5kcG9pbnRzwqAgwqAgwqAgwqAgwqAgwqAyPGJyPg0KwqAgwqAgwqAgYkludGVy
ZmFjZUNsYXNzwqAgwqAgwqAgwqAyNTUgVmVuZG9yIFNwZWNpZmljIENsYXNzPGJyPg0KwqAgwqAg
wqAgYkludGVyZmFjZVN1YkNsYXNzwqAgwqAgwqAgMTxicj4NCsKgIMKgIMKgIGJJbnRlcmZhY2VQ
cm90b2NvbMKgIMKgIMKgIDE8YnI+DQrCoCDCoCDCoCBpSW50ZXJmYWNlwqAgwqAgwqAgwqAgwqAg
wqAgwqAgMDxicj4NCsKgIMKgIMKgIEVuZHBvaW50IERlc2NyaXB0b3I6PGJyPg0KwqAgwqAgwqAg
wqAgYkxlbmd0aMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgNzxicj4NCsKgIMKgIMKgIMKgIGJE
ZXNjcmlwdG9yVHlwZcKgIMKgIMKgIMKgIMKgNTxicj4NCsKgIMKgIMKgIMKgIGJFbmRwb2ludEFk
ZHJlc3PCoCDCoCDCoDB4ODPCoCBFUCAzIElOPGJyPg0KwqAgwqAgwqAgwqAgYm1BdHRyaWJ1dGVz
wqAgwqAgwqAgwqAgwqAgwqAgMTxicj4NCsKgIMKgIMKgIMKgIMKgIFRyYW5zZmVyIFR5cGXCoCDC
oCDCoCDCoCDCoCDCoCBJc29jaHJvbm91czxicj4NCsKgIMKgIMKgIMKgIMKgIFN5bmNoIFR5cGXC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoE5vbmU8YnI+DQrCoCDCoCDCoCDCoCDCoCBVc2FnZSBUeXBl
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBEYXRhPGJyPg0KwqAgwqAgwqAgwqAgd01heFBhY2tldFNp
emXCoCDCoCDCoDB4MDAwMMKgIDF4IDAgYnl0ZXM8YnI+DQrCoCDCoCDCoCDCoCBiSW50ZXJ2YWzC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoDE8YnI+DQrCoCDCoCDCoCBFbmRwb2ludCBEZXNjcmlwdG9y
Ojxicj4NCsKgIMKgIMKgIMKgIGJMZW5ndGjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDc8YnI+
DQrCoCDCoCDCoCDCoCBiRGVzY3JpcHRvclR5cGXCoCDCoCDCoCDCoCDCoDU8YnI+DQrCoCDCoCDC
oCDCoCBiRW5kcG9pbnRBZGRyZXNzwqAgwqAgwqAweDAzwqAgRVAgMyBPVVQ8YnI+DQrCoCDCoCDC
oCDCoCBibUF0dHJpYnV0ZXPCoCDCoCDCoCDCoCDCoCDCoCAxPGJyPg0KwqAgwqAgwqAgwqAgwqAg
VHJhbnNmZXIgVHlwZcKgIMKgIMKgIMKgIMKgIMKgIElzb2Nocm9ub3VzPGJyPg0KwqAgwqAgwqAg
wqAgwqAgU3luY2ggVHlwZcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTm9uZTxicj4NCsKgIMKgIMKg
IMKgIMKgIFVzYWdlIFR5cGXCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoERhdGE8YnI+DQrCoCDCoCDC
oCDCoCB3TWF4UGFja2V0U2l6ZcKgIMKgIMKgMHgwMDAwwqAgMXggMCBieXRlczxicj4NCsKgIMKg
IMKgIMKgIGJJbnRlcnZhbMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMTxicj4NCsKgIMKgIEludGVy
ZmFjZSBEZXNjcmlwdG9yOjxicj4NCsKgIMKgIMKgIGJMZW5ndGjCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoDk8YnI+DQrCoCDCoCDCoCBiRGVzY3JpcHRvclR5cGXCoCDCoCDCoCDCoCDCoDQ8YnI+
DQrCoCDCoCDCoCBiSW50ZXJmYWNlTnVtYmVywqAgwqAgwqAgwqAgMTxicj4NCsKgIMKgIMKgIGJB
bHRlcm5hdGVTZXR0aW5nwqAgwqAgwqAgwqAxPGJyPg0KwqAgwqAgwqAgYk51bUVuZHBvaW50c8Kg
IMKgIMKgIMKgIMKgIMKgMjxicj4NCsKgIMKgIMKgIGJJbnRlcmZhY2VDbGFzc8KgIMKgIMKgIMKg
MjU1IFZlbmRvciBTcGVjaWZpYyBDbGFzczxicj4NCsKgIMKgIMKgIGJJbnRlcmZhY2VTdWJDbGFz
c8KgIMKgIMKgIDE8YnI+DQrCoCDCoCDCoCBiSW50ZXJmYWNlUHJvdG9jb2zCoCDCoCDCoCAxPGJy
Pg0KwqAgwqAgwqAgaUludGVyZmFjZcKgIMKgIMKgIMKgIMKgIMKgIMKgIDA8YnI+DQrCoCDCoCDC
oCBFbmRwb2ludCBEZXNjcmlwdG9yOjxicj4NCsKgIMKgIMKgIMKgIGJMZW5ndGjCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoDc8YnI+DQrCoCDCoCDCoCDCoCBiRGVzY3JpcHRvclR5cGXCoCDCoCDC
oCDCoCDCoDU8YnI+DQrCoCDCoCDCoCDCoCBiRW5kcG9pbnRBZGRyZXNzwqAgwqAgwqAweDgzwqAg
RVAgMyBJTjxicj4NCsKgIMKgIMKgIMKgIGJtQXR0cmlidXRlc8KgIMKgIMKgIMKgIMKgIMKgIDE8
YnI+DQrCoCDCoCDCoCDCoCDCoCBUcmFuc2ZlciBUeXBlwqAgwqAgwqAgwqAgwqAgwqAgSXNvY2hy
b25vdXM8YnI+DQrCoCDCoCDCoCDCoCDCoCBTeW5jaCBUeXBlwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBOb25lPGJyPg0KwqAgwqAgwqAgwqAgwqAgVXNhZ2UgVHlwZcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgRGF0YTxicj4NCsKgIMKgIMKgIMKgIHdNYXhQYWNrZXRTaXplwqAgwqAgwqAweDAwMDnCoCAx
eCA5IGJ5dGVzPGJyPg0KwqAgwqAgwqAgwqAgYkludGVydmFswqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAxPGJyPg0KwqAgwqAgwqAgRW5kcG9pbnQgRGVzY3JpcHRvcjo8YnI+DQrCoCDCoCDCoCDCoCBi
TGVuZ3RowqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA3PGJyPg0KwqAgwqAgwqAgwqAgYkRlc2Ny
aXB0b3JUeXBlwqAgwqAgwqAgwqAgwqA1PGJyPg0KwqAgwqAgwqAgwqAgYkVuZHBvaW50QWRkcmVz
c8KgIMKgIMKgMHgwM8KgIEVQIDMgT1VUPGJyPg0KwqAgwqAgwqAgwqAgYm1BdHRyaWJ1dGVzwqAg
wqAgwqAgwqAgwqAgwqAgMTxicj4NCsKgIMKgIMKgIMKgIMKgIFRyYW5zZmVyIFR5cGXCoCDCoCDC
oCDCoCDCoCDCoCBJc29jaHJvbm91czxicj4NCsKgIMKgIMKgIMKgIMKgIFN5bmNoIFR5cGXCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoE5vbmU8YnI+DQrCoCDCoCDCoCDCoCDCoCBVc2FnZSBUeXBlwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBEYXRhPGJyPg0KwqAgwqAgwqAgwqAgd01heFBhY2tldFNpemXC
oCDCoCDCoDB4MDAwOcKgIDF4IDkgYnl0ZXM8YnI+DQrCoCDCoCDCoCDCoCBiSW50ZXJ2YWzCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoDE8YnI+DQrCoCDCoCBJbnRlcmZhY2UgRGVzY3JpcHRvcjo8YnI+
DQrCoCDCoCDCoCBiTGVuZ3RowqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA5PGJyPg0KwqAgwqAg
wqAgYkRlc2NyaXB0b3JUeXBlwqAgwqAgwqAgwqAgwqA0PGJyPg0KwqAgwqAgwqAgYkludGVyZmFj
ZU51bWJlcsKgIMKgIMKgIMKgIDE8YnI+DQrCoCDCoCDCoCBiQWx0ZXJuYXRlU2V0dGluZ8KgIMKg
IMKgIMKgMjxicj4NCsKgIMKgIMKgIGJOdW1FbmRwb2ludHPCoCDCoCDCoCDCoCDCoCDCoDI8YnI+
DQrCoCDCoCDCoCBiSW50ZXJmYWNlQ2xhc3PCoCDCoCDCoCDCoDI1NSBWZW5kb3IgU3BlY2lmaWMg
Q2xhc3M8YnI+DQrCoCDCoCDCoCBiSW50ZXJmYWNlU3ViQ2xhc3PCoCDCoCDCoCAxPGJyPg0KwqAg
wqAgwqAgYkludGVyZmFjZVByb3RvY29swqAgwqAgwqAgMTxicj4NCsKgIMKgIMKgIGlJbnRlcmZh
Y2XCoCDCoCDCoCDCoCDCoCDCoCDCoCAwPGJyPg0KwqAgwqAgwqAgRW5kcG9pbnQgRGVzY3JpcHRv
cjo8YnI+DQrCoCDCoCDCoCDCoCBiTGVuZ3RowqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA3PGJy
Pg0KwqAgwqAgwqAgwqAgYkRlc2NyaXB0b3JUeXBlwqAgwqAgwqAgwqAgwqA1PGJyPg0KwqAgwqAg
wqAgwqAgYkVuZHBvaW50QWRkcmVzc8KgIMKgIMKgMHg4M8KgIEVQIDMgSU48YnI+DQrCoCDCoCDC
oCDCoCBibUF0dHJpYnV0ZXPCoCDCoCDCoCDCoCDCoCDCoCAxPGJyPg0KwqAgwqAgwqAgwqAgwqAg
VHJhbnNmZXIgVHlwZcKgIMKgIMKgIMKgIMKgIMKgIElzb2Nocm9ub3VzPGJyPg0KwqAgwqAgwqAg
wqAgwqAgU3luY2ggVHlwZcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTm9uZTxicj4NCsKgIMKgIMKg
IMKgIMKgIFVzYWdlIFR5cGXCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoERhdGE8YnI+DQrCoCDCoCDC
oCDCoCB3TWF4UGFja2V0U2l6ZcKgIMKgIMKgMHgwMDExwqAgMXggMTcgYnl0ZXM8YnI+DQrCoCDC
oCDCoCDCoCBiSW50ZXJ2YWzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDE8YnI+DQrCoCDCoCDCoCBF
bmRwb2ludCBEZXNjcmlwdG9yOjxicj4NCsKgIMKgIMKgIMKgIGJMZW5ndGjCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoDc8YnI+DQrCoCDCoCDCoCDCoCBiRGVzY3JpcHRvclR5cGXCoCDCoCDCoCDC
oCDCoDU8YnI+DQrCoCDCoCDCoCDCoCBiRW5kcG9pbnRBZGRyZXNzwqAgwqAgwqAweDAzwqAgRVAg
MyBPVVQ8YnI+DQrCoCDCoCDCoCDCoCBibUF0dHJpYnV0ZXPCoCDCoCDCoCDCoCDCoCDCoCAxPGJy
Pg0KwqAgwqAgwqAgwqAgwqAgVHJhbnNmZXIgVHlwZcKgIMKgIMKgIMKgIMKgIMKgIElzb2Nocm9u
b3VzPGJyPg0KwqAgwqAgwqAgwqAgwqAgU3luY2ggVHlwZcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
Tm9uZTxicj4NCsKgIMKgIMKgIMKgIMKgIFVzYWdlIFR5cGXCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oERhdGE8YnI+DQrCoCDCoCDCoCDCoCB3TWF4UGFja2V0U2l6ZcKgIMKgIMKgMHgwMDExwqAgMXgg
MTcgYnl0ZXM8YnI+DQrCoCDCoCDCoCDCoCBiSW50ZXJ2YWzCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oDE8YnI+DQrCoCDCoCBJbnRlcmZhY2UgRGVzY3JpcHRvcjo8YnI+DQrCoCDCoCDCoCBiTGVuZ3Ro
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA5PGJyPg0KwqAgwqAgwqAgYkRlc2NyaXB0b3JUeXBl
wqAgwqAgwqAgwqAgwqA0PGJyPg0KwqAgwqAgwqAgYkludGVyZmFjZU51bWJlcsKgIMKgIMKgIMKg
IDE8YnI+DQrCoCDCoCDCoCBiQWx0ZXJuYXRlU2V0dGluZ8KgIMKgIMKgIMKgMzxicj4NCsKgIMKg
IMKgIGJOdW1FbmRwb2ludHPCoCDCoCDCoCDCoCDCoCDCoDI8YnI+DQrCoCDCoCDCoCBiSW50ZXJm
YWNlQ2xhc3PCoCDCoCDCoCDCoDI1NSBWZW5kb3IgU3BlY2lmaWMgQ2xhc3M8YnI+DQrCoCDCoCDC
oCBiSW50ZXJmYWNlU3ViQ2xhc3PCoCDCoCDCoCAxPGJyPg0KwqAgwqAgwqAgYkludGVyZmFjZVBy
b3RvY29swqAgwqAgwqAgMTxicj4NCsKgIMKgIMKgIGlJbnRlcmZhY2XCoCDCoCDCoCDCoCDCoCDC
oCDCoCAwPGJyPg0KwqAgwqAgwqAgRW5kcG9pbnQgRGVzY3JpcHRvcjo8YnI+DQrCoCDCoCDCoCDC
oCBiTGVuZ3RowqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA3PGJyPg0KwqAgwqAgwqAgwqAgYkRl
c2NyaXB0b3JUeXBlwqAgwqAgwqAgwqAgwqA1PGJyPg0KwqAgwqAgwqAgwqAgYkVuZHBvaW50QWRk
cmVzc8KgIMKgIMKgMHg4M8KgIEVQIDMgSU48YnI+DQrCoCDCoCDCoCDCoCBibUF0dHJpYnV0ZXPC
oCDCoCDCoCDCoCDCoCDCoCAxPGJyPg0KwqAgwqAgwqAgwqAgwqAgVHJhbnNmZXIgVHlwZcKgIMKg
IMKgIMKgIMKgIMKgIElzb2Nocm9ub3VzPGJyPg0KwqAgwqAgwqAgwqAgwqAgU3luY2ggVHlwZcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgTm9uZTxicj4NCsKgIMKgIMKgIMKgIMKgIFVzYWdlIFR5cGXC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoERhdGE8YnI+DQrCoCDCoCDCoCDCoCB3TWF4UGFja2V0U2l6
ZcKgIMKgIMKgMHgwMDE5wqAgMXggMjUgYnl0ZXM8YnI+DQrCoCDCoCDCoCDCoCBiSW50ZXJ2YWzC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoDE8YnI+DQrCoCDCoCDCoCBFbmRwb2ludCBEZXNjcmlwdG9y
Ojxicj4NCsKgIMKgIMKgIMKgIGJMZW5ndGjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDc8YnI+
DQrCoCDCoCDCoCDCoCBiRGVzY3JpcHRvclR5cGXCoCDCoCDCoCDCoCDCoDU8YnI+DQrCoCDCoCDC
oCDCoCBiRW5kcG9pbnRBZGRyZXNzwqAgwqAgwqAweDAzwqAgRVAgMyBPVVQ8YnI+DQrCoCDCoCDC
oCDCoCBibUF0dHJpYnV0ZXPCoCDCoCDCoCDCoCDCoCDCoCAxPGJyPg0KwqAgwqAgwqAgwqAgwqAg
VHJhbnNmZXIgVHlwZcKgIMKgIMKgIMKgIMKgIMKgIElzb2Nocm9ub3VzPGJyPg0KwqAgwqAgwqAg
wqAgwqAgU3luY2ggVHlwZcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTm9uZTxicj4NCsKgIMKgIMKg
IMKgIMKgIFVzYWdlIFR5cGXCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoERhdGE8YnI+DQrCoCDCoCDC
oCDCoCB3TWF4UGFja2V0U2l6ZcKgIMKgIMKgMHgwMDE5wqAgMXggMjUgYnl0ZXM8YnI+DQrCoCDC
oCDCoCDCoCBiSW50ZXJ2YWzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDE8YnI+DQrCoCDCoCBJbnRl
cmZhY2UgRGVzY3JpcHRvcjo8YnI+DQrCoCDCoCDCoCBiTGVuZ3RowqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqA5PGJyPg0KwqAgwqAgwqAgYkRlc2NyaXB0b3JUeXBlwqAgwqAgwqAgwqAgwqA0PGJy
Pg0KwqAgwqAgwqAgYkludGVyZmFjZU51bWJlcsKgIMKgIMKgIMKgIDE8YnI+DQrCoCDCoCDCoCBi
QWx0ZXJuYXRlU2V0dGluZ8KgIMKgIMKgIMKgNDxicj4NCsKgIMKgIMKgIGJOdW1FbmRwb2ludHPC
oCDCoCDCoCDCoCDCoCDCoDI8YnI+DQrCoCDCoCDCoCBiSW50ZXJmYWNlQ2xhc3PCoCDCoCDCoCDC
oDI1NSBWZW5kb3IgU3BlY2lmaWMgQ2xhc3M8YnI+DQrCoCDCoCDCoCBiSW50ZXJmYWNlU3ViQ2xh
c3PCoCDCoCDCoCAxPGJyPg0KwqAgwqAgwqAgYkludGVyZmFjZVByb3RvY29swqAgwqAgwqAgMTxi
cj4NCsKgIMKgIMKgIGlJbnRlcmZhY2XCoCDCoCDCoCDCoCDCoCDCoCDCoCAwPGJyPg0KwqAgwqAg
wqAgRW5kcG9pbnQgRGVzY3JpcHRvcjo8YnI+DQrCoCDCoCDCoCDCoCBiTGVuZ3RowqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqA3PGJyPg0KwqAgwqAgwqAgwqAgYkRlc2NyaXB0b3JUeXBlwqAgwqAg
wqAgwqAgwqA1PGJyPg0KwqAgwqAgwqAgwqAgYkVuZHBvaW50QWRkcmVzc8KgIMKgIMKgMHg4M8Kg
IEVQIDMgSU48YnI+DQrCoCDCoCDCoCDCoCBibUF0dHJpYnV0ZXPCoCDCoCDCoCDCoCDCoCDCoCAx
PGJyPg0KwqAgwqAgwqAgwqAgwqAgVHJhbnNmZXIgVHlwZcKgIMKgIMKgIMKgIMKgIMKgIElzb2No
cm9ub3VzPGJyPg0KwqAgwqAgwqAgwqAgwqAgU3luY2ggVHlwZcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgTm9uZTxicj4NCsKgIMKgIMKgIMKgIMKgIFVzYWdlIFR5cGXCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoERhdGE8YnI+DQrCoCDCoCDCoCDCoCB3TWF4UGFja2V0U2l6ZcKgIMKgIMKgMHgwMDIxwqAg
MXggMzMgYnl0ZXM8YnI+DQrCoCDCoCDCoCDCoCBiSW50ZXJ2YWzCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoDE8YnI+DQrCoCDCoCDCoCBFbmRwb2ludCBEZXNjcmlwdG9yOjxicj4NCsKgIMKgIMKgIMKg
IGJMZW5ndGjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDc8YnI+DQrCoCDCoCDCoCDCoCBiRGVz
Y3JpcHRvclR5cGXCoCDCoCDCoCDCoCDCoDU8YnI+DQrCoCDCoCDCoCDCoCBiRW5kcG9pbnRBZGRy
ZXNzwqAgwqAgwqAweDAzwqAgRVAgMyBPVVQ8YnI+DQrCoCDCoCDCoCDCoCBibUF0dHJpYnV0ZXPC
oCDCoCDCoCDCoCDCoCDCoCAxPGJyPg0KwqAgwqAgwqAgwqAgwqAgVHJhbnNmZXIgVHlwZcKgIMKg
IMKgIMKgIMKgIMKgIElzb2Nocm9ub3VzPGJyPg0KwqAgwqAgwqAgwqAgwqAgU3luY2ggVHlwZcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgTm9uZTxicj4NCsKgIMKgIMKgIMKgIMKgIFVzYWdlIFR5cGXC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoERhdGE8YnI+DQrCoCDCoCDCoCDCoCB3TWF4UGFja2V0U2l6
ZcKgIMKgIMKgMHgwMDIxwqAgMXggMzMgYnl0ZXM8YnI+DQrCoCDCoCDCoCDCoCBiSW50ZXJ2YWzC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoDE8YnI+DQrCoCDCoCBJbnRlcmZhY2UgRGVzY3JpcHRvcjo8
YnI+DQrCoCDCoCDCoCBiTGVuZ3RowqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA5PGJyPg0KwqAg
wqAgwqAgYkRlc2NyaXB0b3JUeXBlwqAgwqAgwqAgwqAgwqA0PGJyPg0KwqAgwqAgwqAgYkludGVy
ZmFjZU51bWJlcsKgIMKgIMKgIMKgIDE8YnI+DQrCoCDCoCDCoCBiQWx0ZXJuYXRlU2V0dGluZ8Kg
IMKgIMKgIMKgNTxicj4NCsKgIMKgIMKgIGJOdW1FbmRwb2ludHPCoCDCoCDCoCDCoCDCoCDCoDI8
YnI+DQrCoCDCoCDCoCBiSW50ZXJmYWNlQ2xhc3PCoCDCoCDCoCDCoDI1NSBWZW5kb3IgU3BlY2lm
aWMgQ2xhc3M8YnI+DQrCoCDCoCDCoCBiSW50ZXJmYWNlU3ViQ2xhc3PCoCDCoCDCoCAxPGJyPg0K
wqAgwqAgwqAgYkludGVyZmFjZVByb3RvY29swqAgwqAgwqAgMTxicj4NCsKgIMKgIMKgIGlJbnRl
cmZhY2XCoCDCoCDCoCDCoCDCoCDCoCDCoCAwPGJyPg0KwqAgwqAgwqAgRW5kcG9pbnQgRGVzY3Jp
cHRvcjo8YnI+DQrCoCDCoCDCoCDCoCBiTGVuZ3RowqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA3
PGJyPg0KwqAgwqAgwqAgwqAgYkRlc2NyaXB0b3JUeXBlwqAgwqAgwqAgwqAgwqA1PGJyPg0KwqAg
wqAgwqAgwqAgYkVuZHBvaW50QWRkcmVzc8KgIMKgIMKgMHg4M8KgIEVQIDMgSU48YnI+DQrCoCDC
oCDCoCDCoCBibUF0dHJpYnV0ZXPCoCDCoCDCoCDCoCDCoCDCoCAxPGJyPg0KwqAgwqAgwqAgwqAg
wqAgVHJhbnNmZXIgVHlwZcKgIMKgIMKgIMKgIMKgIMKgIElzb2Nocm9ub3VzPGJyPg0KwqAgwqAg
wqAgwqAgwqAgU3luY2ggVHlwZcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTm9uZTxicj4NCsKgIMKg
IMKgIMKgIMKgIFVzYWdlIFR5cGXCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoERhdGE8YnI+DQrCoCDC
oCDCoCDCoCB3TWF4UGFja2V0U2l6ZcKgIMKgIMKgMHgwMDMxwqAgMXggNDkgYnl0ZXM8YnI+DQrC
oCDCoCDCoCDCoCBiSW50ZXJ2YWzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDE8YnI+DQrCoCDCoCDC
oCBFbmRwb2ludCBEZXNjcmlwdG9yOjxicj4NCsKgIMKgIMKgIMKgIGJMZW5ndGjCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoDc8YnI+DQrCoCDCoCDCoCDCoCBiRGVzY3JpcHRvclR5cGXCoCDCoCDC
oCDCoCDCoDU8YnI+DQrCoCDCoCDCoCDCoCBiRW5kcG9pbnRBZGRyZXNzwqAgwqAgwqAweDAzwqAg
RVAgMyBPVVQ8YnI+DQrCoCDCoCDCoCDCoCBibUF0dHJpYnV0ZXPCoCDCoCDCoCDCoCDCoCDCoCAx
PGJyPg0KwqAgwqAgwqAgwqAgwqAgVHJhbnNmZXIgVHlwZcKgIMKgIMKgIMKgIMKgIMKgIElzb2No
cm9ub3VzPGJyPg0KwqAgwqAgwqAgwqAgwqAgU3luY2ggVHlwZcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgTm9uZTxicj4NCsKgIMKgIMKgIMKgIMKgIFVzYWdlIFR5cGXCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoERhdGE8YnI+DQrCoCDCoCDCoCDCoCB3TWF4UGFja2V0U2l6ZcKgIMKgIMKgMHgwMDMxwqAg
MXggNDkgYnl0ZXM8YnI+DQrCoCDCoCDCoCDCoCBiSW50ZXJ2YWzCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoDE8YnI+DQrCoCDCoCBJbnRlcmZhY2UgRGVzY3JpcHRvcjo8YnI+DQrCoCDCoCDCoCBiTGVu
Z3RowqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA5PGJyPg0KwqAgwqAgwqAgYkRlc2NyaXB0b3JU
eXBlwqAgwqAgwqAgwqAgwqA0PGJyPg0KwqAgwqAgwqAgYkludGVyZmFjZU51bWJlcsKgIMKgIMKg
IMKgIDI8YnI+DQrCoCDCoCDCoCBiQWx0ZXJuYXRlU2V0dGluZ8KgIMKgIMKgIMKgMDxicj4NCsKg
IMKgIMKgIGJOdW1FbmRwb2ludHPCoCDCoCDCoCDCoCDCoCDCoDI8YnI+DQrCoCDCoCDCoCBiSW50
ZXJmYWNlQ2xhc3PCoCDCoCDCoCDCoDI1NSBWZW5kb3IgU3BlY2lmaWMgQ2xhc3M8YnI+DQrCoCDC
oCDCoCBiSW50ZXJmYWNlU3ViQ2xhc3PCoCDCoCAyNTUgVmVuZG9yIFNwZWNpZmljIFN1YmNsYXNz
PGJyPg0KwqAgwqAgwqAgYkludGVyZmFjZVByb3RvY29swqAgwqAgMjU1IFZlbmRvciBTcGVjaWZp
YyBQcm90b2NvbDxicj4NCsKgIMKgIMKgIGlJbnRlcmZhY2XCoCDCoCDCoCDCoCDCoCDCoCDCoCAw
PGJyPg0KwqAgwqAgwqAgRW5kcG9pbnQgRGVzY3JpcHRvcjo8YnI+DQrCoCDCoCDCoCDCoCBiTGVu
Z3RowqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA3PGJyPg0KwqAgwqAgwqAgwqAgYkRlc2NyaXB0
b3JUeXBlwqAgwqAgwqAgwqAgwqA1PGJyPg0KwqAgwqAgwqAgwqAgYkVuZHBvaW50QWRkcmVzc8Kg
IMKgIMKgMHg4NMKgIEVQIDQgSU48YnI+DQrCoCDCoCDCoCDCoCBibUF0dHJpYnV0ZXPCoCDCoCDC
oCDCoCDCoCDCoCAyPGJyPg0KwqAgwqAgwqAgwqAgwqAgVHJhbnNmZXIgVHlwZcKgIMKgIMKgIMKg
IMKgIMKgIEJ1bGs8YnI+DQrCoCDCoCDCoCDCoCDCoCBTeW5jaCBUeXBlwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBOb25lPGJyPg0KwqAgwqAgwqAgwqAgwqAgVXNhZ2UgVHlwZcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgRGF0YTxicj4NCsKgIMKgIMKgIMKgIHdNYXhQYWNrZXRTaXplwqAgwqAgwqAweDAw
MjDCoCAxeCAzMiBieXRlczxicj4NCsKgIMKgIMKgIMKgIGJJbnRlcnZhbMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgMTxicj4NCsKgIMKgIMKgIEVuZHBvaW50IERlc2NyaXB0b3I6PGJyPg0KwqAgwqAg
wqAgwqAgYkxlbmd0aMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgNzxicj4NCsKgIMKgIMKgIMKg
IGJEZXNjcmlwdG9yVHlwZcKgIMKgIMKgIMKgIMKgNTxicj4NCsKgIMKgIMKgIMKgIGJFbmRwb2lu
dEFkZHJlc3PCoCDCoCDCoDB4MDTCoCBFUCA0IE9VVDxicj4NCsKgIMKgIMKgIMKgIGJtQXR0cmli
dXRlc8KgIMKgIMKgIMKgIMKgIMKgIDI8YnI+DQrCoCDCoCDCoCDCoCDCoCBUcmFuc2ZlciBUeXBl
wqAgwqAgwqAgwqAgwqAgwqAgQnVsazxicj4NCsKgIMKgIMKgIMKgIMKgIFN5bmNoIFR5cGXCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoE5vbmU8YnI+DQrCoCDCoCDCoCDCoCDCoCBVc2FnZSBUeXBlwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBEYXRhPGJyPg0KwqAgwqAgwqAgwqAgd01heFBhY2tldFNpemXC
oCDCoCDCoDB4MDAyMMKgIDF4IDMyIGJ5dGVzPGJyPg0KwqAgwqAgwqAgwqAgYkludGVydmFswqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAxPGJyPg0KwqAgwqAgSW50ZXJmYWNlIERlc2NyaXB0b3I6PGJy
Pg0KwqAgwqAgwqAgYkxlbmd0aMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgOTxicj4NCsKgIMKg
IMKgIGJEZXNjcmlwdG9yVHlwZcKgIMKgIMKgIMKgIMKgNDxicj4NCsKgIMKgIMKgIGJJbnRlcmZh
Y2VOdW1iZXLCoCDCoCDCoCDCoCAzPGJyPg0KwqAgwqAgwqAgYkFsdGVybmF0ZVNldHRpbmfCoCDC
oCDCoCDCoDA8YnI+DQrCoCDCoCDCoCBiTnVtRW5kcG9pbnRzwqAgwqAgwqAgwqAgwqAgwqAwPGJy
Pg0KwqAgwqAgwqAgYkludGVyZmFjZUNsYXNzwqAgwqAgwqAgwqAyNTQgQXBwbGljYXRpb24gU3Bl
Y2lmaWMgSW50ZXJmYWNlPGJyPg0KwqAgwqAgwqAgYkludGVyZmFjZVN1YkNsYXNzwqAgwqAgwqAg
MSBEZXZpY2UgRmlybXdhcmUgVXBkYXRlPGJyPg0KwqAgwqAgwqAgYkludGVyZmFjZVByb3RvY29s
wqAgwqAgwqAgMTxicj4NCsKgIMKgIMKgIGlJbnRlcmZhY2XCoCDCoCDCoCDCoCDCoCDCoCDCoCAw
PGJyPg0KwqAgwqAgwqAgRGV2aWNlIEZpcm13YXJlIFVwZ3JhZGUgSW50ZXJmYWNlIERlc2NyaXB0
b3I6PGJyPg0KwqAgwqAgwqAgwqAgYkxlbmd0aMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgOTxicj4NCsKgIMKgIMKgIMKgIGJEZXNjcmlwdG9yVHlwZcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIDMzPGJyPg0KwqAgwqAgwqAgwqAgYm1BdHRyaWJ1dGVzwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgNTxicj4NCsKgIMKgIMKgIMKgIMKgIFdp
bGwgTm90IERldGFjaDxicj4NCsKgIMKgIMKgIMKgIMKgIE1hbmlmZXN0YXRpb24gVG9sZXJhbnQ8
YnI+DQrCoCDCoCDCoCDCoCDCoCBVcGxvYWQgVW5zdXBwb3J0ZWQ8YnI+DQrCoCDCoCDCoCDCoCDC
oCBEb3dubG9hZCBTdXBwb3J0ZWQ8YnI+DQrCoCDCoCDCoCDCoCB3RGV0YWNoVGltZW91dMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgNTAwMCBtaWxsaXNlY29uZHM8YnI+DQrCoCDCoCDCoCDC
oCB3VHJhbnNmZXJTaXplwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgNjQgYnl0ZXM8
YnI+DQrCoCDCoCDCoCDCoCBiY2RERlVWZXJzaW9uwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAxLjEwPGJyPg0KRGV2aWNlIFN0YXR1czrCoCDCoCDCoDB4MDAwMDxicj4NCsKgIChCdXMgUG93
ZXJlZCk8YnI+DQo8YnI+DQpSZWdhcmRzLDxicj4NCjxicj4NCkhhbnM8YnI+DQo8L2Jsb2NrcXVv
dGU+PC9kaXY+PGJyPjwvZGl2Pg0K
--94eb2c124cb800e9d80553b73a09--
