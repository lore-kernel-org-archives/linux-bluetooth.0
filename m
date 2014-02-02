Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1391092491-21374-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1391092491-21374-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Sun, 2 Feb 2014 08:05:12 -0800
Message-ID: <CABBYNZJvuUn-Y1ROCjBqLB0_9Nr4NNUZGnJ4kH=zJJ2Dio8O4g@mail.gmail.com>
Subject: Re: [PATCH] gitignore: Add unit/avctp to .gitignore
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Jan 30, 2014 at 6:34 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.gitignore b/.gitignore
> index e2b23fc..2210e03 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -110,6 +110,7 @@ unit/test-gobex-header
>  unit/test-gobex-packet
>  unit/test-gobex-transfer
>  unit/test-avdtp
> +unit/test-avctp
>  unit/test-*.log
>  unit/test-*.trs
>
> --
> 1.8.3.2

Applied, thanks.


-- 
Luiz Augusto von Dentz
