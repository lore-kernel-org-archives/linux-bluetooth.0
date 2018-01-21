Return-Path: <attitokes@gmail.com>
MIME-Version: 1.0
In-Reply-To: <6E3D045D-0353-4D65-BBA8-75C369620677@holtmann.org>
References: <CAMoM21GBuUJu=JDOyJc+dgNHccMw=ckwRYtMwJP-j0xuXE-pDQ@mail.gmail.com>
 <1516478795.11220.8.camel@iki.fi> <CAMoM21ExUmytoG8LOSmhhL5iubqLx02r3Cn0zmujisk9Et0ZJA@mail.gmail.com>
 <1516486000.11220.9.camel@iki.fi> <CAMoM21H84=3W03S2fotyEFFbMut95_=8q-NbwkGjzgdAUZe2NQ@mail.gmail.com>
 <6E3D045D-0353-4D65-BBA8-75C369620677@holtmann.org>
From: =?UTF-8?B?QXR0aWxhIFTFkWvDqXM=?= <attitokes@gmail.com>
Date: Sun, 21 Jan 2018 21:22:55 +0200
Message-ID: <CAMoM21G-HzSysjMoZ2gDQVAHi7M_cY7a6wpPx4zmMMXUY+Hc7Q@mail.gmail.com>
Subject: Re: Raspberry Pi 3 / BCM43438 + HSP profile + PulseAudio
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Tanu Kaskinen <tanuk@iki.fi>, Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,


