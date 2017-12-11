Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8b962f05-12c2-8bd9-31ca-1700a45bbdae@jp.fujitsu.com>
References: <8b962f05-12c2-8bd9-31ca-1700a45bbdae@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 11 Dec 2017 11:04:22 -0200
Message-ID: <CABBYNZJ1_LU327gefkiooqW9dEQMdPUXHtowKScWvafz6eL3JA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] shared/shell: Fix hidden default menu if no submenu
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Mon, Dec 11, 2017 at 5:13 AM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> Also fixes the output of the default menu in the help command of obexctl.
> ---
>  src/shared/shell.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/src/shared/shell.c b/src/shared/shell.c
> index a4be844b7..f9dbdb194 100644
> --- a/src/shared/shell.c
> +++ b/src/shared/shell.c
> @@ -198,8 +198,9 @@ static void shell_print_menu(void)
>                 /* Skip menu command if not on main menu or if there are no
>                  * submenus.
>                  */
> -               if ((data.menu != data.main && !strcmp(entry->cmd, "menu")) ||
> -                                       queue_isempty(data.submenus))
> +               if (!strcmp(entry->cmd, "menu") &&
> +                       (data.menu != data.main ||
> +                               queue_isempty(data.submenus)))
>                         continue;
>
>                 /* Skip back command if on main menu */
> --
> 2.14.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
