Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247F4C77B78
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Apr 2023 18:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbjDZSdf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Apr 2023 14:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbjDZSdd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Apr 2023 14:33:33 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4210883E1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Apr 2023 11:33:28 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-18b0879e0c8so5484897fac.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Apr 2023 11:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682534006; x=1685126006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mZ4CftAMRUtwcmQHv5O3MpM6gGXmjx8bVjVGHNa4ZQc=;
        b=fhR2PH6rOr8vtFebk4GBA0otSpBQroino3syYeyOx/ydJE/cjbSMwfKuyxzAQDAZW+
         e/oc5cPnv43TJ0Soi+8m3T3O51ACl43SecvSp8O6CGsrjx6EB5WJ424zu9aNEhr2xbjv
         HsRkmOsc0P4K1HImDpFz5oDMgsQOTrdC6eonUbL9QqnXFQAs9iti/ZgS4mnZ+PoYMGE9
         Wgpol7kCoBJaha4fb0pLJHk978iJZGkflzT9vPtc2WuNpFDRsaNDsvNSTw30xz47Tcu7
         ckCH3GyKN4KEDGZR+PchWEo4DdJZaps13eT4naxdiR/BOE3bXXYHPSbcWKs7lJD63RPS
         HDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682534006; x=1685126006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZ4CftAMRUtwcmQHv5O3MpM6gGXmjx8bVjVGHNa4ZQc=;
        b=Vx3tf4oy7w0gfqnHErdifBj+mdf2QFglNw9tvSI8+kiTwoJ3/ofB1Y0ngtj4tb+UdZ
         fBc7ENBaj1Aw3Bc5toCUDC+c6lidIlOZaY/W4N4MeaO/SJuPmueSiqV6y8ynsfA2eCdS
         WyxiaZInh0ZSZtqmugBM2nR6OvevMcwqpQHkDeear6+vUzDwf6T3zlBpio9Fz01VhrkG
         sqTB8v0xAFn29oiNHXtViVOGgVK5UvOdyiYjPMIATfjrWzFt0UqXagvwABWHbKus/ovG
         FMRD8GcWaRbHfGFZeSfGXT3ctSzZRK86hO/DLn5S3n2lwzsBK9EoKYODfnoiZsaN+qi8
         FzzA==
X-Gm-Message-State: AAQBX9e+ji53Vx5UEFxEg0uDRcKt8nzmsAsdcWcSSQiSw1MjMb5XAgjp
        x6+kZYLiNRq4Ft80beuMD+xGd60h0KE3gyK4
X-Google-Smtp-Source: AKy350ZgbKpNjL/YV6/iLyl6Qn0/WE+kQixt3K6T8MY6FSfGEzVkYvwxVErtA0pHgyE6PAmGZwBZ5g==
X-Received: by 2002:a05:6870:b390:b0:18b:1c64:2d33 with SMTP id w16-20020a056870b39000b0018b1c642d33mr13318086oap.36.1682534005986;
        Wed, 26 Apr 2023 11:33:25 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:f429:2d04:9d9f:c9a0:8ef:bc50])
        by smtp.gmail.com with ESMTPSA id 124-20020a4a1d82000000b00541854d066bsm7442308oog.10.2023.04.26.11.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 11:33:25 -0700 (PDT)
From:   Raul Cheleguini <raul.cheleguini@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Raul Cheleguini <raul.cheleguini@gmail.com>
Subject: [PATCH] Bluetooth: Fix unexpected SMP command errors for ATS2851
Date:   Wed, 26 Apr 2023 15:33:06 -0300
Message-Id: <20230426183306.2048251-1-raul.cheleguini@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix unexpected SMP 0x08 and 0x09 command errors when connecting and pairing
devices using ATS2851 based constrollers.

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

