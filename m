Return-Path: <SRS0=uVZl=3N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4444C35246
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jan 2020 23:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5FD22072C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jan 2020 23:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ass6p3yA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387648AbgAXXVC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Jan 2020 18:21:02 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38530 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387576AbgAXXUo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Jan 2020 18:20:44 -0500
Received: by mail-ot1-f68.google.com with SMTP id z9so3270394oth.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2020 15:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JtxRF3Zk0kOTgDAqE1w4gcMYUcK7mha/O7fgVytm8F4=;
        b=ass6p3yAW175wM2DtKLoACs8Hz8/w2ylflUiiCPHtoIxQ40QDxuMTdaLFMkSaEh1Zm
         p7JwJ+Vara55Kal27q3aPv8c1d9oglaTEJ46mWplUgW/j6AI3cTzBeGF2NVMZy9stnKM
         s2jluTNC1tq/yHYh6Vqd6FwNZ0G2e5Q7sq7HkZIXm3An9zHn+P3rEL8ej++DG5HcV9sN
         15gQ+DTFCKhKnYyiTvMPuIgJK5SsBuhnCWJTUXy8ONfdXQLSbQeMB1XkM0i0b+XA+vFe
         ShZqcEOQWwE2buxRE6N5msAYpMcX+gKRybubhDrM6tIPGTdJcuR9tA1Rz9FgqBDv4Loe
         xDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JtxRF3Zk0kOTgDAqE1w4gcMYUcK7mha/O7fgVytm8F4=;
        b=svqZdEe0ZMPMVUomSHFot0s/nPrEHC8+YzIIeQ8zvAS9cvu6TqF+P93qOoSHA/TNz8
         3lREnVd/PT5+lxHYt71ESuftvFsrSn/9b8hsLPBMx+oNgh2h5QNYWt2UHoBdvp753buN
         g1xgYk8nH8HsZpLMC/NbTjzLE1hrV3Ajqqyq/NN4AHjOmYKpORKzxVqhWLv8m+cM68qa
         I47jY/JvgQuwTy8XHEkWMUb8dbn/so5PnNMB08Ir6HUEHnakwikziFXdtFzGfUKBZVYM
         uCiQdxvy8pdYnXdoHKaXjS5EtAoV9aBW6q30d5intAIi+w5l5sDeW/AGTI+GnBFwvSSi
         ZBVQ==
X-Gm-Message-State: APjAAAW8k+m6SW3n5Q3T8cEH219/OX3/PtwGloFg9Tsb1daL/RFQdPbl
        s9Jz43xjLbvajSZwIzlKNsW+SqDAF/JCh6wiAKk+XlNa
X-Google-Smtp-Source: APXvYqxCEhl2C1tqMlWrT3jpw0lOJW2BNQiCWHNVmus1ME1MRQG6k7vusVQl5LRSV/VjcWfYwGnGOOu57yvD9ByIBpo=
X-Received: by 2002:a9d:5542:: with SMTP id h2mr4237226oti.146.1579908043520;
 Fri, 24 Jan 2020 15:20:43 -0800 (PST)
MIME-Version: 1.0
References: <20200122151924.32697-1-roland.ruckerbauer@robart.cc>
In-Reply-To: <20200122151924.32697-1-roland.ruckerbauer@robart.cc>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 24 Jan 2020 15:20:31 -0800
Message-ID: <CABBYNZ+ZP796CbLo6+uttBEbdTHD1BUEVdwm-5rCX=U7vvBB_A@mail.gmail.com>
Subject: Re: [PATCH] Fixed bug in prep_write_cb(): missing arguments
To:     Roland Ruckerbauer <roland.ruckerbauer@robart.cc>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Roland,

On Wed, Jan 22, 2020 at 7:31 AM Roland Ruckerbauer
<roland.ruckerbauer@robart.cc> wrote:
>
> prep_write_cb() calls gatt_db_attribure_write(), but does not pass data
> and data length.
>
> Fixed by passing pdu as data, and skipping the first 4 bytes.
> ---
>  src/shared/gatt-server.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> index 0d9bb07..a235552 100644
> --- a/src/shared/gatt-server.c
> +++ b/src/shared/gatt-server.c
> @@ -1312,7 +1312,7 @@ static void prep_write_cb(uint8_t opcode, const void *pdu,
>         pwcd->length = length;
>         pwcd->server = server;
>
> -       status = gatt_db_attribute_write(attr, offset, NULL, 0,
> +       status = gatt_db_attribute_write(attr, offset, pdu + 4, length - 4,
>                                                 BT_ATT_OP_PREP_WRITE_REQ,
>                                                 server->att,
>                                                 prep_write_complete_cb, pwcd);
> --
> 2.19.1

I recall having similar discussion not long ago, not sure it was you
though, but if I recall this correct prepare is not actually suppose
to write anything until we receive execute so this write is mostly to
let the application authorize or not the prepare (which is kind dumb
if you ask me but there are qualification tests requiring a specific
error like that.)


-- 
Luiz Augusto von Dentz
