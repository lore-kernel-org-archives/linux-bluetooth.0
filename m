Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D77C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 May 2022 08:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiEXIJL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 May 2022 04:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiEXIJL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 May 2022 04:09:11 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B7877F05
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 01:09:10 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id q184so682929ybg.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 01:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dkLTcxs8LVH0sqAqHX3zwE0YhNnh+xIZuZ0uAeaShmw=;
        b=musaGlIUesSSFQdYuAzfEmgjChU/RErADTpoJGqFYDxCjSKWv4SZgrtDjy2TU2cJ7V
         6IcuLSp4qou81OsuCdHC8fOLeimdtdOQGQnqdkPprKogeMQ33ZnzhIDjIDCzbl+BGrOT
         9gljfGF/KKtyhiBggP6XepXiQhNVSbx7DCLzz76L8nCVN723cAbgYo8Z3pxo14FzA+Fk
         NuX2oNJKs21TPwEJlzAbXd8x6LyzNhDDD/EwaVQF7MSHy6WTZ8mYYjGC6Timo3iszaY/
         FDzE+T18UfrMu5qO0fIWDjDS7Vvm2GgGuGV5tOlzybHZNxMcLOYyMPWoQd8P14IX4Cmk
         3FqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dkLTcxs8LVH0sqAqHX3zwE0YhNnh+xIZuZ0uAeaShmw=;
        b=BXVsqoIFeCnLQ4XPem2AMvIlYgY8qEdx1sRbjbQW17HXzkj1vqX3pEPDcOY6tvpGN/
         deq9WsEYd9iVBLfVazP2ZYhjBTLWn+igxqL9dmLTaEP+37DTHuGq268lqNZyBai6ZfZH
         Yd9UrxMjXfFWUmOwNdP5IcRoEgHnB9G0W/qXz9kX7bQUPp4mkDfvpNyb3B2IRu+iBYY3
         i2gkBD/si/TkuoSPOAqGRknd90/o8oyk4wbUIucssSYKFxoiHDqTqNbhEDfMXkA41SNn
         fTA49Vut77Uk8iAY4gAt0EWORfttxKoz3n5SNoDo/48+xlRZzcH41+Np5ERleOvgap3t
         l84g==
X-Gm-Message-State: AOAM532UgK9j71Hh3+uUk457ExNWQFvB8nicy7YodQaVezO4Hvt+p36p
        ubz/fT6zz4phn3FGBvb4/KOZuGmNylQqlFoYrXzQfQ==
X-Google-Smtp-Source: ABdhPJyf5gbDLLFA40Cy6Js44+0uWmYjUNjCN43UMga6ZpyrkAqN6ZT1g0cZE+VhRqLEzvShzX0tpLzLf20WBd/xV48=
X-Received: by 2002:a25:6cd6:0:b0:64f:c489:5382 with SMTP id
 h205-20020a256cd6000000b0064fc4895382mr10347226ybc.514.1653379749486; Tue, 24
 May 2022 01:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220524055642.1574769-1-a.fatoum@pengutronix.de> <20220524055642.1574769-2-a.fatoum@pengutronix.de>
In-Reply-To: <20220524055642.1574769-2-a.fatoum@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 May 2022 10:08:58 +0200
Message-ID: <CACRpkdZm0XHfPpWwBB0Nn1h=_oOgj6xKDj24iAVqFPxtextSoA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: hci_bcm: Add BCM4349B1 variant
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     kernel@pengutronix.de, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, May 24, 2022 at 7:56 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:

> The BCM4349B1, aka CYW/BCM89359, is a WiFi+BT chip and its Bluetooth
> portion can be controlled over serial.
>
> Two subversions are added for the chip, because ROM firmware reports
> 002.002.013 (at least for the chips I have here), while depending on
> patchram firmware revision, either 002.002.013 or 002.002.014 is
> reported.
>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> v1 -> v2:
>   - No changes

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
