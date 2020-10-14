Return-Path: <SRS0=CDO+=DV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791DAC43457
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Oct 2020 08:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 171BC21527
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Oct 2020 08:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0gCWVd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgJNIOp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Oct 2020 04:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbgJNIOh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Oct 2020 04:14:37 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42931C045866;
        Tue, 13 Oct 2020 22:48:09 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w21so1200428plq.3;
        Tue, 13 Oct 2020 22:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nb/uFi8WsRrgWvvp/XblLt9Qx7O6wCy9IPkPTSrHgcI=;
        b=g0gCWVd+fyGFCrVvBgYbENgYj5fUVrbXA40j99tr5L2MugnblgsNG+kes3VDWrcP/Q
         uKq13a8AISOxVFU9VxDFxbemN/bg6GYNNMBibYfAL1LqoTfopeZxkSg+2OA8i5yehnGe
         +QY59p75FAOh0MMk8gP9Qp5CXOP/EDXEidemoToVZuFhDZY0fVPGABPgkIlHwiZ1/fuQ
         kCUkqCX3mFxv+kpG+a4b/dXOJ60C6ctE/UMOmnnGa4syhaplQ83FwfAtNK0buvWdDzgD
         RFUqBrqfVtfBFbJVgBir4qAERRBIGUzVJ4qPiGpQMhjGwixc0z0id6hgFe6clGNpd8Zg
         UXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nb/uFi8WsRrgWvvp/XblLt9Qx7O6wCy9IPkPTSrHgcI=;
        b=JSBzc6ZuqjDnzdcsNbGqRkhITgewticlmw3RwdqnZ1luYgBfXqLagv4dzA+fLjnNoY
         kX80BBdovE0cFtPksRhv4zZQxOaMAQ03/15Jh5NcXcRgRume3G0ZwVmIAHfrYY90f0mr
         G9KI7q8L9gU6BKPWLL4dfoHnjBl6mz4brz9MZ8siSN9rzV+o6fGxUZQq1iFUpJFpTPr8
         BR6HAOqkFJYFrMsEeC4Jei2ouyZccGCKBdAlAegXAQMSvVNShnO74J9I+YFOx8Cv5u4W
         u8bIhdPYZlzJxz6KiKhhdS3weqyfhyaYKnvqnI0RpTuLu41/DLVDORgkw443e4wjf0BC
         cNrA==
X-Gm-Message-State: AOAM530R8s0Y5UxMdk2B9WIdXieyxd/4u3RHHGAzV3UWf8fVPrgyGiTK
        5msznuvSl3BkZqtJ05EctEU=
X-Google-Smtp-Source: ABdhPJxqSdHcsk7zkgs+qDZm+MKDiGAF60n6PRoSWI8mO6Akv8dFFD+YpQ3Rbz080cRf+Ui/lVYoBA==
X-Received: by 2002:a17:90a:8c8a:: with SMTP id b10mr1923235pjo.127.1602654488830;
        Tue, 13 Oct 2020 22:48:08 -0700 (PDT)
Received: from HVD6JC2.Broadcom.net ([103.113.142.251])
        by smtp.gmail.com with ESMTPSA id m13sm1306785pjl.45.2020.10.13.22.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 22:48:08 -0700 (PDT)
From:   Amitesh Chandra <amitesh.chandra@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     amitesh.chandra@broadcom.com, ravi.nagarajan@broadcom.com,
        cheneyni@google.com, Manoj Babulal <manoj.babulal@broadcom.com>
Subject: [PATCH 3/3] Bluetooth: hci_bcm: Ignore deprecated command fail case
Date:   Wed, 14 Oct 2020 11:17:46 +0530
Message-Id: <20201014054746.2507-1-amitesh.chandra@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Manoj Babulal <manoj.babulal@broadcom.com>

Broadcom VSC uart_clock_setting is deprecated in
newer controllers. Ignore error if the controller
returns invalid or bad request error code.

Signed-off-by: Amitesh Chandra <amitesh.chandra@broadcom.com>
Signed-off-by: Manoj Babulal <manoj.babulal@broadcom.com>
---
 drivers/bluetooth/hci_bcm.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 680478f..d316788 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -158,15 +158,18 @@ static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
 		skb = __hci_cmd_sync(hdev, 0xfc45, 1, &clock, HCI_INIT_TIMEOUT);
 		if (IS_ERR(skb)) {
 			int err = PTR_ERR(skb);
-			bt_dev_err(hdev, "BCM: failed to write clock (%d)",
-				   err);
-			return err;
+			/* Ignore err if command is deprecated in controller */
+			if (err != -EBADRQC) {
+				bt_dev_err(hdev, "BCM: failed to write "
+						"clock (%d)", err);
+				return err;
+			}
+		} else {
+			kfree_skb(skb);
 		}
-
-		kfree_skb(skb);
 	}
 
-	bt_dev_dbg(hdev, "Set Controller UART speed to %d bit/s", speed);
+	bt_dev_info(hdev, "Set Controller UART speed to %d bit/s", speed);
 
 	param.zero = cpu_to_le16(0);
 	param.baud_rate = cpu_to_le32(speed);
-- 
2.7.4

