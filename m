Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1402039188-8441-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1402038374-8264-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1402039188-8441-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Mon, 9 Jun 2014 15:11:43 +0300
Message-ID: <CABBYNZLsQjsae4gics-Bi6K9-2F0KqG7=h969nQZZLpn-RhTmQ@mail.gmail.com>
Subject: Re: [PATCHv3] android/hal-audio: Fix memory leak
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Jun 6, 2014 at 10:19 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Fixes clang warning:
> ...
> android/hal-audio.c:484:3: warning: Potential leak of memory pointed to
> by 'preset'
> ...
> ---
>  android/hal-audio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/android/hal-audio.c b/android/hal-audio.c
> index 439b583..7a40682 100644
> --- a/android/hal-audio.c
> +++ b/android/hal-audio.c
> @@ -482,7 +482,7 @@ static bool open_endpoint(struct audio_endpoint **epp,
>
>         if (!ep) {
>                 error("Cound not find opened endpoint");
> -               return false;
> +               goto failed;
>         }
>
>         *epp = ep;
> --
> 1.8.3.2

Pushed, thanks.


-- 
Luiz Augusto von Dentz
