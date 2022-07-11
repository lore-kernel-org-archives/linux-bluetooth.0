Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4694C43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Jul 2022 08:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiGKIfw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Jul 2022 04:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiGKIfT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Jul 2022 04:35:19 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936E0205F0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 01:34:41 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-31c8bb90d09so41517607b3.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 01:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QdbaAV5FK76Uc2eirkQA2yHXVOboe6L8Bk5p4Quu1Fc=;
        b=U1zIMqgVXWpxUf+MgxIN2kElsyLm53b1G9tMIQjlu27E0ToE7Dc6bZh/dd4NL18TEo
         oOiOjkCkyA0+hJxX54Q3Yg15DnaPCWwjraCSy5EDkgrpXR4c5Ji8VaHJd9dbusCmIbwC
         ixf/thwjLfiiFeVBLiJNfLlwTGjvfmHku6tw4/Jjy2D1Ku7l4yUGsSA/IwfcELTRhxqo
         lwCqwtAtsiiLOOS31p69ViXQwR1ElWQIVyKWRxgrsElQcHvRdRaT5rAJuTA+SJt9lncR
         WJbQKC7kZ4FkPZUFwHrdrML63FxfqlIE/gqiFFgcbt7PJP5JYUpaUyRi1ee3z8tcGbTg
         T3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QdbaAV5FK76Uc2eirkQA2yHXVOboe6L8Bk5p4Quu1Fc=;
        b=RfIuT1YluaQbk02hXwPcE0GVgEHVKN692aVlpjgV9PpxKmpAyEVaTsyXEZ05MAzFca
         j26UyY+5pB1MgRmdmwJWPzVkMo/OuRF8kSrRhonRZOt7iDWEB0c29v4wy9GgdCzTjCDa
         v26GSOI9wVeyXoo+0HjSbFl/FdIs1j9Wy3jgPvK0Nt6bV6K6Co8AT09DYQln6reKArgo
         qEU8frDlqy38WsKnjHothaBPXOPE6yk9yG5gfFBLW+0P4emRwNMBsISs0oSNYxyqLjuG
         3mdz0v50FxoVeWt0Wx2er8PFoEWEbxBDIcKOWPm7APjgh/+1BIHmm16/0IolJJyHbYhl
         IXvw==
X-Gm-Message-State: AJIora97BwCmidODHp+sT2ZaMKn+lkDTucW1GUFri8m5i1J6bzKoJ7a3
        lnAjKSOl/MxhTp89nW/363Juxlcc7CxZK9uR7IxY3Q==
X-Google-Smtp-Source: AGRyM1v2gWdKpSi1APBbZfuBwCnT5kbKZ3VCWH6h/oSBTVy+KlcaafOxwYR6NVtPsb8r6FrPyS9sUg76wAF1b27C3xY=
X-Received: by 2002:a0d:f801:0:b0:31d:851:96b8 with SMTP id
 i1-20020a0df801000000b0031d085196b8mr18316942ywf.448.1657528480835; Mon, 11
 Jul 2022 01:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656583541.git.hakan.jansson@infineon.com> <c0ac87d9f7072de6ad8ea7c9d306eacfbb4ef2c9.1656583541.git.hakan.jansson@infineon.com>
In-Reply-To: <c0ac87d9f7072de6ad8ea7c9d306eacfbb4ef2c9.1656583541.git.hakan.jansson@infineon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Jul 2022 10:34:29 +0200
Message-ID: <CACRpkdbOWdNyywooNdr-O-fpksVAwaxOn4Qr9c+oZp0Z8DqCwA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] Bluetooth: hci_bcm: Increase host baudrate for
 CYW55572 in autobaud mode
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

On Thu, Jun 30, 2022 at 2:55 PM Hakan Jansson
<hakan.jansson@infineon.com> wrote:

> Add device specific data for max baudrate in autobaud mode. This allows the
> host to use a baudrate higher than "init speed" when loading FW in autobaud
> mode.
>
> The device specific max baudrate in autobaud mode for CYW55572 is set to
> 921600 bps. Devices without device specific max baudrate in autobaud mode
> will use init speed as before. If no device specific init speed has been
> specified, it will default to the bcm_proto default 115200 bps.
>
> The increased baud rate improves FW load time. The exact load time will
> depend on the specific system and FW being used. As a rough indication,
> the FW load time dropped from ~9s @ 115.2kbps to ~1.7s @ 921.6kbps in one
> test.
>
> Signed-off-by: Hakan Jansson <hakan.jansson@infineon.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
