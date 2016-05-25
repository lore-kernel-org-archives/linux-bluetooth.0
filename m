Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPcThSH8ZFNHCfVRWPcJJf=dASSvgBN6ns-tCR3_XX4N88usfw@mail.gmail.com>
References: <CAPcThSH8ZFNHCfVRWPcJJf=dASSvgBN6ns-tCR3_XX4N88usfw@mail.gmail.com>
Date: Wed, 25 May 2016 12:32:07 +0300
Message-ID: <CABBYNZJfsdXcu5f6b6J74NHn1J4Xq=QkyVf6AjjBSrJye9-BRA@mail.gmail.com>
Subject: Re: SelectConfiguration not called by bluez for a bluetooth headset
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Qingtao Cao <qingtao.cao.au@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Harry,

On Wed, May 25, 2016 at 4:13 AM, Qingtao Cao <qingtao.cao.au@gmail.com> wrote:
> Hi Community,
>
> I have two questions about how bluez would invoke the
> SelectConfiguration provided by the registered media endpoint. I am
> using bluez-4.101.
>
> 1. With a bluetooth speaker that supports A2DP, from logs of my
> program manipulating bluez's dbus API I saw bluez had invoked the
> SelectConfiguration method with parameters describing the capability
> of the bluetooth speaker, so that my program could send back bluez a
> dbus message with my preferred settings, e.g., 48k Hz frequency and
> Mono.

SelectConfiguration is only called in case of outgoing connection so
you can select the preferred configuration, for incoming connection
the remote will select the configuration so we can only accept or
reject it.

> However, when I tested with a bluetooth headset that only supports
> HFP/HSP, bluez seems not calling SelectConfiguration, but
> SetConfiguration directly. Furthermore, the "Configuration" in the
> parameters of the SetConfiguration is an empty array:
>
>    object path "/org/bluez/3765/hci1/dev_1C_48_F9_AD_19_EE/fd5"
>    array [
>       dict entry(
>          string "Device"
>          variant             object path
> "/org/bluez/3765/hci1/dev_1C_48_F9_AD_19_EE"
>       )
>       dict entry(
>          string "UUID"
>          variant             string "0000111f-0000-1000-8000-00805f9b34fb"
>       )
>       dict entry(
>          string "Codec"
>          variant             byte 0
>       )
>       dict entry(
>          string "Configuration"
>          variant             array [
>             ]
>       )
>       dict entry(
>          string "NREC"
>          variant             boolean true
>       )
>       dict entry(
>          string "InbandRingtone"
>          variant             boolean true
>       )
>       dict entry(
>          string "Routing"
>          variant             string "HCI"
>       )
>    ]

Hmm Im afraid this is old since we no longer support HSP/HFP
endpoints, the reference implementation of HFP is in ofono which does
have its own interface to setup the audio and pulseaudio has also its
own implementation for HSP.

If you are using ofono these are the interfaces involved:

http://git.kernel.org/cgit/network/ofono/ofono.git/tree/doc/handsfree-audio-api.txt

> I am wondering if this is the reason that makes bluez not calling
> SelectConfiguration for such bluetooth headsetl in the first place,
> since it is not configurable at all.
>
> Please confirm whether this is how bluez works.
>
> Then how can I further know the frequency and the number of channel
> supported by my bluetooth headset? (from my testing with different wav
> files it seems only plays well format of S16_LE, 8kHz, mono)

HFP/HSP should be always mono, and in case of CVSD it is 8 kHZ, only
when using SBC that 16 Khz is used but contrary to A2DP in HFP there
is no codec configuration so these parameter are fixed per codec.

>
> 2. For my bluetooth speaker that is configurable on frequency and the
> number of channel, if I specify a particular configuration, then it
> won't support other wave files with different configurations. For
> example, if I specify the sample rate used by it to be 48k Hz, but I
> play a wav file of 8k Hz instead, then it will be played 6 times
> faster than expected, only a short screaming is heard.

You will need to resample it if the output should be in 48 Khz.

> Moreover, during testing I found that if I specify more than one bit
> for frequency or channel_mode for example in the return message of
> SelectConfiguration, the connection will simply fail.
>
> So, does this mean my program, or the audio server, would have to
> convert the format of sound files to the frequency, channel_mode etc
> used by the remote bluetooth configured through SelectConfiguration
> before playing sound files?

Yes, that is one of the main features of an audio server should deal
with, but instead of reinventing the wheel you could use pulseaudio
since it already takes cares of these details for you.

-- 
Luiz Augusto von Dentz
