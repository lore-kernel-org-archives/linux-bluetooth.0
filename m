Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3147BE776CB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Oct 2023 23:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbjJBXN0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Oct 2023 19:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237222AbjJBXNZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Oct 2023 19:13:25 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98140D7
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Oct 2023 16:13:21 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c723f1c80fso2579945ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Oct 2023 16:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696288400; x=1696893200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jTfkD4LB0wR3NJmaf5Zf1JnCjxtvsB7d6ETy73XgILw=;
        b=Eo5qjrkdYurH+JaU9Fh+52dpH6uZJD6BUlnU+o1UDVMY6AHM2hQ7Inl3YbSjd3JfIw
         iCCxC/PdZBOzvjJv0wOGQ6lBo8VR91qWpXQ+SxDoANerKHbwEB2PBmWPjDWWaOAe8MGE
         Epv7p/NVZtH0v5TXSvkBZupTV02ggUdqiaZjgamtM7qG9GJo3VMtlDxhLX//BdN1B1dY
         irNHVEVOrZGKfj8RR+lfbkc7J3+WcBGm0dsf+BVWdfK6ZoB4T0b+eye1FYgGuBwbSe+Q
         /M1KgQqlduwH2wMul8z0tDaq5MjOtrGw1UKTEq12ggResSSVyURF8v6s+LGdeDB1g9+G
         NorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696288400; x=1696893200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTfkD4LB0wR3NJmaf5Zf1JnCjxtvsB7d6ETy73XgILw=;
        b=kYbEP5E1zLVqB09jFYJas5/b6oE42C+Wsl4nSleLxhe4ntZd3uBgMDqcq7tlbMbq/a
         1Qwbqla59pjL6L0AfzzSVsRgdbbQgqgAE6siFYpdfgxpWHoQjhro2UvtGH17kn0YGQ5p
         dQMzkoTP2Z1EdD2AY04mOKvTqXM/U18UVj5Vum2+jCXND4GWzbAmWXMDBXnPDe6jZX/P
         OfEDMR4IDMGVbSFVcH2hrmUFJ/RtrxEr7bmdbPEJyjZyVD7Ov89MkqXVAaQgs3qtk8VQ
         VThd+Ss/yDWyRc+k6cOt0w8VQqnX5aQvx1UxsvHRvogBez17X3lqzii+k7py9LEZifNc
         5dGw==
X-Gm-Message-State: AOJu0YwMm2C6yqp2gJBT8bsXMURhUZ9TCN6F2gioibsymLKCrJ1s1WAv
        cboN0j6yQxXXZyPonlF+LB5mpSmRMnnDQDH0
X-Google-Smtp-Source: AGHT+IHWbavW4s0LKB4zGTtVMv+IMcrWnXJtoPXE3u30Uud5xHLT1f+F5vRdWWlzV3PdSL+6/iL9Cg==
X-Received: by 2002:a17:902:c409:b0:1c5:ea60:85c1 with SMTP id k9-20020a170902c40900b001c5ea6085c1mr13693506plk.12.1696288400148;
        Mon, 02 Oct 2023 16:13:20 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id l11-20020a170902d34b00b001c75627545csm5181817plk.135.2023.10.02.16.13.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 16:13:19 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/6] csip: Add support for SIRK encryption
Date:   Mon,  2 Oct 2023 16:13:09 -0700
Message-ID: <20231002231311.3104749-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002231311.3104749-1-luiz.dentz@gmail.com>
References: <20231002231311.3104749-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements SIRK value encryption using the LTK which is accessed
using btd_device_get_ltk.
---
 profiles/audio/csip.c | 36 ++++++++++++++++++++++++++----
 src/shared/csip.c     | 51 ++++---------------------------------------
 src/shared/csip.h     |  5 ++---
 3 files changed, 38 insertions(+), 54 deletions(-)

diff --git a/profiles/audio/csip.c b/profiles/audio/csip.c
index 05bf588d8d6f..a697ebdfbda0 100644
--- a/profiles/audio/csip.c
+++ b/profiles/audio/csip.c
@@ -40,6 +40,7 @@
 #include "src/shared/gatt-client.h"
 #include "src/shared/gatt-server.h"
 #include "src/shared/csip.h"
+#include "src/shared/crypto.h"
 
 #include "btio/btio.h"
 #include "src/plugin.h"
@@ -313,10 +314,37 @@ static struct btd_profile csip_profile = {
 	.experimental	= true,
 };
 
-static bool csis_ltk_read(struct bt_csip *csip, uint8_t k[16], void *user_data)
+static bool csis_encrypt(struct bt_att *att, uint8_t val[16])
 {
-	/* TODO: Retrieve LTK using device object */
-	return false;
+	struct btd_device *device;
+	struct bt_crypto *crypto;
+	uint8_t ltk[16];
+	bool ret;
+
+	device = btd_adapter_find_device_by_fd(bt_att_get_fd(att));
+	if (!device) {
+		error("Unable to find device");
+		return false;
+	}
+
+	if (!btd_device_get_ltk(device, ltk, NULL, NULL)) {
+		error("Unable to get device LTK");
+		return false;
+	}
+
+	crypto = bt_crypto_new();
+	if (!crypto) {
+		error("Failed to open crypto");
+		return false;
+	}
+
+	ret = bt_crypto_sef(crypto, ltk, val, val);
+	if (!ret)
+		error("Failed to encrypt SIRK using LTK");
+
+	bt_crypto_unref(crypto);
+
+	return ret;
 }
 
 static void csis_data_add(struct csis_data *data)
