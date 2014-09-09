Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1409926365-6436-1-git-send-email-gowtham.ab@samsung.com>
References: <1409926365-6436-1-git-send-email-gowtham.ab@samsung.com>
Date: Tue, 9 Sep 2014 11:49:49 +0300
Message-ID: <CABBYNZKQNjiep=A_6t-GGU5jEreYt4FVbSmsSvqQZ9xinq2QBQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] android/audio_utils/resampler : Fix the null pointer dereference.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: gowtham babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>, p.sinha@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Sep 5, 2014 at 5:12 PM, gowtham babu <gowtham.ab@samsung.com> wrote:
> Checks for NULL.
> ---
>  android/audio_utils/resampler.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/android/audio_utils/resampler.c b/android/audio_utils/resampler.c
> index ce30375..f845e2c 100644
> --- a/android/audio_utils/resampler.c
> +++ b/android/audio_utils/resampler.c
> @@ -50,8 +50,10 @@ static void resampler_reset(struct resampler_itfe *resampler)
>  {
>      struct resampler *rsmp = (struct resampler *)resampler;
>
> -    rsmp->frames_in = 0;
> -    rsmp->frames_rq = 0;
> +    if(rsmp != NULL) {
> +       rsmp->frames_in = 0;
> +       rsmp->frames_rq = 0;
> +    }
>
>      if (rsmp != NULL && rsmp->speex_resampler != NULL) {
>          speex_resampler_reset_mem(rsmp->speex_resampler);
> --
> 1.9.1

Im afraid this was copied from Android so I would not bother with it
except if you want to send the patch to Android itself.


-- 
Luiz Augusto von Dentz
