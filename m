Return-Path: <SRS0=mBsK=AM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1192C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 17:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8BF820771
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 17:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aT13mzU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732016AbgGARzJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Jul 2020 13:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbgGARzJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Jul 2020 13:55:09 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8A4C08C5C1
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2020 10:55:08 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id e4so13223229oib.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2020 10:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gyQF7N46rccRe51etLI7nVzODLmPrqWQyISOUMmMZXM=;
        b=aT13mzU+yVEAV+120HJCM5aNR0ikcpI2/fyyC400rmUauGIrTZJ9HEswLx2SQSzShl
         KvMmT/yuK3RqOJwLWDxOUm0pmdEjtGDtk0w3mBdxzLOTSgFAYmqrUpVVJHj8TKiu7eMS
         WH9kuiP/qYr8dUZoMOjofTKoSofoHGhsDSFvrUdrpCyA/zb5sDM4cxbBonti1gXjh6rc
         dEpGwcDarfXeVawfmXyeesnNFhbkDZrYc1n9NDe6xHKQgg4tCCnsBmErMEW5I+QG4w2v
         9iVQAEErt/h5vnAcb8NaBmikjUZPq1bgikhCv9ltVM11aXCn/GssR6UnA1Bxe8BSRWj8
         MyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gyQF7N46rccRe51etLI7nVzODLmPrqWQyISOUMmMZXM=;
        b=hN72Krpb/rN4Vr7AK/2dbd0Dav3zCpCS1r97JKC1njssrn4KDDxbgO11A0nNkLwLqt
         HZL1yCiz+9TodJVm5vxqKGjMPp2PXfc35a5xt+qsmQ6I8vd3nFObyRAlvXQzfHhruqey
         Xqt6ONjq1akVUnj50353eZmvclhBL/QCrX/W+xZzZ8Q5ovmNdyxdR+pla61pj/yaxfKR
         gjz1B4U0jiaPIpyLy0O7JBzGQE/e8IQCUvJCZ2DhS2lU8LMvHctsqNUih709XueXEiZy
         cQVtV1iOKEVfJfhQZFbvbyH9fueW8OcX3sb/5FADIdH4IM0LhycrhilApNTE7iLIlW3s
         rW5Q==
X-Gm-Message-State: AOAM531DT7n19VuyrM4il8oob9xBMigK8+/Ipwr4IOph7BbBCKyb0Bf3
        aNHkqu2GdBPBsZx5mOtys39dCS6LlT2k6ZeeyeaxNFIY
X-Google-Smtp-Source: ABdhPJx0Vlug3SMuuYns/x1sLLojNvX7NRS2ZYHdNDFcWRh4CElcYaraPMcBI38a1jHJPARMzW3vQkDO5HNtA2rnBK8=
X-Received: by 2002:aca:2819:: with SMTP id 25mr14927355oix.48.1593626107393;
 Wed, 01 Jul 2020 10:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200701131328.3835273-1-alainm@chromium.org>
In-Reply-To: <20200701131328.3835273-1-alainm@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 1 Jul 2020 10:54:55 -0700
Message-ID: <CABBYNZLZPJKy=Fk9bLeSys5mMh3QtWcoqW4yhqszPsP=Jj6MEg@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3] profiles/scanparam: use configured scanparams
 when available
To:     Alain Michaud <alainm@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-Chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Wed, Jul 1, 2020 at 6:16 AM Alain Michaud <alainm@chromium.org> wrote:
>
> This patch updates the scan parameter service to use the configured scan
> parameters when available rather than the hardcoded kernel defaults.
>
> Reviewed-by: Miao-Chen Chou <mcchou@chromium.org>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
>
> ---
>
> Changes in v3:
>  - Addin Chromium/Gerrit reviewers
>
> Changes in v2:
>  - Fixing checkpatch comment warning.
>
>  profiles/scanparam/scan.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
> index 9e8f57747..d72be3dff 100644
> --- a/profiles/scanparam/scan.c
> +++ b/profiles/scanparam/scan.c
> @@ -45,12 +45,11 @@
>  #include "src/shared/gatt-db.h"
>  #include "src/shared/gatt-client.h"
>  #include "attrib/att.h"
> +#include "src/hcid.h"
>
>  #define SCAN_INTERVAL_WIN_UUID         0x2A4F
>  #define SCAN_REFRESH_UUID              0x2A31
>
> -#define SCAN_INTERVAL          0x0060
> -#define SCAN_WINDOW            0x0030
>  #define SERVER_REQUIRES_REFRESH        0x00
>
>  struct scan {
> @@ -75,8 +74,16 @@ static void write_scan_params(struct scan *scan)
>  {
>         uint8_t value[4];
>
> -       put_le16(SCAN_INTERVAL, &value[0]);
> -       put_le16(SCAN_WINDOW, &value[2]);
> +       /* Unless scan parameters are configured, use the known kernel default
> +        * parameters
> +        */
> +       put_le16(main_opts.default_params.le_scan_interval_autoconnect ?
> +                       main_opts.default_params.le_scan_interval_autoconnect :
> +                       0x60, &value[0]);
> +
> +       put_le16(main_opts.default_params.le_scan_win_autoconnect ?
> +                       main_opts.default_params.le_scan_win_autoconnect :
> +                       0x30, &value[2]);
>
>         bt_gatt_client_write_without_response(scan->client, scan->iwhandle,
>                                                 false, value, sizeof(value));
> --
> 2.27.0.212.ge8ba1cc988-goog
>

Applied, thanks.

-- 
Luiz Augusto von Dentz
