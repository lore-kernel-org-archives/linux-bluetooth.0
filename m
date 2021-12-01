Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CF5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Dec 2021 19:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245485AbhLATxt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Dec 2021 14:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245468AbhLATxX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Dec 2021 14:53:23 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB82C06175A
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 11:49:56 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id z6so18537486plk.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Dec 2021 11:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/lLfEm/ZKVuJS0aITX55IpwHJw9It37eiV/mbuWOt7s=;
        b=hsyaMNCcla/uSDLR4trs+J54vUWUywChakN0zGNRoH4aVdepng8VvpZ4HzNByWc5nv
         PvsEEhjkLttMwoKXjCaDq8CQSPn1kULxba3tOv6e50kfvOtc+k5EYpzvyDoHFSIvPGNd
         oaX47rEyaBbuEWAY5yi6ZDqsYEAWrndvRkoy1bQNDtsDKrkClmP3f9x+bz8uv5Lp54/l
         1eDSmCO2kdYt3hYDgJii448Cp8ZabyL2NgTRlqVm3AM5ntIA5ReEhzyvP3znLaMPFi/d
         0C+6GSwC85Zu5Iu4kZLxDAxulmWYG0q7JzQGcxxOLFPsnUCVwFQeeiizSTu8u1U9Mwjn
         Nqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/lLfEm/ZKVuJS0aITX55IpwHJw9It37eiV/mbuWOt7s=;
        b=GGha9XPmOJ7rutWynb+XOckiVCdZqDMJ+ra3/PTs/32GQo/fSqbmKzhx8BSQmRA7lS
         C46JununbdJJNI5WWhHYLDo/jgJ+Ia/Ue4kjXxb/J7Tdqh52rV55SZqzGMMIyXBjm06z
         FX2p+kCunjPEao5WLB4AyWdwk55v0t3RBbAzEAudM6d4I7XxsV3DnUqkAw46N+IJ4WAd
         gfYW2d/k/CTCMZXntssurV3oVNE7Q21zG9KUIY/QwH1y6+BapcYGJNz3QvHldOTeN6Pt
         xsTL5jHix9Oqd5hBDdl47eHrARDGr9EZrGJC6ZtT6r96evnkX3qnlmi3w2ClBq2shxeA
         XJDw==
X-Gm-Message-State: AOAM53280x4ca0jYCUYIunn+E5/DQXSNnbrZXxLDab3vybh73QvWmFBv
        YzM4DJnQmxu7v1zGnCD8GFj7OU69Rnw=
X-Google-Smtp-Source: ABdhPJzzAWKrAbx5YZG2XlHYJ/urcNUssG0SekWB94OcQjjjlT1uPM3SCmGplRDzOELknSk9p2dn+g==
X-Received: by 2002:a17:90b:4b0e:: with SMTP id lx14mr395286pjb.160.1638388195619;
        Wed, 01 Dec 2021 11:49:55 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id ip6sm122208pjb.42.2021.12.01.11.49.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 11:49:55 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 3/4] Bluetooth: Introduce HCI_CONN_FLAG_DEVICE_PRIVACY device flag
Date:   Wed,  1 Dec 2021 11:49:51 -0800
Message-Id: <20211201194952.1537811-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211201194952.1537811-1-luiz.dentz@gmail.com>
References: <20211201194952.1537811-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/hci_core.h |  4 ++++
 net/bluetooth/mgmt.c             | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d1b67755a373..cf24af649c7f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -154,6 +154,7 @@ struct bdaddr_list_with_irk {
 
 enum hci_conn_flags {
 	HCI_CONN_FLAG_REMOTE_WAKEUP,
+	HCI_CONN_FLAG_DEVICE_PRIVACY,
 
 	__HCI_CONN_NUM_FLAGS,
 };
@@ -1466,6 +1467,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define use_ll_privacy(dev) (ll_privacy_capable(dev) && \
 			     hci_dev_test_flag(dev, HCI_ENABLE_LL_PRIVACY))
 
+#define privacy_mode_capable(dev) (use_ll_privacy(dev) && \
+				   (hdev->commands[39] & 0x04))
+
 /* Use enhanced synchronous connection if command is supported */
 #define enhanced_sco_capable(dev) ((dev)->commands[29] & 0x08)
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7d3c69c3cf62..17a5f972cc65 100644
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

