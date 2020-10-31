Return-Path: <SRS0=4lpm=EG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCF2C00A89
	for <linux-bluetooth@archiver.kernel.org>; Sat, 31 Oct 2020 00:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D7B0208B6
	for <linux-bluetooth@archiver.kernel.org>; Sat, 31 Oct 2020 00:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HQqR9mmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgJaAyQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Oct 2020 20:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJaAyQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Oct 2020 20:54:16 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C31C0613D5
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 17:54:15 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id r3so3822545plo.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 17:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QbH7X4Il4bbJD/ePRdn06r3YRB9WAND3qaqaTTHKOcY=;
        b=HQqR9mmNqsNRFBSi4bGHA7uMRsb8ob2gIBtiQLjTq58TtWLcAtoH8prhXrNPMDUx6e
         r27C9hG7X7iI756Se6a7BluQORygXASFgg30wKf335wlAja/otqcqJ0owzTIacMPOak9
         524G/Dv32ubsrnsJFpXf0P3yUiFBOfddbfPl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QbH7X4Il4bbJD/ePRdn06r3YRB9WAND3qaqaTTHKOcY=;
        b=Nmtkh03Ha6MK+7x3KrXImK0AeXmAvLKeK0xiXM+IR2CWx+a5efR8MIUD9n3KffVK/h
         9y571rt65Onqa/RIaK8LM1exaaiAf4t6vwActGV5YGzgl49ptY7YtAJyUkCifbLLVyPJ
         rSoG0tnLxtjCQDdlNkHnGb6TO3T4OqwPa320Paj2b4VvITGgCauTf9ZzDd9bJm6YZDuV
         A/chXesEDEzjTn+xWJ9mJ8nPuYKnaWY7wSB3+9sF4aYAOrL/V/oMsqtzbqBPOq44zffJ
         wAYcirp6SODcYaYHpAMQbV/NbvMUfGJBymHGeQ2ACKjIcGYdZCnZ89DNVo4wuQw1gJho
         h7ug==
X-Gm-Message-State: AOAM532pwIoH9SC1AgMSrwI6jFcUznoLoa10+kWYyciQZsNpWNS3xxki
        e6EuqJOKZtqpayozmOJcAw6Rb3GBZh1lTg==
X-Google-Smtp-Source: ABdhPJxhqTVpINamM24MD4iYxl9k7w59eczXXkSnRM9UmaO+0HstqlocccEI428xpUusROqMAKOq5w==
X-Received: by 2002:a17:90b:3501:: with SMTP id ls1mr5642978pjb.26.1604105654462;
        Fri, 30 Oct 2020 17:54:14 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id p22sm4394292pju.48.2020.10.30.17.54.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2020 17:54:13 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v8 3/6] adapter: Clear all Adv monitors upon bring-up
Date:   Fri, 30 Oct 2020 17:52:50 -0700
Message-Id: <20201030175219.BlueZ.v8.3.Id6bfe7838831ae01fddc8605689dd77b51673960@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201030175219.BlueZ.v8.1.Ie670925d87068d24a6e5c2e7dd9dd0e88c89a7da@changeid>
References: <20201030175219.BlueZ.v8.1.Ie670925d87068d24a6e5c2e7dd9dd0e88c89a7da@changeid>
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

