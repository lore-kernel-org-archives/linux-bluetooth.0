Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF9EC35257
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 05:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A4A92137B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 05:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="fLZlyxtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgIQFaL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 01:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgIQFaI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 01:30:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A92EC061788
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 22:30:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b3so1128028ybg.23
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 22:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ygbRGR9MwQmhVfnOPf7/bfPQRgvGhgJ28URwKmtcTXY=;
        b=fLZlyxtD0aKEcvA+dEYTYrEvrvvko2Dbwk39ayqkCi3IVgAoZ2lGWWQLlSkz7NCtZt
         Gxl17cg91T1SEeE3eFkQV3YfMYi8ACcRKW88i3MTs9ZuNBQKPqTdObZFhMS6W9Tuk6p6
         7xMhwuzMtJVrv3CO9DQd6HDlt5sgfnhnvscmuQNxGaKEalmzEEsdgdd/cX/T1xX7I4Rr
         3YasPxPPbNlw0Oobkc8Kri8QCyDtLTy9CuzVqtCohi6J80rDk0ogYK2tksgssNzH7wAi
         9XDM/HFhN9tsgOJx0BRamQltRGpK/lnP8/fh+PCBNktQCogE54XodNeAruDxBpKOMNcv
         si3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ygbRGR9MwQmhVfnOPf7/bfPQRgvGhgJ28URwKmtcTXY=;
        b=UNJHywyPOEvXBmMlYfuB5e7vcue2XeegxegZu/GjtPrgg18S3MtEjQCF4RbG9Yli3u
         YFoYUJ+OdCGeEaTSw46YYgApF+7chOrOKiR803foZjiaoThqMye96wrLlQi5YQOEIYu+
         oiP0UaQcIsU0zbJw9ncspOMm1fM+9Iwp37zlJpCF8P0gjbWTvckVqHZsYvoCNivHOpu2
         CBCrS9jVmJfaJ3ok3XqpaeIP0x/5FoEOySl+oHakZ5eXnEyjtZBf8J5QPXz4GW8V+sdL
         WmftlzGGftII0tCjYcc1cMZlmmxtcq/oYXaLP+qZZfqSmnxsJhpAVdT6eCAds4k9iYze
         ZSfg==
X-Gm-Message-State: AOAM531sgMPfecFKxvy/4OvWHONYZIhY6Q9nijOaZ8G9Bjy4y6D5DiBN
        aPJi47mVpKoHAEyLwJ7Q4cOfoAj2GCIEu23SffUBIX19YhJKZ0X09KHzyt3UfbV5CSa99kAgAGP
        TDrq57uyByeoZHijtR+AhzSOpoJQJGDEw1DlKY3WdNKuvCVpIbkm16mkF0vXjDgUhTnxKBqr3Py
        Q7Hszjxer52Yo=
X-Google-Smtp-Source: ABdhPJzRjYVShJdRorG6MaSccBe6ZdX1e3S2/18Yaiab0f2LybTKVk9bv/O83Y1YB3R7mSO5Sq+2PCBsGO7y2bLfyQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:23d6:: with SMTP id
 j205mr21425311ybj.76.1600320606780; Wed, 16 Sep 2020 22:30:06 -0700 (PDT)
Date:   Thu, 17 Sep 2020 13:29:43 +0800
In-Reply-To: <20200917132836.BlueZ.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
Message-Id: <20200917132836.BlueZ.6.I756c1fecc03bcc0cd94400b4992cd7e743f4b3e2@changeid>
Mime-Version: 1.0
References: <20200917132836.BlueZ.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [BlueZ PATCH 6/6] Bluetooth: Add toggle to switch off interleave scan
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     mcchou@chromium.org, marcel@holtmann.org, mmandlik@chromium.org,
        howardchung@google.com, luiz.dentz@gmail.com, alainm@chromium.org,
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
index 6dc3e43dcaa9f..4df6de44ee438 100644
--- a/net/bluetooth/mgmt_config.c
+++ b/net/bluetooth/mgmt_config.c
@@ -69,6 +69,7 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 						def_le_autoconnect_timeout),
 		HDEV_PARAM_U16(0x001d, advmon_allowlist_duration),
 		HDEV_PARAM_U16(0x001e, advmon_no_filter_duration),
+		HDEV_PARAM_U16(0x001f, enable_advmon_interleave_scan),
 	};
 	struct mgmt_rp_read_def_system_config *rp = (void *)params;
 
@@ -143,6 +144,7 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		case 0x001c:
 		case 0x001d:
 		case 0x001e:
+		case 0x001f:
 			if (len != sizeof(u16)) {
 				bt_dev_warn(hdev, "invalid length %d, exp %zu for type %d",
 					    len, sizeof(u16), type);
@@ -264,6 +266,10 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
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
2.28.0.618.gf4bc123cb7-goog