On Sun, Jan 21, 2018 at 2:21 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Tokes,
>
>>>>>> I'm trying to use a Bluetooth speaker with Raspberry Pi 3 in HSP mode
>>>>>> with PulseAudio.
>>>>>>
>>>>>> Based on the information I found on the web (blogs / forums / mailing
>>>>>> list archives), apparently, HSP does not really works with the
>>>>>> Rasberry Pi's built in BCM43438 chip. I didn't found the exact reason
>>>>>> yet. Some people suggest it may be a problem with the BCM43438
>>>>>> firmware or with the kernel driver. A2DP, and HSP with USB Bluetooth
>>>>>> dongles are reported to be working fine. (The most complete
>>>>>> description I found about the problem is:
>>>>>> http://youness.net/raspberry-pi/bluetooth-headset-raspberry-pi-3-ad2p-hsp)
>>>>>>
>>>>>> I think it would be useful to get clear picture about the problem. And
>>>>>> maybe we could try to fix it.
>>>>>>
>>>>>> Does anyone managed to figure out what exactly the problem is?
>>>>>>
>>>>>> I started investigating the issue, but didn't got any result yet. I
>>>>>> didn't had too much experience with the Linux's Bluetooth stack, so
>>>>>> some help with the further investigation would be useful.
>>>>>>
>>>>>> ----
>>>>>>
>>>>>> Bellow are some details of my investigation.
>>>>>>
>>>>>> Hardware: Raspberry Pi 3 + JBL GO! Bluetooth speaker
>>>>>>
>>>>>> Kernel: raspberrypi 4.14.14-v7
>>>>>> BlueZ: 5.43
>>>>>> PulseAudio: 11.1
>>>>>>
>>>>>> Summary:
>>>>>> - BCM43438's driver is sucessfuly loaded, it's firmware is uploaded successfully
>>>>>> - the Bluetooth speaker gets detected and the pairing / connection works fine
>>>>>> - PulseAudio detects the speaker as a card
>>>>>> - both the headset_head_unit and a2dp_sink profiles are shown by
>>>>>> `pacmd list-cards` and can be set with `pacmd set-card-profile`
>>>>>> - with the a2dp_sink profile, the audio playback works fine (tested
>>>>>> with `paplay`)
>>>>>> - with the headset_head_unit profile, `paplay` gets stuck at start a
>>>>>> no audio is played (`parecord` does the same)
>>>>>>
>>>>>> I started booth BlueZ and PulseAudio in debug mode, but found nothing
>>>>>> obviuosly wrong (at least for me :P) in the logs. Also did a HCI dump.
>>>>>>
>>>>>> Linking the following logs (uploaded to PasteBin; they are too long
>>>>>> inline them):
>>>>>> - the Blootoothd's log - https://pastebin.com/WC17Ze0r
>>>>>> - the PlulseAudio's log - https://pastebin.com/jUjqjuhC
>>>>>> - the output of the PA commands - https://pastebin.com/wvRzdTEx
>>>>>> - the output of some BL Tools (sdptool / bluetoothctl / hciconfig) -
>>>>>> https://pastebin.com/Ax7XYr94
>>>>>> - the HCI dump -https://pastebin.com/zqhqKu57
>>>>>>
>>>>>> SCO dump did not managed to get.
>>>>>>
>>>>>> I executed the following steps:
>>>>>> (the steps are marked in the log files too):
>>>>>> - start Blootoothd
>>>>>> - start PulseAudio
>>>>>> - powered on the Bloothooth speaker
>>>>>> - tried to play some audio
>>>>>> $ pacmd list cards
>>>>>> $ pacmd set-card-profile 1 headset_head_unit
>>>>>> $ paplay -v -d bluez_sink.78_44_05_4B_4F_FF.headset_head_unit
>>>>>> /tmp/h2g2.ogg (gets stuck)
>>>>>> $ pacmd set-card-profile 1 a2dp_sink
>>>>>> $ paplay -v -d bluez_sink.78_44_05_4B_4F_FF.a2dp_sink /tmp/h2g2.ogg (works)
>>>>>
>>>>> HSP playback getting stuck is a fairly common problem (affecting
>>>>> multiple bluetooth adapters from different vendors). Solutions for the
>>>>> problem are known for a few adapters, but not this one. The issue is
>>>>> documented here (the "HSP problem: the bluetooth sink and source are
>>>>> created, but no audio is being transmitted" section):
>>>>>
>>>>> https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Bluetooth/#index8h3
>>>>>
>>>>> As you can read there, the underlying problem in the known cases is
>>>>> either that firmware is missing or the SCO audio routing is wrong in
>>>>> the adapter. Changing the routing requires (at least in the known
>>>>> cases) a vendor-specific magic command. I don't know how to figure out
>>>>> the correct command. On one Broadcom chip this does the trick: "hcitool
>>>>> cmd 0x3F 0x01C 0x01 0x02 0x00 0x01 0x01", but I don't know how likely
>>>>> that is to work on a different chip.
>>>>
>>>> I just sent that HCI command right now and guess what, it worked :).
>>>> Both paplay an parecord are working fine with the HSP profile now.
>>>
>>> Awesome! I'll update the wiki page.
>>
>> Ok, Thanks! I posted the solution to the two related GitHub issues +
>> some forums / blog posts, so hope it will reach anyone interested in
>> this.
>
> I would be more interested in someone adding this kind of PCM routing configuration to DT and also adopting the hci_bcm.c driver to use it and send the appropriate commands.

I could take a look on adding the new functionality to hci_bcm.c. I'm
not really familiar with the Linux kernel development, so be aware
that this will take some time.

>
> Sending hcitool cmd is like injecting commands. That is a hack. It is not a solution. So commenting that you need some hcitool to hack the hardware setup, that is just wrong. Get this merged into the driver and have it configurable via DT.

Yes, I know its not the best solution, but it fixes the problem and
this is more important for most of the people, than having the "right"
solution. That's why I posted it to GitHub, etc.

>
> Also if you have a recent enough btmon installed, then it might actually decode the Broadcom commands for you. Can you give it a try and see what it says.
>

Actually, I found a document today with the vendor specific HCI
commands for the Cypress CYW4329/CYW4330 chip
(http://www.cypress.com/file/298311/download). Its not the same chip,
by I guess the commands will be similar for all the Cypress / Broadcom
chips.

According to this document the HCI command
hcitool cmd 0x3F 0x01C 0x01 0x02 0x00 0x01 0x01

translates to:

command = 0x01C (Write_SCO_PCM_Int_Param)
   SCO_Routing = 0x01 (Transport)
   PCM_Interface_Rate = 0x02 (512 KBps)
   Frame_Type = 0x00 (Short)
   Sync_Mode = 0x01 (Master)
   Clock_Mode = 0x01 (Master)

btmon (5.43) does not seems to know to decode the command. It outputs this:

$ sudo btmon -s /org/bluez/hci0
...
@ RAW Open: hcitool (privileged) version 2.22            {0x0003} 16.534966
@ RAW Close: hcitool
{0x0003} 16.534997
@ RAW Open: hcitool (privileged) version 2.22            {0x0003}
[hci0] 16.535043
< HCI Command: Vendor (0x3f|0x001c) plen 5             [hci0] 16.535162
        01 02 00 01 01                                   .....
> HCI Event: Command Complete (0x0e) plen 4          [hci0] 16.535566
      Vendor (0x3f|0x001c) ncmd 1
        Status: Success (0x00)
@ RAW Close: hcitool

> Regards
>
> Marcel
>

Thanks,
Attila
