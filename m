Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21E9C71153
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Aug 2023 19:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238354AbjHWTlp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Aug 2023 15:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238406AbjHWTld (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Aug 2023 15:41:33 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D76E60
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 12:41:32 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bf48546ccfso33379735ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 12:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692819691; x=1693424491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8jn8shvmvOhHziHSUEJRynmV66x4yKky7FQScDj0rQ0=;
        b=PqF7Z3uv2xGt53rFsJSXMxl521AwL6QLsFp4XcjxU55iWg+3UGq4E+FG+3ck+bn227
         eIm13OfUVBr7EWHSiDnoZ8Z90aX6gpabO1ryIhmQSRSNs6zYCekaj6PcUiodQvOIFYx6
         5R2+Vt9iRcvq7cjo1eEadg2EwSk8SAVBFhlo901KkNaIy6Lok3PCj4WuYYTYU6w4qb/C
         RjxtBGVVpN2kQsV0X7OlCXZtqC0Yskpyf9RycpJFLPiTMo9tU6wEyCc3Aczw72gs6eHx
         RFACWnJ9rXwuSBe0/f+DnE6M3rKprXRmCSSl/DDwSr3pIJ3jLPqXZoLi+J+g3ZWsNsGD
         aAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692819691; x=1693424491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8jn8shvmvOhHziHSUEJRynmV66x4yKky7FQScDj0rQ0=;
        b=U5BsQybHP7Re3eAOSL4limUDqbTaD0h2nmWnbGSAxsZ8DZ0BAod0uzLgD7aHV4YLlW
         QqsVGLnecnf/9YAaKFm5c48l+ddPuu85vynujwHQeP/Me9enjm3yiWcc5J9xPKfhXc0k
         yIErnaTpp8jh3puatM1mnY+eyuq5L1iuqJP0MQo99b0qI9zkxyosr2Rxo9XJaO3LOJRa
         jw1jetAqW1PgwE8nWXxGeQiGUUyTY6TDT1lGPEXMfgtTdu+q35BQg+wn9gTQOvpJi3rJ
         HAZqOsmxklKIGkP3UOH2L3eSXOch9zFdHeW+eGsVNqDuhZKuo3qiDaMvomAn3uJKlMGt
         dujA==
X-Gm-Message-State: AOJu0Yzksg5gMTbZJglhziSlYkYu3kFkCwICC/joT7r/Amgxmufvl6Yd
        bs7NroPG0uFUrciJXTqQcMg3craSA/Q=
X-Google-Smtp-Source: AGHT+IFf31BG122NAW6+lquVXzftI4y2JUTm7puhXbVT90XXaZiYjzQ528CN4GixG/ylXLmhBLK9GA==
X-Received: by 2002:a17:902:e5c1:b0:1b8:9044:9ede with SMTP id u1-20020a170902e5c100b001b890449edemr14131861plf.62.1692819690704;
        Wed, 23 Aug 2023 12:41:30 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b001befe0ac506sm11275712plg.175.2023.08.23.12.41.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 12:41:29 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4] Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED
Date:   Wed, 23 Aug 2023 12:41:28 -0700
Message-ID: <20230823194128.3893244-1-luiz.dentz@gmail.com>
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

Cc: stable@vger.kernel.org # 6.4.y+
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

