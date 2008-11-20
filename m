Return-Path: <cyrus@holtmann.org>
Message-ID: <492539BF.5040303@powercraft.nl>
Date: Thu, 20 Nov 2008 11:19:43 +0100
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: Brad Midgley <bmidgley@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: possible sbc codec bug with audio glitches
References: <4920099A.9030109@powercraft.nl>	 <d89ddf300811160629v29a0602cgdfcf25ade32c4cfc@mail.gmail.com>	 <4920929A.30703@powercraft.nl> <d89ddf300811161715sd0fd511v4371712a27cdd6d3@mail.gmail.com>
In-Reply-To: <d89ddf300811161715sd0fd511v4371712a27cdd6d3@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------020305090808040206010308"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------020305090808040206010308
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Brad Midgley wrote:
> Jelle,
> 
> Everything in the codec is symmetrical between the two channels unless
> using joint stereo mode. In joint stereo, if it saves space, we encode
> the difference between and the sum of the channels instead of the
> individual channel content. It's conceivable that an overflow here
> might be manifest differently between the two channels.
> 
> It looks like you can use a parameter "mode" in the alsa config and
> set it to either "stereo" or "joint"
> 
> If you can narrow down the distortion to one of these cases that would be handy.
> 
> Do you have an mp3 I could try to hear the problem?
> 
> Brad

Thank you Brad for taking the time to answer.

I have tried the mode joint and mode stereo [1] for a few days but I
cant hear any difference and the small glitches are still there.

I posted a small audio segment that has the problem in my first post:
http://sourceforge.net/mailarchive/message.php?msg_name=4819B1A7.2070702%40powercraft.nl
http://filebin.ca/pugrs/glitch.wav

Thanks in advance,

Jelle

> On Sun, Nov 16, 2008 at 2:37 PM, Jelle de Jong
> <jelledejong@powercraft.nl> wrote:
>> Brad Midgley wrote:
>>> Jelle
>>>
>>>> The strange thing is that I can only hear the glitches on the right side
>>>> of the headset.
>>> That is very strange it is only on one side. Do you know if you were
>>> you using the joint stereo setting in the codec?
>>>
>> Thank you Brad for taking the time to read and answer to my question,
>> this is really appreciated. I dont exactly know what you mean with joint
>> stereo settings in the code?
>>
>> I use the bluez git build on 2008-11-06. The only info I got is from the
>> bluetoothd running in debug mode, please see the attachment for more
>> information.
>>
>> I hope the below section is the most relevant?
>>
>> config a2dp - device = 00:0C:55:D1:C9:78 access_mode = 2
>> codec sbc - frequency = 1 channel_mode = 1 allocation = 1 subbands = 1
>> blocks = 1 bitpool = 44
>> a2dp_source_config: selected SEP 0xb81b1020
>> avdtp_ref(0xb81acbf0): ref=3
>> setup_ref(0xb81b62a8): ref=1
>> avdtp_set_configuration(0xb81acbf0): int_seid=1, acp_seid=1
>>
>> Thanks in advance,
>>
>> Jelle

--------------020305090808040206010308
Content-Type: application/x-sh;
 name="setup-bluetooth-motorola-s805.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="setup-bluetooth-motorola-s805.sh"

#!/bin/bash

echo "setup-bluetooth-motorola-s805.sh"

echo 'pcm.headset {
    type bluetooth
    #~ device 00:0D:18:A0:35:70
    #~ device 00:53:53:FB:7E:9C # Nokia BH-801
    device 00:0C:55:D1:C9:78 # Motorola S805
    #~ device 00:0D:FD:18:6E:3C # Motorola S9
    #~ device 20:07:09:15:A9:5A # Samsung WEP210
    profile hifi
    #~ profile voice
    #~ profile auto
    mode stereo
    #~ mode joint
}
pcm.softvol {
    type softvol
    slave.pcm headset
    control.name Headset
    control.card 0
}
pcm.!default {
    #~ type hw
    #~ card 0
    type plug
    slave.pcm softvol
}' > ~/.asoundrc

#~ sudo /etc/init.d/bluetooth restart
#~ sudo /etc/init.d/alsa-utils restart

echo "done, you can close this windows now"

exit

--------------020305090808040206010308--
