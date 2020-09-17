Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC26FC43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 08:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 770F02083B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 08:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="fgXrxwl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgIQIro (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 04:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgIQIrl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 04:47:41 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387CBC061788
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 01:47:41 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 139so1058004qkl.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 01:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=kL2AQmKmQ8DRMKjtBMJBwyEAwBYPLpPCmkHC9nftMgY=;
        b=fgXrxwl5WGPHQG8YKqyWsKa+CPdKEMhNFS4ZyclxNkVJqc25wKfupVBKvCKG6haRzC
         0TBWGdEgUhbiblMCalHV7r39WltR8n+867Sh825ejjZPfMAUeAOVcCA8uWA91UdO1q09
         rBfY0YRvul6BhI5xFScawLndUs39LHNgfoS6sMd2OOQ0BBsL8fWi56CjRgKL7w74mZLT
         WdjeAueIV0Z9LX+87sesrytlq2Xa6FS3WpVUqbyiukolI7Y/2GE3ArMPaUux2JBaHiQ/
         SvjeabzpQfozVT//Xr828aSEJVLIVBv+6TtSP5G6PTem8xH83EcFNnwWhXE4XEBLPv6p
         rWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kL2AQmKmQ8DRMKjtBMJBwyEAwBYPLpPCmkHC9nftMgY=;
        b=XRD129lU1D0ZknlZXT16Ra2oFfxAUSiOW8uFTsnTy8nM45IOOW/xRABfRgMIBpsVY/
         QWUf4T7MZW4Uy4uH/wVuktSaqNx+T5YG7i5S4GTlt9+ElsK9NdqKskdVTTImRAM8fLUc
         UTpteN5jZQBF8tmj5q8UCkO47oEhSW/1B3udQ22gW5Lhd7HyLYzPgCvn4bw1ZbEU0J5d
         I/6j0QpHQvXKfOH5o3LnS+ZgvEVQOEsgj0dzEld3fsa5grWzXASSxb/cg2918FKoBJ07
         9LQN+Bi1jaAvwUy0aN3mrYh2xvUV4ZzGFFQAleA2m0yl5q6qkYLOm4V2UglidYLHRQtJ
         E2OA==
X-Gm-Message-State: AOAM5336AsPNCKGaxQ2nfbIr5aG1d1pBQilwAsrdnZhG7d0zXPVITmdq
        6KQ6lBNBu05HgAu1NCyPnx7JeoBH8zOVI2oyB4ThmlpsDvjR9TnFABjQ621NcA1ItMDSLrdp0h1
        0LHZMPFeLjIkBZKw9eVBisWk+D8Ru98j9gP1dFr+MjnHH/3jN5QJ+bhkx1RnrdsCLSt5L6E2VUa
        76szbgrIhKnQE=
X-Google-Smtp-Source: ABdhPJyNGGCWI5ydqkiZgandDqVu55u47O7nGmUqX2w1Bd9eqbdqO7yMoMa6S7yTGTAh34aYZvpS9plvu9PUEnoVRw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:ad4:5a0e:: with SMTP id
 ei14mr12731226qvb.15.1600332460122; Thu, 17 Sep 2020 01:47:40 -0700 (PDT)
Date:   Thu, 17 Sep 2020 16:47:15 +0800
In-Reply-To: <20200917164632.BlueZ.v2.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
Message-Id: <20200917164632.BlueZ.v2.6.I756c1fecc03bcc0cd94400b4992cd7e743f4b3e2@changeid>
Mime-Version: 1.0
References: <20200917164632.BlueZ.v2.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [BlueZ PATCH v2 6/6] Bluetooth: Add toggle to switch off interleave scan
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, mmandlik@chromium.org,
        mcchou@chromium.org, howardchung@google.com, alainm@chromium.org,
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
2.28.0.618.gf4bc123cb7-goog

