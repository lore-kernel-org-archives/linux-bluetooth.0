Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9287CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 May 2022 20:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244830AbiESUth (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 May 2022 16:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244791AbiESUtg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 May 2022 16:49:36 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FFE986D2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 13:49:33 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id i187so8810842ybg.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 13:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DpIUn7t2KpByY+C3exdjmM1g7bDyPkhbaj3F539P5Ug=;
        b=be4+zMYgHWBD0Fm8gVi2/TF2wY6TpO20KB8n9nn225sOFXquQQ+GoLMQiUSJNsfP6i
         gmJAonvgLrXHYk9VmEPiweCwS65SJMfIVO5JYuA8w9vKBFLNDlShjOZi+KCXwiynlmG9
         S8DHJbSI4WMsxIROerIXKHNZkJoZ+WizMBwk6nnEs8nr4zB4sDOemcxFX5uHEjs3hytF
         Jsxmn+qmKyyz1q+0LMNv6buvXZQ7SrCN29zqwfhIR1UAk2ssVXStQdAqbfDL++oyR1p7
         HQuUylF8EV12p+x5M82glvEBSmbBj26M0qPJoTrlBWv2hVuehOplhtgYQHtqTGZIsRr8
         zW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DpIUn7t2KpByY+C3exdjmM1g7bDyPkhbaj3F539P5Ug=;
        b=IgdFlY+z9w2eg4O8kV6QhLRQhWXBr36fhzUkwH23PfvAwBlzDjepBOYXgp6wey0Pgi
         obAqlcP4C3xKNA+blx1UMEVM1zMvpTNGwBGHfqxP76eN38woa5zkuF2aFzQZaRYE3B8X
         Kwqb2hakF5UxyDifFjAuFWxPheivTIUIOkfsLj6hce45/8ZXcNV2GVD00gDGxim/43dW
         QJyhIs6aUVdqwjKZJ+5Xstv0fczcn6Ul5B2ZUiNt9T2AX/sjQL3SnL+g5QMDtQPe3tU0
         VAVAt0iqFmNAVcFJDECxssA2uwnDgMhsV473uEEUHfe/7Jmo/CwUxadG3iwiu3RZb3JC
         yOQA==
X-Gm-Message-State: AOAM533A4UMjd/a+ZpdFeF0pD3D7ufszwOH7Prpu3QT+DXe5zJvn7xbG
        PdC6K2qNP30WobZWo3h7qgp+ZIqh/AAPtxdHLpEozA==
X-Google-Smtp-Source: ABdhPJzPxhkV/Rn/SuoG3prTwHYeGQr3LSPIIJaKxjOHyoF0SbdUm2tlYi6vaiBt8JFzR0b45ZPy7nHSil3uJWZmlz8=
X-Received: by 2002:a05:6902:526:b0:64d:b6ab:f91d with SMTP id
 y6-20020a056902052600b0064db6abf91dmr6490609ybs.295.1652993373117; Thu, 19
 May 2022 13:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651647576.git.hakan.jansson@infineon.com>
 <64b59ca66cc22e6433a044e7bba2b3e97c810dc2.1651647576.git.hakan.jansson@infineon.com>
 <CACRpkdY3xPcyNcJfdGbSP5rdcUV6hr87yJNDVDGZdRCfN+MqLA@mail.gmail.com>
 <1e8cfbc6-8452-0e87-9713-536d235e5b51@infineon.com> <CACRpkda4ByrS8RGAunno_S59+Y2yado4eObzwsVkM2Q=n-B+CQ@mail.gmail.com>
 <d35fff90-ded7-2b1a-0e1a-f2db14cc4d07@infineon.com> <0dffeb79-3182-fab1-e25a-aab4107beb6e@infineon.com>
In-Reply-To: <0dffeb79-3182-fab1-e25a-aab4107beb6e@infineon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 19 May 2022 22:49:21 +0200
Message-ID: <CACRpkdaea+35bn-fa0JcfYvi+SMvHUxzmWJHeCHwV82+eodCGw@mail.gmail.com>
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

On Thu, May 19, 2022 at 4:04 PM Hakan Jansson
<hakan.jansson@infineon.com> wrote:

> I checked the state of this patch on Devicetree Bindings Patchwork and
> it's marked "Changes Requested". I'd be happy to revise the patch but
> it's not clear to me what changes are requested. Could you please help
> guide me how to proceed?

Sorry if it's not clear but I'm essentially requesting that the document
describe how autobaud mode actually works. The binding documentation
must help DT authors to know what they should do with this property.

Yours,
Linus Walleij
