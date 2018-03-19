Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <645f8de1-77a5-71d9-ca31-637fcf30c6fa@jp.fujitsu.com>
References: <645f8de1-77a5-71d9-ca31-637fcf30c6fa@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 19 Mar 2018 07:52:29 +0200
Message-ID: <CABBYNZJagFifysKhJ346bWYKQ07UVzaLaNAtsADOGR91bACAww@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] shared/shell: Return NULL if generator error occur
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Mon, Mar 19, 2018 at 6:46 AM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> Explicitly returns NULL if asprintf() fails, since the asprintf(3)
> man-page says that the contents of the first argument are undefined if
> any error occurs.
> ---
>  src/shared/shell.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/src/shared/shell.c b/src/shared/shell.c
> index 0a05b5215..7417e7ab4 100644
> --- a/src/shared/shell.c
> +++ b/src/shared/shell.c
> @@ -643,8 +643,13 @@ static char *cmd_generator(const char *text, int state)
>         }
>
>         cmd = find_cmd(text + strlen(menu->name) + 1, menu->entries, &index);
> -       if (cmd)
> -               asprintf(&cmd, "%s.%s", menu->name, cmd);
> +       if (cmd) {
> +               int err;
> +
> +               err = asprintf(&cmd, "%s.%s", menu->name, cmd);
> +               if (err < 0)
> +                       return NULL;
> +       }
>
>         return cmd;
>  }
> --
> 2.14.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
