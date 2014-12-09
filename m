Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418115110-25335-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1418115110-25335-1-git-send-email-jakub.tyszkowski@tieto.com>
Date: Tue, 9 Dec 2014 12:05:01 +0200
Message-ID: <CABBYNZ+au2U8UPe_0di2R=NHhnCtwXrYfCL=7EeEBZ6cJaq__g@mail.gmail.com>
Subject: Re: [PATCHv2 1/5] shared/att: Handle commands under
 BT_ATT_ALL_REQUESTS op group type
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tue, Dec 9, 2014 at 10:51 AM, Jakub Tyszkowski
<jakub.tyszkowski@tieto.com> wrote:
> This is needed for backward compatibility with gattrib.
> ---
>  src/shared/att.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/src/shared/att.c b/src/shared/att.c
> index ee425d8..3181b36 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -666,8 +666,10 @@ struct notify_data {
>
>  static bool opcode_match(uint8_t opcode, uint8_t test_opcode)
>  {
> -       if (opcode == BT_ATT_ALL_REQUESTS &&
> -                                   get_op_type(test_opcode) == ATT_OP_TYPE_REQ)
> +       enum att_op_type op_type = get_op_type(test_opcode);
> +
> +       if (opcode == BT_ATT_ALL_REQUESTS && (op_type == ATT_OP_TYPE_REQ ||
> +                                               op_type == ATT_OP_TYPE_CMD))
>                 return true;
>
>         return opcode == test_opcode;
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
