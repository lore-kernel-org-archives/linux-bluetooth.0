Return-Path: <SRS0=loPc=XL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7447C49ED7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Sep 2019 09:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B018520678
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Sep 2019 09:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlYKvq38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbfIPJaE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Sep 2019 05:30:04 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42492 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbfIPJaE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Sep 2019 05:30:04 -0400
Received: by mail-ot1-f68.google.com with SMTP id c10so34937171otd.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2019 02:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=2ILHQ3gh9dqs9iZfNKKLaLwlgLquHyXR39695I3kLfM=;
        b=PlYKvq38lcRxBo9n8GWgqJ9CVQhTPrJ7hg0njZvXcHUW3TMXUf+O8vf8hXHc5CeLut
         Y8HXwTeiKzPoAr41DqpRZn1rc0RCBObD9sIv9hmwhVSKBoTpc19x/iY8EOMIw2t0+BDI
         sO70hoFkztwGCWCYVlUmi2uzJQ0YsBijJFNqrXfl0rEwmdHHTsJ3J3y5y8Za/oiLjGWX
         lr1jwx8zolowWER26fL69Oo56Rkd6BKm41n37n3jcCWAd45NjaWBfuZUcgTJcZQwD6+p
         4llQVtfPRVGdQJo9gNR4P/dA/s/F4AJ22Rfij12EDbB01L5gieQchWZGT2/KOMb1vaKL
         3dHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=2ILHQ3gh9dqs9iZfNKKLaLwlgLquHyXR39695I3kLfM=;
        b=g+N0X96L4ZN0zussf5PyllwMR6IETtCqEjzdw0I+NNgiBxo/MljNQWYvwZNh/Zvy2/
         jL4wimjl54S8LO1I2n8WIHmdxqPQhokrTYuTP04zrgcDZukCBnzxOGD+Iaj2KpVKGkTm
         BZV21Pq2utCb42t67S6IiP3Hdj745bWdTa8HqHT+uBIZLxooeDaxFzBORTWLVXtVsLuW
         4t8aFZkZ2hr4ih1xFxqNINvjV+E9Wg0cnnZfGokJucj9VXSbapHgcaSwgYF6U9RUDb4n
         /GzP4Efk4HTBrS5yXuUAfaX17rjORJnK3O28axuTrUeNEZeHXUkIFTrT+DU5d5v0Y9GP
         lwoA==
X-Gm-Message-State: APjAAAWI3Dk1VrbScAabvF2kbT7pnzQiuzX98NvwuYAOXlrwMAf/4LqK
        TfegHhYw2U6FFySJKEL9G2ko0RmEGkolwTpu9SUGbgBD
X-Google-Smtp-Source: APXvYqzKbw+n72JEZCe2ZzaoKkHhy9KuXg+vQ/7KZgdmfGXGJwW8dniLdL0r8NY7CL6nRvTDVfUppiVXKFy/l6OgKQw=
X-Received: by 2002:a05:6830:1102:: with SMTP id w2mr7173595otq.146.1568626202127;
 Mon, 16 Sep 2019 02:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190913072345.24118-1-luiz.dentz@gmail.com>
