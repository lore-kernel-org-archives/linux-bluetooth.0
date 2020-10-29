Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0902BC55178
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 21:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AFF620FC3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 21:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8KMYxyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgJ2Vwr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgJ2Vwr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 17:52:47 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678B7C0613D2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 14:52:47 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id x23so1958005plr.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 14:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dj2AwENNY4Eel+sbLtG/UnqpqzwcG+5Zo6M/m+oNcJo=;
        b=l8KMYxyVX9SyONOUL69zcPz2Ve1TEThKnAZGkFIe0Fnv1HghBDdaj8KCTyRipes8tE
         TGrZOHTgqyVR1cpxRrFhGRiyEjjvc+Lj4QDOp2PhV07Z6MV+UZDN3ovhSu8KO4JgAyJR
         ZHb3xl5AKSsbqdsGnEAl9rjXwEYdkzec5D9GId0SzMl2X6o6KVubl5tehd4MYRFs/fN7
         1HepTnRvbKpjpzU3nsB01tYgnWdPfAjUy+N4tuRArV/VpXyCx07pgY8d0ldlDsoMDAKR
         y5CDnoe8Y77qdIdcrUv0OlalFeoU3IoK+lpezTVGQemYfzQjjgh/pRRRPrzgM6wI6E6U
         Wdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dj2AwENNY4Eel+sbLtG/UnqpqzwcG+5Zo6M/m+oNcJo=;
        b=nsPz6XloMp8i4HcNpgyPyWVzRBtdlzWYCLa7sWgSs919Xh237rAe83xxFob0bQaPqQ
         uECdS53Oi8ip6GNtKkmqxYwXhsj4yAuEYMD5v29RzrZIyQPKC8h5ApGbr84v5fpQthN0
         JUEWAeNmoTrnsNFp8xAl+zekUprPWgNGvcRM/p9jrQwLvh/BhuBVRsqjybjt7+2Xpeas
         E9SWJhoy/XK99k8g7VykimLF2rfEqBQZxPH6fk6FxofC37mk672dBzXvYLn6ha6dzMuo
         QsIewNf78VD9cdHwjmJLVPw8P/XaYrciUbGosAfR0eUnw0NQe2gl1k6ZRNtDh3yCacI0
         qJCg==
X-Gm-Message-State: AOAM53112K96Dp/akKhFkLwixeUCZNVkltRTZq975Iy1Z6imDxTHwDCe
        LriSvcChgl9zwFLpmvVaYRN+YWE7LwM2nA==
X-Google-Smtp-Source: ABdhPJwcPvrOMkv84LRd+g3Ac078GyU63WHzAdOSeY7rToqAE/FufA8v+ljjngb4Cv0NlI+QZJJgOg==
X-Received: by 2002:a17:902:c152:b029:d6:33a:c46f with SMTP id 18-20020a170902c152b02900d6033ac46fmr6240171plj.38.1604008366665;
        Thu, 29 Oct 2020 14:52:46 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id lw12sm780572pjb.5.2020.10.29.14.52.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 14:52:46 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] emulator/hciemu: Add debug support
Date:   Thu, 29 Oct 2020 14:52:43 -0700
Message-Id: <20201029215243.888555-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029215243.888555-1-luiz.dentz@gmail.com>
References: <20201029215243.888555-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bthost_set_debug which can be used to debug internals of
hciemu.
---
 emulator/hciemu.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 emulator/hciemu.h |  5 +++++
 2 files changed, 53 insertions(+)

diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index fa8905ed7..999bb5a03 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -45,6 +45,10 @@ struct hciemu {
 	guint client_source;
 	struct queue *post_command_hooks;
 	char bdaddr_str[18];
+
+	hciemu_debug_func_t debug_callback;
+	hciemu_destroy_func_t debug_destroy;
+	void *debug_data;
 };
 
 struct hciemu_command_hook {
@@ -385,6 +389,50 @@ void hciemu_unref(struct hciemu *hciemu)
 	free(hciemu);
 }
 
+static void bthost_debug(const char *str, void *user_data)
+{
+	struct hciemu *hciemu = user_data;
+
+	util_debug(hciemu->debug_callback, hciemu->debug_data,
+					"bthost: %s", str);
+}
+
+static void btdev_master_debug(const char *str, void *user_data)
+{
+	struct hciemu *hciemu = user_data;
+
+	util_debug(hciemu->debug_callback, hciemu->debug_data,
+					"btdev[0]: %s", str);
+}
+
+static void btdev_client_debug(const char *str, void *user_data)
+{
+	struct hciemu *hciemu = user_data;
+
+	util_debug(hciemu->debug_callback, hciemu->debug_data,
+					"btdev[1]: %s", str);
+}
+
+bool hciemu_set_debug(struct hciemu *hciemu, hciemu_debug_func_t callback,
+			void *user_data, hciemu_destroy_func_t destroy)
+{
+	if (!hciemu)
+		return false;
+
+	if (hciemu->debug_destroy)
+		hciemu->debug_destroy(hciemu->debug_data);
+
+	hciemu->debug_callback = callback;
+	hciemu->debug_destroy = destroy;
+	hciemu->debug_data = user_data;
+
+	btdev_set_debug(hciemu->master_dev, btdev_master_debug, hciemu, NULL);
+	btdev_set_debug(hciemu->client_dev, btdev_client_debug, hciemu, NULL);
+	bthost_set_debug(hciemu->host_stack, bthost_debug, hciemu, NULL);
+
+	return true;
+}
+
 const char *hciemu_get_address(struct hciemu *hciemu)
 {
 	const uint8_t *addr;
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index c8ec80d8d..d0708277d 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -34,6 +34,11 @@ struct hciemu *hciemu_new(enum hciemu_type type);
 struct hciemu *hciemu_ref(struct hciemu *hciemu);
 void hciemu_unref(struct hciemu *hciemu);
 
+typedef void (*hciemu_debug_func_t)(const char *str, void *user_data);
+typedef void (*hciemu_destroy_func_t)(void *user_data);
+bool hciemu_set_debug(struct hciemu *hciemu, hciemu_debug_func_t callback,
+			void *user_data, hciemu_destroy_func_t destroy);
+
 struct bthost *hciemu_client_get_host(struct hciemu *hciemu);
 
 const char *hciemu_get_address(struct hciemu *hciemu);
-- 
2.26.2

