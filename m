Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A95CCD37AF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Sep 2023 23:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237994AbjIOXWM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Sep 2023 19:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237950AbjIOXVr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Sep 2023 19:21:47 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211961FE0
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 16:21:43 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so2126075a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 16:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694820102; x=1695424902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oWovvwV6RqYuE0gLiBxHUd3cEuUE/+wFd/+K5yBGVao=;
        b=gTvqjIHgkjohzDZGoa/WpK4BSGSmNzERuKsyrB+CU5P5NP0g2AutqKrAlnen6VlrsF
         Dd1r2CYgOeDd5B00m9TFjhzzFsQBo2PBpSS6UYd/b7H9qPubDPpQqlrdlpqRDaNHUltc
         yExN4YOnbzzW67nlrqs1k03k0cbqQFr5MQQN7oAwfkZdPyGnkbb6xqUeWCfN0gq4i8hd
         bKlB7QGdSV/75ri5RCDyGXsQ1NpWyyS4Nm52hHSJMNcBpXxaUaMIgtJUyWxA6auppuDO
         biS8QpwYrCLrlO/413048ZXjImHgQSw7w353LvoijI5ikgMDrhMfbngI6+lXT2fJKGqi
         nOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694820102; x=1695424902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oWovvwV6RqYuE0gLiBxHUd3cEuUE/+wFd/+K5yBGVao=;
        b=ZepjeFHurn9zNdLu77igjZCB9Di0UbohGipH+blg7BhvN+Mf3y+akb4T4QWE5YFeq6
         cQ+tseJOY/0X+v2ZAh3ReQv6ufdLA8oTOldRmayyaBwhqdW0osNenS6GmVAprO4c9xgk
         mFPy/bfO9epMVjvTTh3xl7C+P1/826NNX5g7kfDDvVV35ovJvE03I9DgBXPX32zATmlJ
         iTluDZoL/icm2u+ChF0cOHE5nZH2VUBH2275Ke3YDZ/ge0nX6+nKCd4ANwx6LjlyJ3y/
         Kp2l4pmJvIsnkXOhZJEg8HAryOVNVc82Aa5PM2gezDFPGYX1i2d8fMr9c3FgQ91VPdlu
         +evQ==
X-Gm-Message-State: AOJu0Yxir7oDHi5SPAppBsRiyLNC4x9cpTy7PaFun1Gkd08RwLFYTw/9
        hnBSs8Cmasc5W0couThqwGELEZcYNa4=
X-Google-Smtp-Source: AGHT+IEBBp1SaUN59SbayXg6+zV+oRMkhH7KlDFbk5v2lijYut7Wh0HkmkruOFIpZvdz0zd+tLBWqg==
X-Received: by 2002:a05:6a20:914d:b0:159:ee33:12f with SMTP id x13-20020a056a20914d00b00159ee33012fmr3743406pzc.56.1694820101877;
        Fri, 15 Sep 2023 16:21:41 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id p24-20020aa78618000000b0068746ab9aebsm3583212pfn.14.2023.09.15.16.21.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 16:21:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: hci_core: Fix build warnings
Date:   Fri, 15 Sep 2023 16:21:38 -0700
Message-ID: <20230915232139.3661778-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index db4f28d68d71..5a7fb496297b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2617,7 +2617,8 @@ int hci_register_dev(struct hci_dev *hdev)
 	if (id < 0)
 		return id;
 
-	snprintf(hdev->name, sizeof(hdev->name), "hci%d", id);
+	snprintf(hdev->name, sizeof(hdev->name), "hci%u",
+		 id ? id % HCI_MAX_ID : id);
 	hdev->id = id;
 
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
-- 
2.41.0

