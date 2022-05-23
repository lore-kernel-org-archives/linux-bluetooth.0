Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A861C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 May 2022 08:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbiEWIjN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 May 2022 04:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiEWIjM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 May 2022 04:39:12 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4353CFFE
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 May 2022 01:39:08 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2fee9fe48c2so139966297b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 May 2022 01:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ms1xiGnp9VFH8Q9WvnNJjHzsFoHcObvaufuDxPzB8s=;
        b=Uet4r7oIXi/ElVe63yV1mWhDRZ+fGIgc5OZMp+pGq/pwPrZ33OPF1HDuE/BKkaKPXK
         jQDEkdFsjwaDOM0WHhuA6doA6kC9TMW7VHOC3aArWFo8rD/XFve21eGHC2NVQEFM2Fsa
         2BBCBMxfigeAO9ep6xDQ7mXqxxb34jwF1pEXTfDTPfYT9Kc/Ugs23KFhBZSXh10RM9Zx
         AIEUjNNEc3uDMKeQMajmp/JwzZqX9O+cG6X1BA+62WhYx8hK945ueObKZ6qjPB/0xKbQ
         2KETO5q4v/umXdZUIidDW+RgYqN91R5iY8+h+dRBlHq3TGczK5IM4T4WU7a8EIkNSg9q
         r69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ms1xiGnp9VFH8Q9WvnNJjHzsFoHcObvaufuDxPzB8s=;
        b=6xyvhCSnSFGC2EnOGlh/5+aYy+ACMcO0m04+QEYF0QzpKdyGMNrFDiFKG/YwL0ioIK
         LRU2UNDbIQMj15aaDu9dc39drsgz9Cp0e2M7wkzGRhWDxWyybX8oJvYJCu9aFkj7TZ/A
         8J/Mi2fYvZlGTCykI90RMa3ILWriIb1bc4rHsWj0S6da6RFt0bArxys2meUDU87FbZNe
         IkY9tsZHgo3Vg4HEROJXbKsWmTUwLdkWJvJVQxy3oKaiN6s3mNVvTjP2e+VkkHDl6ssu
         bq0NQXDALEzuEgybmjkATVQZt4LlFEhydsLk4cOVJE0vMC3taE09J1y+nC/1YNFAwt7j
         QoiQ==
X-Gm-Message-State: AOAM530vQisgD//lIMtI2AM2sPat1PLtpNnfdanmh8oED3zL6bmxyQCQ
        9fWqzGluAnvAWvw0NwpBjdBVaVCiqpktm6MP7qXK3A==
X-Google-Smtp-Source: ABdhPJzVCJisNVWwF/tRYhS+3OQBbnOrRKNdHmqe9UxkbvUyiNZVzi+GLJWTPkxmpI2apsjpExrpugAd+DKqFmDQJAE=
X-Received: by 2002:a81:a107:0:b0:2ff:e11d:3ad8 with SMTP id
 y7-20020a81a107000000b002ffe11d3ad8mr5164601ywg.448.1653295147509; Mon, 23
 May 2022 01:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220521200734.421223-1-a.fatoum@pengutronix.de>
 <CACRpkdbKUHu-T2whY4wgk5xnR7X-hptEg+Jm5Hudq8ieQi3VwA@mail.gmail.com> <80306a31-462c-4ce3-5c54-c0f74ad828f8@pengutronix.de>
In-Reply-To: <80306a31-462c-4ce3-5c54-c0f74ad828f8@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 23 May 2022 10:38:56 +0200
Message-ID: <CACRpkdbR_pbQ7L4m8oYt3PN4QT0oXx2-ESHWNTt=QRcpH_gOrg@mail.gmail.com>
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

On Mon, May 23, 2022 at 12:16 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> On 22.05.22 23:03, Linus Walleij wrote:
> > On Sat, May 21, 2022 at 10:07 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >
> >> The BCM4349B1 chip is a single-chip Bluetooth 5.0 controller and
> >> Transceiver. It is contained in the CYW/BCM89359 WiFi+BT package.
> >
> > So the BT and the package have two different names.
>
> The package also goes by the name BCM4349B1 apparently.
> Cypress support had later confirmed BCM4349B1 and BCM89359 to
> be the same chipset. I should probably rephrase the commit message.
>
>
> >> +      - brcm,bcm4349-bt
> >
> > Then why do you have to tag on "-bt" on this compatible?
> >
> > That is typically used when the wifi and bt has the *same* name, so
> > the only way to distinguish between them is a suffix.

> I think that's the case here too.

OK then!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
