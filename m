Return-Path: <SRS0=/O/j=EP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6729FC61DD8
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 07:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C74F20853
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 07:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dCjzCsA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbgKIH5m (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Nov 2020 02:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729737AbgKIH5l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Nov 2020 02:57:41 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8822C0613D4
        for <linux-bluetooth@vger.kernel.org>; Sun,  8 Nov 2020 23:57:39 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id l3so3600232ply.6
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Nov 2020 23:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fZu+i/Tey4YuHE3nmf4R/J6pPaT130pHwxhtyujUvT8=;
        b=dCjzCsA1NNS5/KnUDsa0Jo9Dx9F/NoCnQ4fUtHSJ3jy8SfMB2iffkzAlNmiBxpzv93
         R8ZrvAVK+qwQRQUxZQRiK860r1KKiIKzQ+nptmBAeWZnER6ixDejzjWrxfsbWFpesO6q
         fB71JL3uHFwx0yIrjmqmv5VYlPmuW5aCek6SG27rcHvOFQV0j0WxgMXOrlUE+n1xTftI
         OHCOBgQEZVDC5lZb7tRT8yFBV/Gt3ZchznUFo3od037F1uwp66wZ75bXDf54oAqfj7yM
         N8xngeORkWvr2OYCBwvOLu+0y8745+A2Jt+u6PFMd1EFREprQq6wAtKOBt0tEHYPFgD+
         +gVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fZu+i/Tey4YuHE3nmf4R/J6pPaT130pHwxhtyujUvT8=;
        b=EKQ5Pq5GVcbmH14a1wNiBeJnPbJa51dIn+3VZcatLouzNsodceiKgscaE9IDJwtaFB
         riJnML2rj1P2hQqFxYrTR2zH05PvxgdYjS0S6YqI7ADwN7DgRDztGn2peLPYRQEeDfN1
         CVEr/goOsBUTSk51/d+wKux74r26QMsZEJA6Rm9QQw8t5MInOp5VNS3LTI5D3GxBuF5o
         D+NCu8CFRjGQDUeH6MrdSB2DN6UY6W6u+6ijIFLpiPqCo1AVGbGv6Q6B62JnECnsRtf0
         HIshrCxAoQrywoURv7JbdfvDru2UrYU3dAWPysS7+TEpgEK6qjs7CnlUESheFkPFczpJ
         qYGQ==
X-Gm-Message-State: AOAM530z9ONXMuOcF6H+FvamgBXiZzvrq/bRRqn1UXvBhqI3VcP+7VeY
        gmvGv2n2c3+gqVNxP//AoAH/MsNpTwaHvCCw7rIn0sFyygqC8fD+hYwDp7FO9tgd7AImncnE3D5
        BaW6f6nYw+VJdyuSgHYOjC1cZPPmMNcrw6pLwX1Uh5KQ71n+43UbkwhICZyW0kw94dhoR1GCMJ1
        h0AlkGlI2AEHA=
X-Google-Smtp-Source: ABdhPJzvhFDG65ja4IDNja/+FMSLFMnHzO5O5WnBrF0c4Jy+9ZC4DC5CJtt2ggr4upsCUOF7GrFvI0b/S+/8uHHW3g==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a17:902:8e87:b029:d6:8dde:138b with
 SMTP id bg7-20020a1709028e87b02900d68dde138bmr11541206plb.83.1604908659272;
 Sun, 08 Nov 2020 23:57:39 -0800 (PST)
Date:   Mon,  9 Nov 2020 15:57:23 +0800
In-Reply-To: <20201109155659.v7.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
Message-Id: <20201109155659.v7.2.I3774a8f0d748c7c6ec3402c4adcead32810c9164@changeid>
Mime-Version: 1.0
References: <20201109155659.v7.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v7 2/5] Bluetooth: Handle system suspend resume case
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

Commit-changes 5:
- Remove the change in hci_req_config_le_suspend_scan

Signed-off-by: Howard Chung <howardchung@google.com>
Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

(no changes since v1)

 net/bluetooth/hci_request.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 70ea126f56282..b615b981be9d6 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1284,8 +1284,10 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
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
2.29.2.222.g5d2a92d10f8-goog