@@ -332,7 +360,7 @@ static void csis_data_add(struct csis_data *data)
 
 	bt_csip_set_sirk(data->csip, btd_opts.csis.encrypt, btd_opts.csis.sirk,
 				btd_opts.csis.size, btd_opts.csis.rank,
-				csis_ltk_read, data);
+				csis_encrypt);
 
 	if (!servers)
 		servers = queue_new();
diff --git a/src/shared/csip.c b/src/shared/csip.c
index 85de63ea626b..53ce155416c7 100644
--- a/src/shared/csip.c
+++ b/src/shared/csip.c
@@ -66,6 +66,7 @@ struct bt_csis {
 	struct gatt_db_attribute *lock;
 	struct gatt_db_attribute *lock_ccc;
 	struct gatt_db_attribute *rank;
+	bt_csip_encrypt_func_t encrypt;
 };
 
 struct bt_csip_cb {
@@ -96,9 +97,6 @@ struct bt_csip {
 	bt_csip_destroy_func_t debug_destroy;
 	void *debug_data;
 
-	bt_csip_ltk_func_t ltk_func;
-	void *ltk_data;
-
 	bt_csip_sirk_func_t sirk_func;
 	void *sirk_data;
 
@@ -218,46 +216,6 @@ static void csip_debug(struct bt_csip *csip, const char *format, ...)
 	va_end(ap);
 }
 
-static bool csip_match_att(const void *data, const void *match_data)
-{
-	const struct bt_csip *csip = data;
-	const struct bt_att *att = match_data;
-
-	return bt_csip_get_att((void *)csip) == att;
-}
-
-static bool csis_sirk_enc(struct bt_csis *csis, struct bt_att *att,
-						struct csis_sirk *sirk)
-{
-	struct bt_csip *csip;
-	uint8_t k[16];
-	struct bt_crypto *crypto;
-	bool ret;
-
-	csip = queue_find(sessions, csip_match_att, att);
-	if (!csip)
-		return false;
-
-	if (!csip->ltk_func(csip, k, csip->ltk_data)) {
-		DBG(csip, "Unable to read sef key");
-		return false;
-	}
-
-	crypto = bt_crypto_new();
-	if (!crypto) {
-		DBG(csip, "Failed to open crypto");
-		return false;
-	}
-
-	ret = bt_crypto_sef(crypto, k, sirk->val, sirk->val);
-	if (!ret)
-		DBG(csip, "Failed to encrypt SIRK using sef");
-
-	bt_crypto_unref(crypto);
-
-	return ret;
-}
-
 static void csis_sirk_read(struct gatt_db_attribute *attrib,
 				unsigned int id, uint16_t offset,
 				uint8_t opcode, struct bt_att *att,
@@ -270,7 +228,7 @@ static void csis_sirk_read(struct gatt_db_attribute *attrib,
 	memcpy(&sirk, csis->sirk_val, sizeof(sirk));
 
 	if (sirk.type == BT_CSIP_SIRK_ENCRYPT &&
-				!csis_sirk_enc(csis, att, &sirk)) {
+				!csis->encrypt(att, sirk.val)) {
 		gatt_db_attribute_read_result(attrib, id, BT_ATT_ERROR_UNLIKELY,
 							NULL, 0);
 		return;
@@ -776,7 +734,7 @@ static struct csis_sirk *sirk_new(struct bt_csis *csis, struct gatt_db *db,
 
 bool bt_csip_set_sirk(struct bt_csip *csip, bool encrypt,
 				uint8_t k[16], uint8_t size, uint8_t rank,
-				bt_csip_ltk_func_t func, void *user_data)
+				bt_csip_encrypt_func_t func)
 {
 	uint8_t zero[16] = {};
 	uint8_t type;
@@ -793,8 +751,7 @@ bool bt_csip_set_sirk(struct bt_csip *csip, bool encrypt,
 	if (!sirk_new(csip->ldb->csis, csip->ldb->db, type, k, size, rank))
 		return false;
 
-	csip->ltk_func = func;
-	csip->ltk_data = user_data;
+	csip->ldb->csis->encrypt = func;
 
 	return true;
 }
diff --git a/src/shared/csip.h b/src/shared/csip.h
index bc5519cfbc49..81c8954aba8d 100644
--- a/src/shared/csip.h
+++ b/src/shared/csip.h
@@ -27,8 +27,7 @@ typedef void (*bt_csip_ready_func_t)(struct bt_csip *csip, void *user_data);
 typedef void (*bt_csip_destroy_func_t)(void *user_data);
 typedef void (*bt_csip_debug_func_t)(const char *str, void *user_data);
 typedef void (*bt_csip_func_t)(struct bt_csip *csip, void *user_data);
-typedef bool (*bt_csip_ltk_func_t)(struct bt_csip *csip, uint8_t k[16],
-							void *user_data);
+typedef bool (*bt_csip_encrypt_func_t)(struct bt_att *att, uint8_t k[16]);
 typedef bool (*bt_csip_sirk_func_t)(struct bt_csip *csip, uint8_t type,
 				    uint8_t k[16], uint8_t size, uint8_t rank,
 				    void *user_data);
@@ -54,7 +53,7 @@ struct bt_csip *bt_csip_new(struct gatt_db *ldb, struct gatt_db *rdb);
 
 bool bt_csip_set_sirk(struct bt_csip *csip, bool encrypt,
 				uint8_t k[16], uint8_t size, uint8_t rank,
-				bt_csip_ltk_func_t func, void *user_data);
+				bt_csip_encrypt_func_t func);
 
 bool bt_csip_get_sirk(struct bt_csip *csip, uint8_t *type,
 				uint8_t k[16], uint8_t *size, uint8_t *rank);
-- 
2.41.0

