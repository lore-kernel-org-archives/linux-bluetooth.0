Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83AEC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Oct 2021 11:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A59361106
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Oct 2021 11:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhJ1LVT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Oct 2021 07:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhJ1LVQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Oct 2021 07:21:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45500C061767
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Oct 2021 04:18:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b126-20020a251b84000000b005bd8aca71a2so8261501ybb.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Oct 2021 04:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GArPAs92R04yZtAJ3Eyt3HPrbC6g2vwEe9LxDAEsAoI=;
        b=mpyXcJETSPJjVF7L8fe2iYA2F2RsPPOD0pVivAwB74+al0GAinwQAe4IwSq71Pz88d
         HanUxsrz0KUgt8v6D6bfgadmfOIbpKCOynDxw4+M4ccIAJy/xRpqz005cns9xyW7fQgg
         JXWrZ+m6QqHX8NJp4c69iKe06Cn7dpmSusjnm1ujukAD44dOvUP904QQKYNqaY/dEi+G
         o46gsihRHGkSsC2i40ySdv8mSEmZauEcv/mwIx9L+3mpYhXQ7LRee2leQSbDeqeyz+kr
         qB8M4ValJTi+oR02Ktcthel+VeW7v8UK0MMz0/ofQDYBWw5XNTRRJniukz2tAwNhlcmE
         yigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GArPAs92R04yZtAJ3Eyt3HPrbC6g2vwEe9LxDAEsAoI=;
        b=mS55xzpBk0QVDrvLLf7yhgOh6VqJuszq1DlIXoYEvdS76Q35qM2536uA6poeDWggwV
         k/2byjKfH4s6WVsSWX9OE8K0LtcKvZv7RB3JXzVdfykDuyiILxSNP+QhoGZxrKXD4AJP
         kFGelzLgqfq6VIIKaJLmnaWOcY89h9DrWYzO0m/D+WfMfP9oU32hEPCYcvpwRkcAd46I
         fvM/c21nz+3tvAR++E3FxNjTapwawjOVtNEOx7SbsdXXXRBEkVarQzvd/cl4WQFoa+xM
         khkrI7U3InwXuJVwbNQEv16ZVSu7Nk7CcSYMlLBLh2NZNwLHDhMj1XmceSPzCeFKFA6Z
         SYWQ==
X-Gm-Message-State: AOAM530zazgaLVayxoOGSqySYXUGuuwULCMTt16Xj/xHPzmZ4S5dPfpO
        vvokq4no+hmwIZ/4Nto9RlvHyQdmCOw04cqJgNzcQ4MmAuW/GCwU5zK+UsBMBbLhEN6YeO9cdW1
        vIDFvuaM55z9+Ox1nI9MN1IbkNK76nTK3tEt6AnHQKrutJLL6bdItBKvoD4gUPwO6O6OFRVU71w
        jQ
X-Google-Smtp-Source: ABdhPJyLWi7XzEVenNr7snS37vs2wJPBKmPwYx/gvza6YS5LzQGepbfu6AjkxrtFFuQ+Tk+836P7OeSqObiU
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:a9d:c667:f9ff:b40e])
 (user=apusaka job=sendgmr) by 2002:a25:424a:: with SMTP id
 p71mr3949088yba.101.1635419928437; Thu, 28 Oct 2021 04:18:48 -0700 (PDT)
Date:   Thu, 28 Oct 2021 19:18:42 +0800
Message-Id: <20211028191805.1.I35b7f3a496f834de6b43a32f94b6160cb1467c94@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH] Bluetooth: Limit duration of Remote Name Resolve
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
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

When doing remote name request, we cannot scan. In the normal case it's
OK since we can expect it to finish within a short amount of time.
However, there is a possibility to scan lots of devices that
(1) requires Remote Name Resolve
(2) is unresponsive to Remote Name Resolve
When this happens, we are stuck to do Remote Name Resolve until all is
done before continue scanning.

This patch adds a time limit to stop us spending too long on remote
name request. The limit is increased for every iteration where we fail
to complete the RNR in order to eventually solve all names.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---
Hi maintainers, we found one instance where a test device spends ~90
seconds to do Remote Name Resolving, hence this patch.
I think it's better if we reset the time limit to the default value
at some point, but I don't have a good proposal where to do that, so
in the end I didn't.


 include/net/bluetooth/hci_core.h |  5 +++++
 net/bluetooth/hci_event.c        | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index dd8840e70e25..df9ffedf1d29 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -87,6 +87,8 @@ struct discovery_state {
 	u8			(*uuids)[16];
 	unsigned long		scan_start;
 	unsigned long		scan_duration;
+	unsigned long		name_resolve_timeout;
+	unsigned long		name_resolve_duration;
 };
 
 #define SUSPEND_NOTIFIER_TIMEOUT	msecs_to_jiffies(2000) /* 2 seconds */
@@ -805,6 +807,8 @@ static inline void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
 #define INQUIRY_CACHE_AGE_MAX   (HZ*30)   /* 30 seconds */
 #define INQUIRY_ENTRY_AGE_MAX   (HZ*60)   /* 60 seconds */
 
+#define NAME_RESOLVE_INIT_DURATION	5120	/* msec */
+
 static inline void discovery_init(struct hci_dev *hdev)
 {
 	hdev->discovery.state = DISCOVERY_STOPPED;
@@ -813,6 +817,7 @@ static inline void discovery_init(struct hci_dev *hdev)
 	INIT_LIST_HEAD(&hdev->discovery.resolve);
 	hdev->discovery.report_invalid_rssi = true;
 	hdev->discovery.rssi = HCI_RSSI_INVALID;
+	hdev->discovery.name_resolve_duration = NAME_RESOLVE_INIT_DURATION;
 }
 
 static inline void hci_discovery_filter_clear(struct hci_dev *hdev)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3cba2bbefcd6..104a1308f454 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2086,6 +2086,15 @@ static bool hci_resolve_next_name(struct hci_dev *hdev)
 	if (list_empty(&discov->resolve))
 		return false;
 
+	/* We should stop if we already spent too much time resolving names.
+	 * However, double the name resolve duration for the next iterations.
+	 */
+	if (time_after(jiffies, discov->name_resolve_timeout)) {
+		bt_dev_dbg(hdev, "Name resolve takes too long, stopping.");
+		discov->name_resolve_duration *= 2;
+		return false;
+	}
+
 	e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY, NAME_NEEDED);
 	if (!e)
 		return false;
@@ -2634,6 +2643,9 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (e && hci_resolve_name(hdev, e) == 0) {
 		e->name_state = NAME_PENDING;
 		hci_discovery_set_state(hdev, DISCOVERY_RESOLVING);
+
+		discov->name_resolve_timeout = jiffies +
+				msecs_to_jiffies(discov->name_resolve_duration);
 	} else {
 		/* When BR/EDR inquiry is active and no LE scanning is in
 		 * progress, then change discovery state to indicate completion.
-- 
2.33.0.1079.g6e70778dc9-goog

