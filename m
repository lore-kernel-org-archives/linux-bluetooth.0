Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED07BC43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 04:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6A122075E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 04:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C3KJbgay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgIQEbR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 00:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgIQEbN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 00:31:13 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C16BC06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 21:31:13 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gf14so561288pjb.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 21:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tEXRaSOfGPBWZAounuJS1sb2LnFVUvkMbj2zMShq8aQ=;
        b=C3KJbgay55aBCx9y+3YFTpfwOBcZM90pYido0meEPcUkWBvktvZLOPVYFLkBDdDgHy
         hOFAT6dASZNLlompkLyQVJjO2nxjV5z50Wwy+AOASbOAXag3RF+oUaoKZ6/6LOY/22ev
         8hZZunh6g1gd7ARH65wQUItmC6DENvrO3wLXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tEXRaSOfGPBWZAounuJS1sb2LnFVUvkMbj2zMShq8aQ=;
        b=Ni3YDo+wX+RZx+h8IClElxdk3vDJz0vv2rhm30gkiYaESqxvMig6jCF5YK4mhG2vwV
         dVKRiGl7F+23HHipwhgHKJPA3JwXjZ9VqZ3SqeAfjun9WkAogmmAr+1BF0ByWjOy4Lh/
         3/suecFt9XoHioBfG1G5Zg8nk0X5vDi1pmP9CqHrGQ6lZbZSdj0e+ktxsXoxm3N2F3x/
         bngHoSGh4VkDTd+ykbuXIhfxOfWWbQbpmlxgr1CTar3zo41EC7lBSLXlrAI3zi9jmbvj
         q8UU/pkEAtJsD+3YT7XyqXQnFgupj4uOq4jM3Z4ObxDnyQkN/97dbhuE2nXombRgo4UZ
         zT2w==
X-Gm-Message-State: AOAM531SdnkD6IdtyyGBAn+nFfsZ2xbpyLFaXIMjSJsA0SFHqIIFBM7b
        G+jJhLGVpuJSNMzsLePu5xUtOHTLap7o5A==
X-Google-Smtp-Source: ABdhPJzRwolEkmo3mUzGJuEW6NcFnszrrID0p1meEpm/7hR4+ZqSfgIvJDP0/nfFksTMU/dqBuxYVg==
X-Received: by 2002:a17:90a:f187:: with SMTP id bv7mr6182491pjb.63.1600317071864;
        Wed, 16 Sep 2020 21:31:11 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id 99sm4169562pjo.40.2020.09.16.21.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 21:31:11 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        Manish Mandlik <mmandlik@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v1 5/8] adapter: Clear all Adv monitors upon bring-up
Date:   Wed, 16 Sep 2020 21:29:53 -0700
Message-Id: <20200916212926.BlueZ.v1.5.Id6bfe7838831ae01fddc8605689dd77b51673960@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200916212926.BlueZ.v1.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20200916212926.BlueZ.v1.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
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

