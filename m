Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1428934490-20840-1-git-send-email-gowtham.ab@samsung.com>
References: <1428934490-20840-1-git-send-email-gowtham.ab@samsung.com>
Date: Mon, 13 Apr 2015 18:07:25 +0300
Message-ID: <CABBYNZJSWanVhkngcfnh-_xo6apzxx2MJaf0GGY4Ex89B9KPJg@mail.gmail.com>
Subject: Re: [PATCH] shared/att: Add packed struct definition for err_rsp
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Mon, Apr 13, 2015 at 5:14 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Reused the structure definition (bt_att_pdu_error_rsp) defined in
> att-types.h by removing uint8_t array for sending err rsp pdu.
> ---
>  src/shared/att.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 422cc2c..e0c6d76 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -689,14 +689,13 @@ static bool opcode_match(uint8_t opcode, uint8_t test_opcode)
>
>  static void respond_not_supported(struct bt_att *att, uint8_t opcode)
>  {
> -       uint8_t pdu[4];
> +       struct bt_att_pdu_error_rsp pdu;
>
> -       pdu[0] = opcode;
> -       pdu[1] = 0;
> -       pdu[2] = 0;
> -       pdu[3] = BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
> +       pdu.opcode = opcode;
> +       pdu.handle = 0x0000;
> +       pdu.ecode = BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
>
> -       bt_att_send(att, BT_ATT_OP_ERROR_RSP, pdu, sizeof(pdu), NULL, NULL,
> +       bt_att_send(att, BT_ATT_OP_ERROR_RSP, &pdu, sizeof(pdu), NULL, NULL,
>                                                                         NULL);
>  }
>
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
