Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101B7C433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 12:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1863613BE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 12:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbhEMMXh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 May 2021 08:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbhEMMXg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 May 2021 08:23:36 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE551C061760
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 May 2021 05:22:26 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id w15so33482200ljo.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 May 2021 05:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+CvWp8C4jOtH4VG0WTPyYI86YzMBV1yC9j91Ev2r4/Y=;
        b=I5lT/BA1ZifGnQZ2XKWcGG4/rdrp+hoPqcZN0X5t0EbtBvyJiEvjGQwL+Sk6XxKP/9
         x1o3zRqjBBMvSyZwFoP2o/PlgXzH600APgiphoW/M9dofB/eLkpYvckMmo4P0noEaTBo
         zeyvmw+mJiFYU6zq5y2heS7dOHj4HGxUmkHXq7uLySey6S8vHjXVpe0kX0+jvx0SPG88
         rTDFr2qoUVO2zF9bNzslszgD7hRY2lH+Q58Qji406I80aYytXuQjMAm6NXLm1lQLMtLi
         30X4MvoHMKW6RdRHOR86MFs0zZIaIKRVe2i3YMjt5KMcYGk+X9VOOSQ2VPwIEfn7dtRr
         T+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+CvWp8C4jOtH4VG0WTPyYI86YzMBV1yC9j91Ev2r4/Y=;
        b=DvZGpTpvrZoA1kOeyObIyfD/9eZlOJi0olNj5rN+NuwwmpnFrCPd4xcyLYJG7c/df7
         K6iaYTXNm5vAwZoz2U/w6yVIKEhy2Nd7o2gG7VXV/feVEf7oC7A6P0ZhNRsDwh541Nyn
         VTNG5T5wwEVgXlMWRpExHahOD68JJsu0IvBQHZ46ZP+KDPIF0xjUQshMhxehIT+xAziG
         7fehxDOtQWSj/pR/3DDp1PBZup3K76x85FHee9/35ugw3+OxaiW3lKtNZcobZXC1mdKw
         0QquCaw0NzE8bu9QYLObtC7jKhqGC1mkM7tTDZedWtDnYHyuHau2soNzZ+hXYxDcnF22
         24sw==
X-Gm-Message-State: AOAM530ak/iE7V6Km9rO/ov9aBNQPkw9r7Vv+p9+wuON1SvEDtARmqE8
        kVA3m6Du9/k9FP+Hp7lunbrYhi+pPgtBtw==
X-Google-Smtp-Source: ABdhPJwtjAcDqUYX2MbiA8qkjLXRnDv1xbjhGBQCfUHpuooFIgnQsE4CJyvqJmwK92OhnN6L9rU1Cg==
X-Received: by 2002:a2e:7807:: with SMTP id t7mr32138117ljc.393.1620908545000;
        Thu, 13 May 2021 05:22:25 -0700 (PDT)
Received: from ix.cc.local ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id 20sm415918ljj.101.2021.05.13.05.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:22:24 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>, stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Remove spurious error message
Date:   Thu, 13 May 2021 14:22:20 +0200
Message-Id: <20210513122220.313465-1-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Even with rate limited reporting this is very spammy and since
it is remote device that is providing bogus data there is no
need to report this as error.

Since real_len variable was used only to allow conditional error
message it is now also removed.

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
 net/bluetooth/hci_event.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5e99968939ce..26846d338fa7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5441,7 +5441,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	struct hci_conn *conn;
 	bool match;
 	u32 flags;
-	u8 *ptr, real_len;
+	u8 *ptr;
 
 	switch (type) {
 	case LE_ADV_IND:
@@ -5472,14 +5472,8 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 			break;
 	}
 
-	real_len = ptr - data;
-
 	/* Adjust for actual length */
-	if (len != real_len) {
-		bt_dev_err_ratelimited(hdev, "advertising data len corrected %u -> %u",
-				       len, real_len);
-		len = real_len;
-	}
+	len = ptr - data;
 
 	/* If the direct address is present, then this report is from
 	 * a LE Direct Advertising Report event. In that case it is
-- 
2.31.1

