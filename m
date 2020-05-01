Return-Path: <SRS0=Zhcm=6P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13786C35280
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 20:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E20C6216FD
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 20:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLRq501n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgEAUqL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 May 2020 16:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgEAUqL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 May 2020 16:46:11 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A17C061A0C
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2020 13:46:11 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 19so818238oiy.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 May 2020 13:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8wq8asihVhIpgEZgIkNu7ws7QCW2/mN90Big/42PoaI=;
        b=oLRq501nS9KMOU1dUPhEBpRJQIQ/DQycbOgmTPLkXc/VLsYWT5LrkSresV1EBIiRtm
         6+mqoKGfA5ek5CFYTznWhvAAlPVTZHYJ9LCobKYJl7JRcrj4A76Og049doMH1SVwNBoE
         m1Lh+eekRzgmqjuoXFhpwh/XX3r14pfeu263VbL4QpM5nG9fC/cb2Nv4G31LT2g92/Ht
         Ldf7ZbRJGqB4yWrGiHB4KSE8YcarGjEi0R2A+7+vvIKH8TZ+RUn6j6VdHs9ZmS2DjuBi
         5ZfVjQeHf5Gz30oAtNT8Xs7kzYMJiqT/3P+YEBEgo8Y7FITK2Cnxz1nyvWcbb+HiU8RY
         0pDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8wq8asihVhIpgEZgIkNu7ws7QCW2/mN90Big/42PoaI=;
        b=NA1MyozJFiC2cFQoMUBrCcGSDoIip2kysWj3C6KkYYdO9lmaoie8Kycr3UARL9eBqN
         sM0CqGLDfMEoPiawN7Rqx1RbTRjXOYeOeP72h0NlYI1Ff+GmQ98BbAqhK8F7NfQi7dSz
         eOvcVpLQGBCBncsfGDG5jKwBNRszwQjildKwmGzvM3OO+ZCqkbvV2H8Hurg9UF01md3M
         cPTnwvT6VJ84TQMFgTcaCyMYksKd/NzaKvfaGpTSraE+CeNPsAFlIIN9wctnnUC10YfM
         51XMvgZnj5NlCUDa32yHuIgUt5u9OgB1X6wj2EdKIYzT6rRK12rAAXkC1m/D1mAgGC5H
         kBFw==
X-Gm-Message-State: AGi0PuZBtZlSXUTY/DndyQxDKRzkt7cI6IHXGvrcLfEIG2xUmxJvcLBD
        05UeZ8PUYAuOq8VSmEQeHAn6HaeoCLvCj13qtXc=
X-Google-Smtp-Source: APiQypLwWzQ5Phw9QLrTqaIpQ3iJlZT3VW/XtHFaMlvuVflaBg8fYXlAFNtiMzNcBrribD/eyhnFfNzAyap9469EeFY=
X-Received: by 2002:aca:b155:: with SMTP id a82mr1169887oif.110.1588365970363;
 Fri, 01 May 2020 13:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200501192218.73993-1-alainm@chromium.org>
In-Reply-To: <20200501192218.73993-1-alainm@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 1 May 2020 13:45:58 -0700
Message-ID: <CABBYNZ+5EykQDdsAagP27T1hazfg_+9qHhwt4M136dUZCwU1Kw@mail.gmail.com>
Subject: Re: [BlueZ PATCH v2] shared/gatt-client:Ignore orphaned characteristics
To:     Alain Michaud <alainm@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Fri, May 1, 2020 at 12:27 PM Alain Michaud <alainm@chromium.org> wrote:
>
> The gatt discovery proceedure simplification to discover all
> characteristics at once has exposed a device side issue where some
> device implementation reports orphaned characteristics.  While this
> technically shouldn't be allowed, some instances of this were observed
> (namely on some Android phones).
>
> The fix is to simply skip over orphaned characteristics and continue
> with everything else that is valid.
>
> This has been tested as part of the Android CTS tests against an
> affected platform and was confirmed to have worked around the issue.
>
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> ---
>
>  src/shared/gatt-client.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 963ad619f..507b4d304 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -632,7 +632,13 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
>                         util_debug(client->debug_callback, client->debug_data,
>                                 "Failed to insert characteristic at 0x%04x",
>                                 chrc_data->value_handle);
> -                       goto failed;
> +
> +                       /* Some devices have been seen reporting orphaned
> +                        * characteristics.  In order to favor interoperability
> +                        * we skip over characteristics in error
> +                        */
> +                       free(chrc_data);
> +                       continue;
>                 }
>
>                 if (gatt_db_attribute_get_handle(attr) !=
> --
> 2.26.2.526.g744177e7f7-goog
>

Applied, thanks. Note that I drop the Signed-off-by line since we
don't use that on userspace.

-- 
Luiz Augusto von Dentz
