Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ADDC4361B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Dec 2020 23:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28C482336E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Dec 2020 23:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437220AbgLKXcJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Dec 2020 18:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437052AbgLKXbj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Dec 2020 18:31:39 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BA5C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Dec 2020 15:30:59 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id s2so5378608plr.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Dec 2020 15:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u3YSqH1FiIVrSIBPKfpTCG/uhni00GyHzVDOAjTchBw=;
        b=RGPJPfkZlJLwx4Q6e1y9Dx0lvbAOuZYbLzItcTlQlPvnivlhvgp0uieZ/S9R93JfbD
         mKi0p+3JMakJgdc1fJMjyUxEnBXyjI7JNbwI5880Si6NaSFNiR+kkZD6d9q3dAtSUDMG
         ziv6TMx3Xgb5RE8GgcJyBS+dU47tUp6j/+xgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u3YSqH1FiIVrSIBPKfpTCG/uhni00GyHzVDOAjTchBw=;
        b=JnkSRyRRK0upET6jR8Rp/cHPnEpWNDSnYqVVxoSP+At3vJvS/aMfFBEvp13ds6Z+Co
         57/tr/qavW+5SHODwpi8PDv6gi7el4DRz6/SSDTjvK1j2lg870hEYLml/tFg467gKe0n
         XzWJpsjpOaobfM0lOOiz+D8ifotBBuynyivGRkl7TEvUXUhkzqzC416s/cMngW2RD/Rv
         tiTPnGxK4lReYA0pwqLjtKuTcJ57CX3I8RZlHjH14YK81EYMihuqPr0ZHYexnjTFDb4A
         F6UKOInQwaaPcrgBf+bBIe/sNOqCTlCZqjngzI0L2t6y7Wbhko0J6Pp3ygvlgxYwkxtc
         HnHQ==
X-Gm-Message-State: AOAM533EmWHFZc2Scz6Rnzj8hK7B898ROanIMtskgJBePym16I2LK7Ws
        GY7YJztFSdmtFpHtsNRrVTCduFxUCiAViw==
X-Google-Smtp-Source: ABdhPJxCOcwPaJybnXPLfFO+PbfrplN6HUM4TQg6U54bG4c6zDih6U40LDhpv2hZ960AcFw3prBJ/A==
X-Received: by 2002:a17:902:bf44:b029:da:d0ee:cef with SMTP id u4-20020a170902bf44b02900dad0ee0cefmr9769527pls.12.1607729457660;
        Fri, 11 Dec 2020 15:30:57 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id y15sm11015450pju.13.2020.12.11.15.30.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Dec 2020 15:30:56 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Subject: [PATCH BlueZ v2 1/2] Revert "input/hog: Remove HID device after HoG device disconnects"
Date:   Fri, 11 Dec 2020 15:30:46 -0800
Message-Id: <20201211233047.108658-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This reverts commit d6cafa1f0c3ea1989f8a580e52f418b0998a3552.

In commit d6cafa1f0c3e ("input/hog: Remove HID device after HoG device
disconnects"), the bt_hog structure is destroyed in order to fix a bug
where the UHID connection is not destroyed. This fix has the cost of
increasing reconnection time because every reconnection would need to
re-read the report map again. An improvement to this fix is, instead of
removing the bt_hog structure, we can just destroy the UHID with
UHID_DESTROY event and use the existing bt_hog structure to keep the
cache of the report map to avoid re-reading the report map at
reconnection.

Reviewed-by: Alain Michaud <alainm@chromium.org>

---
 profiles/input/hog.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 91de4c70f..d50b82321 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -207,8 +207,6 @@ static int hog_disconnect(struct btd_service *service)
 	struct hog_device *dev = btd_service_get_user_data(service);
 
 	bt_hog_detach(dev->hog);
-	bt_hog_unref(dev->hog);
-	dev->hog = NULL;
 
 	btd_service_disconnecting_complete(service, 0);
 
-- 
2.26.2

