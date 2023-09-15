Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D241CD37AF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Sep 2023 23:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbjIOXr6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Sep 2023 19:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbjIOXrv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Sep 2023 19:47:51 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453B82119
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 16:47:46 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68a3ced3ec6so2480283b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 16:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694821665; x=1695426465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FydRHNuSiU9lI0l5Le9Lmmb62FGr7xwRau34f1XeHkA=;
        b=He+8fYpkRIg97FEZlfDlYdxsMGqCLFzSUpLoqa/VUD7RMomQ4tHw1ndREKjGXUD9c+
         BRXJHiXQ9zLbSKNUY8M0y/oH0GeqGVw/78YRtzU7dROwHUYeneyjvXcjE7ES1xoU6AKp
         d7A8U91GapLFTUpE1tfSDdjRlSV1kAranCRsRwLC9zzhMDkdNUhYiCam0N4dHkRe9DEp
         ZAbBEgToKbodWtHG3HbW9mj3VNAsK6XUuw00a1BFmma6Hc3J7zhx6XBYE1jIGXnX2jL8
         F4rHsiYzjuIBdVJySrLrrLTiTY4eWMXA7aXKM8SQAIgV+oaNqkjd2pdn0xPjCbh0xtIM
         eG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694821665; x=1695426465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FydRHNuSiU9lI0l5Le9Lmmb62FGr7xwRau34f1XeHkA=;
        b=pakLS5LF3Mfh3JuUFNzXQycc/+xAyIQggN6iRLRqlfeMvgU1BImVgxz2k0uANDGwz2
         /WBB7sxAb6mTV86Yzwe5MiBD8xhMd0Sb/Rho8T2ygDyH/I7BPFFiEqMKGI1QhAehhVBw
         Hf7aAde2MsOYYE2N6QnPLFlIEzj2PklL9byLRb0ebyd6d6f6aQqmQePS/Oau04TnKBNM
         Y27sT4CSUgtqxBHszyIeabYbMPvUMk6nY156KN2L27K9rq/Rrn4tJZNs+YzzfA6/zPgo
         z2A05l71VSHHB0Y1zijW9a2gh6BAsNi2/Cm68EoDv63Dta1Wt7sRk1ghY+Je/4obyWKb
         RiLg==
X-Gm-Message-State: AOJu0Yw2TZiCAroHZzThzm2sepj73AzukYo/jhkk/O7XwgBLdoDVUGPL
        TIT/C7YpcopfbYc1fatZr+z2FY1QxRk=
X-Google-Smtp-Source: AGHT+IG1ttqC6eWr0cXDFdNd9RAq797rLgEm9E73CSxYkG7m/KkAR0SmfZDyVmqxmYMCb1Y7KF5l3w==
X-Received: by 2002:a05:6a00:150e:b0:68a:5449:7436 with SMTP id q14-20020a056a00150e00b0068a54497436mr3460242pfu.32.1694821664983;
        Fri, 15 Sep 2023 16:47:44 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id k22-20020aa790d6000000b0068fdb59e9d6sm3438129pfk.78.2023.09.15.16.47.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 16:47:44 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: hci_core: Fix build warnings
Date:   Fri, 15 Sep 2023 16:47:41 -0700
Message-ID: <20230915234742.3739283-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following warnings:

net/bluetooth/hci_core.c: In function ‘hci_register_dev’:
net/bluetooth/hci_core.c:2620:54: warning: ‘%d’ directive output may
be truncated writing between 1 and 10 bytes into a region of size 5
[-Wformat-truncation=]
 2620 |         snprintf(hdev->name, sizeof(hdev->name), "hci%d", id);
      |                                                      ^~
net/bluetooth/hci_core.c:2620:50: note: directive argument in the range
[0, 2147483647]
 2620 |         snprintf(hdev->name, sizeof(hdev->name), "hci%d", id);
      |                                                  ^~~~~~~
net/bluetooth/hci_core.c:2620:9: note: ‘snprintf’ output between 5 and
14 bytes into a destination of size 8
 2620 |         snprintf(hdev->name, sizeof(hdev->name), "hci%d", id);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 2 +-
 net/bluetooth/hci_core.c         | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index bbad301f5781..f36c1fd5d64e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -350,7 +350,7 @@ struct hci_dev {
 	struct list_head list;
 	struct mutex	lock;
 
-	char		name[8];
+	const char	*name;
 	unsigned long	flags;
 	__u16		id;
 	__u8		bus;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index db4f28d68d71..9e89843c259b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2617,7 +2617,11 @@ int hci_register_dev(struct hci_dev *hdev)
 	if (id < 0)
 		return id;
 
-	snprintf(hdev->name, sizeof(hdev->name), "hci%d", id);
+	error = dev_set_name(&hdev->dev, "hci%u", id);
+	if (error)
+		return error;
+
+	hdev->name = dev_name(&hdev->dev);
 	hdev->id = id;
 
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
@@ -2639,8 +2643,6 @@ int hci_register_dev(struct hci_dev *hdev)
 	if (!IS_ERR_OR_NULL(bt_debugfs))
 		hdev->debugfs = debugfs_create_dir(hdev->name, bt_debugfs);
 
-	dev_set_name(&hdev->dev, "%s", hdev->name);
-
 	error = device_add(&hdev->dev);
 	if (error < 0)
 		goto err_wqueue;
-- 
2.41.0

