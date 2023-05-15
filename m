Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DC3C7EE24
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 May 2023 21:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245421AbjEOVF7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 May 2023 17:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245358AbjEOVF6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 May 2023 17:05:58 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F320A49F9
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 May 2023 14:05:56 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aaec6f189cso90552305ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 May 2023 14:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684184756; x=1686776756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KjhUpj8uSuuQsuauzOhywl0XBpKd80yMyJQj1Ru8+Ns=;
        b=MMfbESzlWgG0kWeeSEWNWoWJ1hIW8etKdJYIbHiDhqCXcSTWv6P41AF7rbKvLZwJQn
         ES+dzELh9bZrZXmrsqe/iQ7SlxiuiscsPt7q/x2E4y/WeJmWGJ6QgmtLWcdMK7yCHDY6
         93heTdkctg8L7bvsyLpspn4znAXfxfRTnopTxgSfLDNkHHORpsEv7rtMI07gpkxVRBnw
         /Ve1YhmQWf3PCUEtrviYB7sjoaH13nCK3LSgHAYXfjvqBpl+QMDlZXMxqFPUgWbY4qa4
         kRS8J+iH+IeVRDrpZWtVwspMGrTg7fstrAbBU8pzIqP31LfWsYF8YjX44X7zwgrtV/oE
         e7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684184756; x=1686776756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjhUpj8uSuuQsuauzOhywl0XBpKd80yMyJQj1Ru8+Ns=;
        b=O4KTTD+DA4Ru9e5TFSWYpQJK0QngfFamGb2SLb9hq4ZeCKkMXPJdIt8Y5t2ycZhjOI
         CBmU4gtSJNmxvkof2776jj4l4xg9UwPmu/g7THNJS17CyJyYIuTYcLW7BCK8XdaL6/L0
         LmE6VLMVXpbFj7Cq4oNC5kzDSruttpefGjy5fU2YSBfPWwvdg2Dzm+RiRaD/aoN/DneF
         T66VanjOODb/0kOpiF+LeMfaLqXPDK3s4YCOWtUBPNSSaA05vMMVEM6laZbqj2HR4FmD
         51XeMk3kqMiHzPF3uKBm3L4Fu9JszL9847rhsOJSwENn9mOYcAHK2kOpvktL13KI7mx3
         yB/Q==
X-Gm-Message-State: AC+VfDxSUIDed/lHoyv1m9sUJWZfxzVyrzv9ddUIri9o+ScPRfCXBvv9
        2HaQA2TNosvbas++wAqbT0GWSCBdBC0=
X-Google-Smtp-Source: ACHHUZ7VB/Kvz/PghhrperSvj7ZYaa/TgShi5zYmNsgyDzXdLYbFyqytCvwfxjK5mf1UwLfOdaDUjQ==
X-Received: by 2002:a17:902:dace:b0:1ac:7e95:74be with SMTP id q14-20020a170902dace00b001ac7e9574bemr34628506plx.28.1684184755684;
        Mon, 15 May 2023 14:05:55 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id jb4-20020a170903258400b001a04ff0e2eesm13990050plb.58.2023.05.15.14.05.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 14:05:54 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/7] vcp: Mark driver as experimental
Date:   Mon, 15 May 2023 14:05:44 -0700
Message-Id: <20230515210545.718701-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515210545.718701-1-luiz.dentz@gmail.com>
References: <20230515210545.718701-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses the btd_profile.experimental to mark the driver as
experimental.
---
 profiles/audio/vcp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/profiles/audio/vcp.c b/profiles/audio/vcp.c
index b42b0a4f79dd..175275f2e977 100644
--- a/profiles/audio/vcp.c
+++ b/profiles/audio/vcp.c
@@ -289,18 +289,20 @@ static struct btd_profile vcp_profile = {
 
 	.adapter_probe = vcp_server_probe,
 	.adapter_remove = vcp_server_remove,
+
+	.experimental	= true,
 };
 
 static unsigned int vcp_id = 0;
 
 static int vcp_init(void)
 {
-	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
-		warn("D-Bus experimental not enabled");
-		return -ENOTSUP;
-	}
+	int err;
+
+	err = btd_profile_register(&vcp_profile);
+	if (err)
+		return err;
 
-	btd_profile_register(&vcp_profile);
 	vcp_id = bt_vcp_register(vcp_attached, vcp_detached, NULL);
 
 	return 0;
@@ -308,10 +310,8 @@ static int vcp_init(void)
 
 static void vcp_exit(void)
 {
-	if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) {
-		btd_profile_unregister(&vcp_profile);
-		bt_vcp_unregister(vcp_id);
-	}
+	btd_profile_unregister(&vcp_profile);
+	bt_vcp_unregister(vcp_id);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(vcp, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
-- 
2.40.1

