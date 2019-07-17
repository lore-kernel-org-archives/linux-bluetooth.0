Return-Path: <SRS0=OoMZ=VO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0192C7618F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 19:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C390421851
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 19:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="YZFpUtbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfGQTrQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jul 2019 15:47:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41834 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQTrQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jul 2019 15:47:16 -0400
Received: by mail-lj1-f196.google.com with SMTP id d24so24851958ljg.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jul 2019 12:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KuS3p44w3UruS4OuPrSqFeaKxSkFSr7gA4eaO2Vuhwk=;
        b=YZFpUtbrR/mm0I/cu+Fkeq9yufbZYBIgbqBW41WOJj8VkUF9BfagTVrqm/pCiNjsjv
         f4HP96v1cyJ1oL59RKctub5GD8rBCmjfiS4Jp57rKAtLeWCKaXhhyW8slVlvA23izIhs
         E41gX+RX9+/w8ZfH1dNE1gdbBtnQiNopRs9V0yrWnHv70IVMoB8bxN8wVsDQrDCrHTNQ
         /5O3maEx/AZjePFNfd6aqr6lo4IDzcTWVe2zOKewp0DLr7kmB3V+JCdi+N46nWeJ+jj4
         CvDdtK5maFHIzt5Nozd3sYhSAGfsGTfOYnWh5YHIkq3bYND25uojLsJA58QwzoVM54Fb
         8ejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=KuS3p44w3UruS4OuPrSqFeaKxSkFSr7gA4eaO2Vuhwk=;
        b=IbOJy0EQv3C7nNig9wp8OUdGNRkYH4kEKNv44POVT5guCvNzh5Y4dHzxIEteGOVS/G
         f1bxqJ8bvsExE8RIps7KlIewXuebXiMdKkjhKou3OX055blhqt0YTiWYhhRwJK1uHC2+
         dTwRyQgJ1Jy85RD5eFq8cxALFIIF8Vaix4+St+/c9F8WXcKvhiviu2v0kpb9yTNY5EGx
         GS3jfwoS6QJbakGHFtKQ8k8X2la4M68qtKctvB/cLWEGB1EoVfzC+k35KCJpS5TywZlG
         oAnLlHzI+nj6DBSV3mTjlIXHm4IS3HPEho5c/VE34m2Bw5BKekylkGt8KpQs7TaWzduE
         ISaw==
X-Gm-Message-State: APjAAAW57KUBEvl6Jnyb/4NMDx+XGVw6VO0K7c4mkra4A4SneeDO/wn2
        EBdOl5RkOC0n9SXTWmw1widX1g==
X-Google-Smtp-Source: APXvYqzrUbWvqA3qKiRRVNMBspOsgFSKlBr3Sg1pV5ytB9PZ5Fqcegj5gkEn6pKmsL3WWzenxkjgJw==
X-Received: by 2002:a2e:b0c4:: with SMTP id g4mr6519009ljl.155.1563392834378;
        Wed, 17 Jul 2019 12:47:14 -0700 (PDT)
Received: from kynes (apn-77-112-37-101.dynamic.gprs.plus.pl. [77.112.37.101])
        by smtp.gmail.com with ESMTPSA id u11sm5074832ljd.90.2019.07.17.12.47.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 12:47:13 -0700 (PDT)
Date:   Wed, 17 Jul 2019 21:47:12 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "Gix, Brian" <brian.gix@intel.com>
Subject: Re: [PATCH BlueZ v5 1/4] mesh: Add ImportLocalNode API documentation
Message-ID: <20190717194712.i4dtiwhldq2is2z2@kynes>
Mail-Followup-To: "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "Gix, Brian" <brian.gix@intel.com>
References: <20190717083650.26346-1-michal.lowas-rzechonek@silvair.com>
 <20190717083650.26346-2-michal.lowas-rzechonek@silvair.com>
 <915ea1c10883aaf1e4d42c5a749bfda964b54b51.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <915ea1c10883aaf1e4d42c5a749bfda964b54b51.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

On 07/17, Stotland, Inga wrote:
> I feel like having "object app_root" is unnecessary and also, creates
> some gnarly pathways within the code.
> 
> What exactly is the problem for requiring the composition data to be
> part of the import_data? It's just weird to say "oh, it may be there or
> it may be not".

The main issue lies on the application side. In order to properly
Attach(), the application must expose element structure via D-Bus.

If we say that it must also do the same via JSON, to call
ImportLocalNode, it leads to code duplication on the application side.

Moreover, the app still needs to be queried via D-Bus to check that the
passed JSON matches the D-Bus structure - otherwise the app would then
fail to Attach() and the user would be in deep trouble.

> Getting rid of the app_root and mandating the composition to be part of
> the import_data allows:
> 
> 1) Avoid checking whether this is a "full" configuration or the
> "minimal" one

I'm not convinced that the "full" configuration is even needed. We
certaintly don't use it in our use case, but it might be required in the
future.

> 2) Efficiently re-use the existing code:
> Adding an API call like this one may be sufficient
> 
> mesh_config_import(const char *cfg_dir,
>                    const uint8_t uuid[16],
>                    const uint8 *import_data, <import__len>?,
>                    mesh_config_node_func_t cb,
>                    void *user_data)
> 
> We can just re-factor the code that parses and populates a single node
> from the stored configuration. user_data may contain whatever we need
> to preserve in order to respond to d-bus call.

After refactoring node validation to byte-compare composition data, the
code also becomes significantly simpler, and execution paths for Join(),
Attach(), CreateNetwork() and ImportLocalNode() converge.

I've implemented this validation method on top of this patch-set. I'll
send it as RFC shortly.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
