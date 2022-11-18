Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC57CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 17:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242523AbiKRROC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 12:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242482AbiKRRNf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 12:13:35 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA02CD2DC;
        Fri, 18 Nov 2022 09:13:34 -0800 (PST)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 43C19C9C23;
        Fri, 18 Nov 2022 17:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1668791612; bh=apPOJWrI+8oml1PmcoEWwnJiflUBZ+IttCDrVn4BrbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KKNAInBA7AbvAJuaPoOnsgdH0KNymbL8QuY4cAuca6yENAx3Envl5yAMs8cyOIB0c
         Vk1dK1GPHhoV6+fZcRK4ZvjZwai47OnDAJGm/4zNwTrGpfj051eUqI77zbZI9QKpeh
         X0EKkwUNB5/9n5uAnyg9kEway2OX2HZBS14efBXI=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-bluetooth@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: bluetooth: broadcom: add BCM43430A0 & BCM43430A1
Date:   Fri, 18 Nov 2022 18:13:31 +0100
Message-ID: <2122234.irdbgypaU6@g550jk>
In-Reply-To: <20220924142154.14217-1-luca@z3ntu.xyz>
References: <20220924142154.14217-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi all,

On Samstag, 24. September 2022 16:21:55 CET Luca Weiss wrote:
> Document the compatible string for BCM43430A0 bluetooth used in lg-lenok
> and BCM43430A1 used in asus-sparrow.

Asking again if somebody could pick this patch up, it's been sitting around 
for 2 months.

Regards
Luca

> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v3:
> * pick up tags
> * resend
> 
>  Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
> b/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml index
> 445b2a553625..d8d56076d656 100644
> --- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
> +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
> @@ -19,6 +19,8 @@ properties:
>        - brcm,bcm4329-bt
>        - brcm,bcm4330-bt
>        - brcm,bcm4334-bt
> +      - brcm,bcm43430a0-bt
> +      - brcm,bcm43430a1-bt
>        - brcm,bcm43438-bt
>        - brcm,bcm4345c5
>        - brcm,bcm43540-bt




