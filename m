Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAENjB=JKRcH0V7K_Ga-8YVxM-fe2+GEcTs2ikVO0wWUbdLy24Q@mail.gmail.com>
References: <CAENjB=J_Qf_6hzOLXFMfrSrwVC6tp+dJhS+h=m2-HHgbQxFHag@mail.gmail.com>
 <87shmcpttt.fsf@intel.com> <CAENjB=JKRcH0V7K_Ga-8YVxM-fe2+GEcTs2ikVO0wWUbdLy24Q@mail.gmail.com>
From: Luke McKee <hojuruku@gmail.com>
Date: Fri, 17 Mar 2017 17:06:43 +0700
Message-ID: <CAENjB=LwmZH6hirZNwab8BJzmMnbSBte9AvMM5-1HUu97N-REA@mail.gmail.com>
Subject: Re: Lower Level Host Stack bug - 0x1a (remote host feature) using
 EDR+SCO to non-capable Taiwanese/Chinese devices
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-bluetooth@vger.kernel.org, bluetooth_help@broadcom.com
Cc: georg@chini.tk, Geoffrey McKee <gamckee@gmail.com>,
        Michael Borusiewicz <lukesarmy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

[    3.143609] usb 3-6.3: new full-speed USB device number 7 using xhci_hcd
[    3.225202] usb 3-6.3: New USB device found, idVendor=3D0a5c, idProduct=
=3D2148
[    3.225847] usb 3-6.3: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[    3.225848] usb 3-6.3: Product: BCM92046DG-CL1ROM
[    3.225849] usb 3-6.3: Manufacturer: Broadcom Corp
[    3.225850] usb 3-6.3: SerialNumber: 00198600002E

Vinicius,

I'm not so sure usb HCI firmware/adapter is the issue.

There seems to be no record of the specific usb product id in btusb.c or bt=
cm.c
But some non-PatchRAM broadcom's can be updated according to a Mac OS
PatchRAM program on github.

Does this device need a firmware update?

I got the *newish* Broadcom windows driver for an IOGEAR that seems to
have the same USB ID's.
Mine comes from the same factory as the ASUS one by the look of it
without the ASUS logo, and ASUS has no drivers on their website
https://www.asus.com/Networking/USBBT211_Mini_Bluetooth_Dongle/
https://www.iogear.com/support/dm/driver/GBU421

Kicked off the installer via wine (needs MFC42.DLL) to see what's
inside and got some tips from here:
https://www.tonymacx86.com/threads/brcmpatchram-upload-firmware-into-broadc=
om-bluetooth-usb-devices.150661/

%BRCM2046_UHE.DeviceDesc%=3DBRSMARTUSB,  USB\VID_0A5C&PID_2148
BRCM2046_UHE.DeviceDesc=3D"Broadcom 2046 Bluetooth 2.1 USB UHE Dongle"

The latest drivers are here:
https://www.asus.com/us/Motherboards/X99DELUXE/HelpDesk_Download/ -
that didn't have by USB device ID in it.
https://github.com/RehabMan/OS-X-BrcmPatchRAM

Because this one does HID at boot, it doesn't RAM patch any firmware
into the device, at least in the Windows XP driver.

So I guess the problem is either with the chip (broadcomm - do you
need to make a patch?) or it's SCO setup using the wrong packet types.

I'll test my vanilla kernel and try and connect to an Iphone6 that
should do eSCO EDR 3-EV3 packets tonight.

I looked into this because udevadm monitor --property |grep FIRMWARE
reported nothing. It's not using firmware.

