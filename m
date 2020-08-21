Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00449C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 07:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB0BF22B40
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 07:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fHKpNm6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgHUHLu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgHUHLm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 03:11:42 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BECC061385
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 00:11:42 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id u21so462182ejz.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 00:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A7002B1FAcwCDVUObHOePcfzoOQKLPQFGoLw3Ly97fo=;
        b=fHKpNm6xgaGrPl6weHyKvuMKGy9JwVcEZGlSWRpHR9A6n4MGV2s9AAlqvd9IZLhoV1
         fDw6JFHxULSKM1JZat2vhGZFTHoZg42JhIJqcBSP7gHD+AjCTYsc5E2UHHuP69TmUqyX
         qikAfLEkChBNt83fsOpz4NduWrhsRI9n4F1i8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A7002B1FAcwCDVUObHOePcfzoOQKLPQFGoLw3Ly97fo=;
        b=ZSFf/Cf7sPUgak8OuEZeyoNLEO/gQJQYHr4xWN7NoIvN5t2yXIYUcR0aNy2DtmkrX+
         OdRd+6kgQzvvtPc/yfIarluDDTEkd34rOmIhX7mOcz7pfBWu2XWw63IHOGlPQ1PYOp2w
         RZOpzVmpfe2EzcYKkuUiBQDRhqMnxfANxN0KGJpsNuOhs5R8sfJ7iEF5EQsXEdWMIaj2
         L880AD7Yyw4BvWxIBJB79EKmL9ohGPL3Q3g2UIqW20sj+Y6Pz1nu0mr9kw6E2RoNh+/s
         OdDcL7a/+lSNtY1D8xmZxNirFbUQaP8c3tuW/4uOpea9N8PcGItm/zMt8fN3EW1BY6Ho
         MXzg==
X-Gm-Message-State: AOAM530ghwzOiqyMmKLq1S2SxSnD7YviTrQUxkLn/PedDV1VHhjXjBkf
        1KQS4LgdZL7PYEf869pH/RkGinK19Uc9sw==
X-Google-Smtp-Source: ABdhPJxKB/WMSNZpwOIx/Ia6h0hpMZcf0KtfKbwLmjdSdccoaDuuvQFXfkJrpjNKB/xG/i3jV7LDbg==
X-Received: by 2002:a17:906:59b:: with SMTP id 27mr1697745ejn.56.1597993900488;
        Fri, 21 Aug 2020 00:11:40 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id d7sm750480ejk.99.2020.08.21.00.11.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 00:11:40 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id k20so800946wmi.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 00:11:40 -0700 (PDT)
X-Received: by 2002:a05:600c:2050:: with SMTP id p16mr2444179wmg.154.1597993898999;
 Fri, 21 Aug 2020 00:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200821062526.16689-1-sonnysasaka@chromium.org>
In-Reply-To: <20200821062526.16689-1-sonnysasaka@chromium.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Fri, 21 Aug 2020 00:11:28 -0700
X-Gmail-Original-Message-ID: <CAO271m=eB=HRUXReW8BUWooU5mfz=yQfwq0Dp1KZyWbqc9KPCg@mail.gmail.com>
Message-ID: <CAO271m=eB=HRUXReW8BUWooU5mfz=yQfwq0Dp1KZyWbqc9KPCg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] device: unset disconnecting flag when connection is removed
To:     BlueZ <linux-bluetooth@vger.kernel.org>
Cc:     Joseph Hwang <josephsih@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Maintainers,

Please ignore this patch as it is broken. Apologize for the mistake.


On Thu, Aug 20, 2020 at 11:25 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> From: Joseph Hwang <josephsih@chromium.org>
>
> A disconnecting flag has been used to avoid race condition
> between the service browsing thread and the disconnecting
> thread. We need to unset the flag when connection is removed.
>
> ---
>  src/device.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/src/device.c b/src/device.c
> index 7b7808405..5ab591dd4 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -3041,6 +3041,9 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
>                                                         "Paired");
>         }
>
> +       if (device)
> +               set_client_diconnecting(device->client, false);
> +
>         if (device->bredr_state.connected || device->le_state.connected)
>                 return;
>
> --
> 2.26.2
>
