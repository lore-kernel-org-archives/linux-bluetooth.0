Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2786BC433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Apr 2021 22:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E87E061177
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Apr 2021 22:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhDGWed (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Apr 2021 18:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhDGWec (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Apr 2021 18:34:32 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAD4C061760
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Apr 2021 15:34:22 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so2068831pjb.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Apr 2021 15:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zuQW1FRJ4BKg923uSrgEDFi7TIEspcjzj26BamHN6YE=;
        b=Fid4GJqLwMXo2iFb3MJj5yN1n2t7MbVD3TnF3NU8jAH8m2uM/3D+EWs4zATDUj0bQD
         xxCk//QNElqxDMXcV3Z+F69t5QWzJwo2pHY36n0AmMEffG7qbXoyI1dUIqf8GKaiQjwl
         oMSjXyoHe6oa1t5KcJBU2Kh6zDw2A7Cyumj/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zuQW1FRJ4BKg923uSrgEDFi7TIEspcjzj26BamHN6YE=;
        b=eHjY6igIST+WeLo82MQzj4Qjw6VWKsnk9GAJBkZV2TEG4I/0xJjbkDtdklf0X+jovM
         Q1oMQ0TCyWxxslYRVYj5PFHy1cYc4a1qMj6h4HcIMRdPcE1J8J9IYdhH9bemAExr+5tQ
         7wLClSN+YH21dwL++katAYvPV13ggCiLqEXiFZukIg5ry/dJ12toWY59E5ldJTc0tqOX
         nhRRD5CuHRlJxUxhyIog7BT70vEXFRcpn5BXhSicKvF3Z2EQmTzAwaTgDmLsUjfnJV+u
         jDmdFe3TsxyDhfkpRn084J7YURAFs/hOAoX0sEU1DSRYyEPfFfEQsDmRnl4bBD8U+GoP
         0dBw==
X-Gm-Message-State: AOAM531zOdnNC5xqlSkIAZy15QjizUhxKRdDzxyFTBKuXIKwMfXPjUuN
        MRp3VgxYSc6u0eCB7bThFhp5lX2qYjep0w==
X-Google-Smtp-Source: ABdhPJymIJLC1SsFLryqKOKSJBWwHaOeNQV97D+QtIlglT7juLnEYN66/Za3LanYWqMA/aAn1saofA==
X-Received: by 2002:a17:90a:f0d1:: with SMTP id fa17mr5306612pjb.155.1617834861753;
        Wed, 07 Apr 2021 15:34:21 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:c572:df03:d9fe:57c5])
        by smtp.gmail.com with ESMTPSA id t24sm4563359pgi.30.2021.04.07.15.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Apr 2021 15:34:21 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Dmitry Torokhov <dtor@chromium.org>
Subject: [PATCH BlueZ] input/hog-lib: avoid scanning characteristics too early
Date:   Wed,  7 Apr 2021 15:34:18 -0700
Message-Id: <20210407223418.28793-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Dmitry Torokhov <dtor@chromium.org>

We need to have active connection to fully discover a HOG instance,
and in the chain

	bt_hog_new()->
		gatt_db_foreach_service()->
		foreach_hog_service()->
		hog_attach_instance()

we have not set up hog->attrib yet. So let's skip calling
foreach_hog_chrc() from hog_attach_instance(), especially since
we will be calling bt_hog_attach() pretty much immediately after
bt_hog_new(), and we will be discovering characteristics there anyway.

---
 profiles/input/hog-lib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 6ac14e401..a9ecabad0 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -1428,7 +1428,6 @@ static void hog_attach_instance(struct bt_hog *hog,
 
 	if (!hog->attr) {
 		hog->attr = attr;
-		gatt_db_service_foreach_char(hog->attr, foreach_hog_chrc, hog);
 		return;
 	}
 
-- 
2.31.0

