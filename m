Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180404073209.10282-1-szymon.janc@codecoup.pl>
References: <20180404073209.10282-1-szymon.janc@codecoup.pl>
From: Szymon Janc <szymon.janc@codecoup.pl>
Date: Wed, 4 Apr 2018 12:04:54 +0200
Message-ID: <CAAEJBhKLRbWcXZrnSFc-L3j1JnQ+xbpqRxiuAC2czgiXZxoHFw@mail.gmail.com>
Subject: Re: [PATCH] gatt: Fix crash with BR/EDR only adapter
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 4 April 2018 at 09:32, Szymon Janc <szymon.janc@codecoup.pl> wrote:
> adapter->database can be NULL if controller is BR/EDR only or LE was
> disabled. Make btd_gatt_database_restore_svc_chng_ccc accept NULL
> pointer and silently ignore it similiar to rest of btd_gatt_database
> API.
> ---
>  src/gatt-database.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 1cdc72e1b..0ac5b75b0 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -3330,6 +3330,9 @@ void btd_gatt_database_restore_svc_chng_ccc(struct btd_gatt_database *database)
>         uint8_t value[4];
>         uint16_t handle, ccc_handle;
>
> +       if (!database)
> +               return;
> +
>         handle = gatt_db_attribute_get_handle(database->svc_chngd);
>         ccc_handle = gatt_db_attribute_get_handle(database->svc_chngd_ccc);
>
> --
> 2.14.3
>

Applied.

-- 
pozdrawiam
Szymon K. Janc
