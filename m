Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171212124122.10816-1-luiz.dentz@gmail.com>
References: <20171212124122.10816-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 13 Dec 2017 10:28:20 -0200
Message-ID: <CABBYNZJVBWhD3eqD1W91VvqOz_xw4iBdY9v+um0=+x01DDEauw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] shared/shell: Add submenu description
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Dec 12, 2017 at 10:41 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds a field for submenu description.
> ---
>  src/shared/shell.c | 3 ++-
>  src/shared/shell.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/src/shared/shell.c b/src/shared/shell.c
> index 3aa49597c..b4fdf7043 100644
> --- a/src/shared/shell.c
> +++ b/src/shared/shell.c
> @@ -208,7 +208,8 @@ static void shell_print_menu(void)
>                                                 submenu = submenu->next) {
>                         struct bt_shell_menu *menu = submenu->data;
>
> -                       print_submenu(menu->name, "Submenu");
> +                       print_submenu(menu->name, menu->desc ? menu->desc :
> +                                                               "Submenu");
>                 }
>         }
>
> diff --git a/src/shared/shell.h b/src/shared/shell.h
> index 5f86ed61e..8b8b1f634 100644
> --- a/src/shared/shell.h
> +++ b/src/shared/shell.h
> @@ -52,6 +52,7 @@ struct bt_shell_menu_entry {
>
>  struct bt_shell_menu {
>         const char *name;
> +       const char *desc;
>         const struct bt_shell_menu_entry entries[];
>  };
>
> --
> 2.13.6

Applied.


-- 
Luiz Augusto von Dentz
