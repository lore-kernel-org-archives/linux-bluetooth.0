Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B2DC433E6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 17:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA31B64F10
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 17:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhCORkZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Mar 2021 13:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbhCORkI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Mar 2021 13:40:08 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA51C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 10:40:08 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so15192900pjb.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 10:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qo5BSmyDTaf4kb4mmoZcVtc+iaD/03F1FmyxpnovCtY=;
        b=SKKAusPkNp1vWtgZt4yYdWDx6KfBC2FuzaG/4bWCtc+rj4vbR/1sea+LooqM3FXqno
         EklIA2W2RsBVRPuZNLCCWy0897Q4Q9ylxwkDJvdVf8Qdr65V0r9BwbDr0bV5DHFOo0Eg
         z/qT6yBv5SQATbiwQZOEAzdS/JdLM14Ga2OAm1mPN7Pn60yZgBGV27yFEqN5NLjVnjHg
         KhELWcqoOVf13fxuGIvqDqxxxa6DVqxw/s8ilwZX5IP+Ergo6rXoorYPtgT1GgbDqGpU
         OUsKfOatafYD9sE9OVhim1TmZ9cIUbdlrGTcmkCzQ9G886RjdwkvPRZzj3e5zq9+6t89
         O45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qo5BSmyDTaf4kb4mmoZcVtc+iaD/03F1FmyxpnovCtY=;
        b=DBcsEAaYTApcdlRmk+5pwU+khA5l/V/k/B94wO3KjkfT4rLSsqXencAVro7NxIPHv6
         7kaa6KdDcKzG2ufC+cuLy8RTP2hkdTEIBjKfk1U7UEDFGE7hozFhA2NMM+0j8Q8DZ+NA
         9TQyHTVouvzxLNa+gmbBl8ThT0LEnykmLiy0/HqslwsSs+xFLzC2VhAXkAzmopvbw+5f
         4Tq5y6OReQmv38nyIHngIOWkI3qvItLyT2vcRlWeh2G8nh9XwUXbTj3t26AkTACPR9ue
         2pQpkmHWpDnNAs2bq9FsGbgOJlppOK8LGkrwkDmhL3prI+FrWR8EHS9KUUwtWGZfvkrA
         8dhQ==
X-Gm-Message-State: AOAM533SPNSl5CedejYedc4Vp89sstcw9iH+6wM6vr27rsDH2Hw+O3vR
        E5b8JU9khcsvQ5zVCgv7LKBQhexqnDmG5g==
X-Google-Smtp-Source: ABdhPJxfXl3HEvOL6U5p1Lf6dZiaaXGNLJ2F5O8wkoqfr9QildrZZFJbJrwG9gUY04O6rQwFZkF+Rw==
X-Received: by 2002:a17:902:74c4:b029:e4:9e16:18d9 with SMTP id f4-20020a17090274c4b02900e49e1618d9mr12912415plt.21.1615830007609;
        Mon, 15 Mar 2021 10:40:07 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id fa21sm246914pjb.25.2021.03.15.10.40.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 10:40:07 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v9 4/9] Bluetooth: btintel: Consolidate intel_version parsing
Date:   Mon, 15 Mar 2021 10:39:57 -0700
Message-Id: <20210315174002.1778447-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315174002.1778447-1-luiz.dentz@gmail.com>
References: <20210315174002.1778447-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves version checks of intel_version() to btintel_version_info().

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btintel.c | 36 ++++++++++++++++++++++++++++++++++--
 drivers/bluetooth/btintel.h |  2 +-
 drivers/bluetooth/btusb.c   | 12 ++++--------
 3 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index bb2546c4374a..bddaa4f32566 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -216,10 +216,39 @@ void btintel_hw_error(struct hci_dev *hdev, u8 code)
 }
 EXPORT_SYMBOL_GPL(btintel_hw_error);
 
-void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
+int btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
 {
 	const char *variant;
 
+	/* The hardware platform number has a fixed value of 0x37 and
+	 * for now only accept this single value.
+	 */
+	if (ver->hw_platform != 0x37) {
+		bt_dev_err(hdev, "Unsupported Intel hardware platform (%u)",
+			   ver->hw_platform);
+		return -EINVAL;
+	}
+
+	/* Check for supported iBT hardware variants of this firmware
+	 * loading method.
+	 *
+	 * This check has been put in place to ensure correct forward
+	 * compatibility options when newer hardware variants come along.
+	 */
+	switch (ver->hw_variant) {
+	case 0x0b:      /* SfP */
+	case 0x0c:      /* WsP */
+	case 0x11:      /* JfP */
+	case 0x12:      /* ThP */
+	case 0x13:      /* HrP */
+	case 0x14:      /* CcP */
+		break;
+	default:
+		bt_dev_err(hdev, "Unsupported Intel hardware variant (%u)",
+			   ver->hw_variant);
+		return -EINVAL;
+	}
+
 	switch (ver->fw_variant) {
 	case 0x06:
 		variant = "Bootloader";
@@ -228,13 +257,16 @@ void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
 		variant = "Firmware";
 		break;
 	default:
-		return;
+		bt_dev_err(hdev, "Unsupported firmware variant(%02x)", ver->fw_variant);
+		return -EINVAL;
 	}
 
 	bt_dev_info(hdev, "%s revision %u.%u build %u week %u %u",
 		    variant, ver->fw_revision >> 4, ver->fw_revision & 0x0f,
 		    ver->fw_build_num, ver->fw_build_ww,
 		    2000 + ver->fw_build_yy);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(btintel_version_info);
 
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 94a63e898826..7163170410a8 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -148,7 +148,7 @@ int btintel_set_diag(struct hci_dev *hdev, bool enable);
 int btintel_set_diag_mfg(struct hci_dev *hdev, bool enable);
 void btintel_hw_error(struct hci_dev *hdev, u8 code);
 
-void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver);
+int btintel_version_info(struct hci_dev *hdev, struct intel_version *ver);
 int btintel_version_info_tlv(struct hci_dev *hdev, struct intel_version_tlv *version);
 int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type, u32 plen,
 			const void *param);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2a1926552a50..dfc743e8fdf4 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2465,12 +2465,6 @@ static int btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
 					     char *fw_name, size_t len,
 					     const char *suffix)
 {
-	/* The hardware platform number has a fixed value of 0x37 and
-	 * for now only accept this single value.
-	 */
-	if (ver->hw_platform != 0x37)
-		return -EINVAL;
-
 	switch (ver->hw_variant) {
 	case 0x0b:	/* SfP */
 	case 0x0c:	/* WsP */
@@ -2640,8 +2634,6 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 	if (!ver || !params)
 		return -EINVAL;
 
-	btintel_version_info(hdev, ver);
-
 	/* The firmware variant determines if the device is in bootloader
 	 * mode or is running operational firmware. The value 0x06 identifies
 	 * the bootloader and the value 0x23 identifies the operational
@@ -2834,6 +2826,10 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 		return err;
 	}
 
+	err = btintel_version_info(hdev, &ver);
+	if (err)
+		return err;
+
 	err = btusb_intel_download_firmware(hdev, &ver, &params, &boot_param);
 	if (err)
 		return err;
-- 
2.30.2

