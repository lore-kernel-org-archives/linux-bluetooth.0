Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B61C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 21:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83D3B611AE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 21:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhJMVkZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Oct 2021 17:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhJMVkY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Oct 2021 17:40:24 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B746C061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 14:38:21 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id e2so7420105uax.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 14:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FyH9RmIzG4YX4jNe5NXGI749bARheOagvQaZWj2xWz4=;
        b=YRcGX9YFODpzFbKHKzM1dVvCqSNbrKETKpVA6KbaXy7qnyToQ1h7cLjdh4q7u192HC
         6/dq23h2UcCU8bzCzFqzmAK2YBKhSJ5IL4IFv5pvw239lLAVFm2sUvtLhTxrWj0tMQDZ
         +jSWxEF5L8ExxWPAmAC7KbpYYJ0LORd9aiFEM4RKCn0dTjfCUbiOIavkJ0eWs1fYJ5kt
         IG1zgphGgW6bac6yiuGONpKr9QpJ457AeZ7zne0fLKkHkzh9rVoOeMz2UlFQbUkTx9N5
         lqxx7hwseYJH9x3IFuBe8emE+NJsl/sA8Xq/0Mrn/OlMuhKlBr1T2gdn1tWTE7TvS4iI
         S2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FyH9RmIzG4YX4jNe5NXGI749bARheOagvQaZWj2xWz4=;
        b=jcSFupVRkFL9POFpS5uQwU+oTh65rkZH5DVi0n3olT7t3KCMbu5RmlkPZ29d9pPxjM
         lA8U5fLigIA2NKN7cFFfYVZMfeNCPQ5VjSDmERhox5s18p1OZgSdYlZqAnLC8N4ADPea
         UvAi4DdKmR41mEz2FUVSwrkXIg8v8BWKpAz3/Prm8gGdCcjDnFhWE3T4MpS74wKYL3HD
         uHTeuDoaj2D8XUyzr3XM6TWoihdrml84dxlF/MJ/7MoUIRAsVhGjzrd+P2meHKj+iT6P
         mGDuNpNRlmNh/42dtDqgl6S8ClbjvyLecwSyVPg2OhQ+TIBe/KBQ6FTUbAMitp44F68p
         pg/g==
X-Gm-Message-State: AOAM533rtgs+8iMzM20DRHWpT2ToDzdfjSEuq5FLhZdjt5qPYSpruX3J
        dWQrdnzbfXJOwS2xLifPfiVk2Tx02t5CrEX8V88cnfA0
X-Google-Smtp-Source: ABdhPJyj58wmKzcQwN4YzHr2u0MwTCNeZlccK6YwkhwnT8sY8egi4Ty+HLnSB8Iib2QANMOrBezOlNaLgtYzZVxc1Ds=
X-Received: by 2002:ab0:29da:: with SMTP id i26mr2117236uaq.129.1634161100355;
 Wed, 13 Oct 2021 14:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211008190023.15462-1-bernie@allthenticate.net> <CABBYNZLx8HCO3f6+NsPaAUVKSshdiPM_eEq2qK82mkwno-1pkw@mail.gmail.com>
In-Reply-To: <CABBYNZLx8HCO3f6+NsPaAUVKSshdiPM_eEq2qK82mkwno-1pkw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 13 Oct 2021 14:38:09 -0700
Message-ID: <CABBYNZ+G+kHrkjZkCt6+A31eM_84VEghtnGSWYcBFPauXr4+Hg@mail.gmail.com>
Subject: Re: [BlueZ v2] gatt: more fixes with cleanup on disconnect/timeout
To:     Bernie Conrad <bernie@allthenticate.net>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Bernie Conrad <bernie@allthenticate.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bernie,

