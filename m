Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB75C001DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 05:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjG1Fb7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 01:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjG1Fb6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 01:31:58 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E6530FF
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 22:31:57 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-986d8332f50so234390366b.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 22:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1690522315; x=1691127115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=293iRzTDcP8H1DfaYWlaR8OceYF9wRtrEquD7Ji6Nn4=;
        b=Ddzdju+fNRoDEXlSIgjxjUYyGxg7eJm+gbeFcf+AwmckuUtqEm+s0t1BjZQIWjxYW7
         OU+40py6KOYZPWR6NnFBCRi6qfmR+tAshzCD6rKIVF1nc5MamkMlX14/xeyrHigpGWfA
         AVX7lTg7OTg/LWX9TyiXTH26e58EMaUtLQfss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690522315; x=1691127115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=293iRzTDcP8H1DfaYWlaR8OceYF9wRtrEquD7Ji6Nn4=;
        b=WN+eDob3rtEg192pgWjGgATGXQrAnuCjVhRKCxTXFl5Jr87PG/2829kGEUmrVFGXzk
         AKDn1MAyc2wfF7W5SIvBpQwUaVqfdyI1kXyO6KsAqWVB4dnTBaUJcXlF7+x/0fRBxjte
         5X7WM9BcKohn5cfInwHZbWLv/D9a8BNJoswEDS35/7YaRxPmiDGlENCuzK0wNLEsWqrW
         nOeISOlKzfKecbZBSaq0Gg7cW7eHBcuacyiUxknLW11yy3E/wXjO9Dw2Cfzj34wb9PY9
         iwBaSkrBfpre4OqXSflAnsbS58JTb3bMk67qR0fmhhaP8p58g786RjqZpcbRKeg9AMWh
         jbDw==
X-Gm-Message-State: ABy/qLbWzb1apX22k0tsmuCT7/7GGXQsyuj3g6OZ3T4bCWh7eiYSsvZT
        Bgujh4bUDbpm8iIs9jjqHP2TN0E+3YTB+m9pExQ=
X-Google-Smtp-Source: APBJJlGn2DdSQ3bpfHo4KRNW2bq2BDpW+7W2Rs+VWPpjQ29yNwAiOA9c0vDz5WPm8NAktv5gfHf6Hg==
X-Received: by 2002:a17:907:7791:b0:982:c69c:8c30 with SMTP id ky17-20020a170907779100b00982c69c8c30mr988086ejc.55.1690522315436;
        Thu, 27 Jul 2023 22:31:55 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:353d:c2fa:e0df:3251])
        by smtp.gmail.com with ESMTPSA id oq26-20020a170906cc9a00b009888aa1da11sm1590113ejb.188.2023.07.27.22.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 22:31:55 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 0/5] Device pairing and discovery fixes
Date:   Fri, 28 Jul 2023 07:31:48 +0200
Message-Id: <20230728053153.584222-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I submitted some patches separately.

I didn't submit patch "device: Handle error from discover services request after pair"
because there was some merge conflict, but I renamed it as you suggested.

I reworked patch "device: Fix pairing and discovery with dual mode devices"
so that both discoveries could run in parallel. Because of that I moved
browse and timer to bearer struct.

Simon Mikuda (5):
  device: Refactor device_discover_services function
  device: Rename start_discovery function
  device: Fix returning discovery error for Device.Pair
  device: Fix pairing with dual mode devices
  device: Fix reverse service discovery handling for dual mode devices

 profiles/input/server.c |   2 +-
 src/adapter.c           |   2 +-
 src/device.c            | 167 +++++++++++++++++++++++++---------------
 src/device.h            |   3 +-
 4 files changed, 108 insertions(+), 66 deletions(-)

-- 
2.34.1

