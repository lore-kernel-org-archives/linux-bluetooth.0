Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE74C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 May 2022 21:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243200AbiE3VDQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 May 2022 17:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiE3VDK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 May 2022 17:03:10 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359DB5F47
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 May 2022 14:03:08 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 129so6750472pgc.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 May 2022 14:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+qmsvgomiZ/viHPe+NJZB01OGjh/MHHkDfU9RKsPecA=;
        b=mwj4rqspx7/M+mPDrID2VhTBOAUHLHJNRWO1ghabYs1hcDCrvp43tl607bILMJLNUd
         4Kg75l40AbR5/5WsmgW5jnNbkjqwrsy1dLBet8EaqthlHViFx+sAXXIXdq4jNAQplukT
         VgLiqMNlMFYzHkyPufpjJrp+huSfRHtbbvNRKTAvu5FXOSzX7CvXggBs5HVsSva04bw5
         OynHWUdkydNDDDV3ArMNRoipeHgPcnKTJzUvdPc3RrVH7iWdGIZ5ycAGBSmew04xL0da
         YR5Ke2tTpthf37z1gQLCHHGG9KbhHJutqhD4YYwHVgI25VDCo2pwojufGwryurjq4aBm
         LYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+qmsvgomiZ/viHPe+NJZB01OGjh/MHHkDfU9RKsPecA=;
        b=xDPDDSaqy/O4oxPUqJCLrMiH8OyMDlx8GTItDxjUpXn26vfAoF0e54q1Dw20kLP6jk
         zK9FsR9i1pDZtkskMP+QokQhXw7ww67fFYlvKfk/YdCpcXIeLQlouPV/GhkR5o/e/Pcn
         3tWgBgGqT6oqfrqwZqokqlXvgPO3W3K0V5WrcAixppLoosopjVnLG7NjqOUVYoFltabF
         ie1axNqIC76Cn66TgKpTbqUk7Jam3DgukwRYr3Pir51Sc4zXBTpKJNuD1u1N4jmMhdKN
         cDs1ZrzSfFvriujH0Ag198WXGbLoR3bavQLj58Q89pfEe8q20bBqlwMSlZo8bOWXntlQ
         y58w==
X-Gm-Message-State: AOAM531Yd+PwbcrZJwTnh3oIvPkyP0d8nkhgiyOyNmT98nB6/VTS/yoI
        ViLv6tL0OTnJ0eQuprCF/3fzsq+CGBhRYD8C5hvd60SLiC4=
X-Google-Smtp-Source: ABdhPJz97pJSGXCkZsBW4xS961TVosxmXMWOtRnaP19COh8Z2LUwmB7JDf/JeSYQiUr5nnVqHu53ga279QQ6djMvh0k=
X-Received: by 2002:a65:6d08:0:b0:3c6:8a08:3b9f with SMTP id
 bf8-20020a656d08000000b003c68a083b9fmr50080397pgb.147.1653944588374; Mon, 30
 May 2022 14:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220526112456.2488536-1-josephsih@chromium.org>
 <20220526112456.2488536-3-josephsih@chromium.org> <CABBYNZ+jxkXvsmKxka0McLDgZOXp=aJ9Q3pT0P-2_0k79+2Q5g@mail.gmail.com>
 <CAHFy41_D_JRxe34hUheg0pGVRk9ns0GWUvZPkCQe1G7iZHAitQ@mail.gmail.com>
In-Reply-To: <CAHFy41_D_JRxe34hUheg0pGVRk9ns0GWUvZPkCQe1G7iZHAitQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 30 May 2022 14:02:56 -0700
Message-ID: <CABBYNZLh_J2_y_RcAaMshgiQVYKWGmxyGSZ23p1gs9+D5sUp=A@mail.gmail.com>
Subject: Re: [BlueZ PATCH v6 3/8] adapter: remove quality report from
 experimental features
To:     Joseph Hwang <josephsih@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

On Thu, May 26, 2022 at 8:13 PM Joseph Hwang <josephsih@google.com> wrote:
>
> Thanks Luiz for the comment! Does it mean that bluez should 1) try to
> use MGMT_OP_SET_QUALITY_REPORT; and if it failed, use the experimental
> feature EXP_FEAT_BQR instead?

Yep, in fact you should probably keep the existing code as it since it
only set BQR if the kernel supports it anyway, that said how you are
planning to support MGMT_OP_SET_QUALITY_REPORT since that is not
enabled via UUID even if we can detect its support by the kernel Ive
assumed it wouldn't be enabled all the time or that safe to be always
enabled?

