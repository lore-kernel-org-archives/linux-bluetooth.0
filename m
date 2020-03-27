Return-Path: <SRS0=n6SA=5M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714AFC43331
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 18:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA042083E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 18:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHKnnavS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgC0SRq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:17:46 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35914 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgC0SRq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 14:17:46 -0400
Received: by mail-ot1-f65.google.com with SMTP id l23so10741700otf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2020 11:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dU7khsbzt/YxZEoCJLGaUHtDz1ogMUmIJkBPs5bZnzw=;
        b=bHKnnavS6v0/Mb/T+ihBYENt298KEC97dcPCTnNWxDd7HKwYqx9yeFCmuIxy5Awh+6
         w0CbofJ1Z5to7sErFd3hU7Q3/o91moa1zaobAYtMm9VW3W21Od5HEjLpSp0VJoBKooqN
         y1zwvTNIcvEy7BWE3slhqGk8KAgh9XtH5EWTkwy5Npf8S5GK1hQq5gau3twyyvOLUxFZ
         looAEnMUQRQhC9irDGzeswKr6LyCNM4eWDeRFLEwq0S0n5ocoeHjM2hDSyfZrHLCx143
         RZqxm7GNrzy9uUbOmfu0phU4Z0HvjUIuJ3AKhgM9/mOszZHcnjlplqHl/nRGtKaS9GFK
         YTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dU7khsbzt/YxZEoCJLGaUHtDz1ogMUmIJkBPs5bZnzw=;
        b=kWofMY+hMMoJGrLyyqIMgHKFkUh5Oys8mIR1z+zCxhCSSnIGdZPVaxXjUc6GsVO7jh
         LCXFTP/Srlqoh29UoIFUGqCu4uFZwEdRQ8v5YJxIUNwjkzTbepERz5uzhhG5N1up98gE
         06IboaEWDyW0vwaPOS3WfKTSG+x4P/g7+dFpDwwXtImQ2FxRBX1tU7zCXJd1hN5dAFlC
         7PPLoYhHFVBQ5lEt7pLjt/+7nXtjpMf9gDkDyel7kCrHfevFe+E/66z8quaS/DXo8t9/
         eOcW2vzG7a4FeLWNozLJ/daiBKjse5ki7M48wNaP3RxCb/mai9D0Z5kQ7FFwjqqrkaZD
         tF8A==
X-Gm-Message-State: ANhLgQ3HddN+otnriY0/SISRHSWEWA5i1yEr1/71b91qIOdEqpFnSxde
        FZY3lWgDsBYQiGzHl4r8/skQlfTMF/5CvTK1Fle67g==
X-Google-Smtp-Source: ADFU+vt8oQA9/c2vj/7tDHnGCloFY3Fpqzj/QxoHMSOrsv0VTbng76VrNxWTNIAsTB6zezNNALTgfiBXQtuh7/czCj0=
X-Received: by 2002:a4a:2cc6:: with SMTP id o189mr611397ooo.20.1585333063770;
 Fri, 27 Mar 2020 11:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200327201817.Bluez.v1.1.If919a39697a6506be273f879d752bd506e63b45b@changeid>
 <CABBYNZ+nSx++GMZNEuUKDner+Aa92sjC9e2aSZ8vQE9iMTdoNA@mail.gmail.com>
In-Reply-To: <CABBYNZ+nSx++GMZNEuUKDner+Aa92sjC9e2aSZ8vQE9iMTdoNA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 27 Mar 2020 11:17:32 -0700
Message-ID: <CABBYNZJFnR8Co8EghH+77eMoa90ePGEd6qY4BWgsEnyj0RgEWw@mail.gmail.com>
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