On Fri, Oct 8, 2021 at 12:24 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Bernie,
>
> On Fri, Oct 8, 2021 at 12:01 PM Bernie Conrad <bernie@allthenticate.net> wrote:
> >
> > From: Bernie Conrad <bernie@allthenticate.com>
> >
> > The changes in gatt-database.c fix a use after free that was introduced
> > after the last cleanup patch, ccc_new and write_new operations were not
> > being properly unregistered because they were not assigned a disconn_id.
> >
> > The changes in gatt-db add similar cleanup to pending reads/writes where
> > timeouts after a disconnect would cause a similar use after free with
> > already cleaned up resoureces, this adds a simple cb to set on a pending
> > read/write if a disconnect has occurred to skip the use.
> >
> > v2: Fixing formatting issues
> >
> > ---
> >  src/gatt-database.c  |  4 ++--
> >  src/shared/gatt-db.c | 38 ++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 38 insertions(+), 4 deletions(-)
> >
> > diff --git a/src/gatt-database.c b/src/gatt-database.c
> > index 475e7873c..00647cf08 100644
> > --- a/src/gatt-database.c
> > +++ b/src/gatt-database.c
> > @@ -978,7 +978,7 @@ static struct pending_op *pending_ccc_new(struct bt_att *att,
> >         op->attrib = attrib;
> >         op->link_type = link_type;
> >
> > -       bt_att_register_disconnect(att,
> > +       op->disconn_id = bt_att_register_disconnect(att,
> >                                    pending_disconnect_cb,
> >                                    op,
> >                                    NULL);
> > @@ -2418,7 +2418,7 @@ static struct pending_op *pending_write_new(struct bt_att *att,
> >         op->prep_authorize = prep_authorize;
> >         queue_push_tail(owner_queue, op);
> >
> > -       bt_att_register_disconnect(att,
> > +       op->disconn_id = bt_att_register_disconnect(att,
> >                             pending_disconnect_cb,
> >                             op, NULL);
>
> These changes above shall be split into another patch.
>
> > diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> > index 3a02289ce..8423961f8 100644
> > --- a/src/shared/gatt-db.c
> > +++ b/src/shared/gatt-db.c
> > @@ -77,17 +77,23 @@ struct attribute_notify {
> >
> >  struct pending_read {
> >         struct gatt_db_attribute *attrib;
> > +       struct bt_att *att;
> >         unsigned int id;
> >         unsigned int timeout_id;
> >         gatt_db_attribute_read_t func;
> > +       bool disconn;
> > +       unsigned int disconn_id;
> >         void *user_data;
> >  };
> >
> >  struct pending_write {
> >         struct gatt_db_attribute *attrib;
> > +       struct bt_att *att;
> >         unsigned int id;
> >         unsigned int timeout_id;
> >         gatt_db_attribute_write_t func;
> > +       bool disconn;
> > +       unsigned int disconn_id;
> >         void *user_data;
> >  };
> >
> > @@ -139,8 +145,10 @@ static void pending_read_result(struct pending_read *p, int err,
> >         if (p->timeout_id > 0)
> >                 timeout_remove(p->timeout_id);
> >
> > -       p->func(p->attrib, err, data, length, p->user_data);
> > +       if (!p->disconn)
> > +               p->func(p->attrib, err, data, length, p->user_data);
> >
> > +       bt_att_unregister_disconnect(p->att, p->disconn_id);
> >         free(p);
> >  }
> >
> > @@ -156,8 +164,10 @@ static void pending_write_result(struct pending_write *p, int err)
> >         if (p->timeout_id > 0)
> >                 timeout_remove(p->timeout_id);
> >
> > -       p->func(p->attrib, err, p->user_data);
> > +       if (!p->disconn)
> > +               p->func(p->attrib, err, p->user_data);
> >
> > +       bt_att_unregister_disconnect(p->att, p->disconn_id);
> >         free(p);
> >  }
>
> I wonder if it wouldn't be better to use a specific error to inform it
> the operation has been aborted e.g. -ECONNABORTED instead of
> duplicating the handling of disconnection, btw if we don't call the
> callback who is doing the cleanup in gatt-server.c, we still need to
> call async_read_op_destroy/async_write_op_destroy or that is taken
> care somewhere else?
>
> Also it would be great if we had a test in unit/test-gatt.c that
> covers such scenarios, e.g disconnect while read/write is pending.

Is there something not clear about the direction given here, or they
are understood but you still haven't had time to work on them?

> > @@ -1868,6 +1878,13 @@ bool gatt_db_attribute_set_fixed_length(struct gatt_db_attribute *attrib,
> >         return true;
> >  }
> >
> > +static void pending_read_cb(int err, void *user_data)
> > +{
> > +       struct pending_read *p = user_data;
> > +
> > +       p->disconn = 1;
> > +}
> > +
> >  bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
> >                                 uint8_t opcode, struct bt_att *att,
> >                                 gatt_db_attribute_read_t func, void *user_data)
> > @@ -1901,6 +1918,11 @@ bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
> >                 p->func = func;
> >                 p->user_data = user_data;
> >
> > +               p->disconn = 0;
> > +               p->disconn_id = bt_att_register_disconnect(att,
> > +                                       pending_read_cb, p, NULL);
> > +               p->att = att;
> > +
> >                 queue_push_tail(attrib->pending_reads, p);
> >
> >                 attrib->read_func(attrib, p->id, offset, opcode, att,
> > @@ -1956,6 +1978,13 @@ static bool write_timeout(void *user_data)
> >         return false;
> >  }
> >
> > +static void pending_write_cb(int err, void *user_data)
> > +{
> > +       struct pending_write *p = user_data;
> > +
> > +       p->disconn = 1;
> > +}
> > +
> >  bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
> >                                         const uint8_t *value, size_t len,
> >                                         uint8_t opcode, struct bt_att *att,
> > @@ -1995,6 +2024,11 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
> >                 p->func = func;
> >                 p->user_data = user_data;
> >
> > +               p->disconn = 0;
> > +               p->disconn_id = bt_att_register_disconnect(att,
> > +                                       pending_write_cb, p, NULL);
> > +               p->att = att;
> > +
> >                 queue_push_tail(attrib->pending_writes, p);
> >
> >                 attrib->write_func(attrib, p->id, offset, value, len, opcode,
> > --
> > 2.17.1
> >
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
