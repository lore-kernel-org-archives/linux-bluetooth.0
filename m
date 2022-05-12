Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E04EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 May 2022 22:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354858AbiELWau (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 May 2022 18:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349298AbiELWat (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 May 2022 18:30:49 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28B01DA4B
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 15:30:47 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id a191so5837261pge.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 15:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0dSEvmtlIR9K4VicMPCeEGlquhAdRH/Yf16cRkI0vts=;
        b=XtUe1tsvoozNY7GnKdNoGqF/NtOTP+30lKWAs9Ca04xmId425M5LzEjPxIPSCQIPlQ
         FPp24AAxJncinYiG+y+ku12Yi8PC1EweOViilHHnHwaIiavku1SZe3fY7Yhy5ibL4aOp
         t5K4ptGkGrsCmwr4vXJBlch0UPIgV5ZqK8Rmw9ZH33wzaHQQkzoekR72Zdz0fsUC2ebH
         U9FKxjpRRBiGW6A5XC3yuRc/2l2jPEjnZCmaTz8WTo2P9PzrgZl2gZqBL6dfePDDjC08
         2PBLz0a0/9+Ixh9Y+2KTzMi5l78kXUGzENrgAFsJtt29C4mq3fIxUP7TtfrIdRZhG4OZ
         dzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0dSEvmtlIR9K4VicMPCeEGlquhAdRH/Yf16cRkI0vts=;
        b=hPVY+HZQL4hUsvp8yDJbY6mTJOmnTEFrdYTsJSs66ZegN6pSCGq2hP4E/xEGIOBhy3
         oSiFNiH6ZrCf8yVXJudWFkWhc2dj6TDZgc6cDV/pJmqhTmOX1aKdOcahxwcW+SnMA5aq
         Ohp+k/EyEXFklCOlv+32yx6UUP7zXqicZPJvOxSUzkr5AsmHYnpOrBpmaG3rGdP8ni+y
         0nBAmJ5EdEVXq0t8n9lXQ8JyDptnH2cD1nbnuaYhXaWasGaXXJE0aV3HT04hML5om4xB
         3lU4lVICdRAXpzrUdynN5Yqy3jp0Mr0xKn/KQnpARnzRH6d2qwNJ9LhAwGT0/LUitOaB
         eVCw==
X-Gm-Message-State: AOAM533TIskLQTTVbwchYvLQSkr/aXTPqULmuV6hi7rzlC+KKRgd5uE1
        I0cnMBMVFnlpTlOybHT5EgueekH9dYs=
X-Google-Smtp-Source: ABdhPJxQ+vq6oFxYqwSCjH9R+ERfyOKHaqQvYH/VMCI4J7qzNVNi06KwLPqPenINnyQEbseekvbN1w==
X-Received: by 2002:a63:f646:0:b0:3db:7288:9ab5 with SMTP id u6-20020a63f646000000b003db72889ab5mr1408398pgj.290.1652394647130;
        Thu, 12 May 2022 15:30:47 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n11-20020a170902e54b00b0015e8d4eb21asm409848plf.100.2022.05.12.15.30.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 15:30:46 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: hci_sync: Fix attempting to suspend with unfiltered passive scan
Date:   Thu, 12 May 2022 15:30:43 -0700
Message-Id: <20220512223043.1020767-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512223043.1020767-1-luiz.dentz@gmail.com>
References: <20220512223043.1020767-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When suspending the passive scanning _must_ have its filter_policy set
to 0x01 to use the accept list otherwise _any_ advertise report would
end up waking up the system.

In order to fix the filter_policy the code now checks for
hdev->suspended && HCI_CONN_FLAG_REMOTE_WAKEUP
first, since the MGMT_OP_SET_DEVICE_FLAGS will reject any attempt to
set HCI_CONN_FLAG_REMOTE_WAKEUP when it cannot be programmed in the
acceptlist, so it can return success causing the proper filter_policy
to be used.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215768
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 58 +++++++++++++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 7bdfdc6a91f5..0fa013816a9b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1664,20 +1664,19 @@ static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
 	struct hci_cp_le_add_to_accept_list cp;
 	int err;
 
+	/* During suspend, only wakeable devices can be in acceptlist */
+	if (hdev->suspended &&
+	    !test_bit(HCI_CONN_FLAG_REMOTE_WAKEUP, params->flags))
+		return 0;
+
 	/* Select filter policy to accept all advertising */
 	if (*num_entries >= hdev->le_accept_list_size)
 		return -ENOSPC;
 
 	/* Accept list can not be used with RPAs */
 	if (!use_ll_privacy(hdev) &&
-	    hci_find_irk_by_addr(hdev, &params->addr, params->addr_type)) {
+	    hci_find_irk_by_addr(hdev, &params->addr, params->addr_type))
 		return -EINVAL;
-	}
-
-	/* During suspend, only wakeable devices can be in acceptlist */
-	if (hdev->suspended &&
-	    !test_bit(HCI_CONN_FLAG_REMOTE_WAKEUP, params->flags))
-		return 0;
 
 	/* Attempt to program the device in the resolving list first to avoid
 	 * having to rollback in case it fails since the resolving list is
@@ -4940,10 +4939,28 @@ static int hci_update_event_filter_sync(struct hci_dev *hdev)
 	return 0;
 }
 
+/* This function disables scan (BR and LE) and mark it as paused */
+static int hci_pause_scan_sync(struct hci_dev *hdev)
+{
+	if (hdev->scanning_paused)
+		return 0;
+
+	/* Disable page scan if enabled */
+	if (test_bit(HCI_PSCAN, &hdev->flags))
+		hci_write_scan_enable_sync(hdev, SCAN_DISABLED);
+
+	hci_scan_disable_sync(hdev);
+
+	hdev->scanning_paused = true;
+
+	return 0;
+}
+
 /* This function performs the HCI suspend procedures in the follow order:
  *
  * Pause discovery (active scanning/inquiry)
  * Pause Directed Advertising/Advertising
+ * Pause Scanning (passive scanning in case discovery was not active)
  * Disconnect all connections
  * Set suspend_status to BT_SUSPEND_DISCONNECT if hdev cannot wakeup
  * otherwise:
@@ -4969,15 +4986,11 @@ int hci_suspend_sync(struct hci_dev *hdev)
 	/* Pause other advertisements */
 	hci_pause_advertising_sync(hdev);
 
-	/* Disable page scan if enabled */
-	if (test_bit(HCI_PSCAN, &hdev->flags))
-		hci_write_scan_enable_sync(hdev, SCAN_DISABLED);
-
 	/* Suspend monitor filters */
 	hci_suspend_monitor_sync(hdev);
 
 	/* Prevent disconnects from causing scanning to be re-enabled */
-	hdev->scanning_paused = true;
+	hci_pause_scan_sync(hdev);
 
 	/* Soft disconnect everything (power off) */
 	err = hci_disconnect_all_sync(hdev, HCI_ERROR_REMOTE_POWER_OFF);
@@ -5048,6 +5061,22 @@ static void hci_resume_monitor_sync(struct hci_dev *hdev)
 	}
 }
 
+/* This function resume scan and reset paused flag */
+static int hci_resume_scan_sync(struct hci_dev *hdev)
+{
+	if (!hdev->scanning_paused)
+		return 0;
+
+	hci_update_scan_sync(hdev);
+
+	/* Reset passive scanning to normal */
+	hci_update_passive_scan_sync(hdev);
+
+	hdev->scanning_paused = false;
+
+	return 0;
+}
+
 /* This function performs the HCI suspend procedures in the follow order:
  *
  * Restore event mask
@@ -5070,10 +5099,9 @@ int hci_resume_sync(struct hci_dev *hdev)
 
 	/* Clear any event filters and restore scan state */
 	hci_clear_event_filter_sync(hdev);
-	hci_update_scan_sync(hdev);
 
-	/* Reset passive scanning to normal */
-	hci_update_passive_scan_sync(hdev);
+	/* Resume scanning */
+	hci_resume_scan_sync(hdev);
 
 	/* Resume monitor filters */
 	hci_resume_monitor_sync(hdev);
-- 
2.35.1

