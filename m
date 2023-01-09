Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8C8C54EBE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Jan 2023 21:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237996AbjAIVYg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Jan 2023 16:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237597AbjAIVYO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Jan 2023 16:24:14 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971111C918
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jan 2023 13:22:41 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id d13so7150937qvj.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Jan 2023 13:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7eCT1HNgFmGDk45imdSj4I9RKCb1ZlpqNTFW6pF3SgA=;
        b=JQ5yT0hlGE7VpBAxPOi6J7cnXkqv77JkAp7PSI6P8PBqfb22ztBK1vE4zRx68AJMWm
         OADUvwVxn01hwm7P8/zHO5EgsqUaODfPlw22BElkKdecrQLT0Tar5gh7VCr+qnS50FpW
         TNI5vPxyZmifaTSBAMb9Ox/FiA1tC5uAnwcJAqcOEFq5ydayuTKidAU50z1//5gGl0CI
         86uZslb9dvAtIUjDEBaR9c/HZ3YgsUx1mwVz8gxKvcpWG+15glsh6WBpnHmtskqqSsb/
         6ojUIXVhvy6jYSfZx5Zz1/CvX8Gc5EI7rmOBCWXqFvSxub/cnWs1c2n9mfChunDae3YK
         IuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eCT1HNgFmGDk45imdSj4I9RKCb1ZlpqNTFW6pF3SgA=;
        b=p2c9agU1W7JF/6AEv8bV4SPfdhDGXapLFou4yKa+EFI7sK8FgPrFJ9+x0kSzGGijis
         vctpyS4kZKPoP3jZRL0iCTaF3yBiAgRG4ephnw9/kTDVdKpJPff0axFTjeVuM5tHt0Uz
         uAzCDPVVircWen2pPT+VZ7/uPzfuy7e6tVhKfeM7xIHrV0Xk8NYGNd1vJOaitX0vMTtL
         MyQAls37rm5b7I24ukmTDfPdvw5NofGORbJQgZTeaojJDg2wwXPmjIdSgnfFOLf/A8Uf
         xJ26dZkneCXa/mbfJhwfteY3HfYLLi3v15OnpMMpdt+nLhZwtvRfIAxupncHv4ZTIFTi
         4XWA==
X-Gm-Message-State: AFqh2krrGeAv9VEV3WgcaYbDN2tlI7O4ryGG6PJ/KDg+JuLR0xqQh97f
        ySN1ZsXaEkOEGmVOJq8tJWHNZ1fh9C8=
X-Google-Smtp-Source: AMrXdXu0ATeSHI1Mjbs5IB4BFgnH2mGWy2CsSUAOryueFi3k/qwwTaGICC63uUuqNsZGCovYUr7EdA==
X-Received: by 2002:a05:6214:4385:b0:4c7:7c7e:35af with SMTP id oh5-20020a056214438500b004c77c7e35afmr92464021qvb.1.1673299360093;
        Mon, 09 Jan 2023 13:22:40 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id h23-20020a05620a13f700b006fefa5f7fc9sm5851591qkl.134.2023.01.09.13.22.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 13:22:39 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_sync: fix memory leak in hci_update_adv_data()
Date:   Mon,  9 Jan 2023 13:22:37 -0800
Message-Id: <20230109212237.3209300-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Zhengchao Shao <shaozhengchao@huawei.com>

When hci_cmd_sync_queue() failed in hci_update_adv_data(), inst_ptr is
not freed, which will cause memory leak, convert to use ERR_PTR/PTR_ERR
to pass the instance to callback so no memory needs to be allocated.

Fixes: 651cd3d65b0f ("Bluetooth: convert hci_update_adv_data to hci_sync")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index b38a097344fb..117eedb6f709 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6187,20 +6187,13 @@ int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 
 static int _update_adv_data_sync(struct hci_dev *hdev, void *data)
 {
-	u8 instance = *(u8 *)data;
-
-	kfree(data);
+	u8 instance = PTR_ERR(data);
 
 	return hci_update_adv_data_sync(hdev, instance);
 }
 
 int hci_update_adv_data(struct hci_dev *hdev, u8 instance)
 {
-	u8 *inst_ptr = kmalloc(1, GFP_KERNEL);
-
-	if (!inst_ptr)
-		return -ENOMEM;
-
-	*inst_ptr = instance;
-	return hci_cmd_sync_queue(hdev, _update_adv_data_sync, inst_ptr, NULL);
+	return hci_cmd_sync_queue(hdev, _update_adv_data_sync,
+				  ERR_PTR(instance), NULL);
 }
-- 
2.37.3

