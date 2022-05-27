Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A154FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 May 2022 03:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiE0DNv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 May 2022 23:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237960AbiE0DNo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 May 2022 23:13:44 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C19C9AE43
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 20:13:42 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id z17so1940184wmf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 20:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hLhbEmB+6oWbSobGhlaOXKWY2MtkxESxzLh0gUWNPjM=;
        b=tKYMDnDS4oJT8zrK7SQCNKSdT0FwpU8y7JEWwHZdf/bcQrN7IDvd7eaZAnWnKtxXn9
         59pPqNGkVhnpPrZd/jt9XC7MfKdMnhPCp/6Qj5U8Yl3idwGtDLLadidpcaUbKL93W7xk
         5z92bH8vLTiW+PGL3CKv6/+ltBOliwojactsb8+3KAy8wsBcHq/5Xe68RSc2HZXFvm6T
         Z/vaKoYdcTEalcHd+27rw59ErcuzVuxcABEuO9/WVS6cN0LeAGObMtwP6qifWnZi8E2J
         LfZvIQnljAhq8Pfn/RmQEVqFxNTNobLv0YqFv8NIsmpGZhsQsmwlHuYyeduY68UzgucX
         G3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hLhbEmB+6oWbSobGhlaOXKWY2MtkxESxzLh0gUWNPjM=;
        b=chrx8k4Q6CCbYaJTuREvSDLO01fEqqtRni+DJyomZlq1eKQqv5eT2GzjXnyP/LfWvm
         +bYOAVdYISisbDUn4+FlSlBEx8dGZSy60onnaGtkxBZwocczqYf8D+l6ulFiBq2mcRiG
         Qh6HrDJMsJTCwXxnu6vJN4WFfxWg+6dlMkSG+Aw6JToqFoI4tvXgB7Z9NCdhqQOsMBsA
         pCw58rCrz/5NwJXUi8CMjNlezLAq+YVt3rHkISf1felYyhWpKeKxayniFbBBqgVlz4gX
         b8nqMgpvZywbmLpOHYNbwkdwqlaWJYg90GujGGvIR8vyXFXOQTd3sTFZff0xInwRdwAn
         I6fA==
X-Gm-Message-State: AOAM531FzYjkXgQtJPlG7ajRtCtrjP4GBbnGkhg3z7Cdj4gHKpEO66pz
        NxV0sYEanahb3e+hN8RAHjsOUqlJOcy9YlLB4wF4P2A9i9VUuA==
X-Google-Smtp-Source: ABdhPJxVfU2NZajY56XPrv2/sBKTdjTTpks2AM7CUGy07OWgS/vNj8jPKJtm3GPGdOmbLTydo/V6dmW8Vg/pCaOiso0=
X-Received: by 2002:a05:600c:19cd:b0:397:83f8:ec5c with SMTP id
 u13-20020a05600c19cd00b0039783f8ec5cmr3461246wmq.9.1653621220786; Thu, 26 May
 2022 20:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220526112456.2488536-1-josephsih@chromium.org>
 <20220526112456.2488536-3-josephsih@chromium.org> <CABBYNZ+jxkXvsmKxka0McLDgZOXp=aJ9Q3pT0P-2_0k79+2Q5g@mail.gmail.com>
In-Reply-To: <CABBYNZ+jxkXvsmKxka0McLDgZOXp=aJ9Q3pT0P-2_0k79+2Q5g@mail.gmail.com>
From:   Joseph Hwang <josephsih@google.com>
Date:   Fri, 27 May 2022 11:13:30 +0800
Message-ID: <CAHFy41_D_JRxe34hUheg0pGVRk9ns0GWUvZPkCQe1G7iZHAitQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v6 3/8] adapter: remove quality report from
 experimental features
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        pali@kernel.org, chromeos-bluetooth-upstreaming@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks Luiz for the comment! Does it mean that bluez should 1) try to
use MGMT_OP_SET_QUALITY_REPORT; and if it failed, use the experimental
feature EXP_FEAT_BQR instead?

Regards,
Joseph


