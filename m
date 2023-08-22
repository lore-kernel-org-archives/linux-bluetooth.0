Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458DDEE4993
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Aug 2023 19:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjHVTOu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Aug 2023 15:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjHVTOt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Aug 2023 15:14:49 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686E4CED
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 12:14:48 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-34961362f67so14248855ab.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 12:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692731687; x=1693336487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=d1V1C+jXV+fsxNPrLox+oQIzkpdkp0HSaM2jWj5Scu4=;
        b=YRcOvc4qgvhjSSX30C96fVMs7ECiamJaLKgJAHZp7Vnalnda9Jn1RBdIJX6JpZ+0Mk
         Pk3q5BKE02WhCUINzOjWF9BdIlJvPMc0/9g7DAVSWWApYDl5F3hcS5humec7IQdNCHXn
         x8ElchDY/+IvC8xgjsk5dX/1AQ+joKASev94YQBonFiBY8GRmyQ+Zu/3L5kVteL4ct4h
         RsWByqSs2NqTaz+7oqV3QiG9pVP+PkmH8kV6/xuUe7ccTDxijmAktSS/4UgdbtRRyR9d
         J+rs269czzNM47nqmw+h2HlNYftHe2gkkEEuf+vTEd5MDErfNF3IpWTBMSF4CKeP01we
         42LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692731687; x=1693336487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1V1C+jXV+fsxNPrLox+oQIzkpdkp0HSaM2jWj5Scu4=;
        b=H28CcjWzDNHcLMz3XsiTt68foeIy6Hy89vCFRcX5cCRrUUjf04Hv6XxjwPSmLV/1qz
         boE9Kk59t2NXbmPvrgEz0OGM8hXAmbcnNqm30mQ6eRqEI+Hd3UCxbNp097In8NhzuQ4W
         0Y0h33ZDopZNiyIJgEKi0Cm1ghT8nyw3xuKRRt5Ly8dOknp7vZE9fjzxPMgDfht3s8rt
         v8nV1scpWmS9+oiaEHZ6I7ej9suvH449qNsLxxNdPyQ3iOmSKvFQI4aT1H975A5dZrxr
         qBIoYQx27QurEqpz25g7VYhJh0DW1I4T3EUPyxfF0OjwX+Jsd1WpJydWTWgJYNfvqs77
         UdyQ==
X-Gm-Message-State: AOJu0YwYquKrBUxM45bxe9a1zgIQUva052zx2E1vl1V2Ohj7alvGDH9z
        59RlC9mK6h+rany0Z7t4ldmUteGvWdE=
X-Google-Smtp-Source: AGHT+IG8EuG36uNuhS7CKuqeC9Ri1HGiuOWj/pkr5RQd3w3+jnUBb84EE3uze3W+hYeHl+wZ03VDtA==
X-Received: by 2002:a05:6e02:1aa8:b0:349:46fa:3844 with SMTP id l8-20020a056e021aa800b0034946fa3844mr465423ilv.3.1692731687070;
        Tue, 22 Aug 2023 12:14:47 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id h23-20020a02cd37000000b004302370a169sm3131289jaq.157.2023.08.22.12.14.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 12:14:46 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED
Date:   Tue, 22 Aug 2023 12:14:44 -0700
Message-ID: <20230822191444.3741307-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces HCI_QUIRK_BROKEN_LE_CODED is is used to indicate that
LE Coded PHY shall not be used, it is then set for some Intel models
that claims to support it but when used causes many problems.

Link: https://github.com/bluez/bluez/issues/577
Link: https://github.com/bluez/bluez/issues/582
Link: https://lore.kernel.org/linux-bluetooth/CABBYNZKco-v7wkjHHexxQbgwwSz-S=GZ=dZKbRE1qxT1h4fFbQ@mail.gmail.com/T/#
Fixes: 288c90224eec ("Bluetooth: Enable all supported LE PHY by default")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btintel.c      |  2 ++
 include/net/bluetooth/hci.h      | 10 ++++++++++
 include/net/bluetooth/hci_core.h |  4 +++-
 3 files changed, 15 insertions(+), 1 deletion(-)

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
index c58425d4c592..767921d7f5c1 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -319,6 +319,16 @@ enum {
 	 * This quirk must be set before hci_register_dev is called.
 	 */
 	HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER,
+
+	/*
+	 * When this quirk is set, LE Coded PHY is shall not be used. This is
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
-- 
2.41.0

