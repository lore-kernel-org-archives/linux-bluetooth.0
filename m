Return-Path: <SRS0=n6SA=5M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B1FC43331
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 18:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7B920774
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 18:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5INX7Nt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgC0SPy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:15:54 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33461 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgC0SPx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 14:15:53 -0400
Received: by mail-oi1-f194.google.com with SMTP id m14so9647513oic.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2020 11:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pl9F5Vb1NtmsY997Y4dzK/AnJapWg75mnDACOHkQypc=;
        b=l5INX7NtMqiblyUOqtZx/4J8/sq0SzsUKq3vWKOcgA7I3E+gZl7NjjFNWRFF3/fdU+
         YKfLqjiHJXsTHWcmwPKnS6+cMVMy2VXt0PXpt80OL991J1XeP10BBrFYW22Lw8YWnmQ7
         EulTf6doDKo0nWaTt0W++cKAiuiCfuO9cbBfvsjECNPBKz8rKfSwjEaLukbRUSeRf2UJ
         2bM0ndf8G9gfUUjylHWA/TkasB9tRhLHlq+Z+5NOAhph0bVm3YnLXLuVmGrUK3cjKSaS
         GP8HgrSvnXvrsccgi+1Dlx3Gf5P5Vjsz7S36Bg1k9jPNt4QspS16fCM3Uhwb1xdw3zr0
         wOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pl9F5Vb1NtmsY997Y4dzK/AnJapWg75mnDACOHkQypc=;
        b=YKZLTYFDsw364RQAhvfdDpa9vdcfoQ5qdFQRFfKGcAishKyQjTSu1Gh9ZK6h5pXbRk
         dkrv3KqVOV8hJsaEUzstoovPzTorYmB8m04fqi5TolgPiwK+/F3JucyJ/Vx1X15eC1RE
         wmMimC4ZU0C24aHXX/Ow5SfF5CnqngGL5sL0OahGeuyIPY6xbqroSGyws3444pHtnS1p
         8TGZsTekxw+Qbvt8Be1/BGZMbLANVX5lTS7IBG4aP/DnkL4aLupcTseJH1CN3cvj4BZn
         20Lgr6Qy09f+xrEp3KnwE3W5sKsOfA4SSRKQWtmXPBrf7a7wntEJcFGHXyuMmriCUhcA
         l4Iw==
X-Gm-Message-State: ANhLgQ247t5/eCMpb2MECdhN+ZZQp9tkqsSlw791HTMn/7EinHGIoXCI
        KXz2pCF5fK2NEk4upi6cWT1sZ5+Ir8yxZvriURa4tA==
X-Google-Smtp-Source: ADFU+vvc5dFRomJtu35v6QEK2cbP45oiWwAd9HMSUZxjwqC5fFT1QZv3x/tChBdXK/LplGdZItROlNnJCCgGX2SMlrs=
X-Received: by 2002:aca:b602:: with SMTP id g2mr103718oif.82.1585332952899;
 Fri, 27 Mar 2020 11:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200327201817.Bluez.v1.1.If919a39697a6506be273f879d752bd506e63b45b@changeid>
In-Reply-To: <20200327201817.Bluez.v1.1.If919a39697a6506be273f879d752bd506e63b45b@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 27 Mar 2020 11:15:41 -0700
Message-ID: <CABBYNZ+nSx++GMZNEuUKDner+Aa92sjC9e2aSZ8vQE9iMTdoNA@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] shared/att: Check the signature of att packets
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Fri, Mar 27, 2020 at 5:19 AM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> According to bluetooth spec Ver 5.1, Vol 3, Part C (GAP), 10.4.2
> A device receiving signed data shall authenticate it by performing
> the Signing Algorithm. The signed data shall be authenticated by
> performing the Signing Algorithm where m is the Data PDU to be
> authenticated, k is the stored CSRK and the SignCounter is the
> received counter value. If the MAC computed by the Signing
> Algorithm does not match the received MAC, the verification fails
> and the Host shall ignore the received Data PDU.
>
> Currently bluez ignore the signature of received signed att
> packets, as the function bt_crypto_sign_att() only generates the
> signature, and not actually make any check about the genuineness
> of the signature itself.
>
> This patch also fix a wrong boolean condition which prevents
> handle_signed() to be called.
>
> Tested to pass these BT certification test
> SM/MAS/SIGN/BV-03-C
> SM/MAS/SIGN/BI-01-C

Nice catch, looks like we have never passed this test properly before.

> ---
>
>  src/shared/att.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 948a5548b..0faac4d1d 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -886,6 +886,8 @@ static bool handle_signed(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
>  {
>         uint8_t *signature;
>         uint32_t sign_cnt;
> +       uint8_t *copy_pdu = NULL;
> +       uint8_t *generated_signature;
>         struct sign_info *sign;
>
>         /* Check if there is enough data for a signature */
> @@ -903,15 +905,29 @@ static bool handle_signed(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
>         if (!sign->counter(&sign_cnt, sign->user_data))
>                 goto fail;
>
> -       /* Generate signature and verify it */
> -       if (!bt_crypto_sign_att(att->crypto, sign->key, pdu,
> -                               pdu_len - BT_ATT_SIGNATURE_LEN, sign_cnt,
> -                               signature))
> +       /* Generate signature */
> +       copy_pdu = malloc(pdu_len + 1);
> +       if (!copy_pdu)
>                 goto fail;
>
> +       copy_pdu[0] = opcode;
> +       memcpy(copy_pdu + 1, pdu, pdu_len - BT_ATT_SIGNATURE_LEN);
> +       generated_signature = copy_pdu + pdu_len - BT_ATT_SIGNATURE_LEN + 1;
> +
> +       if (!bt_crypto_sign_att(att->crypto, sign->key, copy_pdu,
> +                               pdu_len - BT_ATT_SIGNATURE_LEN + 1, sign_cnt,
> +                               generated_signature))
> +               goto fail;
> +
> +       /* Verify received signature */
> +       if (memcmp(generated_signature, signature, BT_ATT_SIGNATURE_LEN))
> +               goto fail;
>
> +       free(copy_pdu);

While this seems to do a proper check perhaps it is better to have a
helper function in crypto to do that for us, so we can unit test it as
well, also I would consider the possibility of doing the comparison in
place since you don't seem to modify the PDU contents at any point we
just want to compare the signatures match.

>         return true;
>
>  fail:
> +       free(copy_pdu);
>         util_debug(att->debug_callback, att->debug_data,
>                         "ATT failed to verify signature: 0x%02x", opcode);
>
> @@ -925,7 +941,7 @@ static void handle_notify(struct bt_att_chan *chan, uint8_t opcode,
>         const struct queue_entry *entry;
>         bool found;
>
> -       if ((opcode & ATT_OP_SIGNED_MASK) && !att->crypto) {
> +       if ((opcode & ATT_OP_SIGNED_MASK) && att->crypto) {
>                 if (!handle_signed(att, opcode, pdu, pdu_len))
>                         return;
>                 pdu_len -= BT_ATT_SIGNATURE_LEN;
> --
> 2.25.1.696.g5e7596f4ac-goog
>


-- 
Luiz Augusto von Dentz
