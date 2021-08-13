Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CCBC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBA56610CF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240233AbhHMMU2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240175AbhHMMU2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:20:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6C1C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f64-20020a2538430000b0290593bfc4b046so8975202yba.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6xRz0Qm0SECmn6Pgtavnhfow/nmGujogj3e0uaxrCNo=;
        b=GC5iniwgQRS68xPq1n+30ZLfL7qpyGZ2BJDbXlk3k0INJsfcxy0TTYvn+yA7YKOE6Y
         A9vlV2jqg0pVfAgrjrkzsk4AUIMcVcFJI+PJ2XsRKnJ4+P4flDxqqPucpxzMs+qng9n2
         BIkrMnlsy9ume0ZzlU6w6vDeACkTn5vsuhOA9yxaE5LdIAxRKVjESIDY5sdAvAi/jqSU
         q0CM3oW0zKehdkU7nCZ2j/pmFivca8LZLLzI6zQMuLTSqexB9pqOIMwDsKF6lwA5c+Fy
         ttINYAHup54wofM7ww2EzEpo8M36DdjguCmchx8ZgliD5Eki/PkbV3T/IQC/Rsu33F26
         TPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6xRz0Qm0SECmn6Pgtavnhfow/nmGujogj3e0uaxrCNo=;
        b=TfFv11twu6Ko6Yw5jwmMRLaNn7Yb1EbM1fjsBhnsIYabq1yjiOcqhc5J5V7duUyC41
         eGbHQfkacTzNXosysS1DdotZdidfsD8hIEOeLFF8v0bhgvptdIX5+QccgvKImqCZEk8d
         obQhUuuF1tEhpJnsPQNAr6upZ/d7fy5IkMqCvFZxJp4b0qxwxG0bXEoicJQzvkqUKA7P
         bvIfptEnDLuGOnlB3TeQ3SQwUJMDnJ1DbSrM5PjlBz7z84ZtBuGCulzJ/Ves9lD17AZz
         oDUgMHcPMvL9ZVTkTw4Z/mQ/ImlIp7uh/P5j4Wi1xgh4xq/YWHtCGEj+as2LCSr22otm
         xRrg==
X-Gm-Message-State: AOAM532PiGHX9Fj9L7TLwJIS+mjld4DrT1KirFOzeaqpErxVvfUFiI4D
        kWwuxi9awI2dvbXp1OCpLtDgkfFxQqhONOvjq5HBlzSEzNTvjEb3koZtTEGuS5jzoOHzjulAFKm
        cyqOCVxyINq9xa2FOqDCEuv2oOOcCOwUG1PFFAbyYp0H9c1w8iYNyYLxo/rNbxU05mbG4JA0xpe
        Z8
X-Google-Smtp-Source: ABdhPJy65nWs3IFeHLV0d4ZGvJ1anDX7YJhS2o/i6V8NAIGi18iCBPWZsTSJunWYVvgl6oSKY3Cr+/W8p4ka
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a25:83ce:: with SMTP id
 v14mr2843618ybm.221.1628857200916; Fri, 13 Aug 2021 05:20:00 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:17:52 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.7.I2169032b03520f33b73ca4dc7f2ae7ab0a901da3@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 07/62] lib/mgmt: Inclusive language for LTK
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"central" is preferred, as reflected in the BT core spec 5.3.
---

 android/bluetooth.c | 4 ++--
 lib/mgmt.h          | 2 +-
 monitor/control.c   | 4 ++--
 src/adapter.c       | 4 ++--
 tools/oobtest.c     | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index c3ad503497..fe956b5d43 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2276,7 +2276,7 @@ static void new_long_term_key_event(uint16_t index, uint16_t length,
 		ediv = le16_to_cpu(key->ediv);
 		rand = le64_to_cpu(key->rand);
 
-		store_ltk(&key->addr.bdaddr, key->addr.type, key->master,
+		store_ltk(&key->addr.bdaddr, key->addr.type, key->central,
 				key->val, key->type, key->enc_size, ediv, rand);
 	}
 
@@ -3097,7 +3097,7 @@ static struct mgmt_ltk_info *get_ltk_info(GKeyFile *key_file, const char *peer,
 	info->ediv = g_key_file_get_integer(key_file, peer, ediv_s, NULL);
 	info->ediv = cpu_to_le16(info->ediv);
 
-	info->master = master;
+	info->central = master;
 
 failed:
 	g_free(key);
diff --git a/lib/mgmt.h b/lib/mgmt.h
index 0a6349321a..0d1678f01d 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -179,7 +179,7 @@ struct mgmt_cp_load_link_keys {
 struct mgmt_ltk_info {
 	struct mgmt_addr_info addr;
 	uint8_t type;
-	uint8_t master;
+	uint8_t central;
 	uint8_t enc_size;
 	uint16_t ediv;
 	uint64_t rand;
diff --git a/monitor/control.c b/monitor/control.c
index d1ba97d377..97d7e789c4 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -308,13 +308,13 @@ static void mgmt_new_long_term_key(uint16_t len, const void *buf)
 	/* LE SC keys are both for master and slave */
 	switch (ev->key.type) {
 	case 0x00:
-		if (ev->key.master)
+		if (ev->key.central)
 			type = "Master (Unauthenticated)";
 		else
 			type = "Slave (Unauthenticated)";
 		break;
 	case 0x01:
-		if (ev->key.master)
+		if (ev->key.central)
 			type = "Master (Authenticated)";
 		else
 			type = "Slave (Authenticated)";
diff --git a/src/adapter.c b/src/adapter.c
index 663b778e4a..a71ebd15c3 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4028,7 +4028,7 @@ static void load_ltks(struct btd_adapter *adapter, GSList *keys)
 		key->rand = cpu_to_le64(info->rand);
 		key->ediv = cpu_to_le16(info->ediv);
 		key->type = info->authenticated;
-		key->master = info->master;
+		key->central = info->master;
 		key->enc_size = info->enc_size;
 	}
 
@@ -8145,7 +8145,7 @@ static void new_long_term_key_callback(uint16_t index, uint16_t length,
 		rand = le64_to_cpu(key->rand);
 
 		store_longtermkey(adapter, &key->addr.bdaddr,
-					key->addr.type, key->val, key->master,
+					key->addr.type, key->val, key->central,
 					key->type, key->enc_size, ediv, rand);
 
 		device_set_bonded(device, addr->type);
diff --git a/tools/oobtest.c b/tools/oobtest.c
index c095036fe7..0368bc3865 100644
--- a/tools/oobtest.c
+++ b/tools/oobtest.c
@@ -133,13 +133,13 @@ static void new_long_term_key_event(uint16_t index, uint16_t len,
 
 	switch (ev->key.type) {
 	case 0x00:
-		if (ev->key.master)
+		if (ev->key.central)
 			type = "Unauthenticated, Master";
 		else
 			type = "Unauthenticated, Slave";
 		break;
 	case 0x01:
-		if (ev->key.master)
+		if (ev->key.central)
 			type = "Authenticated, Master";
 		else
 			type = "Authenticated, Slave";
-- 
2.33.0.rc1.237.g0d66db33f3-goog

