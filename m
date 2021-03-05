Return-Path: <SRS0=2LFz=ID=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17EDC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 17:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A88C0650AF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 17:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhCERqG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Mar 2021 12:46:06 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:38316 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhCERqE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Mar 2021 12:46:04 -0500
Received: by mail-ot1-f53.google.com with SMTP id a17so2592792oto.5;
        Fri, 05 Mar 2021 09:46:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=nOKtk0y5WMQw47OTedpnXuJ5YQISVB72ATji7kcK9eM=;
        b=Q8qt/68EalyoBIuYjAS3GLtYm/qsEpQ4dUnttvLH82zlbvCj0SeW1FFbe8fbkLTjSC
         qRSurbUUXeNOKQ2uMqmvtQGF/fXaXBm46wkzniHQHu2roh5vVUxjCkQ+12h70+eW0rYA
         y5ulq00zdIBgFux/RV13tk1+vLqASLUee89qejbBr7tJnyR3zPp4SWIipEsIiGvEpBgq
         v9HqajPHPooo2xG/JPG9JfjFlFkBIru0CjZEeD9D5dMenhmgvW5w+L9y8t7o0YjH/stG
         TAokWW2vYoai2Na8fWld76yEuEjuwnBHzt4d/d1pvOdMt87BXXUu1bCNYseBmRIEkdmx
         X/zg==
X-Gm-Message-State: AOAM530nQcCwBpmYgkOKnjR6/hni+Dd1Qbx0QvLELoLk4Gnyz0dahyQW
        551MjkLvvLOCebDGEgWFWw==
X-Google-Smtp-Source: ABdhPJzB21BEzMOy3cPZ61yFLrnbNdGM+BT9Nq8FRNw0k/eUVObTt4OrBFOMGytkHQvyP0UQAdm43A==
X-Received: by 2002:a9d:6c88:: with SMTP id c8mr9078064otr.87.1614966363818;
        Fri, 05 Mar 2021 09:46:03 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n17sm680206oos.20.2021.03.05.09.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 09:46:03 -0800 (PST)
Received: (nullmailer pid 368864 invoked by uid 1000);
        Fri, 05 Mar 2021 17:46:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20210305132343.2070583-1-linus.walleij@linaro.org>
References: <20210305132343.2070583-1-linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2 v2] Bluetooth: btbcm: Rewrite bindings in YAML and add reset
Date:   Fri, 05 Mar 2021 11:46:02 -0600
Message-Id: <1614966362.385480.368863.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, 05 Mar 2021 14:23:42 +0100, Linus Walleij wrote:
> This rewrites the Broadcom bluetooth bindings in YAML and
> adds a GPIO handle for the BT_RST_N line as used on some
> platforms.
> 
> The Ingenic UART binding was using this binding in its
> example DTS fragment, however mistakenly using "vcc-supply"
> for what is called "vbat-supply". The proper DTS files
> and the code in the kernel all use "vbat-supply" so
> fix up the example in this patch so we ge a clean
> check.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Fix the error in the Ingenic UART binding example as
>   part of adding this patch.
> ---
>  .../bindings/net/broadcom-bluetooth.txt       |  56 ---------
>  .../bindings/net/broadcom-bluetooth.yaml      | 117 ++++++++++++++++++
>  2 files changed, 117 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>  create mode 100644 Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/ingenic,uart.example.dt.yaml: bluetooth: 'vcc-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml

See https://patchwork.ozlabs.org/patch/1447828

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

