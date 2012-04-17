Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334127438-27617-4-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334127438-27617-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1334127438-27617-4-git-send-email-mikel.astiz.oss@gmail.com>
Date: Tue, 17 Apr 2012 15:20:08 +0300
Message-ID: <CABBYNZJ4Oty4iSPyTpBHc7Zsxr+bn66Epq1HoYREwdaDrDCM7Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ v0 3/7] audio: Add multiple device search to manager
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Wed, Apr 11, 2012 at 9:57 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> -struct audio_device *manager_find_device(const char *path,
> +GSList *manager_find_devices(const char *path,
>                                        const bdaddr_t *src,
>                                        const bdaddr_t *dst,
>                                        const char *interface,
> -                                       gboolean connected)
> +                                       gboolean connected,
> +                                       size_t max_count)
>  {

It doesn't look like this max_count parameter is going to be useful,
iirc you only use 0 in the patches so I would recommending leaving it
out for now.

-- 
Luiz Augusto von Dentz
