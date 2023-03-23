Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DEAC7619A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 13:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjCWNq2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 09:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjCWNq1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 09:46:27 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2CD29431
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 06:46:26 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id bj20so6699715oib.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 06:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679579185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eNfRV2/SFwI3VKXjRWjcBnlXjLTKauWw0nnHnGDwz7o=;
        b=qKMTUNdhMkBKvWSIi23mF3R1L9L5Lc2teF5As+ksIe4u2KmHZ6XZMro+xhqkOD4gIS
         3njl9K5MWyh88CI2e7iDEAJ2PZnJwH2q6B/UCkVLBERMq1xVnQYvpu1vHDSkIk2OI8in
         /Gu0Wzwza0xhBVAAFIJtEynObY9DXUd3h/57hWAxxBqWZYaRTlD3eYOeDpe6aQusyc6Z
         h/P4kS6hpPVna7BhWRnTG1Nj1gNtlvdASr3bR5KWqrsGeQs2yvd2nOUhQ0wK9AcAECUZ
         Y0ZZLudgECLKY0hmqEemP74pA0dynx2Zsks7wCWw6VwEdOSpmkrFlK77kSryENuzRCVu
         9nKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679579185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNfRV2/SFwI3VKXjRWjcBnlXjLTKauWw0nnHnGDwz7o=;
        b=AnMmf6XQvlog70fbHSuYkokaHW3OBOPsYM4J75yQiUpdjRx3WPlhOCdnQ73vmGWQ0G
         i4qx1y2U/yc6a7uNJCmZxcEyKZPC2u+3bu89TrMYu0jojxQo98exOGVMoTRkLHS5sqiF
         OGdCiFzauF0nafh0H4cXwIJVnfK9R+x/HyD2RF77m8OVbLrrwKxWyqPZHqnFtqIEwXii
         by19EIRrw9pRw3U5Zo/KNOg0YtD2EADfegzHjWKnclmJ5e7CfLL59/pa88sFOgpp5vm+
         tebm36qbGmLJWH89d5L1MZm0X3bbBPLlRyJxK3t1LPGQP401pum30IVWmck16kc0BCNo
         ZRgA==
X-Gm-Message-State: AO0yUKXvG34Y165TccZdwHSfIwJ/Y/VsJz1GVyib87qZw119b4PjSq95
        qDYsOq+hkMCdYSaAuZva+ku3t20Sgna9g9tr
X-Google-Smtp-Source: AK7set8rBouc4MIasueVJ9k3FUfcYxEkRmH07jEeS7NC6dBqzPOHiBzuf+RQJ3dRsnLYReCNKVuhXw==
X-Received: by 2002:aca:910:0:b0:386:bcc9:fe99 with SMTP id 16-20020aca0910000000b00386bcc9fe99mr2894703oij.5.1679579184881;
        Thu, 23 Mar 2023 06:46:24 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:f429:2d04:9d9f:c9a0:8ef:bc50])
        by smtp.gmail.com with ESMTPSA id bx32-20020a0568081b2000b0038733b00a5fsm2036459oib.10.2023.03.23.06.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 06:46:24 -0700 (PDT)
From:   Raul Cheleguini <raul.cheleguini@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Raul Cheleguini <raul.cheleguini@gmail.com>,
        imoc <wzj9912@gmail.com>
Subject: [PATCH] Bluetooth: Add new quirk for broken set random RPA timeout for ATS2851
Date:   Thu, 23 Mar 2023 10:45:39 -0300
Message-Id: <20230323134539.3957410-1-raul.cheleguini@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The ATS2851 based controller advertises support for command "LE Set Random
Private Address Timeout" but does not actually implement it, impeding the
controller initialization.

Add the quirk HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT to unblock the controller
initialization.

< HCI Command: LE Set Resolvable Private... (0x08|0x002e) plen 2
        Timeout: 900 seconds
> HCI Event: Command Status (0x0f) plen 4
      LE Set Resolvable Private Address Timeout (0x08|0x002e) ncmd 1
        Status: Unknown HCI Command (0x01)

Co-developed-by: imoc <wzj9912@gmail.com>
Signed-off-by: imoc <wzj9912@gmail.com>
Signed-off-by: Raul Cheleguini <raul.cheleguini@gmail.com>
---
 drivers/bluetooth/btusb.c   | 1 +
 include/net/bluetooth/hci.h | 8 ++++++++
 net/bluetooth/hci_sync.c    | 6 +++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7382b021f3df..3a3a966419af 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4105,6 +4105,7 @@ static int btusb_probe(struct usb_interface *intf,
 		/* Support is advertised, but not implemented */
 		set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &hdev->quirks);
 	}
 
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 997107bfc0b1..07df96c47ef4 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -301,6 +301,14 @@ enum {
 	 * don't actually support features declared there.
 	 */
 	HCI_QUIRK_BROKEN_LOCAL_EXT_FEATURES_PAGE_2,
+
+	/*
+	 * When this quirk is set, the HCI_OP_LE_SET_RPA_TIMEOUT command is
+	 * skipped during initialization. This is required for the Actions
+	 * Semiconductor ATS2851 based controllers, which erroneously claims
+	 * to support it.
+	 */
+	HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT,
 };
 
 /* HCI device flags */
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 8e5fe73873a8..003ec0e34fcc 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4090,7 +4090,8 @@ static int hci_le_set_rpa_timeout_sync(struct hci_dev *hdev)
 {
 	__le16 timeout = cpu_to_le16(hdev->rpa_timeout);
 
-	if (!(hdev->commands[35] & 0x04))
+	if (!(hdev->commands[35] & 0x04) ||
+	    test_bit(HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT, &hdev->quirks))
 		return 0;
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_RPA_TIMEOUT,
@@ -4530,6 +4531,9 @@ static const struct {
 			 "HCI Set Event Filter command not supported."),
 	HCI_QUIRK_BROKEN(ENHANCED_SETUP_SYNC_CONN,
 			 "HCI Enhanced Setup Synchronous Connection command is "
+			 "advertised, but not supported."),
+	HCI_QUIRK_BROKEN(SET_RPA_TIMEOUT,
+			 "HCI LE Set Random Private Address Timeout command is "
 			 "advertised, but not supported.")
 };
 
-- 
2.39.2

