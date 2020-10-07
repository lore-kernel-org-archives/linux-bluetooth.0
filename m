Return-Path: <SRS0=7SIp=DO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC35C4363D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 00:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1FBB20760
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 00:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bC1idlII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgJGAO7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Oct 2020 20:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgJGAO7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Oct 2020 20:14:59 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287D1C061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2020 17:14:59 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t18so111792plo.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2020 17:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lk7bODG5y3+0RhDUq3vlG8yhUFCiComhhZ2Ud4bQAQI=;
        b=bC1idlII33sRimWk3Rlp4cEAG6gOV5s5Ig3+fvpnNivEpwGhSNqCxL2KiNMS6rTXjL
         siLZPQ6lxRB41eB9gyTPVSoh6IqZLeYGtY4oUkytQAdMwOEQPINEMoaGqs6cm9klddV/
         0h94y0bFQX/+dd8iVt2ILCFfZrWKpEdwFQf2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lk7bODG5y3+0RhDUq3vlG8yhUFCiComhhZ2Ud4bQAQI=;
        b=CLXUKkeYiwcW+tjWtKkgRAqedSc5smLH6+X8wEdM69Idwh0XkVLzug3XUqX+GGM7En
         qpaUoeMSD1X+LQSu1YmdL6x34cuMnCDvIVuYERFWCdhbckiQoE2CKnh+r+121N3esiKK
         n0Xb6ld+Um1TEu+exyevRZnq6uj4S8CpxvrumOqdfDfVHxtm+U1f2FV49N3EU7v+xu67
         4fdPCh3Kc/JMAdFEutIS9KQxqRadP9UkFAXaTCX3wITO5OqMmNgIfFUDsgPg25LZUwti
         9B3L3TMW+Jysf9IjIjhcp8aLEKl33135E5oCSXx7hOZ1uBgLMtRq+viL6+5kIEZeOj6Z
         kNHw==
X-Gm-Message-State: AOAM532+/NQASm09hLChMBJ3Gs7mJkJr6HCBgRVsl8zPf27geQJnFoB+
        opd9hR2idY9bWBZttwWN0zW+3Lvdv3Sy+w==
X-Google-Smtp-Source: ABdhPJygF3p325EAps7rlMtRt1SycaSS2JzoQfnkQjS2qhDzUpNqXvTrNRQSXjfYVWR0zXh5AO3A3Q==
X-Received: by 2002:a17:90b:3103:: with SMTP id gc3mr558382pjb.158.1602029698449;
        Tue, 06 Oct 2020 17:14:58 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id s13sm329722pgo.56.2020.10.06.17.14.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2020 17:14:57 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v6 3/6] adapter: Clear all Adv monitors upon bring-up
Date:   Tue,  6 Oct 2020 17:14:10 -0700
Message-Id: <20201006171333.BlueZ.v6.3.Id6bfe7838831ae01fddc8605689dd77b51673960@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006171333.BlueZ.v6.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20201006171333.BlueZ.v6.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
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
index fdd9b3808..c7179fc2e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9500,6 +9500,43 @@ failed:
 	btd_adapter_unref(adapter);
 }
 
+static void reset_adv_monitors_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_rp_remove_adv_monitor *rp = param;
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
@@ -9514,6 +9551,8 @@ static void index_added(uint16_t index, uint16_t length, const void *param,
 		return;
 	}
 
+	reset_adv_monitors(index);
+
 	adapter = btd_adapter_new(index);
 	if (!adapter) {
 		btd_error(index,
-- 
2.26.2

