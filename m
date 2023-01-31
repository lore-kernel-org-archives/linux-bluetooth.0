Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2A4C636D7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Jan 2023 02:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjAaCWI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 21:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjAaCWG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 21:22:06 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F013347D
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 18:22:04 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id mc11so15117982ejb.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 18:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SJlOo//NnyQRtXCAg7oRYYTwGMe/Y0tVPk/IwjimmSA=;
        b=Q8Xl3JFiCnghwz/mY4qoC7dOM4H0NZM7oxBiqsrrjuTdoiFa0B4Vn9W/bHVw3pkgUx
         GeCI31BYpx8euLV5CsD6CI7RQPqPYDnbxzNP0SyX8MsINzdam/bVdbZSNmU6A26HR2mx
         YkgYUQxLatXtJULhBhVdVDoYZ5bPTKVHvGLU/mhjdtm7JBsx4z4JM3fd3/aeZfiMbAlN
         dRgq4nHCnEjcI2XJeLfckP3hIxjvOfoZ/0kdE+OLWopRu44Sa1slidKpP8SbeMkSedu/
         z01STutxSvUIRX1eqxt1W38pQ6BtFZsaWqFQzgKbpq8zAxniZSVv8jASgKId+AZxXJfh
         51Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJlOo//NnyQRtXCAg7oRYYTwGMe/Y0tVPk/IwjimmSA=;
        b=yxUvqH9BrzVIxAUYLHE6ZKVNYR/FNwcsKng7YTWQTAZeliXBV40ToU97g6CRwLJMAA
         re9GyQItB1zuRRjoTCGXAlcafLGEIz7QVYskOSl3fhc0u5P58HX31nLVgk+LyuBjDFY/
         /okyF/KlJCcJZIByn2fALZVNmCgFHrTc9FDQAySBmQDzo4Tmkm+ZC1ygngL6w7+jB9Bj
         +K4NjYnWKPzHx/qVPWtY2Igah9/lxpopPnxyIzv41LVWrL5nIPgEd6WDDaidK05OK5+G
         /LIj/lWUXyJChz5gACLL28Erv5LSCUGFT9qwUJcbdJn/3z1caZjfQU9qYOv9FFFd7VGN
         Womw==
X-Gm-Message-State: AO0yUKUzU6lp/BWtigz8Hi9kbRET0KS7oBp7RFiHqIkrPH5WwrC9nerk
        YqpWbSlo/7U5O6MkNpVeWiDzgSH0/acjD4eVgpVKiw==
X-Google-Smtp-Source: AK7set8X/VWcBLz8Gkx/q+RO26aEHLZ9YC1cRzWZB8juJMU+rW+4PVZg7TOlZRqXNNg62oogE2gKcDvk7wQ7KnrXyVM=
X-Received: by 2002:a17:906:289b:b0:87a:574a:617d with SMTP id
 o27-20020a170906289b00b0087a574a617dmr3714217ejd.155.1675131723446; Mon, 30
 Jan 2023 18:22:03 -0800 (PST)
MIME-Version: 1.0
References: <20230129215136.5557-1-steev@kali.org> <20230129215136.5557-2-steev@kali.org>
 <20230130222337.GA3628858-robh@kernel.org>
In-Reply-To: <20230130222337.GA3628858-robh@kernel.org>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Mon, 30 Jan 2023 20:21:52 -0600
Message-ID: <CAKXuJqhYZ7bLeWq1N_zabOaN2UamhhNu6g-vmtO9ShDA9Z8=JQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: net: Add WCN6855 Bluetooth bindings
To:     Rob Herring <robh@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sven Peter <sven@svenpeter.dev>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Rob,

On Mon, Jan 30, 2023 at 4:23 PM Rob Herring <robh@kernel.org> wrote:
>
> Proper threading is all patches are reply to cover letter.
>
> Drop the last 'binding' in the subject. Don't need it twice.

Sorry, I'm not sure what happened with my threading here, I changed
chainreplyto=true to false in my .gitconfig so hopefully v2 will come
correctly.
