Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKvrXUpkB639-YtY5Zb1ae5wbhvqT=JUNv_7XX-fMpbk5gC0GQ@mail.gmail.com>
References: <CAKvrXUrUGtWuOyS0NEajGX8fbJB8xSRCNMCUufu4nXBYje9LyA@mail.gmail.com>
 <ddf3666c-4fc6-f057-2118-65f9b7a4673c@collabora.co.uk> <CAKvrXUpkB639-YtY5Zb1ae5wbhvqT=JUNv_7XX-fMpbk5gC0GQ@mail.gmail.com>
From: Juha Kuikka <juha.kuikka@gmail.com>
Date: Wed, 8 Mar 2017 21:34:34 -0800
Message-ID: <CAKvrXUoWC+HZbM7XEOmsaGdgOQACf_1okEfhdabZNY2ZJcfrFA@mail.gmail.com>
Subject: Re: mSBC codec issue on a headset
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYWxsZWF1?=
        <frederic.dalleau@collabora.co.uk>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Mar 8, 2017 at 4:48 PM, Juha Kuikka <juha.kuikka@gmail.com> wrote:
> On Wed, Mar 8, 2017 at 11:21 AM, Fr=C3=A9d=C3=A9ric Dalleau
> <frederic.dalleau@collabora.co.uk> wrote:
>> Hi Juha,
>>
>>> My problem is that the Jabra headset starts adding noise to the audio
>>> output after a period, while the LG headset works a-ok for prolonged
>>> periods of time.
>>>
>>> My test is about 13s long wave file that is being looped. On Jabra the
>>> noise always starts at about 25s (could be right at the edge of the
>>> loop, hard to tell) and never goes away.
>>
>>
>> Some kind of description of the noise you hear could help.
>
> Certainly. I have been trying to record them off the headset but it is
> proving to be surprisingly difficult.
>
> Best way to describe it is as "sizzling", like fat in a pan.
>
>> If it looks like (hear like) small gaps are inserted between packets, th=
is
>> could indicates timing issues ? If it hear like the audio data are wrong=
,
>> this could indicate codec issues.
>
> I am trying to ascertain which one it is. I certainly have timing
> issues also, they come across as clearer clicks and pops, as I would
> expect, the sizzle is constant.
>
> The clicks and pops I can also hear on the LG headset.
>
> I will try to record it, just seeing the signal should give a good
> idea whether they are frame gaps or something else.
>
> Thanks for your comments!

I managed to make a recording of the issue. Don't mind the huge amount
of office back noise in there.
Original: https://goo.gl/XQK3IL
Looping with issue: https://goo.gl/fBQo5I
The "sizzle" starts at about 25s

Thanks,
- Juha
