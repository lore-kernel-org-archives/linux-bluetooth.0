Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Luke McKee <hojuruku@gmail.com>, linux-bluetooth@vger.kernel.org
Cc: georg@chini.tk, kubax.t.pawlak@intel.com, madingzhi@163.com,
        rimi@szaodasen.com, conwise@conwise.com.tw
Subject: Re: Lower Level Host Stack bug - 0x1a (remote host feature) using EDR+SCO to non-capable Taiwanese/Chinese devices
In-Reply-To: <CAENjB=J_Qf_6hzOLXFMfrSrwVC6tp+dJhS+h=m2-HHgbQxFHag@mail.gmail.com>
References: <CAENjB=J_Qf_6hzOLXFMfrSrwVC6tp+dJhS+h=m2-HHgbQxFHag@mail.gmail.com>
Date: Thu, 16 Mar 2017 18:37:02 -0700
Message-ID: <87shmcpttt.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luke,

Luke McKee <hojuruku@gmail.com> writes:

> On 16 March 2017 at 23:45, Luke McKee <hojuruku@gmail.com> wrote:
>>
>> This bug at first sight appears to be a regression of this bug:
>> https://lists.freedesktop.org/archives/pulseaudio-discuss/2015-March/023305.html
>> reported by Georg Chini that's well known of by many pulseaudio users
>> but I believe it's a new one, brought about by incompatibility of many
>> Taiwanese Bluetooth stacks that support EDR only for A2DP / EDR
>> connection-less streams.   Many thanks for to Georg for support given
>> on #pulseaudio given to me (hojuruku)
>>
>> The feedback from hcidump is near identical to the previous bug,
>> because but after even applying a patch to hci_event.c from George
>> (included below) however it didn't attempt a reconnect, so the cause
>> may be different, but the symptoms are the same.
>>
>> The HSP or HFP protocols don't work due to the reliance on SCO with
>> this device and all other TW based hardware I have laying around here
>> (headphones / speakers)
>> https://www.mikrocontroller.net/attachment/193445/CW6626-Datasheet-DS6626V1.1.pdf
>> FYI this is the speaker:
>> http://www.szaodasen.com/en/productmore.asp?id=119&pid=6&i=119 It also
>> has a rfcomm profile and a proprietary app to remote control,
>> configure it set the clock etc. I might ask how to sniff rfcomm
>> connections later ;)
>>
>> Unlike the previous issues this bluetooth speaker supports eSCO, but
>> not eSCO with a EDR packet type. This is affecting 4.9.13
>
> I have confirmed what's going on. bluez isn't honoring the SDP where
> the device claims it doesn't support EDR packet types for SCO (see
> previous email http://marc.info/?l=linux-bluetooth&m=148968308621534&w=2)
>
> I set up android-x86.org under qemu to use the same bluetooth adapter
> and did a snoop and analysed in wireshark. If the controller supports
> EDR, bluez will try and ONLY use EDR for SCO without checking if the
> remote device (SDP) supports it.
>
> This is why SCO doesn't work - it's a linux kernel issue to do with
> sco.c as suggested in a relevant bug report
> (https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=788466)
> If esco exists bluez is assuming it supports esco over EDR - which
> this device doesn't support. That's the new bug.
> Legacy non EDR SCO/esco would use these packet types?
> http://www.dziwior.org/Bluetooth/SCO.html HV1 HV2 HV3
>

Your analysis was very good, but looks like it missed an important
detail: the error reported is in the Command *Status* event not in the
Command *Complete* event. The Command Status event is used by the *local*
controller to report errors. So it probably means that it is your local
controller that doesn't support that set of parameters, i.e. it is a
misbehaving controller.

One possible workaround is to do something like this:

$ echo 1 > /sys/module/bluetooth/parameters/disable_esco

to disable eSCO support locally.

Now I am curious, what controller is that?

