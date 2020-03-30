Return-Path: <SRS0=mSPA=5P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4215AC43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 08:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EFD20748
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 08:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dihsC9h3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgC3Izn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:55:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38271 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729595AbgC3Izn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 04:55:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id f6so14351534wmj.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2020 01:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3DoqjDacwN8qODbiTh/rSDoI68rYdGTSKTiICX8Foy4=;
        b=dihsC9h3bbDlEevuwkBujW58HhdnK6cbbyAnhJq/ZpkEPL57EenP3lbT1VywnHEISJ
         7fqDX+8EViapACw7SARGvPSa7lKeacWYWdIEfW3CEetX5Cm/DNzamf4bc/LdxgR44Dcx
         F6B7f1pJJWU1EUjm5QGR4DBAk+07IrKfP3J4a9cQ02L9ZmWyOT3bYZLv8K55vgHC/F1F
         r1D691eyLA5hkONxtmzWxEGKW6qPN9nfBVJoELCklyiAzPtViNLTevgSZdlhIsBzNU8P
         Ff86lXACWBYPjpX4qkBXomD/ikYYd8dKHvM1uyD8C2qtRck5pJaqCeEZBy6JZgSUDgJK
         0TnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3DoqjDacwN8qODbiTh/rSDoI68rYdGTSKTiICX8Foy4=;
        b=Gy4wUS3p8ABOCbYmdWnMHfwqyp/iXtZ7N+UR11xKlsXyisbFup+6tFWp7LYSUVZPj7
         1QTx6hsMDMwhN/YT/jy0F+AYB2+2faH334/XCoSmJC3zTWOJrHc9913QcgkClIioikx4
         kjzP62+GA+Gw8wTyI6Ror7TAbWwHnlZwQoVF5aTKrbJK4/xp1RvwYtjCp5CuTTnZTGlJ
         yLZr+91NBPD8wAvDMnR/ktL8Kr9iOGokBY3Z9Lj0GFmh/OtD7E96mNJlr3/CLvxWcsua
         gTACaM3SPRlJO4xJOfkboN1DDOOlHcnVmVTd+IF0BF9/0D1WbzeypZ3G1esBqyRl/Rwi
         1thQ==
X-Gm-Message-State: ANhLgQ1OtV9lMJl8lXFuu6DGWVWho4y20DV5I7UZmy8yr5VhRgewI6r+
        dxiHvH4Pi0lTDdHyGjM8v1SftTBdBtntZEpxTf20dz6EhgA=
X-Google-Smtp-Source: ADFU+vuQMkg/akjFkfQsJAov4rPOp51/FvN34XrcLw+5kKXa9Vf0qknpzHFmY3INpy3b5RE05hioxxR5HG3pN0+WUN8=
X-Received: by 2002:a1c:456:: with SMTP id 83mr12122582wme.54.1585558541142;
 Mon, 30 Mar 2020 01:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200327201817.Bluez.v1.1.If919a39697a6506be273f879d752bd506e63b45b@changeid>
 <CABBYNZ+nSx++GMZNEuUKDner+Aa92sjC9e2aSZ8vQE9iMTdoNA@mail.gmail.com> <CABBYNZJFnR8Co8EghH+77eMoa90ePGEd6qY4BWgsEnyj0RgEWw@mail.gmail.com>
In-Reply-To: <CABBYNZJFnR8Co8EghH+77eMoa90ePGEd6qY4BWgsEnyj0RgEWw@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Mon, 30 Mar 2020 16:55:30 +0800
Message-ID: <CAJQfnxHNCNFbaiju0HCsYF4LkWmgxNFtfxhxHtHa9v5En97+dg@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] shared/att: Check the signature of att packets
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

I will move the whole check to crypto.c.

The problem with generating the signature without copying the pdu is,
the function to generate the signature requires the opcode to be
prepended to the pdu. Therefore, I make a copy of the pdu just for the
sake to prepend the opcode to it.

However, the opcode was actually prepended to the pdu in the first
place, but we separate it when invoking handle_notify(). Because this
function is local to only this file, I will change it so the opcode is
not separated when entering handle_notify(), but we will do so for
every other function that is called within handle_notify().

Thanks,
Archie

