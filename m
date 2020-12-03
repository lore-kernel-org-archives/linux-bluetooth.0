Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137F9C83014
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 10:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFDA021D1A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 10:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388807AbgLCKbH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Dec 2020 05:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388801AbgLCKbG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Dec 2020 05:31:06 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20E7C061A55
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Dec 2020 02:29:50 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id bd1so912122plb.22
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Dec 2020 02:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=LgFUufeP/6GJIT+/FBOIVfpSa89RyGRkt3hInsL6vv8=;
        b=eq/xwaUjQ+yC41iYj9sWUZ1k+KkznoXg2gfXaN99+GUdDMSNHSwtAq3yhyapLGx7xT
         FYAkzvUmLS3uyff8mQCmRlNDddihzyYvy8UcD+FIfDjda09gubm7I6euR09pOtN+ZEEh
         gZ/KqZD25eu81rhmAyEw9NBJPbISqpU6qNxHVTK3N/DTnG1OssSzevwhT4KV3fjMVbIw
         nTrjEPoBoZurKWT+S7jxmdcifv62CkLSzWL2T2Z6JBqT6YKi8xJcE4UotJsquVLx1fBx
         pxGbe57TgtTR5XBgtsbsosbNmM50UXn9sG8WuA2rnBrc4M+YRxSiePVmlQK/FZlQR1e5
         uL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LgFUufeP/6GJIT+/FBOIVfpSa89RyGRkt3hInsL6vv8=;
        b=hCAErPn2XRIaVJQpzFrqctdIeboMAav23rsJ7EcpRUKoRdiPQXVGdmpdKV9zVUME2f
         9h/phta2lpRttwDv+JzT/HbuCKpXBzdS2I36vtQdsrug2gJ3XPKt0ocgjm+MA29EkrBf
         FqCH+wDRVoK1LEyX51Kdf5f+U86KtAv5xXS+eBv1pNRzImzmjgAaVd3VeSq0o4iEcB7e
         RIi4k4n79TnPGJnaaMvpsusy5tr0e5GSSx62PtJCTJSkTDoiOZx3l/RfLR4D4htqRkEI
         EgDgg+goYrvqfkp/c/0d+d/C2cUNQ/FIy9J56xTi5sZoE3hiG6+GZ3XzywhzuxzbYNrK
         IKMw==
X-Gm-Message-State: AOAM533dKikUTJi6ulrqdi2GNq4Kyti7SInDKhyHSNTsaPohWaz+zITL
        izNYdFRuPOJtdcqoCPU68FWDqkZhtkpLBqtliXFV77Uhomy3NCjtD8jPxO+pFW8nZgiAmonm3UQ
        ex/ClcF1+uyC8K1bdJGRjRs6j+M5+K1KEPEORS1KQWnxlSlU6qwix5rsXepMNHZzvewtGbPGSeK
        9D
X-Google-Smtp-Source: ABdhPJz1kh8OY2kfEa5qWxyAYd5fj4rgXnXnpj1E6hxkmaWSDTZKCbEpyoyG2efc/XOhnBO2b+XkFj0MmFtC
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a17:90b:4b07:: with SMTP id
 lx7mr2511105pjb.230.1606991390116; Thu, 03 Dec 2020 02:29:50 -0800 (PST)
Date:   Thu,  3 Dec 2020 18:29:31 +0800
In-Reply-To: <20201203102936.4049556-1-apusaka@google.com>
Message-Id: <20201203182903.v1.1.I92d2e2a87419730d60136680cbe27636baf94b15@changeid>
Mime-Version: 1.0
References: <20201203102936.4049556-1-apusaka@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v1 1/5] Bluetooth: advmon offload MSFT add rssi support
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Yun-Hao Chung <howardchung@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

MSFT needs rssi parameter for monitoring advertisement packet,
therefore we should supply them from mgmt.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Yun-Hao Chung <howardchung@google.com>

---

 include/net/bluetooth/hci_core.h | 9 +++++++++
 include/net/bluetooth/mgmt.h     | 9 +++++++++
 net/bluetooth/mgmt.c             | 8 ++++++++
 3 files changed, 26 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9873e1c8cd16..42d446417817 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -246,8 +246,17 @@ struct adv_pattern {
 	__u8 value[HCI_MAX_AD_LENGTH];
 };
 
+struct adv_rssi_thresholds {
+	__s8 low_threshold;
+	__s8 high_threshold;
+	__u16 low_threshold_timeout;
+	__u16 high_threshold_timeout;
+	__u8 sampling_period;
+};
+
 struct adv_monitor {
 	struct list_head patterns;
+	struct adv_rssi_thresholds rssi;
 	bool		active;
 	__u16		handle;
 };
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index d8367850e8cd..dc534837be0e 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -763,9 +763,18 @@ struct mgmt_adv_pattern {
 	__u8 value[31];
 } __packed;
 
+struct mgmt_adv_rssi_thresholds {
+	__s8 high_threshold;
+	__le16 high_threshold_timeout;
+	__s8 low_threshold;
+	__le16 low_threshold_timeout;
+	__u8 sampling_period;
+} __packed;
+
 #define MGMT_OP_ADD_ADV_PATTERNS_MONITOR	0x0052
 struct mgmt_cp_add_adv_patterns_monitor {
 	__u8 pattern_count;
+	struct mgmt_adv_rssi_thresholds rssi;
 	struct mgmt_adv_pattern patterns[];
 } __packed;
 #define MGMT_ADD_ADV_PATTERNS_MONITOR_SIZE	1
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3dfed4efa078..5f0f03dcd81d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4237,6 +4237,14 @@ static int add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
 	INIT_LIST_HEAD(&m->patterns);
 	m->active = false;
 
+	m->rssi.low_threshold = cp->rssi.low_threshold;
+	m->rssi.low_threshold_timeout =
+	    __le16_to_cpu(cp->rssi.low_threshold_timeout);
+	m->rssi.high_threshold = cp->rssi.high_threshold;
+	m->rssi.high_threshold_timeout =
+	    __le16_to_cpu(cp->rssi.high_threshold_timeout);
+	m->rssi.sampling_period = cp->rssi.sampling_period;
+
 	for (i = 0; i < cp->pattern_count; i++) {
 		if (++mp_cnt > HCI_MAX_ADV_MONITOR_NUM_PATTERNS) {
 			err = mgmt_cmd_status(sk, hdev->id,
-- 
2.29.2.454.gaff20da3a2-goog

