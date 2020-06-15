Return-Path: <SRS0=u3xs=74=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E43C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 12:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D4AA2067B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 12:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GDhRe+QZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbgFOMnz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbgFOMny (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jun 2020 08:43:54 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77769C061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 05:43:53 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id t23so3897823vkt.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 05:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P8Vj9oQ74zsd0LOGWPldE12+eK1pcedzb9RIuNUDypY=;
        b=GDhRe+QZIWD/hhDaZoRUjNH3K91ct278ipLPCnGPXpgV54kQqCIvVYH3Y+w5AtIIOc
         TTIwIgoMrkKJ3uBTXN1HY8i6aKHtZPQJF+APUR6AWAyyMUxBCSwzrejFbIHuUi+URwyX
         Orbr6lSnIj77212YL7nDr1JETKz52IrK790FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P8Vj9oQ74zsd0LOGWPldE12+eK1pcedzb9RIuNUDypY=;
        b=BWmJwZzJnfyRMt6LkxcJDyApmAqFfcmv9g5g6eooBovmAc1ILylneho8jKjB884u6r
         xFj3Q6KFx/xJO8BFsMdLDr4zReGUBNFDNDNOu1IqQ9Im5dRXK6MRv1P+DSYDh4M2uAJe
         NAOVmbc8f9pI1+WpC5OgzQ0fXE8V70t3AqWq9dArLPxjojgZ45fUKS9wecoURgEPq3ey
         JlBXvOHskKPKl6CrYuGUlIPWrgOTqcGjrsj3mJ+6rE5XlS9kI/bVSG1AAre12aIo4bf7
         GFZA7MKGWHldHwq4bvvO7lrrXed/VKpUq8m8+PJl964wghyCZ8hddbJRiZmmEU5JO1O2
         BEbg==
X-Gm-Message-State: AOAM530DORKI5FXFwlWH/8c9Dz1orY/TIKNivUHy2+ZjFilEGhIbJyzk
        FPaWPnaxO1Mto8VJkvvf62tmUWe7jc8=
X-Google-Smtp-Source: ABdhPJwS4kqegz0TlObK231D30FlTLPtOuOZI80BQ922F4EZTVdfVNAeyZSFDp7zv5BHO51XOW519w==
X-Received: by 2002:a1f:430a:: with SMTP id q10mr17769661vka.4.1592225031333;
        Mon, 15 Jun 2020 05:43:51 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id 81sm1798381uaj.5.2020.06.15.05.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 05:43:50 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v1] bluetooth: use configured default params for active scans
Date:   Mon, 15 Jun 2020 12:43:44 +0000
Message-Id: <20200615124344.37192-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch fixes active scans to use the configured default parameters.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 net/bluetooth/hci_request.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index a7f572ad38ef..04f846958ad6 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -2742,8 +2742,9 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 	if (err < 0)
 		own_addr_type = ADDR_LE_DEV_PUBLIC;
 
-	hci_req_start_scan(req, LE_SCAN_ACTIVE, interval, DISCOV_LE_SCAN_WIN,
-			   own_addr_type, filter_policy);
+	hci_req_start_scan(req, LE_SCAN_ACTIVE, interval,
+			   hdev->le_scan_window_discovery, own_addr_type,
+			   filter_policy);
 	return 0;
 }
 
@@ -2790,18 +2791,18 @@ static void start_discovery(struct hci_dev *hdev, u8 *status)
 			 * to do BR/EDR inquiry.
 			 */
 			hci_req_sync(hdev, interleaved_discov,
-				     DISCOV_LE_SCAN_INT * 2, HCI_CMD_TIMEOUT,
+				     hdev->le_scan_int_discovery * 2, HCI_CMD_TIMEOUT,
 				     status);
 			break;
 		}
 
 		timeout = msecs_to_jiffies(hdev->discov_interleaved_timeout);
-		hci_req_sync(hdev, active_scan, DISCOV_LE_SCAN_INT,
+		hci_req_sync(hdev, active_scan, hdev->le_scan_int_discovery,
 			     HCI_CMD_TIMEOUT, status);
 		break;
 	case DISCOV_TYPE_LE:
 		timeout = msecs_to_jiffies(DISCOV_LE_TIMEOUT);
-		hci_req_sync(hdev, active_scan, DISCOV_LE_SCAN_INT,
+		hci_req_sync(hdev, active_scan, hdev->le_scan_int_discovery,
 			     HCI_CMD_TIMEOUT, status);
 		break;
 	default:
-- 
2.27.0.290.gba653c62da-goog

