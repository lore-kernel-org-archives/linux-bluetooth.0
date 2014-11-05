Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1415135999-8792-4-git-send-email-jamuraa@chromium.org>
References: <1415135999-8792-1-git-send-email-jamuraa@chromium.org>
	<1415135999-8792-4-git-send-email-jamuraa@chromium.org>
Date: Wed, 5 Nov 2014 16:38:46 +0200
Message-ID: <CABBYNZJvaG6TMgBH94PfBjtOzBAS05SFW5fTj4rE_MwnNocGRQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/4] shared/att: Add support for BT_ATT_ALL_REQUESTS
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Tue, Nov 4, 2014 at 11:19 PM, Michael Janssen <jamuraa@chromium.org> wrote:
> ---
>  src/shared/att-types.h |  3 +++
>  src/shared/att.c       | 11 ++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/src/shared/att-types.h b/src/shared/att-types.h
> index a6b23e4..a042695 100644
> --- a/src/shared/att-types.h
> +++ b/src/shared/att-types.h
> @@ -55,6 +55,9 @@
>  #define BT_ATT_OP_HANDLE_VAL_IND               0x1D
>  #define BT_ATT_OP_HANDLE_VAL_CONF              0x1E
>
> +/* Special opcode for all requests (legacy servers) */
> +#define BT_ATT_ALL_REQUESTS 0xFE

It doesn't seems that 0xFE would be future proof considering the spec says:

The attribute PDU operation code
bit7: Authentication Signature Flag
bit6: Command Flag
bit5-0: Method

In the other hand 0x00 might be safer since the opcodes start with 0x01.

>  /* Error codes for Error response PDU */
>  #define BT_ATT_ERROR_INVALID_HANDLE                    0x01
>  #define BT_ATT_ERROR_READ_NOT_PERMITTED                        0x02
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 6adde22..aa80cef 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -575,6 +575,15 @@ struct notify_data {
>         bool handler_found;
>  };
>
> +static bool opcode_match(uint8_t opcode, uint8_t test_opcode)
> +{
> +       if (opcode == BT_ATT_ALL_REQUESTS &&
> +                                   get_op_type(test_opcode) == ATT_OP_TYPE_REQ)
> +               return true;
> +
> +       return opcode == test_opcode;
> +}
> +
>  static void notify_handler(void *data, void *user_data)
>  {
>         struct att_notify *notify = data;
> @@ -583,7 +592,7 @@ static void notify_handler(void *data, void *user_data)
>         if (notify->removed)
>                 return;
>
> -       if (notify->opcode != not_data->opcode)
> +       if (!opcode_match(notify->opcode, not_data->opcode))
>                 return;
>
>         not_data->handler_found = true;
> --
> 2.1.0.rc2.206.gedb03e5



-- 
Luiz Augusto von Dentz
