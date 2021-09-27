Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1146C43217
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 22:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99ABC61156
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 22:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbhI0WCL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237265AbhI0WCG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Sep 2021 18:02:06 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76166C061604
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 15:00:28 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id k26so12554626pfi.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 15:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ulYTQxez9S70XO4fJRTVCLBkj/g0R/ce/IyGCduIVrs=;
        b=DFKVxJ1sKKDwkhmsmooUvR8IxX2wtHiTLX0TwYBiYZ3ovoRrGXm4lOtfCuJKR+/0AG
         YZ4KYjn589RPv10YN8WZ6Uzc+Ma78/Wxj/hEzHEKkLn8YYU8Cbypn9ejsh4XVPEUyP10
         jBsm1DljaebJSnEF5ypyAomtLTnFh0Uw/oe2mCur4aQOJssw/3XHe+rSYAHsc6/3W/p3
         RHm2Zwu901sBp2pvTLZWYfzqyduD9HxJoc2i3qH2kjltxswc2Cw87DQHDeMpjf6NIuhw
         8kj+HGjbE8HDUPJuo5/T/maUEVvgaMqi+Z+v2ITitdUnVtCOH3Coiiu75Rx1az3AWobX
         c9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ulYTQxez9S70XO4fJRTVCLBkj/g0R/ce/IyGCduIVrs=;
        b=YbCsHfewgV0kBbEzlKfys4K7Q/rLeVR8NAab4EEE9k1ykqrpksP4BtNHCPkHR+4ZBi
         mKRWbw6H5vzzBsSgN2TmGwf6K0evaupV2js/fUcZouKyop2zpf9HGuJHeCxZtSKGaM7e
         SDp7zWDHo7uMYgeBT1gHQlNXcWXUL4fcfZtS08+1kS3i2CJtD44tKCtNPSlS/EKbtK7D
         UAtkAm+pyA2aigLDzKKW6C/3/suJknljsAH/5CR3amjeCe/UGCPOVRvl+WXiqyA+8+D9
         tjhPSmNFUR1P6pmVVXlAY/1C/zffvfqokOMPs/ednwC0Uqj3SYoT4vdQwUtOHoh6pzD2
         yIbA==
X-Gm-Message-State: AOAM531xWqRbc8CVxZ/s0tq8bSQ/SYFak6GCrqiWW/l59H6yDM4MGsac
        /NjVz4iH7SmvQQqVrfNz5c1erWMwdDo=
X-Google-Smtp-Source: ABdhPJzRy7G7dhZ6xYaCRvFmrJrSKFkhd05O8/ULNzfjfWt4veDKxXN+CzBag39NuUsZ+BBAtWfQ4w==
X-Received: by 2002:a63:e057:: with SMTP id n23mr1594115pgj.183.1632780027584;
        Mon, 27 Sep 2021 15:00:27 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id c18sm19085677pge.69.2021.09.27.15.00.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 15:00:27 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: msft: Fix build when BT_MSFTEXT is not defined
Date:   Mon, 27 Sep 2021 15:00:24 -0700
Message-Id: <20210927220024.2776585-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

ld: net/bluetooth/hci_event.o: in function `msft_suspend':
/linux/net/bluetooth/msft.h:64: multiple definition of `msft_suspend';
net/bluetooth/hci_core.o:/linux/net/bluetooth/msft.h:64: first defined here
ld: net/bluetooth/hci_event.o: in function `msft_resume':
/linux/net/bluetooth/msft.h:64: multiple definition of `msft_resume';
net/bluetooth/hci_core.o:/linux/net/bluetooth/msft.h:64: first defined here
ld: net/bluetooth/mgmt.o: in function `msft_suspend':
/linux/net/bluetooth/msft.h:64: multiple definition of `msft_suspend';
net/bluetooth/hci_core.o:/linux/net/bluetooth/msft.h:64: first defined here
ld: net/bluetooth/mgmt.o: in function `msft_resume':
/linux/net/bluetooth/msft.h:64: multiple definition of `msft_resume';
net/bluetooth/hci_core.o:/linux/net/bluetooth/msft.h:64: first defined here
ld: net/bluetooth/hci_request.o: in function `msft_suspend':
/linux/net/bluetooth/msft.h:64: multiple definition of `msft_suspend';
net/bluetooth/hci_core.o:/linux/net/bluetooth/msft.h:64: first defined here
ld: net/bluetooth/hci_request.o: in function `msft_resume':
/linux/net/bluetooth/msft.h:64: multiple definition of `msft_resume';
net/bluetooth/hci_core.o:/linux/net/bluetooth/msft.h:64: first defined here
make: *** [Makefile:1176: vmlinux] Error 1

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/msft.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/msft.h b/net/bluetooth/msft.h
index 27d73f82b9de..59c6e081c789 100644
--- a/net/bluetooth/msft.h
+++ b/net/bluetooth/msft.h
@@ -61,8 +61,8 @@ static inline int msft_set_filter_enable(struct hci_dev *hdev, bool enable)
 	return -EOPNOTSUPP;
 }
 
-void msft_suspend(struct hci_dev *hdev) {}
-void msft_resume(struct hci_dev *hdev) {}
+static inline void msft_suspend(struct hci_dev *hdev) {}
+static inline void msft_resume(struct hci_dev *hdev) {}
 
 static inline bool msft_curve_validity(struct hci_dev *hdev)
 {
-- 
2.31.1

