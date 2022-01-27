Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9937DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jan 2022 01:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbiA0BVD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jan 2022 20:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbiA0BVC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jan 2022 20:21:02 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34329C06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jan 2022 17:21:02 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id u5so1202420ilq.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jan 2022 17:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=on04lp59vWEnFs4v+cCYnWABdxGTrJVdsAyRqnA6sXc=;
        b=N8ZlM3filSu8AeGIzisN42PW6TzViVdJN/aBQUxQU2DkqnBs2lM7V/HrAAouMjzB9Z
         5BH2LkVJTPdAakGuWa24gHLZ62p69q4U2bdIPwjauigXhlPYFGYkpFPbrmiC33znrHm4
         /KXLhUUR6biFxV/QJvRr9R9EgBPOB2a1HlKdk9lDKt/u5UwCuzKFkrhV/PCJ+/G/2yv5
         lfP5qp1WC0Frn11+70XT8AnhpDljLDwu8qcZCK5Y5p4OxNoLpRkDLNd+odHpPDbYWY2c
         1H5vnj+FuLaScbxG3m6g/ZjtJ9wmGCW+1XBcZ3x0xPoP8ijoUkZOsPLpO01l/3dK6Anp
         9JTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=on04lp59vWEnFs4v+cCYnWABdxGTrJVdsAyRqnA6sXc=;
        b=zU7X/n/lx2S4rjQAsinSWSscBKqgTyuGTAQk7/0VUiTkU09HsUrm7rzWBaRcbUVQaK
         atIVPC4+qiMAqJSU9XI9o2cQPLeTi5EkbmU9QmkDyj4LjeDnPpkrcPEcI2MlaxlgWTpw
         UywMxPQKc1I4rMTqeysGm/9UJ/Cqrd9E6pRN8FuahND8PqJBhUnG9O7XCts/k/hVBSrh
         BXapZEQF8UcKEMB0zZEBM8Quh8nDGeTLsjqPCFkPUyttx6PF2m+Gq3Shnr0qfh9IjGHw
         yz+aUKzKCLx8DWI++Ue6+zTp6kCcqg3OukQMf8iXMV61ndhbCQ6D2S6EDpUalLOtXdsQ
         dmCw==
X-Gm-Message-State: AOAM532MrWT5nrZ784Xbe0yyRKJls6Up1INAf8qTAAbKRy/9ALP6PYov
        JqhQPTquyuhAZpeEuJxDECyyjCEZp4vebw==
X-Google-Smtp-Source: ABdhPJz6vs3HPMBQRkrD9JMe9ckRNpKoEmBmFnQtTtdWOM8SseSPz5PSSjid0cj3mbfMPQUAB+5ANw==
X-Received: by 2002:a05:6e02:1785:: with SMTP id y5mr1262836ilu.85.1643246461433;
        Wed, 26 Jan 2022 17:21:01 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d16sm11724773iow.13.2022.01.26.17.21.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 17:21:01 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Fix queuing commands when HCI_UNREGISTER is set
Date:   Wed, 26 Jan 2022 17:21:00 -0800
Message-Id: <20220127012100.3128690-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_cmd_sync_queue shall return an error if HCI_UNREGISTER flag has
been set as that means hci_unregister_dev has been called so it will
likely cause a uaf after the timeout as the hdev will be freed.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 87c46b04b9ff..af16b1018c35 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -382,6 +382,9 @@ int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 {
 	struct hci_cmd_sync_work_entry *entry;
 
+	if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
+		return -ENODEV;
+
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
 		return -ENOMEM;
-- 
2.34.1

