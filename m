Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B255C433DB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Mar 2021 00:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ABDE64F87
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Mar 2021 00:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhCMApM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Mar 2021 19:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhCMAon (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Mar 2021 19:44:43 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D63AC061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Mar 2021 16:44:43 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id y13so3000349pfr.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Mar 2021 16:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2SxAcovGs2+Jk9LZgigUFrntEe7dXxNDaa4Z1C1CUBE=;
        b=e4nuvdK5SzKhAki0irI9GcTxID5A6yayEXO/D8RUMQfknzYQn4BVp/VV+GGFBKcy/Q
         ozFhrJIoybMNZ3i3ryoufV0O3N2VN99stSDutlW3/YXmTH5JMbAQAQ3Fh2VnWlyHBI5X
         sKyHlGzj2gm0JVYMOpLSeXix9aAhppPLRmyPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2SxAcovGs2+Jk9LZgigUFrntEe7dXxNDaa4Z1C1CUBE=;
        b=YTWZ7uuqO7ziCiV+FG2wiz6im77Po++iV5OoEPk9bRZO0n8C5xwx0roXjrVxOCrpzU
         D0sPYftRgCav0aQsD94Sf6Q79XGxW8GgvCS5MPAXKo1op1LFLX4aJoJVzCXTPGBHoxOy
         b9f3E/LXzTHoRNH7YC9osda6NAQKcOMWg01PhSF9hLcAhilyVHHeJPjJdRPOPgbEIxV6
         O/KJm8aJxw65IR08rYpGyStSVTVX4icSE6vDgdeJq6Yb38K+Q24pg3ICvZbF35qB3o3a
         n0MApgTCXoomy3OlDsjkwoXRdRGDOhRGlhDWYW2kozLJfqdYVfdYB5q90MseE07M+ZZ4
         xBTA==
X-Gm-Message-State: AOAM531Q7NP9GR8HNnGRGOgzlgegyINlF6FkG6YNlHmHNFXmJ4FcgI8J
        Xia3pud3bM0z4UZdYodS8KrbcQqjHeIFqg==
X-Google-Smtp-Source: ABdhPJxTA7g45TYgpbGOrhI6LObBMV9qw8WVUXUOFXJpmw+vUMcKVDZD1nuvIq5Ex2rg1kVx1T9KQw==
X-Received: by 2002:a05:6a00:8d2:b029:1f1:5b57:85ae with SMTP id s18-20020a056a0008d2b02901f15b5785aemr766772pfu.60.1615596282639;
        Fri, 12 Mar 2021 16:44:42 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:78cf:b6f4:e2a:4f9d])
        by smtp.gmail.com with ESMTPSA id n10sm6390432pgk.91.2021.03.12.16.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Mar 2021 16:44:42 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [PATCH] Bluetooth: Cancel le_scan_restart work when stopping discovery
Date:   Fri, 12 Mar 2021 16:44:35 -0800
Message-Id: <20210313004435.73331-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Not cancelling it has caused a bug where passive background scanning is
disabled out of the blue, preventing BLE keyboards/mice to reconnect.
Here is how it happens:
After hci_req_stop_discovery, there is still le_scan_restart_work
scheduled. Invocation of le_scan_restart_work causes a harmful
le_scan_disable_work to be scheduled. This le_scan_disable_work will
eventually disable passive scanning when the timer fires.

Sample btmon trace:

< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
        Type: Passive (0x00)
        Interval: 367.500 msec (0x024c)
        Window: 37.500 msec (0x003c)
        Own address type: Public (0x00)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
        Scanning: Enabled (0x01)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
...
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
// Background scanning is not working here onwards.

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Sonny Sasaka <sonnysasaka@chromium.org>

---
 net/bluetooth/hci_request.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index d7639c4b63104..c64b4a06de708 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -2710,6 +2710,7 @@ bool hci_req_stop_discovery(struct hci_request *req)
 
 		if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
 			cancel_delayed_work(&hdev->le_scan_disable);
+			cancel_delayed_work(&hdev->le_scan_restart);
 			hci_req_add_le_scan_disable(req);
 		}
 
-- 
2.29.2

