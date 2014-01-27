Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1390838504-25456-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1390838504-25456-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Mon, 27 Jan 2014 11:32:28 -0800
Message-ID: <CABBYNZ+QQ81d7r6o=BbFYXAxxsQRWctGeAcF86OhbBBGK4Temw@mail.gmail.com>
Subject: Re: [PATCH 1/2] unit/avdtp: trivial: Remove empty line
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Jan 27, 2014 at 8:01 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> ---
>  unit/test-avdtp.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
> index 4726c4b..8fe5ce3 100644
> --- a/unit/test-avdtp.c
> +++ b/unit/test-avdtp.c
> @@ -216,7 +216,6 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
>         return TRUE;
>  }
>
> -
>  static struct context *context_new(uint16_t version, uint16_t imtu,
>                                         uint16_t omtu, gconstpointer data)
>  {
> --
> 1.8.3.2

Applied, thanks.


-- 
Luiz Augusto von Dentz
