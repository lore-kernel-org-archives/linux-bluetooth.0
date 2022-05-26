Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC84FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 May 2022 20:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237973AbiEZUbX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 May 2022 16:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238065AbiEZUbW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 May 2022 16:31:22 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B982C674
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 13:31:20 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ge11so2792693pjb.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 13:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rdIRbITs6B4bWd11Ga7tXtn1gFKwf/ItYYBNqnN63GE=;
        b=OEGc/lnvI371qjSou5QacuFfXEgVJqV5vArnvWTTF640k7Ngjym/+eT3/USAB+2FPq
         +TM6f4gc7OfZemJAKCZLplpENC5atPh/V+yWSd8Z+CWU1rWCX/Ftz7QUOJICOgBKVjlD
         dy6HNo8i6uNu18mRFAOsfPiRVoVuiSXnWTZBYTsXNuTactiE15+rPEj3jJ+i6naiQZ5c
         WZQ586PrOQOY2PN7NHiUHZHzXC7E3z/US5vj+WO/dQESdr/aSBKZbddw7y2jnuCvZTXn
         18PoJJSoJpgFvgJBKbUV7E+hF8rNdZzDzxkBKDeZi9DWp6/Dw716lO5zMjRE3bxogCHK
         oQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rdIRbITs6B4bWd11Ga7tXtn1gFKwf/ItYYBNqnN63GE=;
        b=LvqPITK3Zkaz0iU+g2Jq0kCujeo2UxaNrqxcyxbsBJbpcRcTZf0t7B0YBUknoi1b8h
         YJal8Zjr+EJK4QTBrSrWXLMu+DRfB2J245MX8uKWvls3I5LMNg80T+1oqbYZZoSAyDzq
         szMfDN4FdJScFJYrIh1SO/q/DATjiYKtAr41Lkv/EMp9rtgaG/2SNFd+M5eeBn3ZFHRA
         vkqQsA92DcTZT/Vzw9G9FlMFfNLpzfw7kOAVUWbXd0k8/g/O91ushXwZ9G+FosGXOt0U
         Yt96AEcHYZJk93R8GZD42jixTR8Gkyjnm71Flf2wUWr68rIu8uXlCIkKPBzqb5YBlE41
         qABg==
X-Gm-Message-State: AOAM5338gjfS9dWNh/LELCYToshHvrKvexAwsmbBzezZblxT4KzirVSA
        sFbZoxsJVduMDKqeCaLLTUESVvcxJCKyqpZBDXaA3/2RHUI=
X-Google-Smtp-Source: ABdhPJxjQClhl5uze4IcP0SH2wrwDjdzLni4Vd3hV6ucXVBML9X2PlfY8P/jRmevxfNV5rMkJI/f5bkskyAyS4/GCRA=
X-Received: by 2002:a17:90a:4803:b0:1dc:b4c9:1958 with SMTP id
 a3-20020a17090a480300b001dcb4c91958mr4402756pjh.61.1653597080324; Thu, 26 May
 2022 13:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220526112456.2488536-1-josephsih@chromium.org> <20220526112456.2488536-3-josephsih@chromium.org>
In-Reply-To: <20220526112456.2488536-3-josephsih@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 26 May 2022 13:31:09 -0700
Message-ID: <CABBYNZ+jxkXvsmKxka0McLDgZOXp=aJ9Q3pT0P-2_0k79+2Q5g@mail.gmail.com>
Subject: Re: [BlueZ PATCH v6 3/8] adapter: remove quality report from
 experimental features
To:     Joseph Hwang <josephsih@chromium.org>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        pali@kernel.org, josephsih@google.com,
        chromeos-bluetooth-upstreaming@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

On Thu, May 26, 2022 at 4:25 AM Joseph Hwang <josephsih@chromium.org> wrote:
>
> The quality report feature is now enabled through
> MGMT_OP_SET_QUALITY_REPORT instead of through the experimental
> features.
>
> ---
>
> Changes in v6:
> - Fixed a patch conflict.
>
> Changes in v5:
> - Move is_quality_report_supported() implementation to next patch.
>   The function does not belong to this patch.
>
> Changes in v4:
> - Move forward this patch in the patch series so that this
>   command patch is prior to the quality report event patches.
>
> Changes in v3:
> - This is a new patch that enables the quality report feature via
>   MGMT_OP_SET_QUALITY_REPORT.
>
>  src/adapter.c | 14 --------------
>  src/adapter.h |  1 -
>  2 files changed, 15 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index f7faaa263..2ceea6e1c 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -120,13 +120,6 @@ static const struct mgmt_exp_uuid le_simult_central_peripheral_uuid = {
>         .str = "671b10b5-42c0-4696-9227-eb28d1b049d6"
>  };
>
> -/* 330859bc-7506-492d-9370-9a6f0614037f */
> -static const struct mgmt_exp_uuid quality_report_uuid = {
> -       .val = { 0x7f, 0x03, 0x14, 0x06, 0x6f, 0x9a, 0x70, 0x93,
> -               0x2d, 0x49, 0x06, 0x75, 0xbc, 0x59, 0x08, 0x33 },
> -       .str = "330859bc-7506-492d-9370-9a6f0614037f"
> -};
> -
>  /* 15c0a148-c273-11ea-b3de-0242ac130004 */
>  static const struct mgmt_exp_uuid rpa_resolution_uuid = {
>         .val = { 0x04, 0x00, 0x13, 0xac, 0x42, 0x02, 0xde, 0xb3,
> @@ -9621,12 +9614,6 @@ static void le_simult_central_peripheral_func(struct btd_adapter *adapter,
>                                 (void *)le_simult_central_peripheral_uuid.val);
>  }
>
> -static void quality_report_func(struct btd_adapter *adapter, uint8_t action)
> -{
> -       if (action)
> -               queue_push_tail(adapter->exps, (void *)quality_report_uuid.val);
> -}
> -
>  static void set_rpa_resolution_complete(uint8_t status, uint16_t len,
>                                         const void *param, void *user_data)
>  {
> @@ -9703,7 +9690,6 @@ static const struct exp_feat {
>         EXP_FEAT(EXP_FEAT_DEBUG, &debug_uuid, exp_debug_func),
>         EXP_FEAT(EXP_FEAT_LE_SIMULT_ROLES, &le_simult_central_peripheral_uuid,
>                  le_simult_central_peripheral_func),
> -       EXP_FEAT(EXP_FEAT_BQR, &quality_report_uuid, quality_report_func),
>         EXP_FEAT(EXP_FEAT_RPA_RESOLUTION, &rpa_resolution_uuid,
>                 rpa_resolution_func),
>         EXP_FEAT(EXP_FEAT_CODEC_OFFLOAD, &codec_offload_uuid,
> diff --git a/src/adapter.h b/src/adapter.h
> index 688ed51c6..3d53a962d 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -257,7 +257,6 @@ bool btd_le_connect_before_pairing(void);
>  enum experimental_features {
>         EXP_FEAT_DEBUG                  = 1 << 0,
>         EXP_FEAT_LE_SIMULT_ROLES        = 1 << 1,
> -       EXP_FEAT_BQR                    = 1 << 2,
>         EXP_FEAT_RPA_RESOLUTION         = 1 << 3,
>         EXP_FEAT_CODEC_OFFLOAD          = 1 << 4,
>  };

We can't remove existing experimental features since there could be
kernels which don't support MGMT_OP_SET_QUALITY_REPORT, so this will
need to stay for as long as we support such kernels versions.

> --
> 2.36.1.124.g0e6072fb45-goog
>


-- 
Luiz Augusto von Dentz
