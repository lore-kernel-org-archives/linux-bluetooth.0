Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071D1CCA480
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Jul 2022 08:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiGKIeF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Jul 2022 04:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiGKIdl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Jul 2022 04:33:41 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCC521250
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 01:33:06 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id f73so7547343yba.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 01:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iVyuPPd4JS7DK+cdBbaLOh3fYIbgdPf73eEb1h+UQN8=;
        b=q0M52SkDM75AJrAPNvYIbmGuS6dUjHy4NCOmQjKKfinbsvVFAu2dCMY+vlur7Bo5I3
         wjFz16T7LRF308SFWAkRkCpQKfgJtgABgYuE4WXVkG1pKka9/653/Zc6LhNwMVEqZEe9
         2OFQD9TiXV9naJdagdAfi3UgKybWwtjsBkIZpsEzjpzhGaiHk6EwZ+fM3tu5Cl7f5lSF
         CCqZDBQslBOxRH++aB681UlW9vpMN/AzGonSGqjy1u9BoMHa1xXDkzjRAZrORub4O6S5
         eKRdPwABF+mLy1G1XG6fdVX+zVDlYdn9lIxJyyVZV5PL63jpGuYKjiaaHZpFzRFcfTvX
         XqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iVyuPPd4JS7DK+cdBbaLOh3fYIbgdPf73eEb1h+UQN8=;
        b=5cMlMtbidBN+KQMI42NZTnlCaVegJ/8wHsx0IjQlS6aIZfaLbJqxXW8ZxTUM3hHCQm
         j1O3Y+cEZtetW+pAI43QX8/XUvZJab0v2PeI9W5mabaEswY+J/vMZsgPM9FnbhjDgn+X
         Hgmsk8ARercRFPwYkiSafjGqzcgTNUq4jbdlX4pbyJn1FwHkXt7zRLjHI3f+ZQ9+40k4
         TwYvthKTHHeS4B8nV9Rr9bv01WM8IU/T6FQTYkgJdAYJOBEJ8TxJCifuGRMoNSgn9sTj
         zr9riAeD7LahQJZG5QuzYNDgtbM0DSKfRBSwCkpOv7B7l33yMcMsuzGfJcak8yXQBW/n
         Adfw==
X-Gm-Message-State: AJIora8gKwBzRrDwGiAvX+ypnk/ekyJjoHcw9nLzkscxfHAZckQAWKEc
        fzsJC7hIaoEzwiFDPlpJMenVAj8kyoCYpdx0/ra0pw==
X-Google-Smtp-Source: AGRyM1s0qx+LpwHJQ6qrX8OZQRJYw7IvTpEMihynzP8Jj2RurCYHautXi5k77p5X40nQps4/xHse5VtsSthmh11Z14I=
X-Received: by 2002:a25:fe04:0:b0:66e:1f8a:8e89 with SMTP id
 k4-20020a25fe04000000b0066e1f8a8e89mr16500920ybe.514.1657528385869; Mon, 11
 Jul 2022 01:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656583541.git.hakan.jansson@infineon.com> <3591c206eeccdacb8b4e702494d799792b752661.1656583541.git.hakan.jansson@infineon.com>
In-Reply-To: <3591c206eeccdacb8b4e702494d799792b752661.1656583541.git.hakan.jansson@infineon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Jul 2022 10:32:54 +0200
Message-ID: <CACRpkdYcpdDphKXHY46BEth3fruLfUyc9dsf7t4Y70_FSrCrmg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: net: broadcom-bluetooth: Add
 conditional constraints
To:     Hakan Jansson <hakan.jansson@infineon.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Jun 30, 2022 at 2:46 PM Hakan Jansson
<hakan.jansson@infineon.com> wrote:

> Add conditional constraint to make property "reset-gpios" available only
> for compatible devices acually having the reset pin.
>
> Make property "brcm,requires-autobaud-mode" depend on property
> "shutdown-gpios" as the shutdown pin is required to enter autobaud mode.
>
> I looked at all compatible devices and compiled the matrix below before
> formulating the conditional constraint. This was a pure paper exercise and
> no verification testing has been performed.
>
>                                 d
>                                 e
>                                 v h
>                                 i o
>                                 c s
>                             s   e t
>                             h   - -
>                             u   w w       v
>                             t r a a     v d
>                             d e k k     b d
>                             o s e e     a i
>                             w e u u     t o
>                             n t p p     - -
>                             - - - -     s s
>                             g g g g     u u
>                             p p p p t   p p
>                             i i i i x l p p
>                             o o o o c p l l
>                             s s s s o o y y
>     ---------------------------------------
>     brcm,bcm20702a1         X X X X X X X X
>     brcm,bcm4329-bt         X X X X X X X X
>     brcm,bcm4330-bt         X X X X X X X X
>     brcm,bcm4334-bt         X - X X X X X X
>     brcm,bcm43438-bt        X - X X X X X X
>     brcm,bcm4345c5          X - X X X X X X
>     brcm,bcm43540-bt        X - X X X X X X
>     brcm,bcm4335a0          X - X X X X X X
>     brcm,bcm4349-bt         X - X X X X X X
>     infineon,cyw55572-bt    X - X X X X X X
>
> Signed-off-by: Hakan Jansson <hakan.jansson@infineon.com>

A job well done!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
