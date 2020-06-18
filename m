Return-Path: <SRS0=NPxI=77=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF83C433E3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jun 2020 21:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6D9E208DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jun 2020 21:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZZk+ms7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgFRVHL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Jun 2020 17:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgFRVHD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Jun 2020 17:07:03 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047C9C06174E
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2020 14:07:03 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id u17so4392335vsu.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2020 14:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hgqt/bs2UKjnBLgAEpUq3clHZ0oP/HrtIklkQ+jFjjs=;
        b=ZZk+ms7dqownSqJ+CKPyGAYD22zRpI/FipesUUN6pGXL196Nf7q/CItmoa3D4N1/Nq
         yA4y34fDuw5hdIR2uj+UvDcd0qh3yPVmScSwoWsb53NdUxTlaT1141ta1PcMHL8L+7Xq
         0yPPlHd6JrrN5dZUMVQFulE6SwYiWJs6bVglI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hgqt/bs2UKjnBLgAEpUq3clHZ0oP/HrtIklkQ+jFjjs=;
        b=Ijb94k/BCppRwKVNNOWEtlATAMxpAZ+AZ++vltmetLeIo0tzmQloS9VuXAUZEJRqbm
         qwPfZ/BGS4iRSVxvTzJ+SEcO3pDGMkFyBcdkmMSDq5WnTNXT/P6oaFdySW1hUaY2jnQb
         AGff4CvRAGxgtvNpEaav69bef7jaPpxNnZsYqyB0PiSVk0wFMaYUgOcZMBxPxtFHHQft
         sxN7iwMGuM5l7TVBzUTKxy8CSbWYwbIKe4aa4o2L6+AFd22mbtp9wioJR7LtIFIXtTrS
         JtqTYzgH9QgqQX4BHecQA5feuGSru2FJVz+pEElSEkt3f78IwsVWbbTaSaNlCkQzlfbg
         w/wg==
X-Gm-Message-State: AOAM532MBMY+3u54L8LnL2sejUfYbOo24BaNzjLjy9QMdAalnMGMlQJG
        4AjE+aGVcF6tPjsJ+j2IfMR5NEkf9bk=
X-Google-Smtp-Source: ABdhPJzpOK+ugI1KoubyJavbdWPq0a02W1eZn7fthe5dfWVrW0Pmv3zAIXOzURdjn6CuoYqRBxedWw==
X-Received: by 2002:a67:2c4c:: with SMTP id s73mr5275082vss.233.1592514421982;
        Thu, 18 Jun 2020 14:07:01 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id p16sm472977vkd.27.2020.06.18.14.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 14:07:01 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Subject: [PATCH v1] bluetooth: use configured params for ext adv
Date:   Thu, 18 Jun 2020 21:06:59 +0000
Message-Id: <20200618210659.142284-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When the extended advertisement feature is enabled, a hardcoded min and
max interval of 0x8000 is used.  This patches fixes this issue by using
the configured min/max value.

This was validated by setting min/max in main.conf and making sure the
right setting is applied:

< HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036) plen
25                                          #93 [hci0] 10.953011
…
Min advertising interval: 181.250 msec (0x0122)
Max advertising interval: 181.250 msec (0x0122)
…

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Daniel Winkler <danielwinkler@google.com>

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 net/bluetooth/hci_request.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 29decd7e8051..08818b9bf89f 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1799,8 +1799,9 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
 	int err;
 	struct adv_info *adv_instance;
 	bool secondary_adv;
-	/* In ext adv set param interval is 3 octets */
-	const u8 adv_interval[3] = { 0x00, 0x08, 0x00 };
+	/* In ext adv set param interval is 3 octets in le format */
+	const __le32 min_adv_interval = cpu_to_le32(hdev->le_adv_min_interval);
+	const __le32 max_adv_interval = cpu_to_le32(hdev->le_adv_max_interval);
 
 	if (instance > 0) {
 		adv_instance = hci_find_adv_instance(hdev, instance);
@@ -1833,8 +1834,9 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
 
 	memset(&cp, 0, sizeof(cp));
 
-	memcpy(cp.min_interval, adv_interval, sizeof(cp.min_interval));
-	memcpy(cp.max_interval, adv_interval, sizeof(cp.max_interval));
+	/* take least significant 3 bytes */
+	memcpy(cp.min_interval, &min_adv_interval, sizeof(cp.min_interval));
+	memcpy(cp.max_interval, &max_adv_interval, sizeof(cp.max_interval));
 
 	secondary_adv = (flags & MGMT_ADV_FLAG_SEC_MASK);
 
-- 
2.27.0.111.gc72c7da667-goog

