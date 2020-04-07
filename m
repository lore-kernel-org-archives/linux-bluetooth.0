Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A12C2BA16
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 07:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CC020678
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 07:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f/cvJzs4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgDGHXe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Apr 2020 03:23:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55433 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgDGHXe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Apr 2020 03:23:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id e26so650580wmk.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2020 00:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=moonz0vCzeKsZ7s3C/9s96mvunJbTbFjY/xq+QGQiFU=;
        b=f/cvJzs4hHBo0uRzPwRKSEvoC3stydmbBO9/RHgLtlmVPhWP+nyzfFZdtNIGIbs0EU
         4RzTmbJpyGGvz5+Zkcm5cjQjtpk0iqx6xnNxtz0++n9qrq/+DnkTYiUQeDfeNc7LxN1E
         dZldt5xxuKm3bOvWCFQoJbYur6K1nDaG3kgP3HbXvcGaiBVOtTcDMnmRmHmwefq353Pm
         Fz/oUMXEo1Ber8wmEvc02lfsL5W4LjBFZMszN/NuTvN3SKckC8Cn9BFuEGqvAUx6IkMO
         o+MhXQc0kIW5j8dIYSFfqMVbpZy9uHgLsgdBpbCTaM+yVonbKx96PvVrv4yBcLSrx7Lu
         8Bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=moonz0vCzeKsZ7s3C/9s96mvunJbTbFjY/xq+QGQiFU=;
        b=VP/6fQEgLWvVAE4nj2g3A3iG5bIJTyle82sZWAKaZJEc8wa8BPBN5rpyPaIoa4VEBJ
         KBgM0m05p+UWIFvrsIS4EjICDKgZNGrMKmx7hTRoeZqwld/Pm+qlk9q7oypESISqLUd8
         LgXxpXGa8tH6TfiQHKEokew5xjZVwW993eOeVc0YQ+myJ50nPBrjwty8EVlnSUpC/MWh
         UiqIO8xAmeJAl42DJw7F3UnetkWrPAzpxo9iDeqjL+4falX2L8mF0poSCTw8KhLkChR5
         xVvm0jDlOSmtXAPxzVrV34T9jAtoHTX56NsvPeAKKWmEG7JuXHPa3Lm6+NRcSoawgaMx
         DfSw==
X-Gm-Message-State: AGi0PubTEkIV9Xvu/2TNGODg2Opi5ml4NTI5i1HtANe/SrnJ0HkUdS6C
        waUFR8F5J7rkjtdr7QqVgi3k6glkH6gabto6XxKg1g==
X-Google-Smtp-Source: APiQypJJCBr/QdiZctbyfqbli6folQ5xucscgNUTCUQGhjmpQvO9tnS7X+9HKD5wlLZrUV23UpXtvLNNNaieWvcuiTs=
X-Received: by 2002:a1c:5f56:: with SMTP id t83mr862533wmb.61.1586244211840;
 Tue, 07 Apr 2020 00:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200406114845.255532-1-apusaka@google.com> <20200406194749.Bluez.v3.3.I28a54f18ca82b58e44689a0c76663e735fefb6f1@changeid>
 <CABBYNZJh9O8xcyqXZYKtq9uV=UvSwf8GZBocKVzeh5Wtu2cSDg@mail.gmail.com>
In-Reply-To: <CABBYNZJh9O8xcyqXZYKtq9uV=UvSwf8GZBocKVzeh5Wtu2cSDg@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Tue, 7 Apr 2020 15:23:20 +0800
Message-ID: <CAJQfnxHX2AnbKLQto_m89AsoKutp=Z6oBPL7UfOSFEPBrstu2Q@mail.gmail.com>
Subject: Re: [Bluez PATCH v3 3/3] shared/att: Check the signature of att packets
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

The reason test-gatt.c is stuck is because there exists a test which
sends pdu with opcode = 0xBF, an invalid opcode, to test the
robustness of the system of an invalid request.
By applying the patch, instead of replying to the pdu, we silently
ignore it, which makes the test stuck.
The opcode has the "signed" bit (0x80) on and "command" bit (0x40)
off, which makes it in a difficult situation where it shouldn't be
possible and as far as I know is not explicitly discussed in the spec.

I shall fall back to this part from the BT spec, vol 3. Part C section 10.4.2:
"A device receiving signed data shall authenticate it by performing
the Signing Algorithm. If the MAC computed by the Signing Algorithm
does not match the received MAC, the verification fails and the Host
shall ignore the received Data PDU."

Therefore, I shall modify the failing test, and add another case which
is just "invalid request" but without the signed bit.

Thanks,
Archie