On Fri, May 27, 2022 at 4:31 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Joseph,
>
> On Thu, May 26, 2022 at 4:25 AM Joseph Hwang <josephsih@chromium.org> wrote:
> >
> > The quality report feature is now enabled through
> > MGMT_OP_SET_QUALITY_REPORT instead of through the experimental
> > features.
> >
> > ---
> >
> > Changes in v6:
> > - Fixed a patch conflict.
> >
> > Changes in v5:
> > - Move is_quality_report_supported() implementation to next patch.
> >   The function does not belong to this patch.
> >
> > Changes in v4:
> > - Move forward this patch in the patch series so that this
> >   command patch is prior to the quality report event patches.
> >
> > Changes in v3:
> > - This is a new patch that enables the quality report feature via
> >   MGMT_OP_SET_QUALITY_REPORT.
> >
> >  src/adapter.c | 14 --------------
> >  src/adapter.h |  1 -
> >  2 files changed, 15 deletions(-)
> >
> > diff --git a/src/adapter.c b/src/adapter.c
> > index f7faaa263..2ceea6e1c 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -120,13 +120,6 @@ static const struct mgmt_exp_uuid le_simult_central_peripheral_uuid = {
> >         .str = "671b10b5-42c0-4696-9227-eb28d1b049d6"
> >  };
> >
> > -/* 330859bc-7506-492d-9370-9a6f0614037f */
> > -static const struct mgmt_exp_uuid quality_report_uuid = {
> > -       .val = { 0x7f, 0x03, 0x14, 0x06, 0x6f, 0x9a, 0x70, 0x93,
> > -               0x2d, 0x49, 0x06, 0x75, 0xbc, 0x59, 0x08, 0x33 },
> > -       .str = "330859bc-7506-492d-9370-9a6f0614037f"
> > -};
> > -
> >  /* 15c0a148-c273-11ea-b3de-0242ac130004 */
> >  static const struct mgmt_exp_uuid rpa_resolution_uuid = {
> >         .val = { 0x04, 0x00, 0x13, 0xac, 0x42, 0x02, 0xde, 0xb3,
> > @@ -9621,12 +9614,6 @@ static void le_simult_central_peripheral_func(struct btd_adapter *adapter,
> >                                 (void *)le_simult_central_peripheral_uuid.val);
> >  }
> >
> > -static void quality_report_func(struct btd_adapter *adapter, uint8_t action)
> > -{
> > -       if (action)
> > -               queue_push_tail(adapter->exps, (void *)quality_report_uuid.val);
> > -}
> > -
> >  static void set_rpa_resolution_complete(uint8_t status, uint16_t len,
> >                                         const void *param, void *user_data)
> >  {
> > @@ -9703,7 +9690,6 @@ static const struct exp_feat {
> >         EXP_FEAT(EXP_FEAT_DEBUG, &debug_uuid, exp_debug_func),
> >         EXP_FEAT(EXP_FEAT_LE_SIMULT_ROLES, &le_simult_central_peripheral_uuid,
> >                  le_simult_central_peripheral_func),
> > -       EXP_FEAT(EXP_FEAT_BQR, &quality_report_uuid, quality_report_func),
> >         EXP_FEAT(EXP_FEAT_RPA_RESOLUTION, &rpa_resolution_uuid,
> >                 rpa_resolution_func),
> >         EXP_FEAT(EXP_FEAT_CODEC_OFFLOAD, &codec_offload_uuid,
> > diff --git a/src/adapter.h b/src/adapter.h
> > index 688ed51c6..3d53a962d 100644
> > --- a/src/adapter.h
> > +++ b/src/adapter.h
> > @@ -257,7 +257,6 @@ bool btd_le_connect_before_pairing(void);
> >  enum experimental_features {
> >         EXP_FEAT_DEBUG                  = 1 << 0,
> >         EXP_FEAT_LE_SIMULT_ROLES        = 1 << 1,
> > -       EXP_FEAT_BQR                    = 1 << 2,
> >         EXP_FEAT_RPA_RESOLUTION         = 1 << 3,
> >         EXP_FEAT_CODEC_OFFLOAD          = 1 << 4,
> >  };
>
> We can't remove existing experimental features since there could be
> kernels which don't support MGMT_OP_SET_QUALITY_REPORT, so this will
> need to stay for as long as we support such kernels versions.
>
> > --
> > 2.36.1.124.g0e6072fb45-goog
> >
>
>
> --
> Luiz Augusto von Dentz



-- 

Joseph Shyh-In Hwang
Email: josephsih@google.com
