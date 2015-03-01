Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1425075685-12571-1-git-send-email-szymon.janc@tieto.com>
References: <1425075685-12571-1-git-send-email-szymon.janc@tieto.com>
Date: Sun, 1 Mar 2015 16:49:18 +0200
Message-ID: <CABBYNZLWFjokCT=kQkOUXGs=9qmthsDyJfoQDvekwRNDh9NcOA@mail.gmail.com>
Subject: Re: [PATCH v2] shared/att: Fix signed write without transparent signing
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Sat, Feb 28, 2015 at 12:21 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> If local key wasn't set by bt_att_set_local_key() assume that signing
> is done by bt_att_send() caller ie. gattrib code.
> ---
>  src/shared/att.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 9787377..90701b0 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -282,10 +282,10 @@ static bool encode_pdu(struct bt_att *att, struct att_send_op *op,
>                                         const void *pdu, uint16_t length)
>  {
>         uint16_t pdu_len = 1;
> -       struct sign_info *sign;
> +       struct sign_info *sign = att->local_sign;
>         uint32_t sign_cnt;
>
> -       if (op->opcode & ATT_OP_SIGNED_MASK)
> +       if (sign && (op->opcode & ATT_OP_SIGNED_MASK))
>                 pdu_len += BT_ATT_SIGNATURE_LEN;
>
>         if (length && pdu)
> @@ -303,13 +303,9 @@ static bool encode_pdu(struct bt_att *att, struct att_send_op *op,
>         if (pdu_len > 1)
>                 memcpy(op->pdu + 1, pdu, length);
>
> -       if (!(op->opcode & ATT_OP_SIGNED_MASK))
> +       if (!sign || !(op->opcode & ATT_OP_SIGNED_MASK))
>                 return true;
>
> -       sign = att->local_sign;
> -       if (!sign)
> -               goto fail;
> -
>         if (!sign->counter(&sign_cnt, sign->user_data))
>                 goto fail;
>
> --
> 1.9.3

Applied, thanks.


-- 
Luiz Augusto von Dentz