On 17 March 2017 at 13:58, Luke McKee <hojuruku@gmail.com> wrote:
> On 17 March 2017 at 08:37, Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
>
>>
>> Your analysis was very good, but looks like it missed an important
>> detail: the error reported is in the Command *Status* event not in the
>> Command *Complete* event. The Command Status event is used by the *local=
*
>> controller to report errors. So it probably means that it is your local
>> controller that doesn't support that set of parameters, i.e. it is a
>> misbehaving controller.
>
> It was my first attempt at bluetooth packet analysis :P
>
> In any case the request is wrong not trying for basic rate eSCO (EV3)
> or SCO right if the remote device doesn't support it? LMP issues.
>
> Are you sure about that? According to the docs included below the
> specs say bluetooth will report a "connection complete event". Failed
> connections due to incompatible packet types don't complete, and the
> packet you were looking for never comes. Scroll to the very end of the
> email, I cut and paste a little of the bluetooth specs for the benefit
> of others.
>
> The logs below showing the request going straight for 3Mbit eSCO only
> in the connection setup, even with the kernel argument set to disable
> esco! Strange!
>
> uname -a
> Linux hojuruku 4.9.0-sabayon-msi #1 SMP PREEMPT Thu Mar 16 15:10:04
> ICT 2017 x86_64 Intel(R) Core(TM) i5-4460 CPU @ 3.20GHz GenuineIntel
> GNU/Linux
>
>
>> to disable eSCO support locally.
>>
>> Now I am curious, what controller is that?
>>
>
> It's funny people talk about the controller on the raspberry pi forums
> with a lot of grudges. I'm using an x86_64. If you see the earlier
> email it's a broadcomm. If I'd buy a new one i'd get a Cambridge
> Silicon. Intel has usb HCI bluetooth devices?
>
> Physically it looks a dead ringer for this ASUS without the branding
> https://www.asus.com/Networking/USBBT211_Mini_Bluetooth_Dongle/
>
> Can we extract firmware from the windows drivers and update Linux-frimwar=
e?
>
> bus 003 Device 007: ID 0a5c:2148 Broadcom Corp. BCM92046DG-CL1ROM
> Bluetooth 2.1 Adapter
> Bus 003 Device 006: ID 0a5c:4503 Broadcom Corp. Mouse (Boot Interface Sub=
class)
> Bus 003 Device 005: ID 0a5c:4502 Broadcom Corp. Keyboard (Boot
> Interface Subclass)
> Bus 003 Device 004: ID 0a5c:4500 Broadcom Corp. BCM2046B1 USB 2.0 Hub
> (part of BCM2046 Bluetooth)
>
>>
>> One possible workaround is to do something like this:
>>
>> $ echo 1 > /sys/module/bluetooth/parameters/disable_esco
>>
>
> Like I said 3 or so  times I'm betting on EDR packet types + eSCO as
> both host and device support eSCO, The Linux is sending the wrong
> packet type mask to the device, or at least not retrying for a slower
> speed / regular SCO.
>
> Disabling esco should have made the request only want packet types HV1
> HV2 HV3 but it didn't!
>
> This is interesting I disabled esco via a grub reboot / kernel cmdline
> ask you ask bluetooth.disable_esco=3D1 and here's what I got in testing.
> It didn't make a difference? Regression?
>
> I'm going to compile the latest Vanilla kernel right now with the same
> configuration (no patch suggested in previous email) and try again.
> If I don't reply that means I got the same results as below.
>
> systool -vm bluetooth:
> Module =3D "bluetooth"
>
>   Attributes:
>     uevent              =3D <store method only>
>     version             =3D "2.22"
>
>   Parameters:
>     disable_ertm        =3D "N"
>     disable_esco        =3D "Y"
>
> It's meant to be disabled ... but.....
>
> pulseaudio -vvvv
> D: [pulseaudio] module-bluez5-device.c: Acquiring transport
> /org/bluez/hci0/dev_30_21_57_95_5A_3A/fd22
> I: [pulseaudio] backend-native.c: doing connect
> E: [pulseaudio] backend-native.c: connect(): Protocol not supported
>
> hcidump -R
> HCI sniffer - Bluetooth packet analyzer ver 5.44
> device: hci0 snap_len: 1500 filter: 0xffffffffffffffff
> < 01 04 08 02 0B 00
>> 04 0F 04 00 01 04 08
>> 04 1B 03 0B 00 05
>> 04 14 06 00 0B 00 00 00 00
> < 01 28 04 11 0B 00 40 1F 00 00 40 1F 00 00 0A 00 60 00 01 80
>   03
>> 04 0F 04 1A 01 28 04
>
> hcidump
> HCI sniffer - Bluetooth packet analyzer ver 5.44
> device: hci0 snap_len: 1500 filter: 0xffffffffffffffff
> < HCI Command: Exit Sniff Mode (0x02|0x0004) plen 2
>     handle 11
>> HCI Event: Command Status (0x0f) plen 4
>     Exit Sniff Mode (0x02|0x0004) status 0x00 ncmd 1
>> HCI Event: Max Slots Change (0x1b) plen 3
>     handle 11 slots 5
>> HCI Event: Mode Change (0x14) plen 6
>     status 0x00 handle 11 mode 0x00 interval 0
>     Mode: Active
> < HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
>     handle 11 voice setting 0x0060 ptype 0x0380
>> HCI Event: Command Status (0x0f) plen 4
>     Setup Synchronous Connection (0x01|0x0028) status 0x1a ncmd 1
>     Error: Unsupported Remote Feature / Unsupported LMP Feature
>
> 2.26 Unsupported Remote Feature / Unsupported LMP
> Feature (0X1A)
> The Unsupported Remote Feature error code indicates that the remote devic=
e
> does not support the feature associated with the issued command or LMP PD=
U.
>
>
> esco and SCO are negotiated with the same first step, to see what
> packet types are available for sco links. The Packet type option given
> by Linux precludes SCO, or eSCO EV3 (enhanced sco - basic rate no
> EDR).
>
>
> https://www.bluetooth.org/docman/handlers/DownloadDoc.ashx?doc_id=3D40211=
&vId=3D41552
>
> "2.5 Packet Types
> All Controllers that support eSCO have to support the EV3 packet type.
> This ensures that the Controllers
> will have at least one packet type in common. However, it is possible
> for a Host to set the packet_type
> mask such that the mandatory packet type is not selected. When this
> happens there is a possibility that the
> Link Manager cannot negotiate an eSCO connection."
>
> Linux isn't accepting EV3 on first request, (non EDR eSCO packet type)
> I'll roll back to vanilla kernel without anything patched to confirm
> this. Without retries configured in the kernel to at least attempt a
> EV3 connection without EDR.
>
> THIS DOCUMENT https://media.digikey.com/pdf/Data%20Sheets/Taiyo%20Yuden%2=
0PDFs%20URL%20links/EYSFDCAXW.pdf
> shows the different SCO/ESCO packet types.
> and the HCI DUMP Below shows Linux is requesting ONLY ESCO EDR 3-EV3
> Data types (3mbit eSCO) - and  the LMP isn't negotiating the right
> feature mask. The dump not only shows the connection error at the end
> but the features supported by the device (hcitool info xx:yy:zz).
>
> http://www.testunlimited.com/pdf/an/5988-3760EN.pdf
> "Packet types
> Standard rate The 1, 3, and 5 suffixes indicate the number:
> NULL, POLL, FHS-system packets DH1-366 =C2=B5s
> DH3-1622 =C2=B5s
> DM1, DM3, DM5-medium rate, error-protected data packets DH5-2870 =C2=B5s
> of time slots occupied by the data burst
> DH1, DH3, DH5-high rate, non-protected data packets
> HV1, HV2, HV3-digitized audio, three levels of error protection; ominal
> burst lengths DV-mixed data and voice, synchronous or asynchronous
> AUX1-for other uses
> 2 Mb/s packets:
> 2-EV3, 2-EV5- same as standard rate packet but modulated
> using =CF=80/4-DQPSK
> 2-DH1, 2-DH3, 2-DH5-same as standard rate packet but modulated
> using =CF=80/4-DQPSK
> 3 Mb/s packets:
> 3-EV3, 3-EV5-same as standard rate packet but modulated using 8DQPSK
> 3-DH1, 3-DH3, 3-DH5-same as standard rate packet but modulated
> using 8DPSK
>
>
> Frame 1: 14 bytes on wire (112 bits), 14 bytes captured (112 bits)
>     Encapsulation type: Bluetooth H4 with linux header (99)
>     Arrival Time: Mar 17, 2017 12:17:04.313015000 ICT
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1489727824.313015000 seconds
>     [Time delta from previous captured frame: 0.000000000 seconds]
>     [Time delta from previous displayed frame: 0.000000000 seconds]
>     [Time since reference or first frame: 0.000000000 seconds]
>     Frame Number: 1
>     Frame Length: 14 bytes (112 bits)
>     Capture Length: 14 bytes (112 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     Point-to-Point Direction: Sent (0)
>     [Protocols in frame: bluetooth:hci_h4:bthci_cmd]
> Bluetooth
>     [Source: host]
>     [Destination: controller]
> Bluetooth HCI H4
>     [Direction: Sent (0x00)]
>     HCI Packet Type: HCI Command (0x01)
> Bluetooth HCI Command - Remote Name Request
>     Command Opcode: Remote Name Request (0x0419)
>         0000 01.. .... .... =3D Opcode Group Field: Link Control Commands=
 (0x01)
>         .... ..00 0001 1001 =3D Opcode Command Field: Remote Name Request=
 (0x019)
>     Parameter Total Length: 10
>     BD_ADDR: 30:21:57:95:5a:3a (30:21:57:95:5a:3a)
>     Page Scan Repetition Mode: R2 (0x02)
>     Page Scan Mode: Mandatory Page Scan Mode (0x00)
>     .000 0000 0000 0000 =3D Clock Offset: 0x0000 (0 msec)
>     0... .... .... .... =3D Clock_Offset_Valid_Flag: false (0)
>     [Pending in frame: 2]
>     [Command-Pending Delta: 1.669 ms]
>     [Response in frame: 3]
>     [Command-Response Delta: 244.669 ms]
>
> 0000  01 19 04 0a 3a 5a 95 57 21 30 02 00 00 00         ....:Z.W!0....
>
> Frame 2: 7 bytes on wire (56 bits), 7 bytes captured (56 bits)
>     Encapsulation type: Bluetooth H4 with linux header (99)
>     Arrival Time: Mar 17, 2017 12:17:04.314684000 ICT
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1489727824.314684000 seconds
>     [Time delta from previous captured frame: 0.001669000 seconds]
>     [Time delta from previous displayed frame: 0.001669000 seconds]
>     [Time since reference or first frame: 0.001669000 seconds]
>     Frame Number: 2
>     Frame Length: 7 bytes (56 bits)
>     Capture Length: 7 bytes (56 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     Point-to-Point Direction: Received (1)
>     [Protocols in frame: bluetooth:hci_h4:bthci_evt]
> Bluetooth
>     [Source: controller]
>     [Destination: host]
> Bluetooth HCI H4
>     [Direction: Rcvd (0x01)]
>     HCI Packet Type: HCI Event (0x04)
> Bluetooth HCI Event - Command Status
>     Event Code: Command Status (0x0f)
>     Parameter Total Length: 4
>     Status: Pending (0x00)
>     Number of Allowed Command Packets: 1
>     Command Opcode: Remote Name Request (0x0419)
>         0000 01.. .... .... =3D Opcode Group Field: Link Control Commands=
 (0x01)
>         .... ..00 0001 1001 =3D Opcode Command Field: Remote Name Request=
 (0x019)
>     [Command in frame: 1]
>     [Response in frame: 3]
>     [Command-Pending Delta: 1.669 ms]
>     [Pending-Response Delta: 243 ms]
>
> 0000  04 0f 04 00 01 19 04                              .......
>
> Frame 3: 258 bytes on wire (2064 bits), 258 bytes captured (2064 bits)
>     Encapsulation type: Bluetooth H4 with linux header (99)
>     Arrival Time: Mar 17, 2017 12:17:04.557684000 ICT
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1489727824.557684000 seconds
>     [Time delta from previous captured frame: 0.243000000 seconds]
>     [Time delta from previous displayed frame: 0.243000000 seconds]
>     [Time since reference or first frame: 0.244669000 seconds]
>     Frame Number: 3
>     Frame Length: 258 bytes (2064 bits)
>     Capture Length: 258 bytes (2064 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     Point-to-Point Direction: Received (1)
>     [Protocols in frame: bluetooth:hci_h4:bthci_evt]
> Bluetooth
>     [Source: controller]
>     [Destination: host]
> Bluetooth HCI H4
>     [Direction: Rcvd (0x01)]
>     HCI Packet Type: HCI Event (0x04)
> Bluetooth HCI Event - Remote Name Request Complete
>     Event Code: Remote Name Request Complete (0x07)
>     Parameter Total Length: 255
>     Status: Success (0x00)
>     BD_ADDR: 30:21:57:95:5a:3a (30:21:57:95:5a:3a)
>     Remote Name: JY-17
>     [Command in frame: 1]
>     [Pending in frame: 2]
>     [Pending-Response Delta: 243 ms]
>     [Command-Response Delta: 244.669 ms]
>
> 0000  04 07 ff 00 3a 5a 95 57 21 30 4a 59 2d 31 37 00   ....:Z.W!0JY-17.
> 0010  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
> 0020  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
> 0030  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
> 0040  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
> 0050  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
> 0060  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
> 0070  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
> 0080  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
> 0090  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
> 00a0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
> 00b0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
> 00c0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
> 00d0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
> 00e0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
> 00f0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
> 0100  00 00                                             ..
>
> Frame 4: 6 bytes on wire (48 bits), 6 bytes captured (48 bits)
>     Encapsulation type: Bluetooth H4 with linux header (99)
>     Arrival Time: Mar 17, 2017 12:17:04.557774000 ICT
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1489727824.557774000 seconds
>     [Time delta from previous captured frame: 0.000090000 seconds]
>     [Time delta from previous displayed frame: 0.000090000 seconds]
>     [Time since reference or first frame: 0.244759000 seconds]
>     Frame Number: 4
>     Frame Length: 6 bytes (48 bits)
>     Capture Length: 6 bytes (48 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     Point-to-Point Direction: Sent (0)
>     [Protocols in frame: bluetooth:hci_h4:bthci_cmd]
> Bluetooth
>     [Source: host]
>     [Destination: controller]
> Bluetooth HCI H4
>     [Direction: Sent (0x00)]
>     HCI Packet Type: HCI Command (0x01)
> Bluetooth HCI Command - Read Remote Version Information
>     Command Opcode: Read Remote Version Information (0x041d)
>         0000 01.. .... .... =3D Opcode Group Field: Link Control Commands=
 (0x01)
>         .... ..00 0001 1101 =3D Opcode Command Field: Read Remote
> Version Information (0x01d)
>     Parameter Total Length: 2
>     Connection Handle: 0x000b
>     [Pending in frame: 5]
>     [Command-Pending Delta: 0.914 ms]
>     [Response in frame: 6]
>     [Command-Response Delta: 1.916 ms]
>
> 0000  01 1d 04 02 0b 00                                 ......
>
> Frame 5: 7 bytes on wire (56 bits), 7 bytes captured (56 bits)
>     Encapsulation type: Bluetooth H4 with linux header (99)
>     Arrival Time: Mar 17, 2017 12:17:04.558688000 ICT
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1489727824.558688000 seconds
>     [Time delta from previous captured frame: 0.000914000 seconds]
>     [Time delta from previous displayed frame: 0.000914000 seconds]
>     [Time since reference or first frame: 0.245673000 seconds]
>     Frame Number: 5
>     Frame Length: 7 bytes (56 bits)
>     Capture Length: 7 bytes (56 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     Point-to-Point Direction: Received (1)
>     [Protocols in frame: bluetooth:hci_h4:bthci_evt]
> Bluetooth
>     [Source: controller]
>     [Destination: host]
> Bluetooth HCI H4
>     [Direction: Rcvd (0x01)]
>     HCI Packet Type: HCI Event (0x04)
> Bluetooth HCI Event - Command Status
>     Event Code: Command Status (0x0f)
>     Parameter Total Length: 4
>     Status: Pending (0x00)
>     Number of Allowed Command Packets: 1
>     Command Opcode: Read Remote Version Information (0x041d)
>         0000 01.. .... .... =3D Opcode Group Field: Link Control Commands=
 (0x01)
>         .... ..00 0001 1101 =3D Opcode Command Field: Read Remote
> Version Information (0x01d)
>     [Command in frame: 4]
>     [Response in frame: 6]
>     [Command-Pending Delta: 0.914 ms]
>     [Pending-Response Delta: 1.002 ms]
>
> 0000  04 0f 04 00 01 1d 04                              .......
>
> Frame 6: 11 bytes on wire (88 bits), 11 bytes captured (88 bits)
>     Encapsulation type: Bluetooth H4 with linux header (99)
>     Arrival Time: Mar 17, 2017 12:17:04.559690000 ICT
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1489727824.559690000 seconds
>     [Time delta from previous captured frame: 0.001002000 seconds]
>     [Time delta from previous displayed frame: 0.001002000 seconds]
>     [Time since reference or first frame: 0.246675000 seconds]
>     Frame Number: 6
>     Frame Length: 11 bytes (88 bits)
>     Capture Length: 11 bytes (88 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     Point-to-Point Direction: Received (1)
>     [Protocols in frame: bluetooth:hci_h4:bthci_evt]
> Bluetooth
>     [Source: controller]
>     [Destination: host]
> Bluetooth HCI H4
>     [Direction: Rcvd (0x01)]
>     HCI Packet Type: HCI Event (0x04)
> Bluetooth HCI Event - Read Remote Version Information Complete
>     Event Code: Read Remote Version Information Complete (0x0c)
>     Parameter Total Length: 8
>     Status: Success (0x00)
>     Connection Handle: 0x000b
>     LMP Version: 3.0 + HS (0x05)
>     Manufacturer Name: CONWISE Technology Corporation Ltd (0x0042)
>     LMP Subversion: 500
>     [Command in frame: 4]
>     [Pending in frame: 5]
>     [Pending-Response Delta: 1.002 ms]
>     [Command-Response Delta: 1.916 ms]
>
> 0000  04 0c 08 00 0b 00 05 42 00 f4 01                  .......B...
>
> Frame 7: 6 bytes on wire (48 bits), 6 bytes captured (48 bits)
>     Encapsulation type: Bluetooth H4 with linux header (99)
>     Arrival Time: Mar 17, 2017 12:17:04.559789000 ICT
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1489727824.559789000 seconds
>     [Time delta from previous captured frame: 0.000099000 seconds]
>     [Time delta from previous displayed frame: 0.000099000 seconds]
>     [Time since reference or first frame: 0.246774000 seconds]
>     Frame Number: 7
>     Frame Length: 6 bytes (48 bits)
>     Capture Length: 6 bytes (48 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     Point-to-Point Direction: Sent (0)
>     [Protocols in frame: bluetooth:hci_h4:bthci_cmd]
> Bluetooth
>     [Source: host]
>     [Destination: controller]
> Bluetooth HCI H4
>     [Direction: Sent (0x00)]
>     HCI Packet Type: HCI Command (0x01)
> Bluetooth HCI Command - Read Remote Supported Features
>     Command Opcode: Read Remote Supported Features (0x041b)
>         0000 01.. .... .... =3D Opcode Group Field: Link Control Commands=
 (0x01)
>         .... ..00 0001 1011 =3D Opcode Command Field: Read Remote
> Supported Features (0x01b)
>     Parameter Total Length: 2
>     Connection Handle: 0x000b
>     [Pending in frame: 8]
>     [Command-Pending Delta: 0.898 ms]
>     [Response in frame: 9]
>     [Command-Response Delta: 1.904 ms]
>
> 0000  01 1b 04 02 0b 00                                 ......
>
> Frame 8: 7 bytes on wire (56 bits), 7 bytes captured (56 bits)
>     Encapsulation type: Bluetooth H4 with linux header (99)
>     Arrival Time: Mar 17, 2017 12:17:04.560687000 ICT
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1489727824.560687000 seconds
>     [Time delta from previous captured frame: 0.000898000 seconds]
>     [Time delta from previous displayed frame: 0.000898000 seconds]
>     [Time since reference or first frame: 0.247672000 seconds]
>     Frame Number: 8
>     Frame Length: 7 bytes (56 bits)
>     Capture Length: 7 bytes (56 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     Point-to-Point Direction: Received (1)
>     [Protocols in frame: bluetooth:hci_h4:bthci_evt]
> Bluetooth
>     [Source: controller]
>     [Destination: host]
> Bluetooth HCI H4
>     [Direction: Rcvd (0x01)]
>     HCI Packet Type: HCI Event (0x04)
> Bluetooth HCI Event - Command Status
>     Event Code: Command Status (0x0f)
>     Parameter Total Length: 4
>     Status: Pending (0x00)
>     Number of Allowed Command Packets: 1
>     Command Opcode: Read Remote Supported Features (0x041b)
>         0000 01.. .... .... =3D Opcode Group Field: Link Control Commands=
 (0x01)
>         .... ..00 0001 1011 =3D Opcode Command Field: Read Remote
> Supported Features (0x01b)
>     [Command in frame: 7]
>     [Response in frame: 9]
>     [Command-Pending Delta: 0.898 ms]
>     [Pending-Response Delta: 1.006 ms]
>
> 0000  04 0f 04 00 01 1b 04                              .......
>
> Frame 9: 14 bytes on wire (112 bits), 14 bytes captured (112 bits)
>     Encapsulation type: Bluetooth H4 with linux header (99)
>     Arrival Time: Mar 17, 2017 12:17:04.561693000 ICT
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1489727824.561693000 seconds
>     [Time delta from previous captured frame: 0.001006000 seconds]
>     [Time delta from previous displayed frame: 0.001006000 seconds]
>     [Time since reference or first frame: 0.248678000 seconds]
>     Frame Number: 9
>     Frame Length: 14 bytes (112 bits)
>     Capture Length: 14 bytes (112 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     Point-to-Point Direction: Received (1)
>     [Protocols in frame: bluetooth:hci_h4:bthci_evt]
> Bluetooth
>     [Source: controller]
>     [Destination: host]
> Bluetooth HCI H4
>     [Direction: Rcvd (0x01)]
>     HCI Packet Type: HCI Event (0x04)
> Bluetooth HCI Event - Read Remote Supported Features
>     Event Code: Read Remote Supported Features (0x0b)
>     Parameter Total Length: 11
>     Status: Success (0x00)
>     Connection Handle: 0x000b
>     LMP Features
>         .... ...1 =3D 3-slot packets: True
>         .... ..1. =3D 5-slot packets: True
>         .... .1.. =3D Encryption: True
>         .... 1... =3D Slot Offset: True
>         ...1 .... =3D Timing Accuracy: True
>         ..1. .... =3D Role Switch: True
>         .0.. .... =3D Hold Mode: False
>         1... .... =3D Sniff Mode: True
>         .... ...0 =3D Park Mode: False
>         .... ..1. =3D Power Control Requests: True
>         .... .0.. =3D Channel Quality Driven Data Rate: False
>         .... 1... =3D SCO Link: True
>         ...1 .... =3D HV2 packets: True
>         ..1. .... =3D HV3 packets: True
>         .0.. .... =3D u-law Log Synchronous Data: False
>         0... .... =3D A-law Log Synchronous Data: False
>         .... ...1 =3D CVSD Synchronous Data: True
>         .... ..0. =3D Paging Parameter Negotiation: False
>         .... .1.. =3D Power Control: True
>         .... 0... =3D Transparent Synchronous Data: False
>         .000 .... =3D Flow Control Lag: 0 (0 bytes)
>         1... .... =3D Broadband Encryption: True
>         .... ...0 =3D Reserved: False
>         .... ..1. =3D EDR ACL 2 Mbps Mode: True
>         .... .0.. =3D EDR ACL 3 Mbps Mode: False
>         .... 1... =3D Enhanced Inquiry Scan: True
>         ...1 .... =3D Interlaced Inquiry Scan: True
>         ..1. .... =3D Interlaced Page Scan: True
>         .1.. .... =3D RSSI with Inquiry Results: True
>         1... .... =3D EV3 Packets: True
>         .... ...0 =3D EV4 Packets: False
>         .... ..0. =3D EV5 Packets: False
>         .... .0.. =3D Reserved: False
>         .... 1... =3D AFH Capable Slave: True
>         ...1 .... =3D AFH Classification Slave: True
>         ..0. .... =3D BR/EDR Not Supported: False
>         .0.. .... =3D LE Supported Controller: False
>         1... .... =3D 3-slot EDR ACL packets: True
>         .... ...1 =3D 5-slot EDR ACL packets: True
>         .... ..0. =3D Sniff Subrating: False
>         .... .1.. =3D Pause Encryption: True
>         .... 1... =3D AFH Capable Master: True
>         ...1 .... =3D AFH Classification Master: True
>         ..0. .... =3D EDR eSCO 2 Mbps Mode: False
>         .0.. .... =3D EDR eSCO 3 Mbps Mode: False
>         0... .... =3D 3-slot EDR eSCO Packets: False
>         .... ...1 =3D Extended Inquiry Response: True
>         .... ..0. =3D Simultaneous LE and BR/EDR to Same Device Capable
> Controller: False
>         .... .0.. =3D Reserved: False
>         .... 1... =3D Secure Simple Pairing: True
>         ...1 .... =3D Encapsulated PDU: True
>         ..0. .... =3D Erroneous Data Reporting: False
>         .1.. .... =3D Non-flushable Packet Boundary Flag: True
>         0... .... =3D Reserved: False
>         .... ...1 =3D Link Supervision Timeout Changed Event: True
>         .... ..1. =3D Inquiry TX Power Level: True
>         .... .1.. =3D Enhanced Power Control: True
>         .000 0... =3D Reserved: False
>         1... .... =3D Extended Features: True
>     [Command in frame: 7]
>     [Pending in frame: 8]
>     [Pending-Response Delta: 1.006 ms]
>     [Command-Response Delta: 1.904 ms]
>
> 0000  04 0b 0b 00 0b 00 bf 3a 85 fa 98 1d 59 87         .......:....Y.
>
> Frame 10: 7 bytes on wire (56 bits), 7 bytes captured (56 bits)
>     Encapsulation type: Bluetooth H4 with linux header (99)
>     Arrival Time: Mar 17, 2017 12:17:04.561757000 ICT
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1489727824.561757000 seconds
>     [Time delta from previous captured frame: 0.000064000 seconds]
>     [Time delta from previous displayed frame: 0.000064000 seconds]
>     [Time since reference or first frame: 0.248742000 seconds]
>     Frame Number: 10
>     Frame Length: 7 bytes (56 bits)
>     Capture Length: 7 bytes (56 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     Point-to-Point Direction: Sent (0)
>     [Protocols in frame: bluetooth:hci_h4:bthci_cmd]
> Bluetooth
>     [Source: host]
>     [Destination: controller]
> Bluetooth HCI H4
>     [Direction: Sent (0x00)]
>     HCI Packet Type: HCI Command (0x01)
> Bluetooth HCI Command - Read Remote Extended Features
>     Command Opcode: Read Remote Extended Features (0x041c)
>         0000 01.. .... .... =3D Opcode Group Field: Link Control Commands=
 (0x01)
>         .... ..00 0001 1100 =3D Opcode Command Field: Read Remote
> Extended Features (0x01c)
>     Parameter Total Length: 3
>     Connection Handle: 0x000b
>     Page Number: 0
>     [Pending in frame: 11]
>     [Command-Pending Delta: 0.917 ms]
>     [Response in frame: 12]
>     [Command-Response Delta: 479.936 ms]
>
> 0000  01 1c 04 03 0b 00 00                              .......
>
> Frame 11: 7 bytes on wire (56 bits), 7 bytes captured (56 bits)
>     Encapsulation type: Bluetooth H4 with linux header (99)
>     Arrival Time: Mar 17, 2017 12:17:04.562674000 ICT
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1489727824.562674000 seconds
>     [Time delta from previous captured frame: 0.000917000 seconds]
>     [Time delta from previous displayed frame: 0.000917000 seconds]
>     [Time since reference or first frame: 0.249659000 seconds]
>     Frame Number: 11
>     Frame Length: 7 bytes (56 bits)
>     Capture Length: 7 bytes (56 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     Point-to-Point Direction: Received (1)
>     [Protocols in frame: bluetooth:hci_h4:bthci_evt]
> Bluetooth
>     [Source: controller]
>     [Destination: host]
> Bluetooth HCI H4
>     [Direction: Rcvd (0x01)]
>     HCI Packet Type: HCI Event (0x04)
> Bluetooth HCI Event - Command Status
>     Event Code: Command Status (0x0f)
>     Parameter Total Length: 4
>     Status: Pending (0x00)
>     Number of Allowed Command Packets: 1
>     Command Opcode: Read Remote Extended Features (0x041c)
>         0000 01.. .... .... =3D Opcode Group Field: Link Control Commands=
 (0x01)
>         .... ..00 0001 1100 =3D Opcode Command Field: Read Remote
> Extended Features (0x01c)
>     [Command in frame: 10]
>     [Response in frame: 12]
>     [Command-Pending Delta: 0.917 ms]
>     [Pending-Response Delta: 479.019 ms]
>
> 0000  04 0f 04 00 01 1c 04                              .......
>
> Frame 12: 16 bytes on wire (128 bits), 16 bytes captured (128 bits)
>     Encapsulation type: Bluetooth H4 with linux header (99)
>     Arrival Time: Mar 17, 2017 12:17:05.041693000 ICT
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1489727825.041693000 seconds
>     [Time delta from previous captured frame: 0.479019000 seconds]
>     [Time delta from previous displayed frame: 0.479019000 seconds]
>     [Time since reference or first frame: 0.728678000 seconds]
>     Frame Number: 12
>     Frame Length: 16 bytes (128 bits)
>     Capture Length: 16 bytes (128 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     Point-to-Point Direction: Received (1)
>     [Protocols in frame: bluetooth:hci_h4:bthci_evt]
> Bluetooth
>     [Source: controller]
>     [Destination: host]
> Bluetooth HCI H4
>     [Direction: Rcvd (0x01)]
>     HCI Packet Type: HCI Event (0x04)
> Bluetooth HCI Event - Read Remote Extended Features Complete
>     Event Code: Read Remote Extended Features Complete (0x23)
>     Parameter Total Length: 13
>     Status: Success (0x00)
>     Connection Handle: 0x000b
>     Page Number: 0
>     Max. Page Number: 1
>     LMP Features
>         .... ...1 =3D 3-slot packets: True
>         .... ..1. =3D 5-slot packets: True
>         .... .1.. =3D Encryption: True
>         .... 1... =3D Slot Offset: True
>         ...1 .... =3D Timing Accuracy: True
>         ..1. .... =3D Role Switch: True
>         .0.. .... =3D Hold Mode: False
>         1... .... =3D Sniff Mode: True
>         .... ...0 =3D Park Mode: False
>         .... ..1. =3D Power Control Requests: True
>         .... .0.. =3D Channel Quality Driven Data Rate: False
>         .... 1... =3D SCO Link: True
>         ...1 .... =3D HV2 packets: True
>         ..1. .... =3D HV3 packets: True
>         .0.. .... =3D u-law Log Synchronous Data: False
>         0... .... =3D A-law Log Synchronous Data: False
>         .... ...1 =3D CVSD Synchronous Data: True
>         .... ..0. =3D Paging Parameter Negotiation: False
>         .... .1.. =3D Power Control: True
>         .... 0... =3D Transparent Synchronous Data: False
>         .000 .... =3D Flow Control Lag: 0 (0 bytes)
>         1... .... =3D Broadband Encryption: True
>         .... ...0 =3D Reserved: False
>         .... ..1. =3D EDR ACL 2 Mbps Mode: True
>         .... .0.. =3D EDR ACL 3 Mbps Mode: False
>         .... 1... =3D Enhanced Inquiry Scan: True
>         ...1 .... =3D Interlaced Inquiry Scan: True
>         ..1. .... =3D Interlaced Page Scan: True
>         .1.. .... =3D RSSI with Inquiry Results: True
>         1... .... =3D EV3 Packets: True
>         .... ...0 =3D EV4 Packets: False
>         .... ..0. =3D EV5 Packets: False
>         .... .0.. =3D Reserved: False
>         .... 1... =3D AFH Capable Slave: True
>         ...1 .... =3D AFH Classification Slave: True
>         ..0. .... =3D BR/EDR Not Supported: False
>         .0.. .... =3D LE Supported Controller: False
>         1... .... =3D 3-slot EDR ACL packets: True
>         .... ...1 =3D 5-slot EDR ACL packets: True
>         .... ..0. =3D Sniff Subrating: False
>         .... .1.. =3D Pause Encryption: True
>         .... 1... =3D AFH Capable Master: True
>         ...1 .... =3D AFH Classification Master: True
>         ..0. .... =3D EDR eSCO 2 Mbps Mode: False
>         .0.. .... =3D EDR eSCO 3 Mbps Mode: False
>         0... .... =3D 3-slot EDR eSCO Packets: False
>         .... ...1 =3D Extended Inquiry Response: True
>         .... ..0. =3D Simultaneous LE and BR/EDR to Same Device Capable
> Controller: False
>         .... .0.. =3D Reserved: False
>         .... 1... =3D Secure Simple Pairing: True
>         ...1 .... =3D Encapsulated PDU: True
>         ..0. .... =3D Erroneous Data Reporting: False
>         .1.. .... =3D Non-flushable Packet Boundary Flag: True
>         0... .... =3D Reserved: False
>         .... ...1 =3D Link Supervision Timeout Changed Event: True
>         .... ..1. =3D Inquiry TX Power Level: True
>         .... .1.. =3D Enhanced Power Control: True
>         .000 0... =3D Reserved: False
>         1... .... =3D Extended Features: True
>     [Command in frame: 10]
>     [Pending in frame: 11]
>     [Pending-Response Delta: 479.019 ms]
>     [Command-Response Delta: 479.936 ms]
>
> 0000  04 23 0d 00 0b 00 00 01 bf 3a 85 fa 98 1d 59 87   .#.......:....Y.
>
> Frame 13: 7 bytes on wire (56 bits), 7 bytes captured (56 bits)
>     Encapsulation type: Bluetooth H4 with linux header (99)
>     Arrival Time: Mar 17, 2017 12:17:05.042052000 ICT
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1489727825.042052000 seconds
>     [Time delta from previous captured frame: 0.000359000 seconds]
>     [Time delta from previous displayed frame: 0.000359000 seconds]
>     [Time since reference or first frame: 0.729037000 seconds]
>     Frame Number: 13
>     Frame Length: 7 bytes (56 bits)
>     Capture Length: 7 bytes (56 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     Point-to-Point Direction: Sent (0)
>     [Protocols in frame: bluetooth:hci_h4:bthci_cmd]
> Bluetooth
>     [Source: host]
>     [Destination: controller]
> Bluetooth HCI H4
>     [Direction: Sent (0x00)]
>     HCI Packet Type: HCI Command (0x01)
> Bluetooth HCI Command - Read Remote Extended Features
>     Command Opcode: Read Remote Extended Features (0x041c)
>         0000 01.. .... .... =3D Opcode Group Field: Link Control Commands=
 (0x01)
>         .... ..00 0001 1100 =3D Opcode Command Field: Read Remote
> Extended Features (0x01c)
>     Parameter Total Length: 3
>     Connection Handle: 0x000b
>     Page Number: 1
>     [Pending in frame: 14]
>     [Command-Pending Delta: 1.626 ms]
>     [Response in frame: 15]
>     [Command-Response Delta: 499.631 ms]
>
> 0000  01 1c 04 03 0b 00 01                              .......
>
> Frame 14: 7 bytes on wire (56 bits), 7 bytes captured (56 bits)
>     Encapsulation type: Bluetooth H4 with linux header (99)
>     Arrival Time: Mar 17, 2017 12:17:05.043678000 ICT
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1489727825.043678000 seconds
>     [Time delta from previous captured frame: 0.001626000 seconds]
>     [Time delta from previous displayed frame: 0.001626000 seconds]
>     [Time since reference or first frame: 0.730663000 seconds]
>     Frame Number: 14
>     Frame Length: 7 bytes (56 bits)
>     Capture Length: 7 bytes (56 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     Point-to-Point Direction: Received (1)
>     [Protocols in frame: bluetooth:hci_h4:bthci_evt]
> Bluetooth
>     [Source: controller]
>     [Destination: host]
> Bluetooth HCI H4
>     [Direction: Rcvd (0x01)]
>     HCI Packet Type: HCI Event (0x04)
> Bluetooth HCI Event - Command Status
>     Event Code: Command Status (0x0f)
>     Parameter Total Length: 4
>     Status: Pending (0x00)
>     Number of Allowed Command Packets: 1
>     Command Opcode: Read Remote Extended Features (0x041c)
>         0000 01.. .... .... =3D Opcode Group Field: Link Control Commands=
 (0x01)
>         .... ..00 0001 1100 =3D Opcode Command Field: Read Remote
> Extended Features (0x01c)
>     [Command in frame: 13]
>     [Response in frame: 15]
>     [Command-Pending Delta: 1.626 ms]
>     [Pending-Response Delta: 498.005 ms]
>
> 0000  04 0f 04 00 01 1c 04                              .......
>
> Frame 15: 16 bytes on wire (128 bits), 16 bytes captured (128 bits)
>     Encapsulation type: Bluetooth H4 with linux header (99)
>     Arrival Time: Mar 17, 2017 12:17:05.541683000 ICT
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1489727825.541683000 seconds
>     [Time delta from previous captured frame: 0.498005000 seconds]
>     [Time delta from previous displayed frame: 0.498005000 seconds]
>     [Time since reference or first frame: 1.228668000 seconds]
>     Frame Number: 15
>     Frame Length: 16 bytes (128 bits)
>     Capture Length: 16 bytes (128 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     Point-to-Point Direction: Received (1)
>     [Protocols in frame: bluetooth:hci_h4:bthci_evt]
> Bluetooth
>     [Source: controller]
>     [Destination: host]
> Bluetooth HCI H4
>     [Direction: Rcvd (0x01)]
>     HCI Packet Type: HCI Event (0x04)
> Bluetooth HCI Event - Read Remote Extended Features Complete
>     Event Code: Read Remote Extended Features Complete (0x23)
>     Parameter Total Length: 13
>     Status: Success (0x00)
>     Connection Handle: 0x000b
>     Page Number: 1
>     Max. Page Number: 1
>     LMP Features
>         .... ...1 =3D Secure Simple Pairing Host: True
>         .... ..0. =3D LE Supported Host: False
>         .... .0.. =3D Simultaneous LE and BR/EDR to Same Device Capable
> Host: False
>         0000 0... =3D Reserved: 0x00
>         Reserved: 00000000000000
>     [Command in frame: 13]
>     [Pending in frame: 14]
>     [Pending-Response Delta: 498.005 ms]
>     [Command-Response Delta: 499.631 ms]
>
> 0000  04 23 0d 00 0b 00 01 01 01 00 00 00 00 00 00 00   .#..............
>
> Frame 16: 6 bytes on wire (48 bits), 6 bytes captured (48 bits)
>     Encapsulation type: Bluetooth H4 with linux header (99)
>     Arrival Time: Mar 17, 2017 12:17:50.849633000 ICT
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1489727870.849633000 seconds
>     [Time delta from previous captured frame: 45.307950000 seconds]
>     [Time delta from previous displayed frame: 45.307950000 seconds]
>     [Time since reference or first frame: 46.536618000 seconds]
>     Frame Number: 16
>     Frame Length: 6 bytes (48 bits)
>     Capture Length: 6 bytes (48 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     Point-to-Point Direction: Sent (0)
>     [Protocols in frame: bluetooth:hci_h4:bthci_cmd]
> Bluetooth
>     [Source: host]
>     [Destination: controller]
> Bluetooth HCI H4
>     [Direction: Sent (0x00)]
>     HCI Packet Type: HCI Command (0x01)
> Bluetooth HCI Command - Exit Sniff Mode
>     Command Opcode: Exit Sniff Mode (0x0804)
>         0000 10.. .... .... =3D Opcode Group Field: Link Policy Commands =
(0x02)
>         .... ..00 0000 0100 =3D Opcode Command Field: Exit Sniff Mode (0x=
004)
>     Parameter Total Length: 2
>     Connection Handle: 0x000b
>     [Pending in frame: 17]
>     [Command-Pending Delta: 1.093 ms]
>     [Response in frame: 19]
>     [Command-Response Delta: 198.102 ms]
>
> 0000  01 04 08 02 0b 00                                 ......
>
> Frame 17: 7 bytes on wire (56 bits), 7 bytes captured (56 bits)
>     Encapsulation type: Bluetooth H4 with linux header (99)
>     Arrival Time: Mar 17, 2017 12:17:50.850726000 ICT
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1489727870.850726000 seconds
>     [Time delta from previous captured frame: 0.001093000 seconds]
>     [Time delta from previous displayed frame: 0.001093000 seconds]
>     [Time since reference or first frame: 46.537711000 seconds]
>     Frame Number: 17
>     Frame Length: 7 bytes (56 bits)
>     Capture Length: 7 bytes (56 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     Point-to-Point Direction: Received (1)
>     [Protocols in frame: bluetooth:hci_h4:bthci_evt]
> Bluetooth
>     [Source: controller]
>     [Destination: host]
> Bluetooth HCI H4
>     [Direction: Rcvd (0x01)]
>     HCI Packet Type: HCI Event (0x04)
> Bluetooth HCI Event - Command Status
>     Event Code: Command Status (0x0f)
>     Parameter Total Length: 4
>     Status: Pending (0x00)
>     Number of Allowed Command Packets: 1
>     Command Opcode: Exit Sniff Mode (0x0804)
>         0000 10.. .... .... =3D Opcode Group Field: Link Policy Commands =
(0x02)
>         .... ..00 0000 0100 =3D Opcode Command Field: Exit Sniff Mode (0x=
004)
>     [Command in frame: 16]
>     [Response in frame: 19]
>     [Command-Pending Delta: 1.093 ms]
>     [Pending-Response Delta: 197.009 ms]
>
> 0000  04 0f 04 00 01 04 08                              .......
>
> Frame 18: 6 bytes on wire (48 bits), 6 bytes captured (48 bits)
>     Encapsulation type: Bluetooth H4 with linux header (99)
>     Arrival Time: Mar 17, 2017 12:17:51.046696000 ICT
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1489727871.046696000 seconds
>     [Time delta from previous captured frame: 0.195970000 seconds]
>     [Time delta from previous displayed frame: 0.195970000 seconds]
>     [Time since reference or first frame: 46.733681000 seconds]
>     Frame Number: 18
>     Frame Length: 6 bytes (48 bits)
>     Capture Length: 6 bytes (48 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     Point-to-Point Direction: Received (1)
>     [Protocols in frame: bluetooth:hci_h4:bthci_evt]
> Bluetooth
>     [Source: controller]
>     [Destination: host]
> Bluetooth HCI H4
>     [Direction: Rcvd (0x01)]
>     HCI Packet Type: HCI Event (0x04)
> Bluetooth HCI Event - Max Slots Change
>     Event Code: Max Slots Change (0x1b)
>     Parameter Total Length: 3
>     Connection Handle: 0x000b
>     Maximum Number of Slots: 5
>
> 0000  04 1b 03 0b 00 05                                 ......
>
> Frame 19: 9 bytes on wire (72 bits), 9 bytes captured (72 bits)
>     Encapsulation type: Bluetooth H4 with linux header (99)
>     Arrival Time: Mar 17, 2017 12:17:51.047735000 ICT
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1489727871.047735000 seconds
>     [Time delta from previous captured frame: 0.001039000 seconds]
>     [Time delta from previous displayed frame: 0.001039000 seconds]
>     [Time since reference or first frame: 46.734720000 seconds]
>     Frame Number: 19
>     Frame Length: 9 bytes (72 bits)
>     Capture Length: 9 bytes (72 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     Point-to-Point Direction: Received (1)
>     [Protocols in frame: bluetooth:hci_h4:bthci_evt]
> Bluetooth
>     [Source: controller]
>     [Destination: host]
> Bluetooth HCI H4
>     [Direction: Rcvd (0x01)]
>     HCI Packet Type: HCI Event (0x04)
> Bluetooth HCI Event - Mode Change
>     Event Code: Mode Change (0x14)
>     Parameter Total Length: 6
>     Status: Success (0x00)
>     Connection Handle: 0x000b
>     Current Mode: Active Mode (0x00)
>     Interval: 0 Baseband slots (0.000000 msec)
>     [Command in frame: 16]
>     [Pending in frame: 17]
>     [Pending-Response Delta: 197.009 ms]
>     [Command-Response Delta: 198.102 ms]
>
> 0000  04 14 06 00 0b 00 00 00 00                        .........
>
> Frame 20: 21 bytes on wire (168 bits), 21 bytes captured (168 bits)
>     Encapsulation type: Bluetooth H4 with linux header (99)
>     Arrival Time: Mar 17, 2017 12:17:51.047750000 ICT
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1489727871.047750000 seconds
>     [Time delta from previous captured frame: 0.000015000 seconds]
>     [Time delta from previous displayed frame: 0.000015000 seconds]
>     [Time since reference or first frame: 46.734735000 seconds]
>     Frame Number: 20
>     Frame Length: 21 bytes (168 bits)
>     Capture Length: 21 bytes (168 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     Point-to-Point Direction: Sent (0)
>     [Protocols in frame: bluetooth:hci_h4:bthci_cmd]
> Bluetooth
>     [Source: host]
>     [Destination: controller]
> Bluetooth HCI H4
>     [Direction: Sent (0x00)]
>     HCI Packet Type: HCI Command (0x01)
> Bluetooth HCI Command - Setup Synchronous Connection
>     Command Opcode: Setup Synchronous Connection (0x0428)
>         0000 01.. .... .... =3D Opcode Group Field: Link Control Commands=
 (0x01)
>         .... ..00 0010 1000 =3D Opcode Command Field: Setup Synchronous
> Connection (0x028)
>     Parameter Total Length: 17
>     Connection Handle: 0x000b
>     Tx Bandwidth (bytes/s): 8000
>     Rx Bandwidth (bytes/s): 8000
>     Max. Latency (ms): 10
>     0000 00.. .... .... =3D Unused bits: 0x00
>     .... ..00 .... .... =3D Input Coding: Linear (0)
>     .... .... 01.. .... =3D Input Data Format: 2's complement (1)
>     .... .... ..1. .... =3D Input Sample Size: 16 bit (only for Linear PC=
M) (1)
>     .... .... ...0 00.. =3D Linear PCM Bit Position: 0
>     .... .... .... ..00 =3D Air Coding Format: CVSD (0)
>     Retransmission Effort: At least 1 retransmission, optimize for
> power consumption (1)
>     .... .... .... ...0 =3D Packet Type HV1: false (0)
>     .... .... .... ..0. =3D Packet Type HV2: false (0)
>     .... .... .... .0.. =3D Packet Type HV3: false (0)
>     .... .... .... 0... =3D Packet Type EV3: false (1)
>     .... .... ...0 .... =3D Packet Type EV4: false (0)
>     .... .... ..0. .... =3D Packet Type EV5: false (0)
>     .... .... .0.. .... =3D Packet Type 2-EV3: false (0)
>     .... .... 1... .... =3D Packet Type 3-EV3: true (1)
>     .... ...1 .... .... =3D Packet Type 2-EV5: true (1)
>     .... ..1. .... .... =3D Packet Type 3-EV5: true (1)
>     [Response in frame: 21]
>     [Command-Response Delta: 0.989 ms]
>
> 0000  01 28 04 11 0b 00 40 1f 00 00 40 1f 00 00 0a 00   .(....@...@.....
> 0010  60 00 01 80 03                                    `....
>
> Frame 21: 7 bytes on wire (56 bits), 7 bytes captured (56 bits)
>     Encapsulation type: Bluetooth H4 with linux header (99)
>     Arrival Time: Mar 17, 2017 12:17:51.048739000 ICT
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1489727871.048739000 seconds
>     [Time delta from previous captured frame: 0.000989000 seconds]
>     [Time delta from previous displayed frame: 0.000989000 seconds]
>     [Time since reference or first frame: 46.735724000 seconds]
>     Frame Number: 21
>     Frame Length: 7 bytes (56 bits)
>     Capture Length: 7 bytes (56 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     Point-to-Point Direction: Received (1)
>     [Protocols in frame: bluetooth:hci_h4:bthci_evt]
> Bluetooth
>     [Source: controller]
>     [Destination: host]
> Bluetooth HCI H4
>     [Direction: Rcvd (0x01)]
>     HCI Packet Type: HCI Event (0x04)
> Bluetooth HCI Event - Command Status
>     Event Code: Command Status (0x0f)
>     Parameter Total Length: 4
>     Status: Unsupported Remote/LMP Feature (0x1a)
>     Number of Allowed Command Packets: 1
>     Command Opcode: Setup Synchronous Connection (0x0428)
>         0000 01.. .... .... =3D Opcode Group Field: Link Control Commands=
 (0x01)
>         .... ..00 0010 1000 =3D Opcode Command Field: Setup Synchronous
> Connection (0x028)
>     [Command in frame: 20]
>     [Command-Response Delta: 0.989 ms]
>
> 0000  04 0f 04 1a 01 28 04                              .....(.
>
> 7.1.26 Setup Synchronous Connection Command
> Command OCF Command Parameters
> HCI_Setup_Synchronous_
> Connection 0x0028 Connection_Handle
> Transmit_Bandwidth
> Receive_Bandwidth
> Max_Latency
> Voice_Setting
> Retransmission_Effort
> Packet Type
> Return Parameters
> Description:
> The HCI Setup Synchronous Connection command adds a new or modifies an
> existing synchronous logical transport (SCO or eSCO) on a physical link
> depending on the Connection_Handle parameter specified. If the
> Connection_Handle refers to an ACL link a new synchronous logical transpo=
rt
> will be added. If the Connection_Handle refers to an already existing syn=
chro-
> nous logical transport (eSCO only) this link will be modified.The paramet=
ers
> are specified per connection. This synchronous connection can be used to
> transfer synchronous voice at 64kbps or transparent synchronous data.
> When used to setup a new synchronous logical transport, the Connection_Ha=
ndle
> parameter shall specify an ACL connection with which the new synchronous =
con-
> nection will be associated. The other parameters relate to the
> negotiation of the
> link, and may be reconfigured during the lifetime of the link. The transm=
it and
> receive bandwidth specify how much bandwidth shall be available for trans=
mitting
> and for receiving data. While in many cases the receive and transmit band=
width
> parameters may be equal, they may be different. The latency specifies an =
upper
> limit to the time in milliseconds between the eSCO (or SCO) instants,
> plus the size
> of the retransmission window, plus the length of the reserved synchronous=
 slots
> for this logical transport. The content format specifies the settings
> for voice or
> transparent data on this connection. The retransmission effort
> specifies the extra
> resources that are allocated to this connection if a packet may need
> to be retrans-
> mitted. The Retransmission_Effort parameter shall be set to indicate
> the required
> behavior, or to don't care.
> When used to modify an existing synchronous logical transport, the
> Transmit_Bandwidth, Receive_Bandwidth and Voice_Settings shall be set to =
the
> same values as were used during the initial setup. The Packet_Type,
> Retransmission_Effort and Max_Latency parameters may be modified.
> The Packet_Type field is a bitmap specifying which packet types the LM sh=
all
> accept in the negotiation of the link parameters. Multiple packet
> types are spec-
> ified by bitwise OR of the packet type codes in the table. At least one p=
acket
> type must be specified for each negotiation. It is recommended to enable =
as
> many packet types as possible. Note that it is allowed to enable packet t=
ypes
> that are not supported by the local device.
> HCI Commands and Events
> 4 November 2004
> 437BLUETOOTH SPECIFICATION Version 2.0 + EDR [vol 3]
> page 438 of 814
> Host Controller Interface Functional Specification
> A connection handle for the new synchronous connection will be returned i=
n
> the synchronous connection complete event.
> Note: The link manager may choose any combination of packet types, timing=
,
> and retransmission window sizes that satisfy the parameters given. This m=
ay
> be achieved by using more frequent transmissions of smaller packets. The =
link
> manager may choose to set up either a SCO or an eSCO connection, if the
> parameters allow, using the corresponding LMP sequences.
> Note: To modify a SCO connection, use the Change Connection Packet Type
> command.
> Note: If the lower layers cannot achieve the exact transmit and receive b=
and-
> width requested subject to the other parameters, then the link shall
> be rejected.
> A synchronous connection may only be created when an ACL connection
> already exists and when it is not in park state.
> Command Parameters:
> Connection_Handle:
> 2 octets (12 bits meaningful)
> Value Parameter Description
> 0xXXXX Connection Handle for the ACL connection being used to create a sy=
n-
> chronous Connection or for the existing Connection that shall be modified=
.
> Range: 0x0000-0x0EFF (0x0F00 - 0x0FFF Reserved for future use)
> Transmit_Bandwidth:
> 4 octets
> Value Parameter Description
> 0xXXXXXXXX Transmit bandwidth in octets per second.
> Receive_Bandwidth:
> 4 octets
> Value Parameter Description
> 0xXXXXXXXX Receive bandwidth in octets per second.
> 438
> 4 November 2004
> HCI Commands and EventsBLUETOOTH SPECIFICATION Version 2.0 + EDR [vol 3]
> page 439 of 814
> Host Controller Interface Functional Specification
> Max_Latency:
> 2 octets
> Value Parameter Description
> 0x0000-
> 0x0003 Reserved
> 0x0004-
> 0xFFFE This is a value in milliseconds representing the upper limit of
> the sum of
> the synchronous interval, the size of the eSCO window. (See Figure 8.7 in
> the Baseband specification)
> 0xFFFF Don't care.
> Voice_Setting:
> Value
> 2 octets (10 bits meaningful)
> Parameter Description
> See Section 6.12 on page 387.
> Retransmission_Effort:
> 1 octet
> Value Parameter Description
> 0x00 No retransmissions
> 0x01 At least one retransmission, optimize for power consumption.
> 0x02 At least one retransmission, optimize for link quality
> 0xFF Don=E2=80=99t care
> 0x03 =E2=80=93 0xFE Reserved
> HCI Commands and Events
> 4 November 2004
> 439BLUETOOTH SPECIFICATION Version 2.0 + EDR [vol 3]
> page 440 of 814
> Host Controller Interface Functional Specification
> Packet_Type:
> 2 octets
> Value Parameter Description
> 0x0001 HV1 may be used.
> 0x0002 HV2 may be used.
> 0x0004 HV3 may be used.
> 0x0008 EV3 may be used.
> 0x0010 EV4 may be used.
> 0x0020 EV5 may be used.
> 0x0040 2-EV3 may not be used.
> 0x0080 3-EV3 may not be used.
> 0x0100 2-EV5 may not be used.
> 0x0200 3-EV5 may not be used.
> 0x0400 Reserved for future use
> 0x0800 Reserved for future use
> 0x1000 Reserved for future use
> 0x2000 Reserved for future use
> 0x4000 Reserved for future use
> 0x8000 Reserved for future use
> Return Parameters:
> None
> Event(s) generated (unless masked away)
> When the Controller receives the Setup_Synchronous_Connection command,
> it sends the Command Status event to the Host. In addition, when the LM
> determines the connection is established, the local Controller will send =
a Syn-
> chronous Connection Complete event to the local Host, and the remote Con-
> troller will send a Synchronous Connection Complete event or a Connection
> Complete event to the remote Host. The synchronous Connection Complete
> event contains the Connection Handle if this command is successful.
> If this command is used to change the parameters of an existing eSCO link=
, the
> Synchronous Connection Changed Event is sent to both hosts. In this case =
no
> Connection Setup Complete Event or Connection Request Event will be sent =
to
> either host. This command cannot be used to change the parameters of an
> SCO link.
> 440
> 4 November 2004
> HCI Commands and EventsBLUETOOTH SPECIFICATION Version 2.0 + EDR [vol 3]
> page 441 of 814
> Host Controller Interface Functional Specification
> Note: no Command Complete event will be sent by the Controller to indicat=
e
> that this command has been completed. Instead, the synchronous Connection
> Complete event will indicate that this command has been completed.
