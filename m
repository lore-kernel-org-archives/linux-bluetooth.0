Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554EFEE49A5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Aug 2023 20:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjHVU1c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Aug 2023 16:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjHVU1c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Aug 2023 16:27:32 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB09CD1
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 13:27:30 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bdbbede5d4so38911105ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 13:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692736049; x=1693340849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=w9BxYTBp/Nb/mZUoojseYj7vosLTk+QGC/Sa8wJP/VA=;
        b=JqUzI0CberI5cJyzTb2iHad2fT+zBYoAQ5aznSAXjla37wc+oHnfO3A7m2WLQeb3hu
         VF0P18wOxUNC1ct4jTSjzAj3wovURkWjU6bJx8AePSOLEF9vRsBx7B7dalAubTdxibmX
         ANO7A35nwssLNDdQwsoaOfzei1C00VOcScSNSmPCX1AF0PnDS6KUL507VyYXMa1a9onW
         AwxRC11wogi2HgZQvSptL6QNNNj28JpH2oOeO39kMXWdNvHYhlYb2r+vOO7bs1pODwWi
         4UCdymrMcTMXFTmJqokER0b9oZaZsQ7oL+iKzVPvECHjV7vyqb8GJCG8f+woEkRXSHdg
         xi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692736049; x=1693340849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9BxYTBp/Nb/mZUoojseYj7vosLTk+QGC/Sa8wJP/VA=;
        b=NxylywjKYUcX/hBj3OZf0gKPAM08P+Zw/9cWaOS2U/9zUjCHDjezlTsVZTBEsncJmt
         5NIqoDZqUGOeypww9yZzClS/OOXwcbyFUYyN9x6VlDViM2KNLs+Fjzr1LfTL3goQPXKV
         nh+5jl4k16DAPVyXxAntQ2DDOgRmyPOqVUqOutvpRm36q/FTe03kpwmElpAbuGr1FQsK
         va7+rs7xVpZBpvMcDyJG2kpP29W9REkLWtauXw04J8y3exH/cKYIOcUhcwmxOKZG6msI
         83KzS8d7Kidp9QEWNVfzUNFzc6QD2mKnzUoZHAfO/z3dCZLSjzsR6KBZG3wPu6/QdC8A
         LJwA==
X-Gm-Message-State: AOJu0YzGOoHBCEn10sgD0xaD9ewFRQJGkS4IYeaE952CnGvUCUQ/Zm4A
        /v9LELYszrBCdd7O8XbX7M32hK2qtzc=
X-Google-Smtp-Source: AGHT+IGkYhDXf0d/QfsXSvSBE0LK/mX7Y1m1fISe4jjqknnWxnldXTx2IBKv7DA14U+cuMOzQy9/gA==
X-Received: by 2002:a17:902:f684:b0:1bf:205e:fe5d with SMTP id l4-20020a170902f68400b001bf205efe5dmr14119845plg.7.1692736048726;
        Tue, 22 Aug 2023 13:27:28 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id y23-20020a170902b49700b001bb9aadfb04sm9381768plr.220.2023.08.22.13.27.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 13:27:27 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED
Date:   Tue, 22 Aug 2023 13:27:26 -0700
Message-ID: <20230822202726.3757640-1-luiz.dentz@gmail.com>
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
 drivers/bluetooth/btintel.c      |  2 ++
 include/net/bluetooth/hci.h      | 10 ++++++++++
 include/net/bluetooth/hci_core.h |  4 +++-
 net/bluetooth/hci_sync.c         |  5 ++++-
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 9b239ce96fa4..3ed60b2b0340 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2776,6 +2776,8 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		case 0x11:      /* JfP */
 		case 0x12:      /* ThP */
 		case 0x13:      /* HrP */
+			set_bit(HCI_QUIRK_BROKEN_LE_CODED, &hdev->quirks);
+			fallthrough;
 		case 0x14:      /* CcP */
 			set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
 			fallthrough;
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

