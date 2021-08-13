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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FE8C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E174660F46
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240517AbhHMMXJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240515AbhHMMXJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:23:09 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63357C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:42 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id d22-20020a379b160000b02903d298616502so4346404qke.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/j4KemwE7+xppuC192Uv0/YiBWMRPUcz3vJJ8yYdfxQ=;
        b=ATtWswlnnH4a59IkhobWQClSShhMbHIrTbMuvHf7iHGzH6Nqdh0+l9/SCiaOh6u73Y
         O/AT5KNzk3CYvtIU/un1bDdtQ4quAiHjvb2H08kGMaLYWTXIy9Eiy5iOFSfirXLraMt6
         aSeezQlEzdUz9S0HhXOkIL3v9PP1ka9YrLmIcatEWHY0iwB1O3oexKQF2tVwR20f6t0L
         oX4B6Xbv3e+mnmXfNre/YH8UspBKDHdDfRqurhIt45SbKJUUi/D3ogQUUEBxkODZtOPo
         GpaFWrvfhuwrPb9afcqcQuYMWuM8wk0ewRw11CoYZuRIMhwwzBz8A3heLI9mynDaJNk5
         vZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/j4KemwE7+xppuC192Uv0/YiBWMRPUcz3vJJ8yYdfxQ=;
        b=c1c/AJHeVFVl06tsyYWw6jqyHZboJuHr5c6FgMVzE83MDVuu7waja24pvPRGDDTCkr
         7m+S7/fZFFqbeFdHjGYCrMZMgMoTtm1EA3SKX8thhl2vW8YC81MXM0HRsb/hRKmdM650
         BXzyN441lz7+Y1z61eYsIHq0SWcszRzzqJEe1CSQ0B0f1ZmeIojEnhjgbmq4YzYfUY0d
         0kySf9JoVW7ioSNd6Y1cm+hFKFsP4ND8OHpXG/lxsUdmFNlGsmTlTOzOlyWEDsdB9Kp/
         KCcY/TWBpx7Kk5smDRRJUNX+PPtsXakpBrOGRBgLDHKzUrMoZGSiuHvSVaJ8GB9ENtbn
         7JLA==
X-Gm-Message-State: AOAM532Y4hr2g9SomlONoBoIDEMQbiCY974rlH7S946zyjzBIEBl3fNf
        fG6DvmJciWip99Qu8pCer2DzTilmkxJsG0f0M+/cJlkw93fbvZ3Djl8kJKfBYuy2rdvGM0vELxh
        i6mb2NOlC0UeTLnHuDnF+I1JA40yUFyHbvFVQuSvNAlfG/+nJGTA7c5H7WKmwkMg/nmjYXnzvlk
        fm
X-Google-Smtp-Source: ABdhPJyw4hxHPzWndoAaXzs/y0UBXmWnBtu4RiOAa6oOnl9wFvHKB/qbzASAxHzRLascgJFAPf8lty2F12TM
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a05:6214:10c4:: with SMTP id
 r4mr2346200qvs.58.1628857361273; Fri, 13 Aug 2021 05:22:41 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:36 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.51.I90a92f48ae29b2a8d8b18f856ea2a43afba52299@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 51/62] adapter: Inclusive language for storing LTK
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

"central" and "peripheral" are the preferred terms, as reflected in
the BT core spec 5.3.
---

 doc/settings-storage.txt |  4 ++--
 src/adapter.c            | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index d21150f09e..79361d4228 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -294,9 +294,9 @@ Long term key) related to a remote device.
   Rand			Integer		Randomizer
 
 
-[SlaveLongTermKey] group contains:
+[PeripheralLongTermKey] group contains:
 
-  Same as the [LongTermKey] group, except for slave keys.
+  Same as the [LongTermKey] group, except for peripheral keys.
 
 
 [ConnectionParameters] group contains:
diff --git a/src/adapter.c b/src/adapter.c
index 60712f01a0..a23c438f34 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3651,7 +3651,7 @@ static struct smp_ltk_info *get_ltk(GKeyFile *key_file, const char *peer,
 									NULL);
 	ltk->ediv = g_key_file_get_integer(key_file, group, "EDiv", NULL);
 
-	central = g_key_file_get_boolean(key_file, group, "Master", &gerr);
+	central = g_key_file_get_boolean(key_file, group, "Central", &gerr);
 	if (gerr)
 		g_error_free(gerr);
 	else
@@ -3683,7 +3683,7 @@ static struct smp_ltk_info *get_peripheral_ltk_info(GKeyFile *key_file,
 
 	DBG("%s", peer);
 
-	ltk = get_ltk(key_file, peer, bdaddr_type, "SlaveLongTermKey");
+	ltk = get_ltk(key_file, peer, bdaddr_type, "PeripheralLongTermKey");
 	if (ltk)
 		ltk->central = false;
 
@@ -5623,7 +5623,7 @@ static void convert_ltk_entry(GKeyFile *key_file, void *value)
 	g_free(str);
 
 	g_key_file_set_integer(key_file, "LongTermKey", "Authenticated", auth);
-	g_key_file_set_integer(key_file, "LongTermKey", "Master", central);
+	g_key_file_set_integer(key_file, "LongTermKey", "Central", central);
 	g_key_file_set_integer(key_file, "LongTermKey", "EncSize", enc_size);
 	g_key_file_set_integer(key_file, "LongTermKey", "EDiv", ediv);
 
@@ -8047,7 +8047,7 @@ static void store_longtermkey(struct btd_adapter *adapter, const bdaddr_t *peer,
 				uint8_t enc_size, uint16_t ediv,
 				uint64_t rand)
 {
-	const char *group = central ? "LongTermKey" : "SlaveLongTermKey";
+	const char *group = central ? "LongTermKey" : "PeripheralLongTermKey";
 	char device_addr[18];
 	char filename[PATH_MAX];
 	GKeyFile *key_file;
@@ -8069,7 +8069,7 @@ static void store_longtermkey(struct btd_adapter *adapter, const bdaddr_t *peer,
 	g_key_file_load_from_file(key_file, filename, 0, NULL);
 
 	/* Old files may contain this so remove it in case it exists */
-	g_key_file_remove_key(key_file, "LongTermKey", "Master", NULL);
+	g_key_file_remove_key(key_file, "LongTermKey", "Central", NULL);
 
 	for (i = 0; i < 16; i++)
 		sprintf(key_str + (i * 2), "%2.2X", key[i]);
-- 
2.33.0.rc1.237.g0d66db33f3-goog

