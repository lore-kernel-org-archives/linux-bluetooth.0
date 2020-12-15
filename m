Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE689C2BB9A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 08:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 761BA22475
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 08:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgLOIeN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Dec 2020 03:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbgLOIdu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Dec 2020 03:33:50 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A230C0611E4
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 00:32:35 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id a11so6374221pld.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 00:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=tKrpotQRqXKeiHkkUlQLJmQkGbUk0Yb/85Up00zpI90=;
        b=W4mUg3icgLUFwZqbuGYGoxD610CQn2hpRbIx/cZKWcsYds6RtkgiYcIqcLnB2zBVwN
         /G8KKRKK1b6NGESh8UJGNfihjEetzuiDg0z7+CC7qwSZ3nOq65ORzVWCFHnOHifTfwag
         0Pj504g0Q68Lz6IdBW09uQ1tkk2wCaWeoikBsxPPSpwU6tKncsU9NH22EUHvfaPWELS3
         sTOniPPlR/N2/iyqvU9QBr3aBW7ep6YBm9e7KLY0NmCfJbSR6OWEStf1iR3V/gmU5phj
         mJ0Txq2yYFXZroa/8941+4a/FztyhQdeiNFBE3H8GqH0+A1fnmPUgjNo3VRMX5oKZeCj
         0b+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tKrpotQRqXKeiHkkUlQLJmQkGbUk0Yb/85Up00zpI90=;
        b=fA/1N05zJQjd/LboKIjUUzVCJWTT1Qsxc54U/xAtXvWCepB7aSizLAcnjMVMtAzoPQ
         mjS/P5+6P5WDQFWFAFhajBPdgD0Azjs/befGheM7a28mlOAi7vrvyZnd/d9JlHHJmIB0
         FKWdhKH+rJKXYDnfEF3Hzzg7uVT4yMS9SUEakuvb3TLoonNzDsJzyz1GUrG0xAT2RsGG
         Ls1XI4Q5ZMkt9pZ2UQcTcJThGxrUGTs8ltnLgwqfVOCSQi5+IFlojPnIrhibaARUxW+s
         QtLtdM6OnmCweAJ5pDEkmtclkOulUSViOkmdiGTXfLqoW75akNmBb4/O+EAZRt5jaYl3
         Wx/A==
X-Gm-Message-State: AOAM533S051vhXOGN53XvqQMCHHTw+zNpSYWymjKnob7EVHk4RPzOpCi
        qUw/klayvwO5z48sodbzpNxVUWm3eHDsHQAvoUFzPaI4vV1x3+QFa6cZtmKe3WLy6a/tSnlW/vw
        KPa68MoKyy6YfaBXLROFK2ueV7p0UwYG+2UDOzkV6Ym/GItI4oTUYFhFqlkD3j7WZXIx6oRDS7G
        Go
X-Google-Smtp-Source: ABdhPJylR8HTHElwrIBgYZfKWIk7/ykE0SQV1IksNC8qpfVzVbTRRUp7cnaILFn0ZoSSIhrVIWpVjXQs4hcP
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a17:902:7207:b029:da:fd0c:521a with SMTP
 id ba7-20020a1709027207b02900dafd0c521amr26436760plb.45.1608021154785; Tue,
 15 Dec 2020 00:32:34 -0800 (PST)
Date:   Tue, 15 Dec 2020 16:32:01 +0800
In-Reply-To: <20201215083201.1343692-1-apusaka@google.com>
Message-Id: <20201215163106.v2.5.I96e97067afe1635dbda036b881ba2a01f37cd343@changeid>
Mime-Version: 1.0
References: <20201215083201.1343692-1-apusaka@google.com>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH v2 5/5] Bluetooth: advmon offload MSFT handle filter enablement
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
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Implements the feature to disable/enable the filter used for
advertising monitor on MSFT controller, effectively have the same
effect as "remove all monitors" and "add all previously removed
monitors".

This feature would be needed when suspending, where we would not want
to get packets from anything outside the allowlist. Note that the
integration with the suspending part is not included in this patch.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Yun-Hao Chung <howardchung@google.com>

---

(no changes since v1)

 net/bluetooth/msft.c | 67 ++++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/msft.h |  6 ++++
 2 files changed, 73 insertions(+)

diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index 7e33a85c3f1c..055cc5a260df 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -69,6 +69,17 @@ struct msft_rp_le_cancel_monitor_advertisement {
 	__u8 sub_opcode;
 } __packed;
 
