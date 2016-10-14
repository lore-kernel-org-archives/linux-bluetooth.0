Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Sebastian Hilbert <sebastian.hilbert@gmx.net>
To: linux-bluetooth@vger.kernel.org
Subject: Re: multiple headsets for voice conference
Date: Fri, 14 Oct 2016 22:57:49 +0200
Message-ID: <1714277.qsBd67Ld2h@basti-thinkpad-t410>
In-Reply-To: <f01abc0e-33c2-b4e8-c513-0951ee58f1a4@mozilla.com>
References: <5473190.yLOflKejXQ@basti-thinkpad-t410> <f01abc0e-33c2-b4e8-c513-0951ee58f1a4@mozilla.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

Am Freitag, 14. Oktober 2016, 22:23:51 CEST schrieben Sie:
>    Hi Sebastian,
> 
>  Newbie here: I have (very briefly) attempted to do something similar
> and it was suggested to me that ofono, which is a higher-level API on
> top of BlueZ, was a better starting point.

There is a lot of confusing information out there on the web. It is hard to 
judge what is current and what is outdated. 

Seems like there were a number of changes over the years. It looks like HFP is 
currently only supported by ofono while HSP is supported by both 

Looks like Pulseaudio is a big part of this.

https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/
Bluetooth/

People seem to recommend JACKaudio for low latency audio

http://wiki.linuxaudio.org/wiki/raspberrypi

In other words I would have to access the headsets without PulseAudio.
There is something called alsa_in/out which potentially takes care of this.

http://jackaudio.org/faq/routing_alsa.html 

Best,
Sebastian
