Return-Path: <juha.kuikka@gmail.com>
MIME-Version: 1.0
In-Reply-To: <6B0AC741-28BC-4F1A-90E2-5634246F591D@holtmann.org>
References: <1485867673.2993.5.camel@iki.fi> <A00CAB7E-3131-4430-8AEA-4132E28CE8FE@holtmann.org>
 <1486380902.4774.4.camel@iki.fi> <6B0AC741-28BC-4F1A-90E2-5634246F591D@holtmann.org>
From: Juha Kuikka <juha.kuikka@gmail.com>
Date: Fri, 10 Feb 2017 14:23:26 -0800
Message-ID: <CAKvrXUrUy26AaLZ-y2mBeB7QO1+qQsLHfeXnzFkN-1atRoGEFg@mail.gmail.com>
Subject: Re: SCO socket MTU problem in PulseAudio
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Tanu Kaskinen <tanuk@iki.fi>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	Renjith Thomas <renjith@lightlevitate.com>, Georg Chini <georg@chini.tk>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

Sorry to butt in but I have some observations on this.

I have been working on a related thing
(https://github.com/Arkq/bluez-alsa) to add support for HFP and mSBC.

HW:
CSR8510 A10 dongle
Jabra Halo Smart and LG HBS730

SW:
Kernel: 4.4.0-53-generic #74-Ubuntu
BlueZ 5.43

On Fri, Feb 10, 2017 at 3:48 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Tanu,
>
>>>> PulseAudio recently started to use
>>>>
>>>>   getsockopt(sock, SOL_SCO, SCO_OPTIONS, &sco_opt, &len);
>>>>   read_mtu =3D sco_opt.mtu;
>>>>   write_mtu =3D sco_opt.mtu;
>>>>
>>>> to query the MTU of the SCO socket. Previously we used a fixed value o=
f
>>>> 48, but that didn't work for some bluetooth chipsets (see the commit
>>>> message[1]). Now, however, it was reported[2] that the new code doesn'=
t
>>>> work on some hardware where the old fixed MTU used to work.
>>>
>>> can you share details here and btmon traces for the data buffer sizes
>>> and the USB descriptor details. We would need to figure out where
>>> this goes wrong and maybe introduce some driver quirks to ensure that
>>> it returns usable values.
>>
>> Georg already provided a btmon dump. Did that contain everything you
>> need? The way you put your words, it's not clear to me if the USB
>> descriptor details are included in the btmon output or is the USB
>> descriptor a separate thing?
>>
>> I'd like to provide clear instructions for users to get the necessary
>> information, in case it turns out that Georg is not the only one with
>> this problem. What options should be given to btmon?
>
> < HCI Command: Read Local Version Info.. (0x04|0x0001) plen 0
>> HCI Event: Command Complete (0x0e) plen 12
>       Read Local Version Information (0x04|0x0001) ncmd 1
>         Status: Success (0x00)
>         HCI version: Bluetooth 2.0 (0x03) - Revision 5276 (0x149c)
>         LMP version: Bluetooth 2.0 (0x03) - Subversion 5276 (0x149c)
>         Manufacturer: Cambridge Silicon Radio (10)
> < HCI Command: Read BD ADDR (0x04|0x0009) plen 0
>> HCI Event: Command Complete (0x0e) plen 10
>       Read BD ADDR (0x04|0x0009) ncmd 1
>         Status: Success (0x00)
>         Address: 00:15:83:73:FD:06 (IVT corporation)
> < HCI Command: Read Buffer Size (0x04|0x0005) plen 0
>> HCI Event: Command Complete (0x0e) plen 11
>       Read Buffer Size (0x04|0x0005) ncmd 1
>         Status: Success (0x00)
>         ACL MTU: 384  ACL max packet: 8
>         SCO MTU: 64   SCO max packet: 8
>
> This seems to be CSR based hardware. Can we verify that this is the case =
with the /sys/kernel/debug/usb/devices info for this device. If this is a f=
ake device, then all bets are off anyway.

I am using this:

T:  Bus=3D02 Lev=3D02 Prnt=3D02 Port=3D03 Cnt=3D01 Dev#=3D 30 Spd=3D12   Mx=
Ch=3D 0
D:  Ver=3D 2.00 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D0a12 ProdID=3D0001 Rev=3D88.91
S:  Product=3DCSR8510 A10
C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms

No idea if it is real or not though. I should have a Broadcom dongle
around somewhere, I will see how it behaves.

>
> And yes, it reports 64 octets for the MTU. Which is most likely what you =
are getting back from the SCO socket. If this is all bogus and doesn=E2=80=
=99t work for CSR devices, we need to quirk it in the btusb driver to repor=
t a different value.

What I am seeing is that the HCI device shows SCO MTU of 64 bytes,
while the SCO connection request/response indicates a 60 byte payload
size:

hci0: Type: Primary  Bus: USB
BD Address: 00:1A:7D:DA:71:13  ACL MTU: 310:10  SCO MTU: 64:8
UP RUNNING PSCAN
RX bytes:290561090 acl:5745 sco:6560504 events:7731 errors:0
TX bytes:63087159 acl:4785 sco:6783105 commands:1870 errors:2596



< HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17


                                     [hci0] 31.193820
        Handle: 69
        Transmit bandwidth: 8000
        Receive bandwidth: 8000
        Max latency: 10
        Setting: 0x0060
          Input Coding: Linear
          Input Data Format: 2's complement
          Input Sample Size: 16-bit
          # of bits padding at MSB: 0
          Air Coding Format: CVSD
        Retransmission effort: Optimize for power consumption (0x01)
        Packet type: 0x0380
          3-EV3 may not be used
          2-EV5 may not be used
          3-EV5 may not be used
> HCI Event: Command Status (0x0f) plen 4                                  =
                                                                           =
                                                                           =
                         [hci0] 31.196366
      Setup Synchronous Connection (0x01|0x0028) ncmd 1
        Status: Success (0x00)
> HCI Event: Max Slots Change (0x1b) plen 3                                =
                                                                           =
                                                                           =
                         [hci0] 31.203367
        Handle: 69
        Max slots: 1
> HCI Event: Synchronous Connect Complete (0x2c) plen 17                   =
                                                                           =
                                                                           =
                         [hci0] 31.208364
        Status: Success (0x00)
        Handle: 71
        Address: 00:18:6B:52:A6:3F (Sambu Communics CO., LTD.)
        Link type: eSCO (0x02)
        Transmission interval: 0x0c
        Retransmission window: 0x02
        RX packet length: 60
        TX packet length: 60
        Air mode: CVSD (0x02)

....


However, for CVSD audio I also am getting 48 byte PDUs from the socket
(btmon shows same size) but if I configure the SCO link in to
transparent mode for mSBC I start getting 24 byte PDUs (again btmon
shows 24 bytes as well). In both cases the bandwidth is the same 8000
kByte/s.

> SCO Data RX: Handle 71 flags 0x00 dlen 48                                =
                                                                           =
                                                                           =
                         [hci0] 31.234743
> SCO Data RX: Handle 71 flags 0x00 dlen 48                                =
                                                                           =
                                                                           =
                         [hci0] 31.234744


In either case, if I actually send 60 or 64 byte PDUs, I hear nothing.

As a workaround I am setting the write MTU based on the read MTU I get
from the SCO socket and that seems reliable.

(As a side note, I have not been able to make the mSBC output work, no
headset of mine plays anything I send and I am pretty sure I have the
framing correct. I will try another controller for this as well.)

- Juha
