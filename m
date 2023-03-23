Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60C8C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 13:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjCWN67 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 09:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjCWN6l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 09:58:41 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3012A6E3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 06:58:30 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id f17so2019413oiw.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 06:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679579909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6ibXONHpucNxyhy2Ilp3DbNlBIYpvHVq3ulmz4QUwg=;
        b=YXru3eNal+bjY5HzICfn+LACv+bH2kDFBUI1ObfT4oQ7HFqGBbmr4/jQPFFTp+Ha50
         pE9LSNt6n5pcj9UA6HSj928sH59HU1hQbzWco5wJN2gRx/uIvukBNbgjBqQHggi7/AmO
         JPRftSBz9CI2DDg38uXSEvdUEK0Bv+KvcMqVl8iJGVfv5dov/7r+2vDGxMgomtKLC40I
         cdTNtOD3UslSte8u6qNTyo+RE7eX3zw7/N41tZCVDu4MNAbyBW6WZcIAc4WCD72Zwkiy
         NdB1mW6FHBfjFMXbOYKocpaboaoe6L1XzcWvg+Y2WWhDIdNFQtOV67O5PP59+mmV7uzy
         3w9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679579909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6ibXONHpucNxyhy2Ilp3DbNlBIYpvHVq3ulmz4QUwg=;
        b=HsyGTLmCTHyR/d41HUul7lBzIfA2TeXP4de/SwRhS7rreCnJMWF93cEOuflZsyozG2
         NgcbQRKOAaw41d8AF1UEXKizhviPOlR2BsQt7ri76LP4NqxMquXrxcYjSVDKnNEawC0D
         vHGBQZV/bvkwNf1U/nPiCQJZ7xEgH21Z7gmNQqcaf5H/+AjCEQMaW+PdWA5X2O0IskZo
         t9H7F9xW3XA3X8cBitxZsaFVuLkXtd5F2FF7t95a24p0Ajhbf9V8+hqzaRhJH20uqUOP
         2Z/xL+EuStFQvbiFj7WGzFFDz6jazRcBrDx3ubWsLvatxwNNgc/kZ4TNPdzWwGekYluW
         DvVw==
X-Gm-Message-State: AO0yUKWrHdSRvNc+n8lTQJOIm9dofPee8DrcK8gEmgfet4uZNVrfSZ8R
        Ai9ZamOW2AfaMfbEcSppdEzy/nSQMYHK5chu
X-Google-Smtp-Source: AK7set/B6cdm8ZR4a9Yh+RDA3iiIaI+CtqQkbij1GTngf0M8PLEHolPURnj2NpKzpL8KmbGWtaT37Q==
X-Received: by 2002:a05:6808:250:b0:387:1dee:823e with SMTP id m16-20020a056808025000b003871dee823emr2874539oie.54.1679579909370;
        Thu, 23 Mar 2023 06:58:29 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:f429:2d04:9d9f:c9a0:8ef:bc50])
        by smtp.gmail.com with ESMTPSA id 4-20020a4a1704000000b00524faf3d2d7sm7247968ooe.41.2023.03.23.06.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 06:58:29 -0700 (PDT)
From:   Raul Cheleguini <raul.cheleguini@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Raul Cheleguini <raul.cheleguini@gmail.com>
Subject: [PATCH] Bluetooth: Add new quirk for broken extended create connection for ATS2851
Date:   Thu, 23 Mar 2023 10:58:04 -0300
Message-Id: <20230323135804.3962783-1-raul.cheleguini@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The ATS2851 based controller advertises support for command "LE Extended
Create Connection" but does not actually implement it, impeding the
pairing process to begin.

Add the quirk HCI_QUIRK_BROKEN_EXT_CREATE_CONN to avoid the broken command
and send a regular "LE Create Connection" instead.

< HCI Command: LE Extended Create Conn.. (0x08|0x0043) plen 26
        Filter policy: Accept list is not used (0x00)
        Own address type: Public (0x00)
        Peer address type: Random (0x01)
        Peer address: DD:5E:B9:FE:49:3D (Static)
        Initiating PHYs: 0x01
        Entry 0: LE 1M
          Scan interval: 60.000 msec (0x0060)
          Scan window: 60.000 msec (0x0060)
          Min connection interval: 30.00 msec (0x0018)
          Max connection interval: 50.00 msec (0x0028)
          Connection latency: 0 (0x0000)
          Supervision timeout: 420 msec (0x002a)
          Min connection length: 0.000 msec (0x0000)
          Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4
      LE Extended Create Connection (0x08|0x0043) ncmd 1
        Status: Unknown HCI Command (0x01)

Signed-off-by: Raul Cheleguini <raul.cheleguini@gmail.com>
---
- Note that this patch depends on the RPA timeout quirk sent via [1].
  [1]. https://marc.info/?l=linux-bluetooth&m=167957918920723&w=2
  
 drivers/bluetooth/btusb.c        | 1 +
 include/net/bluetooth/hci.h      | 7 +++++++
 include/net/bluetooth/hci_core.h | 3 ++-
 net/bluetooth/hci_sync.c         | 4 ++++
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3a3a966419af..8656ac491f13 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4107,6 +4107,7 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, &hdev->quirks);
 	}
 
 	if (!reset)
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 07df96c47ef4..d5d0e44bf0b6 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -309,6 +309,13 @@ enum {
 	 * to support it.
 	 */
 	HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT,
+
+	/*
+	 * When this quirk is set, the HCI_OP_LE_EXT_CREATE_CONN command is
+	 * disabled. This is required for the Actions Semiconductor ATS2851
+	 * based controllers, which erroneously claims to support it.
+	 */
+	HCI_QUIRK_BROKEN_EXT_CREATE_CONN,
 };
 
 /* HCI device flags */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 53d3328c2b8b..952b0021dc25 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1695,7 +1695,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 			   !test_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &(dev)->quirks))
 
 /* Use ext create connection if command is supported */
-#define use_ext_conn(dev) ((dev)->commands[37] & 0x80)
+#define use_ext_conn(dev) (((dev)->commands[37] & 0x80) && \
+			   !test_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, &(dev)->quirks))
 
 /* Extended advertising support */
 #define ext_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_EXT_ADV))
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 003ec0e34fcc..d49cfd1ea418 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4534,6 +4534,9 @@ static const struct {
 			 "advertised, but not supported."),
 	HCI_QUIRK_BROKEN(SET_RPA_TIMEOUT,
 			 "HCI LE Set Random Private Address Timeout command is "
+			 "advertised, but not supported."),
+	HCI_QUIRK_BROKEN(EXT_CREATE_CONN,
+			 "HCI LE Extended Create Connection command is "
 			 "advertised, but not supported.")
 };
 
@@ -6071,6 +6074,7 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
 	if (err)
 		goto done;
 
+	/* Send command LE Extended Create Connection if supported */
 	if (use_ext_conn(hdev)) {
 		err = hci_le_ext_create_conn_sync(hdev, conn, own_addr_type);
 		goto done;
-- 
2.39.2

