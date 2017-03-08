Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: mSBC codec issue on a headset
To: Juha Kuikka <juha.kuikka@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>
References: <CAKvrXUrUGtWuOyS0NEajGX8fbJB8xSRCNMCUufu4nXBYje9LyA@mail.gmail.com>
From: =?UTF-8?B?RnLDqWTDqXJpYyBEYWxsZWF1?=
        <frederic.dalleau@collabora.co.uk>
Message-ID: <ddf3666c-4fc6-f057-2118-65f9b7a4673c@collabora.co.uk>
Date: Wed, 8 Mar 2017 20:21:42 +0100
MIME-Version: 1.0
In-Reply-To: <CAKvrXUrUGtWuOyS0NEajGX8fbJB8xSRCNMCUufu4nXBYje9LyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Juha,

> My problem is that the Jabra headset starts adding noise to the audio
> output after a period, while the LG headset works a-ok for prolonged
> periods of time.
>
> My test is about 13s long wave file that is being looped. On Jabra the
> noise always starts at about 25s (could be right at the edge of the
> loop, hard to tell) and never goes away.

Some kind of description of the noise you hear could help.

If it looks like (hear like) small gaps are inserted between packets, 
this could indicates timing issues ? If it hear like the audio data are 
wrong, this could indicate codec issues.

Regards,
Fred
