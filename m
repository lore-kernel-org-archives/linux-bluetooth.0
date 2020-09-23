Return-Path: <SRS0=ZvEB=DA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DCEC4727E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Sep 2020 09:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E86592137B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Sep 2020 09:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KwBf6MdW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgIWJWr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Sep 2020 05:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgIWJWl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Sep 2020 05:22:41 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8802C0613D2
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2020 02:22:41 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id l1so13498102qvr.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2020 02:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ZXC6RIjQzvP4+2I2ajwE91pKSZgn0JwFP6uprOUMdtE=;
        b=KwBf6MdWhP0CknbKFW6SdYmhjmeKufVFeUTMS58YpG65Fa57LKDmq4GU4j1dXsqiIK
         KC7BzISj8ncc0A4zxKTitK5MCmXO218SNreBVdugutCob9UXG4C58Z2tRQeVF9EKNb2J
         HiBgyUGwChc7JqQKrA3Qq9ErOSHpPE/+rggv4QgrniULhscUIqiA0hrqw0rasVk5MzfA
         jLq6LVKHSx7vS1L664xoRfUvtfZidSSGCdb5Ds39MS9676fDRPgWxgdPcl7p0OjvaxVj
         dSTcruurTkrqS/H7wO7O2n8UQiS/8MAH0rIQdWjb3NUjXfb5cK5SAlj7AXAIPz1g0aAO
         CF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZXC6RIjQzvP4+2I2ajwE91pKSZgn0JwFP6uprOUMdtE=;
        b=O41IE6liyDqSlw+HDi3xj4+U1zjwNFS3GLPRItHJUcTMSYMjHNAnj0EnGTbOEsvQm5
         hbUTkML85s194L6PVYjZhISi9wy4Enb3QKawsGEbQEe/4lVw6JKhglQ2o8Uk3dUb/6om
         DDmlWgERbIbd5PFAYizqhDiwTzKgV42VhYe69MpO2J8Dq9QtQ7KjJuOSry1UmshfCDQO
         Crq2gt5aAH7WHjRS+vBlOzYL5Dn3vj6SKzbKZQLquBpl3ybobdbQRfbh7yBrCNZeo/ot
         bK9h1JoNZ42ae/CzmclaGpF8xwM74Yg8K6TiUR74EKIuOw7wP0AlhKUp3dD5Cm+WLgZJ
         uPAw==
X-Gm-Message-State: AOAM532UiCJ7eLCGeLQKSDs42PR3UYTQmEFiemLacGX+xwZhNrqXK1om
        LvBaXzqr3JZjYoaQepgy3jg290cJlQWo3Lv9ugFjAVxrqoI/jUWUaMfvZ51JGLVcrJ1ktHy0bAh
        USIhuNO1aqxJU9/aDCua26L30GwaSJnbExR8BHe01fK8cu7xF7LJBVj1S5RBfjoTjSPJgHpV8Yf
        QBOL8mkq3bOtE=
X-Google-Smtp-Source: ABdhPJw1JOPfZUWsb7sDXsDlMt//WE8y5Wm/J1mYW+p6E2cWqB3Sq1npvUx4u1vVd4USLPXEAs8GttiO5VkHSkIeJA==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a0c:f687:: with SMTP id
 p7mr10292000qvn.15.1600852960833; Wed, 23 Sep 2020 02:22:40 -0700 (PDT)
Date:   Wed, 23 Sep 2020 17:22:30 +0800
In-Reply-To: <20200923172129.v5.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
Message-Id: <20200923172129.v5.2.I3774a8f0d748c7c6ec3402c4adcead32810c9164@changeid>
Mime-Version: 1.0
References: <20200923172129.v5.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v5 2/4] Bluetooth: Handle system suspend resume case
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     mmandlik@chromium.orgi, mcchou@chromium.org, alainm@chromium.org,
        Howard Chung <howardchung@google.com>,
        Manish Mandlik <mmandlik@chromium.org>,
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
2.28.0.681.g6f77f65b4e-goog

