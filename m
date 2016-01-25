Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1453664614-16485-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1453664614-16485-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Date: Mon, 25 Jan 2016 11:36:47 +0200
Message-ID: <CABBYNZK97OFQVs88JKUyKpv80PNGd+dcep-xGNWq8v0ZN86LWQ@mail.gmail.com>
Subject: Re: [PATCH] shared/gatt-client: Make read_long_value more robust
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Sun, Jan 24, 2016 at 9:43 PM, Andrzej Kaczmarek
<andrzej.kaczmarek@codecoup.pl> wrote:
> Using "Read Blob Request" on attributes shorter than ATT_MTU - 3 may
> return "Attribute Not Long" error on some values, but at the same time
> it's ok to read this attribute using "Read Request".
>
> Since using "Read Blob Request" as first request when reading long
> characteristic value starting with offset 0 is optional, this patch
> changes read_long_value to start with "Read Request" whenever possible
> to remove need for caller to take care of such error.
>
> Core v4.2, part F, section 1.3.4.4.5:
> If the attribute value has a fixed length that is less than or equal to
> (ATT_MTU - 3) octets in length, then an Error Response can be sent with
> the error code «Attribute Not Long».

Include the spec details as comments to the code.

> ---
>  src/shared/gatt-client.c | 24 +++++++++++----
>  unit/test-gatt.c         | 78 ++++++++++++++++++++++++------------------------
>  2 files changed, 57 insertions(+), 45 deletions(-)
>
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 06ac763..d6b3ad0 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -2156,7 +2156,9 @@ static void read_long_cb(uint8_t opcode, const void *pdu,
>                 goto done;
>         }
>
> -       if (opcode != BT_ATT_OP_READ_BLOB_RSP || (!pdu && length)) {
> +       if ((!op->offset && opcode != BT_ATT_OP_READ_RSP)
> +                       || (op->offset && opcode != BT_ATT_OP_READ_BLOB_RSP)
> +                       || (!pdu && length)) {
>                 success = false;
>                 goto done;
>         }
> @@ -2209,7 +2211,9 @@ unsigned int bt_gatt_client_read_long_value(struct bt_gatt_client *client,
>  {
>         struct request *req;
>         struct read_long_op *op;
> +       uint8_t att_op;
>         uint8_t pdu[4];
> +       uint16_t pdu_len;
>
>         if (!client)
>                 return 0;
> @@ -2233,12 +2237,20 @@ unsigned int bt_gatt_client_read_long_value(struct bt_gatt_client *client,
>         req->destroy = destroy_read_long_op;
>
>         put_le16(value_handle, pdu);
> -       put_le16(offset, pdu + 2);
> +       pdu_len = sizeof(value_handle);
> +
> +       if (op->offset) {
> +               att_op = BT_ATT_OP_READ_BLOB_REQ;
> +               pdu_len += sizeof(op->offset);
> +
> +               put_le16(op->offset, pdu + 2);
> +       } else {
> +               att_op = BT_ATT_OP_READ_REQ;
> +       }
> +
> +       req->att_id = bt_att_send(client->att, att_op, pdu, pdu_len,
> +                                       read_long_cb, req, request_unref);
>
> -       req->att_id = bt_att_send(client->att, BT_ATT_OP_READ_BLOB_REQ,
> -                                                       pdu, sizeof(pdu),
> -                                                       read_long_cb, req,
> -                                                       request_unref);
>         if (!req->att_id) {
>                 op->destroy = NULL;
>                 request_unref(req);

Btw, have you validate this with testing spec and PTS? It seems to
right thing to do but we need to make sure either the spec or PTS
don't expect Read Blob to be used.


-- 
Luiz Augusto von Dentz
