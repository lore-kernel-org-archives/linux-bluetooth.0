Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC86BC77B7F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 May 2023 20:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjEPU7s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 May 2023 16:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjEPU7q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 May 2023 16:59:46 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3865B87
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 13:59:40 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ae3fe67980so1280285ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 13:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684270779; x=1686862779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OgDPveaF1MKTU1yCjzGD+PxL+UXDSV/Fo3bJbJP/EvU=;
        b=BxzhYOo8B2GEXcd6aH9MTpDZDG+sYBrZMJe/EhApcSFEQ8eyfj1YuSwj/ncB5xzwJX
         ENz/hsu33BZnsYry+WbCKYkYyr4gHpIeFRM3wFEHziafuRb8BG7BZAer1XHCvRhXv9it
         Bz5UM5/MgnBHQekBvVcMpajzSlDB6NiEKhxa3GItXhJ5I+kWoDO0f324oE9jZP9Owmcz
         iKqdsnmNf1vAfJeX6Ex3Y/zJm/ZFF78SuUzjpDOlOzVdz914Hdfkgfh2y+rF/XcM/7NP
         PIAfwCBM8fUU0O53OmteErVW17Kaj7AQs3KETyEfMemI+ypwj5XpFmERv5ilNdnUymT+
         8yrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684270779; x=1686862779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgDPveaF1MKTU1yCjzGD+PxL+UXDSV/Fo3bJbJP/EvU=;
        b=Erg0AmwQypIl2WtOCoAGuTwcB6jodk5pFqob6khDopw/BJrfU613jDrpuEVKMfwygq
         4zBYoSwwC1ETCjfgiJiw06VngaxK0RI/1jDpP5zW7k33YCY8L41aifxOPPqo0ikxgyrU
         sSST2pURRuhflafq3W6izFWWvr5ZwVowAsPaWDyOeRNw43Qo/tMq71OchR6JKmKTNmxc
         yh9szXlO+MbapAMHTWhgcl6/DSJO9x2fdJN3au6hTNeDO6IzFLKn05qh+RGDvEojYCJ8
         dYinZIRaSdJL+FQjYLQLm++hmNOjh2TWYVOrSsrTScYTN9Utcqb5op7v+nUMaCkYbnx9
         R2dw==
X-Gm-Message-State: AC+VfDw7Ovpf0YPnpTNQ9qn0IA2/6Wx3acJ8TGxSQvNsVhJrm7+4VUvp
        Qg1bjELHSY3MkiTm45ko+iJPI1+7XQo=
X-Google-Smtp-Source: ACHHUZ5AOEeTZKZxRCBEw2EidpkC3Vw1tp2b0aCG2PU+lyd85NpHRP9SB3JEoCmg5PT3I/Z5CZA12g==
X-Received: by 2002:a17:902:d4cf:b0:1ac:6b92:70c8 with SMTP id o15-20020a170902d4cf00b001ac6b9270c8mr47747774plg.48.1684270779415;
        Tue, 16 May 2023 13:59:39 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id t16-20020a1709028c9000b001acad024c8asm14272237plo.40.2023.05.16.13.59.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:59:38 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 08/10] adapter: Add support for experimental flag
Date:   Tue, 16 May 2023 13:59:22 -0700
Message-Id: <20230516205924.1040506-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516205924.1040506-1-luiz.dentz@gmail.com>
References: <20230516205924.1040506-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds experimental field to btd_adapter_driver so the plugin can
indicate drivers that depends on experimental to be enabled.
---
 src/adapter.c | 6 ++++++
 src/adapter.h | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index cc7f891d96d9..74ed52468b81 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7447,6 +7447,12 @@ static void adapter_stop(struct btd_adapter *adapter)
 
 int btd_register_adapter_driver(struct btd_adapter_driver *driver)
 {
+	if (driver->experimental && !(g_dbus_get_flags() &
+					G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
+		DBG("D-Bus experimental not enabled");
+		return -ENOTSUP;
+	}
+
 	adapter_drivers = g_slist_append(adapter_drivers, driver);
 
 	if (driver->probe == NULL)
diff --git a/src/adapter.h b/src/adapter.h
index a45ac1bab00e..32e49a933b13 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -127,6 +127,11 @@ struct btd_adapter_driver {
 						struct btd_device *device);
 	void (*device_resolved)(struct btd_adapter *adapter,
 						struct btd_device *device);
+
+	/* Indicates the driver is experimental and shall only be registered
+	 * when experimental has been enabled (see: main.conf:Experimental).
+	 */
+	bool experimental;
 };
 
 void device_resolved_drivers(struct btd_adapter *adapter,
-- 
2.40.1

