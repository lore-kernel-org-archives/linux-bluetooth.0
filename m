Return-Path: <cyrus@holtmann.org>
Message-ID: <502C0656.4050008@ntlworld.com>
Date: Wed, 15 Aug 2012 21:28:06 +0100
From: "alistair.rodger" <alistair.rodger@ntlworld.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: gstreamer a2dpSource plugin
References: <5027DC19.8020505@ntlworld.com> <CABBYNZJTkSf1BFZYge9R5WX7m79=hkDfaENh201EygSdck_yyQ@mail.gmail.com>
In-Reply-To: <CABBYNZJTkSf1BFZYge9R5WX7m79=hkDfaENh201EygSdck_yyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am trying to stream_from_  the device to a local sink.  I am therefore looking for something like;

gst-launch alsasrc device=bluetooth ! sbcdec ! .....
or

gst-launch a2dpsource transport=/org/bluez/{PID}/hci0/dev_AA_BB_CC_DD_EE_FF/fd0 ! sbcdec ! ...

preferably the second option as this would use SBC not PCM.

But to clarify, I have been asked to investigate this as part of a product we are developing.  So I am trying to understand the approach we should take.  As an embedded device we cannot support PulseAudio but instead have been using gstreamer.  I can stream_from_  our device using gstreamer but, I understand, the only way to stream to a device, using the higher quality a2dp sbc codec, is using pulse audio.

There are examples on the web using "gst-launch alsasource device=bluetooth ! ..." but I believe this has been deprecated and can only support the SCO headset profile "low" quality audio.

So what I am trying to determine is;

1) Is there a gstreamer source plugin which would take the audio out of the bluetooth stack and pipe it to the "sbcdec" plugin, from which I can pipe it to something like "alsasink"?
2) is it possible to stream the higher quality audio over alsasrc, or is alsa fundamentally only PCM ?
3) Is our only option to create or commission a gstreamer plugin?  If so what steps should we take to pursue its creation.

Sincerely,
alistair

