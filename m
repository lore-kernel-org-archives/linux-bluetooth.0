Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18EEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 22:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97C88610D1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 22:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241015AbhIPW3Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Sep 2021 18:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240999AbhIPW3P (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Sep 2021 18:29:15 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641A2C061756
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 15:27:54 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id c8so24718732lfi.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 15:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XWXkBi7iY7atu68gT71ZZEaVf2W0kM1WsfKKAtmYUFA=;
        b=AopwVjCCPIGZ1r8vZaX1wkBl4BenfCnJiGN3pnowbFamFiXCYBQiniP2FDA45DZXKK
         e57L/a0KWLcKqPskoX13b8te/WxC60Ip8r7V6iF/tGE5T8ogbRE0q7+onwdx8yfdpz7k
         Kjy1vWxiE8fvxFj5qWrfAJEX0M82XHIjXwFB1PLSlqr5CGbDqgtW67RaXoDo8O0PFzGo
         18v3/cuMiBVZjpeohh07jQLJBhiaaFdogZWNb1Kpdkwh4pJQq+Ycyiyaw5viC5sHkkAo
         JzD2PJAOS+nwpOFsmYCRNI9S0/iCXI6wgJ4+8cunq8JDU9D8Fy3AFscbM2g40LjryirL
         l1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XWXkBi7iY7atu68gT71ZZEaVf2W0kM1WsfKKAtmYUFA=;
        b=Kn0myodzgCHI1gsSy38kALyD0U1wXPTMUQHMt2wAyPaiMZL3Mu8Vbt8tFjVaH+nTpg
         8k2R4PDM8DT7o58jFJ20G1O0UjxRWSKZytk0sjDmnQCVfGSNTp7axNAoFSd67jveMUDn
         YcsLhu04TKih2yXSi2VT7cjDK2S4aIgZ3Q0eUGKpkz1gv1Vnhe9ONlMm6KZHc3enqakT
         eazhRm3WB01mlDjJI6FT3AQ3LMXWJZk5cNvC2S9O1bCGKJOSbJO8fb54+o+mPk5S4awp
         ok99MjjHbIMXZ1ZC6/1UCcDuf+0q5hWGPyEjDZ/5A1Vy6x+L6IiJmYDbrleMo4cNB+BV
         xbzA==
X-Gm-Message-State: AOAM5336s/9sCR4JLzzfi737SRh4tPsyKDTOoNhT7CqzvX/SFcvYrxiB
        nh7o/3300O+kDX13pVEEYUBFI4VCvIxKuWtFMUyoYLcQdac=
X-Google-Smtp-Source: ABdhPJxKXtIOidEmaWHCX/zod07OcGynK0tXF1rBtyFqK0cUDFLBboUEyUTmFZnMcybZdcVgrn1MRaeuUS42qDdDBUQ=
X-Received: by 2002:a05:6512:132a:: with SMTP id x42mr5728985lfu.291.1631831272820;
 Thu, 16 Sep 2021 15:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210916170528.138275-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210916170528.138275-1-krzysztof.kozlowski@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Sep 2021 00:27:41 +0200
Message-ID: <CACRpkdbNfXGfK8Z0nhMjMfnp4UqJV2p=eVjNyH8VdguGu9Ea5w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_bcm: remove duplicated brcm,bcm4330-bt compatible
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Sep 16, 2021 at 7:05 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:

> brcm,bcm4330-bt is already on the list.
>
> Fixes: 81534d4835de ("Bluetooth: btbcm: Add BCM4330 and BCM4334 compatibles")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Ooops.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
