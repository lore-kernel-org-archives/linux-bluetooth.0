Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3395AC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 18:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E012C619DE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 18:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhC3SjA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Mar 2021 14:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbhC3Sin (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Mar 2021 14:38:43 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A83C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 11:38:42 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id y32so11208036pga.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 11:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sqDaQRxECwMrq5NmK0/Mghdht1ynJ5svieqGliomUiw=;
        b=QcJmYTBvfYggt3dXT317TsLovlwZqPPv7iEoYr7ARt76Yrqdnc6pd6PIsUU3Ry27Tz
         /e8pEb1k7+wfXfW7Glf/ksaTi87S4N2WAAx0A8/3r0CCNMt/VzrQSm7eH8CfiKZBzkZs
         0O9asaj5mHtW5K956Kyuol9A7MW+WdVFaJ5nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sqDaQRxECwMrq5NmK0/Mghdht1ynJ5svieqGliomUiw=;
        b=cADENLazKZyH/LrHHmbgv1Y0v/s407uLu5Sie852mxjtzX8t7zqmt3j2pRO6eDgcTj
         5HuEwrQMQt4mB65IPxGxxSkbY6vZOFHk07nRSxIbWmLpQNJcpIb46vGPxzK9ioaovFW6
         /wBRVIXSIV8aqryA0Y5F1y4y0NO2RCrjR1LGW3YkDFKY5WCK4b0o1JPQz+kdtIbxj2wI
         FtKchoZY08Cm+WSx61bhADRirj19vgVuGH3FtlM9R8nMsUKn2EHSgmPLhdKqvTZaQ4Nv
         mDAJfuKnMBQgHtqocXN5S3Fc73KEa6O20i518QVdNSetppSPjSSF131D4WzZcb2coRfu
         Siqw==
X-Gm-Message-State: AOAM533SnonrwkSCnUjMVygKbMB4GvPGD0uVXaDqOeKEecgiT3cOhGU2
        S+hrSO8+kSKjRK/a7V6iY1zETPep6Rdq9Y8t
X-Google-Smtp-Source: ABdhPJxUs355cTEOxHe86gqllg5dW+nXzZkWc5W2VXQp3NWSwRmihvwtjp8GIExS/yphlWxiv9349Q==
X-Received: by 2002:a63:de53:: with SMTP id y19mr30293083pgi.191.1617129522100;
        Tue, 30 Mar 2021 11:38:42 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:7587:91c9:c28b:2af5])
        by smtp.gmail.com with ESMTPSA id g15sm6956637pfk.36.2021.03.30.11.38.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 11:38:41 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Subject: [PATCH BlueZ] profiles/battery: Reset battery value cache on disconnect
Date:   Tue, 30 Mar 2021 11:38:35 -0700
Message-Id: <20210330183835.17714-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Due to cache in batt object, bluetoothd fails to update publish the
battery value after reconnection when the battery value does not change
compared to before reconnection. We should reset the battery percentage
cache on disconnect.

Reviewed-by: Alain Michaud <alainm@chromium.org>

---
 profiles/battery/battery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index 81f849d57..176d127f6 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -75,6 +75,7 @@ static void batt_free(struct batt *batt)
 static void batt_reset(struct batt *batt)
 {
 	batt->attr = NULL;
+	batt->percentage = -1;
 	gatt_db_unref(batt->db);
 	batt->db = NULL;
 	bt_gatt_client_unref(batt->client);
-- 
2.29.2