On Sat, 28 Mar 2020 at 02:17, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Fri, Mar 27, 2020 at 11:15 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Archie,
> >
> > On Fri, Mar 27, 2020 at 5:19 AM Archie Pusaka <apusaka@google.com> wrote:
> > >
> > > From: Archie Pusaka <apusaka@chromium.org>
> > >
> > > According to bluetooth spec Ver 5.1, Vol 3, Part C (GAP), 10.4.2
> > > A device receiving signed data shall authenticate it by performing
> > > the Signing Algorithm. The signed data shall be authenticated by
> > > performing the Signing Algorithm where m is the Data PDU to be
> > > authenticated, k is the stored CSRK and the SignCounter is the
> > > received counter value. If the MAC computed by the Signing
> > > Algorithm does not match the received MAC, the verification fails
> > > and the Host shall ignore the received Data PDU.
> > >
> > > Currently bluez ignore the signature of received signed att
> > > packets, as the function bt_crypto_sign_att() only generates the
> > > signature, and not actually make any check about the genuineness
> > > of the signature itself.
> > >
> > > This patch also fix a wrong boolean condition which prevents
> > > handle_signed() to be called.
> > >
> > > Tested to pass these BT certification test
> > > SM/MAS/SIGN/BV-03-C
> > > SM/MAS/SIGN/BI-01-C
> >
> > Nice catch, looks like we have never passed this test properly before.
> >
> > > ---
> > >
> > >  src/shared/att.c | 26 +++++++++++++++++++++-----
> > >  1 file changed, 21 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/src/shared/att.c b/src/shared/att.c
> > > index 948a5548b..0faac4d1d 100644
> > > --- a/src/shared/att.c
> > > +++ b/src/shared/att.c
> > > @@ -886,6 +886,8 @@ static bool handle_signed(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
> > >  {
> > >         uint8_t *signature;
> > >         uint32_t sign_cnt;
> > > +       uint8_t *copy_pdu = NULL;
> > > +       uint8_t *generated_signature;
> > >         struct sign_info *sign;
> > >
> > >         /* Check if there is enough data for a signature */
> > > @@ -903,15 +905,29 @@ static bool handle_signed(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
> > >         if (!sign->counter(&sign_cnt, sign->user_data))
> > >                 goto fail;
> > >
> > > -       /* Generate signature and verify it */
> > > -       if (!bt_crypto_sign_att(att->crypto, sign->key, pdu,
> > > -                               pdu_len - BT_ATT_SIGNATURE_LEN, sign_cnt,
> > > -                               signature))
> > > +       /* Generate signature */
> > > +       copy_pdu = malloc(pdu_len + 1);
> > > +       if (!copy_pdu)
> > >                 goto fail;
> > >
> > > +       copy_pdu[0] = opcode;
> > > +       memcpy(copy_pdu + 1, pdu, pdu_len - BT_ATT_SIGNATURE_LEN);
> > > +       generated_signature = copy_pdu + pdu_len - BT_ATT_SIGNATURE_LEN + 1;
> > > +
> > > +       if (!bt_crypto_sign_att(att->crypto, sign->key, copy_pdu,
> > > +                               pdu_len - BT_ATT_SIGNATURE_LEN + 1, sign_cnt,
> > > +                               generated_signature))
> > > +               goto fail;
> > > +
> > > +       /* Verify received signature */
> > > +       if (memcmp(generated_signature, signature, BT_ATT_SIGNATURE_LEN))
> > > +               goto fail;
> > >
> > > +       free(copy_pdu);
> >
> > While this seems to do a proper check perhaps it is better to have a
> > helper function in crypto to do that for us, so we can unit test it as
> > well, also I would consider the possibility of doing the comparison in
> > place since you don't seem to modify the PDU contents at any point we
> > just want to compare the signatures match.
>
> I realize this may not be clear, what I meant is that we don't need a
> extra copy of the PDU if its contents is no altered at any point.
>
> > >         return true;
> > >
> > >  fail:
> > > +       free(copy_pdu);
> > >         util_debug(att->debug_callback, att->debug_data,
> > >                         "ATT failed to verify signature: 0x%02x", opcode);
> > >
> > > @@ -925,7 +941,7 @@ static void handle_notify(struct bt_att_chan *chan, uint8_t opcode,
> > >         const struct queue_entry *entry;
> > >         bool found;
> > >
> > > -       if ((opcode & ATT_OP_SIGNED_MASK) && !att->crypto) {
> > > +       if ((opcode & ATT_OP_SIGNED_MASK) && att->crypto) {
> > >                 if (!handle_signed(att, opcode, pdu, pdu_len))
> > >                         return;
> > >                 pdu_len -= BT_ATT_SIGNATURE_LEN;
> > > --
> > > 2.25.1.696.g5e7596f4ac-goog
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
