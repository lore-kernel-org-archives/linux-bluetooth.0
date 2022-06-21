Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8285EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 19:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbiFUTJS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 15:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiFUTJR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 15:09:17 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1D120F43
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 12:09:16 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id f16so12517870pjj.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 12:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ssvMU+3MEHIM6Js/djoQXlR3ZYAB0lqSd1uBNPFTPus=;
        b=SX1IgDQjnIQojzCKEO+V8QsXL5FRoQqskgX9yjf4Uek4Z1RachJiNmIfOVzoeS64Qo
         JA9sUjv5arlGz3RN4q972TY7WUQvL/aWyNF4yxjK1MS438Vw3ICh5isLq87bXWSOHmV9
         0cVMYTnb40rRIW1XPTUQGB7KxdZcwqgyqV3/JUFO4PBYub+tfF6JQcA7JesazQoCoaAj
         KrUNMbXGu5DuE+A4bhCEtE1GyP2LCvlfdbBit037KQvDSl4K7zwUVNIcRgPoISDfUjgQ
         3QNiky0TgS742EMBMu7Ist5uW2dn8izoexO0UWP0RUh7c2utat4WVDyblIzzWEzEbmAB
         CymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ssvMU+3MEHIM6Js/djoQXlR3ZYAB0lqSd1uBNPFTPus=;
        b=Je7UBk0N+d6cpNbVaJofMCrWN1qkUk919M0GcW+zQEo4TkZHNLgzCoWM8ju2tBgZGQ
         F14vPCZEdZrLU/Scrhv4dUgy6vw7MLscEJhZavITlOFamE96qFSk0njm6K+Ny8zSG8xE
         q4JVOhF/pNLzFbB2rzLAqX5wjaB3noYPD3EUUHkZxnJwnfPEVSAAPt34kLpE6JmpUb2f
         SpXE7HxHpEkYeH7MpSnz4SC76BdYDd5jST3RU5u7ejVrZ/t19u+eS1XZihNDyEnlemBa
         324mIJ+nHSlZVgg4P94TvoiuI7fzztHW5grcvafQd82+WCIPa2aCTeAFsSmGKYyTjtab
         Psvg==
X-Gm-Message-State: AJIora8I4L+xy3bWI+AB7dmInstafIBXP1qd7xqT7QAT5uFKfhkppZuO
        6i8v514WjvpW6nd6KxmOo1QOeLRiYGozIA==
X-Google-Smtp-Source: AGRyM1s1AedaenhNABvImjMjYYUVbDgNbEo3NeSmxsiJxjGHs4RevEgzqpxGns7xHi2x/HiJj1rl9w==
X-Received: by 2002:a17:902:bf49:b0:16a:87a:349e with SMTP id u9-20020a170902bf4900b0016a087a349emr22655875pls.86.1655838555504;
        Tue, 21 Jun 2022 12:09:15 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id l2-20020a170903120200b00168c523032fsm11090936plh.269.2022.06.21.12.09.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 12:09:14 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RESEND] Bluetooth: hci_sync: Split hci_dev_open_sync
Date:   Tue, 21 Jun 2022 12:09:14 -0700
Message-Id: <20220621190914.2159875-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
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
index e5602e209b63..e974a888c0f3 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3872,9 +3872,148 @@ static const struct {
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
 
@@ -3927,119 +4066,7 @@ int hci_dev_open_sync(struct hci_dev *hdev)
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
2.35.3

