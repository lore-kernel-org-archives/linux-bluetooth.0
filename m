Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73236EE49A5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Aug 2023 23:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjHVXXq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Aug 2023 19:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjHVXXp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Aug 2023 19:23:45 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2195CF
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 16:23:43 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a85b9deeb3so1783746b6e.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 16:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692746622; x=1693351422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yxuer+aQ9TAL5DwWUzNJ6bQJ5sTIkE9vxCL+76vr0yk=;
        b=BALQ+TzzJ3GCbXvk14urEiCJf/Rz5o83bD2Ez97a4Ffj9I3rUsr94YxcTXNKunlsSI
         4T7UzRVnfSYunH6E45MVvvNwsTcEmMdZwW/spOkXeFV/8YXFs94tVkXKb0uqpM7/9qri
         S1D2NyjFdZmcz/MkVM9nUbIKVVuKQLVteh3nDlxk4PcgXz3gN6G96a4F5lMLC6nMe/9l
         noNitgWO478zMffDUtMBvTIAtjDSGxzXHDeSxR9/FWw4JhepiTiBqgY7rwcDKfBGWodp
         DntJVLOtnv/3E0bSfs491XW506cmlvdv11i/L+bs8ZMYRyMZkjA9Zry+9dfEuh2FmgXc
         vO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692746622; x=1693351422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yxuer+aQ9TAL5DwWUzNJ6bQJ5sTIkE9vxCL+76vr0yk=;
        b=OM/gu1/rADw+GGoP/dEr303oPYfk9Sw1QXn5wIcc0oYYIaUYp3mYua4fSQCqIhw02A
         WtBzMx6ZstxnndZ96/AVy5byzdTEgUGAmdkZH1EtIgOAj1jyPpjlnPCJpLyTqI9MmrmV
         8HkcDQXvfMgSo06Y1Gv/EzmADRU90BnCKgDT6wmuYk9lWxibyCKeOxaNB2uFZ3/Y5otz
         Qo5A/If0W0B/10IsOnr/OsKDuBXM7RUeOuc1MCzRIg7EfsT25U0V+r2sDTBERHmV+E38
         9KB1ayGKoeGt/+AgccldOuL/SWIQkCUCyT7wBCgwiB3+93AEmu0IAEOHCx2zyeHCj7Nv
         YH5A==
X-Gm-Message-State: AOJu0YwzRXalyrwnb1b5yBRclwF8YubY42EgqELG5ylb8I+kmqvW+KKr
        EfHrp1Eq5bKzwTxbKMLc6qsR8Wsinwo=
X-Google-Smtp-Source: AGHT+IEIYaFMzzzHzCEMwAB1thXyejs4Tjqu5+sGKt3LDnQAO7WC07iycnOA+6bC0vL4lQCRT3z74w==
X-Received: by 2002:a05:6808:4284:b0:3a1:d1d9:d59c with SMTP id dq4-20020a056808428400b003a1d1d9d59cmr12651180oib.33.1692746622291;
        Tue, 22 Aug 2023 16:23:42 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id m10-20020aa7900a000000b00682d79199e7sm8228722pfo.200.2023.08.22.16.23.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 16:23:41 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED
Date:   Tue, 22 Aug 2023 16:23:40 -0700
Message-ID: <20230822232340.3780478-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces HCI_QUIRK_BROKEN_LE_CODED which is used to indicate
that LE Coded PHY shall not be used, it is then set for some Intel
models that claim to support it but when used causes many problems.

Link: https://github.com/bluez/bluez/issues/577
Link: https://github.com/bluez/bluez/issues/582
Link: https://lore.kernel.org/linux-bluetooth/CABBYNZKco-v7wkjHHexxQbgwwSz-S=GZ=dZKbRE1qxT1h4fFbQ@mail.gmail.com/T/#
Fixes: 288c90224eec ("Bluetooth: Enable all supported LE PHY by default")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btintel.c      |  6 ++++++
 include/net/bluetooth/hci.h      | 10 ++++++++++
 include/net/bluetooth/hci_core.h |  4 +++-
 net/bluetooth/hci_sync.c         |  5 ++++-
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 9b239ce96fa4..2462796a512a 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2787,6 +2787,9 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 			set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
 				&hdev->quirks);
 
+			/* These variants don't seem to support LE Coded PHY */
+			set_bit(HCI_QUIRK_BROKEN_LE_CODED, &hdev->quirks);
+
 			/* Setup MSFT Extension support */
 			btintel_set_msft_opcode(hdev, ver.hw_variant);
 
@@ -2858,6 +2861,9 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		 */
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
 
+		/* These variants don't seem to support LE Coded PHY */
+		set_bit(HCI_QUIRK_BROKEN_LE_CODED, &hdev->quirks);
+
 		/* Set Valid LE States quirk */
 		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
 
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c58425d4c592..87d92accc26e 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -319,6 +319,16 @@ enum {
 	 * This quirk must be set before hci_register_dev is called.
 	 */
 	HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER,
+
+	/*
+	 * When this quirk is set, LE Coded PHY shall not be used. This is
+	 * required for some Intel controllers which erroneously claim to
+	 * support it but it causes problems with extended scanning.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_BROKEN_LE_CODED,
 };
 
 /* HCI device flags */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6e2988b11f99..e6359f7346f1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1817,7 +1817,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define scan_2m(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_2M) || \
 		      ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_2M))
 
-#define le_coded_capable(dev) (((dev)->le_features[1] & HCI_LE_PHY_CODED))
+#define le_coded_capable(dev) (((dev)->le_features[1] & HCI_LE_PHY_CODED) && \
+			       !test_bit(HCI_QUIRK_BROKEN_LE_CODED, \
+					 &(dev)->quirks))
 
 #define scan_coded(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_CODED) || \
 			 ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_CODED))
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 0cb780817198..9b93653c6197 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4668,7 +4668,10 @@ static const struct {
 			 "advertised, but not supported."),
 	HCI_QUIRK_BROKEN(SET_RPA_TIMEOUT,
 			 "HCI LE Set Random Private Address Timeout command is "
-			 "advertised, but not supported.")
+			 "advertised, but not supported."),
+	HCI_QUIRK_BROKEN(LE_CODED,
+			 "HCI LE Coded PHY feature bit is set, "
+			 "but its usage is not supported.")
 };
 
 /* This function handles hdev setup stage:
-- 
2.41.0

