Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07401C43217
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Nov 2022 22:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiKAWYa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiKAWY3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Nov 2022 18:24:29 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E75B16
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Nov 2022 15:24:28 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y14so40725782ejd.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Nov 2022 15:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E6S+nNdWQ1t5UCW87JrKaJ127Lq2U60aD6c+3hAfA8Y=;
        b=AM6e1LcGWNdS1piCYxB0j4MBeZ70j+rv4p2/JdL+RuybWPfQm37XeSKIYDqwOjYG9X
         8aaimlCRU0rJX8FgXzD4pRmISbfZ4x8f4OoEuJO1g1fH78LM/I+EESIqKvJLXKgtHEYF
         /lp9Ac8gg4kSR7dH+AjLFL5qjk2J1NhlFT9gAog6yyAM5xYnRaIAQaLKaiRR1oAQdUsg
         OZRNaHwxe/WVYCqNNatBxg+PIazMY1QXIXBE6224RqNhjUG+QCdbJA+qnu+UwyTgdRJJ
         fJrjvgLJUvON/q0dKFdDEsFoMMOdIflidNcSxjHZTiLZ11TgR/+h37RytJzuokwABnIf
         22gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6S+nNdWQ1t5UCW87JrKaJ127Lq2U60aD6c+3hAfA8Y=;
        b=B8WrGqD1CDhNRjqkvfG47rSE55wXYWh1gMp6xQt6V0exZb653efR903PUB6qdtqWgv
         nwxeG3mb+hBgJQqMepKapgEe+H6SfozR1cg/mFCN/WAJ4Y8sFZTw01Iu2XErb+ru1dow
         00tMba6Uge9eHGTEaX1I/hZSAS8uAjvZsTYF6tvWQEVa2W98NreQlGOH6yCYGhFfNlnW
         cFRlLrKeV5QIsW2ljwklsPP3kcwX1zC8cjzPrCzk0/424EWQIH2Bg8YNtCs0w8MAc20q
         9cmjdPV2P/Vr+sPL+moz5L5NbnlFAoNQG3Jh7V5DaGHpgw9xiM7Am5mnOtCA7fo45M1S
         BciQ==
X-Gm-Message-State: ACrzQf0VOHGMEUbX9XXx03qN+NB6vjCed1CHqOR4iZ/3YQRGk+vELCkT
        o3eNxLiF3ICiol4Ncsw9XAiZ5vDhNDJQqU7cJk9Bog==
X-Google-Smtp-Source: AMsMyM4zA21Mr9vpppaNZoUZC5Crm/68IgVOaX8ZgZ1JvWqjRV7oH12YWpeDfq5qmCwmW2BZLqevdHaA0MZtBdL8i1o=
X-Received: by 2002:a17:906:9be5:b0:7ad:d0be:3467 with SMTP id
 de37-20020a1709069be500b007add0be3467mr13152941ejc.208.1667341466997; Tue, 01
 Nov 2022 15:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221031204804.195267-1-marex@denx.de> <20221031204804.195267-2-marex@denx.de>
In-Reply-To: <20221031204804.195267-2-marex@denx.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 1 Nov 2022 23:24:15 +0100
Message-ID: <CACRpkdawBXm=eJzDWzB_dEruqVcryLZic3Q2HvqKFu=SNgqtxQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: hci_bcm: Add CYW4373A0 support
To:     Marek Vasut <marex@denx.de>
Cc:     linux-bluetooth@vger.kernel.org,
        Hakan Jansson <hakan.jansson@infineon.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Oct 31, 2022 at 9:48 PM Marek Vasut <marex@denx.de> wrote:

> CYW4373A0 is a Wi-Fi + Bluetooth combo device from Cypress.
> This chip is present e.g. on muRata 2AE module.
>
> This chip has additional quirk where the HCI command 0xfc45, used on
> older chips to switch UART clock from 24 MHz to 48 MHz, to support
> baudrates over 3 Mbdps, is no longer recognized by this newer chip.
> This newer chip can configure the 4 Mbdps baudrate without the need
> to issue HCI command 0xfc45, so add flag to indicate this and do not
> issue the command on this chip to avoid failure to set 4 Mbdps baud
> rate.
>
> It is not clear whether there is a way to determine which chip does
> and which chip does not support the HCI command 0xfc45, other than
> trial and error.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
(...)
> +static struct bcm_device_data bcm4373a0_device_data = {
> +       .no_uart_clock_set = true,
> +};

Shouldn't this be named cyw4373a0_device_data like the compatible
string and the device below it?

With that fixed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
