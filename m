Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C802C35273
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Apr 2022 00:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiDFAmQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Apr 2022 20:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1579803AbiDEXdC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Apr 2022 19:33:02 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325BEBD88B
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Apr 2022 14:52:11 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id c2so515534pga.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Apr 2022 14:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mIoT3Q4A3Vvj9KFfT7XLPORm+VgfUQxcbgB5nkyw0EU=;
        b=fCw5SfXLGfj9nbOUfUlXnDjniUDJH57iI9MSHYHAaRMM9QspkbwHim8YydlNS7lrUU
         hbWYRKzmbGIgXbNHCQhxl8n3qDy5CrJooBUFrWESeBTqjfuBOOJ+oppSwmlLQvQtptoE
         Ioz1r/kZYfNPJvyK1DvvsrTuF4PgnZdBcXqJz1PE2Mx1DSfERUA7XbAylBCFqkBus2bP
         QH6KvV3TpiACFNaOrBQGsYisA0uRQ4V8r6+9NxTWhG++4ZFq7+NEIFKNJMLtP9Tp7y0G
         Ji1Fc2PBDI2OCWnEHPoGqKmdJUbd0GO3ocIxYer0n+hMWgRtSNDcrpB7yHMuQxfTVOj4
         70jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mIoT3Q4A3Vvj9KFfT7XLPORm+VgfUQxcbgB5nkyw0EU=;
        b=UQQ/WeLLnORoG3tLSgb+1l9xBiARjhdqn6nvScoYHIfa/uBSfWenoGhPErf8uMU4Yq
         +HawWEWtbuGJjRUcr0ruMbUyT1MkkkJuMFSKOj1CLQN6HqX/F6LJEO9oRn2W5GPdN3eL
         fG+AYMH1pGV27igAf/z3Cm95ksw5Px6dn/SiO2PB5WWQOMSu1eeOphc8Rvw0/1sOPILj
         V803fi4LW/9PT1lNqPvF5su9p7mhavJw+Rv+HfzCFC9UkFsprM/RG0mkLuws0N5Jn341
         Br+c0dFCIw/8J6oiB2baKrQn68eLS+I/QjmbR8pbgBhK63eRehTVEC34wlCQv9AI7bps
         5/Rw==
X-Gm-Message-State: AOAM532mhnMNRl4KrXagsd1751XI/nXnUXR50TqXLzB1Yyjc+ojxej/y
        if1tOcACQPDyxCJBIzvyZD29/nwHKRE=
X-Google-Smtp-Source: ABdhPJxPJTsYHyQnB3JdMUA6L1+4l8UctWSR5po7urg4HC9DynA+NSrOuKyXfjHh21JLGdroGDCEBA==
X-Received: by 2002:a63:c015:0:b0:385:fe06:eb86 with SMTP id h21-20020a63c015000000b00385fe06eb86mr4487741pgg.132.1649195530047;
        Tue, 05 Apr 2022 14:52:10 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p12-20020a63ab0c000000b00381f7577a5csm13834464pgf.17.2022.04.05.14.52.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 14:52:09 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Split hci_dev_open_sync
Date:   Tue,  5 Apr 2022 14:52:07 -0700
Message-Id: <20220405215207.1415731-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This splits hci_dev_open_sync so each stage is handle by its own
function so it is easier to identify each stage.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 255 ++++++++++++++++++++++-----------------
 1 file changed, 141 insertions(+), 114 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5610ec1242d6..2d3b9adbd215 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3849,9 +3849,148 @@ static const struct {
 			 "advertised, but not supported.")
 };
 
