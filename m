Return-Path: <marcos@scriven.org>
MIME-Version: 1.0
In-Reply-To: <8C761B99-AFD0-4F19-AC12-74476EFF252F@holtmann.org>
References: <CA+zKUVLFdP4ho91ZkykW0gnEQw-3gOFLPd0YnuqLLp2UqROcfQ@mail.gmail.com>
 <15900B5C-F25F-4077-B1BA-A4C3F59FD95C@holtmann.org> <CA+zKUV+N5PZ9AP+GNTUFWCMG4cHwJ6EKU9pig_76ggTDACE0XA@mail.gmail.com>
 <77805EC8-592F-406C-9EC7-D33211238A1B@holtmann.org> <CA+zKUVLA=dmm9mQ35X4rqcH8Sr6CEHS6R20sx0qsM9rbOSu8yg@mail.gmail.com>
 <CA+zKUVJWxm+oZ6yCJB2NX0GLfLbthG2bCNpd0f2MK1C2zVd_dQ@mail.gmail.com>
 <CA+zKUVKp0GL8Th3Cc38sUEmxi_LC5y8TMFUeHvCsLJPoDB+Y2w@mail.gmail.com>
 <D957B815-5235-4921-8499-DB5C5FA024C8@holtmann.org> <CA+zKUVJo0EySUputA950SCCko-FiXOAEbndbgqHS2jw7VF2mCw@mail.gmail.com>
 <8C761B99-AFD0-4F19-AC12-74476EFF252F@holtmann.org>
From: Marcos Scriven <marcos@scriven.org>
Date: Mon, 19 Jun 2017 20:25:05 +0100
Message-ID: <CA+zKUVLZc-nNrvJ72qV99Cv7gwZ4fwvtY7wx1VhPgQ=UW45N8A@mail.gmail.com>
Subject: Re: Questions on event masks (specifically in tools/3dsp.c)
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jun 16, 2017 at 4:15 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Marcos,
>
>>>>>>>> I did try btmon, but was only seeing other devices about the house=
,
>>>>>>>> nothing that looked liked the 3D glasses, no matter how many times=
 I
>>>>>>>> press the sync button on the glasses.
>>>>>>>
>>>>>>> that is not how this works. The glasses will scan and find the the =
TV and then sync to its connectionless slave broadcast that broadcasts the =
shutter synchronization information. Glasses will never be discoverable.
>>>>>>
>>>>>> I see - then I'm confused why you suggested capturing btmon output?
>>>>>> What should I be seeing that I'm not?
>>>>>>
>>>>>>>
>>>>>>>> As the glasses were quite cheap, I went ahead and opened them up, =
to
>>>>>>>> find it's based on the Broadcom 20730, which is only Bluetooth 3.0
>>>>>>>> according to the datasheet:
>>>>>>>> http://www.cypress.com/file/298211/download
>>>>>>>>
>>>>>>>> It specifically mentioned 3D glasses support in section 1.3:
>>>>>>>>
>>>>>>>> "The CYW20730, combined with the CYW20702, provides full system
>>>>>>>> support for 3D glasses on televisions. The CYW20702 gets frame
>>>>>>>> synchronization signals from the TV, converts them into proprietar=
y
>>>>>>>> timing control messages, then passes these messages to the CYW2073=
0.
>>>>>>>> The CYW20730 uses these messages to synchronize the shutter contro=
l
>>>>>>>> for the 3D glasses with the television frames."
>>>>>>>>
>>>>>>>> However, there's no such CYW20702 chip on the board, but instead a
>>>>>>>> Sitronix ST9902:
>>>>>>>> http://www.datasheetspdf.com/datasheet/download.php?id=3D948278
>>>>>>>>
>>>>>>>> The description for that is:
>>>>>>>>
>>>>>>>> "ST9902 is an integrated circuit for liquid-crystal shutter glasse=
s
>>>>>>>> driver. It combines a DC/DC converter that generates a specified
>>>>>>>> voltage level as the output voltage source to the four-channel ana=
log
>>>>>>>> switches. Each analog switch has a dedicated input control pin and=
 a
