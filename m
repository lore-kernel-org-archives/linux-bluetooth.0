Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59287C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Apr 2022 23:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353430AbiDAXk0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Apr 2022 19:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353437AbiDAXkW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Apr 2022 19:40:22 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3FDE37
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Apr 2022 16:38:31 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id z10so3087656iln.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Apr 2022 16:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XeImaVfzLHou7+z6R/xeYIY1VSit5WMBxFwnBNaCYSc=;
        b=R3wyaIkjEWpeiMOQ/HhvfISFnjB0nO44o3ug6/sK2xcTifK/1L/YZ8P1uRbfAbnB1O
         HC83F+jCjpBWgV75sTlvs08ONGVFSxP4smvGAzrSkIeTxvLfwjYWo8Am1wwlkn5TwoM0
         HLkvwtWt9COJW75ZqJ8dJBZaI+5K0ESKIj6qGA5eBvoYUphEY5M0r0tedVOnG64ljhSR
         srb9UnMHIoSON2Z2EWPqG99txFrtuIWzCYGkFNnpH5r4GzBNwBNTANjIiINaLwrCULk/
         TGYLI/fk/q6XAcfJBE9zRA9I78uUIOhB9BszZ/sPpmGNbr1TYuqk4ZXRIpBA7qOFL4XR
         79FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XeImaVfzLHou7+z6R/xeYIY1VSit5WMBxFwnBNaCYSc=;
        b=tuU6ggGcDVHKMWTMwUdMc95bshpMiyHBUoOuDeBuqBdyxJcojQvmslSGqyY+oFWR4S
         UxF/qodDNBSX/JNPhR3JyYzfl5A6/Tr+d2GTQepvathOHsXRVdHLAh9yMoH3VIPY+UxL
         N84UkLKE7k8Wlji6uJlplQ06b72ei4PbQz9/YpRsvfgXq/8uD9aDnTSPJ5P9q6yf72VD
         dk6UnvTnWEQZeWY9Wn5TYBMJGkFTHM/7P3y/oreCSeo91ZWBw2S8FW+D7hrn4joP2ZnT
         PRIFzwaryhYiJYyujF9Gr6dvw+qqXNmgqEmf45DhSB5c76kwLVW8tjvfY2MYMTR141Ot
         eVfw==
X-Gm-Message-State: AOAM530nbPCWCSa8FMgBwvQiJ3Dp87EIKQxH8+g/Hnbbs9zGdiqcAEN1
        HhoMDWGBR5w406o3M0UHIrL+kS0FtLg=
X-Google-Smtp-Source: ABdhPJzhednDgspih/DM5aZnuash9hbjd9wPmzTD6/EaIJ9TQyCFvmvn0Wv2Ru2NCyaa6PkNjFGXNw==
X-Received: by 2002:a05:6e02:216f:b0:2ca:203b:75d with SMTP id s15-20020a056e02216f00b002ca203b075dmr365224ilv.174.1648856310720;
        Fri, 01 Apr 2022 16:38:30 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b19-20020a5d8553000000b00649f02b1b0csm2217062ios.39.2022.04.01.16.38.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 16:38:30 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 4/4] Bluetooth: hci_sync: Split hci_dev_open_sync
Date:   Fri,  1 Apr 2022 16:38:26 -0700
Message-Id: <20220401233826.122544-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220401233826.122544-1-luiz.dentz@gmail.com>
References: <20220401233826.122544-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_sync.c | 225 ++++++++++++++++++++++-----------------
 1 file changed, 126 insertions(+), 99 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5610ec1242d6..2d3b9adbd215 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3849,90 +3849,40 @@ static const struct {
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
-
-	bt_dev_dbg(hdev, "");
-
-	if (hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
-		ret = -ENODEV;
-		goto done;
-	}
+	bool invalid_bdaddr;
+	size_t i;
 
 	if (!hci_dev_test_flag(hdev, HCI_SETUP) &&
-	    !hci_dev_test_flag(hdev, HCI_CONFIG)) {
-		/* Check for rfkill but allow the HCI setup stage to
-		 * proceed (which in itself doesn't cause any RF activity).
-		 */
-		if (hci_dev_test_flag(hdev, HCI_RFKILLED)) {
-			ret = -ERFKILL;
-			goto done;
-		}
-
-		/* Check for valid public address or a configured static
-		 * random address, but let the HCI setup proceed to
-		 * be able to determine if there is a public address
-		 * or not.
-		 *
-		 * In case of user channel usage, it is not important
-		 * if a public address or static random address is
-		 * available.
-		 *
-		 * This check is only valid for BR/EDR controllers
-		 * since AMP controllers do not have an address.
-		 */
-		if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
-		    hdev->dev_type == HCI_PRIMARY &&
-		    !bacmp(&hdev->bdaddr, BDADDR_ANY) &&
-		    !bacmp(&hdev->static_addr, BDADDR_ANY)) {
-			ret = -EADDRNOTAVAIL;
-			goto done;
-		}
-	}
-
-	if (test_bit(HCI_UP, &hdev->flags)) {
-		ret = -EALREADY;
-		goto done;
-	}
-
-	if (hdev->open(hdev)) {
-		ret = -EIO;
-		goto done;
-	}
-
-	set_bit(HCI_RUNNING, &hdev->flags);
-	hci_sock_dev_event(hdev, HCI_DEV_OPEN);
-
-	atomic_set(&hdev->cmd_cnt, 1);
-	set_bit(HCI_INIT, &hdev->flags);
-
-	if (hci_dev_test_flag(hdev, HCI_SETUP) ||
-	    test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
-		bool invalid_bdaddr;
-		size_t i;
+	    !test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks))
+		return 0;
 
