Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418637547-20848-4-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418637547-20848-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1418637547-20848-4-git-send-email-lukasz.rymanowski@tieto.com>
Date: Mon, 15 Dec 2014 12:25:44 +0200
Message-ID: <CABBYNZKWPJaeLgvpLzvYWggXtQpd84jS-u1mbHrpCww7ijpviw@mail.gmail.com>
Subject: Re: [PATCH 3/5] shared/gatt: Add bt_send_att_with_id functions
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Mon, Dec 15, 2014 at 11:59 AM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> With this patch it is possible to send ATT request with a given id
> request. It might be useful for ATT user for example to keep track of
> the GATT request which requires more then one ATT request e.g. search
> services
> ---
>  src/shared/att.c | 26 ++++++++++++++++++++++++++
>  src/shared/att.h |  6 ++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 2a131e0..f51f893 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -1083,6 +1083,32 @@ static unsigned int send_att(struct bt_att *att, struct att_send_op *op)
>         return op->id;
>  }
>
> +unsigned int bt_att_send_with_id(struct bt_att *att, unsigned int id,
> +                                       uint8_t opcode, const void *pdu,
> +                                       uint16_t length,
> +                                       bt_att_response_func_t callback,
> +                                       void *user_data,
> +                                       bt_att_destroy_func_t destroy)
> +{
> +       struct att_send_op *op;
> +
> +       if (!att || !att->io)
> +               return 0;

I guess we need to check for invalid id here, or we can do the
opposite and let 0 id be used for self assign an id so bt_att_send
could just bt_att_send_with_id so we reuse more code.

> +       op = create_att_send_op(opcode, pdu, length, att->mtu, callback,
> +                                                       user_data, destroy);
> +       if (!op)
> +               return 0;
>
> +       /*
> +        * TODO: Some verification might be needed here. For now we
> +        * believe that user know what he is doing.
> +        */
> +       op->id = id;

I think we should prevent multiple entries using the same id and Im
also not sure why this is not being queue like the rest of operations?

> +       return send_att(att, op);
> +}
> +
>  unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
>                                 const void *pdu, uint16_t length,
>                                 bt_att_response_func_t callback,
> diff --git a/src/shared/att.h b/src/shared/att.h
> index 99b5a5b..1210ddc 100644
> --- a/src/shared/att.h
> +++ b/src/shared/att.h
> @@ -60,6 +60,12 @@ unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
>                                         bt_att_response_func_t callback,
>                                         void *user_data,
>                                         bt_att_destroy_func_t destroy);
> +unsigned int bt_att_send_with_id(struct bt_att *att, unsigned int id,
> +                                       uint8_t opcode, const void *pdu,
> +                                       uint16_t length,
> +                                       bt_att_response_func_t callback,
> +                                       void *user_data,
> +                                       bt_att_destroy_func_t destroy);
>  bool bt_att_cancel(struct bt_att *att, unsigned int id);
>  bool bt_att_cancel_all(struct bt_att *att);
>
> --
> 1.8.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
