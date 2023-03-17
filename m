Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1382C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Mar 2023 20:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjCQUrC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Mar 2023 16:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjCQUrB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Mar 2023 16:47:01 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6302F7BD
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Mar 2023 13:47:00 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-17aaa51a911so7014428fac.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Mar 2023 13:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679086019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nQKzLCpP1COyC2Xr4Xk57G6p6MUlqAJ8NPApfXEYuzk=;
        b=kcZnhxUyBw26TfHjyIf6aiLyG+6anAmRHoWr5mK9yRBTkNcQZyAM5pbF+pPs0z+8iu
         yqzc02GpFk4OI935hp4tAhPyfGrdn7yJCIodjlfHWdnc4OEoC0dA5M4fGsUEEDC0B1o8
         nJ4cSLEjcL3GizslSHLbPKFP11Gat08fJRf/BjuvE+mkLhB6vQS0ZjmJz+DMYr1QfbEk
         u8sONq1DzDm6GaG6vtQyc2vxkJfaL8l7QYqIZ/EPUqooHKrGlNi0260phmyDwEczZHMC
         UhUEP/SUQ26l6aLFxLMeSJNERnwR/4M2gJAR/KfrnsPiXx7f7t3gseNPGHJs/kEM7Tei
         wS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679086019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQKzLCpP1COyC2Xr4Xk57G6p6MUlqAJ8NPApfXEYuzk=;
        b=TQaBdHYTshOe7NTTu94wjL0b24MsgTooFgZPPDKYQymcH9ndasHWua+iA98yNnyJVX
         Ecx4ZqY1vIpxZU5Vz/ds78urojIMTRiPDpqi17HUVc6ytEYfrx4Sn9QvGYCUWWlnanFy
         WMRFkBEuRTVCm89NLrXoAN/2djwxqs5DMOd9Rw3H3FYNY3/CSmQU6rYQ+l8Y27zRhe4F
         8ebTwqsdGdIysTyEe/mfj7wTfBgRGjPmc4hE3FLaEIQuyUbFfhPNL/aYFeyry0z3qI1h
         zadOb8+wOGN5fkDp+CcUGEnY2Z6fnTLhrQpI/K3YS3FYcV5S8ZFpOkz8W9UBQ8ecxqAC
         ghXw==
X-Gm-Message-State: AO0yUKVJL4qrQkd0TrUELd+gnbzjWcRG/YXYGI9efAzcnMQychlZ10fp
        0fCjaI/R3p7JkJXaTz3HwXKewSbhF6yx1XIR
X-Google-Smtp-Source: AK7set+c7khC8XbT7hvlTb23jUZVoL7rVM/u0HN3dUs0kKIjlMNPMlmibiCL6Ba9OvNoVGLoB5gglg==
X-Received: by 2002:a05:6870:310:b0:177:af7c:906f with SMTP id m16-20020a056870031000b00177af7c906fmr611852oaf.40.1679086019158;
        Fri, 17 Mar 2023 13:46:59 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:f429:2d04:9d9f:c9a0:8ef:bc50])
        by smtp.gmail.com with ESMTPSA id l4-20020a056808020400b0037faba740b8sm1266984oie.16.2023.03.17.13.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 13:46:58 -0700 (PDT)
From:   Raul Cheleguini <raul.cheleguini@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Raul Cheleguini <raul.cheleguini@gmail.com>
Subject: [PATCH] Bluetooth: Partial support for Actions Semi ATS2851 based devices
Date:   Fri, 17 Mar 2023 17:46:20 -0300
Message-Id: <20230317204620.2809181-1-raul.cheleguini@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change enables support to device initialization and to scan
process, by adding two new quirks for the following advertised but
unsupported commands: "Set Random Private Address Timeout" and
"Extended Create Connection".

It offers partial device support: controller initialization and scan.
The pairing process still needs work.

At the moment there is little to none available documentation about the
ATS2851 and its based USB dongles. It is known that it works in other
systems via generic drivers, and this is one step towards have it working
in Linux.

Signed-off-by: Raul Cheleguini <raul.cheleguini@gmail.com>
---
 drivers/bluetooth/btusb.c   |  2 ++
 include/net/bluetooth/hci.h | 14 ++++++++++++++
 net/bluetooth/hci_sync.c    | 13 +++++++++++--
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7382b021f3df..7bba19061277 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4106,6 +4106,8 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, &hdev->quirks);
 	}
 
 	if (!reset)
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 997107bfc0b1..3ff1681fd2b8 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -301,6 +301,20 @@ enum {
 	 * don't actually support features declared there.
 	 */
 	HCI_QUIRK_BROKEN_LOCAL_EXT_FEATURES_PAGE_2,
+
+	/*
+	 * When this quirk is set, the HCI_OP_LE_SET_RPA_TIMEOUT command is
+	 * disabled. This is required for the Actions Semiconductor ATS2851
+	 * controller, which erroneously claim to support it.
+	 */
+	HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT,
+
+	/*
+	 * When this quirk is set, the HCI_OP_LE_EXT_CREATE_CONN command is
+	 * disabled. This is required for the Actions Semiconductor ATS2851
+	 * controller, which erroneously claim to support it.
+	 */
+	HCI_QUIRK_BROKEN_EXT_CREATE_CONN,
 };
 
 /* HCI device flags */
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 8e5fe73873a8..9b2a0d6d6c1a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4090,9 +4090,11 @@ static int hci_le_set_rpa_timeout_sync(struct hci_dev *hdev)
 {
 	__le16 timeout = cpu_to_le16(hdev->rpa_timeout);
 
-	if (!(hdev->commands[35] & 0x04))
+	if (!(hdev->commands[35] & 0x04) ||
+	    test_bit(HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT, &hdev->quirks))
 		return 0;
 
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_RPA_TIMEOUT,
 				     sizeof(timeout), &timeout,
 				     HCI_CMD_TIMEOUT);
@@ -4530,6 +4532,12 @@ static const struct {
 			 "HCI Set Event Filter command not supported."),
 	HCI_QUIRK_BROKEN(ENHANCED_SETUP_SYNC_CONN,
 			 "HCI Enhanced Setup Synchronous Connection command is "
+			  "advertised, but not supported."),
+	HCI_QUIRK_BROKEN(SET_RPA_TIMEOUT,
+			 "HCI LE Set Random Private Address Timeout command is "
+			 "advertised, but not supported."),
+	HCI_QUIRK_BROKEN(EXT_CREATE_CONN,
+			 "HCI LE Extended Create Connection command is "
 			 "advertised, but not supported.")
 };
 
@@ -6067,7 +6075,8 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
 	if (err)
 		goto done;
 
-	if (use_ext_conn(hdev)) {
+	if (use_ext_conn(hdev) &&
+	    !test_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, &hdev->quirks)) {
 		err = hci_le_ext_create_conn_sync(hdev, conn, own_addr_type);
 		goto done;
 	}
-- 
2.39.2

