Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1421147778-22432-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1421147778-22432-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Tue, 13 Jan 2015 14:14:48 -0200
Message-ID: <CABBYNZKZUU7QarPf5ShaR=yO1h+xoYbzxED68Pt53J8EfHH6cA@mail.gmail.com>
Subject: Re: [PATCH] shared/gatt-client: Fix callback type in struct write_op
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Tue, Jan 13, 2015 at 9:16 AM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> Callback type in struct write_op should be bt_gatt_client_callback_t as
> that type is provided by user in bt_gatt_client_write_value()
> ---
>  src/shared/gatt-client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 3042a6c..8acc752 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -1975,7 +1975,7 @@ bool bt_gatt_client_write_without_response(struct bt_gatt_client *client,
>  }
>
>  struct write_op {
> -       bt_gatt_result_callback_t callback;
> +       bt_gatt_client_callback_t callback;
>         void *user_data;
>         bt_gatt_destroy_func_t destroy;
>  };
> --
> 1.8.4

Applied, thanks.


-- 
Luiz Augusto von Dentz
