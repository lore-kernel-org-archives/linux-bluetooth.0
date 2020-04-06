Return-Path: <SRS0=77es=5W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8049FC2BA1A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 21:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B082072A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 21:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9y6cEzy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgDFVQl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:16:41 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42793 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgDFVQk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 17:16:40 -0400
Received: by mail-ot1-f66.google.com with SMTP id z5so884711oth.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2020 14:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9haxKpv3Q4soKfEJDsc7nSsp5tGkaU8qWHy5l/AUsEU=;
        b=m9y6cEzy/ELEjXJxGmv/bgiJq7MRdRJwb1nlL3hwRJ4cbYcZXTppVk3hc0HAoIYY1q
         dy9Hhw6JuXhcpZJEIHCY7H794djTRqPWliT3L2yskabvtR/rd0sLnlZZ/MHAAdbQiXkR
         SVg7/x7WYdyNE1nh3tppRzmoF4kgRkXWZcP8ylK6AD7GUc94Hs56o6veyjkcm3YKcUOv
         2YRrot9KRX/I5QCBscxuZiLWW1b2zSf4U0vO4NUcvi72qJUkpDcCrrhZwfxz3ebxN4xK
         EVoN4bEbUopNIS5CyZ9zLA6aCLuzyseP1pfAi4g1SVdyJh8gvdk1U/5Gf9xeNbwkwB5d
         hmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9haxKpv3Q4soKfEJDsc7nSsp5tGkaU8qWHy5l/AUsEU=;
        b=b9RkzVb5gYacz8wONphL2aCaSRKI8SPGakuFEMZyAkhwZsAu5w/uGvRKiUR1ZKpTf/
         xiTiszpBEcpASYJN/aUAspGATCXDRCcfuYH4q/iK1rqZFUFfGNGioP9+pgS2adbflx1A
         wUD8XNGcR+LJQC7dwZNEcyrgBMt7v6xaRQSQdxkEAaCOfJSUDNLYia03T7k0pq1NbQOD
         WKOUVZmzRp4I9+Ndf+NrIXkG72WGLuIKHPujdS/RSIYLkit08ty2m0k5pX3LFzsiopuf
         CA2BkN0xWwKBnP5Xmj+kCnyjByYKqRgDg3bZP/miodUEOwDMkg+tv4Ax0RIBKT4p+k4M
         Ko6w==
X-Gm-Message-State: AGi0PuZHon6eFbSLblHCCqj7/4gbYjop1YHp5M/ZAkC831dtwysLS61m
        cmvrLwEwE7ozIQk/XmAed9VJpFRwh3+5fB8r9dM=
X-Google-Smtp-Source: APiQypLxuzeyHN2hhIRdgtXDcCbsIUoj82fOJlcI/WmYpd8CzZQbc5LQRt7yZBtaZ+m3RfJpcpLd/Ifv5cGCX1UC5XE=
X-Received: by 2002:a05:6830:19c7:: with SMTP id p7mr20311729otp.79.1586207797871;
 Mon, 06 Apr 2020 14:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200406114845.255532-1-apusaka@google.com> <20200406194749.Bluez.v3.3.I28a54f18ca82b58e44689a0c76663e735fefb6f1@changeid>
In-Reply-To: <20200406194749.Bluez.v3.3.I28a54f18ca82b58e44689a0c76663e735fefb6f1@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 6 Apr 2020 14:16:26 -0700
Message-ID: <CABBYNZJh9O8xcyqXZYKtq9uV=UvSwf8GZBocKVzeh5Wtu2cSDg@mail.gmail.com>
Subject: Re: [Bluez PATCH v3 3/3] shared/att: Check the signature of att packets
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Mon, Apr 6, 2020 at 4:49 AM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> Tested to pass these BT certification test
> SM/MAS/SIGN/BV-03-C
> SM/MAS/SIGN/BI-01-C
>
> ---
>
> Changes in v3:
> - Separate into three patches
>
> Changes in v2:
> - Move the signature verification part to crypto.c
> - Attempt not to copy the whole pdu while verifying the signature
>   by not separating the opcode from the rest of pdu too early, so
>   we don't have to rejoin them later.
>
>  src/shared/att.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 948a5548b..31c6901fb 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -881,15 +881,15 @@ static void respond_not_supported(struct bt_att *att, uint8_t opcode)
>                                                                         NULL);
>  }
>
> -static bool handle_signed(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
> -                                                               ssize_t pdu_len)
> +static bool handle_signed(struct bt_att *att, uint8_t *pdu, ssize_t pdu_len)
>  {
>         uint8_t *signature;
>         uint32_t sign_cnt;
>         struct sign_info *sign;
> +       uint8_t opcode = pdu[0];
>
>         /* Check if there is enough data for a signature */
> -       if (pdu_len < 2 + BT_ATT_SIGNATURE_LEN)
> +       if (pdu_len < 3 + BT_ATT_SIGNATURE_LEN)
>                 goto fail;
>
>         sign = att->remote_sign;
> @@ -903,10 +903,8 @@ static bool handle_signed(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
>         if (!sign->counter(&sign_cnt, sign->user_data))
>                 goto fail;
>
> -       /* Generate signature and verify it */
> -       if (!bt_crypto_sign_att(att->crypto, sign->key, pdu,
> -                               pdu_len - BT_ATT_SIGNATURE_LEN, sign_cnt,
> -                               signature))
> +       /* Verify received signature */
> +       if (!bt_crypto_verify_att_sign(att->crypto, sign->key, pdu, pdu_len))
>                 goto fail;
>
>         return true;
> @@ -918,15 +916,16 @@ fail:
>         return false;
>  }
>
> -static void handle_notify(struct bt_att_chan *chan, uint8_t opcode,
> -                                               uint8_t *pdu, ssize_t pdu_len)
> +static void handle_notify(struct bt_att_chan *chan, uint8_t *pdu,
> +                                                       ssize_t pdu_len)
>  {
>         struct bt_att *att = chan->att;
>         const struct queue_entry *entry;
>         bool found;
> +       uint8_t opcode = pdu[0];
>
> -       if ((opcode & ATT_OP_SIGNED_MASK) && !att->crypto) {
> -               if (!handle_signed(att, opcode, pdu, pdu_len))
> +       if ((opcode & ATT_OP_SIGNED_MASK) && att->crypto) {
> +               if (!handle_signed(att, pdu, pdu_len))
>                         return;
>                 pdu_len -= BT_ATT_SIGNATURE_LEN;
>         }
> @@ -963,7 +962,7 @@ static void handle_notify(struct bt_att_chan *chan, uint8_t opcode,
>                 found = true;
>
>                 if (notify->callback)
> -                       notify->callback(chan, opcode, pdu, pdu_len,
> +                       notify->callback(chan, opcode, pdu + 1, pdu_len - 1,
>                                                         notify->user_data);
>
>                 /* callback could remove all entries from notify list */
> @@ -1054,7 +1053,7 @@ static bool can_read_data(struct io *io, void *user_data)
>                 util_debug(att->debug_callback, att->debug_data,
>                                         "(chan %p) ATT PDU received: 0x%02x",
>                                         chan, opcode);
> -               handle_notify(chan, opcode, pdu + 1, bytes_read - 1);
> +               handle_notify(chan, pdu, bytes_read);
>                 break;
>         }
>
> --
> 2.26.0.292.g33ef6b2f38-goog

This actually make unit/test-gatt get stuck for some reason, so you
will need to investigate and make it work with existing tests or fix
the tests if there are actually not conforming to the spec.

-- 
Luiz Augusto von Dentz
