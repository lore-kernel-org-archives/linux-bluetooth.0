Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <1410426586-9075-1-git-send-email-chao.jie.gu@intel.com>
References: <1410426586-9075-1-git-send-email-chao.jie.gu@intel.com>
Date: Thu, 11 Sep 2014 09:22:18 -0700
Message-ID: <CAHrH25RxdmTDMxEYmUm75fJOt-oU5cLibNOhE3UASPhdHoO24A@mail.gmail.com>
Subject: Re: [PATCH] ATT signed write command
From: Arman Uguray <armansito@chromium.org>
To: Gu Chaojie <chao.jie.gu@intel.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chaojie,


> This patch for signing outgoing, csrk and cryto stored in bt_att.
> the verifying incoming ATT PDU implementation introduce the
> shared/gatt-server which combined with shared/gatt-db.c, so need
> more disccussion.
>
> Signed-off-by: Gu Chaojie <chao.jie.gu@intel.com>

I don't think include "Signed-off-by" in commit messages in BlueZ.


> +/* Len of signature in write signed packet */
> +#define BT_ATT_SIGNATURE_LEN           12

Can you spell out "Length of signature" in the comment instead of just "Len"?


> +       bool valid_remote_csrk;
> +       uint8_t remote_csrk[16];
> +       uint32_t remote_sign_cnt;

Can we add these later if they aren't being used yet?


> +       struct bt_att *att = NULL;
> +
> +       if (op->opcode == BT_ATT_OP_SIGNED_WRITE_CMD) {

Actually, instead of checking explicitly for
BT_ATT_OP_SIGNED_WRITE_CMD, it might be better to check if the opcode
has the "signed" bit set in general. (You can use ATT_OP_SIGNED_MASK,
which is defined in this file).


> +               pdu_len += BT_ATT_SIGNATURE_LEN;
> +               att = op->user_data;

I don't think that this code here works. op->user_data refers to user
data provided in bt_att_send and not the bt_att structure. Instead, I
would just add a "struct bt_att *att" field to struct att_send_op and
remove the local variable "att".


> +       }
>
>         if (length && pdu)
>                 pdu_len += length;
> @@ -293,6 +310,16 @@ static bool encode_pdu(struct att_send_op *op, const void *pdu,
>         if (pdu_len > 1)
>                 memcpy(op->pdu + 1, pdu, length);
>
> +       if (att) {
> +               if (!bt_crypto_sign_att(att->crypto,
> +                                       att->local_csrk,
> +                                       op->pdu,
> +                                       1 + length,
> +                                       att->local_sign_cnt,
> +                                       &((uint8_t *) op->pdu)[1 + length]))
> +               return false;
> +       }

You shouldn't have to check if "att" is NULL. "att" should always be
present if struct att_send_op has a field for it.

I would also remove the nested if statement and just return the return
value of bt_crypto_sign_att inline.

Other than that, I don't see how the CSRK is being provided to the
bt_att structure. Shouldn't there be a bt_att_set_csrk of sorts?


Cheers,
Arman
