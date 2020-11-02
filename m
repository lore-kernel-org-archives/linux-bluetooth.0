Return-Path: <SRS0=F55x=EI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F28AC388F9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 19:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0721C2225E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 19:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcTTSU2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgKBTMi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Nov 2020 14:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgKBTMi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Nov 2020 14:12:38 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B34C0617A6
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2020 11:12:37 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id w11so7301374pll.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2020 11:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9X36yZqsc5IH2GNoTHG/441w3rHF6SH1q4Yn51/UZ5A=;
        b=VcTTSU2fZdcl7hSWV0Ygcd2cb+hZjP1lM//MPWjJ4wIhZ/egtysjKM+4njAE9whnKN
         zrGCEwDMhRGnfKQOUm7IXT/yQdI4WvtXjNWeOh0i5MxagSNdrjalRUvl7kSHsfD9z6NT
         9wTlHo+GsDEKKOR0cpXqR2WPEdKd7g7PEPn8d6QCATWvRvFag3Boi63Vnj3sJCbdEipV
         LZYk7Pf0lX1/60V9NZEtMDzBSODoi9Yf8zFl/1cc8eL2dLUAJR4ffBJWNQ49LtsNudlk
         gKBeQycFh9rQ4steTWRDUVCPJz0tpouv+oNApQnrLxRS0TzkNbpblNZsvNSZrcG54RX1
         wGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9X36yZqsc5IH2GNoTHG/441w3rHF6SH1q4Yn51/UZ5A=;
        b=DvfnbdDNXT6dGVSPoMJkA8dGwdupMM2QEzEMjKU2ChRwdvxgYHN8sCYHE7f6vApCct
         PMW2nWRDZ0cuHbQxgZHTXaW02pPfVNz65bFdWQJ02iey3hBMK2BPjm+ovGTp22Vp/0eM
         K1jbUfQA258XLMUdvCdr8z/9XmQicoYdg4nugQAX25nvQ+oeZ+VyballhLjWGRkNAeuo
         kuTt5+KgFGIBP0+dwiQcVl5svWT8Wr0B3ihzMU6jRwGQ1xPefvq+pRU+J5TbsB5By2fU
         ag5v060wD5R+tovQ0c+GvsdOT57pmCJ7X/RHVnoeQWBp4F8tNUZWVsHpO3RkGafjv1GA
         AiPw==
X-Gm-Message-State: AOAM530vcrpdyX/qKA/UjCT1qDMH/2tDCkWXLBb/Xdbe6GMQYwLbSA3/
        8BwgKBOPkSDjyuSjBwivl50PEhKwYO61Lw==
X-Google-Smtp-Source: ABdhPJyq5Knv11YsoSC+RPoHUfdHJBEaF/GqOEXnmZd8LgpuPME5m4OOJMkh6V0hX/piyvH78xhMcA==
X-Received: by 2002:a17:902:9049:b029:d5:eadd:3d13 with SMTP id w9-20020a1709029049b02900d5eadd3d13mr21835420plz.15.1604344356985;
        Mon, 02 Nov 2020 11:12:36 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z10sm14589716pff.218.2020.11.02.11.12.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 11:12:36 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 03/11] emulator/hciemu: Add debug support
Date:   Mon,  2 Nov 2020 11:12:24 -0800
Message-Id: <20201102191232.1848737-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201102191232.1848737-1-luiz.dentz@gmail.com>
References: <20201102191232.1848737-1-luiz.dentz@gmail.com>
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
index fa8905ed7..fd6029deb 100644
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
+					"btdev: %s", str);
+}
+
+static void btdev_client_debug(const char *str, void *user_data)
+{
+	struct hciemu *hciemu = user_data;
+
+	util_debug(hciemu->debug_callback, hciemu->debug_data,
+					"btdev[bthost]: %s", str);
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

