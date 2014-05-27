Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1400760367-24915-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1400760367-24915-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1400760367-24915-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 27 May 2014 16:40:20 +0300
Message-ID: <CABBYNZ+YbMWEte2u6mi2G5y-eOb==PsOxD0tA0j6GZwxgCyK3g@mail.gmail.com>
Subject: Re: [RFCv0 12/14] android/hal-sco: Fix memory leak
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, May 22, 2014 at 3:06 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Release resampler on exit.
> ---
>  android/hal-sco.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/android/hal-sco.c b/android/hal-sco.c
> index 8635866..bf3b6d4 100644
> --- a/android/hal-sco.c
> +++ b/android/hal-sco.c
> @@ -692,6 +692,8 @@ static int sco_open_output_stream(struct audio_hw_device *dev,
>
>         return 0;
>  failed:
> +       if (out->resampler)
> +               release_resampler(out->resampler);
>         free(out->cache);
>         free(out->downmix_buf);
>         free(out);
> @@ -726,6 +728,9 @@ static void sco_close_output_stream(struct audio_hw_device *dev,
>
>         close_sco_socket();
>
> +       if (out->resampler)
> +               release_resampler(out->resampler);
> +       free(out->resample_buf);
>         free(out->cache);
>         free(out->downmix_buf);
>         free(out);
> --
> 1.8.3.2

Ive pushed just this one, please rebase this set.


-- 
Luiz Augusto von Dentz
