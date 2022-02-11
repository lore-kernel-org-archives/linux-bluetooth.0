Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C160FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Feb 2022 00:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346285AbiBKASp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Feb 2022 19:18:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242748AbiBKASo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Feb 2022 19:18:44 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E451558E
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 16:18:45 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id u16so7532554pfg.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 16:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=n36R9yD2ssxZU4+7XWpdBp0aWbFHEPEK1qICocMBxhw=;
        b=pTRm/JrjyDxk9PGHI+TSJ3+uaOfMFSbsdrvv+VByu4fMDfVgr/jS0sw5E3lc6INGye
         SrFCatTfXfv0iNzCSJjjAWgMYtrEuy5RBWPl5HfNF/3jFSiF9R7ntrRwOFoQ9K3H8fpU
         jrXeuPajgJJQqr+wU/ARKOzpJI7kVswD9uCifdkleFrZ/i0fLzGAKX8mKAkhe26b20Rf
         GZ7ddL4Q9Im/KwmnNFJPvYaPLO7ZwNp+wOkcNqKpzRBqVhmbKxG2GDhfOE/WJZaxvhVy
         8Rky0tMWU9EO3EtIQAZfXmQ2YkZQdldTP9fMJ9WHhB9Tgg0cEDlFmSeNAxyEq5j+NEr7
         ShIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n36R9yD2ssxZU4+7XWpdBp0aWbFHEPEK1qICocMBxhw=;
        b=m4z5h/cnkazSDFSCm7sWSw6Gmhufg4nZX374qXToNM4k3+FX8DPt88qHUEJnuDYZT9
         BrfTmv48VFhHrP1AYWfIPEmxZwxEuZ+7ekzPrnXyqhzQANLRstxCcyG2d8TzaqwHiQTs
         X7tFaT85WC/rzqxNgkEBChG/apKeBmvDTYxsr+nakvjF5NVU01GjAspzb8KSFoRSM8cy
         TftU5Tsgbdf3ybXHw+e1q1iVwZqwc2UUhf+dqhkJXaUXIArNQ1SKRevMJAlpzvPRf1Nx
         pqoxQdfvG6Zz13BE5Vz5ipHRKtPnybS/yymqtVr/Mz1RDQAU2Sctjk+AzvnOa0QlVHF4
         pXig==
X-Gm-Message-State: AOAM5319M+l1pg3ejOZgVQR9fhkbwd8cYpdflfCpGnQdizVhdKGT6S4u
        Cfnq00mS35FI2dACBuJRf+LPQVuwPpY=
X-Google-Smtp-Source: ABdhPJya95Uos853d4iRK5ALJ9HtGIlpjLy+6h2a5tRP1ewpKeb7w9pqdBLp353Sm6//f9hQdqfXJQ==
X-Received: by 2002:a63:8a43:: with SMTP id y64mr1565903pgd.350.1644538724621;
        Thu, 10 Feb 2022 16:18:44 -0800 (PST)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830::169b])
        by smtp.gmail.com with ESMTPSA id n37sm8328321pgl.48.2022.02.10.16.18.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:18:44 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 4/4] device: Fix crash when removing device
Date:   Thu, 10 Feb 2022 16:18:40 -0800
Message-Id: <20220211001840.22566-4-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211001840.22566-1-hj.tedd.an@gmail.com>
References: <20220211001840.22566-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Calling btd_adapter_remove_device from device_remove_connection can
cause a crash, so instead of removing it immediatelly this set a the
temporary timeout to 0.

Fixes: https://github.com/bluez/bluez/issues/290
---
 src/device.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/src/device.c b/src/device.c
index 6a7bdd207..52e2399dd 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3200,6 +3200,28 @@ void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type)
 								"Connected");
 }
 
+static bool device_disappeared(gpointer user_data)
+{
+	struct btd_device *dev = user_data;
+
+	dev->temporary_timer = 0;
+
+	btd_adapter_remove_device(dev->adapter, dev);
+
+	return FALSE;
+}
+
+static void set_temporary_timer(struct btd_device *dev, unsigned int timeout)
+{
+	clear_temporary_timer(dev);
+
+	if (!timeout)
+		return;
+
+	dev->temporary_timer = timeout_add_seconds(timeout, device_disappeared,
+								dev, NULL);
+}
+
 void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 {
 	struct bearer_state *state = get_state(device, bdaddr_type);
@@ -3285,7 +3307,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 						DEVICE_INTERFACE, "Connected");
 
 	if (remove_device)
-		btd_adapter_remove_device(device->adapter, device);
+		set_temporary_timer(device, 0);
 }
 
 guint device_add_disconnect_watch(struct btd_device *device,
@@ -4590,28 +4612,6 @@ void device_set_le_support(struct btd_device *device, uint8_t bdaddr_type)
 	store_device_info(device);
 }
 
-static bool device_disappeared(gpointer user_data)
-{
-	struct btd_device *dev = user_data;
-
-	dev->temporary_timer = 0;
-
-	btd_adapter_remove_device(dev->adapter, dev);
-
-	return FALSE;
-}
-
-static void set_temporary_timer(struct btd_device *dev, unsigned int timeout)
-{
-	clear_temporary_timer(dev);
-
-	if (!timeout)
-		return;
-
-	dev->temporary_timer = timeout_add_seconds(timeout, device_disappeared,
-								dev, NULL);
-}
-
 void device_update_last_seen(struct btd_device *device, uint8_t bdaddr_type)
 {
 	if (bdaddr_type == BDADDR_BREDR)
-- 
2.25.1

