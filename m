Return-Path: <SRS0=RRj3=DG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBDFC47423
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Sep 2020 11:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0C1823BCE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Sep 2020 11:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OOkMhc9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbgI2LfK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Sep 2020 07:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729772AbgI2LfJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Sep 2020 07:35:09 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABD2C0613D4
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2020 04:25:53 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id z12so2268106qvp.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2020 04:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/VsBobuTIfoCbFzJ0kQqpf8oU3yDxKHHFbs4g4IK6lE=;
        b=OOkMhc9kd/YE88zM44mAvr9hdQJnhfyFf/+Wf3DKnSyFaxsGd34jTGMKpJXAgB5W6t
         tx17kPa/mRwFvluvQ72yoXRMEvtwgT26e5d4KsHaIZNyrKjA+nNWaxK73+6MEvypnEwx
         TGmbbK7jdvsMUzVXf/NKciW7hZPxPFZKTNAJ96HZFAxBBgS30Rt6EBa0X3MUOCGgdZjM
         fp8kbGxGFCdVRbT/w2439Fow/i2m62XdbjXQtZOJfe59fM29JGgrYof2AFnXE+5tqmbQ
         whozH39NbiWScSh4FZxSVUXOleDMflrFSblR9flbBj0ymSK3cGFcolS0enqYxIBl5d6I
         d1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/VsBobuTIfoCbFzJ0kQqpf8oU3yDxKHHFbs4g4IK6lE=;
        b=Q1Jr1bfgMkhREUi8jpwyHiUV+tBkPgC4X3GY7jZGpCcDbDH51xnRtvoGx/waPTnR2T
         6jS47KMepuJJ1A/10Vx5AFpivt4LJd8euNR2uQJJsnlqHBhlgMykbsKkRhIgO3h2JWjD
         cjI2bMRxdX/zJamGj4qb3oOIZBpFW5a0hj3YkOTfQXd1IpuPrq3I0goJVGUvoIc6wJfT
         AFgZmBk+I8AJ3GV1oKZk+khzqCh83SDGYgKxlPZSY2pXpGAgQxossyVssL/qDvOpSWna
         y5PKb+yam8n+DscYLGa4+gouxpmQPLle/AV1Zx0WSPi4I4XgHMCSONH1CeudWzyUMQM7
         ZGGA==
X-Gm-Message-State: AOAM531F0pmmuOypfg5bpaOFy3Ii0ilKnnMeK8z5gnYtU0YvTDrrhqVm
        6LY/VL+79eLRyoap7nLL3leNfrIpWE40yekaU6Dg0b5iAl45RlJ9rQbL6ghHEiCUlnUpbDUnMgG
        7OXZqVCn5neMg2HbC8h9IGFhHpCzGWM7CcFfLJTnPetnitMB/qR3t9jbtq/ZLAOwTgCUIDCCDyN
        9ojvVSZUuerOc=
X-Google-Smtp-Source: ABdhPJzLzPklrSrGkyauOe8xVu8TSVmdlQbBVWjWRiw60PlVaYo2l3XoJjNawqozcNCs75lSLOyxEjtCHPW7SUlaOg==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a05:6214:292:: with SMTP id
 l18mr4013077qvv.11.1601378752727; Tue, 29 Sep 2020 04:25:52 -0700 (PDT)
Date:   Tue, 29 Sep 2020 19:25:24 +0800
In-Reply-To: <20200929192508.v7.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
Message-Id: <20200929192508.v7.2.I3774a8f0d748c7c6ec3402c4adcead32810c9164@changeid>
Mime-Version: 1.0
References: <20200929192508.v7.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v7 2/4] Bluetooth: Handle system suspend resume case
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     mmandlik@chromium.org, alainm@chromium.org, mcchou@chromium.org,
        Howard Chung <howardchung@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds code to handle the system suspension during interleave
scan. The interleave scan will be canceled when the system is going to
sleep, and will be restarted after waking up.

Signed-off-by: Howard Chung <howardchung@google.com>
Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

(no changes since v5)

Changes in v5:
- Remove the change in hci_req_config_le_suspend_scan

 net/bluetooth/hci_request.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index ba3016cc0b573..db44680fbe9c9 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1281,8 +1281,10 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
 		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &page_scan);
 
 		/* Disable LE passive scan if enabled */
-		if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
+		if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
+			cancel_interleave_scan(hdev);
 			hci_req_add_le_scan_disable(&req, false);
+		}
 
 		/* Mark task needing completion */
 		set_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks);
-- 
2.28.0.709.gb0816b6eb0-goog

