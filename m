Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: HFP - No Audio
To: Jason Gauthier <jagauthier@gmail.com>
References: <5799150B.2040401@littlecraft.io>
 <CAHY_EhU3F-DN5N9cUt=BSnd=LH1+05xqSpwCFE-iEr+hoQALYw@mail.gmail.com>
 <579943D4.5070900@littlecraft.io>
 <CAHY_EhUvhffcZUVU0QnKm+OOjid9sPcPaR_gOx6-2TVtMjwq_w@mail.gmail.com>
Cc: linux-bluetooth@vger.kernel.org
From: Matthew Waddell <matt@littlecraft.io>
Message-ID: <579A808A.8070008@littlecraft.io>
Date: Thu, 28 Jul 2016 15:00:42 -0700
MIME-Version: 1.0
In-Reply-To: <CAHY_EhUvhffcZUVU0QnKm+OOjid9sPcPaR_gOx6-2TVtMjwq_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thank you!  I can confirm that these versions do indeed work together 
with a CSR adapter.  HFP audio works!

The missing SCO payload issue that I was seeing--where the Audio Gateway 
(my phone) was sending empty SCO payloads (all 0x0000 or 0x0100), and 
probably the real reason that HFP had not been working for me up until 
now, was likely due to a bug on my phone!  It happened to be running a 
nightly build of Cyanogenmod 13.  Updating to a more recent build seems 
to have fixed whatever was going on there.  Sheesh...

Thanks,
_matt

On 07/27/2016 05:23 PM, Jason Gauthier wrote:
> Sure!
>
> Linux Kernel: 4.4.11-v7+
> Bluez 5.39
> PA: 8.0
> Ofono : 1.18
>
> Bus 001 Device 006: ID 0a12:0001 Cambridge Silicon Radio, Ltd
> Bluetooth Dongle (HCI mode)
>
> hci1:   Type: BR/EDR  Bus: USB
>          BD Address: 00:1A:7D:DA:71:13  ACL MTU: 310:10  SCO MTU: 64:8
>          UP RUNNING PSCAN
>          RX bytes:997282 acl:2321 sco:7085 events:417 errors:0
>          TX bytes:369146 acl:198 sco:7083 commands:138 errors:1
>          Features: 0xff 0xff 0x8f 0xfe 0xdb 0xff 0x5b 0x87
>          Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>          Link policy: RSWITCH HOLD SNIFF PARK
>          Link mode: SLAVE ACCEPT
>          Name: 'CarPi #2'
>          Class: 0x2c0000
>          Service Classes: Rendering, Capturing, Audio
>          Device Class: Miscellaneous,
>          HCI Version: 4.0 (0x6)  Revision: 0x22bb
>          LMP Version: 4.0 (0x6)  Subversion: 0x22bb
>          Manufacturer: Cambridge Silicon Radio (10)
>
>
> On Wed, Jul 27, 2016 at 7:29 PM, Matthew Waddell <matt@littlecraft.io> wrote:
>> Hi Jason,
>>
>> Thank you for the success report!
>>
>> Would you be able to share the version numbers of the Kernel, Bluez, Ofono,
>> and pulseaudio you are using on your pi3?  Also, do you know what chipset of
>> bluetooth adapter you are using?
>>
>> Thanks!
>> _matt
>>
>> On 07/27/2016 04:25 PM, Jason Gauthier wrote:
>>>
>>> Matthew,
>>>
>>>    That was my original email, but no success.  The BT adapter in the
>>> raspberry pi 3 I was using does not show any SCO packets during the
>>> call.  I've moved to an external BT device and I haven't had any
>>> issues with it.
>>>
>>> When the call is made, your screen should be *flooded* with SCO
>>> packets.  If not, then you are experiencing the same problem that I've
>>> never found a solution to.
>>>
>>> Good luck,
>>>
>>> Jason
>>>
>>> On Wed, Jul 27, 2016 at 4:09 PM, Matthew Waddell <matt@littlecraft.io>
>>> wrote:
>>>>
>>>> Hi,
>>>>
>>>> I am trying to configure HFP to allow in-call audio to be routed through
>>>> my
>>>> PC's audio card.  I'm interested to know the current state of support,
>>>> and
>>>> if anyone has had success in getting it to work.  I have tried various
>>>> combinations of the following components, but have so far been unable to
>>>> get
>>>> the in-call audio working:
>>>>
>>>> Kernel: 4.4.11, 4.6.4, 4.7 (unstable)
>>>> Bluez: 5.37, 5.7, 5.8, 5.9
>>>> Pulesaudio: 7, 8, 9
>>>> Ofono: 1.7, 1.8, 1.9
>>>> USB Bluetooth Adapters:
>>>>        0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (CSR8510
>>>> A10)
>>>>        0a5c:21e8 Broadcom Corp. BCM20702A0 Bluetooth 4.0 (with firmware
>>>> 001.002.014 build 1338)
>>>>
>>>> I've can verify that ofono is able to detect the HFP capabilities of a
>>>> connected device, and to establish a 'modem' to it. Pulseaudio is also
>>>> notified when a call becomes active, and appears to load the appropriate
>>>> loopbacks to route the audio from/to the call through the HFP modem.
>>>> Hacking
>>>> in some extra debug tracing to pulseaudio, I've verified that pulseaudio
>>>> receives SCO packets from the file descriptor that it receives from
>>>> ofono.
>>>> Still, I am unable to hear any audio from the call.
>>>>
>>>> Something interesting that I've noticed, however, is that if I look at
>>>> the
>>>> in-call traffic with hcidump, it looks to me like the payloads of each of
>>>> the SCO packets that are received from the remote device (the phone) are
>>>> either all 0x0000 or 0x0001.  I have not seen cases where it is anything
>>>> other than that.
>>>>
>>>> Does anyone have any suggestions for what might be going on, or how I
>>>> might
>>>> be able to debug this further?
>>>>
>>>> This post from May sounds like similar circumstances, and possibly even a
>>>> success story:
>>>> http://www.spinics.net/lists/linux-bluetooth/msg67283.html
>>>>
>>>>
>>>> Thanks!
>>>> _matt
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe
>>>> linux-bluetooth"
>>>> in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
