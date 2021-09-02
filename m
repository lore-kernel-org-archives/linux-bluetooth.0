Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30268C4320A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 04:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 184F6610CC
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 04:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbhIBEJ2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 00:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhIBEJY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 00:09:24 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DDDC061575
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Sep 2021 21:08:27 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 62-20020a3706410000b02903d2cdd9acf0so601727qkg.21
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Sep 2021 21:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ntTbkCFsC0XIkarphR8FQnkoIMpe7M+avaoRzPz8lgo=;
        b=LbebAqgk9jlefA4fCCL77++Hh0oECRnh373hGNBK3F4/KSCVjuw8bvOxJRn8CsJ7FM
         uW2aeXChQ0Qi9PFDdmF2AkSQph5qYxRcFJsWjHXLroLQNEzOVMzNduxkwlv0wV92Z3oA
         fX5F0djjakmXgtIrmxfyWu9/o7x9FA86CpboYig+8WHPwU7pSVamKKl2TNs7hju6Oz5T
         f/UmjsT+U9AvWnC2e7UXNiZ3Lvau6Rpeo7m7OF7X5FXuhjrHfvYYKD0JYGQUXU3q/4QA
         oNSeAVdl4LqK9RqkpKB1gu6kxc79Qe07m2m1E69oRyeCDyQ0B/n3f0oTu4/dWmXbSjPv
         WjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ntTbkCFsC0XIkarphR8FQnkoIMpe7M+avaoRzPz8lgo=;
        b=qnl4Bnxi+bH2txwXn11x7vZkAHpw1uCJT+BHHE3iS540VTqZlSmJPVMH7M7enPrRf0
         GjSgcNqiy0pvu3LbsJNRlT/MF0iP15kNGtXVI/IN8x0bou26vEQLxpitDHA9bzuEAOsE
         DZuNbefw0pk0k1olXVVcyYveYDP9MAyhmAr9j30dJrclkFTL1Dx6W6XzLQWnokl77/cL
         VTyEiKRoHYkYzaOcXV0Eahy315qXJ0K2KdAdW/Q/6M4j58AZx/1j+Z9bmYZ21TkvMN3z
         n57JfWkdy6jgLnzN1Py51wUYmqEfxKFa5+W+U4jmokPi/ijNsHseO3C4U7wW51ec8dIJ
         PxQA==
X-Gm-Message-State: AOAM532LqIZfHcJFMdnKIe9iJ48LqMpLkTJEaGGMf7noRMrQV4LfyHCp
        HFOrZQyJOGPU4COSM3rSB3pC72iZ+j/r19h7jHz2cyYxoL2usxPZQVINrmGCbWknZ4WqU970Y1a
        A1+t4UFT95qoOiQllchT73XfKxTTOKVKiWOMAH5dVeEBVr1nckaZ78aD4aAnq2cth5VrEyFC8RP
        lE
X-Google-Smtp-Source: ABdhPJyzLZeRrgbrumLqa7Hmgn8eQ50uW8uV9I9g4ToUeHnkky7Z+/r82CMJTAWV4uo5sAlBCA1T7WlsU9Hy
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:5249:e81c:3ce6:f50c])
 (user=apusaka job=sendgmr) by 2002:a0c:e803:: with SMTP id
 y3mr1292645qvn.39.1630555706224; Wed, 01 Sep 2021 21:08:26 -0700 (PDT)
Date:   Thu,  2 Sep 2021 12:07:11 +0800
In-Reply-To: <20210902040711.665952-1-apusaka@google.com>
Message-Id: <20210902120509.Bluez.v2.13.I90a92f48ae29b2a8d8b18f856ea2a43afba52299@changeid>
Mime-Version: 1.0
References: <20210902040711.665952-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [Bluez PATCH v2 13/13] adapter: Inclusive language for storing LTK
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

BT core spec 5.3 promotes the usage of inclusive languages.
This CL replaces some terms with the more appropriate counterparts,
such as "central" and "peripheral"
---

(no changes since v1)

 doc/settings-storage.txt |  4 ++--
 src/adapter.c            | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index 1d96cd66d9..3c637c3521 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -314,9 +314,9 @@ Long term key) related to a remote device.
   Rand			Integer		Randomizer
 
 
-[SlaveLongTermKey] group contains:
+[PeripheralLongTermKey] group contains:
 
-  Same as the [LongTermKey] group, except for slave keys.
+  Same as the [LongTermKey] group, except for peripheral keys.
 
 
 [ConnectionParameters] group contains:
diff --git a/src/adapter.c b/src/adapter.c
index 4ad53a3a24..8528e2b6e0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3745,7 +3745,7 @@ static struct smp_ltk_info *get_ltk(GKeyFile *key_file, const char *peer,
 									NULL);
 	ltk->ediv = g_key_file_get_integer(key_file, group, "EDiv", NULL);
 
-	central = g_key_file_get_boolean(key_file, group, "Master", &gerr);
+	central = g_key_file_get_boolean(key_file, group, "Central", &gerr);
 	if (gerr)
 		g_error_free(gerr);
 	else
@@ -3777,7 +3777,7 @@ static struct smp_ltk_info *get_peripheral_ltk_info(GKeyFile *key_file,
 
 	DBG("%s", peer);
 
-	ltk = get_ltk(key_file, peer, bdaddr_type, "SlaveLongTermKey");
+	ltk = get_ltk(key_file, peer, bdaddr_type, "PeripheralLongTermKey");
 	if (ltk)
 		ltk->central = false;
 
@@ -5780,7 +5780,7 @@ static void convert_ltk_entry(GKeyFile *key_file, void *value)
 	g_free(str);
 
 	g_key_file_set_integer(key_file, "LongTermKey", "Authenticated", auth);
-	g_key_file_set_integer(key_file, "LongTermKey", "Master", central);
+	g_key_file_set_integer(key_file, "LongTermKey", "Central", central);
 	g_key_file_set_integer(key_file, "LongTermKey", "EncSize", enc_size);
 	g_key_file_set_integer(key_file, "LongTermKey", "EDiv", ediv);
 
@@ -8211,7 +8211,7 @@ static void store_longtermkey(struct btd_adapter *adapter, const bdaddr_t *peer,
 				uint8_t enc_size, uint16_t ediv,
 				uint64_t rand)
 {
-	const char *group = central ? "LongTermKey" : "SlaveLongTermKey";
+	const char *group = central ? "LongTermKey" : "PeripheralLongTermKey";
 	char device_addr[18];
 	char filename[PATH_MAX];
 	GKeyFile *key_file;
@@ -8233,7 +8233,7 @@ static void store_longtermkey(struct btd_adapter *adapter, const bdaddr_t *peer,
 	g_key_file_load_from_file(key_file, filename, 0, NULL);
 
 	/* Old files may contain this so remove it in case it exists */
-	g_key_file_remove_key(key_file, "LongTermKey", "Master", NULL);
+	g_key_file_remove_key(key_file, "LongTermKey", "Central", NULL);
 
 	for (i = 0; i < 16; i++)
 		sprintf(key_str + (i * 2), "%2.2X", key[i]);
-- 
2.33.0.259.gc128427fd7-goog

