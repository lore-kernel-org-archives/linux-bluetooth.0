Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8A5C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 06:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F138C2075E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 06:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P5W329dN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgHUGdE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 02:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgHUGdD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 02:33:03 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E0BC061385
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 23:33:03 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id e4so399693pjd.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 23:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ewx2UKfu+NjCOZFtWd55EizWMyt5AaNSgj2mGWFAxI4=;
        b=P5W329dNu5cbLJG4u9IExeMAIgAscJGO/FXry9yEWLECslzaTUn9x72zmPKKDMCw+/
         nsdI12vx5RGlRHZmGov5sPfUv+DPJChX2IJf8u5A8E2BCl0shR5tBJ+eiKkNWmbTUWHF
         yvnOwi9Zxh0zN377UD61QRXyw//EjFZKzCK2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ewx2UKfu+NjCOZFtWd55EizWMyt5AaNSgj2mGWFAxI4=;
        b=gPzdEftoI75ukfWwJmXsWzycPRrz9j6THLVF9Xq7CQtdAdjLQ3c6yNU7jgjVZLavnQ
         u0TAxT1tavq2OkvVSlZMrcM8GXRM+EG128SsLXVp55JK3anVH7RiaqWX8q6stTLGrJBt
         kh+vQ5OnMC8ABrfdFSOlNNJ8qJ4T1z2vez1GOz/YqTmYfCA/I+e+CCS5cU1HBFU6F46S
         pu4nKWDlja5hrEJ0Zi7yLGMwr3gxrAM18+nNphIYPGayHz24zGYxCmYt3hrpgu2atFEb
         GJg2j/CmdQQ/s0thpQnYuXT20ZfcN0MdvHoaN9KS5mCs85FnN1ZfLz2ayR3etaidvYtt
         IhgA==
X-Gm-Message-State: AOAM530Ubew8U32fAS9vkYh5+9mUx7ZED6C2F+1yvvpk8XCBmUrwmYLd
        AykaFkOxPJaKmGTQ/Ty+cNzhGQQs8R6fOw==
X-Google-Smtp-Source: ABdhPJzsQbqTT7D0tmj2jzWfQGs/CxibK1qc4xSLLiSfNBVy/rFD7q0n+kFVXFDsEzJhx27Cdg6eEg==
X-Received: by 2002:a17:90b:110a:: with SMTP id gi10mr1256133pjb.206.1597991582967;
        Thu, 20 Aug 2020 23:33:02 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id t14sm1010315pgb.51.2020.08.20.23.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 23:33:02 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Miao-chen Chou <mcchou@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH BlueZ] adapter: Log the power state change of adapter to info level
Date:   Thu, 20 Aug 2020 23:32:59 -0700
Message-Id: <20200821063259.17020-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Miao-chen Chou <mcchou@chromium.org>

This changes the log level of messages in adapter_start() and
adapter_stop() in order to have better visibility on the power state of
adapter in bluetoothd log.

Tested that on Chrome OS this has helped debug many issues more easily.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>

---
 src/adapter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5e896a9f0..9ffe8e7e4 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5258,7 +5258,7 @@ static void adapter_start(struct btd_adapter *adapter)
 	g_dbus_emit_property_changed(dbus_conn, adapter->path,
 						ADAPTER_INTERFACE, "Powered");
 
-	DBG("adapter %s has been enabled", adapter->path);
+	info("adapter %s has been enabled", adapter->path);
 
 	trigger_passive_scanning(adapter);
 }
@@ -6884,7 +6884,7 @@ static void adapter_stop(struct btd_adapter *adapter)
 	g_dbus_emit_property_changed(dbus_conn, adapter->path,
 						ADAPTER_INTERFACE, "Powered");
 
-	DBG("adapter %s has been disabled", adapter->path);
+	info("adapter %s has been disabled", adapter->path);
 }
 
 int btd_register_adapter_driver(struct btd_adapter_driver *driver)
-- 
2.26.2

