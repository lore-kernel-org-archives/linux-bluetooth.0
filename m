Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C900FC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Nov 2022 16:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbiKBQlu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Nov 2022 12:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbiKBQlJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Nov 2022 12:41:09 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389532EF1E;
        Wed,  2 Nov 2022 09:36:22 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-13bd19c3b68so20875063fac.7;
        Wed, 02 Nov 2022 09:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFVT7qENyjXHnSkuoYahA0kqn/fglcVPOsEKuaswmoM=;
        b=uqKUaiN//RqYjtx/12rK5YWJb+3XiRiCFiWkaPXMdLy3ZzWT7Ucr3CnSQ4URkbgoxb
         TuVSyTZ3zvmqtDY4R9xqmvY04TNgZ5jQc4lNQ0fjL/tfE8IocHPf+2h3d8QGjz2PbaJw
         xY+G1if4i5XRU6GyuXxpvoMZ3iR4oiA6PhcEKV3D/pQRkg2ro4lkbAXhCpHPuWTmd384
         OyFK0HWR4jaK59PSaY8vhyoUMDl61wCfV8gkRks8mAwLsc02D86fsF+z572Qj46B2nSg
         RPIo/6tMDVOpoQtgND4Qk2czCM358Yv4laibyDRlgW6YEGMoDIRQT01N6u3azu60DvMj
         lTpw==
X-Gm-Message-State: ACrzQf0HqmN+2UUjmxKaIoCA62cAjPmhtlYXiVFAbbvX9rU9i0XtUnJv
        eijDg9ryGhCTSy4jAlVcjA==
X-Google-Smtp-Source: AMsMyM5TdZsKbDF2JrMovZBOpQZyMWopwa8Kx6/lvJdZYjG2G//px+q77MTak0WmLbCxy21WqAbv+A==
X-Received: by 2002:a05:6870:960c:b0:13b:f4f1:7c51 with SMTP id d12-20020a056870960c00b0013bf4f17c51mr14732860oaq.232.1667406981502;
        Wed, 02 Nov 2022 09:36:21 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n1-20020a4ad401000000b00425806a20f5sm4603420oos.3.2022.11.02.09.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:36:20 -0700 (PDT)
Received: (nullmailer pid 4011271 invoked by uid 1000);
        Wed, 02 Nov 2022 16:36:22 -0000
Date:   Wed, 2 Nov 2022 11:36:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Marek Vasut <marex@denx.de>, linux-bluetooth@vger.kernel.org,
        Hakan Jansson <hakan.jansson@infineon.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: net: broadcom-bluetooth: Add CYW4373A0
 DT binding
Message-ID: <20221102163622.GB4006397-robh@kernel.org>
References: <20221031204804.195267-1-marex@denx.de>
 <CACRpkdZPzFivWwQV1X8qWfXdrTmrx5gHCk0ZMKJ+5ovNPgqxrw@mail.gmail.com>
 <CABBYNZ+CgFbKtLsvwbZOo=NA=rgnaKDY0wWRUKTccBm39F+HPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZ+CgFbKtLsvwbZOo=NA=rgnaKDY0wWRUKTccBm39F+HPg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Nov 01, 2022 at 03:39:21PM -0700, Luiz Augusto von Dentz wrote:
> Hi Linus,
> 
> On Tue, Nov 1, 2022 at 3:30 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > On Mon, Oct 31, 2022 at 9:48 PM Marek Vasut <marex@denx.de> wrote:
> >
> > > CYW4373A0 is a Wi-Fi + Bluetooth combo device from Cypress.
> > > This chip is present e.g. on muRata 2AE module. Extend the
> > > binding with its DT compatible.
> > >
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Should we have these changes in bluetooth-next or dt has a dedicated tree?

Most of the time, they go thru the subsystem trees like bluetooth-next.

Rob
