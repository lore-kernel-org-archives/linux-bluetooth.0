Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: Low latency options for Bluetooth?
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZKgcCf3N=gebmzwAPrFNXWd3wTwTVMg=_WYd4GtX0Lt3Q@mail.gmail.com>
Date: Tue, 24 Apr 2018 09:01:01 +0200
Cc: Philipp Haselwarter <philipp@haselwarter.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <6E19B1B3-3BFC-45E4-A4F1-52D3ADE47E10@holtmann.org>
References: <87wox5di3k.fsf@mure.haselwarter.org>
 <5AE870C0-52D4-4EA8-B947-D33AE0662461@holtmann.org>
 <CABBYNZKgcCf3N=gebmzwAPrFNXWd3wTwTVMg=_WYd4GtX0Lt3Q@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>>> Legacy bluetooth codecs have a latency of ~200 ms or more, which creates
>>> a noticeable lag when watching videos or during voice calls.
>>> 
>>> The AptX Low Latency (LL) codec can provide a stable connection with at
>>> most 40 ms of latency.
>>> 
>>> - Is there a way to get AptX LL to work on Linux?
>>> - Are there alternatives for a low latency Bluetooth connection?
>> 
>> with BlueZ for Android we actually had AptX working (given CSR provided you with a correct binary).
> 
> There is a pretty old patch for PulseAudio that enables AptX:
> 
> https://build.tizen.org/package/view_file/Tizen/pulseaudio/0020-add-bluetooth-a2dp-aptx-codec-support-samsung.patch?expand=1
> 
> It doesn't have the actual AptX library, which I guess cannot be
> distributed under the same license. We could perhaps have OPUS (which
> should perform quite well) instead which should be available in all
> distros already, that said no headset or phone would support it
> initially, though it wouldn't be a problem for phones to add support
> for it since it has been in use in WebRTC, youtube, skype, etc.

actually it seems FFmpeg has an open source aptX encoder and decoder.

https://patchwork.ffmpeg.org/patch/5879/

https://github.com/FFmpeg/FFmpeg/blob/master/libavcodec/aptx.c

So I think someone could extend PA to use FFmpeg’s aptX and just enable aptX for all devices.

Regards

Marcel

