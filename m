Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC83C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Nov 2021 01:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbhKTB1x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 20:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbhKTB1w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 20:27:52 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC2EC061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Nov 2021 17:24:50 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so12225956pjb.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Nov 2021 17:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ykUhzNI/cNQOTH0C22kn8IQFNGkRRVLhOnTQMfHkHBU=;
        b=aR98BecnUAr032FphLNv4zPLt2KsrP34SAXYw6u5zIEQ6yik1hddMIj5VfwBWQNVwl
         0/6/ZQM1wouwG1UYESrXYM7+9Ahm+kLGfM1BqFbr5W2PG8EqpFyIwqkpIcGj4l1e3+u0
         SF4ePpkfDAsKrlQ92XkAxX53ntPytgDOR7J6dG9zNB48R4W1uoM4oOJpAF1ckrkt+6y3
         N1ErO2nwYT7ohr1mxxr7Ww2lnto3XjVS0zI0MCtYDUzkYIcNeYL3leoNwI873GaFQ3MR
         dfCWa/zATxRmmz+pA0DtEaHS61yzZqqkN7YgjnCzPFKUzNvOyph3ThAsv+4M+c1rVS/S
         YS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ykUhzNI/cNQOTH0C22kn8IQFNGkRRVLhOnTQMfHkHBU=;
        b=aP1afk2U2CQfNOJ0pekGXNRQZmPnpX2+6yG4jdTiCJIIdKCmfNANgjfvD/AFpSTzQ7
         J9q+uxgRx73OQrMVv9+mP8r5xd4xDSEpG9l+vzWUnOezkh3tTPkEDNcm+EFSNJvu+au8
         VxoYPGzMNu/Ib0JDKv0aY76gUN1GRPTV4z4SHFf7ciFcj4sPGgSnlLg+ibQZ6C5biKCO
         z9JFriUhfnrNlLFkNukLicIyAiRspHcaeLlnXfdKFvaCJ9S/9Q/izkdmpmJUtmjirZmA
         R7109/yCJQEMELJDkxAHw8Md0uzGXlbaQgCNRMaCXJKAFCCkRjGJ7KIR5H58QmzWr6wc
         f32w==
X-Gm-Message-State: AOAM532R1eisxlRyqGqZKW/wOgzxVLaFfvEeobBIA7t6Y4vNcSnv3Ys8
        mWt1/7D9MJSclFD1TlCiIWQV+MYldv4=
X-Google-Smtp-Source: ABdhPJy0Ry150h+F5I/ho6hy+FYBpErJbUYD3+Uwbxtyca2hLCJrPoHPPjYGosBQwTy/dEG/YKlCXw==
X-Received: by 2002:a17:90a:fd93:: with SMTP id cx19mr5230380pjb.190.1637371489398;
        Fri, 19 Nov 2021 17:24:49 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id c2sm801970pfv.112.2021.11.19.17.24.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 17:24:48 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/4] Bluetooth: MGMT: Use hci_dev_test_and_{set,clear}_flag
Date:   Fri, 19 Nov 2021 17:24:45 -0800
Message-Id: <20211120012448.1476960-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This make use of hci_dev_test_and_{set,clear}_flag instead of doing 2
operations in a row.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Fix marking Device Privacy Flag even when adapter is not capable of
handling Set Privacy Mode.
v3: Add patch for using hci_dev_test_and_{set,clear}_flag and split
changes reworking how HCI_CONN_FLAG_REMOTE_WAKEUP is set and make use of
bitmap to store the supported flags.

 net/bluetooth/mgmt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f8f74d344297..0f91bf15e260 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4041,10 +4041,10 @@ static int set_zero_key_func(struct sock *sk, struct hci_dev *hdev,
 #endif
 
 	if (hdev && use_ll_privacy(hdev) && !hdev_is_powered(hdev)) {
-		bool changed = hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY);
-
-		hci_dev_clear_flag(hdev, HCI_ENABLE_LL_PRIVACY);
+		bool changed;
 
+		changed = hci_dev_test_and_clear_flag(hdev,
+						      HCI_ENABLE_LL_PRIVACY);
 		if (changed)
 			exp_ll_privacy_feature_changed(false, hdev, sk);
 	}
@@ -4139,15 +4139,15 @@ static int set_rpa_resolution_func(struct sock *sk, struct hci_dev *hdev,
 	val = !!cp->param[0];
 
 	if (val) {
-		changed = !hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY);
-		hci_dev_set_flag(hdev, HCI_ENABLE_LL_PRIVACY);
+		changed = !hci_dev_test_and_set_flag(hdev,
+						     HCI_ENABLE_LL_PRIVACY);
 		hci_dev_clear_flag(hdev, HCI_ADVERTISING);
 
 		/* Enable LL privacy + supported settings changed */
 		flags = BIT(0) | BIT(1);
 	} else {
-		changed = hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY);
-		hci_dev_clear_flag(hdev, HCI_ENABLE_LL_PRIVACY);
+		changed = hci_dev_test_and_clear_flag(hdev,
+						      HCI_ENABLE_LL_PRIVACY);
 
 		/* Disable LL privacy + supported settings changed */
 		flags = BIT(1);
-- 
2.33.1

