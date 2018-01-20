Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAu3APYKv3LtaoL5mFOhZET-Vr6GQW8wHRtdX12fTm+SD7CHjA@mail.gmail.com>
References: <CAMoM21GBuUJu=JDOyJc+dgNHccMw=ckwRYtMwJP-j0xuXE-pDQ@mail.gmail.com>
 <CAAu3APYKv3LtaoL5mFOhZET-Vr6GQW8wHRtdX12fTm+SD7CHjA@mail.gmail.com>
From: =?UTF-8?B?VMWRa8OpcyBBdHRpbGE=?= <attitokes@gmail.com>
Date: Sat, 20 Jan 2018 13:44:10 +0200
Message-ID: <CAMoM21E1ZqWfS_C=O2z4tm9xHqbFT8f49fnKw3R=Y7-rY=rh3g@mail.gmail.com>
Subject: Re: Raspberry Pi 3 / BCM43438 + HSP profile + PulseAudio
To: Barry Byford <31baz66@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Barry,

On Sat, Jan 20, 2018 at 12:24 PM, Barry Byford <31baz66@gmail.com> wrote:
> Hello Attila,
>
>
> On 20 January 2018 at 08:35, T=C5=91k=C3=A9s Attila <attitokes@gmail.com>=
 wrote:
>> Hi Everyone,
>>
>> I'm trying to use a Bluetooth speaker with Raspberry Pi 3 in HSP mode
>> with PulseAudio.
>>
>> Based on the information I found on the web (blogs / forums / mailing
>> list archives), apparently, HSP does not really works with the
>> Rasberry Pi's built in BCM43438 chip. I didn't found the exact reason
>> yet. Some people suggest it may be a problem with the BCM43438
>> firmware or with the kernel driver. A2DP, and HSP with USB Bluetooth
>> dongles are reported to be working fine. (The most complete
>> description I found about the problem is:
>> http://youness.net/raspberry-pi/bluetooth-headset-raspberry-pi-3-ad2p-hs=
p)
>>
>> I think it would be useful to get clear picture about the problem. And
>> maybe we could try to fix it.
>
> There is an issue on the Raspberry Pi Foundation/Trading GitHub for
> their Linux kernel source tree:
> https://github.com/raspberrypi/linux/issues/1552
>
>
>> Does anyone managed to figure out what exactly the problem is?
>
> The trail on issue 1552 goes all the way back to Cypress/Broadcom via
> people at Raspberry Pi Trading and has the status of "waiting for
> internal comment" so I suspect they will be the people to ping about
> this.
>
The Wifi and Blootooth are provided by the same BCM43438 chip, but I
have no problem using them together (issue #1552). The issue I
described seems to affect only the HSP audio Bluetooth profile.

While tested the Bluetooth audio (A2DP / HSP) the Wifi was on all the
time (mostly idle). Also, using the A2DP profile I'm able to play
audio even while having 10+Mbps (up or down) traffic on the Wifi.

There are 2 HSP related GitHub issues on the raspberrypi/linux project:
https://github.com/raspberrypi/linux/issues/2229
https://github.com/raspberrypi/linux/issues/1401

, but they does not seem to have clear cause of the problem.

Given that the A2DP profile works fine with BCM43438 and USB dongles
are reported to work with both A2DP and HSP, my guess is that
something gets wrong on the Bluetooth protocol level, either in the
BCM43438 (firmware problem) or in it's driver.

Now, I not sure what would be the steps to investigate a such an
issue. I guess we should get some dumps (HCI + SCO) and try to figure
out were it gets wrong. Also we could try to get some dump while using
a USB dongle and compare with the BCM43438 dumps.

Any ideas?

By the way, can somebody help me getting the SCO dump? Probably, I
should use the scotest tool, but tried a lot of options without
success.

>>
>> I started investigating the issue, but didn't got any result yet. I
>> didn't had too much experience with the Linux's Bluetooth stack, so
>> some help with the further investigation would be useful.
>>
>> ----
>>
>> Bellow are some details of my investigation.
>>
>> Hardware: Raspberry Pi 3 + JBL GO! Bluetooth speaker
>>
>> Kernel: raspberrypi 4.14.14-v7
>> BlueZ: 5.43
>> PulseAudio: 11.1
>>
>> Summary:
>> - BCM43438's driver is sucessfuly loaded, it's firmware is uploaded succ=
essfully
>> - the Bluetooth speaker gets detected and the pairing / connection works=
 fine
>> - PulseAudio detects the speaker as a card
>> - both the headset_head_unit and a2dp_sink profiles are shown by
>> `pacmd list-cards` and can be set with `pacmd set-card-profile`
>> - with the a2dp_sink profile, the audio playback works fine (tested
>> with `paplay`)
>> - with the headset_head_unit profile, `paplay` gets stuck at start a
>> no audio is played (`parecord` does the same)
>>
>> I started booth BlueZ and PulseAudio in debug mode, but found nothing
>> obviuosly wrong (at least for me :P) in the logs. Also did a HCI dump.
>>
>> Linking the following logs (uploaded to PasteBin; they are too long
>> inline them):
>> - the Blootoothd's log - https://pastebin.com/WC17Ze0r
>> - the PlulseAudio's log - https://pastebin.com/jUjqjuhC
>> - the output of the PA commands - https://pastebin.com/wvRzdTEx
>> - the output of some BL Tools (sdptool / bluetoothctl / hciconfig) -
>> https://pastebin.com/Ax7XYr94
>> - the HCI dump -https://pastebin.com/zqhqKu57
>>
>> SCO dump did not managed to get.
>>
>> I executed the following steps:
>> (the steps are marked in the log files too):
>> - start Blootoothd
>> - start PulseAudio
>> - powered on the Bloothooth speaker
>> - tried to play some audio
>> $ pacmd list cards
>> $ pacmd set-card-profile 1 headset_head_unit
>> $ paplay -v -d bluez_sink.78_44_05_4B_4F_FF.headset_head_unit
>> /tmp/h2g2.ogg (gets stuck)
>> $ pacmd set-card-profile 1 a2dp_sink
>> $ paplay -v -d bluez_sink.78_44_05_4B_4F_FF.a2dp_sink /tmp/h2g2.ogg (wor=
ks)
>>
>> Thanks,
>> Attila
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetoot=
h" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Attila
