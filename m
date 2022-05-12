Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70474C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 May 2022 22:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359151AbiELWbk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 May 2022 18:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356208AbiELWbi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 May 2022 18:31:38 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D0B57152
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 15:31:37 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p8so6053044pfh.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 15:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0dSEvmtlIR9K4VicMPCeEGlquhAdRH/Yf16cRkI0vts=;
        b=UbAGRDMikzKuuvHh/s3lpoXBPmIqcOR9gCMgFjtTaiVdloSYmFkw+YCdmxoUiuek/9
         N1JQ5QvGEG402NAbsaZpbfdncbHkqVsf2nlVzpt8dK9vCi5bmcmQkhgii6xKviRlIVPd
         ZhhMLNeoYD2yrK0rGH1ELFaxDE9msHXYSVwzHZTntJu4GbE8EdQ775pJvPzcJbI1Bbyz
         +EowmjGuZ8kswJuo8I1e1t0rYTwI/vTVGl/lm18lDKuX/hOY9rSugsxQ4bBoV2JN3BIH
         3IKaTZ/B3LuzWcL8NYMsieiuCwmD67OHtSxnZne2rn5tZuKluEEYjbemAJqpaqpyjhly
         iprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0dSEvmtlIR9K4VicMPCeEGlquhAdRH/Yf16cRkI0vts=;
        b=XqOhf1zONmXwqQMLRgboBADqZQ4aK+h+cUT/cXE7CpuzhmpnFumKXXQLns7t885j/B
         V24KUbf5ory+DxfsEUC7bwyFfzF0EtK5apo7EdrCNKDIWgrUAxzN8L3R+jBxmFN0QblQ
         Vv8VWzMUfnyBLhEgfu1VV7Y07gjgkyjDH9kAC+XXogA2jtcbJ01C5MhApd0np8rI+f1+
         A616mX6Pd/AV3dn2Wd/aSQ90bRViFv9UQ3Unj57lwaQy6BcXrrxzcaC4ITVdthlYr8sb
         e25shX9zTpNUJGTCK9Q6R4N5T7rRcqvx8VMNqpx8jNgTHNiRHSGlGJmHKQdgayrFNucO
         sTwQ==
X-Gm-Message-State: AOAM530nvfF3FNruN0yx60QhmgXazusmGvVdlh3VMNdV8X6qjQYSZ39o
        BfRRKiMdF+ukfWPAmPLylBK/nZYS2TY=
X-Google-Smtp-Source: ABdhPJy9hWTw19Sfhzl3lNwSvrJCrQ+pYuCGLu1BenDeYlBn5gjlt2FPgQ0vBe/dJjxiOnEHZRvKCA==
X-Received: by 2002:aa7:9852:0:b0:50d:6d10:2094 with SMTP id n18-20020aa79852000000b0050d6d102094mr1532938pfq.4.1652394696792;
        Thu, 12 May 2022 15:31:36 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x5-20020a623105000000b0050dc76281fdsm289843pfx.215.2022.05.12.15.31.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 15:31:36 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: hci_sync: Fix attempting to suspend with unfiltered passive scan
Date:   Thu, 12 May 2022 15:31:34 -0700
Message-Id: <20220512223134.1021074-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512223134.1021074-1-luiz.dentz@gmail.com>
References: <20220512223134.1021074-1-luiz.dentz@gmail.com>
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