> Regards,
> Joseph
>
>
> On Fri, May 27, 2022 at 4:31 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Joseph,
> >
> > On Thu, May 26, 2022 at 4:25 AM Joseph Hwang <josephsih@chromium.org> wrote:
> > >
> > > The quality report feature is now enabled through
> > > MGMT_OP_SET_QUALITY_REPORT instead of through the experimental
> > > features.
> > >
> > > ---
> > >
> > > Changes in v6:
> > > - Fixed a patch conflict.
> > >
> > > Changes in v5:
> > > - Move is_quality_report_supported() implementation to next patch.
> > >   The function does not belong to this patch.
> > >
> > > Changes in v4:
> > > - Move forward this patch in the patch series so that this
> > >   command patch is prior to the quality report event patches.
> > >
> > > Changes in v3:
> > > - This is a new patch that enables the quality report feature via
> > >   MGMT_OP_SET_QUALITY_REPORT.
> > >
> > >  src/adapter.c | 14 --------------
> > >  src/adapter.h |  1 -
> > >  2 files changed, 15 deletions(-)
> > >
> > > diff --git a/src/adapter.c b/src/adapter.c
> > > index f7faaa263..2ceea6e1c 100644
> > > --- a/src/adapter.c
> > > +++ b/src/adapter.c
> > > @@ -120,13 +120,6 @@ static const struct mgmt_exp_uuid le_simult_central_peripheral_uuid = {
> > >         .str = "671b10b5-42c0-4696-9227-eb28d1b049d6"
> > >  };
> > >
> > > -/* 330859bc-7506-492d-9370-9a6f0614037f */
> > > -static const struct mgmt_exp_uuid quality_report_uuid = {
> > > -       .val = { 0x7f, 0x03, 0x14, 0x06, 0x6f, 0x9a, 0x70, 0x93,
> > > -               0x2d, 0x49, 0x06, 0x75, 0xbc, 0x59, 0x08, 0x33 },
> > > -       .str = "330859bc-7506-492d-9370-9a6f0614037f"
> > > -};
> > > -
> > >  /* 15c0a148-c273-11ea-b3de-0242ac130004 */
> > >  static const struct mgmt_exp_uuid rpa_resolution_uuid = {
> > >         .val = { 0x04, 0x00, 0x13, 0xac, 0x42, 0x02, 0xde, 0xb3,
> > > @@ -9621,12 +9614,6 @@ static void le_simult_central_peripheral_func(struct btd_adapter *adapter,
> > >                                 (void *)le_simult_central_peripheral_uuid.val);
> > >  }
> > >
> > > -static void quality_report_func(struct btd_adapter *adapter, uint8_t action)
> > > -{
> > > -       if (action)
> > > -               queue_push_tail(adapter->exps, (void *)quality_report_uuid.val);
> > > -}
> > > -
> > >  static void set_rpa_resolution_complete(uint8_t status, uint16_t len,
> > >                                         const void *param, void *user_data)
> > >  {
> > > @@ -9703,7 +9690,6 @@ static const struct exp_feat {
> > >         EXP_FEAT(EXP_FEAT_DEBUG, &debug_uuid, exp_debug_func),
> > >         EXP_FEAT(EXP_FEAT_LE_SIMULT_ROLES, &le_simult_central_peripheral_uuid,
> > >                  le_simult_central_peripheral_func),
> > > -       EXP_FEAT(EXP_FEAT_BQR, &quality_report_uuid, quality_report_func),
> > >         EXP_FEAT(EXP_FEAT_RPA_RESOLUTION, &rpa_resolution_uuid,
> > >                 rpa_resolution_func),
> > >         EXP_FEAT(EXP_FEAT_CODEC_OFFLOAD, &codec_offload_uuid,
> > > diff --git a/src/adapter.h b/src/adapter.h
> > > index 688ed51c6..3d53a962d 100644
> > > --- a/src/adapter.h
> > > +++ b/src/adapter.h
> > > @@ -257,7 +257,6 @@ bool btd_le_connect_before_pairing(void);
> > >  enum experimental_features {
> > >         EXP_FEAT_DEBUG                  = 1 << 0,
> > >         EXP_FEAT_LE_SIMULT_ROLES        = 1 << 1,
> > > -       EXP_FEAT_BQR                    = 1 << 2,
> > >         EXP_FEAT_RPA_RESOLUTION         = 1 << 3,
> > >         EXP_FEAT_CODEC_OFFLOAD          = 1 << 4,
> > >  };
> >
> > We can't remove existing experimental features since there could be
> > kernels which don't support MGMT_OP_SET_QUALITY_REPORT, so this will
> > need to stay for as long as we support such kernels versions.
> >
> > > --
> > > 2.36.1.124.g0e6072fb45-goog
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
>
>
> --
>
> Joseph Shyh-In Hwang
> Email: josephsih@google.com



-- 
Luiz Augusto von Dentz
