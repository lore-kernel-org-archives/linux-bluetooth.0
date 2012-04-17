Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJ4Oty4iSPyTpBHc7Zsxr+bn66Epq1HoYREwdaDrDCM7Q@mail.gmail.com>
References: <1334127438-27617-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1334127438-27617-4-git-send-email-mikel.astiz.oss@gmail.com>
	<CABBYNZJ4Oty4iSPyTpBHc7Zsxr+bn66Epq1HoYREwdaDrDCM7Q@mail.gmail.com>
Date: Tue, 17 Apr 2012 16:12:37 +0200
Message-ID: <CANT-zCUcavHr5kgF7BisFjwMjh6A+M_-GauCa+FbAajnxpP-LA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v0 3/7] audio: Add multiple device search to manager
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Apr 17, 2012 at 2:20 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Mikel,
>
> On Wed, Apr 11, 2012 at 9:57 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
>> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>> -struct audio_device *manager_find_device(const char *path,
>> +GSList *manager_find_devices(const char *path,
>>                                        const bdaddr_t *src,
>>                                        const bdaddr_t *dst,
>>                                        const char *interface,
>> -                                       gboolean connected)
>> +                                       gboolean connected,
>> +                                       size_t max_count)
>>  {
>
> It doesn't look like this max_count parameter is going to be useful,
> iirc you only use 0 in the patches so I would recommending leaving it
> out for now.

It's actually being used in manager_find_device() with max_count==1,
after the lines from the old function have been moved to
manager_find_devices() to avoid duplicated code.

Cheers,
Mikel