>>>>>>>> dedicated output analog pin. The analog switches can be used as th=
e
>>>>>>>> lens driver in a 3D glasses system application. 16K-byte EEPROM is
>>>>>>>> suitable for the MCU-based system, which can use EEPROM as a code =
or
>>>>>>>> data storage unit. ST9902 chip is integrated into a 16-pin QFN pac=
kage
>>>>>>>> and only a few external passive components are require"
>>>>>>>>
>>>>>>>> So that seems to be just a simple I2C controller for the shutters
>>>>>>>> themselves, whereas the companion CYW20702 looks like a full Bluet=
ooth
>>>>>>>> 4.0 processor.
>>>>>>>>
>>>>>>>> I thus have no idea how this is even works, the datasheet for the
>>>>>>>> CYW20730 doesn't explain how it would work to control 3D glasses
>>>>>>>> without the CYW20702 - I'm presuming it must therefore have been
>>>>>>>> programmed by the manufacturer of the glasses. Would you agree tha=
t
>>>>>>>> means it could only support the legacy 3D glasses profile?
>>>>>>>>
>>>>>>>> It would also seem it's BR/EDR only - but should I then still see
>>>>>>>> output in btmon, or is that Bluetooth LE only?
>>>>>>>
>>>>>>> Connection slave broadcast (which is the features used for the 3D G=
lasses Profile) is based on BR/EDR.
>>>>>>>
>>>>>>
>>>>>> So I doubled checked the bcm43438 in the Raspberry Pi 3 does indeed
>>>>>> support connectionless slave broadcast:
>>>>>> https://www.bluetooth.org/tpg/showCorePICS.cfm?3A000A5A005C5346565A5=
D12136B4F1D17270F0812080D34405C210C0D130B285C44
>>>>>>
>>>>>> There's a tick in table 3a, with a reference to Bluetooth spec BB
>>>>>> 8.10.1 LMP 3.3 Table 3.4, Item 128
>>>>>>
>>>>>> So - if the Raspberry Pi 3 is capable, then I should be seeing
>>>>>> something output from the BCM20730 in the glasses?
>>>>>>
>>>>>> There's an interesting post here in a thread about some other glasse=
s
>>>>>> with the same IC (though it's not clear if that used the companion I=
C
>>>>>> mine doesn't have):
>>>>>> http://forum.samygo.tv/viewtopic.php?f=3D25&t=3D2273&sid=3D1297f30a4=
4c3ab989e797e9a2eef460c&start=3D40#p59904
>>>>>>
>>>>>> Quote: "I think its shown that it would never be possible to use an
>>>>>> ordinary usb-bt4 dongle as even samsung needed one with extra l-r-sy=
nc
>>>>>> input lines
>>>>>> so even the glasses would be controllble via cheap dongles i doubt
>>>>>> that we'll get acceptable syncing..."
>>>>>>
>>>>>> So you have any guidance on how I can verify:
>>>>>>
>>>>>> - The Raspberry Pi really is in connectionless slave mode
>>>>>> - That anything at all is coming out of the 3D glasses when I hit th=
e
>>>>>> sync button?
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>>> Marcos
>>>>>>
>>>>>>> Regards
>>>>>>>
>>>>>>> Marcel
>>>>>>>
>>>>>
>>>>>
>>>>> Just to add for ref:
>>>>>
>>>>> $ hciconfig -a
>>>>> hci0: Type: BR/EDR  Bus: UART
>>>>> BD Address: xxxxxxxx  ACL MTU: 1021:8  SCO MTU: 64:1
>>>>> UP RUNNING
>>>>> RX bytes:25695 acl:0 sco:0 events:1177 errors:0
>>>>> TX bytes:3995 acl:0 sco:0 commands:452 errors:0
>>>>> Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
>>>>> Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>>>>> Link policy: RSWITCH SNIFF
>>>>> Link mode: SLAVE ACCEPT
>>>>> Name: 'reelyactive-pi'
>>>>> Class: 0x000000
>>>>> Service Classes: Unspecified
>>>>> Device Class: Miscellaneous,
>>>>> HCI Version: 4.1 (0x7)  Revision: 0xb6
>>>>> LMP Version: 4.1 (0x7)  Subversion: 0x2209
>>>>> Manufacturer: Broadcom Corporation (15)
>>>>
>>>> Marcel
>>>>
>>>> I started from a completely fresh Raspbian distro, and compiled (but
>>>> did not install this time) bluez. Now I am indeed getting output from
>>>> btmon while running:
>>>>
>>>> ./tools/3dsp -D -i 0
>>>>
>>>> Looks much more promising - now I feel I can start tweaking your code:
>>>>
>>>> @ Index Removed
>>>> * Unknown packet (code 8 len 0)
>>>>
>>>>            [hci0] 403.442518
>>>> * Unknown packet (code 10 len 8)
>>>>
>>>>            [hci0] 403.442527
>>>>       3c 4d a3 eb 27 b8 0f 00                          <M..'...
>>>> < HCI Command: Reset (0x03|0x0003) plen 0
>>>>
>>>>            [hci0] 403.442656
>>>>> HCI Event: Command Complete (0x0e) plen 4                            =
                            [hci0] 403.445053
>>>>     Reset (0x03|0x0003) ncmd 1
>>>>       Status: Success (0x00)
>>>> < HCI Command: Set Event Mask (0x03|0x0001) plen 8
>>>>
>>>>            [hci0] 403.445155
>>>>       Mask: 0x000000000000e01c
>>>>         Connection Complete
>>>>         Connection Request
>>>>         Disconnection Complete
>>>>         Command Complete
>>>>         Command Status
>>>>         Hardware Error
>>>>> HCI Event: Command Complete (0x0e) plen 4                            =
                            [hci0] 403.445721
>>>>     Set Event Mask (0x03|0x0001) ncmd 1
>>>>       Status: Success (0x00)
>>>> < HCI Command: Set Event Mask Page 2 (0x03|0x0063) plen 8
>>>>
>>>>            [hci0] 403.445819
>>>>       Mask: 0x000000000074c000
>>>>         Triggered Clock Capture
>>>>         Synchronization Train Complete
>>>>         Connectionless Slave Broadcast Timeout
>>>>         Slave Page Response Timeout
>>>>         Connectionless Slave Broadcast Channel Map Change
>>>>         Inquiry Response Notification
>>>>> HCI Event: Command Complete (0x0e) plen 4                            =
                            [hci0] 403.446324
>>>>     Set Event Mask Page 2 (0x03|0x0063) ncmd 1
>>>>       Status: Success (0x00)
>>>> < HCI Command: Write Simple Pairing Mode (0x03|0x0056) plen 1
>>>>
>>>>            [hci0] 403.446412
>>>>       Mode: Enabled (0x01)
>>>>> HCI Event: Command Complete (0x0e) plen 4                            =
                            [hci0] 403.548305
>>>>     Write Simple Pairing Mode (0x03|0x0056) ncmd 1
>>>>       Status: Success (0x00)
>>>> < HCI Command: Set Reserved LT_ADDR (0x03|0x0074) plen 1
>>>>
>>>>            [hci0] 403.548397
>>>>       LT address: 1
>>>>> HCI Event: Command Complete (0x0e) plen 5                            =
                            [hci0] 403.548817
>>>>     Set Reserved LT_ADDR (0x03|0x0074) ncmd 1
>>>>       Status: Success (0x00)
>>>>       LT address: 1
>>>> < HCI Command: Read Synchronization Train Parameters (0x03|0x0077)
>>>> plen 0
>>>>                [hci0] 403.548897
>>>>> HCI Event: Command Complete (0x0e) plen 11                           =
                            [hci0] 403.549346
>>>>     Read Synchronization Train Parameters (0x03|0x0077) ncmd 1
>>>>       Status: Success (0x00)
>>>>       Interval: 80.000 msec (0x0080)
>>>>       Timeout: 40958.750 msec (0x0000fffe)
>>>>       Service data: 0x00
>>>> < HCI Command: Read Inquiry Response TX Power Level (0x03|0x0058) plen
>>>> 0
>>>>            [hci0] 403.549419
>>>>> HCI Event: Command Complete (0x0e) plen 5                            =
                            [hci0] 403.549771
>>>>     Read Inquiry Response TX Power Level (0x03|0x0058) ncmd 1
>>>>       Status: Success (0x00)
>>>>       TX power: 0 dBm
>>>> < HCI Command: Set Connectionless Slave Broadcast (0x01|0x0041) plen
>>>> 11
>>>>              [hci0] 403.549856
>>>>       Enable: 0x01
>>>>       LT address: 1
>>>>       LPO allowed: 0x01
>>>>       Packet type: 0x0008
>>>>         DM1 may be used
>>>>       Min interval: 50.000 msec (0x0050)
>>>>       Max interval: 100.000 msec (0x00a0)
>>>>       Supervision timeout: 40958.750 msec (0xfffe)
>>>>> HCI Event: Command Complete (0x0e) plen 7                            =
                            [hci0] 403.551327
>>>>     Set Connectionless Slave Broadcast (0x01|0x0041) ncmd 1
>>>>       Status: Success (0x00)
>>>>       LT address: 1
>>>>       Interval: 97.500 msec (0x009c)
>>>> < HCI Command: Write Extended Inquiry Response (0x03|0x0052) plen 241
>>>>
>>>>            [hci0] 403.551409
>>>>       FEC: Not required (0x00)
>>>>       3D Information Data: 0343
>>>>         Features: 0x03
>>>>           Association Notification
>>>>           Battery Level Reporting
>>>>         Path Loss Threshold: 67
>>>>       TX power: 0 dBm
>>>>> HCI Event: Command Complete (0x0e) plen 4                            =
                            [hci0] 403.554484
>>>>     Write Extended Inquiry Response (0x03|0x0052) ncmd 1
>>>>       Status: Success (0x00)
>>>> < HCI Command: Write Class of Device (0x03|0x0024) plen 3
>>>>
>>>>            [hci0] 403.554575
>>>>       Class: 0x08043c
>>>>         Major class: Audio/Video (headset, speaker, stereo, video, vcr=
)
>>>>         Minor class: Video Display and Loudspeaker
>>>>         Capturing (Scanner, Microphone)
>>>>> HCI Event: Command Complete (0x0e) plen 4                            =
                            [hci0] 403.555003
>>>>     Write Class of Device (0x03|0x0024) ncmd 1
>>>>       Status: Success (0x00)
>>>> < HCI Command: Write Scan Enable (0x03|0x001a) plen 1
>>>>
>>>>            [hci0] 403.555097
>>>>       Scan enable: Inquiry Scan + Page Scan (0x03)
>>>>> HCI Event: Command Complete (0x0e) plen 4                            =
                            [hci0] 403.555524
>>>>     Write Scan Enable (0x03|0x001a) ncmd 1
>>>>       Status: Success (0x00)
>>>> < HCI Command: Read Clock (0x05|0x0007) plen 3
>>>>
>>>>            [hci0] 403.555627
>>>>       Handle: 0
>>>>       Type: Local clock (0x00)
>>>>> HCI Event: Command Complete (0x0e) plen 12                           =
                            [hci0] 403.558344
>>>>     Read Clock (0x05|0x0007) ncmd 1
>>>>       Status: Success (0x00)
>>>>       Handle: 0
>>>>       Clock: 0x0060ab22
>>>>       Accuracy: 0.0000 msec (0x0000)
>>>> < HCI Command: Set Connectionless Slave Broadcast Data (0x03|0x0076)
>>>> plen 20
>>>>              [hci0] 403.558453
>>>>       LT address: 1
>>>>       Fragment: No fragmentation (0x03)
>>>>       Length: 17
>>>>       22 ab 60 00 00 00 32 00 2c 01 5e 01 58 02 8a 02  ".`...2.,.^.X..=
.
>>>>       00                                               .
>>>>> HCI Event: Command Complete (0x0e) plen 5                            =
                            [hci0] 403.559046
>>>>     Set Connectionless Slave Broadcast Data (0x03|0x0076) ncmd 1
>>>>       Status: Success (0x00)
>>>>       LT address: 1
>>>
>>> and now press the =E2=80=9Cconnect=E2=80=9D button on the glasses and y=
ou should see them trying to find and connect to your =E2=80=9Cfake=E2=80=
=9D TV. Problem is just that you need the display sync information to do an=
ything more useful with this.
>>>
>>> Regards
>>>
>>> Marcel
>>>
>>
>> Yes - looks like it!
>>
>>> HCI Event: Inquiry Response Notification (0x56) plen 4                 =
                             [hci0] 40.493815
>>        Access code: 0x9e8b33 (General Inquiry)
>>        RSSI: -65 dBm (0xbf)
>>> HCI Event: Inquiry Response Notification (0x56) plen 4                 =
                             [hci0] 40.774764
>>        Access code: 0x9e8b33 (General Inquiry)
>>        RSSI: -76 dBm (0xb4)
>>> HCI Event: Inquiry Response Notification (0x56) plen 4                 =
                             [hci0] 41.135087
>>        Access code: 0x9e8b33 (General Inquiry)
>>        RSSI: -68 dBm (0xbc)
>
> you might see a L2CAP connectionless channel with a single message, but t=
hat is all you will see on the display side. It uses truncated paging. Sinc=
e inquiry + paging is only used to establish the sync. It is called connect=
ionless broadcast for a reason. It is a broadcast and not a connection.
>
>> However, shouldn't the fake 3D display then be responding to those
>> general inquiries (which as I understand it from the spec is to choose
>> a display by proximity info from the path loss of such responses)?
>>
>> Yes - getting vsync from the display is another challenge, but it
>> would be great to get to the point of at least flipping the shutters
>> with fake data.
>
> You can try if you can see them. It is however hard to get good data. Sin=
ce they relate to the Bluetooth clock in the first place.
>
> Regards
>
> Marcel
>

Thanks again Marcel

There's still three things I'm not clear about:

1) The extended response is written before I even touch the the 3D glasses:

