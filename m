Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8059CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Dec 2021 21:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbhLHVxZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Dec 2021 16:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237597AbhLHVxY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Dec 2021 16:53:24 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9848C061746
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Dec 2021 13:49:51 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p18so2414283plf.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Dec 2021 13:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aa+hIvKdopvGH/i1zdQNveafW35HYLtARPAC9bdhulM=;
        b=X3ONIPL4DW3eGzoWe5V+MkWqePLrSItBG4yf4Mf5iNbTmFnfQQ1X8xXwL0/2lu3QLt
         ompYPRg8AmoY7TXqSprU0Jm8Rz1seLYflxl3IPQxioJDMQETsf00YsEEihxC5ylXSFuH
         wpQLhaw4syVUpnfONafPBOgSrJApC2+GV0rIi3WkannGvftqvrDhpBRwogEo9YyxAok6
         GNwtRKiz8fFrvTeK1AmpodZgzA2vLAZB6ecr+OgZK7pnvDsMUXMhhB7f8vUoIeoAfCXv
         i+Azm3nc7jEeotHblQPVE0BM8t/lXyOeOwKRCRICzN0lu/2OAmUpApGk+tKnIHTi5F/4
         VtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aa+hIvKdopvGH/i1zdQNveafW35HYLtARPAC9bdhulM=;
        b=pC4Su2wY9Xokeuck4XjPkzYhuh9rVI6qZj06xP/SHA7Tv1uBOwZBP9TovHoyIpXKK6
         4kTXi7g8EhwQf3ZLtCyzS41f/A2xv2Aq8UZpLxGHcjGaltmkmqsGkAxZeJx83xWP6yTW
         78pYp1iOi7qQYdQIBfzwHYJIQT6IDkwl9+M+s8h7rFRWL9kFNnAvJbA1Ef+Rxe9+mkkI
         cLWMicLviJj3aZuFaN0WvEZtbO3Icw5v/fdOdNh0qgpYXOQw9EEpKF+7IEx/LynIcDp3
         ctp5LaIA5pldWC4vbCDLOnnMO3LtGwnq0FXmF0EDkJBwpz609rMAyYwYvhJZfYQOwQxS
         2z+A==
X-Gm-Message-State: AOAM530447TRfVtca0Tmt9Q6Otr6OX6WPhOP6A73EpguXQqnfeQ+abd1
        U7JdDyqzzzLKMAZvAt7eiZ7yUvaDfDI=
X-Google-Smtp-Source: ABdhPJytV5gI89VWnN7lmrCrZy/DpBEPXvjegyhNeOov1tVL5EvfYG59UnhvI5krCvkT0gzYAK1Nsw==
X-Received: by 2002:a17:90a:7086:: with SMTP id g6mr10410654pjk.34.1639000190982;
        Wed, 08 Dec 2021 13:49:50 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f19sm4504464pfv.76.2021.12.08.13.49.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 13:49:50 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: hci_sync: Fix not always pausing advertising when necessary
Date:   Wed,  8 Dec 2021 13:49:48 -0800
Message-Id: <20211208214949.455089-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_pause_advertising_sync shall always pause advertising until
hci_resume_advertising_sync but instance 0x00 doesn't count
in adv_instance_cnt so it was causing it to be skipped.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Add fix for l2cap-tester direct advertising test cases which was caused
by hci_pause_advertising_sync not pausing advertising when instance 0x00 is
used.

 net/bluetooth/hci_sync.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3d28ca7ebe45..fd15fb37a52a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1701,10 +1701,8 @@ static int hci_pause_advertising_sync(struct hci_dev *hdev)
 	int err;
 	int old_state;
 
-	/* If there are no instances or advertising has already been paused
-	 * there is nothing to do.
-	 */
-	if (!hdev->adv_instance_cnt || hdev->advertising_paused)
+	/* If already been paused there is nothing to do. */
+	if (hdev->advertising_paused)
 		return 0;
 
 	bt_dev_dbg(hdev, "Pausing directed advertising");
-- 
2.33.1

