Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC53C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jun 2022 12:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345686AbiF1Mcx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jun 2022 08:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345720AbiF1Mc3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jun 2022 08:32:29 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70B82ED59
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jun 2022 05:32:27 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-3178acf2a92so115272987b3.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jun 2022 05:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RVfbgOitG18bb87yWBkH35J4JenCkCxRi/ygXGcpbt4=;
        b=tGDyMj1XdbwFx5ENUdMBx7m0pmv1IRVf63OHKrsDLJaeKTSSU2j33ObLxTEK/a1s7Y
         jrOPoEx2nYoNwN/ceD5w9u66ehVEcvbB7E3vPaR+lDZvoKpzNs1eTK0ER7hkvQe6m/VL
         vc+wfNUJ6WJ7Sye6jdDw4Ow3y/KAqjzKYuY6qwnQ9WhqpoeIWOqI32MWXDG6n7fy9Cpk
         6D931yS1B2I3am70V095kXKMLaW15fL1j0Hmj65paVEps+dGjAg7uti5JJ/xTsZ3ffcU
         /T1xlJJOoIPNCE4UuUNFGc1XtroA22QdqISWZXog6bvdHHDaXe0g6WdCDKQnW7q4V5ah
         E3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVfbgOitG18bb87yWBkH35J4JenCkCxRi/ygXGcpbt4=;
        b=jFHbVNvHg+Ey3TM53d4kbxkq+cKXPoXTtMsrAvt2oFXQ+eWjq+dIwVbDhrZV++ohhs
         b7dNeu1Sj5vS2+xhDiTtFKIFk0UnSU6vAiHRf05ZbqX5BKNCLTPps022BKSTiHxlcnWp
         +YgSZiD/ItwcXxiQZgiwzSdkvFiM5xCS/P7xlA1EjhibwWWi/IQibmHpbdGcuuNJ7VID
         0cIsiClt7PwlSbC4bgoP+FT3olM7NWUOK95xxEKvAVJE4XuZx0M1AVgo8ir4K41PtB9B
         S87rYtifI2tLUq61mG4xe6VKiUMIMK0V1BXReFal51dgMOO/To0gDZSQ8EPIGq7ZbyTX
         P+0w==
X-Gm-Message-State: AJIora9ZjQy7L+J2n8BmxH9DjT52LlZbngYCBaQiGBiGhm7aahZxNZLG
        fAIgJj6DksFFhsZqmqc2fmbwidAKsw0vfwEXyGS7xA==
X-Google-Smtp-Source: AGRyM1tZOg8a8akbWJ6uq2aHl4kzEALWqREo/NhIhOnARsOJw9Xp0MQNW5ZunAPwLkiwJuL6LtQs7iavkhL0jCc/bFc=
X-Received: by 2002:a81:d05:0:b0:317:76a1:9507 with SMTP id
 5-20020a810d05000000b0031776a19507mr21222754ywn.151.1656419547105; Tue, 28
 Jun 2022 05:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655723462.git.hakan.jansson@infineon.com> <0e3c48f0f38b167d83feb102284eaf24caa8c500.1655723462.git.hakan.jansson@infineon.com>
In-Reply-To: <0e3c48f0f38b167d83feb102284eaf24caa8c500.1655723462.git.hakan.jansson@infineon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Jun 2022 14:32:15 +0200
Message-ID: <CACRpkdZu9RrmWN+AZi_wy-UsJtdsfBHW+27Nj+n7YRSRXpoSEQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] Bluetooth: hci_bcm: Prevent early baudrate setting in
 autobaud mode
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

On Mon, Jun 20, 2022 at 2:02 PM Hakan Jansson
<hakan.jansson@infineon.com> wrote:

> Always prevent trying to set device baudrate before calling setup() when
> using autobaud mode.
>
> This was previously happening for devices which had device specific data
> with member no_early_set_baudrate set to 0.
>
> Signed-off-by: Hakan Jansson <hakan.jansson@infineon.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
