Return-Path: <SRS0=tE/w=AI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD76C433DF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Jun 2020 15:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C2D20E65
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Jun 2020 15:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aNXxH7QF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgF0PyR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 27 Jun 2020 11:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgF0PyQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 27 Jun 2020 11:54:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEBCC061794
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jun 2020 08:54:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 186so13233402yby.19
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jun 2020 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lnAP9OhJlAY93fzj+swsU4eGATebCgkRo6VUKe/q84A=;
        b=aNXxH7QF4mT8EJBrb7rUIpA6VGypZt0dE+seoVOKFBbzP1B1Q5kT9n001SGOuDh6Pd
         irtfexwF+jqJ4/PpZXkV9YJyKerOxSl1NKiLduON1RjO5ADLnq8GOJxEtEacUsr/vx3l
         l8nq4XGYDDFDYeSfqky2bVnKb9tQvrPTUrsLbaaiPkmtZfaxzDHPWtS5Wnk+8ePcUMvA
         1Y3uc56txajDt+2Tfn5CKlRLQqiLxKCJ2N+TMcCHARUzprtI3+yFK4E8SwK3RQheoIVo
         zdWu9UStdMmP1e8aAkPN89SAYawxxBfeSaYtO03C0jkdWZ0ZQ0tjrnE1AwLD5QlDhjOb
         hBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lnAP9OhJlAY93fzj+swsU4eGATebCgkRo6VUKe/q84A=;
        b=de4VLDaIx9RViH//aQJB6v1kno30rw/e+p19TCQmyh/W43Oge9gGMdxohAmIgicthv
         MMaD7B1pu1rhCfcEpj8JdVWWBcz4FqyJ48UHopR+BfA2cvEdEp2LP/7RutwMMgXIicuQ
         DiBTy7kVYwxA0y8ssyDZWmrLe88jIV8Z0eMmueLIBtflFcKtSwSGA46uxy7LWdtJ7Oj6
         6oUdsH6vrYZrhMgPtIgNyXy7PCieMPRpOozOdv9QUVu/5hkqtvd2Z48ahaJ3PRl6SwsS
         rL8Oy+FBWRY/kZ+oOCuG3E5FJZc6MK3CmOt6fJvJKWGD13feA1+47VUB0FYmuMLQBxZa
         fb7g==
X-Gm-Message-State: AOAM533ze9hiVsTOzL0WqWWCwn8lo2eODRENmor0jt9nhdC4aO4PQy+Q
        0UeMAK4aTlBL4bP/qENngoOlspCKaCMjFcS/Qeh0NV37qdzrqhaq5RXQhW1qzyjj4c0JFHKkSM5
        fwa+WpRS41dlprvxFZSC0tA8ip6zKwUHLlNWttqEkZVLNpeKtxgf8yV/v/ToOXvlhLAi5nOXRyN
        Fu
X-Google-Smtp-Source: ABdhPJzVR/0aW6M5MPYlGq8wF1k2BPX/H+pLrTBCV7SHkfdgnXKrR4JI76aPtS6Tl0kn2rcVDh/YFwiz7f3X
X-Received: by 2002:a25:d28e:: with SMTP id j136mr13666051ybg.516.1593273255575;
 Sat, 27 Jun 2020 08:54:15 -0700 (PDT)
Date:   Sat, 27 Jun 2020 23:54:07 +0800
Message-Id: <20200627235318.Bluez.v2.1.I1322f6745fa50365c1c88de3e2c50c9c5962c094@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [Bluez PATCH v2 1/2] device: add device_remove_bonding function
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

Changes in v2: None

 src/device.c | 25 +++++++++++++++----------
 src/device.h |  1 +
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/src/device.c b/src/device.c
index 7b0eb256e..9fb0e018c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4162,6 +4162,17 @@ static void delete_folder_tree(const char *dirname)
 	rmdir(dirname);
 }
 
+void device_remove_bonding(struct btd_device *device, uint8_t bdaddr_type)
+{
+	if (bdaddr_type == BDADDR_BREDR)
+		device->bredr_state.bonded = false;
+	else
+		device->le_state.bonded = false;
+
+	btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
+							bdaddr_type);
+}
+
 static void device_remove_stored(struct btd_device *device)
 {
 	char device_addr[18];
@@ -4170,17 +4181,11 @@ static void device_remove_stored(struct btd_device *device)
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
index 06b100499..907c7c5c4 100644
--- a/src/device.h
+++ b/src/device.h
@@ -49,6 +49,7 @@ uint16_t btd_device_get_vendor(struct btd_device *device);
 uint16_t btd_device_get_vendor_src(struct btd_device *device);
 uint16_t btd_device_get_product(struct btd_device *device);
 uint16_t btd_device_get_version(struct btd_device *device);
+void device_remove_bonding(struct btd_device *device, uint8_t bdaddr_type);
 void device_remove(struct btd_device *device, gboolean remove_stored);
 int device_address_cmp(gconstpointer a, gconstpointer b);
 int device_bdaddr_cmp(gconstpointer a, gconstpointer b);
-- 
2.27.0.212.ge8ba1cc988-goog

