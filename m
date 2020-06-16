Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05661C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 17:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF2E4208D5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 17:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qb0cQCzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbgFPR10 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbgFPR10 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jun 2020 13:27:26 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0917CC061573
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 10:27:26 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 97so16584619otg.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 10:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JDcUHAJvkU6Oeoz11PRb4m/a25po9npgIwify5gpAc0=;
        b=Qb0cQCzOFvJ4K1WCMzhL8PFU+bfrisa/cQ4bhLdnaTAzRcMrsHM18rNLcjKC5JfjyC
         OsricOiCMyu/bWHbFI98MIdRZPYOjv0fgS6BTzP78o5JJdShaCqJ+xQjoCUTr5Uee92X
         LJmTNe/OS1v+Pv37mYCjHwjgduLOSqHOu+cuzdfWGsy0k1NL4lC0cKrCIi9hfT3eZPP2
         Gpo5XYTkpwrPBb+Wyc6YhywboODii1jnBBNeVqdRhgnddA4rbKZHCOZLCCgtt/HHxiMJ
         uHSySNLJMIRacaPZAHIfgP9GT5cvI6eIItssN6k7P/q2ljdamQgJS7AqHNNVm+aAQB0X
         JEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JDcUHAJvkU6Oeoz11PRb4m/a25po9npgIwify5gpAc0=;
        b=A2G0Z9kJcq+AEoj712O21EV/NmJV6O/+a+M3F3nEe9LrYgcrLw60B/7nfjzRkqaXXa
         V+3s1W6uA1Kn9iMUKuJ6+3vZMqdU27DqYyXQ5U0ZJYjrQ//uw45lwstYqT7Fv6eKq1C3
         tDHsHwrs5vN/hsGkw+pjA7jVil4XHXcLCQPYh+BZhinH/V/7Q/yBf8Euvlqt+v37czyY
         Q0+3ed0aCnQ3Iy0+V3o3Lyp5IB4iJjLOr5RYn0EfljZl+ztCZGmm1HnkS7XYDKsD/WW8
         47p3weQ9OLhIy15M3Hzrym6cmQP6zFFfkbL+V0yDFz4gCryfjc0rsylJmkj8G7PvNDQ6
         nxxQ==
X-Gm-Message-State: AOAM531/dXxYk3dyqf6seFSHSNIOpCLsJ2MBFQtqUwSu9EbbL5lDf1WE
        HxKdzczauBDAY3Ei9dlaawdW3Nu1iOzHwKl4f9Y=
X-Google-Smtp-Source: ABdhPJyLoYVwwpIOvT6ZFzoSsFFQ7EjUptYRjbR3g/ac8O1cqbL+al1VLnCrDDsAmGDxbNmZQTpR0HdRI558SNWuDBc=
X-Received: by 2002:a9d:2c02:: with SMTP id f2mr3451980otb.79.1592328445319;
 Tue, 16 Jun 2020 10:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200615212806.BlueZ.v1.1.I8328c620402620c9aadc149614bb279e42a9db4f@changeid>
In-Reply-To: <20200615212806.BlueZ.v1.1.I8328c620402620c9aadc149614bb279e42a9db4f@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 16 Jun 2020 10:27:13 -0700
Message-ID: <CABBYNZLfApj2grWJKe7Do5cas_+=AWdAX7ZWRybx4LO4bKuRHQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] lib: Correct the name of Add Advertisement
 Patterns Monitor Command opcode
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao,

On Mon, Jun 15, 2020 at 9:32 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
>  lib/mgmt.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/mgmt.h b/lib/mgmt.h
> index f44f2465d..bb31156ab 100644
> --- a/lib/mgmt.h
> +++ b/lib/mgmt.h
> @@ -673,7 +673,7 @@ struct mgmt_adv_pattern {
>         uint8_t value[31];
>  } __packed;
>
> -#define MGMT_OP_ADD_ADV_MONITOR                        0x0052
> +#define MGMT_OP_ADD_ADV_PATTERNS_MONITOR       0x0052
>  struct mgmt_cp_add_adv_monitor {
>         uint8_t pattern_count;
>         struct mgmt_adv_pattern patterns[0];
> --
> 2.26.2
>

Applied, thanks.

-- 
Luiz Augusto von Dentz
