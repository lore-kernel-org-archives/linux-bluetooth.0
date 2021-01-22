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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665FDC433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 08:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BA4B235F9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 08:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbhAVIj4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jan 2021 03:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbhAVIiY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jan 2021 03:38:24 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB26C06121D
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jan 2021 00:36:46 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id w5so3124961qts.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jan 2021 00:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=eLvtJocY85Q1bwr17/2UGrvESZ56o3W43X2Kdejgj9o=;
        b=G5a53b5u8em5s3gT/VvcAD/ntcjXwuVNBydErW7i0yvi7eY6ud3lfb+kd+99Omwgmf
         eVdmeaD+W4BWhL7h9xlC6tcek9HvpM9yq3uO4UcBI77MfyuxPgCPmMubU3kt2+CaL/is
         eCo6feHb+sF2M7X65Zs/49BXmhlnIX32Q7uwTdNKQiEw/5r+GnByUHBponF7pKjCKLxO
         /YDRMYFkC19B2yBiOLkcA0v3LhfnfZLqCSmE0bp5qGK4IDDLNVvk71v+aRnc1WRRRyJ3
         Ij24vpG81bD9ZEl7FIM/mzdb6gWxsbD005UsAsDvr1mETgljzfFocji4zsUOOoSiPjXh
         GHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eLvtJocY85Q1bwr17/2UGrvESZ56o3W43X2Kdejgj9o=;
        b=XIoVzt389jI+1mnen/pqNvpcF7wDXE3akV2EBsH7JLayaC1YbhP96W9aWaa93Gs92L
         U5FjV4aNuz92/Mz9gxgPIExgbkTYpEJ/SH5xiluiWctos5+XC10Vi6r84egdwXxXvIVn
         Chf3mONhczXBsa95TbqpYISY1Cu3lhM5uInCRjsbp5+wjaI+BUaBgBnYMZ+tXPqw16Gm
         1g75aSvwD5NbL1Vlyv5s672XyMPuyZioH6Gt1ZRCC03SRu8G/S3to+mCJvJ8MuxBn/kI
         7fgH7P7a+DE/rNv2OmgyLYeI+R+IlSXp8K/nPKLzAH9Yazec4wkiZCIkXuzGXkFgjBV7
         r0tg==
X-Gm-Message-State: AOAM530a4KBSOETKhKyL40qfUKy9+lqO2sVI97d6NCoGIbqPf5yRCkWK
        1+yib2qJ8qJxkV8eyalYv34QT7XUBUZn3Zt3wxUzHznQkKg8dZ565klYIhuJYisnU7kF4N9UUtF
        WBZGYo+eQWj0ZO9ZQdPq1WVe/5P2qO45Pxj4yumRwyAsi1R7wk3iqMfbLhShFjM1MVwR+O4eJYH
        Xl
X-Google-Smtp-Source: ABdhPJwhwSIq3ExuDBju+z8w8VpPKUMF5wntIGuxSOEYnDA6f07l8owOvrSzVM4fqTN4n4LQ1J302iBqqH5R
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a0c:f991:: with SMTP id
 t17mr3618102qvn.6.1611304605953; Fri, 22 Jan 2021 00:36:45 -0800 (PST)
Date:   Fri, 22 Jan 2021 16:36:15 +0800
In-Reply-To: <20210122083617.3163489-1-apusaka@google.com>
Message-Id: <20210122163457.v6.5.I96e97067afe1635dbda036b881ba2a01f37cd343@changeid>
Mime-Version: 1.0
References: <20210122083617.3163489-1-apusaka@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v6 5/7] Bluetooth: advmon offload MSFT handle filter enablement
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
index d25c6936daa4..b2ef654b1d3d 100644
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
@@ -83,6 +94,7 @@ struct msft_data {
 	__u16 pending_add_handle;
 	__u16 pending_remove_handle;
 	__u8 reregistering;
+	__u8 filter_enabled;
 };
 
 static int __msft_add_monitor_pattern(struct hci_dev *hdev,
@@ -190,6 +202,7 @@ void msft_do_open(struct hci_dev *hdev)
 
 	if (msft_monitor_supported(hdev)) {
 		msft->reregistering = true;
+		msft_set_filter_enable(hdev, true);
 		reregister_monitor_on_restart(hdev, 0);
 	}
 }
@@ -395,6 +408,40 @@ static void msft_le_cancel_monitor_advertisement_cb(struct hci_dev *hdev,
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
+	msft->filter_enabled = cp->enable;
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
@@ -531,3 +578,23 @@ int msft_remove_monitor(struct hci_dev *hdev, struct adv_monitor *monitor,
 
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
index 6f126a1f1688..f8e4d3a6d641 100644
--- a/net/bluetooth/msft.h
+++ b/net/bluetooth/msft.h
@@ -20,6 +20,7 @@ __u64 msft_get_features(struct hci_dev *hdev);
 int msft_add_monitor_pattern(struct hci_dev *hdev, struct adv_monitor *monitor);
 int msft_remove_monitor(struct hci_dev *hdev, struct adv_monitor *monitor,
 			u16 handle);
+int msft_set_filter_enable(struct hci_dev *hdev, bool enable);
 
 #else
 
@@ -45,4 +46,9 @@ static inline int msft_remove_monitor(struct hci_dev *hdev,
 	return -EOPNOTSUPP;
 }
 
+static inline int msft_set_filter_enable(struct hci_dev *hdev, bool enable)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
-- 
2.30.0.280.ga3ce27912f-goog

