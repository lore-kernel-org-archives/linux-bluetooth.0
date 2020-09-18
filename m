Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B566C43463
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 03:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C59521582
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 03:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="UEW/Lh9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbgIRDMq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 23:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbgIRDMk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 23:12:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0794EC061788
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 20:12:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 140so2820483ybf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 20:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=64ZOoFGaOH0m/cPAtUtUGXYMPXoup8s7otAhkDt2H3M=;
        b=UEW/Lh9lpl7cJQgrlAzxT3Ymbi9kik5IAj7EVI1GY2T6uE0YvsPwYWJedj5Yjddxb2
         Nf9za12XPUpgMNJbYMg3nxYfm7tIUa4E4ybFE5NmmN662fd1cbc8aIWNfJTGDeVCo9Wq
         1WJwF/8g5Ie4JkrEp9yIEza/HU17XBEhrMrcZRi+O9Jy9X/8DLPtjMbgX1ooTVXaYZ9G
         9BkQbDFFUO3xE+c8n671VgQ1E2yeVtyvKvMHC2aqjootukqzQUqvzZd7GwT9bLVII80l
         GbNwo30YIeEqvnUnUiLC8wEkHkGFP8RAbeLu0YLLKHJRU6RYHFMxIIgwCRY3z2vSxCxk
         iZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=64ZOoFGaOH0m/cPAtUtUGXYMPXoup8s7otAhkDt2H3M=;
        b=CTQOMuOXQwPTPEDfprVN3ynKOJGXyQv0omWUBWsDEBToFZJlFc1lshuuMTeO2wMcI1
         obnI6+Z6VBZwgn9E9qRJOeloUBYnS3va1/eptWo52VoL+B6MhSVB3sQ0xPbktyhdLavG
         fPTxLIXuWjiga5sMD1KuRbNYunJjYyg4o+wCFwYSuPAjTpSHa4y7EZGBQu9vbYxEzEsN
         qvOJH/sGVZ+uiLQZFqhiw7/OnU7jXpfy4Xhm+vgZhuCNnVbuVnLXVJUqfVkQQuT4q9j4
         joGCoukp78ATUI/QJmukZVjYbZCgJ/B5NNQNeNWiQwEVDdgfY9D3/G1BOJ2i4mJi4oOG
         EZ/Q==
X-Gm-Message-State: AOAM530hSVTRAzEQbkGeLxYGvJAgVWwJ1w4gopH6kM8M8RX36mMe8ac9
        OILhFQ+CAkARZ4rVU1noqOabfeJ66YF4XAwX9Gw0sUiufxcjxRN4Q2lPTdQstNWqpr2hFTL7Yrn
        wUncylwn7tDUSTStlDtK8m0WyPme7ivRtld/vCrXquXqj5ZyYWAXlmGCob2UtQpEf9v71rHSc7l
        h87bwYrXOM/fE=
X-Google-Smtp-Source: ABdhPJxxoVj4sVwb3Pqb1zFKEUNanXR2/70HGloVVRNpSIBlL1Bw+Xd+ataxUCDEF5kqhDcJIjajKb/vuIQfOrUh9A==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:d408:: with SMTP id
 m8mr41594928ybf.204.1600398759153; Thu, 17 Sep 2020 20:12:39 -0700 (PDT)
Date:   Fri, 18 Sep 2020 11:11:53 +0800
In-Reply-To: <20200918111110.v3.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
Message-Id: <20200918111110.v3.6.I756c1fecc03bcc0cd94400b4992cd7e743f4b3e2@changeid>
Mime-Version: 1.0
References: <20200918111110.v3.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 6/6] Bluetooth: Add toggle to switch off interleave scan
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     howardchung@google.com, luiz.dentz@gmail.com, marcel@holtmann.org,
        mcchou@chromium.org, mmandlik@chromium.org, alainm@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch add a configurable parameter to switch off the interleave
scan feature.

Signed-off-by: Howard Chung <howardchung@google.com>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

(no changes since v1)

 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/hci_core.c         | 1 +
 net/bluetooth/hci_request.c      | 3 ++-
 net/bluetooth/mgmt_config.c      | 6 ++++++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 179350f869fdb..c3253f1cac0c2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -363,6 +363,7 @@ struct hci_dev {
 	__u32		clock;
 	__u16		advmon_allowlist_duration;
 	__u16		advmon_no_filter_duration;
+	__u16		enable_advmon_interleave_scan;
 
 	__u16		devid_source;
 	__u16		devid_vendor;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6c8850149265a..4608715860cce 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3595,6 +3595,7 @@ struct hci_dev *hci_alloc_dev(void)
 	/* The default values will be chosen in the future */
 	hdev->advmon_allowlist_duration = 300;
 	hdev->advmon_no_filter_duration = 500;
+	hdev->enable_advmon_interleave_scan = 0x0001;	/* Default to enable */
 
 	hdev->sniff_max_interval = 800;
 	hdev->sniff_min_interval = 80;
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 1fcf6736811e4..bb38e1dead68f 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -500,7 +500,8 @@ static void __hci_update_background_scan(struct hci_request *req)
 		if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
 			hci_req_add_le_scan_disable(req, false);
 
-		if (!update_adv_monitor_scan_state(hdev)) {
+		if (!hdev->enable_advmon_interleave_scan ||
+		    !update_adv_monitor_scan_state(hdev)) {
 			hci_req_add_le_passive_scan(req);
 			bt_dev_dbg(hdev, "%s starting background scanning",
 				   hdev->name);
diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index 1802f7023158c..b4198c33a1b72 100644
--- a/net/bluetooth/mgmt_config.c
+++ b/net/bluetooth/mgmt_config.c
@@ -69,6 +69,7 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 						def_le_autoconnect_timeout),
 		HDEV_PARAM_U16(0x001d, advmon_allowlist_duration),
 		HDEV_PARAM_U16(0x001e, advmon_no_filter_duration),
+		HDEV_PARAM_U16(0x001f, enable_advmon_interleave_scan),
 	};
 	struct mgmt_rp_read_def_system_config *rp = (void *)params;
 
@@ -142,6 +143,7 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		case 0x001b:
 		case 0x001d:
 		case 0x001e:
+		case 0x001f:
 			if (len != sizeof(u16)) {
 				bt_dev_warn(hdev, "invalid length %d, exp %zu for type %d",
 					    len, sizeof(u16), type);
@@ -263,6 +265,10 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 			hdev->advmon_no_filter_duration =
 							TLV_GET_LE16(buffer);
 			break;
+		case 0x0001f:
+			hdev->enable_advmon_interleave_scan =
+							TLV_GET_LE16(buffer);
+			break;
 		default:
 			bt_dev_warn(hdev, "unsupported parameter %u", type);
 			break;
-- 
2.28.0.681.g6f77f65b4e-goog

