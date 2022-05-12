Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E9BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 May 2022 20:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358463AbiELU4S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 May 2022 16:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358451AbiELU4R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 May 2022 16:56:17 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE10F36E1F
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 13:56:15 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id m12so6080291plb.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 13:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mHOHwI5jh69sbhw+jW6AHUrWdEHCFNBT2R7Jbr9ZfGk=;
        b=PvlFVLAxBSti10tfAVarGhagBv4Cz8Kb08mbOH4TjkRr8qR0o/5a+JsbAMhKBmSGDY
         8AAKyW8LsLn3iDo4Zf2GrCGY0dIfT66YzPwOQxG58e16xDyLLTjgttBmL2OEAJcojmJT
         YJ0eDKA2mb/W78Xl0F5ZzCF2Nx7VW1fuYhaxFT8WaNdEUR4tjF9gm5d4Khdqv8z7Bl4E
         zdtThrLRaENuAhm9BgmxCuFb+tVxvZkoEjOmoy44tbavKUG5AM7BFiZHtKMAwFLdFSM1
         0jjDI8n0e6TsCo/AU05qReBCRt+R66YzODi/5vuRIxN+9iewvuNhPDs4Ck+zPsyZZ+m2
         aXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mHOHwI5jh69sbhw+jW6AHUrWdEHCFNBT2R7Jbr9ZfGk=;
        b=FN4XJE9vjPFosIIXggpNk0bbQxJq9oXvFaiQJKNio4ZMnnId/ePCdvH+g/ypb26lJ2
         cOoNdA5bvs7wkwdDhGaWQ+qljdQnJGD4SV+VaGEd4sM+h/vcatDaxlsSIg/ARBBuZcgw
         DPLLm5kAaMAfRhZ5xLJh/LmqSgIu28VMNQTbJ9ZUeotSiF58nOnpZvgFOt/Qz6jFAMun
         is+fodRU4RaKD05gGJsTh+iFhWkGJBYBrPHujTDHhO9adVuDSjRP4pCpbd52z5TnQj/c
         l+467KU48bHtEjrIS+rY+vmtRtkpSH7opTO9Kvnk220tmWZ0zt8RXQuKEt3F+4wXY4jT
         1DrQ==
X-Gm-Message-State: AOAM530eLlDhycSGlOYxBMYRS8aNsftT5q2o9VGg8QZ5P2MlM5Yn0geg
        ygXRobqf74BKgPFwBt1gD5YNclVYrbs=
X-Google-Smtp-Source: ABdhPJxbaHkixAHOLqcjg6NH2lEBfVspwUCIoFTifoSDwryJaDJetQOkucrO3gujlrVSpuzOhazfBw==
X-Received: by 2002:a17:90b:4b03:b0:1dc:6554:1bf9 with SMTP id lx3-20020a17090b4b0300b001dc65541bf9mr12579874pjb.246.1652388975079;
        Thu, 12 May 2022 13:56:15 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id ik29-20020a170902ab1d00b0015f2b3bc97asm376721plb.13.2022.05.12.13.56.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 13:56:13 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Fix attempting to suspend with unfiltered passive scan
Date:   Thu, 12 May 2022 13:56:13 -0700
Message-Id: <20220512205613.992901-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When suspending the passive scanning _must_ have its filter_policy set
to 0x01 to use the accept list otherwise _any_ advertise report would
end up waking up the system.

In order to fix the filter_policy the code now checks hdev->suspended
when attempting to program a device address using RPA into the accept
list, print a warning since the userspace shall not mark it as wakeable
when it doesn't enable LL privacy but proceed to return success so the
proper filter_policy is used.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215768
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 64 ++++++++++++++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 7bdfdc6a91f5..894973dd045f 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1664,6 +1664,11 @@ static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
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
@@ -1671,14 +1676,18 @@ static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
 	/* Accept list can not be used with RPAs */
 	if (!use_ll_privacy(hdev) &&
 	    hci_find_irk_by_addr(hdev, &params->addr, params->addr_type)) {
+		/* During suspend, only wakeable devices can be in acceptlist
+		 * which means that devices using RPAs without LL privacy cannot
+		 * be wakeable.
+		 */
+		if (hdev->suspended) {
+			bt_dev_warn(hdev,
+				    "Ignore wakeable but requires LL Privacy");
+			return 0;
+		}
 		return -EINVAL;
 	}
 
-	/* During suspend, only wakeable devices can be in acceptlist */
-	if (hdev->suspended &&
-	    !test_bit(HCI_CONN_FLAG_REMOTE_WAKEUP, params->flags))
-		return 0;
-
 	/* Attempt to program the device in the resolving list first to avoid
 	 * having to rollback in case it fails since the resolving list is
 	 * dynamic it can probably be smaller than the accept list.
@@ -4940,10 +4949,28 @@ static int hci_update_event_filter_sync(struct hci_dev *hdev)
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
@@ -4969,15 +4996,11 @@ int hci_suspend_sync(struct hci_dev *hdev)
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
@@ -5048,6 +5071,22 @@ static void hci_resume_monitor_sync(struct hci_dev *hdev)
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
@@ -5070,10 +5109,9 @@ int hci_resume_sync(struct hci_dev *hdev)
 
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

