Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1CDC433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Apr 2021 17:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D18DF61163
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Apr 2021 17:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhDBR0z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Apr 2021 13:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBR0z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Apr 2021 13:26:55 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68858C0613E6
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Apr 2021 10:26:53 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id c16so5555971oib.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Apr 2021 10:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bvMxcaKCChTo46pOEC/LoxxRoE5k4G30BeLRtPpHPKI=;
        b=OWn4A3cNb44OrZvon4GppHWMFIcWgHEeW5ObBXugjOWWR93xxJm9D694HnT2awJsbQ
         tMuuzSWZxRtDEtCsblWlqLfK1uhaxArehzNT87fGn4KdwSLQO9wdV2C8rq0YQiKJQTTl
         q/CoskqEQM7Ke+l1777IoWz1+XFXchSJPIcOSa2VPpVfGz6UZGb794YzArMjfYS6YeXm
         ZEZyv6QMSWMI4M5bwZk+YYYIXKE/d+XUJkZ/JPgAdMNk0IvsaD2e1K+LM+bV3o3r2FuR
         iB4AM4c5Othnc+dsqpINFrqE1KdLU4NjH6G7R5+uwIVxdgT22KA/dH/vQF7nXJmOys5+
         awzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bvMxcaKCChTo46pOEC/LoxxRoE5k4G30BeLRtPpHPKI=;
        b=NBrm9ykfpjrGwVGIihPeXu5p+U2OC3z9xOH0OI7RI2g2Q79B71b1m5p3n3QirpbeWQ
         8d1UxuKwFlDF4Outq5SXScbu8X4yKW9KDuSVwjOQjpJ4bDApliLBZyn5uze21p2m2xwK
         WqPrAfAz9W84ao0ZkQ1Qd0rFhGrfpBGPM8ghV069WHrV3RJKK8Li+2gzqx90RLdJ2ClF
         zBfhXnGvyE5zW403eah1yxFjdSkktI69a/6XZObNBEY8uOy2ieTd6dAvHor9yHDPOv4i
         TW7fZpEe//k5h4iripsZl6v5qr+0EBnW+uT8sitG0DzqGko0dXSU/0PkXveHISPhmT8e
         Y1kg==
X-Gm-Message-State: AOAM532W6NWDWXQjGFGAMVCJBrrGE/TdJRMCXVzPr8e4x0g4nUsLbQ+C
        r0HrtzAPuXShwp3NRxDVa6FgnSNURpwNyfAGCcD3GQIea1I=
X-Google-Smtp-Source: ABdhPJzLJz98q58x4n0z6BvQP8oH79yIB3Y1y+gCaoAo+x4NQQtlrSkwsx3LtS89mF2Kgh8v2S003AVcnD8tjmlinAk=
X-Received: by 2002:aca:c4c7:: with SMTP id u190mr10538457oif.161.1617384412367;
 Fri, 02 Apr 2021 10:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210402100124.RFC.v4.1.I530e1c3e621abd34c342d657df119e12e576d8a7@changeid>
In-Reply-To: <20210402100124.RFC.v4.1.I530e1c3e621abd34c342d657df119e12e576d8a7@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 2 Apr 2021 10:26:41 -0700
Message-ID: <CABBYNZKPBX5tOmt-US2uPWOukbxvc0Gr8iJdWF1oRnmtkuZZ0Q@mail.gmail.com>
Subject: Re: [RFC PATCH v4] doc/mgmt-api - Return connection direction in
 Device Connected Event
To:     Yu Liu <yudiliu@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Yu,

On Fri, Apr 2, 2021 at 10:03 AM Yu Liu <yudiliu@google.com> wrote:
>
> When an MGMT_EV_DEVICE_CONNECTED event is reported back to the user
> space we will set the flags to tell if the established connection is
> outbound or not. This is useful for the user space to log better metrics
> and error messages.
>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> ---
>
> Changes in v4:
> - Removed Signed-off by line

I suppose the v4 shouldn't be considered as RFC anymore, or does it?

> Changes in v3:
> - Reserve it in Device Found event
>
> Changes in v2:
> - Use next free bit
>
> Changes in v1:
> - Initial change
>
>  doc/mgmt-api.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index cab1fffc5..5355fedb0 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -4088,6 +4088,7 @@ Device Connected Event
>                 0       Reserved (not in use)
>                 1       Legacy Pairing
>                 2       Reserved (not in use)
> +               3       Initiated Connection
>
>
>  Device Disconnected Event
> @@ -4261,6 +4262,7 @@ Device Found Event
>                 0       Confirm name
>                 1       Legacy Pairing
>                 2       Not Connectable
> +               3       Reserved (not in use)
>
>         For the RSSI field a value of 127 indicates that the RSSI is
>         not available. That can happen with Bluetooth 1.1 and earlier
> --
> 2.31.0.208.g409f899ff0-goog
>


-- 
Luiz Augusto von Dentz
