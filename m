Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E9BC7618E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Apr 2023 18:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbjDZSko (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Apr 2023 14:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbjDZSkn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Apr 2023 14:40:43 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3484173C
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Apr 2023 11:40:41 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6a5f9c1200eso2947668a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Apr 2023 11:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682534441; x=1685126441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zL8eawPHCEGdqDFy/1gKXaFSyh+OEr3QsrolSnWTRmo=;
        b=TFN38/TQsztyMqmpfE8uGcXgrX8fbiY7aNc6RhDsywE44TSQNomnJbbYkSsPQzpvVd
         YJN/q5I/nsjseTzwtYAHDARnBa/KV5DZe1v+CJJ3wMU3A7u+yv0Z3FjV0KNlNqvy7EnX
         RDN3jtX6bejHtw0bpiJc419OjDjc13Ci0DDyZNlg/uwhAlpArfvK5BMKXNOqHgAKyNDh
         +z2rcomDCCXbE3ubyVP0mMYzYAbPcDCDnhyhPa4DxE9W6re497rQozAhNTYBHOPhdu2i
         gLYUVqn2K/Ee3NhT7PEo29lnQtpHcoQjuVXmBwMu8mCXNCLgJ9WHA/PpH/UuZUPGNGja
         u74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682534441; x=1685126441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zL8eawPHCEGdqDFy/1gKXaFSyh+OEr3QsrolSnWTRmo=;
        b=jO1pzQIByjvEjcOHzt9x7dVAGTgxEf94Iwh9dwe4mgV7Os7t0tmD4cJdjvaEcJ7D6w
         VRAd9VyO0iUgDAC2wBnD6BHMeJIyzkzpNCP5MmB8RvTEAs380oOvL1107iPm6U/qCg7k
         Vi3AnCJ/vGGW0hzJBs6TEXQFRb+IGef1AjmVfvfpbJpnTzlJOuyQrOVTAbgm7qj0zVvL
         2ZidWqcDgYqwl3Zjv8IMSkgHJZ+DNhj3BJtTizzlEblx4TkBL4ZLeNNpMXqA/po43dPA
         xtZUZKoSDtR+ZR04YVKVfLU09BOdTRhWB8Bog7A0faCgIUpAuyjd940yfzd3xweFAZrp
         9fSw==
X-Gm-Message-State: AC+VfDwXSLRatmYmbqzFo2t3yTCIRey24LGSGrr2X7N3C31k5VXiSkT4
        ucuO4CEumzIyipqr6dRcoH6Ecms+jqFvvqUz
X-Google-Smtp-Source: ACHHUZ79egC0z1TFbc/mKayBzfcmDfJym+KPZDeRKZy7KIwTZmKqVYm6RHKywjzL6VUqK4xtuxscYw==
X-Received: by 2002:a05:6808:5c3:b0:390:77fa:1fce with SMTP id d3-20020a05680805c300b0039077fa1fcemr767903oij.40.1682534440255;
        Wed, 26 Apr 2023 11:40:40 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:f429:2d04:9d9f:c9a0:8ef:bc50])
        by smtp.gmail.com with ESMTPSA id p129-20020acabf87000000b00383cc29d6b2sm6906329oif.51.2023.04.26.11.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 11:40:39 -0700 (PDT)
From:   Raul Cheleguini <raul.cheleguini@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Raul Cheleguini <raul.cheleguini@gmail.com>
Subject: [PATCH v2] Bluetooth: Fix unexpected SMP command errors for ATS2851
Date:   Wed, 26 Apr 2023 15:40:17 -0300
Message-Id: <20230426184017.2051211-1-raul.cheleguini@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix unexpected SMP 0x08 and 0x09 command errors when connecting and pairing
devices using ATS2851 based controllers.

The errors are a result of a race condition in which the host receives the
commands (without prior authorization by SMP functions) in the moment host
is sending WRITE_AUTH_PAYLOAD_TIMEOUT command.

In such a situation, a disconnect event occurs, and the device cannot
connect or pair.

To address this issue, we add a condition that skips the
WRITE_AUTH_PAYLOAD_TIMEOUT command for ATS2851, enabling the SMP
functions to prepare for commands 0x08 and 0x09 in a timely manner.

Signed-off-by: Raul Cheleguini <raul.cheleguini@gmail.com>
---
V1 -> V2: Fix typo in commit message.

- Note that this patch depends on the broken extended create connection
  quirk sent in [1].
  [1]. https://marc.info/?l=linux-bluetooth&m=168244024503639&w=2

 drivers/bluetooth/btusb.c   | 1 +
 include/net/bluetooth/hci.h | 7 +++++++
 net/bluetooth/hci_event.c   | 7 +++++++
 net/bluetooth/hci_sync.c    | 5 ++++-
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1cf104feaf85..972ca94de6de 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4374,6 +4374,7 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_WRITE_AUTH_PAYLOAD_TIMEOUT, &hdev->quirks);
 	}
 
 	if (!reset)
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index d5d0e44bf0b6..625c100a74ad 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -316,6 +316,13 @@ enum {
 	 * based controllers, which erroneously claims to support it.
 	 */
 	HCI_QUIRK_BROKEN_EXT_CREATE_CONN,
+
+	/*
+	 * When this quirk is set, the command WRITE_AUTH_PAYLOAD_TIMEOUT is
+	 * skipped. This is required for the Actions Semiconductor ATS2851
+	 * based controllers, due to a race condition in pairing process.
+	 */
+	HCI_QUIRK_BROKEN_WRITE_AUTH_PAYLOAD_TIMEOUT,
 };
 
 /* HCI device flags */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d00ef6e3fc45..2077a7c921f1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3655,6 +3655,13 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
+	/* We skip the WRITE_AUTH_PAYLOAD_TIMEOUT for ATS2851 based controllers
+	 * to avoid unexpected SMP command errors when pairing.
+	 */
+	if (test_bit(HCI_QUIRK_BROKEN_WRITE_AUTH_PAYLOAD_TIMEOUT,
+		     &hdev->quirks))
+		goto notify;
+
 	/* Set the default Authenticated Payload Timeout after
 	 * an LE Link is established. As per Core Spec v5.0, Vol 2, Part B
 	 * Section 3.3, the HCI command WRITE_AUTH_PAYLOAD_TIMEOUT should be
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 26ab4deb6d52..ecd18c611122 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4581,7 +4581,10 @@ static const struct {
 			 "advertised, but not supported."),
 	HCI_QUIRK_BROKEN(EXT_CREATE_CONN,
 			 "HCI LE Extended Create Connection command is "
-			 "advertised, but not supported.")
+			"advertised, but not supported."),
+	HCI_QUIRK_BROKEN(WRITE_AUTH_PAYLOAD_TIMEOUT,
+			 "HCI WRITE AUTH PAYLOAD TIMEOUT command leads "
+			 "to unexpected SMP errors when pairing.")
 };
 
 /* This function handles hdev setup stage:
-- 
2.39.2