In-Reply-To: <20190913072345.24118-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 16 Sep 2019 12:29:49 +0300
Message-ID: <CABBYNZ+7r5bYDsyOmY17B2hHXM-=meMs6z8k69vP=jPtpQ477w@mail.gmail.com>
Subject: Re: [PATCH BlueZ] monitor: Add proper decoding of LE flowctl mode
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Sep 13, 2019 at 10:23 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This enables decoding LE flowctl mode properly and print out the
> SDU.
> ---
>  monitor/l2cap.c | 65 ++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 53 insertions(+), 12 deletions(-)
>
> diff --git a/monitor/l2cap.c b/monitor/l2cap.c
> index 26719ac5e..ad2499851 100644
> --- a/monitor/l2cap.c
> +++ b/monitor/l2cap.c
> @@ -47,6 +47,14 @@
>  #include "rfcomm.h"
>  #include "bnep.h"
>
> +
> +#define L2CAP_MODE_BASIC               0x00
> +#define L2CAP_MODE_RETRANS             0x01
> +#define L2CAP_MODE_FLOWCTL             0x02
> +#define L2CAP_MODE_ERTM                        0x03
> +#define L2CAP_MODE_STREAMING           0x04
> +#define L2CAP_MODE_LE_FLOWCTL          0x80
> +
>  /* L2CAP Control Field bit masks */
>  #define L2CAP_CTRL_SAR_MASK            0xC000
>  #define L2CAP_CTRL_REQSEQ_MASK         0x3F00
> @@ -102,12 +110,13 @@ struct chan_data {
>         uint8_t  mode;
>         uint8_t  ext_ctrl;
>         uint8_t  seq_num;
> +       uint16_t sdu;
>  };
>
>  static struct chan_data chan_list[MAX_CHAN];
>
> -static void assign_scid(const struct l2cap_frame *frame,
> -                               uint16_t scid, uint16_t psm, uint8_t ctrlid)
> +static void assign_scid(const struct l2cap_frame *frame, uint16_t scid,
> +                       uint16_t psm, uint8_t mode, uint8_t ctrlid)
>  {
>         int i, n = -1;
>         uint8_t seq_num = 1;
> @@ -154,7 +163,7 @@ static void assign_scid(const struct l2cap_frame *frame,
>
>         chan_list[n].psm = psm;
>         chan_list[n].ctrlid = ctrlid;
> -       chan_list[n].mode = 0;
> +       chan_list[n].mode = mode;
>
>         chan_list[n].seq_num = seq_num;
>  }
> @@ -257,6 +266,9 @@ static int get_chan_data_index(const struct l2cap_frame *frame)
>  {
>         int i;
>
> +       if (frame->chan)
> +               return frame->chan;
> +
>         for (i = 0; i < MAX_CHAN; i++) {
>                 if (chan_list[i].index != frame->index &&
>                                         chan_list[i].ctrlid == 0)
> @@ -1091,7 +1103,8 @@ static void sig_conn_req(const struct l2cap_frame *frame)
>         print_psm(pdu->psm);
>         print_cid("Source", pdu->scid);
>
> -       assign_scid(frame, le16_to_cpu(pdu->scid), le16_to_cpu(pdu->psm), 0);
> +       assign_scid(frame, le16_to_cpu(pdu->scid), le16_to_cpu(pdu->psm),
> +                                               L2CAP_MODE_BASIC, 0);
>  }
>
>  static void sig_conn_rsp(const struct l2cap_frame *frame)
> @@ -1220,7 +1233,7 @@ static void sig_create_chan_req(const struct l2cap_frame *frame)
>         print_field("Controller ID: %d", pdu->ctrlid);
>
>         assign_scid(frame, le16_to_cpu(pdu->scid), le16_to_cpu(pdu->psm),
> -                                                               pdu->ctrlid);
> +                                               L2CAP_MODE_BASIC, pdu->ctrlid);
>  }
>
>  static void sig_create_chan_rsp(const struct l2cap_frame *frame)
> @@ -1293,7 +1306,8 @@ static void sig_le_conn_req(const struct l2cap_frame *frame)
>         print_field("MPS: %u", le16_to_cpu(pdu->mps));
>         print_field("Credits: %u", le16_to_cpu(pdu->credits));
>
> -       assign_scid(frame, le16_to_cpu(pdu->scid), le16_to_cpu(pdu->psm), 0);
> +       assign_scid(frame, le16_to_cpu(pdu->scid), le16_to_cpu(pdu->psm),
> +                                               L2CAP_MODE_LE_FLOWCTL, 0);
>  }
>
>  static void sig_le_conn_rsp(const struct l2cap_frame *frame)
> @@ -3015,10 +3029,21 @@ static void smp_packet(uint16_t index, bool in, uint16_t handle,
>         opcode_data->func(&frame);
>  }
>
> +static struct chan_data *get_data(const struct l2cap_frame *frame)
> +{
> +       int i = get_chan_data_index(frame);
> +
> +       if (i < 0)
> +               return NULL;
> +
> +       return &chan_list[i];
> +}
> +
>  void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
>                         uint16_t psm, const void *data, uint16_t size)
>  {
>         struct l2cap_frame frame;
> +       struct chan_data *chan;
>         uint32_t ctrl32 = 0;
>         uint16_t ctrl16 = 0;
>         uint8_t ext_ctrl;
> @@ -3047,7 +3072,27 @@ void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
>                 l2cap_frame_init(&frame, index, in, handle, 0, cid, psm,
>                                                         data, size);
>
> -               if (frame.mode > 0) {
> +               switch (frame.mode) {
> +               case L2CAP_MODE_LE_FLOWCTL:
> +                       chan = get_data(&frame);
> +                       if (!chan->sdu) {
> +                               if (!l2cap_frame_get_le16(&frame, &chan->sdu))
> +                                       return;
> +                       }
> +                       print_indent(6, COLOR_CYAN, "Channel:", "",
> +                                       COLOR_OFF, " %d len %d sdu %d"
> +                                       " [PSM %d mode %d] {chan %d}",
> +                                       cid, size, chan->sdu, frame.psm,
> +                                       frame.mode, frame.chan);
> +                       chan->sdu -= frame.size;
> +                       break;
> +               case L2CAP_MODE_BASIC:
> +                       print_indent(6, COLOR_CYAN, "Channel:", "", COLOR_OFF,
> +                                       " %d len %d [PSM %d mode %d] {chan %d}",
> +                                               cid, size, frame.psm,
> +                                               frame.mode, frame.chan);
> +                       break;
> +               default:
>                         ext_ctrl = get_ext_ctrl(&frame);
>
>                         if (ext_ctrl) {
> @@ -3077,11 +3122,7 @@ void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
>                         }
>
>                         printf("\n");
> -               } else {
> -                       print_indent(6, COLOR_CYAN, "Channel:", "", COLOR_OFF,
> -                                       " %d len %d [PSM %d mode %d] {chan %d}",
> -                                               cid, size, frame.psm,
> -                                               frame.mode, frame.chan);
> +                       break;
>                 }
>
>                 switch (frame.psm) {
> --
> 2.21.0

Pushed.

-- 
Luiz Augusto von Dentz