< HCI Command: Write Extended Inquiry Response (0x03|0x0052) plen 241

             [hci0] 306.457118
        FEC: Not required (0x00)
        3D Information Data: 0364
          Features: 0x03
            Association Notification
            Battery Level Reporting
          Path Loss Threshold: 100
        TX power: 0 dBm

Does that just mean the EIR is being 'setup', and is sent out
implicitly in response to any general inquiry, or actually sent out
(too early)? Either way, should I not see evidence of the EIR being
sent out, once I hit the sync button on the glasses and see the
General Inquiry:

> HCI Event: Inquiry Response Notification (0x56) plen 4                   =
                                                                           =
     [hci0] 657.512966
        Access code: 0x9e8b33 (General Inquiry)
        RSSI: -63 dBm (0xc1)


2) Again on the EIR setup (if that's what it is), I always see "TX
power: 0dBm", which comes from here:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/3dsp.c#n422

Is it odd that's always zero? So far as I understand it, the glasses
should use that power, and the actual power received, to calculate
path loss, and then associate with the glasses with lowest path loss
(if any are below the threshold). I tried setting the power manual,
and increasing the threshold, to not effect.


3) I do not see "Incoming connection from 3D glasses" in the logs -
and that's in "conn_request" handler which should actually start the
sync train. If I'm not seeing that, looking at the 3DSP spec, does
that essentially mean the glasses have not found a suitable display to
associate with?

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/3dsp.c#n386

