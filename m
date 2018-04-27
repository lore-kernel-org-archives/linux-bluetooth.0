Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <6E19B1B3-3BFC-45E4-A4F1-52D3ADE47E10@holtmann.org>
References: <87wox5di3k.fsf@mure.haselwarter.org> <5AE870C0-52D4-4EA8-B947-D33AE0662461@holtmann.org>
 <CABBYNZKgcCf3N=gebmzwAPrFNXWd3wTwTVMg=_WYd4GtX0Lt3Q@mail.gmail.com> <6E19B1B3-3BFC-45E4-A4F1-52D3ADE47E10@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 27 Apr 2018 11:04:21 +0300
Message-ID: <CABBYNZJvv_SYGtgBjsTeSHi55H1CgP8PsVMspxYM-yXHavg+bA@mail.gmail.com>
Subject: Re: Low latency options for Bluetooth?
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Philipp Haselwarter <philipp@haselwarter.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Apr 24, 2018 at 10:01 AM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Luiz,
>
>>>> Legacy bluetooth codecs have a latency of ~200 ms or more, which creat=
es
>>>> a noticeable lag when watching videos or during voice calls.
>>>>
>>>> The AptX Low Latency (LL) codec can provide a stable connection with a=
t
>>>> most 40 ms of latency.
>>>>
>>>> - Is there a way to get AptX LL to work on Linux?
>>>> - Are there alternatives for a low latency Bluetooth connection?
>>>
>>> with BlueZ for Android we actually had AptX working (given CSR provided=
 you with a correct binary).
>>
>> There is a pretty old patch for PulseAudio that enables AptX:
>>
>> https://build.tizen.org/package/view_file/Tizen/pulseaudio/0020-add-blue=
tooth-a2dp-aptx-codec-support-samsung.patch?expand=3D1
>>
>> It doesn't have the actual AptX library, which I guess cannot be
>> distributed under the same license. We could perhaps have OPUS (which
>> should perform quite well) instead which should be available in all
>> distros already, that said no headset or phone would support it
>> initially, though it wouldn't be a problem for phones to add support
>> for it since it has been in use in WebRTC, youtube, skype, etc.
>
> actually it seems FFmpeg has an open source aptX encoder and decoder.
>
> https://patchwork.ffmpeg.org/patch/5879/
>
> https://github.com/FFmpeg/FFmpeg/blob/master/libavcodec/aptx.c
>
> So I think someone could extend PA to use FFmpeg=E2=80=99s aptX and just =
enable aptX for all devices.

Interesting, I guess we could do that, most likely it will be hard for
distros since they don't normally ship with libavcodec since other
codecs might not be 'free', but I guess users may be able to install
that by themselves.

--=20
Luiz Augusto von Dentz
