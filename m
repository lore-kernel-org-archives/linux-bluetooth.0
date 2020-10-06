Return-Path: <SRS0=Tswr=DN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52FCC4363A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 00:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B4D6207F7
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 00:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OUKofAHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgJFAtd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Oct 2020 20:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgJFAta (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Oct 2020 20:49:30 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44397C0613CE
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2020 17:49:29 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ds1so707747pjb.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2020 17:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lk7bODG5y3+0RhDUq3vlG8yhUFCiComhhZ2Ud4bQAQI=;
        b=OUKofAHbbSw6dLWFuK8VdvJJY+9q61lFzLKVoNToKFiVxol+gSh4Tk/68IkegyScoI
         MdCtg4ALhzgFrEYErVdjrnCF8g7kcrEuTs7LMszZu6t8wyQc+GrxUFlLdPp2sTeNbuTZ
         g0plEpZweTjK00IahMwg8N79zH3N1DZq5tHWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lk7bODG5y3+0RhDUq3vlG8yhUFCiComhhZ2Ud4bQAQI=;
        b=A1m3ldJoxWMhecaVbc9PXPuxSfxXXp4gGcGer4pgjGmF3G2CkdLjaX9+9wTLuPXfyE
         s3g3RBUpEMYDiMkNe2VkbdjR/iq4GfUg9zPFnJIcOpv41+nMfFjNc8q5Cqxb5yDckDdk
         rO0wF2UkH5w7AyUKAeqJ/qxdJMUogGYNHmY7uBDPP4RjTvqvywCJ8mC9AcXIAsGrpBeK
         6JFiIU4qu/mCYMAvec7JyDYxVatNe7AUhBMF876rNLdHOefCcyoQk6GO1z0DEOPyeW8a
         wiEYRJWXtF1qm1tTfzYxExPHVtf1DKXKhyANWW1y/P0KE1P/eYJ/oLtcEPR9cwFJnbD2
         vRjQ==
X-Gm-Message-State: AOAM530Rn5/04WwkI/HYph/8R52hckItAywZz0kUT96vkFuyiJUtzPXC
        SRZB2yX+0oJDEXu+r6M6IfJnBl54GgAhHQ==
X-Google-Smtp-Source: ABdhPJyCFFggrsJWuFmmKSH8Pq+vUkRtutTORNK4Rm24rq1DiE0C8G1edz85FbxjRMYsLeDe/fNShw==
X-Received: by 2002:a17:90a:ba06:: with SMTP id s6mr2015401pjr.13.1601945368541;
        Mon, 05 Oct 2020 17:49:28 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id h2sm776947pjv.4.2020.10.05.17.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2020 17:49:27 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Manish Mandlik <mmandlik@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v5 3/6] adapter: Clear all Adv monitors upon bring-up
Date:   Mon,  5 Oct 2020 17:48:04 -0700
Message-Id: <20201005174640.BlueZ.v5.3.Id6bfe7838831ae01fddc8605689dd77b51673960@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005174640.BlueZ.v5.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20201005174640.BlueZ.v5.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
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

