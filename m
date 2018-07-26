Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180725200728.11835-2-2@0x2c.org>
References: <20180725200728.11835-1-2@0x2c.org> <20180725200728.11835-2-2@0x2c.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 26 Jul 2018 11:40:39 +0300
Message-ID: <CABBYNZLDY1g6HuOfqpK=s_2chmCMioDqCP0t8y99+9qhm_iY=A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] input/hog-lib: set notify bit on every connection
To: Simon Schubert <2@0x2c.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Simon,

On Wed, Jul 25, 2018 at 11:07 PM, Simon Schubert <2@0x2c.org> wrote:
> At least the Microsoft Bluetooth Mobile Mouse 3600 does not persist
> the CCC.  To work around this bug, we check and process the CCC like
> we would do for an initial discovery.
> ---
>  profiles/input/hog-lib.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> index d9ed80689..d3439b8ba 100644
> --- a/profiles/input/hog-lib.c
> +++ b/profiles/input/hog-lib.c
> @@ -1610,10 +1610,10 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
>         for (l = hog->reports; l; l = l->next) {
>                 struct report *r = l->data;
>
> -               r->notifyid = g_attrib_register(hog->attrib,
> -                                       ATT_OP_HANDLE_NOTIFY,
> -                                       r->value_handle,
> -                                       report_value_cb, r, NULL);
> +               if (r->type == HOG_REPORT_TYPE_INPUT) {
> +                       read_char(r->hog, r->hog->attrib,
> +                                 r->ccc_handle, ccc_read_cb, r);
> +               }

There is a task to convert bt_hog instance to use bt_gatt_client
instead of GAttrib, that would fix this problem since
bt_gatt_client_register_notify always write to the CCC for the first
subscription.

>         }
>
>         return true;
> --
> 2.18.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
