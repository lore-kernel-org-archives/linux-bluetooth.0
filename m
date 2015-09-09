Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1441715022-20327-1-git-send-email-luiz.dentz@gmail.com>
References: <1441715022-20327-1-git-send-email-luiz.dentz@gmail.com>
Date: Wed, 9 Sep 2015 14:42:25 +0300
Message-ID: <CABBYNZKFuN6fqztby0c3Pp4ZgrLrLOT_jH8mmhd7LM6DJMYNbQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] shared/gatt-client: Fix not freeing notify data
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 8, 2015 at 3:23 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> notify_data_write_ccc takes another reference in case it succeed so
> the original reference should be dropped to cause the data to be freed
> once notify_data_write_ccc completes.
> ---
>  src/shared/gatt-client.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 903afa7..0983852 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -1596,8 +1596,7 @@ static void complete_unregister_notify(void *data)
>                                                 !notify_data->chrc->ccc_handle)
>                 goto done;
>
> -       if (notify_data_write_ccc(notify_data, false, disable_ccc_callback))
> -               return;
> +       notify_data_write_ccc(notify_data, false, disable_ccc_callback);
>
>  done:
>         notify_data_unref(notify_data);
> --
> 2.4.3

Applied.


-- 
Luiz Augusto von Dentz
