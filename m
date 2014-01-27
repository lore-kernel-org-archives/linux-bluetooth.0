Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1390780546-18402-1-git-send-email-luiz.dentz@gmail.com>
References: <1390780546-18402-1-git-send-email-luiz.dentz@gmail.com>
Date: Sun, 26 Jan 2014 16:20:43 -0800
Message-ID: <CABBYNZK3WhPB4t=dCx3djTgHVGojVcUoauASC_+2ShRPQ=Q8kg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 1/8] android: Add copy of current AVCTP implemention
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sun, Jan 26, 2014 at 3:55 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> These files are not added to any makefile on purpose because they still
> have external dependencies.
> ---
> v2: Fix issues with dependencies in Android, adds proper reject for messages
> that cannot be handled, fix avctp_new not initializing the handlers properly
> and finally fixes using 0 instead of NULL in various places.
> v3: Rebase
>
>  {profiles/audio => android}/avctp.c | 0
>  {profiles/audio => android}/avctp.h | 0
>  2 files changed, 0 insertions(+), 0 deletions(-)
>  copy {profiles/audio => android}/avctp.c (100%)
>  copy {profiles/audio => android}/avctp.h (100%)
>
> diff --git a/profiles/audio/avctp.c b/android/avctp.c
> similarity index 100%
> copy from profiles/audio/avctp.c
> copy to android/avctp.c
> diff --git a/profiles/audio/avctp.h b/android/avctp.h
> similarity index 100%
> copy from profiles/audio/avctp.h
> copy to android/avctp.h
> --
> 1.8.4.2

Pushed.


-- 
Luiz Augusto von Dentz
