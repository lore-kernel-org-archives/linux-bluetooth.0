Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F67C41513
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Aug 2023 08:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjHFIBm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Aug 2023 04:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHFIBj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Aug 2023 04:01:39 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B1D1FC4
        for <linux-bluetooth@vger.kernel.org>; Sun,  6 Aug 2023 01:01:37 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3175f17a7baso2571989f8f.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Aug 2023 01:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1691308895; x=1691913695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L8LIK8Fu0/zVJT/CZVS1ttUz3gAb8D8U8YN7LnPrWsM=;
        b=aqB6cmLHXAUBLsGa5B2y72G8pDjBu3f1LcXHw6eEd4Y68NGldat1eNdVIR0kwWRQKI
         yZJpZI5yTw3esYLaFooO9ujP7grnIE874NyTDI7Owvqf9uA/8IT85QH6s7e6bhnwK7Xm
         ylUvZCwTkyb2M+sxZlGGa6Bxkv4WLhwzRIC8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691308895; x=1691913695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8LIK8Fu0/zVJT/CZVS1ttUz3gAb8D8U8YN7LnPrWsM=;
        b=GfUi/WSlJHgpwUZomrz+Ns31DsKO7rMikHZnPzkyVsWNqAGGfxUBUgYWznvqMmwoNH
         B6xxOphJcp9V1vwTjbO1Irq9YhQWcJmYlW2oUKJt8d16xAFgEmDemfWqN9fXFHvKVqUS
         AgSd2w3N7SJght/e9VwQX9giSRf4AqwngJc0ZioJyCfD5KHGOrs/p5UyUeZ3YFD6h1ns
         yrT13yu0xv12abRWL+FDk+3hcAYFAT+ksvYsfBTp8qcy0TVWYHFB7vU4OsiSDp6Wx+8A
         3RyxaWyGEBVuuGnl/EZ/FqnF+3G8PtlE2BxtpyiRLOV32kNUSNp2OUal8aI4J2DPpXpQ
         Kwug==
X-Gm-Message-State: AOJu0YyHmqpB6eQhJfSc/zbs5X8xYeFEYJInP9c7642KIxPZ9sQlMR2M
        afw5sRNGZDfgU+myyFq+zMiXhAJOvZoODLVgtuk=
X-Google-Smtp-Source: AGHT+IF7dEpJ2nUh154Y8UcQHNDRruh3ZvrPMAUZ3SFyA27U25Bp1qsW5zrHuSfbdpZZxV99uPwJXg==
X-Received: by 2002:adf:fecc:0:b0:313:ee2e:dae1 with SMTP id q12-20020adffecc000000b00313ee2edae1mr3562198wrs.18.1691308894950;
        Sun, 06 Aug 2023 01:01:34 -0700 (PDT)
Received: from Legionbuntu.. ([2a01:c846:10c0:200:9bf4:d5f:8c8:5ad6])
        by smtp.gmail.com with ESMTPSA id u7-20020a5d5147000000b0031437ec7ec1sm6974156wrt.2.2023.08.06.01.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 01:01:34 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 0/2] Report proper error on connect
Date:   Sun,  6 Aug 2023 10:01:07 +0200
Message-Id: <20230806080109.1639693-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When we connect A2DP profile and remote device doesn't have our key
(e.g. was deleted) we've received "unknown" error.

These patches add mapping to "Invalid exchange" error which is returned
in this use case as "key missing" error.

Simon Mikuda (2):
  error: Add "Invalid exchange" mapping
  a2dp: Expose "Key missing" error

 profiles/audio/a2dp.c | 1 +
 src/error.c           | 4 ++++
 src/error.h           | 2 ++
 3 files changed, 7 insertions(+)

-- 
2.34.1

