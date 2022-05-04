Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811D8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 May 2022 22:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377524AbiEDWT3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 May 2022 18:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355845AbiEDWT3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 May 2022 18:19:29 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FF9BE1C
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 15:15:51 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id j2so4819161ybu.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 May 2022 15:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qLBklQTU++z1XSeA0IFDBp8dJkPyeYhGjMSHqs5VeMA=;
        b=NWe0TZcqMFAwCb8eYzInkQywqxx45yJ/Dp3UIamLDQ3fdPCvawza91uR6m3BTXZB1c
         tOFje3SBN3ZUSbpczZvytggrRDBBNbpv2xxtvzN3Yf8JFj4juv+Ixd0d4sCLqPQ9pO0M
         SkPfGB9EZ3QwwM8oegYN4MjMndK4rqiMyKtjTrkIyjlxw2cNBCk65l/GhzOjUjAI1YB/
         iA765SA3zq2F/ud9RrhWKMjOyEKO3KnEU1HU2UVlR5w75a/XuK9ZtPxe/kNs3B0zlRk8
         F9Dz7yO/Krb1igXE6UMDINeUjlXTVXHft6B128HL30WE9LHSQgnc4nqoZMqLTr8jgy1m
         E61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qLBklQTU++z1XSeA0IFDBp8dJkPyeYhGjMSHqs5VeMA=;
        b=trx4pqV9vjdoRlu/8lhGn/3dhj4bQO0iijEGKAjQO5wvDqCAT+TzuVYD68XnGAqHWQ
         FpuIDO3QBDn7ldZcK7Xa0ydRG/cmZqcRADch4N7W6y5TMpjp5OWO0CiiY/XN4ydVZVl2
         yi7CjIcwCUYs17i4VU076629NNI3IGmhR3tT5GV5g7MsbQRLL7zBEvp0tgpnehIOgTPW
         QM5PNDmFVu8eq32IihiQ2IDRkIJ3jPdhggMWQaQ5rcz6jy5Y6oWYkbH8fGUVrK3b0VYG
         uM+KCfu/dExXG/l9mOtD9IsU41tjKFnYC91scpZj13HifIQgXKHaJZTUxF4dz1vMH7dy
         1gJw==
X-Gm-Message-State: AOAM5312FihrdXpp7NnjfnGJJI2SPk4QJU//YBToaWiyyeS4COZEEWWn
        xpdlrJx03mIhLaJ6zVY4dEkPfS1I1TL6Ju2GvjWglQ==
X-Google-Smtp-Source: ABdhPJyjwpvxnoeMjH4hOqPTmTuEjrbSWm6SYSfBU1hA8Xqb22rp4DU76PZhUpFUOSMMV4MibDXJTCgu5WQIa3Kjr3I=
X-Received: by 2002:a25:aa94:0:b0:648:62f2:ef4e with SMTP id
 t20-20020a25aa94000000b0064862f2ef4emr18637229ybi.626.1651702550800; Wed, 04
 May 2022 15:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651647576.git.hakan.jansson@infineon.com> <64b59ca66cc22e6433a044e7bba2b3e97c810dc2.1651647576.git.hakan.jansson@infineon.com>
In-Reply-To: <64b59ca66cc22e6433a044e7bba2b3e97c810dc2.1651647576.git.hakan.jansson@infineon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 May 2022 00:15:39 +0200
Message-ID: <CACRpkdY3xPcyNcJfdGbSP5rdcUV6hr87yJNDVDGZdRCfN+MqLA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: broadcom-bluetooth: Add property
 for autobaud mode
To:     Hakan Jansson <hakan.jansson@infineon.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
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

On Wed, May 4, 2022 at 11:04 AM Hakan Jansson
<hakan.jansson@infineon.com> wrote:

> +  brcm,uses-autobaud-mode:
> +    type: boolean
> +    description: >
> +      The controller should be started in autobaud mode by asserting
> +      BT_UART_CTS_N (i.e. host RTS) during startup. Only HCI commands supported
> +      in autobaud mode should be used until patch FW has been loaded.

Things like gnss uses the current-speed attribute to set a serial link speed,
maybe also Bluetooth?

Would it make sense to use

current-speed-auto;

As a flag for these things in general?

Yours,
Linus Walleij