>
> Command Opcode: Setup Synchronous Connection (0x0428)
>
> No.     Time           Source                Destination
> Protocol Length Info
>     299 70.114149      controller            host
> HCI_EVT  7      Sent Number of Completed Packets
>
> Frame 299: 7 bytes on wire (56 bits), 7 bytes captured (56 bits)
>     Encapsulation type: Bluetooth without transport layer (102)
>     Arrival Time: Mar 17, 2017 03:58:40.549821000 ICT
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1489697920.549821000 seconds
>     [Time delta from previous captured frame: 0.135330000 seconds]
>     [Time delta from previous displayed frame: 0.135330000 seconds]
>     [Time since reference or first frame: 70.114149000 seconds]
>     Frame Number: 299
>     Frame Length: 7 bytes (56 bits)
>     Capture Length: 7 bytes (56 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     Point-to-Point Direction: Sent (0)
>     [Protocols in frame: bluetooth:hci_h1:bthci_evt]
> Bluetooth
>     [Source: controller]
>     [Destination: host]
> Bluetooth HCI H1 Sent HCI Event
>     [Direction: Sent (0)]
> Bluetooth HCI Event - Number of Completed Packets
>     Event Code: Number of Completed Packets (0x13)
>     Parameter Total Length: 5
>     Number of Connection Handles: 1
>     Connection Handle: 0x000b
>     Number of Completed Packets: 1
>
> No.     Time           Source                Destination
> Protocol Length Info
>     300 70.735628      host                  controller
> HCI_CMD  20     Rcvd Setup Synchronous Connection
>
> Frame 300: 20 bytes on wire (160 bits), 20 bytes captured (160 bits)
>     Encapsulation type: Bluetooth without transport layer (102)
>     Arrival Time: Mar 17, 2017 03:58:41.171300000 ICT
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1489697921.171300000 seconds
>     [Time delta from previous captured frame: 0.621479000 seconds]
>     [Time delta from previous displayed frame: 0.621479000 seconds]
>     [Time since reference or first frame: 70.735628000 seconds]
>     Frame Number: 300
>     Frame Length: 20 bytes (160 bits)
>     Capture Length: 20 bytes (160 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     Point-to-Point Direction: Received (1)
>     [Protocols in frame: bluetooth:hci_h1:bthci_cmd]
> Bluetooth
>     [Source: host]
>     [Destination: controller]
> Bluetooth HCI H1 Rcvd HCI Command
>     [Direction: Rcvd (1)]
> Bluetooth HCI Command - Setup Synchronous Connection
>     Command Opcode: Setup Synchronous Connection (0x0428)
>         0000 01.. .... .... = Opcode Group Field: Link Control Commands (0x01)
>         .... ..00 0010 1000 = Opcode Command Field: Setup Synchronous
> Connection (0x028)
>     Parameter Total Length: 17
>     Connection Handle: 0x000b
>     Tx Bandwidth (bytes/s): 8000
>     Rx Bandwidth (bytes/s): 8000
>     Max. Latency (ms): 10
>     0000 00.. .... .... = Unused bits: 0x00
>     .... ..00 .... .... = Input Coding: Linear (0)
>     .... .... 01.. .... = Input Data Format: 2's complement (1)
>     .... .... ..1. .... = Input Sample Size: 16 bit (only for Linear PCM) (1)
>     .... .... ...0 00.. = Linear PCM Bit Position: 0
>     .... .... .... ..00 = Air Coding Format: CVSD (0)
>     Retransmission Effort: At least 1 retransmission, optimize for
> power consumption (1)
>     .... .... .... ...0 = Packet Type HV1: false (0)
>     .... .... .... ..0. = Packet Type HV2: false (0)
>     .... .... .... .0.. = Packet Type HV3: false (0)
>     .... .... .... 0... = Packet Type EV3: false (0)
>     .... .... ...0 .... = Packet Type EV4: false (0)
>     .... .... ..0. .... = Packet Type EV5: false (0)
>     .... .... .0.. .... = Packet Type 2-EV3: false (0)
>     .... .... 1... .... = Packet Type 3-EV3: true (1)
>     .... ...1 .... .... = Packet Type 2-EV5: true (1)
>     .... ..1. .... .... = Packet Type 3-EV5: true (1)
>     [Response in frame: 301]
>     [Command-Response Delta: 2.746 ms]
>
> No.     Time           Source                Destination
> Protocol Length Info
>     301 70.738374      controller            host
> HCI_EVT  6      Sent Command Status (Setup Synchronous Connection)
>
> Frame 301: 6 bytes on wire (48 bits), 6 bytes captured (48 bits)
>     Encapsulation type: Bluetooth without transport layer (102)
>     Arrival Time: Mar 17, 2017 03:58:41.174046000 ICT
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1489697921.174046000 seconds
>     [Time delta from previous captured frame: 0.002746000 seconds]
>     [Time delta from previous displayed frame: 0.002746000 seconds]
>     [Time since reference or first frame: 70.738374000 seconds]
>     Frame Number: 301
>     Frame Length: 6 bytes (48 bits)
>     Capture Length: 6 bytes (48 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     Point-to-Point Direction: Sent (0)
>     [Protocols in frame: bluetooth:hci_h1:bthci_evt]
> Bluetooth
>     [Source: controller]
>     [Destination: host]
> Bluetooth HCI H1 Sent HCI Event
>     [Direction: Sent (0)]
> Bluetooth HCI Event - Command Status
>     Event Code: Command Status (0x0f)
>     Parameter Total Length: 4
>     Status: Unsupported Remote/LMP Feature (0x1a)
>     Number of Allowed Command Packets: 1
>     Command Opcode: Setup Synchronous Connection (0x0428)
>         0000 01.. .... .... = Opcode Group Field: Link Control Commands (0x01)
>         .... ..00 0010 1000 = Opcode Command Field: Setup Synchronous
> Connection (0x028)
>     [Command in frame: 300]
>     [Command-Response Delta: 2.746 ms]
>
> No.     Time           Source                Destination
> Protocol Length Info
>     302 70.741203      30:21:57:95:5a:3a (JY-17) ChengHon_00:00:2e
> (Standard PC (i440FX + PIIX, 1996)) L2CAP    16     Rcvd Disconnection
> Request (SCID: 0x0040, DCID: 0x0040, PSM: 0x0001, Service: SDP)
>
> Frame 302: 16 bytes on wire (128 bits), 16 bytes captured (128 bits)
>     Encapsulation type: Bluetooth without transport layer (102)
>     Arrival Time: Mar 17, 2017 03:58:41.176875000 ICT
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1489697921.176875000 seconds
>     [Time delta from previous captured frame: 0.002829000 seconds]
>     [Time delta from previous displayed frame: 0.002829000 seconds]
>     [Time since reference or first frame: 70.741203000 seconds]
>     Frame Number: 302
>     Frame Length: 16 bytes (128 bits)
>     Capture Length: 16 bytes (128 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     Point-to-Point Direction: Received (1)
>     [Protocols in frame: bluetooth:hci_h1:bthci_acl:btl2cap]
> Bluetooth
>     [Source: 30:21:57:95:5a:3a (30:21:57:95:5a:3a)]
>     [Destination: ChengHon_00:00:2e (00:19:86:00:00:2e)]
> Bluetooth HCI H1 Rcvd ACL Data
>     [Direction: Rcvd (1)]
> Bluetooth HCI ACL Packet
>     .... 0000 0000 1011 = Connection Handle: 0x00b
>     ..00 .... .... .... = PB Flag: First Non-automatically Flushable Packet (0)
>     00.. .... .... .... = BC Flag: Point-To-Point (0)
>     Data Total Length: 12
>     [Connect in frame: 239]
>     [Source BD_ADDR: 30:21:57:95:5a:3a (30:21:57:95:5a:3a)]
>     [Source Device Name: JY-17]
>     [Source Role: Slave (2)]
>     [Destination BD_ADDR: ChengHon_00:00:2e (00:19:86:00:00:2e)]
>     [Destination Device Name: Standard PC (i440FX + PIIX, 1996)]
>     [Destination Role: Master (1)]
>     [Last Role Change in Frame: 238]
>     [Current Mode: Active Mode (0)]
>     [Last Mode Change in Frame: 239]
> Bluetooth L2CAP Protocol
>     Length: 8
>     CID: L2CAP Signaling Channel (0x0001)
>     Command: Disconnection Request
>         Command Code: Disconnection Request (0x06)
>         Command Identifier: 0x06
>         Command Length: 4
>         Destination CID: Dynamically Allocated Channel (0x0040)
>         Source CID: Dynamically Allocated Channel (0x0040)
>     [PSM: SDP (0x0001)]
>     [Connect in frame: 253]
>
> No.     Time           Source                Destination
> Protocol Length Info
>     303 70.820773      ChengHon_00:00:2e (Standard PC (i440FX + PIIX,
> 1996)) 30:21:57:95:5a:3a (JY-17) L2CAP    16     Sent Disconnection
> Response (SCID: 0x0040, DCID: 0x0040, PSM: 0x0001, Service: SDP)
>
> Frame 303: 16 bytes on wire (128 bits), 16 bytes captured (128 bits)
>     Encapsulation type: Bluetooth without transport layer (102)
>     Arrival Time: Mar 17, 2017 03:58:41.256445000 ICT
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1489697921.256445000 seconds
>     [Time delta from previous captured frame: 0.079570000 seconds]
>     [Time delta from previous displayed frame: 0.079570000 seconds]
>     [Time since reference or first frame: 70.820773000 seconds]
>     Frame Number: 303
>     Frame Length: 16 bytes (128 bits)
>     Capture Length: 16 bytes (128 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     Point-to-Point Direction: Sent (0)
>     [Protocols in frame: bluetooth:hci_h1:bthci_acl:btl2cap]
> Bluetooth
>     [Source: ChengHon_00:00:2e (00:19:86:00:00:2e)]
>     [Destination: 30:21:57:95:5a:3a (30:21:57:95:5a:3a)]
> Bluetooth HCI H1 Sent ACL Data
>     [Direction: Sent (0)]
> Bluetooth HCI ACL Packet
>     .... 0000 0000 1011 = Connection Handle: 0x00b
>     ..10 .... .... .... = PB Flag: First Automatically Flushable Packet (2)
>     00.. .... .... .... = BC Flag: Point-To-Point (0)
>     Data Total Length: 12
>     [Connect in frame: 239]
>     [Source BD_ADDR: ChengHon_00:00:2e (00:19:86:00:00:2e)]
>     [Source Device Name: Standard PC (i440FX + PIIX, 1996)]
>     [Source Role: Master (1)]
>     [Destination BD_ADDR: 30:21:57:95:5a:3a (30:21:57:95:5a:3a)]
>     [Destination Device Name: JY-17]
>     [Destination Role: Slave (2)]
>     [Last Role Change in Frame: 238]
>     [Current Mode: Active Mode (0)]
>     [Last Mode Change in Frame: 239]
> Bluetooth L2CAP Protocol
>     Length: 8
>     CID: L2CAP Signaling Channel (0x0001)
>     Command: Disconnection Response
>         Command Code: Disconnection Response (0x07)
>         Command Identifier: 0x06
>         Command Length: 4
>         Destination CID: Dynamically Allocated Channel (0x0040)
>         Source CID: Dynamically Allocated Channel (0x0040)
>     [PSM: SDP (0x0001)]
>     [Connect in frame: 253]
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
--
Vinicius
