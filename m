Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432C5C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Feb 2022 21:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240625AbiBDVMl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiBDVMk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Feb 2022 16:12:40 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4457C061714
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Feb 2022 13:12:38 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id e28so6130992pfj.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Feb 2022 13:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FeauL6xOADZ3IUAX5L1Hc803yMMYzw4jxOJRUoRGVFw=;
        b=mfN25sEFqZNAHmtIYWYbpWGBnkYQ+kRjfcdf0rrZe0/YX20QZwA3EpGTVYA37CNkaR
         /6eG2BRc3yUro85EegftsrUEDSWqqWmkrXZLQ+JA+rHKBReuD+EQgwzO29LG6hMnL1rZ
         cyLBW/jhqkvpopbfHk/cgdvIcz8hyHCjQbko9XlktSBFR5yUx/fkKY5ivzCN0PoaVVJB
         sAodgkjLIMZBpLH/HEyicu30uJYVyfIiAAW+U9sMp9D79+GSF5hV3Uxh55MAX+9o96iL
         ffT7Ynn+YJrAVlluU+9s44rVkVDQhpx0cV05+YqQhfbCjphYr7PL2jhFtffa528KKlfR
         S/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FeauL6xOADZ3IUAX5L1Hc803yMMYzw4jxOJRUoRGVFw=;
        b=quuituqyD6w8JEJhbZAJkAZQOX0JmiT4DcFfckOiJ3VNByadPCey2kBHgULkyw7S7w
         IU06WlucR+x9K89P/OcN8CKF3f5jcUtYpOZIChU38+cGgN+9Ac8PsUjVjD8sNP0e0ejY
         zmvIi1cGfAJhtDOA/AoXvh4+/0g1Q4KDb4Eh3UxYSf4mt46khFWshrZqujaCi3giWR7f
         kACqFsx9YvG32QEM2js+feg0aYehknAteEts/LjAqTuxYd1TEXkTetOSuqeuLNp6nhXl
         kp0ziXdizC9RspnSTMAAPlSN70ccH0nlj9oRgwDwCwDeZh4HwmeqfNzSF+3NiGOI+0UF
         bS4w==
X-Gm-Message-State: AOAM533vF2wJ+1mArYzYGciSyNIUOcrfqy9LpcoWMPHE7H7ZbKifCsbA
        z7Ti18V6tHNq/9XRZErs/SMSoWx0m/TzyQ==
X-Google-Smtp-Source: ABdhPJx6k4pT7fJT7QO1AzNw+wW5oV03SGRiE7hWJxBeHEW5DtAcoRBs6cukI8/mjL/TN83L4MPaNA==
X-Received: by 2002:a62:7656:: with SMTP id r83mr5111672pfc.26.1644009158042;
        Fri, 04 Feb 2022 13:12:38 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z17sm2142267pgf.91.2022.02.04.13.12.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 13:12:37 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_core: Fix leaking sent_cmd skb
Date:   Fri,  4 Feb 2022 13:12:35 -0800
Message-Id: <20220204211236.2690926-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

sent_cmd memory is not freed before freeing hci_dev causing it to leak
it contents.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5bde0ec41177..b4782a6c1025 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2739,6 +2739,7 @@ void hci_release_dev(struct hci_dev *hdev)
 	hci_dev_unlock(hdev);
 
 	ida_simple_remove(&hci_index_ida, hdev->id);
+	kfree_skb(hdev->sent_cmd);
 	kfree(hdev);
 }
 EXPORT_SYMBOL(hci_release_dev);
-- 
2.34.1

