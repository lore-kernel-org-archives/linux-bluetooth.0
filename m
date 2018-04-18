Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5AE870C0-52D4-4EA8-B947-D33AE0662461@holtmann.org>
References: <87wox5di3k.fsf@mure.haselwarter.org> <5AE870C0-52D4-4EA8-B947-D33AE0662461@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 18 Apr 2018 14:37:29 +0300
Message-ID: <CABBYNZKgcCf3N=gebmzwAPrFNXWd3wTwTVMg=_WYd4GtX0Lt3Q@mail.gmail.com>
Subject: Re: Low latency options for Bluetooth?
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Philipp Haselwarter <philipp@haselwarter.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, Philipp,

On Wed, Apr 18, 2018 at 9:42 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Philipp,
>
>> Legacy bluetooth codecs have a latency of ~200 ms or more, which creates
>> a noticeable lag when watching videos or during voice calls.
>>
>> The AptX Low Latency (LL) codec can provide a stable connection with at
>> most 40 ms of latency.
>>
>> - Is there a way to get AptX LL to work on Linux?
>> - Are there alternatives for a low latency Bluetooth connection?
>
> with BlueZ for Android we actually had AptX working (given CSR provided you with a correct binary).

There is a pretty old patch for PulseAudio that enables AptX:

https://build.tizen.org/package/view_file/Tizen/pulseaudio/0020-add-bluetooth-a2dp-aptx-codec-support-samsung.patch?expand=1

It doesn't have the actual AptX library, which I guess cannot be
distributed under the same license. We could perhaps have OPUS (which
should perform quite well) instead which should be available in all
distros already, that said no headset or phone would support it
initially, though it wouldn't be a problem for phones to add support
for it since it has been in use in WebRTC, youtube, skype, etc.

> Regards
>
> Marcel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
