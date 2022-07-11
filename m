Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4C9C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Jul 2022 08:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiGKIbx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Jul 2022 04:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiGKIbt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Jul 2022 04:31:49 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E121C1EEFB
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 01:31:47 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3137316bb69so41345947b3.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 01:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3J9IyHuNdf4RzUYhyAwrvjFLRiRYfpINA65MRt4kKgM=;
        b=WxLDiTDJ/cGeyxc13LPwdMBwqy9mf7NUwb8pTiIlyxslwk4PbnCJ5wM4ZxQ35hQTGW
         6TdMU9/dafniNVuenzFjx8a4yzjl2UN+41lCphU9wQ862bHH/avz5vqbTBj9jqQaFTop
         t8HZ+LNAl5fhEr5lPMGTw8emV50wpE1Z0y/D+PtanoEug9S0I/UR/GQ0bIkGpXqWChXT
         CkuPZLS4pRGNHOkZbqcNlOGOWC5EV6GRURwUkV01gXNwuLub3EVxobjhfETIqSQVT9b+
         wP0ObIClelaK0DwNKkMyl6qbPjhB/sHo2bzFrYhWWiwB5gnKjXI2bQ5PXWtp/oubc5um
         +6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3J9IyHuNdf4RzUYhyAwrvjFLRiRYfpINA65MRt4kKgM=;
        b=0PW3y2l/jVbild5xfGL7brk3TbV6KH18XRZrAXAezXgwe/ulR7f6jUa3PkHtmq57hh
         n4Qrz5RhJqmE6AEvTFSlwZKZcOto+HFletbJaWqL0RkzSZ6xlYLIiqWBwWqtaho03lqb
         z6Szd6RMWKA85982lTeH5FCdHZUZFSX+vq9ia14Hp7c9/JtfZymSIDt89B32QLixvNhl
         38ujOoHgnZb1bK9PQKAJfPUyPZbYXNY+jWi2gq1UQhUsSDedLFT9pfDjqlrm1ymZexUy
         L4TwEYh/v0j0JgRuE1AEYN8LEBnWzQmKUgvk7Rbl8uHLXPUcYJDF4LBwk4CxXV+mdj2P
         zJ4Q==
X-Gm-Message-State: AJIora8t8SMJiJhJMGgsk56qxsgrjHz0tECbcoWIF3PfHDXIM8KeybEW
        07PvqlmDYxF6Uxw/yYOy9cyMCpW4jIz8RwfMqrOAPQ==
X-Google-Smtp-Source: AGRyM1u/2OXTB+9LffDEL+06zw4GuQSG0hG72hUyRzuw00qzHcEs9iDFO58dE3J4U/ALR03h0POcpnK5re78d+8pfSI=
X-Received: by 2002:a81:6cf:0:b0:31c:913c:144c with SMTP id
 198-20020a8106cf000000b0031c913c144cmr18316528ywg.437.1657528307206; Mon, 11
 Jul 2022 01:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656583541.git.hakan.jansson@infineon.com> <e3f949c067ad07a1dd34247efc49f3d913c4f7c6.1656583541.git.hakan.jansson@infineon.com>
In-Reply-To: <e3f949c067ad07a1dd34247efc49f3d913c4f7c6.1656583541.git.hakan.jansson@infineon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Jul 2022 10:31:36 +0200
Message-ID: <CACRpkdYoe1-kCepz2J3h7H15rcG-a2o6y-GHOwaC6f+ipLTQhg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: net: broadcom-bluetooth: Add CYW55572
 DT binding
To:     Hakan Jansson <hakan.jansson@infineon.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
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
> Extend the binding with its DT compatible.
>
> Signed-off-by: Hakan Jansson <hakan.jansson@infineon.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
