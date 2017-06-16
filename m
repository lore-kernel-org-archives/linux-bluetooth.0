Return-Path: <marcos@scriven.org>
MIME-Version: 1.0
In-Reply-To: <CA+zKUVLA=dmm9mQ35X4rqcH8Sr6CEHS6R20sx0qsM9rbOSu8yg@mail.gmail.com>
References: <CA+zKUVLFdP4ho91ZkykW0gnEQw-3gOFLPd0YnuqLLp2UqROcfQ@mail.gmail.com>
 <15900B5C-F25F-4077-B1BA-A4C3F59FD95C@holtmann.org> <CA+zKUV+N5PZ9AP+GNTUFWCMG4cHwJ6EKU9pig_76ggTDACE0XA@mail.gmail.com>
 <77805EC8-592F-406C-9EC7-D33211238A1B@holtmann.org> <CA+zKUVLA=dmm9mQ35X4rqcH8Sr6CEHS6R20sx0qsM9rbOSu8yg@mail.gmail.com>
From: Marcos Scriven <marcos@scriven.org>
Date: Fri, 16 Jun 2017 11:20:02 +0100
Message-ID: <CA+zKUVJWxm+oZ6yCJB2NX0GLfLbthG2bCNpd0f2MK1C2zVd_dQ@mail.gmail.com>
Subject: Re: Questions on event masks (specifically in tools/3dsp.c)
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jun 16, 2017 at 11:10 AM, Marcos Scriven <marcos@scriven.org> wrote:
> Hi Marcel
>
> On Fri, Jun 16, 2017 at 10:59 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> Hi Marcos,
>>
>>> I did try btmon, but was only seeing other devices about the house,
>>> nothing that looked liked the 3D glasses, no matter how many times I
>>> press the sync button on the glasses.
>>
>> that is not how this works. The glasses will scan and find the the TV and then sync to its connectionless slave broadcast that broadcasts the shutter synchronization information. Glasses will never be discoverable.
>
> I see - then I'm confused why you suggested capturing btmon output?
> What should I be seeing that I'm not?
>
>>
>>> As the glasses were quite cheap, I went ahead and opened them up, to
>>> find it's based on the Broadcom 20730, which is only Bluetooth 3.0
>>> according to the datasheet:
>>> http://www.cypress.com/file/298211/download
>>>
>>> It specifically mentioned 3D glasses support in section 1.3:
>>>
>>> "The CYW20730, combined with the CYW20702, provides full system
>>> support for 3D glasses on televisions. The CYW20702 gets frame
>>> synchronization signals from the TV, converts them into proprietary
>>> timing control messages, then passes these messages to the CYW20730.
>>> The CYW20730 uses these messages to synchronize the shutter control
>>> for the 3D glasses with the television frames."
>>>
>>> However, there's no such CYW20702 chip on the board, but instead a
>>> Sitronix ST9902:
>>> http://www.datasheetspdf.com/datasheet/download.php?id=948278
>>>
>>> The description for that is:
>>>
>>> "ST9902 is an integrated circuit for liquid-crystal shutter glasses
>>> driver. It combines a DC/DC converter that generates a specified
>>> voltage level as the output voltage source to the four-channel analog
>>> switches. Each analog switch has a dedicated input control pin and a
>>> dedicated output analog pin. The analog switches can be used as the
>>> lens driver in a 3D glasses system application. 16K-byte EEPROM is
>>> suitable for the MCU-based system, which can use EEPROM as a code or
>>> data storage unit. ST9902 chip is integrated into a 16-pin QFN package
>>> and only a few external passive components are require"
>>>
>>> So that seems to be just a simple I2C controller for the shutters
>>> themselves, whereas the companion CYW20702 looks like a full Bluetooth
>>> 4.0 processor.
>>>
>>> I thus have no idea how this is even works, the datasheet for the
>>> CYW20730 doesn't explain how it would work to control 3D glasses
>>> without the CYW20702 - I'm presuming it must therefore have been
>>> programmed by the manufacturer of the glasses. Would you agree that
>>> means it could only support the legacy 3D glasses profile?
>>>
>>> It would also seem it's BR/EDR only - but should I then still see
>>> output in btmon, or is that Bluetooth LE only?
>>
>> Connection slave broadcast (which is the features used for the 3D Glasses Profile) is based on BR/EDR.
>>
>
> So I doubled checked the bcm43438 in the Raspberry Pi 3 does indeed
> support connectionless slave broadcast:
> https://www.bluetooth.org/tpg/showCorePICS.cfm?3A000A5A005C5346565A5D12136B4F1D17270F0812080D34405C210C0D130B285C44
>
> There's a tick in table 3a, with a reference to Bluetooth spec BB
> 8.10.1 LMP 3.3 Table 3.4, Item 128
>
> So - if the Raspberry Pi 3 is capable, then I should be seeing
> something output from the BCM20730 in the glasses?
>
> There's an interesting post here in a thread about some other glasses
> with the same IC (though it's not clear if that used the companion IC
> mine doesn't have):
> http://forum.samygo.tv/viewtopic.php?f=25&t=2273&sid=1297f30a44c3ab989e797e9a2eef460c&start=40#p59904
>
> Quote: "I think its shown that it would never be possible to use an
> ordinary usb-bt4 dongle as even samsung needed one with extra l-r-sync
> input lines
> so even the glasses would be controllble via cheap dongles i doubt
> that we'll get acceptable syncing..."
>
> So you have any guidance on how I can verify:
>
> - The Raspberry Pi really is in connectionless slave mode
> - That anything at all is coming out of the 3D glasses when I hit the
> sync button?
>
> Thanks
>
> Marcos
>
>> Regards
>>
>> Marcel
>>


Just to add for ref:

$ hciconfig -a
hci0: Type: BR/EDR  Bus: UART
BD Address: xxxxxxxx  ACL MTU: 1021:8  SCO MTU: 64:1
UP RUNNING
RX bytes:25695 acl:0 sco:0 events:1177 errors:0
TX bytes:3995 acl:0 sco:0 commands:452 errors:0
Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
Link policy: RSWITCH SNIFF
Link mode: SLAVE ACCEPT
Name: 'reelyactive-pi'
Class: 0x000000
Service Classes: Unspecified
Device Class: Miscellaneous,
HCI Version: 4.1 (0x7)  Revision: 0xb6
LMP Version: 4.1 (0x7)  Subversion: 0x2209
Manufacturer: Broadcom Corporation (15)
