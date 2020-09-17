Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58BDC43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 07:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 903232083B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 07:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fxpt9Lsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgIQHLe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 03:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgIQHLd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 03:11:33 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A3DC06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 00:11:33 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id y1so820108pgk.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 00:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u+E1bUX0uVxPcQEsE71u1Ro0+1uBNDa00K7AzDVg6ww=;
        b=Fxpt9Lsqqy/qt2V4rsBntDZKzXyPMUu4spQvy1eli92Q67cswoxdLOQkfJtNQRSpfi
         uN4taFBp2ufLpclzc7aYMFMYAZsEY7a1zBdBqmKwnCBxIUWtdJJLSeWBn3gF7vN5Er2M
         ZgVpZwwWj8NF7cyKym6vF+FVKwvvIXseH+c7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u+E1bUX0uVxPcQEsE71u1Ro0+1uBNDa00K7AzDVg6ww=;
        b=r4m1RlEDHECV0HuLf+0jg2A5euPEWhKDHwiOlXtmUoAEoY3cP1VOApFGBALN2BGKXl
         U2XAHW7JYes6J+iY7U4fLoU+LPNuX6M8UTtSLmYpXFHC8xK3NVjI4twU4QB55y6cPhDY
         sxR376PtWgJ22KfmI6PP6KC1+U5TUux0Qg89JfnrnLzV0viaVqzpHgyTlKEODI3OJFRI
         05szeY8vfYUFcyTqUBHQ9SwbhlxrseQMqP7BHIhsrmatTQibcZw+o87e3h8tnKffsYa1
         mDgRqSKZF3HdMmUilY6ICnQmCgyFyBj9+5kPSRtLIjaJQu0jE8nRm3e/ceSk9VUGGkpN
         fvVA==
X-Gm-Message-State: AOAM532lWKGQbXbbCcqT/+JXnGlF9mj/VkzmbKAU5OBpbmMPlOWn0tAD
        Lg95+7cL6nqchpSqDNbKDD2QT7pbjBrWrA==
X-Google-Smtp-Source: ABdhPJzuPzGZjOYnm97uN1eTAdJM1rMD/ScX0sop+qE7UogxWgvVbzn0UhZfVR4eTbAXi3D+6I0ikA==
X-Received: by 2002:a65:5282:: with SMTP id y2mr10948307pgp.132.1600326693066;
        Thu, 17 Sep 2020 00:11:33 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id j26sm933478pgl.91.2020.09.17.00.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 00:11:32 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Howard Chung <howardchung@google.com>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Manish Mandlik <mmandlik@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v4 5/8] adapter: Clear all Adv monitors upon bring-up
Date:   Thu, 17 Sep 2020 00:10:39 -0700
Message-Id: <20200917001020.BlueZ.v4.5.Id6bfe7838831ae01fddc8605689dd77b51673960@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200917001020.BlueZ.v4.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20200917001020.BlueZ.v4.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This clears all Adv monitors upon daemon bring-up by issuing
MGMT_OP_REMOVE_ADV_MONITOR command with monitor_handle 0.

The following test was performed:
- Add an Adv Monitor using btmgmt, restart bluetoothd and observe the
monitor got removed.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
Reviewed-by: Howard Chung <howardchung@google.com>
---

(no changes since v1)

 src/adapter.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index d33ce7124..191467048 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9513,6 +9513,43 @@ failed:
 	btd_adapter_unref(adapter);
 }
 
+static void reset_adv_monitors_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct mgmt_rp_remove_adv_monitor *rp = param;
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		error("Failed to reset Adv Monitors: %s (0x%02x)",
+			mgmt_errstr(status), status);
+		return;
+	}
+
+	if (length < sizeof(*rp)) {
+		error("Wrong size of remove Adv Monitor response for reset "
+			"all Adv Monitors");
+		return;
+	}
+
+	DBG("Removed all Adv Monitors");
+}
+
+static void reset_adv_monitors(uint16_t index)
+{
+	struct mgmt_cp_remove_adv_monitor cp;
+
+	DBG("sending remove Adv Monitor command with handle 0");
+
+	/* Handle 0 indicates to remove all */
+	cp.monitor_handle = 0;
+	if (mgmt_send(mgmt_master, MGMT_OP_REMOVE_ADV_MONITOR, index,
+			sizeof(cp), &cp, reset_adv_monitors_complete, NULL,
+			NULL) > 0) {
+		return;
+	}
+
+	error("Failed to reset Adv Monitors");
+}
+
 static void index_added(uint16_t index, uint16_t length, const void *param,
 							void *user_data)
 {
@@ -9527,6 +9564,8 @@ static void index_added(uint16_t index, uint16_t length, const void *param,
 		return;
 	}
 
+	reset_adv_monitors(index);
+
 	adapter = btd_adapter_new(index);
 	if (!adapter) {
 		btd_error(index,
-- 
2.26.2

