Return-Path: <SRS0=EW2K=B4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B504C433E3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 23:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDC2F2075E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 23:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PR0i5tUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHRX2d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Aug 2020 19:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgHRX2a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Aug 2020 19:28:30 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BE7C061342
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 16:28:30 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id k13so9917436plk.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 16:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XHUv3FRBN80hsAun3UWyOrIBRTs3yhxSRL5yxQg39V0=;
        b=PR0i5tUm4m6vaF7bl7oP3JlGmW3KVCZhOcp3TW49LecBgfPzPRpD/L+rMPmN4aHIyy
         GjIWsvfiT4pO1yKlLrD3uxtth3ZHIsKjrMOeyD3f9zy30iLWl3+89WYZ/3yly2pXVK3M
         hQFXaOcJQBOXNrctjtOCaKv+mPLdW1Kwq2wBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XHUv3FRBN80hsAun3UWyOrIBRTs3yhxSRL5yxQg39V0=;
        b=Qw0V4pcC8r2+UOAXBsHCYRejhjfzpOPTDgrratZo+lw4AP1Vjy9TNuYUlL3NOyqT++
         IzeUG3kyVKAQUHCPzbj6IFcU/hEGwOBsZYIXUs7nfu+riheAG7+2pmCd820ekx8yo03I
         V6m4ZZYV/L+R/Ka4eLye+muY3DiAEBZVU0GGjXvyelqnxzHQcin+cetFt6rrT4VCbtyh
         naeFMJbYO/MeEBxRCUKlgA4nKDjJrr2hW6suV9xQhjpIQzai09tZmNr2q1rbzxHdVd44
         ROG+Hj2ZQTHDCKJeHnTUOvPWpFztHhwaccYQeuvDFcIqo+WIMdj3IDqJMt0oYx9/cEl5
         v7RA==
X-Gm-Message-State: AOAM531b+or0hSKN/ayV6N5ioYMcYeD81h7o0EWM+//2VZL5e4kSL5re
        cnq4+HpKxtwA072xUIOlOhCs0A==
X-Google-Smtp-Source: ABdhPJxp/5FV4L2Y0CvUQVJQLq4JQoC3tZuYfhsfOTC5//EQp5SjlkqmGenIZR/Yu9OMYuE45vdTqg==
X-Received: by 2002:a17:90b:1b43:: with SMTP id nv3mr1814429pjb.22.1597793309551;
        Tue, 18 Aug 2020 16:28:29 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id 30sm904747pjz.24.2020.08.18.16.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 16:28:28 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [Bluez PATCH v2 1/3] mgmt: Add controller suspend and resume events
Date:   Tue, 18 Aug 2020 16:28:20 -0700
Message-Id: <20200818162807.Bluez.v2.1.I14a96397d181666c124e1c413b834428faf3db7a@changeid>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200818232822.1645054-1-abhishekpandit@chromium.org>
References: <20200818232822.1645054-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add the controller suspend and resume events.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

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
2.28.0.297.g1956fa8f8d-goog

