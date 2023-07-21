Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B22EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jul 2023 12:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjGUMFX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jul 2023 08:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjGUMFE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jul 2023 08:05:04 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5D230ED
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jul 2023 05:04:55 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fdd7d09576so2983510e87.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jul 2023 05:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20221208.gappssmtp.com; s=20221208; t=1689941094; x=1690545894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fWE0+coLyEtzhTjMv+Wt8QfZk7CevxQsAMKZ2AC3d90=;
        b=C7a808wIjZJkudHTVqtUwOSpiHCIy0w2j5X3xCYPJUEr7+s3i1fkhwPljuv/1a+wkw
         RzRS9ojpKyBOKh915s+PMhIJQKPDHJO5ggA/QoHHoPMSq/drnZg+JTg0ht1mymy6SxiB
         Vv6cyBIidpWOQE0Y2Jjm+GxVfWoPFOj2CTKvksgfO4HLQkAUP7X5rkT18hpdrx2euCyc
         OhQLn6xfWnJUiLxP2dkCTBHmDhyCgLnOTXH2BhtsOCLP68QsdQSCd/FnXcnqjVePelnv
         hZU+Q6uYtgq4ZHHdepJx3JOgcdEfvFeUv7Y4HdRxz8ien/R4R5C/CZOVWIbVwjCJgHWC
         MaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689941094; x=1690545894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fWE0+coLyEtzhTjMv+Wt8QfZk7CevxQsAMKZ2AC3d90=;
        b=dDNKcaOxmXITu5CltOLcQ6bbdCFY+kNxQr8SqpQwb+KuguLV3w4WXVQ+TM/ItoRrde
         GOAH0iUuBwyRhdKNLpvH/BiOwrjKGjBhchF47HQeIMkeI9ofSMClCQLb5SpXr2qcXK6J
         D1mc2rZ9gA4+sQFFjHYM/llyJEl8sI6DKUHhWok+RFHNaKClg34ueNf3YklpV5Bj0g36
         apLAq6Pif8OMJUyaoANK/auAXSHf+8kDmWscHiPp2ZsQyBDarpNgI2ccheCYXCyVNVdn
         1l9wpKUM21EPNWALd9lFo2XHULSp/TRr0STyKPgnLJfY6KrLUZQqPje7K2pNW7XJqL4z
         h6Zw==
X-Gm-Message-State: ABy/qLaFGgLptHTY28zFHfYdolDZ1VDfU2xSaBBw7ImbN3sbi7Tsksu3
        7h+U4UVcFzV3yPRlv8zIhTdskbVT1LPdQzTSzs4=
X-Google-Smtp-Source: APBJJlFQbWs/GRkQf0edLnUY+EBUiK2FL7wDf8bs1DzPuCelyI/K6qeX9DcorIO5G1iHAdxKEzxD8Q==
X-Received: by 2002:a2e:8813:0:b0:2b7:33b9:8809 with SMTP id x19-20020a2e8813000000b002b733b98809mr1397304ljh.16.1689941093723;
        Fri, 21 Jul 2023 05:04:53 -0700 (PDT)
Received: from rymek.localdomain (217.96.247.89.ipv4.supernova.orange.pl. [217.96.247.89])
        by smtp.gmail.com with ESMTPSA id z26-20020a2e885a000000b002b6de6deb5asm907977ljj.2.2023.07.21.05.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 05:04:53 -0700 (PDT)
From:   =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ 0/4] Minor monitor changes around Broadcast
Date:   Fri, 21 Jul 2023 14:03:16 +0200
Message-Id: <20230721120320.147496-1-lukasz.rymanowski@codecoup.pl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Grzegorz Kolodziejczyk (1):
  monitor: Fix invalid Create BIG Test command

Jakub Tyszkowski (1):
  monitor: Fix adv_handle size in the set info transfer packet

Łukasz Rymanowski (2):
  btmon: Fix obvious typo
  btmon: Make BIG identifier consistent

 monitor/bt.h     | 9 ++++-----
 monitor/packet.c | 6 +++---
 2 files changed, 7 insertions(+), 8 deletions(-)

-- 
2.34.1

