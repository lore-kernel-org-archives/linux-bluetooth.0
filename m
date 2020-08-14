Return-Path: <SRS0=Aqt4=BY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFA5C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 06:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7229720855
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 06:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CECAaDGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgHNGkX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Aug 2020 02:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgHNGkX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Aug 2020 02:40:23 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90565C061757
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2020 23:40:23 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 2so3943170pjx.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2020 23:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bw7HqmrKE4bMmC/qo7mdRecaT5OsOCHG6GMDFaNmUWA=;
        b=CECAaDGR7fbf7xXfzpCCnNxkBdYsdlyBrBHfF4k+vAHwcLocKFg7ZO+gPHCe5UbdC6
         xIlfHB8hn4WIh7ePCZV3yJPtOxDG3j6Ycn7TRAS/G8ZKIta63O38A0Lb6AeBlSSy2Wri
         ZL1L/Yi0qmWWOW5vnaN4JVpSKJJ2iL1+OWcRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bw7HqmrKE4bMmC/qo7mdRecaT5OsOCHG6GMDFaNmUWA=;
        b=MOnBXKdInsJOeZE+XRNAF9OpE3Jr6QE06l2BC4P8Q07QApfMY20nUaPY907G1boj8I
         56Ge00FYTOiw1asSqVBAw7eD6FmmmRUlGlfCFqPGKpreDPCnEgP2WkTjrsj9m3BXv3QF
         JPFGlcxrZl+zHvgJBIxdZZ4fbEzZuRqyv0EIbsyvf1nx3+0iPlM73R9mA26/QrvFG85p
         rZYRQollCED5zqoDDz0SIo5LcN4qpg9DLluWaS3ackIQYEuemCWZF9HBOBY6BVoAtrtj
         PKPv9MQ6JLEstypB6DjdKgM6Swsm5VLN4cKiaQ3EYb1gdIUEGwHyjBOXfAzx+GAZEXgE
         GmjA==
X-Gm-Message-State: AOAM531+99Eg3iLBBzlCbsvBdW29QtRgN+Rjj7SqmkoeMDSDZP33zcwX
        Y7WihP1FwBjD55epEoj/OrIA9lk6TPrB5g==
X-Google-Smtp-Source: ABdhPJxeGyXcflDF+cbSwnZJHaLGcDtjXji9UiK19E7oNjzWZzRCxY5dK3IbhiJv9eBN6Pdf44s5aw==
X-Received: by 2002:a17:90a:cc14:: with SMTP id b20mr1075583pju.1.1597387220263;
        Thu, 13 Aug 2020 23:40:20 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id mh14sm7464214pjb.23.2020.08.13.23.40.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2020 23:40:19 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v1] shared/ad: move MAX_ADV_DATA_LEN macro to the header
Date:   Thu, 13 Aug 2020 23:40:15 -0700
Message-Id: <20200813233952.BlueZ.v1.1.I716fc87b0c97e5349a04766a61ecad1f5b0fd28e@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This moves MAX_ADV_DATA_LEN macro to src/shared/ad.h.
---
Hi Maintainers,

In order to avoid duplicate definition of the maximum data length of
advertisement for the following series of advertisement monitor API,
we'd like to reuse the one in shared/ad.

Thanks,
Miao

 src/shared/ad.c | 2 --
 src/shared/ad.h | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index 8d276842e..6d882a9b3 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -33,8 +33,6 @@
 #include "src/shared/queue.h"
 #include "src/shared/util.h"
 
-#define MAX_ADV_DATA_LEN 31
-
 struct bt_ad {
 	int ref_count;
 	char *name;
diff --git a/src/shared/ad.h b/src/shared/ad.h
index 19aa1d035..dc92c89bc 100644
--- a/src/shared/ad.h
+++ b/src/shared/ad.h
@@ -27,6 +27,8 @@
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
 
+#define MAX_ADV_DATA_LEN 31
+
 #define BT_AD_FLAGS			0x01
 #define BT_AD_UUID16_SOME		0x02
 #define BT_AD_UUID16_ALL		0x03
-- 
2.26.2

