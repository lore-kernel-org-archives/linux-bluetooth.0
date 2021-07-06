Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F3DC07E96
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Jul 2021 04:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D40A761976
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Jul 2021 04:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhGFEes (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Jul 2021 00:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhGFEer (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Jul 2021 00:34:47 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EA1C061574
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jul 2021 21:32:08 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 62so12149013pgf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jul 2021 21:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ib/d+Tt+cpVasBtedh93d/vVgOfg80bhX5NQ+5O6kmc=;
        b=HGG6zbJpqANTNm6+D5wK0gmxOEQACUgF+ajwAadjXWKUeQMi1Pabkx1V2sgDgRCYCP
         cQaAD2XxlrglJONGKyKOeifMoguRZ7Tq6TDCyLJxW/k6LfFi6subqeLDv6iJHpfiwDg1
         wSGdYXTwHSdgtSXV1c/1DCo1WX44LuMmis/oxxLhR4jMYmL6Hsfz0XQhbHVPuqGzME2q
         t7drI6GM08AdGH0R3A541aZUiw9FtcFeu8iNKVt9GwQywMBJTAgVqF2hrK8q3xDbcsO6
         3MVWNSQ1P47/sGK/rJQpVSG0HpG945xL4E1/IIWtmxaEcwrPJgIEbkNxy5jQ53m9q97f
         Voxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ib/d+Tt+cpVasBtedh93d/vVgOfg80bhX5NQ+5O6kmc=;
        b=tUeRWagtKmRpScx0V0uUqxxk3C4Xa/e5ytIy+/cKifoXJS9AwHnZrLn+tmcqv4U3aD
         gNmsJPOGVQ87/2BePKxEWLmBk+6GzPZqIuhC9shBoex/fwhICDUYdS1fOAkNZeQGmE6n
         GHk5Zxf/wtysa5JZt3M2hLVJFAn9qeZwHQIUvfDWXhpxF3ur1D3UrM6VAqtg+9abp0RN
         bXyZxA/5KIb9fAz1quse19xr0fxRm1XBWJbHGF6KAzuFhVxQ6EJ1NEtecamKDc1+Y+1K
         kY3eE8mLPZoFgeK8UozB+xoP9axRZyM6wdLcAT2jTH/ahm/hFhpzohGWtmUHxLDqK/r7
         KjUQ==
X-Gm-Message-State: AOAM5332Q8MmvOJNqFSnbvCbhNKD5TN4U9W1vfMb/x62jFSdnEu+b9v2
        jZB78swqN7+2D8cuHKzd2kyrGXiTJ4rpdQ==
X-Google-Smtp-Source: ABdhPJx7I0AV5kMpCAZG/njUXiatOzBqq8e6OA7hXMVxsinHqVaaQ4Oon31p7riUFf/OrPIx7zTYpw==
X-Received: by 2002:a05:6a00:a1e:b029:303:56b5:414b with SMTP id p30-20020a056a000a1eb029030356b5414bmr18380651pfh.48.1625545928034;
        Mon, 05 Jul 2021 21:32:08 -0700 (PDT)
Received: from localhost.localdomain (c-76-115-118-196.hsd1.or.comcast.net. [76.115.118.196])
        by smtp.gmail.com with ESMTPSA id i18sm7233454pgb.83.2021.07.05.21.32.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 21:32:07 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ PATCH v5 1/2] emulator/btdev: Update the white list and resolving list size
Date:   Mon,  5 Jul 2021 21:32:04 -0700
Message-Id: <20210706043205.171122-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the white list and resolving list size to small
number.
Also, it update the size of white list and resolving list to 1 more than
actual size when it is read via HCI read size commands. This is used to
simulate the case when the list is out of space.

Note that the read list size may not represent the current actual list
size depends on the device vendor.
---
 emulator/btdev.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index a7fda2c89..75cca7549 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -33,8 +33,8 @@
 #include "monitor/bt.h"
 #include "btdev.h"
 
-#define WL_SIZE			16
-#define RL_SIZE			16
+#define WL_SIZE			3
+#define RL_SIZE			3
 #define CIS_SIZE		3
 
 #define has_bredr(btdev)	(!((btdev)->features[4] & 0x20))
@@ -3404,7 +3404,12 @@ static int cmd_read_wl_size(struct btdev *dev, const void *data, uint8_t len)
 	struct bt_hci_rsp_le_read_white_list_size rsp;
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.size = WL_SIZE;
+	/* The size is not fixed and the actual list size can be different from
+	 * the returned size here.
+	 * In order to test such cases, return more than allocated size, and
+	 * HCI Add device cmd will return the Memory Capacity Exceeded(0x07)
+	 */
+	rsp.size = WL_SIZE + 1;
 	cmd_complete(dev, BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE, &rsp,
 						sizeof(rsp));
 
@@ -3689,7 +3694,12 @@ static int cmd_read_rl_size(struct btdev *dev, const void *data, uint8_t len)
 	struct bt_hci_rsp_le_read_resolv_list_size rsp;
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.size = RL_SIZE;
+	/* The size is not fixed and the actual list size can be different from
+	 * the returned size here.
+	 * In order to test such cases, return more than allocated size, and
+	 * HCI Add device cmd will return the Memory Capacity Exceeded(0x07)
+	 */
+	rsp.size = RL_SIZE + 1;
 
 	cmd_complete(dev, BT_HCI_CMD_LE_READ_RESOLV_LIST_SIZE,
 							&rsp, sizeof(rsp));
-- 
2.26.3

