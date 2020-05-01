Return-Path: <SRS0=Zhcm=6P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E8DC47258
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 17:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99B5B2173E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 17:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F5jJVOTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbgEARkx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 May 2020 13:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729572AbgEARkw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 May 2020 13:40:52 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DA1C061A0C
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2020 10:40:52 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id t11so4406342lfe.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 May 2020 10:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AvoZcybB+C+WEQaUiBLplnF5GWMC5z6qQfjFgXMPod4=;
        b=F5jJVOTFXokcNkuQ1Zk8OVzSrIVakAeKxETqY4gf1zE67zq6eki5POPWY99DBHpQUo
         I4QtJuGLfy5m+9X4odOyeXZT7qRFvVSamQ6WmXDXmD4DzZkHciVmIxmI2Bsfaxh2y6zJ
         wB2fNf0RypGSQCZ8VYhQdj7JC4K6KM19flnatmMP4ddw2UxkFF6c1JS3xRw/NSnSdv5f
         7CWiIyxclemhZspUywKDv44DX7sc4nnl7x4lHfXG6AhtmPx3VAXIIZXOYSmCdvjJkSye
         fmydtdhhqUYnQ3PKB08hzcqjoa59qka9oR69COlP4ybpOt4p5DsIMp7A6EDm3HKRvEBM
         rkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AvoZcybB+C+WEQaUiBLplnF5GWMC5z6qQfjFgXMPod4=;
        b=fmrei6g65Jlxl5cxv5HDTTlP9fqaBva0JiSYdQJczv7f85d6dra8OurB2/SeP2LAbM
         quoWdq4103lmsNCmAge6cODvjPGS0UuZsdTp1eLQWDRDuTXYNcWwGjeF2suV1qCxEFuN
         VJKJ2hTyfRJ/KZ3fTqRVL7kvWxf7Y4w+N6YArzJxCSP7PPMrrh/e7kSmDLEtaN6ROQOM
         D5AJIQ2RVYueA75o+dSivqxXQKg+/BohoKq/2x2NUs/cl0j4eNIT+dwQPsrHh4eKt0c8
         O/m1IXa7EAsyVJBljocIWpq36BTQOGCXkVGKdcS2bsbPRGwSMdKOupPEp/EWIOQ4MSzl
         n61g==
X-Gm-Message-State: AGi0PuZlOPj0UoZ/1eL5nifgq39yaH/2Uy8a6ue/Y4X/GaXX7Y8sEAki
        bwYxB/FHvbzeFACukKqjkkRAfs4IwO6JJTkF481BeA==
X-Google-Smtp-Source: APiQypJLH4tvuQlrkymaRmS3XxBAQdQrtFYlX8jSo+g38D8EIXfS/nXrT90+Lcyr4jBY5Psp6zCi3u5o88GbYZTL0wo=
X-Received: by 2002:a19:6a18:: with SMTP id u24mr3229653lfu.191.1588354850782;
 Fri, 01 May 2020 10:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200501144037.1684-1-alainm@chromium.org> <4195BFB9-1586-435F-8FC2-ED215959A591@holtmann.org>
 <CALWDO_W4AquYjw5LZR+pbFnPEB=shYKDH7_JDGHexpsXUnC7aA@mail.gmail.com> <215E5E68-A360-4DD7-8DBC-E46278729FC6@holtmann.org>
In-Reply-To: <215E5E68-A360-4DD7-8DBC-E46278729FC6@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Fri, 1 May 2020 13:40:39 -0400
Message-ID: <CALWDO_XG7PG8KCy0rraZZm0L12baSyWzxfCJnUkNBJX=APhQ_A@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] shared/gatt-client:Ignore orphaned characteristics
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, May 1, 2020 at 1:32 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> >>> The gatt discovery proceedure simplification to discover all
> >>> characteristics at once has exposed a device side issue where some
> >>> device implementation reports orphaned characteristics.  While this
> >>> technically shouldn't be allowed, some instances of this were observed
> >>> (namely on some Android phones).
> >>>
> >>> The fix is to simply skip over orphaned characteristics and continue
> >>> with everything else that is valid.
> >>>
> >>> This has been tested as part of the Android CTS tests against an
> >>> affected platform and was confirmed to have worked around the issue.
> >>> ---
> >>>
> >>> src/shared/gatt-client.c | 5 ++++-
> >>> 1 file changed, 4 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> >>> index 963ad619f..d604c77a3 100644
> >>> --- a/src/shared/gatt-client.c
> >>> +++ b/src/shared/gatt-client.c
> >>> @@ -632,7 +632,10 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
> >>>                      util_debug(client->debug_callback, client->debug_data,
> >>>                              "Failed to insert characteristic at 0x%04x",
> >>>                              chrc_data->value_handle);
> >>> -                     goto failed;
> >>> +
> >>> +                     /* Skip over invalid characteristic */
> >>> +                     free(chrc_data);
> >>> +                     continue;
> >>>              }
> >>
> >> should we add a warning here?
> > Is there a good way other than the util_debug mechanism to write  a warning?
>
> you could just use btd_warn() here. If this gets too noisy, we either remove it later or we introduce a btd_warn_ratelimited() or btd_warn_once().
This being under src/shared, I wasn't sure if that was acceptable to
add a btd dependency here, especially with the work to avoid it via
the util_debug.  Happy to do either way, just want to make sure the
guidance is clear.

>
> Regards
>
> Marcel
>
