Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1432886959-17508-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1432886959-17508-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 29 May 2015 11:39:01 +0300
Message-ID: <CABBYNZK+AnuQM+EoLDaEwbr4hZnjxjfHy9gGM1bH1PEG-G7faQ@mail.gmail.com>
Subject: Re: [PATCH] shared/att: Fix boolean check in handle_notify()
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, May 29, 2015 at 11:09 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> ext_signed is boolean and shall be checked with logical op.
> ---
>  src/shared/att.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 053aa47..a3d8f89 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -733,7 +733,7 @@ static void handle_notify(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
>         const struct queue_entry *entry;
>         bool found;
>
> -       if (opcode & ATT_OP_SIGNED_MASK & !att->ext_signed) {
> +       if (opcode & ATT_OP_SIGNED_MASK && !att->ext_signed) {

I guess adding (opcode & ATT_OP_SIGNED_MASK) would make this even more clearer.

>                 if (!handle_signed(att, opcode, pdu, pdu_len))
>                         return;
>                 pdu_len -= BT_ATT_SIGNATURE_LEN;
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
