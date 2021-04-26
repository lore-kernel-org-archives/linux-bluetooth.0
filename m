Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8AAC433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Apr 2021 14:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF40F60E0C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Apr 2021 14:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbhDZOpR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Apr 2021 10:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbhDZOpQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Apr 2021 10:45:16 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E4CC061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Apr 2021 07:44:33 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j4so49180054lfp.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Apr 2021 07:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iEyaa+KdKO3/TwjRJSjJ8eqEKt844NBhvTEl0BWfZcM=;
        b=J7YqrOxB45f6FqOPJ+EnPOZkPr9NP3jlbPiezx6Zi5KF0jd4ZYqpCItlvm1HBYfyLP
         Qdu0ay9LuCmb3mGXGF1Zz5H3Fb2HG6M+80ZofyZteczJkXcyz8nbn7upFXZUrrVXraXt
         fKSnc3qkF+w4G8nzxvGGCQ5yoUgiHvsZRlwlMYWwOHRP4yqEe1lTpFbNIB8hEtYLq7kp
         zpTmLH1A5ogDBdDI5soVBzb0mLKe0IwFFKCUP5025YOoZBHRRgkuMVzJN+gE0qn04jUb
         Ev0KmGHYweqpkml3zdAy8dCTTw6NoGBv//hVsrUHhqbb9DuClEY7PZBN1B/QkB3R3yiE
         RasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iEyaa+KdKO3/TwjRJSjJ8eqEKt844NBhvTEl0BWfZcM=;
        b=faBRrBVEoesSino3eLVJqiHThWiODKGp0DzTp+k9zTNwglD0+B75c0pkaXRibdVl8M
         zynSTcjjcVJsDKFjxpruh6rXI2O+XE9uDx+JTOtSdIQhMWMKwOSZk3ta68OecC6O9JD0
         /JnVfAeEBOvtsD1F6gfbJbkKdPQTVayFz5ICKrgVwADGMb76aqSnM5GC4Dfad3yOclaI
         Gx0uPspIKQtKC8j00w7VLl4TrIHgIotDLTn+B7nnQeq5b2Fn/fy9xaOKD3H+kgbIjLEq
         40TH+f3CiTgISHvf0OiTzQAYcVwgSwWcqtvhp/b25G27N6yLnJue+aRIDvUafXqYyHYu
         3DIA==
X-Gm-Message-State: AOAM530rI6u1ab2nX/2KNkExhslzyEu0YRZe4Yt4UEAnl0z+QP6jdspW
        1bwyC6hV2ur/qQ3mEuGrOqYBxB7u2pDO16Gq
X-Google-Smtp-Source: ABdhPJzYnzbHgYvM7KhY2kXFkTFJ++vIkuJuCDzYHKyAtyJqIzlV46qaMJmeBJb7fCpuDs8hmJN5Uw==
X-Received: by 2002:ac2:4d10:: with SMTP id r16mr12745692lfi.643.1619448271909;
        Mon, 26 Apr 2021 07:44:31 -0700 (PDT)
Received: from localhost.localdomain (45-11-60-42.ip4.greenlan.pl. [45.11.60.42])
        by smtp.gmail.com with ESMTPSA id n10sm1421728lfu.216.2021.04.26.07.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 07:44:31 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>, stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Make spurious error message debug
Date:   Mon, 26 Apr 2021 16:44:19 +0200
Message-Id: <20210426144419.451157-1-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.30.2
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
 net/bluetooth/hci_event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5e99968939ce..2a27d5764ba0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5476,8 +5476,8 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 
 	/* Adjust for actual length */
 	if (len != real_len) {
-		bt_dev_err_ratelimited(hdev, "advertising data len corrected %u -> %u",
-				       len, real_len);
+		bt_dev_dbg(hdev, "advertising data len corrected %u->%u",
+			   len, real_len);
 		len = real_len;
 	}
 
-- 
2.30.2

