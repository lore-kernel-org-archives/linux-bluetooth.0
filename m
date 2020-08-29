Return-Path: <SRS0=jcZI=CH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29499C433E2
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Aug 2020 01:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7AA42098B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Aug 2020 01:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J//h6N7G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgH2BCZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Aug 2020 21:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgH2BCT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Aug 2020 21:02:19 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DF0C061264
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2020 18:02:19 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ls14so326398pjb.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2020 18:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3xXRDB2sGPzoGqKOB+6TwO7ShGY5615JtErKHfxz8fk=;
        b=J//h6N7GjrFtY2260Hs1jViiPMfa9CkX6rEyGHVXoAzr2/ByhHU4ruyy1eUbKUQVnZ
         pvV5LRMRoC4f9xx4Yw+M4g7zgVgtBPpqpbp80xgkHsUt37xeGn5xaiFcUzSOfqBoGn4F
         yiEZk6JnQJ5R2rn4J9yOUMV8M78plctwY+Er4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3xXRDB2sGPzoGqKOB+6TwO7ShGY5615JtErKHfxz8fk=;
        b=StYjNdr4/2g84FdX4crv7bnzHgkYLs2u89SCnIh7rPkqmjxXvnGAF3RntMDr9TL85t
         rSegutqpJFDJ6F0DIF18ZuxMWsAF886PQqpxLVqAKCiwk/SLTfItPtdAc2cPor/n9otP
         eBIpYHfJwKwj/+bXYFmN1fVQxM8YSZQBsUrNTqQ5uyruXruem+3KIe9NKvbMg8EM+YIH
         8jlloGG/pjNd2OfaDFNByJXP0Cmej324b6jE66lGTy81GstcntiUHhBcVG4ZGnKvpPYM
         JHea4k6lVqsFKc0MCWhClnbRG3C0djLCiSkO9akbP2A9o93GvisGccAANMYFDu293Mzv
         XRWg==
X-Gm-Message-State: AOAM530nv+7rMkJah9A87ZbCfAC0dAaWrndzc2IKLC9Ih3cFNbgeT1Ti
        bjmH22/8m4r2aBbkKsqdzmx9z8aelXL3sA==
X-Google-Smtp-Source: ABdhPJwNSjzZME0Uxua5lrWAjcNhkGmnvFct4vFvYBJV+jN0jDBnr6vTVdlN6ZSeGmiRa9BYkyexJg==
X-Received: by 2002:a17:902:d88c:: with SMTP id b12mr594759plz.96.1598662938763;
        Fri, 28 Aug 2020 18:02:18 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id 78sm630360pfv.200.2020.08.28.18.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 18:02:18 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [Bluez PATCH v3 1/3] mgmt: Add controller suspend and resume events
Date:   Fri, 28 Aug 2020 18:02:08 -0700
Message-Id: <20200828180157.Bluez.v3.1.I14a96397d181666c124e1c413b834428faf3db7a@changeid>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
In-Reply-To: <20200829010210.871471-1-abhishekpandit@chromium.org>
References: <20200829010210.871471-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add the controller suspend and resume events.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

Changes in v3: None
Changes in v2: None

 lib/mgmt.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index a800bcab4..46d894ae9 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -772,6 +772,7 @@ struct mgmt_ev_device_connected {
 #define MGMT_DEV_DISCONN_TIMEOUT	0x01
 #define MGMT_DEV_DISCONN_LOCAL_HOST	0x02
 #define MGMT_DEV_DISCONN_REMOTE		0x03
+#define MGMT_DEV_DISCONN_LOCAL_HOST_SUSPEND	0x05
 
 #define MGMT_EV_DEVICE_DISCONNECTED	0x000C
 struct mgmt_ev_device_disconnected {
@@ -959,6 +960,17 @@ struct mgmt_ev_adv_monitor_removed {
 	uint16_t monitor_handle;
 }  __packed;
 
+#define MGMT_EV_CONTROLLER_SUSPEND		0x002d
+struct mgmt_ev_controller_suspend {
+	uint8_t suspend_state;
+} __packed;
+
+#define MGMT_EV_CONTROLLER_RESUME		0x002e
+struct mgmt_ev_controller_resume {
+	struct mgmt_addr_info addr;
+	uint8_t wake_reason;
+} __packed;
+
 static const char *mgmt_op[] = {
 	"<0x0000>",
 	"Read Version",
@@ -1088,6 +1100,8 @@ static const char *mgmt_ev[] = {
 	"Device Flags Changed",
 	"Advertisement Monitor Added",			/* 0x002b */
 	"Advertisement Monitor Removed",
+	"Controller Suspend",
+	"Controller Resume",
 };
 
 static const char *mgmt_status[] = {
-- 
2.28.0.402.g5ffc5be6b7-goog

