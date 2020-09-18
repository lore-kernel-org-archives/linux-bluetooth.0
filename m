Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59792C43464
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 03:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F052083B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 03:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="lPnbMx9M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbgIRDMe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 23:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730621AbgIRDMU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 23:12:20 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F202C061756
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 20:12:20 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id y10so2555659pll.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 20:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=NxYLZaP4aGvAu+/UZ2/LCTJAGtRN+euo/YJvY78SnJI=;
        b=lPnbMx9MR7LP0g8yYqS8XX8PwdhoCbJLqS3Z0Z0JtuxwszJ9u0TKgULzYiNZpjdWBD
         1pFWEgRbhds1BOQrRuitu8mMEDBNDuwU5LUhPPic6Zb0Oe8Cu9IUv4vX3N4HXaUTsqWN
         E3tLAgY5ThRFLx8JC8AtkuxBczzVFBpbeZu2koExJJHkSA5JVsuSRZSxuttC7ewNIl7W
         Yj4EwfyVNTayTJoqCUaNoujn8oMQLgP+QxsxmxT8TnmsrLc3wbbV03nlr+a1oxwen8aE
         Q7X003JemibbmOX6Tn5rBhnHC1uMggGUYmpZwFiCSGp9jwbAzfgo7EOJs9om+YsJ684o
         FBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=NxYLZaP4aGvAu+/UZ2/LCTJAGtRN+euo/YJvY78SnJI=;
        b=HV4qUU0ntIzVYbvT7nEnsQkJ2XwucCMIjwYyNsQl9qXL8qxzGNyTewCZa+UpEX4hey
         obCCI6KscZjd1eMddp9x4gOqCjNfosNVGZ1mx1TC29hr7GMkdi0DaahKo1GPfhOPpYOj
         iq1kFVBvpIw8pJG7cKY1ZKszA6n9Gzh9p+8LX+SstPj8CWN2vbzg+SLBTK6GVt86W+Ws
         TMOfQD5KJ+5hkMOoNruWH2VKQmJJ27JXnDZdyhJ0AMmcmIhIniO2u9gHfvA2ptlLpcwr
         3tk2OO9oSYQYMgBQiKK+g652QUMlEHpEDSuxdu3z+RStn0Ejho1tk8/KCsbePgmVNCHZ
         L62w==
X-Gm-Message-State: AOAM530B23Ob4AdS4TgaoCmwjeGzUYb5EXywmdLxqfRnAexzj/mBX1Bi
        hwuIWoX9YhUx2nwq+FyMbYg3BBsEf5NlLKxv760H5l5HLeDdfOWYl6AIi2hUhIWlKSJPlfcpKqW
        qUg6Lp9mHywypmktxiKchOFSXd9HEaxLSwuZyPm3hjnvYNFayR4Xpr/1DKoaux0+ausyjlEC3zB
        LVLyNFEp8ceS0=
X-Google-Smtp-Source: ABdhPJx6kM5DLLFGf2usi1qL12z1S/m8Hsz6v1BbQkAwPJVD0ivhgJmBq+H071e/KejErTX27f7V9MxscFhrpmdfXg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:aa7:8583:0:b029:13f:7096:5eb with SMTP
 id w3-20020aa785830000b029013f709605ebmr30016944pfn.0.1600398739505; Thu, 17
 Sep 2020 20:12:19 -0700 (PDT)
Date:   Fri, 18 Sep 2020 11:11:48 +0800
Message-Id: <20200918111110.v3.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 1/6] Bluetooth: Update Adv monitor count upon removal
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     howardchung@google.com, luiz.dentz@gmail.com, marcel@holtmann.org,
        mcchou@chromium.org, mmandlik@chromium.org, alainm@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Miao-chen Chou <mcchou@chromium.org>

This fixes the count of Adv monitor upon monitor removal.

The following test was performed.
- Start two btmgmt consoles, issue a btmgmt advmon-remove command on one
console and observe a MGMT_EV_ADV_MONITOR_REMOVED event on the other.

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Howard Chung <howardchung@google.com>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

Changes in v3:
- Remove 'Bluez' prefix

Changes in v2:
- delete 'case 0x001c' in mgmt_config.c

 net/bluetooth/hci_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8a2645a833013..f30a1f5950e15 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3061,6 +3061,7 @@ static int free_adv_monitor(int id, void *ptr, void *data)
 
 	idr_remove(&hdev->adv_monitors_idr, monitor->handle);
 	hci_free_adv_monitor(monitor);
+	hdev->adv_monitors_cnt--;
 
 	return 0;
 }
@@ -3077,6 +3078,7 @@ int hci_remove_adv_monitor(struct hci_dev *hdev, u16 handle)
 
 		idr_remove(&hdev->adv_monitors_idr, monitor->handle);
 		hci_free_adv_monitor(monitor);
+		hdev->adv_monitors_cnt--;
 	} else {
 		/* Remove all monitors if handle is 0. */
 		idr_for_each(&hdev->adv_monitors_idr, &free_adv_monitor, hdev);
-- 
2.28.0.681.g6f77f65b4e-goog

