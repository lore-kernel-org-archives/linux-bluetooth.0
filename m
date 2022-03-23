Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0430AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 20:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240790AbiCWUyD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344812AbiCWUx7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 16:53:59 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053338B6DD
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 13:52:29 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id g3so2721322plo.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 13:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fQwh4amWpFaUYFE3yRHpnASrf87h4cacFDES28Pe7yU=;
        b=hk0g0ytehl7tarlOOTOJjAbTxp02X7fWO6OMZSz7vroIURW4Bkop5zhybyqxy7yOKq
         Uqql+w7pf+8fogZjcnwevpqO2sIjooSPW8avY8isnNJ3yS9W87a6139m8mCoNrM4JZmQ
         0Dyuptm7HMOOUBJw10y5eQSh+SYy26Uam5J16LwlsdXjkgNWDycxm+mKdU7p3NZJf50U
         VqxWwg9mfAxahSQXwQmLMNDObxXCvtWl5RQOYpsw0gB/PBz3mqf8GbNyWGygsQt8TMKT
         /TWGMzDybc/JnL8sfwc2naoXRF0/9I6W9RfLbUuT+IoWqrUQf5kg53A8YKadtG6vjwBd
         CUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fQwh4amWpFaUYFE3yRHpnASrf87h4cacFDES28Pe7yU=;
        b=tGrg2TrBj2Sdp1AEPfky4mI2gtND3SyIAxJ3Gzv+xECIWoBFjulcwK6UvQBv9WtvdH
         LGx0Ncajs0/YY/LtwdQnDO9bIZZC+o/vm6057NwVDVy2wrMcsexjvOq5PFGpncO3oS/9
         Qg/IjuI8a0uJzUb9c6XnIjV4hKXEZOq5tUtfe0RSMkR4RAUAsPOtSu2fQ/GR3un6/gk8
         ZboSXFATC2vVySIzLaQleZ/319kDOD6B2M3pNqefq0J99aER1xtOG1ABE56hu3M1DNhk
         E58g9pBXeN/oSh9Pl2ZS0jHgBe5L2+2YL1hM15C8aDQIJEKHf3mKB2GvtT+W7VC9godj
         l7Dw==
X-Gm-Message-State: AOAM531zS57OUgNgf/LdnXQVMGwmv+o85hOHFPDTBhIMDsmLpLohIWq8
        0qwiJhhElM48aEKlq87yzXl0eCP/rps=
X-Google-Smtp-Source: ABdhPJyRKOGWGYcDc/RVqXuDPL6sy2iCeKUP+vuXCNIWu+0x4J5BhCCTAUT2R7uq/RfsHb1baORb0Q==
X-Received: by 2002:a17:902:6ac7:b0:150:24d6:b2ee with SMTP id i7-20020a1709026ac700b0015024d6b2eemr1961139plt.168.1648068748263;
        Wed, 23 Mar 2022 13:52:28 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id j4-20020a056a00174400b004fabbccb1a5sm743873pfc.94.2022.03.23.13.52.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:52:28 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ] adapter: Introduce BTD_ADAPTER_DBG
Date:   Wed, 23 Mar 2022 13:52:27 -0700
Message-Id: <20220323205227.3605495-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces BTD_ADAPTER_DBG which includes the controller index
when using DBG_IDX, in addition to it also add similar macro for
devices in the form of BTD_DEVICE_DBG which resolves the adapter and
before calling BTD_ADAPTER_DBG.
---
 src/adapter.h | 4 ++++
 src/device.h  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/src/adapter.h b/src/adapter.h
index 35deb1d11..515be3210 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -23,6 +23,10 @@
 /* Invalid SSP passkey value used to indicate negative replies */
 #define INVALID_PASSKEY		0xffffffff
 
+#define BTD_ADAPTER_DBG(adapter, fmt, arg...) \
+	DBG_IDX(btd_adapter_get_index(adapter), "%s:%s() " fmt, __FILE__, \
+							__func__ , ## arg)
+
 struct btd_adapter;
 struct btd_device;
 struct queue;
diff --git a/src/device.h b/src/device.h
index 071576d6b..4d40d1d22 100644
--- a/src/device.h
+++ b/src/device.h
@@ -11,6 +11,10 @@
 
 #define DEVICE_INTERFACE	"org.bluez.Device1"
 
+#define BTD_DEVICE_DBG(device, fmt, arg...) \
+	BTD_ADAPTER_DBG(device_get_adapter(device), "%s:%s() " fmt, __FILE__, \
+							__func__ , ## arg)
+
 struct btd_device;
 
 struct btd_device *device_create(struct btd_adapter *adapter,
-- 
2.35.1

