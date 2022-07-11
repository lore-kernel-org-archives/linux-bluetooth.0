Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5B4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Jul 2022 08:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiGKIfD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Jul 2022 04:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiGKIef (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Jul 2022 04:34:35 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2F365AB
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 01:33:39 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id h62so4949447ybb.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 01:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EMqz2RlRm0bA+8FrAifa7ABlwpjofLzKIEAi6/6vrLU=;
        b=QKeG1HHzJRHD0H/6LGGRINRsdCGiSnl5uUKdMUCuRhoYEQWRC6lTS+Lg7OFSPp0Xde
         FzHjt7jdbpTAbnN6Jk+F2iFxW0E4xi6OZ4xViAlRMe4f32/oV2TBD2YkUuR7r3fxPLTq
         X6k8bwRixqOnzTktO8gylxnb40UV8/WQmW3TtPx3YI5kXXnuVtKItv//X7gF9nK4l1yr
         UThHrRJoTlJXI+JvK+46nnLHNvY/ytS4iWI+Khd71Lus0RJNVZZsSf5BWb3LGKvhdvnB
         va3XO+T+ZMk+hoA4l40QpdtwNt6T3FjNHvZzByxIbl+TY0KheOYDL8R7ZZPzFpvbXv5L
         LoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMqz2RlRm0bA+8FrAifa7ABlwpjofLzKIEAi6/6vrLU=;
        b=mHNzBk14F5qm3p9UZTBYq6WcmlaPpY4W2eoHhsc/PvS3eD/3dEBVfeK/3ReCkkd3jG
         7DUJaQr0fmjzcf3QNGG6QIpOP07+jRUDxaec+Z3qktjX6SRkIiouLB1d5upOTkcKoCWd
         sZ97QEJ6qkzGYmc1j2lUgvIL21p+Yh5k7jMnHkDIosQWzKPSzOHHYCn/4aHKZDWRE7+a
         4+fEDQ9cQGy3KVeuPI5cKm51O/pfAye9QdyyKvpov61xuP4EBW3fPI93jkLrG1GiosX0
         fKfC5RkhtFSviIMr2eoVSXU+TYF3uU3Knl7UgxaC1N2iHwXfEdTV/KoZ+cnDyESX2BK7
         s3ew==
X-Gm-Message-State: AJIora8s73cGc90NMigL/a787ipGRYRB2TTV0uYmxLCG4vzIwgsPKz/d
        BD7+P04r/8x7o8dHyF6Eu8yBBgPcd/je8PvvBUVuhg==
X-Google-Smtp-Source: AGRyM1tBz8gehbsWzZ67YSk/1SanF3vkLhKYyrfaxSuuZmsIkaaSs9/LHvYZeiqbGDliuQnewe2hn0FUU2grp/OroJc=
X-Received: by 2002:a05:6902:150a:b0:66f:8a6:be47 with SMTP id
 q10-20020a056902150a00b0066f08a6be47mr8237660ybu.291.1657528419365; Mon, 11
 Jul 2022 01:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656583541.git.hakan.jansson@infineon.com> <6d17c74d01e785ca7db21d611a5722943aeffdd3.1656583541.git.hakan.jansson@infineon.com>
In-Reply-To: <6d17c74d01e785ca7db21d611a5722943aeffdd3.1656583541.git.hakan.jansson@infineon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Jul 2022 10:33:28 +0200
Message-ID: <CACRpkdb4U0xZCSwfip4EoPzMcPjn9wUvsw1bjrjTQpb3AHTxZQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] Bluetooth: hci_bcm: Add DT compatible for CYW55572
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

> CYW55572 is a Wi-Fi + Bluetooth combo device from Infineon.
>
> Signed-off-by: Hakan Jansson <hakan.jansson@infineon.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
