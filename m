Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF69BC47089
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 May 2021 07:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD80061378
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 May 2021 07:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbhE0HVe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 May 2021 03:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbhE0HVd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 May 2021 03:21:33 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C68C061760
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 May 2021 00:20:00 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id d201-20020ae9efd20000b02902e9e9d8d9dcso2781109qkg.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 May 2021 00:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ji/2+wPlkaFbP8QsAXHaOpSxoldaomxvmpnrFt3cDwU=;
        b=c9TaXglfnDg0YRq/AddtTw+c7V7Q3sd/fG6iZ3gSZg7iYsVbOAVM07xK+TmfTVUSH3
         mzRO2avhfpJ+//yFS1oi+58VH5FtMk+mJyotllgPE419XczUCFwvsymFsblPDFelw6zj
         uS5QR/XqNsNCIDDvUPWRiDM37C4vVSUaJ/xigXx+0XeSqtPQS8eSeANys3AFQ5aWR7a8
         PeLddKwI/zUP4O4GNUxSWfIJtCxZvDrFwV/hlb/aWTR4YCvpqSfk079WxqoYR7tZi7K7
         CkjRcj1YsQnMcE83O5aez92RcqO4iOYMzxJMV2dw7N2W3mmAYPYKjfh68+n+zNzCuzKU
         jZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ji/2+wPlkaFbP8QsAXHaOpSxoldaomxvmpnrFt3cDwU=;
        b=BIQL74VI1bAkUaDkNz+cf+qAxw/XfSb2fOmkCK+jv4kEcyICzhKZVyAiMFc83p0JAa
         r4iOm3JTxZwibiqrTQiADXi9l+JSAgHHrGfT70OjMGc923Qe9F9sk37aPO7iz9wizAZD
         tnoZPeSu2YrXHQpqeYSr4/Z93pPHQ5fAt1k9fynk6zxBWkugbt20OSoadnTmCF8v9W2f
         /qyxhnJoJU3xZuKopAQonogl4K/4vZcVWbTLza6yqBW1X0vaZY6EyBsGfGTrxeHBkRnt
         hhxG9jWbEsxVyqKP8zaxdBrTnsJW0uZspt//ZGxpiDPGQx6yM5YEIJzUMN5i9aRfew8Q
         /7+g==
X-Gm-Message-State: AOAM531aPLrD4Vj4MV+5ex5a90X8x6+zv6d2v9k69gg4Jv+VOqRYElCl
        hHd1aHh8hPLwo7MeG9iK1/NxTJ2EdupnBp6pBhMzRa6/cAnNHyi+rcaGcdZreDGbUoamhPeA3uR
        Y9MdR86H4eORF68OPGSLDk4RpFRdGQfNaldRX38LyhJL45C4Uo9eN03oyEmpnoYA+GlNrrAdeIO
        XM
X-Google-Smtp-Source: ABdhPJwvbgpdjAn+uX+Nd4Q8dm80teldFYAG15JZ+xOwZ4Us5eitDjXIEuipY4Vd5tsmfvtBuSYW5G29cc88
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:3631:4fed:a968:3783])
 (user=apusaka job=sendgmr) by 2002:a0c:bf4b:: with SMTP id
 b11mr1978417qvj.11.1622099999558; Thu, 27 May 2021 00:19:59 -0700 (PDT)
Date:   Thu, 27 May 2021 15:19:54 +0800
Message-Id: <20210527151951.v2.1.I4d214bb82746fb2ed94eb1c2100dda0f63cf9a25@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v2] Bluetooth: hci_h5: Add RTL8822CS capabilities
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

RTL8822 chipset supports WBS, and this information is conveyed in
btusb.c. However, the UART driver doesn't have this information just
yet.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

---

Changes in v2:
* Add declaration for the case when CONFIG_BT_RTL is not enabled

 drivers/bluetooth/btrtl.c  | 26 ++++++++++++++++----------
 drivers/bluetooth/btrtl.h  |  7 +++++++
 drivers/bluetooth/hci_h5.c |  5 +----
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index e7fe5fb22753..988a09860c6b 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -719,17 +719,8 @@ int btrtl_download_firmware(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btrtl_download_firmware);
 
-int btrtl_setup_realtek(struct hci_dev *hdev)
+void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 {
-	struct btrtl_device_info *btrtl_dev;
-	int ret;
-
-	btrtl_dev = btrtl_initialize(hdev, NULL);
-	if (IS_ERR(btrtl_dev))
-		return PTR_ERR(btrtl_dev);
-
-	ret = btrtl_download_firmware(hdev, btrtl_dev);
-
 	/* Enable controller to do both LE scan and BR/EDR inquiry
 	 * simultaneously.
 	 */
@@ -750,6 +741,21 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 		rtl_dev_dbg(hdev, "WBS supported not enabled.");
 		break;
 	}
+}
+EXPORT_SYMBOL_GPL(btrtl_set_quirks);
+
+int btrtl_setup_realtek(struct hci_dev *hdev)
+{
+	struct btrtl_device_info *btrtl_dev;
+	int ret;
+
+	btrtl_dev = btrtl_initialize(hdev, NULL);
+	if (IS_ERR(btrtl_dev))
+		return PTR_ERR(btrtl_dev);
+
+	ret = btrtl_download_firmware(hdev, btrtl_dev);
+
+	btrtl_set_quirks(hdev, btrtl_dev);
 
 	btrtl_free(btrtl_dev);
 	return ret;
diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
index 2a582682136d..2c441bda390a 100644
--- a/drivers/bluetooth/btrtl.h
+++ b/drivers/bluetooth/btrtl.h
@@ -54,6 +54,8 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 void btrtl_free(struct btrtl_device_info *btrtl_dev);
 int btrtl_download_firmware(struct hci_dev *hdev,
 			    struct btrtl_device_info *btrtl_dev);
+void btrtl_set_quirks(struct hci_dev *hdev,
+		      struct btrtl_device_info *btrtl_dev);
 int btrtl_setup_realtek(struct hci_dev *hdev);
 int btrtl_shutdown_realtek(struct hci_dev *hdev);
 int btrtl_get_uart_settings(struct hci_dev *hdev,
@@ -79,6 +81,11 @@ static inline int btrtl_download_firmware(struct hci_dev *hdev,
 	return -EOPNOTSUPP;
 }
 
+static inline void btrtl_set_quirks(struct hci_dev *hdev,
+				    struct btrtl_device_info *btrtl_dev)
+{
+}
+
 static inline int btrtl_setup_realtek(struct hci_dev *hdev)
 {
 	return -EOPNOTSUPP;
diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 27e96681d583..e0520639f4ba 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -906,10 +906,7 @@ static int h5_btrtl_setup(struct h5 *h5)
 	/* Give the device some time before the hci-core sends it a reset */
 	usleep_range(10000, 20000);
 
-	/* Enable controller to do both LE scan and BR/EDR inquiry
-	 * simultaneously.
-	 */
-	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &h5->hu->hdev->quirks);
+	btrtl_set_quirks(h5->hu->hdev, btrtl_dev);
 
 out_free:
 	btrtl_free(btrtl_dev);
-- 
2.31.1.818.g46aad6cb9e-goog

