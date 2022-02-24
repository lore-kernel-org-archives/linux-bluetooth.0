Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BCAC4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 00:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiBXAbN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Feb 2022 19:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiBXAbK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Feb 2022 19:31:10 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B94A6D976
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 16:30:41 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id c9so315372pll.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 16:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bN72KDA/URR+CXci2mzM3peVK0aNrF9ntA5ysSCg1Jg=;
        b=Hwxy+h1WWPv68+GPj0AtbKcUXuQnflS7s6LgL6+tsHspp9oHVSqhE9iMlypigCeQ6K
         GhiUB5ZOy0GKKNG/DGNZkUSj2bXO2aSTOi1i5uD4QzBLgQ8jiEqV/78VB5TAs3gf20Lu
         4vT6+eVjbZnDAx22qRStGu7H1KkWjCW+ene5OcstU9RcKVncVgwwgikwNj3mbev6oFrc
         WtWmG3PDkfxRf33k77xINGLSeg+JRv/2n+rQ7B7fPyNDmXbd5JUBQccGrgm2T/f79xen
         x6RJKOLEhVJl6ZSmka9EhBmm+VA8Jf9oVQiHWVkMMpztqq/Xh8Ir2Zok61QgcMi7mc8X
         /Liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bN72KDA/URR+CXci2mzM3peVK0aNrF9ntA5ysSCg1Jg=;
        b=tMMtTPNhkSTgR6wADWiXeJbpxYc/RcPtQqcqPmvk84cdCxfZXcj7nHgcVsEPxudf5M
         0MK3F7DMUq0tSR/BUqNU5X2ZNz7H9p5QxJDPw0cSNVLYOarXwhpCnxZCOidppo001a5O
         02C8hqPYaf2dl3ooNL38Tv4xpI8tofPCwbmQ1rb4ROEy9gl5VZUvQg4mxkLL4J3+lSNO
         QF0cebA0PyYOOdn9fiFK1oq5Y3RCK0NjmEOiHcus4wbQJsRk4aHELjqG555fgLLBt5sW
         NC76Gjx9axkC1vjZBkpLLSgH7F8Aklfn32D9hwkamKARZalr64gnNtUpg08pU7dG4kCd
         3q3A==
X-Gm-Message-State: AOAM532i2EuM3Mtk0ElOCmyOw9UgMgQQ/hdpmUNhKZHupgbt3R9nfXm4
        i+mOw73CgvTp+U0WUqEjywSCtZHepNM=
X-Google-Smtp-Source: ABdhPJykEpmkbq/AzIlYijgxwg6pKxIxIilYogiMkBcymdIRkR3smmXfNntSA/in2BCrgytGgDqjKA==
X-Received: by 2002:a17:90a:ca8d:b0:1bc:649c:6dd1 with SMTP id y13-20020a17090aca8d00b001bc649c6dd1mr121268pjt.165.1645662640253;
        Wed, 23 Feb 2022 16:30:40 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t19sm574570pjs.54.2022.02.23.16.30.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 16:30:39 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/11] bthost: Add support for Create BIG
Date:   Wed, 23 Feb 2022 16:30:29 -0800
Message-Id: <20220224003029.706163-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224003029.706163-1-luiz.dentz@gmail.com>
References: <20220224003029.706163-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bthost_create_big
---
 emulator/bthost.c | 13 +++++++++++++
 emulator/bthost.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index fef542236..43434387c 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -2820,6 +2820,19 @@ void bthost_set_pa_enable(struct bthost *bthost, uint8_t enable)
 	send_command(bthost, BT_HCI_CMD_LE_SET_PA_ENABLE, &cp, sizeof(cp));
 }
 
+void bthost_create_big(struct bthost *bthost, uint8_t num_bis)
+{
+	struct bt_hci_cmd_le_create_big cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = 0x01;
+	cp.adv_handle = 0x01;
+	cp.num_bis = num_bis;
+	cp.bis.sdu = 40;
+	cp.bis.phy = 0x01;
+	send_command(bthost, BT_HCI_CMD_LE_CREATE_BIG, &cp, sizeof(cp));
+}
+
 bool bthost_search_ext_adv_addr(struct bthost *bthost, const uint8_t *addr)
 {
 	const struct queue_entry *entry;
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 55a7adf26..18e7b98e3 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -86,6 +86,7 @@ void bthost_set_ext_adv_params(struct bthost *bthost);
 void bthost_set_ext_adv_enable(struct bthost *bthost, uint8_t enable);
 void bthost_set_pa_params(struct bthost *bthost);
 void bthost_set_pa_enable(struct bthost *bthost, uint8_t enable);
+void bthost_create_big(struct bthost *bthost, uint8_t num_bis);
 bool bthost_search_ext_adv_addr(struct bthost *bthost, const uint8_t *addr);
 
 void bthost_set_scan_params(struct bthost *bthost, uint8_t scan_type,
-- 
2.35.1

