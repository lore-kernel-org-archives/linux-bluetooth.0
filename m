Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26727C6FD18
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Apr 2023 16:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbjDYQbq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Apr 2023 12:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbjDYQbp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Apr 2023 12:31:45 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7173D9022
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 09:31:44 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-187ec6a5504so4559994fac.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 09:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682440303; x=1685032303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XmXqyd0W5cmoGgju/nu079tCrUcRnNOWtvPWPXTiENA=;
        b=dpCpAF5vR5wD9AgOzwe0yDdsZXoTdmYuiKw8OrPR6D9SCUprUOxJzO+iGgflp7brUu
         +y18d/GvpXCah8HXBaH2opUHe/vvq2Fdz3G/ZwnAardzLn1th42tAdbU8isnf7l45W/c
         awDdlJhJ8LsNzet415M+TARJx51gw2lo+Tj4P5kuDjGdCOoYPkLDce36flWQ0Pf8C9QL
         VBzsAl4BadZ49os1EQT44JNq+u7EYo7tZ6Nmrz1DLTFYwcIBaUn0ECr72Z6Y+MM2BMd5
         RuKUuojwmPoe2VsUE1WiobsejyYocFA67hk4PzTmNCoXsILmR9k9jNYwfkx8wl4WY+VQ
         W8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682440303; x=1685032303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XmXqyd0W5cmoGgju/nu079tCrUcRnNOWtvPWPXTiENA=;
        b=bhb1LMfT3qjDzG3EV/P0oE3k3nTXuzkBlYnLA6pfraljddSDBjlqkIZYmg8VR4Vx55
         T5b15CKub99exicnQoTv0W+s7Y9cMHuAkJkDIC02bNgQKEuGOdw91HK8rdtnR401ET8l
         i/Ih7tJ1G6aeumycC7fDtdZKpXVR3vTgsaWcf8DTi57s3NQ0c53NAFHnoa9DT2wtkn+Q
         gpPn0wUX+7kii7a0Hk8bHiQQX2AE9QLtAdpf7q5q3jcHJimI39GZB0qT/s5uaA+ItFVf
         WXvZ9MLQXClqINUNvghhGh4bgfv8b8mWiUiIoiXSfiKnyc3aBfmbs+FfpzQq5V9rlFbP
         V9gQ==
X-Gm-Message-State: AAQBX9dZNwEa66Oib6N8al/SadwwOfPl3VezYiOBkFApWz3juL4nDzrU
        P7rj9C2pwQ5wQSNFK5pjjIg+RfJYtOk0Txzz
X-Google-Smtp-Source: AKy350bsU/qa4vMTC4nrWiLwbyCQLEdJvs7ksXxHF2ja1B0p1upchh44IloamOz06VBMRXv+5PtW3g==
X-Received: by 2002:a05:6870:ac27:b0:177:cbb6:ba2 with SMTP id kw39-20020a056870ac2700b00177cbb60ba2mr12136714oab.53.1682440303502;
        Tue, 25 Apr 2023 09:31:43 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:f429:2d04:9d9f:c9a0:8ef:bc50])
        by smtp.gmail.com with ESMTPSA id v6-20020a056870e28600b0017e0c13b29asm5709200oad.36.2023.04.25.09.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 09:31:43 -0700 (PDT)
From:   Raul Cheleguini <raul.cheleguini@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Raul Cheleguini <raul.cheleguini@gmail.com>
Subject: [PATCH v2] Bluetooth: Add new quirk for broken extended create connection for ATS2851
Date:   Tue, 25 Apr 2023 13:31:20 -0300
Message-Id: <20230425163120.1059724-1-raul.cheleguini@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The controller based on ATS2851 advertises support for the "LE Extended
Create Connection" command, but it does not actually implement it. This
issue is blocking the pairing process from beginning.

To resolve this, add the quirk HCI_QUIRK_BROKEN_EXT_CREATE_CONN.
This will avoid the unsupported command and instead send a regular "LE
Create Connection" command.

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
V1 -> V2: Grammar fix in commit message.

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