Thanks

Marcos

Here's another btcmon dump - first just starting ./tools/3dsp.c -D -i
0, and then hitting the button on the glasses:

@ Index Removed
* Unknown packet (code 17 len 6)

            [hci0] 1097.428375
        02 00 00 00 05 00                                ......
* Unknown packet (code 8 len 0)

            [hci0] 1097.428418
* Unknown packet (code 10 len 8)

            [hci0] 1097.428426
        3c 4d a3 eb 27 b8 0f 00                          <M..'...
* Unknown packet (code 14 len 30)

            [hci0] 1097.428447
        01 00 00 00 01 00 02 16 00 01 00 00 00 10 33 64  ..............3d
        73 70 00 00 00 00 00 00 00 00 00 00 00 00        sp............
< HCI Command: Reset (0x03|0x0003) plen 0

            [hci0] 1097.428622
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                                           =
    [hci0] 1097.430997
      Reset (0x03|0x0003) ncmd 1
        Status: Success (0x00)
< HCI Command: Set Event Mask (0x03|0x0001) plen 8

            [hci0] 1097.431097
        Mask: 0x000000000000e01f
          Inquiry Complete
          Inquiry Result
          Connection Complete
          Connection Request
          Disconnection Complete
          Command Complete
          Command Status
          Hardware Error
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                                           =
    [hci0] 1097.431837
      Set Event Mask (0x03|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: Set Event Mask Page 2 (0x03|0x0063) plen 8

            [hci0] 1097.432019
        Mask: 0x000000000074c000
          Triggered Clock Capture
          Synchronization Train Complete
          Connectionless Slave Broadcast Timeout
          Slave Page Response Timeout
          Connectionless Slave Broadcast Channel Map Change
          Inquiry Response Notification
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                                           =
    [hci0] 1097.432510
      Set Event Mask Page 2 (0x03|0x0063) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Simple Pairing Mode (0x03|0x0056) plen 1

            [hci0] 1097.432611
        Mode: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                                           =
    [hci0] 1097.535715
      Write Simple Pairing Mode (0x03|0x0056) ncmd 1
        Status: Success (0x00)
< HCI Command: Set Reserved LT_ADDR (0x03|0x0074) plen 1

            [hci0] 1097.535831
        LT address: 1
> HCI Event: Command Complete (0x0e) plen 5                                =
                                                                           =
    [hci0] 1097.536281
      Set Reserved LT_ADDR (0x03|0x0074) ncmd 1
        Status: Success (0x00)
        LT address: 1
< HCI Command: Read Synchronization Train Parameters (0x03|0x0077)
plen 0
                [hci0] 1097.536372
> HCI Event: Command Complete (0x0e) plen 11                               =
                                                                           =
    [hci0] 1097.536848
      Read Synchronization Train Parameters (0x03|0x0077) ncmd 1
        Status: Success (0x00)
        Interval: 80.000 msec (0x0080)
        Timeout: 40958.750 msec (0x0000fffe)
        Service data: 0x00
< HCI Command: Read Inquiry Response TX Power Level (0x03|0x0058) plen
0
            [hci0] 1097.536935
> HCI Event: Command Complete (0x0e) plen 5                                =
                                                                           =
    [hci0] 1097.537336
      Read Inquiry Response TX Power Level (0x03|0x0058) ncmd 1
        Status: Success (0x00)
        TX power: 0 dBm
< HCI Command: Set Connectionless Slave Broadcast (0x01|0x0041) plen
11
              [hci0] 1097.537507
        Enable: 0x01
        LT address: 1
        LPO allowed: 0x01
        Packet type: 0x0008
          DM1 may be used
        Min interval: 50.000 msec (0x0050)
        Max interval: 100.000 msec (0x00a0)
        Supervision timeout: 40958.750 msec (0xfffe)
> HCI Event: Command Complete (0x0e) plen 7                                =
                                                                           =
    [hci0] 1097.539334
      Set Connectionless Slave Broadcast (0x01|0x0041) ncmd 1
        Status: Success (0x00)
        LT address: 1
        Interval: 97.500 msec (0x009c)
< HCI Command: Write Extended Inquiry Response (0x03|0x0052) plen 241

            [hci0] 1097.539491
        FEC: Not required (0x00)
        3D Information Data: 0364
          Features: 0x03
            Association Notification
            Battery Level Reporting
          Path Loss Threshold: 100
        TX power: 60 dBm
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                                           =
    [hci0] 1097.542579
      Write Extended Inquiry Response (0x03|0x0052) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Class of Device (0x03|0x0024) plen 3

            [hci0] 1097.542681
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                                           =
    [hci0] 1097.543093
      Write Class of Device (0x03|0x0024) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1

            [hci0] 1097.543183
        Scan enable: Inquiry Scan + Page Scan (0x03)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                                           =
    [hci0] 1097.543631
      Write Scan Enable (0x03|0x001a) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Clock (0x05|0x0007) plen 3

            [hci0] 1097.543720
        Handle: 0
        Type: Local clock (0x00)
> HCI Event: Command Complete (0x0e) plen 12                               =
                                                                           =
    [hci0] 1097.546343
      Read Clock (0x05|0x0007) ncmd 1
        Status: Success (0x00)
        Handle: 0
        Clock: 0x08371d4c
        Accuracy: 0.0000 msec (0x0000)
< HCI Command: Set Connectionless Slave Broadcast Data (0x03|0x0076)
plen 20
              [hci0] 1097.546444
        LT address: 1
        Fragment: No fragmentation (0x03)
        Length: 17
        4c 1d 37 08 00 00 32 00 2c 01 5e 01 58 02 8a 02  L.7...2.,.^.X...
        00                                               .
> HCI Event: Command Complete (0x0e) plen 5                                =
                                                                           =
    [hci0] 1097.547038
      Set Connectionless Slave Broadcast Data (0x03|0x0076) ncmd 1
        Status: Success (0x00)
        LT address: 1

# Wait a few second, then press sync button on glasses

> HCI Event: Inquiry Response Notification (0x56) plen 4                   =
                                                                           =
    [hci0] 1205.356574
        Access code: 0x9e8b33 (General Inquiry)
        RSSI: -67 dBm (0xbd)
> HCI Event: Inquiry Response Notification (0x56) plen 4                   =
                                                                           =
    [hci0] 1205.416861
        Access code: 0x9e8b33 (General Inquiry)
        RSSI: -64 dBm (0xc0)
> HCI Event: Inquiry Response Notification (0x56) plen 4                   =
                                                                           =
    [hci0] 1205.847817
        Access code: 0x9e8b33 (General Inquiry)
        RSSI: -72 dBm (0xb8)
> HCI Event: Inquiry Response Notification (0x56) plen 4                   =
                                                                           =
    [hci0] 1206.428159
        Access code: 0x9e8b33 (General Inquiry)
        RSSI: -62 dBm (0xc2)

# Then nothing further.