-		hci_sock_dev_event(hdev, HCI_DEV_SETUP);
+	bt_dev_dbg(hdev, "");
 
-		if (hdev->setup)
-			ret = hdev->setup(hdev);
+	hci_sock_dev_event(hdev, HCI_DEV_SETUP);
 
-		for (i = 0; i < ARRAY_SIZE(hci_broken_table); i++) {
-			if (test_bit(hci_broken_table[i].quirk, &hdev->quirks))
-				bt_dev_warn(hdev, "%s",
-					    hci_broken_table[i].desc);
-		}
+	if (hdev->setup)
+		ret = hdev->setup(hdev);
 
-		/* The transport driver can set the quirk to mark the
-		 * BD_ADDR invalid before creating the HCI device or in
-		 * its setup callback.
-		 */
-		invalid_bdaddr = test_bit(HCI_QUIRK_INVALID_BDADDR,
-					  &hdev->quirks);
+	for (i = 0; i < ARRAY_SIZE(hci_broken_table); i++) {
+		if (test_bit(hci_broken_table[i].quirk, &hdev->quirks))
+			bt_dev_warn(hdev, "%s", hci_broken_table[i].desc);
+	}
 
-		if (ret)
-			goto setup_failed;
+	/* The transport driver can set the quirk to mark the
+	 * BD_ADDR invalid before creating the HCI device or in
+	 * its setup callback.
+	 */
+	invalid_bdaddr = test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
 
+	if (!ret) {
 		if (test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) {
 			if (!bacmp(&hdev->public_addr, BDADDR_ANY))
 				hci_dev_get_bd_addr_from_property(hdev);
@@ -3951,33 +3901,51 @@ int hci_dev_open_sync(struct hci_dev *hdev)
 					invalid_bdaddr = false;
 			}
 		}
+	}
 
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
 
 	if (hci_dev_test_flag(hdev, HCI_CONFIG)) {
 		/* If public address change is configured, ensure that
@@ -4017,6 +3985,65 @@ int hci_dev_open_sync(struct hci_dev *hdev)
 
 	clear_bit(HCI_INIT, &hdev->flags);
 
+	return ret;
+}
+
+int hci_dev_open_sync(struct hci_dev *hdev)
+{
+	int ret;
+
+	bt_dev_dbg(hdev, "");
+
+	if (hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
+		ret = -ENODEV;
+		goto done;
+	}
+
+	if (!hci_dev_test_flag(hdev, HCI_SETUP) &&
+	    !hci_dev_test_flag(hdev, HCI_CONFIG)) {
+		/* Check for rfkill but allow the HCI setup stage to
+		 * proceed (which in itself doesn't cause any RF activity).
+		 */
+		if (hci_dev_test_flag(hdev, HCI_RFKILLED)) {
+			ret = -ERFKILL;
+			goto done;
+		}
+
+		/* Check for valid public address or a configured static
+		 * random address, but let the HCI setup proceed to
+		 * be able to determine if there is a public address
+		 * or not.
+		 *
+		 * In case of user channel usage, it is not important
+		 * if a public address or static random address is
+		 * available.
+		 *
+		 * This check is only valid for BR/EDR controllers
+		 * since AMP controllers do not have an address.
+		 */
+		if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
+		    hdev->dev_type == HCI_PRIMARY &&
+		    !bacmp(&hdev->bdaddr, BDADDR_ANY) &&
+		    !bacmp(&hdev->static_addr, BDADDR_ANY)) {
+			ret = -EADDRNOTAVAIL;
+			goto done;
+		}
+	}
+
+	if (test_bit(HCI_UP, &hdev->flags)) {
+		ret = -EALREADY;
+		goto done;
+	}
+
+	if (hdev->open(hdev)) {
+		ret = -EIO;
+		goto done;
+	}
+
+	set_bit(HCI_RUNNING, &hdev->flags);
+	hci_sock_dev_event(hdev, HCI_DEV_OPEN);
+
+	ret = hci_dev_init_sync(hdev);
 	if (!ret) {
 		hci_dev_hold(hdev);
 		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
-- 
2.35.1

