Return-Path: <SRS0=Zco+=A3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10373C433E3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 18:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D314F2070E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 18:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RarlXJt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgGPSEq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jul 2020 14:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgGPSEq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jul 2020 14:04:46 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8BBC061755
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2020 11:04:45 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id j4so3908605qvt.20
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2020 11:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5i6s9EyPlfxHx+66OfGFkRV1yvtiRhlOmgOMdROAJ5E=;
        b=RarlXJt2534WE+tm8kUm5giPC/u9gPQUYCeQIT2gsqzD9yXaOojFL4fbOejNQuwrxW
         GdbZiI323Yje6D3FpKTPts8AWyIhQ5TTQC6Oh6JdvP0hNa5ydvkZ6MmIn/b6eWkjZWQ3
         z1+xAICplY0D5eV+RaQem9eYBvez7jvTqiPL44fgjC6FNSQiJnLPUCAVxkLHnFAqoZbk
         SligMV4jg5hru4IZlXMGk/zshLDlXMp7k8oiDNaX8czxCiPfHTajnTOjl2iLAZdrS6ym
         7XsPRl2tB+R9jWinqe9ITAWWC1oFaSb0nVjuvv3ilDGyDQLFIi5Zm5nR4az7Oq/ku4YA
         fBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5i6s9EyPlfxHx+66OfGFkRV1yvtiRhlOmgOMdROAJ5E=;
        b=RL4/pbFE+vouMO6VEy4gY3ntIdLrKCS4RdBFcb+9bJEWhyRtK8KnzMtd7YsFvmxIWH
         +uGZOdWc1BdNr/BYI4puplIUWwJu1F3ChTUrZLClx/vgkZ4jo0w7QJHoi1CKhmFmYhiV
         CAxRadQ4Ddf2dy0ekXscm0fe/170J7e/5egH9UlhuXS/63Tq2oYLkQ2S14TLcY5pQYZS
         YL6CuAH2J2afndTFg21pnwMFTXe1b8GQ8wLU+0tjXtPaQQ4bx1mHXCTjPUziTc4bz9on
         LUBhnTY4edZlLwWLwj9WQCeZEi4I0hNd/5+nxbM9ikfDFouxtJUanz6Waxm4WHLelKF1
         V0nw==
X-Gm-Message-State: AOAM533gXjNzpDZLq4TdMt2/cX7Y4YkB7JEuwCTyXu4UO15mZnW44UdZ
        BcxOv5vclqWSallKo9bIIVdiGHBgvSd0LvVlOD8hUphaNLmyQ2MZh7YyxgkZOOaaGnzuB5QBEL3
        SpKtm3yQp/yW/GOjjLoApOQag6YILxHe8ujnrv+aB1IUOOS/35s7BgSSSWPPxgsXgVRgbnmR1vs
        MH
X-Google-Smtp-Source: ABdhPJxP7E3ud3LqcYh2fkpq0z88RuJ2AJ5SqCcSDXqz47n0AoN2/+LH8Lo7WcVVUUkyOIH5UDeLLAz8nXFM
X-Received: by 2002:ad4:54e9:: with SMTP id k9mr5160647qvx.193.1594922684814;
 Thu, 16 Jul 2020 11:04:44 -0700 (PDT)
Date:   Fri, 17 Jul 2020 02:04:32 +0800
Message-Id: <20200717020332.Bluez.v3.1.I1322f6745fa50365c1c88de3e2c50c9c5962c094@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
Subject: [Bluez PATCH v3 1/2] device: add device_remove_bonding function
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Archie Pusaka <apusaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

This patch splits the "bonding removal" function in device.c,
because we need to remove bonding information when receiving
"virtual cable unplug" in HID profile.

Reviewed-by: Alain Michaud <alainm@chromium.org>
---

Changes in v3:
- Call device_set_temporary on device_remove_bonding

Changes in v2: None

 src/device.c | 28 ++++++++++++++++++----------
 src/device.h |  1 +
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/src/device.c b/src/device.c
index 226216235..b23ecb7fd 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4356,6 +4356,20 @@ static void delete_folder_tree(const char *dirname)
 	rmdir(dirname);
 }
 
+void device_remove_bonding(struct btd_device *device, uint8_t bdaddr_type)
+{
+	if (bdaddr_type == BDADDR_BREDR)
+		device->bredr_state.bonded = false;
+	else
+		device->le_state.bonded = false;
+
+	if (!device->bredr_state.bonded && !device->le_state.bonded)
+		btd_device_set_temporary(device, true);
+
+	btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
+							bdaddr_type);
+}
+
 static void device_remove_stored(struct btd_device *device)
 {
 	char device_addr[18];
@@ -4364,17 +4378,11 @@ static void device_remove_stored(struct btd_device *device)
 	char *data;
 	gsize length = 0;
 
-	if (device->bredr_state.bonded) {
-		device->bredr_state.bonded = false;
-		btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
-								BDADDR_BREDR);
-	}
+	if (device->bredr_state.bonded)
+		device_remove_bonding(device, BDADDR_BREDR);
 
-	if (device->le_state.bonded) {
-		device->le_state.bonded = false;
-		btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
-							device->bdaddr_type);
-	}
+	if (device->le_state.bonded)
+		device_remove_bonding(device, device->bdaddr_type);
 
 	device->bredr_state.paired = false;
 	device->le_state.paired = false;
diff --git a/src/device.h b/src/device.h
index cb8d884e8..956fec1ae 100644
--- a/src/device.h
+++ b/src/device.h
@@ -50,6 +50,7 @@ uint16_t btd_device_get_vendor(struct btd_device *device);
 uint16_t btd_device_get_vendor_src(struct btd_device *device);
 uint16_t btd_device_get_product(struct btd_device *device);
 uint16_t btd_device_get_version(struct btd_device *device);
+void device_remove_bonding(struct btd_device *device, uint8_t bdaddr_type);
 void device_remove(struct btd_device *device, gboolean remove_stored);
 int device_address_cmp(gconstpointer a, gconstpointer b);
 int device_bdaddr_cmp(gconstpointer a, gconstpointer b);
-- 
2.27.0.389.gc38d7665816-goog

