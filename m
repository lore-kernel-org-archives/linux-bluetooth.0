Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C966C433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 09:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69EBD21D42
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 09:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgLVJ6u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 04:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgLVJ6t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 04:58:49 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BAFC0611E4
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 01:57:34 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id o9so17249641yba.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 01:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=YmRkRWAPaxBPzw7t074VGQroTVoKudZ84P0ZF3qXVM8=;
        b=YU3V1K3/+hFi+oZEiex4spCaSuDiYhtx26nAYI3YjsEz5aniCiil7D+Jig7UGOtzyb
         pew8vscA945yZ/aspLiSl+n7bk7gjPGOWVJMnO/QbhJn7Wj+MF9g2gfLX6R3u3F5ZrJA
         ZBXoc8hDXbZVOQ21gaXrXt6CbBiE8KQ4Jojw6cvnDyyRB5kAxst+4ZgBY7micx/JmGRg
         tjgBslt1LXb3KmmgC5p9CGqT/hvuKevaIrpCjr8SLZxMKKktc7wESNu9dCCNE+Tng/Eh
         JWfHbZ+PhaUcxMjxFDkyO2Zi5RoHHd0HbPCNRGavs8/12mO7gvrd2nOODCd52wZILUxv
         uTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YmRkRWAPaxBPzw7t074VGQroTVoKudZ84P0ZF3qXVM8=;
        b=QW/1rjPO24AiO/xPS9bBg+Qnve6WQMz7+bdqTnzqj5kgJiyj/YgPdHeCZYfloSbrJX
         OERP9fCEp4jb21GHmV2ckZtxeGkjgpaI6lCaicUYFAP99WtLqXI88SJwSuhBR5HnEWVN
         AtzhN+BaRqWvg96FN7Q4fwSz6bDrk//EFVkeBW4Vnaeve6hhx0udBIcmTJLhONvMaotX
         fX/3coQMSIwHJR+bDNOpd/yYqONmugJml1WbTnnLPwGLHWT6E7fXrVjbok0nowEkCG+I
         g5rlfSx8TgnAW+39LpbGXKvbTF27NVh/xVq+D3BKCoi+XWOCWu1WHEd32O8F31fnRqyJ
         T62g==
X-Gm-Message-State: AOAM530HbffnyxNKjeqfbJBNz5hDKQknyL+pCX6F7QAknNEE1S2vDTKT
        3SqO9TTwAbYu3J9jqfVG5HvNjUNqvOaT2BJMqM/utB34LYwmi57iNOddAeO+8zrqQntQChh6qyT
        YKK1XhmTxlAaqEPDipwWfWRf3neyRm7V7XuITS+PXlHkH4IM6ezuGW6OZlZqJxqvzjPxNX+E9rl
        db
X-Google-Smtp-Source: ABdhPJxV2ixDoVFJv5B3xJTTH5qlEyYnoVX3VGNnFpzuOboypTtzs5V13vnAesWruXI3PKS1XaR8R4SRk84w
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([172.30.210.44])
 (user=apusaka job=sendgmr) by 2002:a25:a228:: with SMTP id
 b37mr2542930ybi.460.1608631054039; Tue, 22 Dec 2020 01:57:34 -0800 (PST)
Date:   Tue, 22 Dec 2020 17:57:06 +0800
In-Reply-To: <20201222095706.948827-1-apusaka@google.com>
Message-Id: <20201222175659.v4.5.I96e97067afe1635dbda036b881ba2a01f37cd343@changeid>
Mime-Version: 1.0
References: <20201222095706.948827-1-apusaka@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH v4 5/5] Bluetooth: advmon offload MSFT handle filter enablement
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
2.29.2.729.g45daf8777d-goog

