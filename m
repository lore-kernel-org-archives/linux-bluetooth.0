Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC2BC433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 00:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2AE620767
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 00:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jT5Iqgdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgFPAZW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jun 2020 20:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgFPAZT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jun 2020 20:25:19 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACA2C061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 17:25:18 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 23so8615787pfw.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 17:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=awD337CBHyYdSueStD1GXtB0uBoMw71o8ikTZfEl/T8=;
        b=jT5IqgddoepqoTXi1PgtAUNM2UBaXwxr+oCyyEuKZYhGqCPjBSJ1pXsEc8ZJCWpcml
         a0zd7wf4YfIVsxfIBXl8eX1fsf2NzQtzlzjPlaOxAkx7FmBNv4msQrbdmvP88ZR//Uou
         7WwiIT+C1lf22okY5wtvNiXwmfrFg5+Fm/44w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=awD337CBHyYdSueStD1GXtB0uBoMw71o8ikTZfEl/T8=;
        b=IG8VYGmr9MzbHbBwcwRE8jS9eYWvaqZYQZ3oK1+V1M3ns8tP99Sp7bNNacohUryHf3
         kMY3YAKw0vamlapHFh9qgTVDLgeMogMwnP9oKDksma9jA58jysjFMMDWeCuG/8VQhvj9
         M6ByMG/4ns4mueFuzAGm6dqH/RIamhykRn5ZGY0nGBMfbNaA/EiIIyd+F/+GktuRo2cz
         d/yiYPHqGsgSVTRBxboqLeHlBsfC+TnBkJh+Nun/SyhZVYethWRDbZW7cSpTZwKKwZEO
         ohoC56BCUWqpMHR9U4TgjIAuVcF6aSePGLGsz8zYEgmJ0pl4+wCq/DT3X4jKK/XzqCn4
         +0mg==
X-Gm-Message-State: AOAM532Z8ijBXRgG4lVLjzjF2cPPq7BDEVPI286QMywhDrAQXQEpsf+e
        53NyNmsHRlaSHs8B9yA3g9JNPUd9+cQ=
X-Google-Smtp-Source: ABdhPJy9Ja7JFzS0zZuNTCBAJH/wdxBzeXeGLz3CsuXbZzW05pM3l2CKs4u0QPD5SyBCFjb6KzSGrg==
X-Received: by 2002:a63:c50:: with SMTP id 16mr87071pgm.143.1592267117577;
        Mon, 15 Jun 2020 17:25:17 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id x2sm14783781pfr.186.2020.06.15.17.25.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 17:25:16 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v5 6/7] Bluetooth: Notify adv monitor removed event
Date:   Mon, 15 Jun 2020 17:25:04 -0700
Message-Id: <20200615172440.v5.6.If1a82f71eb63f969de3d5a5da03c2908b58a721a@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615172440.v5.1.I636f906bf8122855dfd2ba636352bbdcb50c35ed@changeid>
References: <20200615172440.v5.1.I636f906bf8122855dfd2ba636352bbdcb50c35ed@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This notifies management sockets on MGMT_EV_ADV_MONITOR_REMOVED event.

The following test was performed.
- Start two btmgmt consoles, issue a btmgmt advmon-remove command on one
console and observe a MGMT_EV_ADV_MONITOR_REMOVED event on the other.

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v5:
- Fix warnings.

Changes in v4: None
Changes in v3:
- Convert the endianness of the returned handle.

Changes in v2: None

 net/bluetooth/mgmt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f4dffd06c3aa2..fed9c17b90dc9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -156,6 +156,7 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_PHY_CONFIGURATION_CHANGED,
 	MGMT_EV_EXP_FEATURE_CHANGED,
 	MGMT_EV_ADV_MONITOR_ADDED,
+	MGMT_EV_ADV_MONITOR_REMOVED,
 };
 
 static const u16 mgmt_untrusted_commands[] = {
@@ -3864,6 +3865,16 @@ static void mgmt_adv_monitor_added(struct sock *sk, struct hci_dev *hdev,
 	mgmt_event(MGMT_EV_ADV_MONITOR_ADDED, hdev, &ev, sizeof(ev), sk);
 }
 
+static void mgmt_adv_monitor_removed(struct sock *sk, struct hci_dev *hdev,
+				     u16 handle)
+{
+	struct mgmt_ev_adv_monitor_added ev;
+
+	ev.monitor_handle = cpu_to_le16(handle);
+
+	mgmt_event(MGMT_EV_ADV_MONITOR_REMOVED, hdev, &ev, sizeof(ev), sk);
+}
+
 static int read_adv_monitor_features(struct sock *sk, struct hci_dev *hdev,
 				     void *data, u16 len)
 {
@@ -4016,6 +4027,7 @@ static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_cp_remove_adv_monitor *cp = data;
 	struct mgmt_rp_remove_adv_monitor rp;
+	unsigned int prev_adv_monitors_cnt;
 	u16 handle;
 	int err;
 
@@ -4024,6 +4036,7 @@ static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	handle = __le16_to_cpu(cp->monitor_handle);
+	prev_adv_monitors_cnt = hdev->adv_monitors_cnt;
 
 	err = hci_remove_adv_monitor(hdev, handle);
 	if (err == -ENOENT) {
@@ -4032,6 +4045,9 @@ static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
+	if (hdev->adv_monitors_cnt < prev_adv_monitors_cnt)
+		mgmt_adv_monitor_removed(sk, hdev, handle);
+
 	hci_dev_unlock(hdev);
 
 	rp.monitor_handle = cp->monitor_handle;
-- 
2.26.2