+#define MSFT_OP_LE_SET_ADVERTISEMENT_FILTER_ENABLE	0x05
+struct msft_cp_le_set_advertisement_filter_enable {
+	__u8 sub_opcode;
+	__u8 enable;
+} __packed;
+
+struct msft_rp_le_set_advertisement_filter_enable {
+	__u8 status;
+	__u8 sub_opcode;
+} __packed;
+
 struct msft_monitor_advertisement_handle_data {
 	__u8  msft_handle;
 	__u16 mgmt_handle;
@@ -85,6 +96,7 @@ struct msft_data {
 
 	struct {
 		u8 reregistering:1;
+		u8 filter_enabled:1;
 	} flags;
 };
 
@@ -193,6 +205,7 @@ void msft_do_open(struct hci_dev *hdev)
 
 	if (msft_monitor_supported(hdev)) {
 		msft->flags.reregistering = true;
+		msft_set_filter_enable(hdev, true);
 		reregister_monitor_on_restart(hdev, 0);
 	}
 }
@@ -398,6 +411,40 @@ static void msft_le_cancel_monitor_advertisement_cb(struct hci_dev *hdev,
 	hci_remove_adv_monitor_complete(hdev, status);
 }
 
+static void msft_le_set_advertisement_filter_enable_cb(struct hci_dev *hdev,
+						       u8 status, u16 opcode,
+						       struct sk_buff *skb)
+{
+	struct msft_cp_le_set_advertisement_filter_enable *cp;
+	struct msft_rp_le_set_advertisement_filter_enable *rp;
+	struct msft_data *msft = hdev->msft_data;
+
+	rp = (struct msft_rp_le_set_advertisement_filter_enable *)skb->data;
+	if (skb->len < sizeof(*rp))
+		return;
+
+	/* Error 0x0C would be returned if the filter enabled status is
+	 * already set to whatever we were trying to set.
+	 * Although the default state should be disabled, some controller set
+	 * the initial value to enabled. Because there is no way to know the
+	 * actual initial value before sending this command, here we also treat
+	 * error 0x0C as success.
+	 */
+	if (status != 0x00 && status != 0x0C)
+		return;
+
+	hci_dev_lock(hdev);
+
+	cp = hci_sent_cmd_data(hdev, hdev->msft_opcode);
+	msft->flags.filter_enabled = cp->enable;
+
+	if (status == 0x0C)
+		bt_dev_warn(hdev, "MSFT filter_enable is already %s",
+			    cp->enable ? "on" : "off");
+
+	hci_dev_unlock(hdev);
+}
+
 static bool msft_monitor_rssi_valid(struct adv_monitor *monitor)
 {
 	struct adv_rssi_thresholds *r = &monitor->rssi;
@@ -534,3 +581,23 @@ int msft_remove_monitor(struct hci_dev *hdev, struct adv_monitor *monitor,
 
 	return err;
 }
+
+int msft_set_filter_enable(struct hci_dev *hdev, bool enable)
+{
+	struct msft_cp_le_set_advertisement_filter_enable cp;
+	struct hci_request req;
+	struct msft_data *msft = hdev->msft_data;
+	int err;
+
+	if (!msft)
+		return -EOPNOTSUPP;
+
+	cp.sub_opcode = MSFT_OP_LE_SET_ADVERTISEMENT_FILTER_ENABLE;
+	cp.enable = enable;
+
+	hci_req_init(&req, hdev);
+	hci_req_add(&req, hdev->msft_opcode, sizeof(cp), &cp);
+	err = hci_req_run_skb(&req, msft_le_set_advertisement_filter_enable_cb);
+
+	return err;
+}
diff --git a/net/bluetooth/msft.h b/net/bluetooth/msft.h
index 9f9a11f90b0c..44bee705c16d 100644
--- a/net/bluetooth/msft.h
+++ b/net/bluetooth/msft.h
@@ -20,6 +20,7 @@ __u64 msft_get_features(struct hci_dev *hdev);
 int msft_add_monitor_pattern(struct hci_dev *hdev, struct adv_monitor *monitor);
 int msft_remove_monitor(struct hci_dev *hdev, struct adv_monitor *monitor,
 			u16 handle);
+int msft_set_filter_enable(struct hci_dev *hdev, bool enable);
 
 #else
 
@@ -45,4 +46,9 @@ static inline bool msft_remove_monitor(struct hci_dev *hdev,
 	return -EOPNOTSUPP;
 }
 
+static inline int msft_set_filter_enable(struct hci_dev *hdev, bool enable)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
-- 
2.29.2.684.gfbc64c5ab5-goog

