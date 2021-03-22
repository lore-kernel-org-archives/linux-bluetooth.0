Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8098FC433E4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 16:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34111619B1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 16:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhCVQdM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Mar 2021 12:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhCVQcY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Mar 2021 12:32:24 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D035AC061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Mar 2021 09:32:23 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id c13so5717225uao.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Mar 2021 09:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P/uIpVtiQc3s6/BJAe8bK43IldyAXontUzM5N++HzFk=;
        b=WTJ0Jy3QS+xvtu/ghwTFRBk2I1Xzyt8jZe/wp+Y8wSaPzm6Wk1jPuS4/FaOMFqH5VC
         I9rMBWNTMwotEk2ywAX1ZNnHY+g4LUHNhl0TCpKn8B5ZFsx18luMBugXID1h1a0VWImX
         O3KGSxvKgFA4vHbD2dUyRNm6iU6krfF8zVpLxYkgiEzcwQwsUpW+ZCjHntb2DS6K8XCW
         nkEvHC9cQ8MaWBOqpi0uuHxTSG9Y9BYu+g/omgRmlN8e2E3J/aOdT39XQHF2ARJYgC+X
         9iPPcCxD6gscBNitCEr6BwuOVKE1q7X24DKRsg6G1FsBVF0kKcmHR86/TYVCq3ulUdOS
         Ax/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/uIpVtiQc3s6/BJAe8bK43IldyAXontUzM5N++HzFk=;
        b=b4ggTKi+zpfMfcUrckjBw43A6lLkP3q6EG8qAVt1W/RnmJr+8wxe05A4aJhRzio2tR
         QwaHCSK4UPe/BxR838aQ6ihwg6c8YyKvSyJ5gcdeDBGV4b3jwY777qq9T9geS535IYhy
         53mqdsD2afwNK3c3zC24GLSAo/MquP3+uLKSsESGbTS41PfXGrRTSP4lk7eA1VvFq+Bz
         Bic+dlf2Xr387AQJwdSwbxAzw4pdfRYDJwt38eMH0jCztQ+sYFoUMk1h6x4stZ/iCj28
         z7xV1aKLldGUHe27mAOBPMuNgVrpPDXu5Efc0IFE9MgdJQXF/xqTfiPnCP9/9E1UIEvC
         F6oQ==
X-Gm-Message-State: AOAM531ln5vD7Vq3kswICty5OUdnfqTct7ye24ZyE6MWmB+uYNkVhRdG
        QG4y717+FuN46MjxygvgquAgX1etIJih9pQcnPaNbN5BD7ymxw==
X-Google-Smtp-Source: ABdhPJzwpIDDClMdkAHIXv8OYx5RI2iNKatNiU49N3qbfkcKB4IdWAAEFyGuHpC6XICYH71pMq5YUX3bYO/FkSMvO8w=
X-Received: by 2002:ab0:45e1:: with SMTP id u88mr667353uau.25.1616430742607;
 Mon, 22 Mar 2021 09:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210316224957.3294962-1-danielwinkler@google.com>
In-Reply-To: <20210316224957.3294962-1-danielwinkler@google.com>
From:   Daniel Winkler <danielwinkler@google.com>
Date:   Mon, 22 Mar 2021 09:32:11 -0700
Message-ID: <CAP2xMbthhGqO89va4Z9VKwnZi_h_Bg1AeOdxzLfPHCM_AXJW6g@mail.gmail.com>
Subject: Re: [Bluez PATCH v3 0/2] Bluetooth: Fix scannable broadcast
 advertising on extended APIs
To:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Maintainers,

Friendly reminder to review this V3 patch at your convenience.

Thanks!
Daniel


On Tue, Mar 16, 2021 at 3:50 PM Daniel Winkler <danielwinkler@google.com> wrote:
>
> Hello Maintainers,
>
> We have discovered that when userspace registers a broadcast
> (non-connectable) advertisement with scan response data, it exposes a
> limitation in the new extended MGMT APIs. At the time that the
> parameters are registered with the controller, kernel does not yet have
> the advertising data and scan response (coming in a separate MGMT call),
> and will default to a non-scannable PDU. When the MGMT call for
> data/scan response is received, the controller will either fail when we
> request to set the scan response, or return success and not use it.
>
> This series along with another in kernel will allow userspace to pass a
> flag with the params request indicating if the advertisement contains a
> scan response. This allows kernel to register the parameters correctly
> with the controller.
>
> The patch is tested with a scannable broadcast advertisement on Hatch
> and Kukui chromebooks (ext and non-ext capabilities) and ensuring a
> peripheral device can detect the scan response.
>
> Best,
> Daniel
>
> Changes in v3:
>     - Use helpers to determine scannable rather than generating earlier
>
> Changes in v2:
>     - Check kernel supports flag before setting it
>
> Daniel Winkler (2):
>   advertising: Create and use scannable adv param flag
>   doc/mgmt-api: Update documentation for scan_rsp param flag
>
>  doc/mgmt-api.txt  |  5 +++++
>  lib/mgmt.h        |  1 +
>  src/advertising.c | 24 +++++++++++++++++++++++-
>  src/shared/ad.c   | 17 +++++++++++++++++
>  src/shared/ad.h   |  2 ++
>  5 files changed, 48 insertions(+), 1 deletion(-)
>
> --
> 2.31.0.rc2.261.g7f71774620-goog
>
