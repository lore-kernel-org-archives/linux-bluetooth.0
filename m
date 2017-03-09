Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: mSBC codec issue on a headset
To: Juha Kuikka <juha.kuikka@gmail.com>
References: <CAKvrXUrUGtWuOyS0NEajGX8fbJB8xSRCNMCUufu4nXBYje9LyA@mail.gmail.com>
 <ddf3666c-4fc6-f057-2118-65f9b7a4673c@collabora.co.uk>
 <CAKvrXUpkB639-YtY5Zb1ae5wbhvqT=JUNv_7XX-fMpbk5gC0GQ@mail.gmail.com>
 <CAKvrXUoWC+HZbM7XEOmsaGdgOQACf_1okEfhdabZNY2ZJcfrFA@mail.gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
From: =?UTF-8?B?RnLDqWTDqXJpYyBEYWxsZWF1?=
        <frederic.dalleau@collabora.co.uk>
Message-ID: <87f1b9aa-893d-7620-5d11-30e329ac2693@collabora.co.uk>
Date: Thu, 9 Mar 2017 16:59:26 +0100
MIME-Version: 1.0
In-Reply-To: <CAKvrXUoWC+HZbM7XEOmsaGdgOQACf_1okEfhdabZNY2ZJcfrFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Juha,

On 09/03/2017 06:34, Juha Kuikka wrote:
 >>> If it looks like (hear like) small gaps are inserted between 
packets, this
 >>> could indicates timing issues ? If it hear like the audio data are 
wrong,
 >>> this could indicate codec issues.
 >
 > I managed to make a recording of the issue. Don't mind the huge amount

More likely the latter type of issue... But if some headset can decode 
it properly, could be on decoder side.

Have you tried to compare both streams (mtu ? data ?)

atm I can't tell you much more than try to narrow the reproduction data.

Regards,
Fred

