Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0987CC43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 07:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFA0021D7F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 07:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S2eLc/rv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgIQHGN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 03:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgIQHGE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 03:06:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FD6C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 00:06:04 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z18so644196pfg.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 00:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u+E1bUX0uVxPcQEsE71u1Ro0+1uBNDa00K7AzDVg6ww=;
        b=S2eLc/rvaepND8Icr0cBILxS+QGa1uFhTFmd65QO/R5XHGqAutzWOK/X0Gq1ePvGTH
         sGZxpejzUWulmO7S38fEzqEXU0IYhtJwN6YDVGjFwU2mACSS8kc3rP8g21AaRuoo70aG
         KW8MUeTXKsKnIdcQBUz4/rLga2cdAN1H+GW5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u+E1bUX0uVxPcQEsE71u1Ro0+1uBNDa00K7AzDVg6ww=;
        b=cWmxwTIDTNNtYpji80ylmlaeG/qzEBiSGwLCSdJ2QhytrB0qlzY/GFWpPhjnAzMHJ6
         3+YWXn8lTu2FKQeWwuhdEiIvK2HJMSZo+Mw5LEHYqzmIe4w0hA8HM+ioWl7JJTq2JDpB
         in4sJKxgr0uKtUaeO0dOgC4a0m56uCnNSAhz0E7eaKcpnmWI05r1lZUyYcp7TkJxrTrA
         tzZbGkpiMBQpPeZNmNBRp0pXqtsWA32vpwTB6HtiMDzz4EgCG2QaMIkoj7UFdmHmwJYu
         Z/x+fya7cCTyYF5U5PvWHQKInA5R3eGxTiaNCfiyf9wF2TlhOXECC2sQNaAlNJ3psYoe
         0Wvw==
X-Gm-Message-State: AOAM530/fzpOwv2peLMgrH3dZ0ykz8/M+66CGWNNesLjbxCXeLO2zuvp
        5ydsO/Wx5GRKABnVxO+9Wf7pZcIAL2962g==
X-Google-Smtp-Source: ABdhPJwxlR1tasWj8I4dTGhLmdFaC+kEF8dazPqIRuKiWZCfyfybzBHPNljq3cdI+ltW5Hocp7ZDZg==
X-Received: by 2002:a63:e802:: with SMTP id s2mr21569528pgh.350.1600326363295;
        Thu, 17 Sep 2020 00:06:03 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id y197sm5407372pfc.220.2020.09.17.00.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 00:06:02 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Howard Chung <howardchung@google.com>,
        Alain Michaud <alainm@chromium.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v3 5/8] adapter: Clear all Adv monitors upon bring-up
Date:   Thu, 17 Sep 2020 00:05:01 -0700
Message-Id: <20200917000448.BlueZ.v3.5.Id6bfe7838831ae01fddc8605689dd77b51673960@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200917000448.BlueZ.v3.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20200917000448.BlueZ.v3.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
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

