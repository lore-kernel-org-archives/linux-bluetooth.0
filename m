Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FA6C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Jan 2021 15:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A62023340
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Jan 2021 15:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733148AbhATPgv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Jan 2021 10:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730855AbhATPgd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Jan 2021 10:36:33 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A60CC061575
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jan 2021 07:35:53 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id i30so10819179ota.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jan 2021 07:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0US1jbH1bm0q7yCWHG8YsA4zf/ICaYmHEoNLy36sYSQ=;
        b=I8qJab6y0G5CCxtdyj1fQ0yigM3A+ScdRs2rPBLC2zqcLrPnueTmEuFKEvHAwCwu+d
         PfkdRt2U8F2oB3P4btmNBCo/QuAWBBhF4NLz8CqAmQHHCYBHAvAH9MK69vkynHCEaTDu
         dmP46JEqftU0Jj1pl1HbWhFnBHbR2Pzb2jRiPBUtL2BBZOEwbrCq+ivY4uSDAJ7rnASd
         rnAy3RUN3JQ6HF3+4Jt+A0nEmDrSmAPlUfrJ99VvwUrwsAQm6VN/oA/M/I7tkeWMJfEL
         xDJE2vszo4zg92ajdTsbIJKOBlJjy7jeMJ26FKRXCFXz5oJu+vw1fD4gEju2a2X03Tx7
         m8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0US1jbH1bm0q7yCWHG8YsA4zf/ICaYmHEoNLy36sYSQ=;
        b=Yxdq3yUln10+1YwzmXKOvvzpXLz9caa0Gi0cthwN950oThXYJDhd4sxMxT5M1PvTGe
         2XfA3NCLBdhB+xHmgkjkbGZDIJMaJH+BlInOsh+bsGELUDpDpgu64xecDNM0Mal9MhmE
         J4DbjzP/hyjiZFEz6iQxC2bbUN+z8TIyFlrj+u/8BwktsNPB44R/CnQL/v0SAfjwpTtl
         j77w16r865mfMhtQKzvc2O6/PXyy6dZqeO/pR6wvHZxtWFDoQo61FLBLeKmahEHhobzg
         PXMUAownFinxMaB4X912kIGQZtBA4HT809Rs0XY6VeRd3qiKSBOW2XFcgvu2AtEb1vKN
         d90w==
X-Gm-Message-State: AOAM530pK67sbfuZO38aKnC39gbMaWYDHGWs07vRgP7Kq4jNyl2dorMb
        8pTf4XMyqfRamqNexBoTtQswhejmutzSKqqWvsGAgkncE++stQ==
X-Google-Smtp-Source: ABdhPJyfrrx4AWdhZwmYm7aw+mvP2hFfvos6FafFm6R+v0SuA+j2GJJ7sZxO2XFTGTU531EKZGX20a4wMkPvT2oH20M=
X-Received: by 2002:a05:6830:157:: with SMTP id j23mr7666653otp.240.1611156952940;
 Wed, 20 Jan 2021 07:35:52 -0800 (PST)
MIME-Version: 1.0
References: <20210108211513.5180-1-luiz.dentz@gmail.com> <20210108211513.5180-4-luiz.dentz@gmail.com>
 <CAOVXEJL6VTmiPRymnHepGgcMtDeNvouav049wLdQHg0ogWrjWg@mail.gmail.com>
In-Reply-To: <CAOVXEJL6VTmiPRymnHepGgcMtDeNvouav049wLdQHg0ogWrjWg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 20 Jan 2021 07:35:42 -0800
Message-ID: <CABBYNZL+qUi8yAseFOSXWptvPFV47cm5xE1aCd3i_cQNLh_B2Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/4] gatt: Fix assuming service changed has been subscribed
To:     Sathish Narasimman <nsathish41@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

On Wed, Jan 20, 2021 at 1:30 AM Sathish Narasimman <nsathish41@gmail.com> wrote:
>
> Hi Luiz
>
> On Sat, Jan 9, 2021 at 2:48 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > Unfortunately assuming service changed has been subscribed may cause
> > indication to time out in some peripherals (Logitech M720 Triathlon, Mx
> > Anywhere 2, Lenovo Mice N700, RAPOO BleMouse and Microsoft Designer
> > Mouse) even though the expect actually mandates that the client responds
> > with confirmation these peripherals just ignores it completely which
> > leads them to be disconnected whenever bluetoothd is restarted or the
> > system reboots.
> > ---
> >  src/device.c        | 11 ++---------
> >  src/gatt-database.c |  2 +-
> >  2 files changed, 3 insertions(+), 10 deletions(-)
> >
> > diff --git a/src/device.c b/src/device.c
> > index fe885aa64..af13badfc 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -5831,18 +5831,11 @@ void device_load_svc_chng_ccc(struct btd_device *device, uint16_t *ccc_le,
> >         key_file = g_key_file_new();
> >         g_key_file_load_from_file(key_file, filename, 0, NULL);
> >
> > -       /*
> > -        * If there is no "ServiceChanged" section we may be loading data from
> > -        * old version which did not persist Service Changed CCC values. Let's
> > -        * check if we are bonded and assume indications were enabled by peer
> > -        * in such case - it should have done this anyway.
> > -        */
> >         if (!g_key_file_has_group(key_file, "ServiceChanged")) {
> >                 if (ccc_le)
> > -                       *ccc_le = device->le_state.bonded ? 0x0002 : 0x0000;
> > +                       *ccc_le = 0x0000;
> >                 if (ccc_bredr)
> > -                       *ccc_bredr = device->bredr_state.bonded ?
> > -                                                       0x0002 : 0x0000;
> > +                       *ccc_bredr = 0x0000;
> >                 g_key_file_free(key_file);
> >                 return;
> >         }
> > diff --git a/src/gatt-database.c b/src/gatt-database.c
> > index b7d2bea1d..d99604826 100644
> > --- a/src/gatt-database.c
> > +++ b/src/gatt-database.c
> > @@ -333,7 +333,7 @@ static void att_disconnected(int err, void *user_data)
> >                 handle = gatt_db_attribute_get_handle(state->db->svc_chngd_ccc);
> >
> >                 ccc = find_ccc_state(state, handle);
> > -               if (ccc)
> > +               if (ccc && ccc->value)
> >                         device_store_svc_chng_ccc(device, state->bdaddr_type,
> >                                                                 ccc->value);
> >
> > --
> > 2.26.2
> >
>
> Was this patch is merged?

Yes, https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=39054d59c0ecdb102f8aa352cb7aa6fcbd7f2b6b

> Regards
> Sathish N



-- 
Luiz Augusto von Dentz
