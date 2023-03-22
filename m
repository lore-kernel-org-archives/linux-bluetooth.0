Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA6AC6FD20
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Mar 2023 01:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjCVBY7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Mar 2023 21:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCVBY6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Mar 2023 21:24:58 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3B82ED7D
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Mar 2023 18:24:55 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-177ca271cb8so18108181fac.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Mar 2023 18:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679448294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A5mRzC1oaEoURX9oqC9E9PPrelrNozeaQf2hz8mffQo=;
        b=UO71itZPzxkF6pf+VzYbAaawCQpLPEIAobGbxhC1U+VmHaZYs87OcfhEpQrbIuvK83
         PJN2tjHQtjSe9KSxVndJpMYhtye9Jq99ypdzdHn+R2gPSrxEaV90nVR7zJxV3ciXXD4O
         FRDj3Sryz98cf5W60CeaaRIkMmlvmzAU7CVb/rhJ+lhjK/gkjK2hAWG5HNqnLEHTbGwr
         JrYU+UIihx5ObGho3zvIqYyOwpmLq7zHLbnKhk6Q5HCPJk5xNn5H71MulThcm6m3p4sh
         pYpvnqJG3uIulF3KosOAqA5KnQYs9jirQAExn9vmEaHYeFSL9N/HXpQ27ByMvx7uIzAS
         F6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679448294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A5mRzC1oaEoURX9oqC9E9PPrelrNozeaQf2hz8mffQo=;
        b=3d2va3AUrL4l2fhNKWOpZE82VMELOhfceCBWjrPms+jNlJyMj5lvX4YMSRjX3qAvUP
         Gnk5OpmkVTTx1WAW3TkDgmJ5QORX0KcKJnhW6xHHqRZFb4jFU/XBbWosLP2XUfdomcZ8
         sz4KDa6ugB7UC6yZbBCQp7ydYJj8WziLAuFa2Xg+PWcsB9HfIY1fjiBI+m/d1XSOy4mR
         vHOglJyAVIbff2w3E9LoE5haSXCb2yNfA8x5zfeK4TRjVJGirGvgJOa6rJUiHbf8Qxxi
         HnIt8renMMeM6HxSMwR6O8yy+LbaYQa2E4luBVEEMYjor7sqTUqnaSy8eVu1Q2MdE9RS
         KcEw==
X-Gm-Message-State: AO0yUKUjdJ4sc2Xf0+6zaAeuEBASov26k8IjnrDXY9tQ6pIa6Q+z9BH/
        6HSNofzoKPOQ8npJ3IvfDH1LNxGyK7RzR41S
X-Google-Smtp-Source: AK7set+qSciJctd9KjKQK4x7zmXyqdoREjM4bhvF+wOBnW9SFQLAv0DQsxkF5xJB3aQlgXT09ZdJIw==
X-Received: by 2002:a05:6870:c387:b0:17a:ff84:5972 with SMTP id g7-20020a056870c38700b0017aff845972mr298979oao.12.1679448294673;
        Tue, 21 Mar 2023 18:24:54 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:f429:2d04:9d9f:c9a0:8ef:bc50])
        by smtp.gmail.com with ESMTPSA id yy48-20020a05687125b000b001728669a604sm2432738oab.5.2023.03.21.18.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 18:24:54 -0700 (PDT)
From:   Raul Cheleguini <raul.cheleguini@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Raul Cheleguini <raul.cheleguini@gmail.com>
Subject: [PATCH v2] Bluetooth: Partial support for Actions Semi ATS2851 based devices
Date:   Tue, 21 Mar 2023 22:24:28 -0300
Message-Id: <20230322012428.2662664-1-raul.cheleguini@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The ATS2851 advertises support for commands "Set Random Private Address
Timeout" and "Extended Create Connection" but does not actually implement
them and reply with unknown HCI command.

The failed first command blocks the device initialization, and the failed
second command blocks the start of the pairing process.

Add these two quirks to unblock the device initialization and to skip
the extended create connection command when start pairing.

v2: Move the extended create connection quirk to use_ext_conn, edit commit
description and add btmon logs.

< HCI Command: LE Set Resolvable Private... (0x08|0x002e) plen 2
        Timeout: 900 seconds
> HCI Event: Command Status (0x0f) plen 4
      LE Set Resolvable Private Address Timeout (0x08|0x002e) ncmd 1
        Status: Unknown HCI Command (0x01)

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
 drivers/bluetooth/btusb.c        |  2 ++
 include/net/bluetooth/hci.h      | 14 ++++++++++++++
 include/net/bluetooth/hci_core.h |  3 ++-
 net/bluetooth/hci_sync.c         | 10 +++++++++-
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7382b021f3df..8656ac491f13 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4105,7 +4105,9 @@ static int btusb_probe(struct usb_interface *intf,
 		/* Support is advertised, but not implemented */
 		set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &hdev->quirks);
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
index 8e5fe73873a8..d49cfd1ea418 100644
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
@@ -4530,6 +4531,12 @@ static const struct {
 			 "HCI Set Event Filter command not supported."),
 	HCI_QUIRK_BROKEN(ENHANCED_SETUP_SYNC_CONN,
 			 "HCI Enhanced Setup Synchronous Connection command is "
+			 "advertised, but not supported."),
+	HCI_QUIRK_BROKEN(SET_RPA_TIMEOUT,
+			 "HCI LE Set Random Private Address Timeout command is "
+			 "advertised, but not supported."),
+	HCI_QUIRK_BROKEN(EXT_CREATE_CONN,
+			 "HCI LE Extended Create Connection command is "
 			 "advertised, but not supported.")
 };
 
@@ -6067,6 +6074,7 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
 	if (err)
 		goto done;
 
+	/* Send command LE Extended Create Connection if supported */
 	if (use_ext_conn(hdev)) {
 		err = hci_le_ext_create_conn_sync(hdev, conn, own_addr_type);
 		goto done;
-- 
2.39.2

