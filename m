Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1401979897-6920-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1401979897-6920-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Thu, 5 Jun 2014 17:18:27 +0200
Message-ID: <CAF3PWx1PcCFvr_H1Ru6kLY84FhAED2tjEaU=bjx=kHiPtR90UQ@mail.gmail.com>
Subject: Re: [PATCH] android/hal-audio: Fix memory leak
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On 5 June 2014 16:51, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Fixes clang warning:
> ...
> android/hal-audio.c:484:3: warning: Potential leak of memory pointed to
> by 'preset'
> ...
> ---
>  android/hal-audio.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/android/hal-audio.c b/android/hal-audio.c
> index 439b583..4d3cdb1 100644
> --- a/android/hal-audio.c
> +++ b/android/hal-audio.c
> @@ -482,6 +482,7 @@ static bool open_endpoint(struct audio_endpoint **epp,
>
>         if (!ep) {
>                 error("Cound not find opened endpoint");
> +               free(preset);
>                 return false;
>         }

I'd rather do 'goto failed' here so we also close fd.

BR,
Andrzej
