Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174E4C6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Mar 2023 23:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCKXgs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Mar 2023 18:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCKXgr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Mar 2023 18:36:47 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571614AFED
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Mar 2023 15:36:45 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id m6so11283466lfq.5
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Mar 2023 15:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20210112.gappssmtp.com; s=20210112; t=1678577803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C0UOGtkr/H+BOMU0VY7YaEj9CG6g0C00RJHxUG8Fyq4=;
        b=xfrRLzpg2otgW128fYigCjmq8+TK4i1K6XQFiZlJjyng/ZtQ5FYNQ40F+QLjyvcj0/
         DHVn7DknofghHZXke5Ji3hWVc1CnMoS0js64HuiHtG684G2+4Qy2EdVBtAwWA9DwThpu
         NkN4rkU25fRDOSWUZA0fj5j+0yJPAFW2BVOXoMHrrarLJIM3XHX/6OFwWZOKo4DfpD8s
         z4m6CQ4hnz+Ve2pMIEVMxoc+tTsho+obiKQQRpukH0QkgBWCgiJCGb3ihozLEbkU4rMw
         RcDdHXgwElQRnZMQwJijkb0bo8XXvU32eeHvXGHSJLDYyP2U+gbEl/X7PM5fmnnHphnL
         460A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678577803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0UOGtkr/H+BOMU0VY7YaEj9CG6g0C00RJHxUG8Fyq4=;
        b=voj6NMaBYC7tLOmObeYnTYKYhaNA7KOBnM6+ekwe/TLec66YrqyUH31n3J+VVWDM8G
         JRkbfmu8l2D/q5PNmK60ixXdvZ8ppW8e72X8DjiHaxo1kA14wo5VTa7OpPeQIaKQ7bUJ
         XFh6EgXMk4AGMtaYtWal3+NSXifRwBDsdKPd4cX/RvJhPZMqD9hykQjbto9aq1Cq6pBD
         hMmgj2r27/74Nx9o90+JL1E9dNs3/eiWb1V6sjwPV9e4x0lJNl09AgNghT2rBWksvPlu
         e/Cf1/l9N489XAhrcjjpFYg5dYhMPqavGKcOS8n/lTi8O0u/i7f3aYVrhvkingp5/nK5
         Sa6A==
X-Gm-Message-State: AO0yUKWCTbek9VTcao+geCChPCwu1PbCi/KQU+n/FmQEOhGDxt7yE3y1
        oVWuthOIKLC4Hspokszkt3AuiVTC34CbXumzSMOoJg==
X-Google-Smtp-Source: AK7set8BleO7+aU6SBD4sF1ac6oIaDveuHyqleV3zLzHakxj4kSmyb0bzocd0YNDgeiczpDlsE8KeA==
X-Received: by 2002:a19:7516:0:b0:4dc:8215:5531 with SMTP id y22-20020a197516000000b004dc82155531mr8801784lfe.6.1678577803238;
        Sat, 11 Mar 2023 15:36:43 -0800 (PST)
Received: from rymek.. (80.49.185.123.ipv4.supernova.orange.pl. [80.49.185.123])
        by smtp.gmail.com with ESMTPSA id r10-20020a19ac4a000000b004cc800b1f2csm445260lfc.238.2023.03.11.15.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 15:36:42 -0800 (PST)
From:   =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ v2 0/1] Btmon: Fix handling not complete packets
Date:   Sun, 12 Mar 2023 00:36:39 +0100
Message-Id: <20230311233640.103858-1-lukasz.rymanowski@codecoup.pl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When for security reasons or any other, packets in the btsnoop logs are
not complete, then Included length is smaller then Original size.

For the moment, Bluez always assumes to get complete packets.
If it not happen, then it stops decoding after fist packet which
Original size is bigger then Included lenght. e.g.
In the file where we had some ISO packets but with payload = 0,
btmon ended like that:

./btmon -r btsnoop.log 
Bluetooth monitor ver 5.66

After the fix logs looks like that (from the same btsnoop log)

> HCI Event: Number of Completed Packets (0x13) plen 5                                                                      #1 0.926288
        Num handles: 1
        Handle: 96
        Count: 2
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                      #2 0.932776
        Num handles: 1
        Handle: 97
        Count: 2
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                      #3 0.945915
        Num handles: 1
        Handle: 96
        Count: 2


And here is an example how truncated ACL packet will look after fix.
> ACL Data RX: Handle 64 flags 0x02 dlen 51                                                                               #138 7.118921
        invalid packet size (10 != 51)
        2f 00 04 00 1b 05 11 01 01 00                    /.........      


Łukasz Rymanowski (1):
  btmon: Fix decoding truncated data

 src/shared/btsnoop.c | 2 +-
 tools/btsnoop.c      | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.34.1

