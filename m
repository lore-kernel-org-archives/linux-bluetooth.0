Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BD2C2BA16
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 08:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B5120730
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 08:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NWjdnvw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgDGIAP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Apr 2020 04:00:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35048 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgDGIAO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Apr 2020 04:00:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so2750536wrx.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2020 01:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G+l2zrYalJ5ySbqwLb7s9D5O0O5WyAzOGXqmDg3bzYA=;
        b=NWjdnvw2EHybDeMapSnf7LPZ6RMvb7yHDiRiHi6kdgqGKg2teLvAG0fFP8VBb030y/
         2Ik03w5ZgfzhimrCmFXJi2HtZED30BLfrJ4DCZWF4ukHN7SOfZCCt9c2/9yGqJ2fJbE9
         Ph/OYBmhAouKytWBlDJ+PUFUzQsViyY3jkL/uH4N1j3deV7P71zAO8jiizGO5qyruX/P
         86oztTTuY85MU2QPnvzrDgCJvzjZB+GrqgteE1YDu4yd2uJ3BU4oW0743XXEBEI7JN5z
         7BSQ8arO8uG3dV+q65kjHpcekfqdNoZfZiQLoxcduqsKeFVzvPI/zDENIoartOFhjJgM
         J+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G+l2zrYalJ5ySbqwLb7s9D5O0O5WyAzOGXqmDg3bzYA=;
        b=Qn/YyVL45BbDv7qknB1/Rjl26eQPp4unu5MK25o1x3nJwk56q2pWRArfwp/lTm7Jl0
         xQmj5n/YW/9iElN/pONAl1aRlPaGzZr6QDYKJvuSlKT9kbuvt85zNGeAUFAR7sTT+JW/
         tX/BxkzDNiSgHfK4J8X++w8ftk6AazMA8gFyTuPNlZdYHg0SBXTbem7YmeyxYA11vblJ
         nMevMizIPhQUFzEjJSZDwbqwb/S47p5t9rZ8960jGJWiQrGTb4MBhTRp7ZvzFNBnwHI+
         dHqnatfDFgcmljBPibju6faP9lPfzbZ51mOKUbtDIokl/c1D8A0LW31kNB82t7SjlrRG
         wnIw==
X-Gm-Message-State: AGi0PuaqQciKhTugEXwmtVOOJEvzfG5h0IsC4nHzLKN24fAHYBorEQov
        5ARFCVaHU1IfyJjVWJSKgrSr0soeORDgO4UyRnmG/g==
X-Google-Smtp-Source: APiQypL9+PC/w4Vlf8Dkgw6ZBCtXsEQY8Ho3mIAkNyHSZcEocjjEWG1WSGLOGM8BrtHlMdy6VEGKAivft6XJIkcg5+o=
X-Received: by 2002:adf:f485:: with SMTP id l5mr1424794wro.58.1586246411094;
 Tue, 07 Apr 2020 01:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200406114845.255532-1-apusaka@google.com> <20200406194749.Bluez.v3.2.Ieda68013af7fbafbf53fbf7c8fd85ea295153e5e@changeid>
 <CABBYNZJwQ5e1iULGDnNKaqnmRpXhEJWC=_TUmMFoBepGmzJJBw@mail.gmail.com>
In-Reply-To: <CABBYNZJwQ5e1iULGDnNKaqnmRpXhEJWC=_TUmMFoBepGmzJJBw@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Tue, 7 Apr 2020 15:59:59 +0800
Message-ID: <CAJQfnxE+ouJ6E=piaOw-GSdKDSYJ7kzVGBiquxW2D4PrTD5ZqQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v3 2/3] unit/test-crypto: test for bt_crypto_verify_att_sign
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thanks, you're correct.

On Tue, 7 Apr 2020 at 05:14, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Mon, Apr 6, 2020 at 4:49 AM Archie Pusaka <apusaka@google.com> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > Adding tests for verifying att signature
> >
> > ---
> >
> > Changes in v3:
> > - Add unit test
> >
> > Changes in v2: None
> >
> >  unit/test-crypto.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> >
> > diff --git a/unit/test-crypto.c b/unit/test-crypto.c
> > index e20b2fa66..3bc944be8 100644
> > --- a/unit/test-crypto.c
> > +++ b/unit/test-crypto.c
> > @@ -272,6 +272,58 @@ static void test_gatt_hash(gconstpointer data)
> >         tester_test_passed();
> >  }
> >
> > +struct verify_sign_test_data {
> > +       const uint8_t *msg;
> > +       uint16_t msg_len;
> > +       const uint8_t *key;
> > +       bool match;
> > +};
> > +
> > +static const uint8_t msg_to_verify_pass[] = {
> > +       0xd2, 0x12, 0x00, 0x13, 0x37, 0x01, 0x00, 0x00, 0x00, 0xF1, 0x87, 0x1E,
> > +       0x93, 0x3C, 0x90, 0x0F, 0xf2
> > +};
> > +
> > +static const struct verify_sign_test_data verify_sign_pass_data = {
> > +       .msg = msg_to_verify_pass,
> > +       .msg_len = sizeof(msg_to_verify_pass),
> > +       .key = key_5,
> > +       .match = true,
> > +};
> > +
> > +static const uint8_t msg_to_verify_bad_sign[] = {
> > +       0xd2, 0x12, 0x00, 0x13, 0x37, 0x01, 0x00, 0x00, 0x00, 0xF1, 0x87, 0x1E,
> > +       0x93, 0x3C, 0x90, 0x0F, 0xf1
> > +};
> > +
> > +static const struct verify_sign_test_data verify_sign_bad_sign_data = {
> > +       .msg = msg_to_verify_bad_sign,
> > +       .msg_len = sizeof(msg_to_verify_bad_sign),
> > +       .key = key_5,
> > +       .match = false,
> > +};
> > +
> > +static const uint8_t msg_to_verify_too_short[] = {
> > +       0xd2, 0x12, 0x00, 0x13, 0x37
> > +};
> > +
> > +static const struct verify_sign_test_data verify_sign_too_short_data = {
>
> These should be msg_to_verify_too_short.
>
> > +       .msg = msg_to_verify_bad_sign,
> > +       .msg_len = sizeof(msg_to_verify_bad_sign),
> > +       .key = key_5,
> > +       .match = false,
> > +};
> > +
> > +static void test_verify_sign(gconstpointer data)
> > +{
> > +       const struct verify_sign_test_data *d = data;
> > +       bool result = bt_crypto_verify_att_sign(crypto, d->key, d->msg,
> > +                                               d->msg_len);
> > +       g_assert(result == d->match);
> > +
> > +       tester_test_passed();
> > +}
> > +
> >  int main(int argc, char *argv[])
> >  {
> >         int exit_status;
> > @@ -292,6 +344,13 @@ int main(int argc, char *argv[])
> >
> >         tester_add("/crypto/gatt_hash", NULL, NULL, test_gatt_hash, NULL);
> >
> > +       tester_add("/crypto/verify_sign_pass", &verify_sign_pass_data,
> > +                                               NULL, test_verify_sign, NULL);
> > +       tester_add("/crypto/verify_sign_bad_sign", &verify_sign_bad_sign_data,
> > +                                               NULL, test_verify_sign, NULL);
> > +       tester_add("/crypto/verify_sign_too_short", &verify_sign_too_short_data,
> > +                                               NULL, test_verify_sign, NULL);
> > +
> >         exit_status = tester_run();
> >
> >         bt_crypto_unref(crypto);
> > --
> > 2.26.0.292.g33ef6b2f38-goog
> >
>
>
> --
> Luiz Augusto von Dentz
