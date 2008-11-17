Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300811161715sd0fd511v4371712a27cdd6d3@mail.gmail.com>
Date: Sun, 16 Nov 2008 18:15:00 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "Jelle de Jong" <jelledejong@powercraft.nl>
Subject: Re: possible sbc codec bug with audio glitches
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <4920929A.30703@powercraft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4920099A.9030109@powercraft.nl>
	 <d89ddf300811160629v29a0602cgdfcf25ade32c4cfc@mail.gmail.com>
	 <4920929A.30703@powercraft.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Jelle,

Everything in the codec is symmetrical between the two channels unless
using joint stereo mode. In joint stereo, if it saves space, we encode
the difference between and the sum of the channels instead of the
individual channel content. It's conceivable that an overflow here
might be manifest differently between the two channels.

It looks like you can use a parameter "mode" in the alsa config and
set it to either "stereo" or "joint"

If you can narrow down the distortion to one of these cases that would be handy.

Do you have an mp3 I could try to hear the problem?

Brad

On Sun, Nov 16, 2008 at 2:37 PM, Jelle de Jong
<jelledejong@powercraft.nl> wrote:
> Brad Midgley wrote:
>> Jelle
>>
>>> The strange thing is that I can only hear the glitches on the right side
>>> of the headset.
>>
>> That is very strange it is only on one side. Do you know if you were
>> you using the joint stereo setting in the codec?
>>
>
> Thank you Brad for taking the time to read and answer to my question,
> this is really appreciated. I dont exactly know what you mean with joint
> stereo settings in the code?
>
> I use the bluez git build on 2008-11-06. The only info I got is from the
> bluetoothd running in debug mode, please see the attachment for more
> information.
>
> I hope the below section is the most relevant?
>
> config a2dp - device = 00:0C:55:D1:C9:78 access_mode = 2
> codec sbc - frequency = 1 channel_mode = 1 allocation = 1 subbands = 1
> blocks = 1 bitpool = 44
> a2dp_source_config: selected SEP 0xb81b1020
> avdtp_ref(0xb81acbf0): ref=3
> setup_ref(0xb81b62a8): ref=1
> avdtp_set_configuration(0xb81acbf0): int_seid=1, acp_seid=1
>
> Thanks in advance,
>
> Jelle
>



-- 
Brad Midgley
Senior Architect
Surgeworks
801-272-9800
