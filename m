Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440BDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Nov 2021 22:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243492AbhKZWQB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Nov 2021 17:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244713AbhKZWOA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Nov 2021 17:14:00 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250A7C061758
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Nov 2021 14:10:47 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b1so27207592lfs.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Nov 2021 14:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLqwQJWDE8a7depWBYd+hrLoF+ltNYrjhfboFky++nY=;
        b=mTLeW6i2Pc2IHaCs3TE7GvqJgqE2uvXUCFN2uC4Dn6FlMnJWeIHbWIoePYw8FQaaQr
         1OvH/TNlTP2JdW8hF6VKSXH1uIIYlLIFxidY7r7VUoMq+MG6TWJbf6qDakWVYVOUZEiE
         msrohFyeCBfbd43Hi8GVgfoQY6vhbxbLiz7wN117qb+mW7IlgUNeMChBC66Y/LtccFNq
         YazePZ/h5rCiipByN5BmE2WYpwkqLbzfeJREiLLKZzaurtTIwl+pU5yMeWxJE3C5iH5S
         0ooefuikUXMjXkNdb5XUq45XmYRt3Cy0y7HrbO1yjdqdZFKzMRjvieGJoV8q5jP4JhS8
         ig0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLqwQJWDE8a7depWBYd+hrLoF+ltNYrjhfboFky++nY=;
        b=6MofOlKQuJTKU4UeOiKs5mJfnxR8TEiKoFi9jPnxMAu6PN/D7IJKFn1/DbLBAc3wsF
         cXZPs2ruPALh6inS8MLFr1deqCMGQjwvB5vBCfw+Gofc3ejCMuNaLwX6fB6cVhdQvuiO
         YiB7Ug5SJX5M1yxPOYwz1PrldIp7TW+8z2/t4qaekP3TUYWqHAweNwLhbeXVbflJTi+c
         NoqVJkMnJ5MKX8MHebEhtXmvn/ILS+uZvIajxutAjThiNOJqAmcw1fWp1XQLM0aWf35B
         DJhLcl1DDGmedn3/wpVspdw4Vsz268lw/BGX0zPDM+i8g4i8h6w3JwRF9wo7TIgvM9hb
         azUA==
X-Gm-Message-State: AOAM532gkMV3fyvU/puksoHgnSo//MNW/O5XcvdHQtWPFoP07J9QPD22
        nunhGFBYpUnuy6nPjWWBgmIO
X-Google-Smtp-Source: ABdhPJwJVSEi5ztbn19HvdKZVk+FNVzfL9I8bOkzkF2joIq/JBel9xgsTB/DxSDpnZ74ss3C2bZC1A==
X-Received: by 2002:ac2:5dc2:: with SMTP id x2mr32280022lfq.228.1637964645418;
        Fri, 26 Nov 2021 14:10:45 -0800 (PST)
Received: from localhost.localdomain (public-gprs370674.centertel.pl. [37.47.79.51])
        by smtp.gmail.com with ESMTPSA id x15sm608256ljc.124.2021.11.26.14.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 14:10:45 -0800 (PST)
From:   Lukasz Bartosik <lb@semihalf.com>
X-Google-Original-From: Lukasz Bartosik <lukasz.bartosik@semihalf.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>, upstream@semihalf.com
Subject: [PATCH v1] Bluetooth: btmtksdio: enable msft opcode
Date:   Fri, 26 Nov 2021 23:10:34 +0100
Message-Id: <20211126221034.21331-1-lukasz.bartosik@semihalf.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Łukasz Bartosik <lb@semihalf.com>

Enable msft opcode for btmtksdio driver.

Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 drivers/bluetooth/btmtksdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index d9cf0c492e29..2a7a615663b9 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -887,6 +887,7 @@ static int btmtksdio_setup(struct hci_dev *hdev)
 	if (enable_autosuspend)
 		pm_runtime_allow(bdev->dev);
 
+	hci_set_msft_opcode(hdev, 0xFD30);
 	bt_dev_info(hdev, "Device setup in %llu usecs", duration);
 
 	return 0;
-- 
2.34.0.rc2.393.gf8c9666880-goog