-int hci_dev_open_sync(struct hci_dev *hdev)
+/* This function handles hdev setup stage:
+ *
+ * Calls hdev->setup
+ * Setup address if HCI_QUIRK_USE_BDADDR_PROPERTY is set.
+ */
+static int hci_dev_setup_sync(struct hci_dev *hdev)
 {
 	int ret = 0;
+	bool invalid_bdaddr;
+	size_t i;
+
+	if (!hci_dev_test_flag(hdev, HCI_SETUP) &&
+	    !test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks))
+		return 0;
+
+	bt_dev_dbg(hdev, "");
+
+	hci_sock_dev_event(hdev, HCI_DEV_SETUP);
+
+	if (hdev->setup)
+		ret = hdev->setup(hdev);
+
+	for (i = 0; i < ARRAY_SIZE(hci_broken_table); i++) {
+		if (test_bit(hci_broken_table[i].quirk, &hdev->quirks))
+			bt_dev_warn(hdev, "%s", hci_broken_table[i].desc);
+	}
+
+	/* The transport driver can set the quirk to mark the
+	 * BD_ADDR invalid before creating the HCI device or in
+	 * its setup callback.
+	 */
+	invalid_bdaddr = test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+
+	if (!ret) {
+		if (test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) {
+			if (!bacmp(&hdev->public_addr, BDADDR_ANY))
+				hci_dev_get_bd_addr_from_property(hdev);
+
+			if (bacmp(&hdev->public_addr, BDADDR_ANY) &&
+			    hdev->set_bdaddr) {
+				ret = hdev->set_bdaddr(hdev,
+						       &hdev->public_addr);
+
+				/* If setting of the BD_ADDR from the device
+				 * property succeeds, then treat the address
+				 * as valid even if the invalid BD_ADDR
+				 * quirk indicates otherwise.
+				 */
+				if (!ret)
+					invalid_bdaddr = false;
+			}
+		}
+	}
+
+	/* The transport driver can set these quirks before
+	 * creating the HCI device or in its setup callback.
+	 *
+	 * For the invalid BD_ADDR quirk it is possible that
+	 * it becomes a valid address if the bootloader does
+	 * provide it (see above).
+	 *
+	 * In case any of them is set, the controller has to
+	 * start up as unconfigured.
+	 */
+	if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks) ||
+	    invalid_bdaddr)
+		hci_dev_set_flag(hdev, HCI_UNCONFIGURED);
+
+	/* For an unconfigured controller it is required to
+	 * read at least the version information provided by
+	 * the Read Local Version Information command.
+	 *
+	 * If the set_bdaddr driver callback is provided, then
+	 * also the original Bluetooth public device address
+	 * will be read using the Read BD Address command.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
+		return hci_unconf_init_sync(hdev);
+
+	return ret;
+}
+
+/* This function handles hdev init stage:
+ *
+ * Calls hci_dev_setup_sync to perform setup stage
+ * Calls hci_init_sync to perform HCI command init sequence
+ */
+static int hci_dev_init_sync(struct hci_dev *hdev)
+{
+	int ret;
+
+	bt_dev_dbg(hdev, "");
+
+	atomic_set(&hdev->cmd_cnt, 1);
+	set_bit(HCI_INIT, &hdev->flags);
+
+	ret = hci_dev_setup_sync(hdev);
+
+	if (hci_dev_test_flag(hdev, HCI_CONFIG)) {
+		/* If public address change is configured, ensure that
+		 * the address gets programmed. If the driver does not
+		 * support changing the public address, fail the power
+		 * on procedure.
+		 */
+		if (bacmp(&hdev->public_addr, BDADDR_ANY) &&
+		    hdev->set_bdaddr)
+			ret = hdev->set_bdaddr(hdev, &hdev->public_addr);
+		else
+			ret = -EADDRNOTAVAIL;
+	}
+
+	if (!ret) {
+		if (!hci_dev_test_flag(hdev, HCI_UNCONFIGURED) &&
+		    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
+			ret = hci_init_sync(hdev);
+			if (!ret && hdev->post_init)
+				ret = hdev->post_init(hdev);
+		}
+	}
+
+	/* If the HCI Reset command is clearing all diagnostic settings,
+	 * then they need to be reprogrammed after the init procedure
+	 * completed.
+	 */
+	if (test_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks) &&
+	    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
+	    hci_dev_test_flag(hdev, HCI_VENDOR_DIAG) && hdev->set_diag)
+		ret = hdev->set_diag(hdev, true);
+
+	if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
+		msft_do_open(hdev);
+		aosp_do_open(hdev);
+	}
+
+	clear_bit(HCI_INIT, &hdev->flags);
+
+	return ret;
+}
+
+int hci_dev_open_sync(struct hci_dev *hdev)
+{
+	int ret;
 
 	bt_dev_dbg(hdev, "");
 
@@ -3904,119 +4043,7 @@ int hci_dev_open_sync(struct hci_dev *hdev)
 	set_bit(HCI_RUNNING, &hdev->flags);
 	hci_sock_dev_event(hdev, HCI_DEV_OPEN);
 
-	atomic_set(&hdev->cmd_cnt, 1);
-	set_bit(HCI_INIT, &hdev->flags);
-
-	if (hci_dev_test_flag(hdev, HCI_SETUP) ||
-	    test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
-		bool invalid_bdaddr;
-		size_t i;
-
-		hci_sock_dev_event(hdev, HCI_DEV_SETUP);
-
-		if (hdev->setup)
-			ret = hdev->setup(hdev);
-
-		for (i = 0; i < ARRAY_SIZE(hci_broken_table); i++) {
-			if (test_bit(hci_broken_table[i].quirk, &hdev->quirks))
-				bt_dev_warn(hdev, "%s",
-					    hci_broken_table[i].desc);
-		}
-
-		/* The transport driver can set the quirk to mark the
-		 * BD_ADDR invalid before creating the HCI device or in
-		 * its setup callback.
-		 */
-		invalid_bdaddr = test_bit(HCI_QUIRK_INVALID_BDADDR,
-					  &hdev->quirks);
-
-		if (ret)
-			goto setup_failed;
-
-		if (test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) {
-			if (!bacmp(&hdev->public_addr, BDADDR_ANY))
-				hci_dev_get_bd_addr_from_property(hdev);
-
-			if (bacmp(&hdev->public_addr, BDADDR_ANY) &&
-			    hdev->set_bdaddr) {
-				ret = hdev->set_bdaddr(hdev,
-						       &hdev->public_addr);
-
-				/* If setting of the BD_ADDR from the device
-				 * property succeeds, then treat the address
-				 * as valid even if the invalid BD_ADDR
-				 * quirk indicates otherwise.
-				 */
-				if (!ret)
-					invalid_bdaddr = false;
-			}
-		}
-
-setup_failed:
-		/* The transport driver can set these quirks before
-		 * creating the HCI device or in its setup callback.
-		 *
-		 * For the invalid BD_ADDR quirk it is possible that
-		 * it becomes a valid address if the bootloader does
-		 * provide it (see above).
-		 *
-		 * In case any of them is set, the controller has to
-		 * start up as unconfigured.
-		 */
-		if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks) ||
-		    invalid_bdaddr)
-			hci_dev_set_flag(hdev, HCI_UNCONFIGURED);
-
-		/* For an unconfigured controller it is required to
-		 * read at least the version information provided by
-		 * the Read Local Version Information command.
-		 *
-		 * If the set_bdaddr driver callback is provided, then
-		 * also the original Bluetooth public device address
-		 * will be read using the Read BD Address command.
-		 */
-		if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
-			ret = hci_unconf_init_sync(hdev);
-	}
-
-	if (hci_dev_test_flag(hdev, HCI_CONFIG)) {
-		/* If public address change is configured, ensure that
-		 * the address gets programmed. If the driver does not
-		 * support changing the public address, fail the power
-		 * on procedure.
-		 */
-		if (bacmp(&hdev->public_addr, BDADDR_ANY) &&
-		    hdev->set_bdaddr)
-			ret = hdev->set_bdaddr(hdev, &hdev->public_addr);
-		else
-			ret = -EADDRNOTAVAIL;
-	}
-
-	if (!ret) {
-		if (!hci_dev_test_flag(hdev, HCI_UNCONFIGURED) &&
-		    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
-			ret = hci_init_sync(hdev);
-			if (!ret && hdev->post_init)
-				ret = hdev->post_init(hdev);
-		}
-	}
-
-	/* If the HCI Reset command is clearing all diagnostic settings,
-	 * then they need to be reprogrammed after the init procedure
-	 * completed.
-	 */
-	if (test_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks) &&
-	    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
-	    hci_dev_test_flag(hdev, HCI_VENDOR_DIAG) && hdev->set_diag)
-		ret = hdev->set_diag(hdev, true);
-
-	if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
-		msft_do_open(hdev);
-		aosp_do_open(hdev);
-	}
-
-	clear_bit(HCI_INIT, &hdev->flags);
-
+	ret = hci_dev_init_sync(hdev);
 	if (!ret) {
 		hci_dev_hold(hdev);
 		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
-- 
2.35.1

