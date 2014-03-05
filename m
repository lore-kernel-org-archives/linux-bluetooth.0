Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1393965804-13866-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1393965804-13866-1-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Wed, 5 Mar 2014 10:42:21 +0200
Message-ID: <CABBYNZJprM2WzcWotV20z7EzN2VONOxoKR2eqRSQbLOvZtSG8A@mail.gmail.com>
Subject: Re: [PATCH 1/4] android/avrcp: Fix response for RegisterNotification
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Tue, Mar 4, 2014 at 10:43 PM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> ---
>  android/avrcp.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/android/avrcp.c b/android/avrcp.c
> index 8eac4cd..f3427a3 100644
> --- a/android/avrcp.c
> +++ b/android/avrcp.c
> @@ -255,6 +255,7 @@ static void handle_register_notification(const void *buf, uint16_t len)
>         struct avrcp_request *req;
>         uint8_t pdu[IPC_MTU];
>         size_t pdu_len;
> +       uint8_t code;
>         int ret;
>
>         DBG("");
> @@ -280,8 +281,20 @@ static void handle_register_notification(const void *buf, uint16_t len)
>                 goto done;
>         }
>
> +       switch (cmd->type) {
> +       case HAL_AVRCP_EVENT_TYPE_INTERIM:
> +               code = AVC_CTYPE_INTERIM;
> +               break;
> +       case HAL_AVRCP_EVENT_TYPE_CHANGED:
> +               code = AVC_CTYPE_CHANGED;
> +               break;
> +       default:
> +               status = HAL_STATUS_FAILED;
> +               goto done;
> +       }
> +
>         ret = avrcp_register_notification_rsp(req->dev->session,
> -                                               req->transaction, cmd->type,
> +                                               req->transaction, code,
>                                                 pdu, pdu_len);
>         if (ret < 0) {
>                 status = HAL_STATUS_FAILED;
> --
> 1.9.0

Applied, thanks.


-- 
Luiz Augusto von Dentz
