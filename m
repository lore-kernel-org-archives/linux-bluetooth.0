Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD28C43461
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 13:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32081613F9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 13:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhELNfZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 May 2021 09:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhELNfY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 May 2021 09:35:24 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037C4C06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 06:34:14 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id v6so29599507ljj.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 06:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vWwIzD/diXzmemNA9Kgt1f6PqD2bXnjYoA0Tk4MCAwM=;
        b=lmNz4NWUJlaqf4rcJSVgN3IJE8bWEjEXPHYP7w8PtB3UfOeBGn97OZdGrbM6UU/XAU
         H6MjzcoL/85WDMG8jvK5VhMXtYHoCztoqxEDtGnYJd0qUvnWRXMs2LPIUER3asHrihjg
         W16wfAZnzetHveQfv3Y0iaxwLJhv6DsPvb/bGIGMVnffNQqiefwvh0BmaGUIBIOwQ1XT
         ygIVNjjXaRVbO8l5rHATeM1S5Rrs4On3GI1S3He99A6blu/y7KkIAeDkOtxfo2DgVX93
         kJapLNSbYNcj4GzLH28THygPQvOgw1JwbX8FW3dv3IfKBkeAhceHNx9AJRYch90NgGhz
         ibRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vWwIzD/diXzmemNA9Kgt1f6PqD2bXnjYoA0Tk4MCAwM=;
        b=jbeKXmfkxFnnWKwMBXt0jDc3JHqqKFMfBcR17ZAzx6cOIX9XSOiMDGBc3ERYhCLoFZ
         wvNZV2iiGQbw7GeKcqikSnZSNoRyMimVuiju8ulRxuTcfFAHTW5ElozYbVo9ArFMlrui
         Z6w+jTjD8g4LGgpCEr5aN7Z2m10qqWmZm4m79xmnTOH4SnFQOnV3XFzGASe04+cq2gMH
         7hJZFwbQk3xg8k931gNi9ZM5cPHpVPj0AM9fky7ckR/Sfwu6qslLJgmovjoGrXEzFZIb
         xvmM74ykat57/U8bp2K+ZvoUydqlTeecMZqkPZBK//oVxnbLKkDzjmX/tlLpsEIcXAa3
         +HgA==
X-Gm-Message-State: AOAM5324mg7KuodidCYUFGgcyfG8WZzKzYj6wAt0Hj5bQ697RfqwaBZX
        M4kuLLu42n+4WqeiAZNOm2H0wyETQ4cYww==
X-Google-Smtp-Source: ABdhPJzMjFvtaYFAqOU5uqK2ZOwIVQZV3a89x9RX7PC5Qiz09tTXJdvyfdnN4YcGzC8VPaHrmh0XXQ==
X-Received: by 2002:a2e:8244:: with SMTP id j4mr29509293ljh.361.1620826453360;
        Wed, 12 May 2021 06:34:13 -0700 (PDT)
Received: from ix.cc.local ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id h19sm2989242lfc.56.2021.05.12.06.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 06:34:12 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>, stable@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove spurious error message
Date:   Wed, 12 May 2021 15:34:07 +0200
Message-Id: <20210512133407.52330-1-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Even with rate limited reporting this is very spammy and since
it is remote device that is providing bogus data there is no
need to report this as error.

[72454.143336] bt_err_ratelimited: 10 callbacks suppressed
[72454.143337] Bluetooth: hci0: advertising data len corrected
[72454.296314] Bluetooth: hci0: advertising data len corrected
[72454.892329] Bluetooth: hci0: advertising data len corrected
[72455.051319] Bluetooth: hci0: advertising data len corrected
[72455.357326] Bluetooth: hci0: advertising data len corrected
[72455.663295] Bluetooth: hci0: advertising data len corrected
[72455.787278] Bluetooth: hci0: advertising data len corrected
[72455.942278] Bluetooth: hci0: advertising data len corrected
[72456.094276] Bluetooth: hci0: advertising data len corrected
[72456.249137] Bluetooth: hci0: advertising data len corrected
[72459.416333] bt_err_ratelimited: 13 callbacks suppressed
[72459.416334] Bluetooth: hci0: advertising data len corrected
[72459.721334] Bluetooth: hci0: advertising data len corrected
[72460.011317] Bluetooth: hci0: advertising data len corrected
[72460.327171] Bluetooth: hci0: advertising data len corrected
[72460.638294] Bluetooth: hci0: advertising data len corrected
[72460.946350] Bluetooth: hci0: advertising data len corrected
[72461.225320] Bluetooth: hci0: advertising data len corrected
[72461.690322] Bluetooth: hci0: advertising data len corrected
[72462.118318] Bluetooth: hci0: advertising data len corrected
[72462.427319] Bluetooth: hci0: advertising data len corrected
[72464.546319] bt_err_ratelimited: 7 callbacks suppressed
[72464.546319] Bluetooth: hci0: advertising data len corrected
[72464.857318] Bluetooth: hci0: advertising data len corrected
[72465.163332] Bluetooth: hci0: advertising data len corrected
[72465.278331] Bluetooth: hci0: advertising data len corrected
[72465.432323] Bluetooth: hci0: advertising data len corrected
[72465.891334] Bluetooth: hci0: advertising data len corrected
[72466.045334] Bluetooth: hci0: advertising data len corrected
[72466.197321] Bluetooth: hci0: advertising data len corrected
[72466.340318] Bluetooth: hci0: advertising data len corrected
[72466.498335] Bluetooth: hci0: advertising data len corrected
[72469.803299] bt_err_ratelimited: 10 callbacks suppressed

Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=203753
Cc: stable@vger.kernel.org
---
 net/bluetooth/hci_event.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5e99968939ce..abdc44dc0b2f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5476,8 +5476,6 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 
 	/* Adjust for actual length */
 	if (len != real_len) {
-		bt_dev_err_ratelimited(hdev, "advertising data len corrected %u -> %u",
-				       len, real_len);
 		len = real_len;
 	}
 
-- 
2.31.1

