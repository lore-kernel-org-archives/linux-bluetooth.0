Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A9AC19F2B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Aug 2022 23:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiHCXEI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Aug 2022 19:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiHCXEH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Aug 2022 19:04:07 -0400
X-Greylist: delayed 378 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 03 Aug 2022 16:04:05 PDT
Received: from endrift.com (endrift.com [173.255.198.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E308F4D818
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Aug 2022 16:04:05 -0700 (PDT)
Received: from corsac.vulpes.eutheria.net (unknown [50.106.20.54])
        by endrift.com (Postfix) with ESMTPSA id A63DCA05B;
        Wed,  3 Aug 2022 15:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=endrift.com; s=2020;
        t=1659567467; bh=BQOtxJXFxsAPU1R5c5sUA8SDxvJIwo4px7RsDdcb0Es=;
        h=From:To:Cc:Subject:Date:From;
        b=go7KFsp1neH3Ru+j8Uertj9aOIz5EL9r0HcRbTSJ54etgV9AkDtTH9yYtILqBtyuA
         +YOLbM8PYxItwxJJu1dxxI7qpr7HI5IgABMljFqJdsk6g8RmvvBLclhtMLOPopUCD0
         +A0Jcu78bl8ex9SkUeUpXXy4stj4KhZzEN/Udwvwu5nvmk5AnHqMbjrjPCKsdcemlM
         mYPcvUsQ5vGZ4uKs+LXvEZcSYl1VHx+7/Q96mtMIU/IgwlGhZJZjmkExmdEG4w7euj
         mRUqJIvnwmAtg8dPrU3ocZsW6KKKvmgl77Y/W6mhdYfqyQnYaudtdJeqDffE5k8OAe
         kQ5R7nJ6Mw1eQ==
From:   Vicki Pfau <vi@endrift.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Vicki Pfau <vi@endrift.com>
Subject: [PATCH BlueZ] hog-lib: Increase maximum report map size
Date:   Wed,  3 Aug 2022 15:57:17 -0700
Message-Id: <20220803225716.1287921-1-vi@endrift.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Though a 512 byte report map size seems plenty large, there exist some devices
(e.g. Brydge W-Touch) that send larger reports. There is no protocol-defined
maximum size so doubling the maximum size is safe, and should hopefully fix
most real-world failures.
---
 profiles/input/hog-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 4a9c60185..9f3eb428c 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -64,7 +64,7 @@
 #define HOG_PROTO_MODE_BOOT    0
 #define HOG_PROTO_MODE_REPORT  1
 
-#define HOG_REPORT_MAP_MAX_SIZE        512
+#define HOG_REPORT_MAP_MAX_SIZE        1024
 #define HID_INFO_SIZE			4
 #define ATT_NOTIFICATION_HEADER_SIZE	3
 
-- 
2.37.1