On Tue, 7 Apr 2020 at 05:16, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Mon, Apr 6, 2020 at 4:49 AM Archie Pusaka <apusaka@google.com> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > Tested to pass these BT certification test
> > SM/MAS/SIGN/BV-03-C
> > SM/MAS/SIGN/BI-01-C
> >
> > ---
> >
> > Changes in v3:
> > - Separate into three patches
> >
> > Changes in v2:
> > - Move the signature verification part to crypto.c
> > - Attempt not to copy the whole pdu while verifying the signature
> >   by not separating the opcode from the rest of pdu too early, so
> >   we don't have to rejoin them later.
> >
> >  src/shared/att.c | 25 ++++++++++++-------------
> >  1 file changed, 12 insertions(+), 13 deletions(-)
> >
> > diff --git a/src/shared/att.c b/src/shared/att.c
> > index 948a5548b..31c6901fb 100644
> > --- a/src/shared/att.c
> > +++ b/src/shared/att.c
> > @@ -881,15 +881,15 @@ static void respond_not_supported(struct bt_att *att, uint8_t opcode)
> >                                                                         NULL);
> >  }
> >
> > -static bool handle_signed(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
> > -                                                               ssize_t pdu_len)
> > +static bool handle_signed(struct bt_att *att, uint8_t *pdu, ssize_t pdu_len)
> >  {
> >         uint8_t *signature;
> >         uint32_t sign_cnt;
> >         struct sign_info *sign;
> > +       uint8_t opcode = pdu[0];
> >
> >         /* Check if there is enough data for a signature */
> > -       if (pdu_len < 2 + BT_ATT_SIGNATURE_LEN)
> > +       if (pdu_len < 3 + BT_ATT_SIGNATURE_LEN)
> >                 goto fail;
> >
> >         sign = att->remote_sign;
> > @@ -903,10 +903,8 @@ static bool handle_signed(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
> >         if (!sign->counter(&sign_cnt, sign->user_data))
> >                 goto fail;
> >
> > -       /* Generate signature and verify it */
> > -       if (!bt_crypto_sign_att(att->crypto, sign->key, pdu,
> > -                               pdu_len - BT_ATT_SIGNATURE_LEN, sign_cnt,
> > -                               signature))
> > +       /* Verify received signature */
> > +       if (!bt_crypto_verify_att_sign(att->crypto, sign->key, pdu, pdu_len))
> >                 goto fail;
> >
> >         return true;
> > @@ -918,15 +916,16 @@ fail:
> >         return false;
> >  }
> >
> > -static void handle_notify(struct bt_att_chan *chan, uint8_t opcode,
> > -                                               uint8_t *pdu, ssize_t pdu_len)
> > +static void handle_notify(struct bt_att_chan *chan, uint8_t *pdu,
> > +                                                       ssize_t pdu_len)
> >  {
> >         struct bt_att *att = chan->att;
> >         const struct queue_entry *entry;
> >         bool found;
> > +       uint8_t opcode = pdu[0];
> >
> > -       if ((opcode & ATT_OP_SIGNED_MASK) && !att->crypto) {
> > -               if (!handle_signed(att, opcode, pdu, pdu_len))
> > +       if ((opcode & ATT_OP_SIGNED_MASK) && att->crypto) {
> > +               if (!handle_signed(att, pdu, pdu_len))
> >                         return;
> >                 pdu_len -= BT_ATT_SIGNATURE_LEN;
> >         }
> > @@ -963,7 +962,7 @@ static void handle_notify(struct bt_att_chan *chan, uint8_t opcode,
> >                 found = true;
> >
> >                 if (notify->callback)
> > -                       notify->callback(chan, opcode, pdu, pdu_len,
> > +                       notify->callback(chan, opcode, pdu + 1, pdu_len - 1,
> >                                                         notify->user_data);
> >
> >                 /* callback could remove all entries from notify list */
> > @@ -1054,7 +1053,7 @@ static bool can_read_data(struct io *io, void *user_data)
> >                 util_debug(att->debug_callback, att->debug_data,
> >                                         "(chan %p) ATT PDU received: 0x%02x",
> >                                         chan, opcode);
> > -               handle_notify(chan, opcode, pdu + 1, bytes_read - 1);
> > +               handle_notify(chan, pdu, bytes_read);
> >                 break;
> >         }
> >
> > --
> > 2.26.0.292.g33ef6b2f38-goog
>
> This actually make unit/test-gatt get stuck for some reason, so you
> will need to investigate and make it work with existing tests or fix
> the tests if there are actually not conforming to the spec.
>
> --
> Luiz Augusto von Dentz
