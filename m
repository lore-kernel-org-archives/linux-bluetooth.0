Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1425049274-11552-6-git-send-email-szymon.janc@tieto.com>
References: <1425049274-11552-1-git-send-email-szymon.janc@tieto.com>
	<1425049274-11552-6-git-send-email-szymon.janc@tieto.com>
Date: Fri, 27 Feb 2015 07:21:51 -0800
Message-ID: <CAJLTA8gDLn-AkGHfCyye4s_RHL5=pcrMVSFtA4dTac3cHXxoeQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] shared/att: Fix signed write without transparent signing
From: Michael Janssen <jamuraa@google.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Feb 27, 2015 at 7:01 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> If local key wasn't set by bt_att_set_local_key() assume that signing
> is done by bt_att_send() caller ie. gattrib code.
> ---
>  src/shared/att.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 9787377..b20af21 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -308,7 +308,7 @@ static bool encode_pdu(struct bt_att *att, struct att_send_op *op,
>
>         sign = att->local_sign;
>         if (!sign)
> -               goto fail;
> +               true;

This should be 'return true;' I think?

>
>         if (!sign->counter(&sign_cnt, sign->user_data))
>                 goto fail;
> --
> 1.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Michael Janssen
