Return-Path: <SRS0=77es=5W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAA2C2BA1A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 21:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F3820753
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 21:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJynulQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgDFVOc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:14:32 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34371 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgDFVOc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 17:14:32 -0400
Received: by mail-ot1-f66.google.com with SMTP id m2so938109otr.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2020 14:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WonRw+4ODStzR6anIq5922KAmURvty+C1tiuaqgbIXo=;
        b=pJynulQq3FKQd2FI/LjSkzZ7kQT7z0th/3p4JCtf2+IZL3W4C9rpYmuLrFGAD3+ywl
         Hfrqasn81+X+w+mwg93SxRkUS5pjRGjsxgyzhQVLaUazNo4Su/YGpY1PwJ97EMgpJEBH
         qnNIiPQJDi9zNYUxJf3oMlv1VLH1Rn9casLTXQ0NozSqPrICBbAzlH6H+NZdRK4bgGnX
         Sw23YoC0EMUs5FbhVfMnIVPcB2mEr96DIPg/cJPyJZRmxyILO4ToQPupkW0AtuOlCc+O
         YfoE6jK/7TCE96lgnEaHSeixG5e8YGmU5cJBkgH40TE8U1zcWBqh4RYOqF6gZojIeZsl
         wNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WonRw+4ODStzR6anIq5922KAmURvty+C1tiuaqgbIXo=;
        b=J9WRdPb7LWJPQ9pn04DTjGG6Ace9GotHEiJ0h1b/RiQUayAu8ZOssOcwYr9tGf7rHm
         7qDWdjjn/XNrCV65MAMNMIdjDhujpkq/GDbJVFpCl4OXlZ952WrRJ3SiIdH2LZoJoK+6
         bWsw1dSYhjv0ikVjQeJZG3SZhm4rqQYvsTBWDJNEgKtXuxZWBpfUzMTGJ4nJA84yWEBT
         6BHGmFLfsm+HiGnH04hb1hl8MDBMlUJcqS7VD9zR2/vEdKHjo57qBvmWhNzN56bEVZyk
         PfiKLz2wufLkZicZ64KUQF1WvjBp4xkCTY83C9067zFA7znFDw2WB6oErMM8SYudo662
         JJTg==
X-Gm-Message-State: AGi0PuY9eCfK+1APtIupIsLg63SQ0Hz0znmhAwhB7KNICqJmF85s0aNU
        dhUA+HM28tL+eGpKzh+wUgI7d0wdE66RXbMIsNk=
X-Google-Smtp-Source: APiQypLo65jayM3qm/M2ScstvUWhwHfjGMqtYdA96bta4Owe3bVVQl4n2vPPvD067K174cxjgLIttK1OxizjDOvM1GM=
X-Received: by 2002:a9d:67c6:: with SMTP id c6mr19207142otn.11.1586207671050;
 Mon, 06 Apr 2020 14:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200406114845.255532-1-apusaka@google.com> <20200406194749.Bluez.v3.2.Ieda68013af7fbafbf53fbf7c8fd85ea295153e5e@changeid>
In-Reply-To: <20200406194749.Bluez.v3.2.Ieda68013af7fbafbf53fbf7c8fd85ea295153e5e@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 6 Apr 2020 14:14:19 -0700
Message-ID: <CABBYNZJwQ5e1iULGDnNKaqnmRpXhEJWC=_TUmMFoBepGmzJJBw@mail.gmail.com>
Subject: Re: [Bluez PATCH v3 2/3] unit/test-crypto: test for bt_crypto_verify_att_sign
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
> Adding tests for verifying att signature
>
> ---
>
> Changes in v3:
> - Add unit test
>
> Changes in v2: None
>
>  unit/test-crypto.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>
> diff --git a/unit/test-crypto.c b/unit/test-crypto.c
> index e20b2fa66..3bc944be8 100644
> --- a/unit/test-crypto.c
> +++ b/unit/test-crypto.c
> @@ -272,6 +272,58 @@ static void test_gatt_hash(gconstpointer data)
>         tester_test_passed();
>  }
>
> +struct verify_sign_test_data {
> +       const uint8_t *msg;
> +       uint16_t msg_len;
> +       const uint8_t *key;
> +       bool match;
> +};
> +
> +static const uint8_t msg_to_verify_pass[] = {
> +       0xd2, 0x12, 0x00, 0x13, 0x37, 0x01, 0x00, 0x00, 0x00, 0xF1, 0x87, 0x1E,
> +       0x93, 0x3C, 0x90, 0x0F, 0xf2
> +};
> +
> +static const struct verify_sign_test_data verify_sign_pass_data = {
> +       .msg = msg_to_verify_pass,
> +       .msg_len = sizeof(msg_to_verify_pass),
> +       .key = key_5,
> +       .match = true,
> +};
> +
> +static const uint8_t msg_to_verify_bad_sign[] = {
> +       0xd2, 0x12, 0x00, 0x13, 0x37, 0x01, 0x00, 0x00, 0x00, 0xF1, 0x87, 0x1E,
> +       0x93, 0x3C, 0x90, 0x0F, 0xf1
> +};
> +
> +static const struct verify_sign_test_data verify_sign_bad_sign_data = {
> +       .msg = msg_to_verify_bad_sign,
> +       .msg_len = sizeof(msg_to_verify_bad_sign),
> +       .key = key_5,
> +       .match = false,
> +};
> +
> +static const uint8_t msg_to_verify_too_short[] = {
> +       0xd2, 0x12, 0x00, 0x13, 0x37
> +};
> +
> +static const struct verify_sign_test_data verify_sign_too_short_data = {

These should be msg_to_verify_too_short.

> +       .msg = msg_to_verify_bad_sign,
> +       .msg_len = sizeof(msg_to_verify_bad_sign),
> +       .key = key_5,
> +       .match = false,
> +};
> +
> +static void test_verify_sign(gconstpointer data)
> +{
> +       const struct verify_sign_test_data *d = data;
> +       bool result = bt_crypto_verify_att_sign(crypto, d->key, d->msg,
> +                                               d->msg_len);
> +       g_assert(result == d->match);
> +
> +       tester_test_passed();
> +}
> +
>  int main(int argc, char *argv[])
>  {
>         int exit_status;
> @@ -292,6 +344,13 @@ int main(int argc, char *argv[])
>
>         tester_add("/crypto/gatt_hash", NULL, NULL, test_gatt_hash, NULL);
>
> +       tester_add("/crypto/verify_sign_pass", &verify_sign_pass_data,
> +                                               NULL, test_verify_sign, NULL);
> +       tester_add("/crypto/verify_sign_bad_sign", &verify_sign_bad_sign_data,
> +                                               NULL, test_verify_sign, NULL);
> +       tester_add("/crypto/verify_sign_too_short", &verify_sign_too_short_data,
> +                                               NULL, test_verify_sign, NULL);
> +
>         exit_status = tester_run();
>
>         bt_crypto_unref(crypto);
> --
> 2.26.0.292.g33ef6b2f38-goog
>


-- 
Luiz Augusto von Dentz
