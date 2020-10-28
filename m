Return-Path: <SRS0=FSAH=ED=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36895C388F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 23:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF5420782
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 23:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Spul2Edr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732874AbgJ1XHF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731936AbgJ1XHE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 19:07:04 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352DCC0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 16:07:04 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x13so704599pfa.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 16:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QbH7X4Il4bbJD/ePRdn06r3YRB9WAND3qaqaTTHKOcY=;
        b=Spul2EdrnzrkQ99FOImUj/VotoETT3pO4KhmBBdqplq98G01qTUx/SsqhAfGHbmHGX
         b523wzVMycy5RwDD/vEer2gvml1pBnLeDRBff6yN+I4d/LSwgjRRg7JfAc4DKhOSxOC3
         fYSFioGW1x+CIsCnkQoFaqQx6GklEoq7EjkHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QbH7X4Il4bbJD/ePRdn06r3YRB9WAND3qaqaTTHKOcY=;
        b=SoaF5+h0Wkd7IUupnwojjhhJJE96RlmW10kiUj2AXy2XUc6A+O3cbSJzRo08CxlGEY
         MWlc4Ariz0IOZPhCDKYzKv23jBUWaxH8oJMvOXnHWo0VmPQ3fA0B5BT/cVKEhHhN2IEw
         K5GUOQkv9PaqVn38ZRZxq5xFqtF8eyochhW12dpzgzKUL83kPkXt4+Uc3FOSDxlYQRkA
         fMzJiwEskVcTZY9aPw9Zea42cSM3szLojJE09jzyPGlh2+3M7lfhkSIOBYjRrtsnuVe4
         r1uPdUISeoRHBEHUPYdjtuvVwX7fMondW5dfx650xVxAZCk3ur4R5hqY/pMnt07Sfo3j
         wSSw==
X-Gm-Message-State: AOAM532nEL4nI9G5k7HxUlRqOZ/9tFDr4pVjfKaqSNbLeDnGc3obcPyP
        O2Dh7DCODEboadXFwVjQE2wb1JxMdifSyA==
X-Google-Smtp-Source: ABdhPJznDENZRS5mi6HD3NHNXJn+7gwgJCH5qOUDolQCZj+srRYvMlkmo7Soivl6EEd0l1ObyBRbAQ==
X-Received: by 2002:a17:90a:5995:: with SMTP id l21mr1135614pji.5.1603926423304;
        Wed, 28 Oct 2020 16:07:03 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id y137sm644134pfc.77.2020.10.28.16.07.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2020 16:07:02 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v7 4/7] adapter: Clear all Adv monitors upon bring-up
Date:   Wed, 28 Oct 2020 16:05:32 -0700
Message-Id: <20201028160433.BlueZ.v7.4.Id6bfe7838831ae01fddc8605689dd77b51673960@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201028160433.BlueZ.v7.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20201028160433.BlueZ.v7.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
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
index 0e3fd57f3..0f855d848 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9509,6 +9509,43 @@ failed:
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
@@ -9523,6 +9560,8 @@ static void index_added(uint16_t index, uint16_t length, const void *param,
 		return;
 	}
 
+	reset_adv_monitors(index);
+
 	adapter = btd_adapter_new(index);
 	if (!adapter) {
 		btd_error(index,
-- 
2.26.2