On Fri, Mar 27, 2020 at 11:15 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Fri, Mar 27, 2020 at 5:19 AM Archie Pusaka <apusaka@google.com> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > According to bluetooth spec Ver 5.1, Vol 3, Part C (GAP), 10.4.2
> > A device receiving signed data shall authenticate it by performing
> > the Signing Algorithm. The signed data shall be authenticated by
> > performing the Signing Algorithm where m is the Data PDU to be
> > authenticated, k is the stored CSRK and the SignCounter is the
> > received counter value. If the MAC computed by the Signing
> > Algorithm does not match the received MAC, the verification fails
> > and the Host shall ignore the received Data PDU.
> >
> > Currently bluez ignore the signature of received signed att
> > packets, as the function bt_crypto_sign_att() only generates the
> > signature, and not actually make any check about the genuineness
> > of the signature itself.
> >
> > This patch also fix a wrong boolean condition which prevents
> > handle_signed() to be called.
> >
> > Tested to pass these BT certification test
> > SM/MAS/SIGN/BV-03-C
> > SM/MAS/SIGN/BI-01-C
>
> Nice catch, looks like we have never passed this test properly before.
>
> > ---
> >
> >  src/shared/att.c | 26 +++++++++++++++++++++-----
> >  1 file changed, 21 insertions(+), 5 deletions(-)
> >
> > diff --git a/src/shared/att.c b/src/shared/att.c
> > index 948a5548b..0faac4d1d 100644
> > --- a/src/shared/att.c
> > +++ b/src/shared/att.c
> > @@ -886,6 +886,8 @@ static bool handle_signed(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
> >  {
> >         uint8_t *signature;
> >         uint32_t sign_cnt;
> > +       uint8_t *copy_pdu = NULL;
> > +       uint8_t *generated_signature;
> >         struct sign_info *sign;
> >
> >         /* Check if there is enough data for a signature */
> > @@ -903,15 +905,29 @@ static bool handle_signed(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
> >         if (!sign->counter(&sign_cnt, sign->user_data))
> >                 goto fail;
> >
> > -       /* Generate signature and verify it */
> > -       if (!bt_crypto_sign_att(att->crypto, sign->key, pdu,
> > -                               pdu_len - BT_ATT_SIGNATURE_LEN, sign_cnt,
> > -                               signature))
> > +       /* Generate signature */
> > +       copy_pdu = malloc(pdu_len + 1);
> > +       if (!copy_pdu)
> >                 goto fail;
> >
> > +       copy_pdu[0] = opcode;
> > +       memcpy(copy_pdu + 1, pdu, pdu_len - BT_ATT_SIGNATURE_LEN);
> > +       generated_signature = copy_pdu + pdu_len - BT_ATT_SIGNATURE_LEN + 1;
> > +
> > +       if (!bt_crypto_sign_att(att->crypto, sign->key, copy_pdu,
> > +                               pdu_len - BT_ATT_SIGNATURE_LEN + 1, sign_cnt,
> > +                               generated_signature))
> > +               goto fail;
> > +
> > +       /* Verify received signature */
> > +       if (memcmp(generated_signature, signature, BT_ATT_SIGNATURE_LEN))
> > +               goto fail;
> >
> > +       free(copy_pdu);
>
> While this seems to do a proper check perhaps it is better to have a
> helper function in crypto to do that for us, so we can unit test it as
> well, also I would consider the possibility of doing the comparison in
> place since you don't seem to modify the PDU contents at any point we
> just want to compare the signatures match.

I realize this may not be clear, what I meant is that we don't need a
extra copy of the PDU if its contents is no altered at any point.

> >         return true;
> >
> >  fail:
> > +       free(copy_pdu);
> >         util_debug(att->debug_callback, att->debug_data,
> >                         "ATT failed to verify signature: 0x%02x", opcode);
> >
> > @@ -925,7 +941,7 @@ static void handle_notify(struct bt_att_chan *chan, uint8_t opcode,
> >         const struct queue_entry *entry;
> >         bool found;
> >
> > -       if ((opcode & ATT_OP_SIGNED_MASK) && !att->crypto) {
> > +       if ((opcode & ATT_OP_SIGNED_MASK) && att->crypto) {
> >                 if (!handle_signed(att, opcode, pdu, pdu_len))
> >                         return;
> >                 pdu_len -= BT_ATT_SIGNATURE_LEN;
> > --
> > 2.25.1.696.g5e7596f4ac-goog
> >
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
