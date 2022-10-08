Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1EEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Oct 2022 01:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiJHBOP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 21:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJHBOO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 21:14:14 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB4EB48A9
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 18:14:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso7942571pjq.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Oct 2022 18:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aWZTAG1Eih+DouCQoHVwsrrhAQjYzIpkDznjhxpWO28=;
        b=SIC34xdGXg5QTnUb9/7diDr+rrIyWICcLB1XV0idxDpadqx0RF29pq20cv8uVLMirs
         y3/kGzNpGDtHJ/bAcUHS/YI6TdlfdTMiG8zzu8DvbjSZTCKrEYWYN6XjQPdAjhLNXTgF
         qOa2bPVCEVMwhQYHU398zpTUJWe+YCsxVgIhA9HVmUQg67Ij7WFewMdVCmLINTMpRCIq
         0d2/A0s1yuP8MmE43i5TtdG+0sTae4u8+RvUC4qEQjab2OkfeF4yqAZQjnDdoQsCwljz
         jvz+jxLbz5auLaI/cOcY5lDeShfeqMDv95C1gFVHtwH5LgT0Eld2I7tGBqlrjdozKlYa
         SFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWZTAG1Eih+DouCQoHVwsrrhAQjYzIpkDznjhxpWO28=;
        b=NfUpGB+uS3mSYcYJ/LAIkdaEI5lhoxRJLR8LVLJt4p/VtBoBKxGS+eeUrqoUPNfJCM
         TrNTTTm1gnhXkYuKFMWnVDqWGoQsFdidb0atYPWxEb25+pzAXKDBUiysPqIjjSToGwqj
         cYoq51VQgT86StIkc9dWDtDl1ZMVpdFti1l9hVUPSf3vLlrTUTkUsr924ynIgKAr7Bhi
         HcG0XUyBDPcZvDdgPptKUP0bMZA0kgEVWXIkBVUVh4bIhSsNFzON6rFuQRIiVdWhJUS/
         gQR9aKmUKiZMWlbVU6kTB7995AUyHOgZPuOu781MGFui6rguKPHEdMf4a4Gw4SVvEYjm
         Mg/A==
X-Gm-Message-State: ACrzQf0GNPjc0yUcRJ4GaJ+FFvwbFG2bcsj8V0+04q/kd/GjtanF6aMP
        cIOuKLxwAiWgS742VZuTe2bJIZtJRkGNcQ==
X-Google-Smtp-Source: AMsMyM4qGzsRZbW+N//zRbWQDuVfvW5/2njjM/9R5srev+y0aBbLT7URlogRphjcnVGTdpfKvuMe+Q==
X-Received: by 2002:a17:902:7786:b0:178:48c0:a083 with SMTP id o6-20020a170902778600b0017848c0a083mr7763119pll.125.1665191651864;
        Fri, 07 Oct 2022 18:14:11 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 131-20020a621989000000b00561969ea721sm2291938pfz.147.2022.10.07.18.14.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 18:14:11 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] btdev: Add support for setting bdaddr
Date:   Fri,  7 Oct 2022 18:14:08 -0700
Message-Id: <20221008011410.1907549-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds btdev_set_bdaddr so it is possible to set an arbritrary
address.
---
 emulator/btdev.c | 10 ++++++++++
 emulator/btdev.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 3fdfb64a9eba..549f93645684 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -6960,6 +6960,16 @@ const uint8_t *btdev_get_bdaddr(struct btdev *btdev)
 	return btdev->bdaddr;
 }
 
+bool btdev_set_bdaddr(struct btdev *btdev, const uint8_t *bdaddr)
+{
+	if (!btdev || !bdaddr)
+		return false;
+
+	memcpy(btdev->bdaddr, bdaddr, sizeof(btdev->bdaddr));
+
+	return true;
+}
+
 uint8_t *btdev_get_features(struct btdev *btdev)
 {
 	return btdev->features;
diff --git a/emulator/btdev.h b/emulator/btdev.h
index 228bf205cf4b..cad5f699f801 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -72,6 +72,8 @@ bool btdev_set_debug(struct btdev *btdev, btdev_debug_func_t callback,
 			void *user_data, btdev_destroy_func_t destroy);
 
 const uint8_t *btdev_get_bdaddr(struct btdev *btdev);
+bool btdev_set_bdaddr(struct btdev *btdev, const uint8_t *bdaddr);
+
 uint8_t *btdev_get_features(struct btdev *btdev);
 
 uint8_t btdev_get_scan_enable(struct btdev *btdev);
-- 
2.37.3

