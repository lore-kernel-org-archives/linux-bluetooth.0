Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50D9C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Nov 2021 01:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbhKTB14 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 20:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbhKTB1z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 20:27:55 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADACC061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Nov 2021 17:24:51 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id r5so10047578pgi.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Nov 2021 17:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7sVyhecDpvB3AeKnp1qw4KudX1dTM8aYUdTupqO00vg=;
        b=BklFX7RWUmz8YZtN9rZ/PM+fNNyPqymtUTFEd0EHl4/YFbhQ3nujeGSTJkEaBCG+bg
         CI3jCgVmBsVkg8K7+5dqKK8kDQ5xzbMB/ttnT5K+1x75seNbFX1Dr4NjzX52V4LkHowS
         GBWT2llvCzbRTJXrDa87dFYcvQXCTC+/NQZA81ksfzvJA4f2yRzF5OCePzs73xOFYn/u
         /B0AIPNr7LJxmj8Z6uk8krpv9d69xclDcFZzchWh2voqXf4uRg2lWA/KQlMr/G5PThUp
         cGe+S+wyMuveptD3BWcWIoIoSevaSRev0fZevBImbwrCqjkxRLW8NupFFv47Ullv+RDs
         LVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7sVyhecDpvB3AeKnp1qw4KudX1dTM8aYUdTupqO00vg=;
        b=bg9EZxdtG8KKcQ5l3tc49+GF3nx3+YFhQduJ+huZjsN5K2V5E1XHS+AjbQznRxlr9v
         zBRLdOzwRTufV12A+4ARwSYjKG5rHvdVdqSJH1ThcfUPlFFC5kMtH5pvZhv2OOht2zdR
         dbjLIimUE9BpQrXzZUiCRkCFwLiB4CvTC+tBe9pxONZW/Locb3BlagupZ9caip62I3x6
         HeXShkeXcwUgjseXKUGKMXkQLDR8X+xQDwSqHim9ugwDv/m+LCJcbK+BA4CJFyKufznx
         szD/c/r8oOusN2duzX7DSeehmXcpt4MtFmvkAGrLRBpdcthlqUxGrlPizvTa88VWG9Zk
         cdHw==
X-Gm-Message-State: AOAM533knDbyooVfAY9I6mz0YwBQ1yLYww2Yp1OJRSYgoLM/AC7b6h8Y
        ya6fuy6FEMyJbxRp0GnWTyvH6rtQD1M=
X-Google-Smtp-Source: ABdhPJzTfd9UnXW3mjlfFll21e+2LLOhXTwD7MJxyTKjdIIhZYHKOayOef8O3Y72LnGgtQH2z//EMw==
X-Received: by 2002:aa7:87c5:0:b0:4a0:25d0:d88c with SMTP id i5-20020aa787c5000000b004a025d0d88cmr68352112pfo.43.1637371490986;
        Fri, 19 Nov 2021 17:24:50 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id c2sm801970pfv.112.2021.11.19.17.24.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 17:24:50 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/4] Bluetooth: Introduce HCI_CONN_FLAG_DEVICE_PRIVACY device flag
Date:   Fri, 19 Nov 2021 17:24:47 -0800
Message-Id: <20211120012448.1476960-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211120012448.1476960-1-luiz.dentz@gmail.com>
References: <20211120012448.1476960-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces HCI_CONN_FLAG_DEVICE_PRIVACY which can be used by
userspace to indicate to the controller to use Device Privacy Mode to a
specific device.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/mgmt.c             | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index fc93a1907c90..9c94d1c49b25 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -153,6 +153,7 @@ struct bdaddr_list_with_irk {
 
 enum hci_conn_flags {
 	HCI_CONN_FLAG_REMOTE_WAKEUP,
+	HCI_CONN_FLAG_DEVICE_PRIVACY,
 
 	__HCI_CONN_NUM_FLAGS,
 };
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0f4b620bc630..925a549e448c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3978,6 +3978,11 @@ static int exp_ll_privacy_feature_changed(bool enabled, struct hci_dev *hdev,
 	memcpy(ev.uuid, rpa_resolution_uuid, 16);
 	ev.flags = cpu_to_le32((enabled ? BIT(0) : 0) | BIT(1));
 
+	if (enabled && privacy_mode_capable(hdev))
+		set_bit(HCI_CONN_FLAG_DEVICE_PRIVACY, hdev->conn_flags);
+	else
+		clear_bit(HCI_CONN_FLAG_DEVICE_PRIVACY, hdev->conn_flags);
+
 	return mgmt_limited_event(MGMT_EV_EXP_FEATURE_CHANGED, hdev,
 				  &ev, sizeof(ev),
 				  HCI_MGMT_EXP_FEATURE_EVENTS, skip);
@@ -4461,6 +4466,13 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (params) {
 			bitmap_from_u64(params->flags, current_flags);
 			status = MGMT_STATUS_SUCCESS;
+
+			/* Update passive scan if HCI_CONN_FLAG_DEVICE_PRIVACY
+			 * has been set.
+			 */
+			if (test_bit(HCI_CONN_FLAG_DEVICE_PRIVACY,
+				     params->flags))
+				hci_update_passive_scan(hdev);
 		} else {
 			bt_dev_warn(hdev, "No such LE device %pMR (0x%x)",
 				    &cp->addr.bdaddr,
-- 
2.33.1

