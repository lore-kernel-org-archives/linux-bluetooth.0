Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44CCC433FE
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 May 2022 21:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240123AbiEVVDo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 22 May 2022 17:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242846AbiEVVDm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 22 May 2022 17:03:42 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAD13A189
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 May 2022 14:03:40 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id a3so22327295ybg.5
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 May 2022 14:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mxiplx6RkaytXlrRSYKEQ3O7D7iVT1tPh1nthwSj52s=;
        b=RbDrWXHdFHp710mS+KTiAsacnf8zZILcSCFAvEkg5tmJgLLY/OtbMort7xqYxWhFm1
         B63F83m/TsJitosRLG9h1UU7sTJgEl2o0kxZLELo45zT7IQbsHmvcQLe85BW4Hwg39R3
         RF6agLIV8dwzLNzS0ZneQZfYKDN+0zJEyEqF4KrbH/7NdQbPKsgTypg7ov0+ZyIxNfn0
         K4Yx7/ANDGLxI4vpoC8vaRzg4kQer11hgvl5J5PUOZQ886qcziOGaC4DbWnyJ6iRGiwm
         Pwv5e1iC13g8GFOolW4/mrl5DycCQ0GMGRuBZ+H/CRK/dzIRiT/h/UN6Kqcdak6QtZCu
         AcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mxiplx6RkaytXlrRSYKEQ3O7D7iVT1tPh1nthwSj52s=;
        b=0hvTk8Rza0N63MSC2k8PSP3evTB4+1B3z5+vT6kKOORJ7IxC8nnEWpofDw5JleeqAH
         ofD+ESbUdfSIN116p0aMs42oYmM4lUhXEzWMxl8Q8Kfagv9zFvJ/lpG7OH53qlkipTqf
         dlEUXsc2pH20KimtelJBT25KMz/erJvfHX6XU58IDImPprZZaMB2tieZzquF41HPK2tG
         nsIiQrjmYZc+F/qcm5uT1Nw196Ye5bpkJlOBll9ifk1dyKO4/0+iNh9R9Pk5iuRlwnx2
         jOYvURaFVM5mGOAVI0p5I7QUyZNeWCkasJ9ipgvaqPIw0GDhQq2e29Ugw52o5N5Mh3jC
         cFvQ==
X-Gm-Message-State: AOAM530x2DO37LYIYunopk5qg3M429yVYFIs/h/9gMG2qsx2miyZHN7a
        heh2T02jL77Iy7bsErR9xO4N7DuHR/J3JySceDSNZQ==
X-Google-Smtp-Source: ABdhPJwTBwnyeOqQ+H1oLaBkNCWS83VGkpo6Am+xihPb5+nNh3oq+bfFbsJAeD9vmSzwzBPnHIMQc7QlkN/SRG5gFlU=
X-Received: by 2002:a5b:302:0:b0:64b:a20a:fcd9 with SMTP id
 j2-20020a5b0302000000b0064ba20afcd9mr18570383ybp.492.1653253419976; Sun, 22
 May 2022 14:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220521200734.421223-1-a.fatoum@pengutronix.de>
In-Reply-To: <20220521200734.421223-1-a.fatoum@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 22 May 2022 23:03:28 +0200
Message-ID: <CACRpkdbKUHu-T2whY4wgk5xnR7X-hptEg+Jm5Hudq8ieQi3VwA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: bluetooth: broadcom: Add BCM4349B1 DT binding
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sat, May 21, 2022 at 10:07 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:

> The BCM4349B1 chip is a single-chip Bluetooth 5.0 controller and
> Transceiver. It is contained in the CYW/BCM89359 WiFi+BT package.

So the BT and the package have two different names.

> +      - brcm,bcm4349-bt

Then why do you have to tag on "-bt" on this compatible?

That is typically used when the wifi and bt has the *same* name, so
the only way to distinguish between them is a suffix.

Yours,
Linus Walleij
