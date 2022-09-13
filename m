Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40748ECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Sep 2022 23:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiIMXhY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Sep 2022 19:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiIMXhW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Sep 2022 19:37:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E2671BF2
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 16:37:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b14-20020a056902030e00b006a827d81fd8so11440894ybs.17
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 16:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=NwGQODpxaIQjq2Q9i7xww6BX9L+zJmLaZqsIG4X4HwQ=;
        b=o4kOxYovTq8PJdbtLFHNsCuRZnYOxfFbUklDCum1if7Egy/oOVrLZccjBiHzq5BXuR
         HQFB4ufGVJe1EForw5n8XYdu13KQ21Jwpy0r8gcfLeBszXy1Phx3faimJZyxO37aXLOp
         YUYAH3/1WvyO3nP8fCCVDCpiVONvC+o2oLf+5sLG/VvnPA8UotxYhrM4nCJ4+/Z1GEz7
         XkEDwRlsiGrs8TsCQbv0cdQm8Oz6ibzUN3tKMehKP02NX/iFzuc8K6BUYYwhuF/pOyKD
         xwc/6jQHuSnUGzzuBLKblrDN9Xv0hArYEZKA2TvN7tKApcijJ5Fd2qwZO6MBZy6cuSMN
         nggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=NwGQODpxaIQjq2Q9i7xww6BX9L+zJmLaZqsIG4X4HwQ=;
        b=C32CJSwd76p+tTJJSU2d0sBVeoM0bjPh2eUcnuAD2FUcMMhieFysEg9vFPnk0zMVP1
         hTlKZSMeZNk9jS/IRYaXRQYJ5cZbBJe92Y6umhYsHpHC+qtIzGEEQU/KC+FYuCh8iZZ8
         il24yvokD+AJOIVnFPWVDZc9HXbCmgX3X0oc/dsbHnzpjnizJNn4HxTbpklrhDObYAka
         ywR44hPmocUJy6qPIN8m4nMK1nCyMCQ9haQgRkZzvPxmv1NUEh90BjxmEApClKNjRFF1
         5IYkSNxrr5KmgESm+RrvL45iQ2lNDlOs51TdrGSig8Gropi1NspnwPqADgxZh5cBQNx9
         K7kQ==
X-Gm-Message-State: ACgBeo138Ccj5zPjxbjqL6HG66SCCWVf9479zZGX80GVeXujGaixvNkZ
        DvEVvvD+RkYM+ulx+06ZWi350wbTguXdDohbM3/OUDDBuNZKHq9pJRuD+AVAjhfnZaX4aZMpw6H
        5Xuda4ARddTDbk+G1IybnXlirSCXeFU+lMtw/R3gfCmZ0fBIIqLNXPaezJUmqimNz7NPS4H4cK7
        /k
X-Google-Smtp-Source: AA6agR4nHY/ALASaB6ML9Y/8f2p0m5sk2i47fc6sZmQCuiYN/l2jdLI3fj8Icd8/Bz5NvCRsPfMkWvqD2Yoj
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a81:1353:0:b0:345:34b5:ad29 with SMTP id
 80-20020a811353000000b0034534b5ad29mr27724101ywt.17.1663112238498; Tue, 13
 Sep 2022 16:37:18 -0700 (PDT)
Date:   Tue, 13 Sep 2022 16:37:14 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220913233715.3323089-1-jiangzp@google.com>
Subject: [kernel PATCH v2 0/1] Bluetooth: hci_sync: allow advertise when scan
 without RPA
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     Zhengping Jiang <jiangzp@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


This patch allows the device to keep advertising during active scan when
ll privacy is enabled, if the device is not using privacy mode.

Changes in v2:
- Modify title to reduce length within limit

Changes in v1:
- Check privacy flag when disable advertising

Zhengping Jiang (1):
  Bluetooth: hci_sync: allow advertise when scan without RPA

 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.37.2.789.g6183377224-goog

