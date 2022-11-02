Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8F4C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Nov 2022 16:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiKBQmJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Nov 2022 12:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiKBQl2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Nov 2022 12:41:28 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDFA2EF7F;
        Wed,  2 Nov 2022 09:36:32 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id s206so19771750oie.3;
        Wed, 02 Nov 2022 09:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRIqLJzpvdwIsDIOcNax6l0J9MVGIRrkQsstguh+rBk=;
        b=g/H88GxN4bVs32cwQBEtJLJsx8INqrSR70gMgMpnsKshhMvI+MLOM+HZ3Q6Gyzmqmd
         mVkup6iheAtFWrXi6lq8gznk0eSDXoeLex1S2SnA+jNDibsY+oWuz+vaVc2MbWwvi1sQ
         ugCjhl+tSa6mTp/ZVOWLdjhLZzBbPuogH6qkCYcMOrK73XE0e9pHPInzUc3MvlTzea/s
         HWxWqI6PuzVLl1JlGJLSH2rX+/jjFI19ADbZUbWHAQmcYz+xZMPU1EvdMoO+ArblsbJ5
         R1OJE9EBLBwZOvCAzYg+lAit+geFO7U4MRU5K6fJ+KRxoXKRXNP6CjHzIWatc2MRe3WP
         k+xA==
X-Gm-Message-State: ACrzQf0DihwtM3wB5nIqfIaR7DeCx3JsdJ5yXP8SGqy+trQZiPbPZCsT
        zEJZqnj+neGnkDcR0pj0ytPi5L28LQ==
X-Google-Smtp-Source: AMsMyM5u79XwB1oojudnF/swJR8GY9Ou/GyZn4heWLOqUMQVIwupIAfM9Q1SjJhm3a7xF5I08t//Gg==
X-Received: by 2002:a05:6808:140a:b0:355:230f:b7f1 with SMTP id w10-20020a056808140a00b00355230fb7f1mr22368338oiv.8.1667406992060;
        Wed, 02 Nov 2022 09:36:32 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cz40-20020a05687064a800b0013bc40b09dasm6131312oab.17.2022.11.02.09.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:36:31 -0700 (PDT)
Received: (nullmailer pid 4011499 invoked by uid 1000);
        Wed, 02 Nov 2022 16:36:33 -0000
Date:   Wed, 2 Nov 2022 11:36:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hakan Jansson <hakan.jansson@infineon.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: broadcom-bluetooth: Add CYW4373A0
 DT binding
Message-ID: <166740699221.4011442.14503424852131271758.robh@kernel.org>
References: <20221031204804.195267-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031204804.195267-1-marex@denx.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


On Mon, 31 Oct 2022 21:48:03 +0100, Marek Vasut wrote:
> CYW4373A0 is a Wi-Fi + Bluetooth combo device from Cypress.
> This chip is present e.g. on muRata 2AE module. Extend the
> binding with its DT compatible.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Hakan Jansson <hakan.jansson@infineon.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> To: linux-bluetooth@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
