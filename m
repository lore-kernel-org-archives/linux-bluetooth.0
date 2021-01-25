Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6247CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 19:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FC26224DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 19:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731774AbhAYTfO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Jan 2021 14:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731935AbhAYTev (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jan 2021 14:34:51 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5079C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jan 2021 11:34:01 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id b17so1755574plz.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jan 2021 11:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cwtWDxmwHSDYWjI4YunYkhhqtXGCnKOek3r8W7tJWA0=;
        b=GIjv2m0e14tlvIVFO/bgZP7eDqPFkQP9tQbkKX+owKzyAOM7vjLtbVXp0bpnbp0Y1B
         RlOpuR2tSaXywifem8nBHi7dUXUYZjvTCWVhYCEfoGG3P+FzQI2J57e8FQDzof/I5zCq
         3ZO4ep1xZ1Jw3hSXu1YadrV6yg3vSMd3dRqcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cwtWDxmwHSDYWjI4YunYkhhqtXGCnKOek3r8W7tJWA0=;
        b=iFXjLbybL9+vPuGAHK3zTLqqM3rYViMzc2Xx52N9g8w/mMEWhxaOQImLEAGQqgO5QA
         JNsBWi8UzNJDvJfLU5ScluV9Tjrra/Ykr6aYCN34Q4qpxwz+/SX7JbntfFw0z3sxJ1CF
         nwtnuIwg6n40F685p9IqfC7smIeq9X/iPA7N408lZgI+CSb3bkZxDw1iZI/5+Jiobrs9
         WYohld4oc1xD7Y6mMBzgi/W4iNziqzyaweQpqbyOwVi+CNg9Mab8ygsVmTRX11KeGIhp
         j/jdXO53ai0YjQSQFLU1F3WqLgKcGKNLcxvz7Km5jyikzq24cDpHPy54/G7A2fqLU9ak
         Td1g==
X-Gm-Message-State: AOAM531iwpSMX7sACV1nlOsWd9S25BLTxNvJHIIIjOPK3KPnlhqmkfZ2
        2mNIJg1Ov3x0YnPnt/QDd75/EWdF3nnjpw==
X-Google-Smtp-Source: ABdhPJw3Ft0qJYkhwdBg5zyznD9aTmBDGu8BBN4COXooLvXRWYg0Zbv6Y2bw6ta5SqptBSykEN3pVw==
X-Received: by 2002:a17:902:edcb:b029:df:cce5:1105 with SMTP id q11-20020a170902edcbb02900dfcce51105mr2063792plk.2.1611603241164;
        Mon, 25 Jan 2021 11:34:01 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:7c08:2ccf:8f7c:2eed])
        by smtp.gmail.com with ESMTPSA id y4sm149599pji.34.2021.01.25.11.33.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 11:34:00 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH BlueZ v3] input/hog: Fix double registering report value callbacks
Date:   Mon, 25 Jan 2021 11:33:54 -0800
Message-Id: <20210125193354.742-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In commit 23b69ab3e484 ("input/hog: Cache the HID report map"), we
optimized HOG reconnection by registering report value callbacks early,
but there was a bug where we also re-register the same report value
callbacks after at CCC write callback. We should handle this case by
avoiding the second callback register if we know we have done it
earlier.

---
 profiles/input/hog-lib.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 1f132aa4c..6ac14e401 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -336,6 +336,9 @@ static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
 		return;
 	}
 
+	if (report->notifyid)
+		return;
+
 	report->notifyid = g_attrib_register(hog->attrib,
 					ATT_OP_HANDLE_NOTIFY,
 					report->value_handle,
@@ -1697,6 +1700,9 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 	for (l = hog->reports; l; l = l->next) {
 		struct report *r = l->data;
 
+		if (r->notifyid)
+			continue;
+
 		r->notifyid = g_attrib_register(hog->attrib,
 					ATT_OP_HANDLE_NOTIFY,
 					r->value_handle,
-- 
2.29.2

