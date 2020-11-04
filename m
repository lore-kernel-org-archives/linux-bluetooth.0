Return-Path: <SRS0=3U9n=EK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53025C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 19:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC5312080D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 19:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604516552;
	bh=l+vRHfqTUzgKMWDA2DyI5UpfWL/ttOpP1dmqjojV2a0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o7igJO+TVyvBRZ6RrmrOK/9GCgbnjtKupu/wXRnMmKOutDsUsBZjDNGIu92bSg+rX
	 Oo1kb7IgxTA4cFspajP+tHN/Az4rlTreZlAI/U5SOgfwF2ZuR8ATYk1U76z3e287Rc
	 wnFu36WofYAp0iDk2YCY+l+jbnzPoYGEhk9g9/IM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbgKDTC0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Nov 2020 14:02:26 -0500
Received: from mail-oo1-f65.google.com ([209.85.161.65]:44723 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbgKDTB2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Nov 2020 14:01:28 -0500
Received: by mail-oo1-f65.google.com with SMTP id o129so5317208ooo.11;
        Wed, 04 Nov 2020 11:01:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yjKsw7ni1G1n3PIaby732+mhl3O2uXnnb+gEy+qFVq0=;
        b=KMaTZ99MsdWchwXQw79RTzwbk1xGzzhC8H89kIolozu15GtoVFAHEkX6s+56TmYR9m
         LUpAflr8sdOdnyALwwbV1yCQFKge2lGFIBqqRbJWe433xvmmXWIILK6fOVDhRflWKh89
         2F666B/TD7d4VNWWuSWHvKvkqS3BhIbKwLiK1n7JW3ry+8567wxvGVmYiJ/gl1Evbg4U
         h42z4ZL0ju7499DtEo1wIEZiB4PZQ8SzuD5hl2ukwTKLR7pS3nXrc3vD5S4OH31z+gC/
         P8j1BBBLixeWV8zGKAa3W+fpBiLVldrNQJDJVLK/2ELDfA14Bvz6MjynprUGVkt5v1e+
         hyfg==
X-Gm-Message-State: AOAM531SubMguyyYuPdaipfVBsD4p9yoafDkCto2srgCxO6/36gkVuaZ
        dXoxj2cgKLZMpsbOOhqvZojFEA8wMw==
X-Google-Smtp-Source: ABdhPJzndO9iebji1bM/Lm/Zh51jFv150lO13UnOB06YPRWX2A2W/11ZZHbgu7UxpZXSIDQK4se0nw==
X-Received: by 2002:a4a:d848:: with SMTP id g8mr20041632oov.35.1604516486291;
        Wed, 04 Nov 2020 11:01:26 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b1sm695706oof.43.2020.11.04.11.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:01:25 -0800 (PST)
Received: (nullmailer pid 3953486 invoked by uid 1000);
        Wed, 04 Nov 2020 19:01:24 -0000
Date:   Wed, 4 Nov 2020 13:01:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     devicetree@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: btbcm: Rewrite bindings i YAML and add
 reset
Message-ID: <20201104190124.GC3950437@bogus>
References: <20201103120943.1289277-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103120943.1289277-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 03 Nov 2020 13:09:42 +0100, Linus Walleij wrote:
> This rewrites the Broadcom bluetooth bindings in YAML and
> adds a GPIO handle for the BT_RST_N line as used on some
> platforms.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
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


See https://patchwork.ozlabs.org/patch/1392981

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

