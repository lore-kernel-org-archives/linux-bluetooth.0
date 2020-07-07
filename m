Return-Path: <SRS0=I8IU=AS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F81C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 17:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA30A206DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 17:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fwGbCy9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgGGRaU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbgGGRaU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jul 2020 13:30:20 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F266C061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2020 10:30:20 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id n4so2360943uae.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2020 10:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xuq/cPtz4H8qHzQbgSRImu0AoYB1hM4DNGsoUIniXWY=;
        b=fwGbCy9YCvQBDRQlOQ25QRUychesGDZK3sJuyPcvSnyuyS0I22pqF4exaGQ3mQyN/r
         DayeW+opzCqR2T2qzTTTGrU7hm+4tM5zuU/EtzraZe5onxlrJGgWC5QeLPMJrVcdMSWz
         ojecYyRdTC/hSK8h0GMUZdKXilvmRHXgpiLdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xuq/cPtz4H8qHzQbgSRImu0AoYB1hM4DNGsoUIniXWY=;
        b=PVFxXWFajanDNe+c7OFG8ok9Wi1mX8KnfuOr2PkkSBbGJKD5/ZjPQYMlIXXp13PavN
         HsHFETgH2tS+ewoYY3tbCKkXecVklYEjxup3qfO12dJcQvW2+w5yrasE0iN/jZlSC4pK
         x1f6KkVcGqrcHwG1fdOuqyEGfQOv13rJRDoYce2dAy34Z9/09hqUWDGCxtDyEYpKLQjI
         HFZSH66ELEFOk2/GmpkNDSTiS/JsDK+fCPo0hZAntjN8nrzEPiKOS9mgcKZDBcSehYKv
         gG8sNLoUk+BVsbFqvSZCDQKKoOZz8cyW8S6Ful4rySZL6kSYaqMjGBYfSmQRZGHPIJZC
         AxbA==
X-Gm-Message-State: AOAM532vJa5+Ffmn9wOIuwT/XfjlynsxQEMek+BgHZtnd7dbv7QuiYME
        Vp+JiBHkluzISHaNc/8oUb2XxiIAQNo=
X-Google-Smtp-Source: ABdhPJxlFpzLk0NFQqzKJTTbvutsQGyOY1l75h8QASiigsice6dgJn/zVDMUT4sJKnZ2+a3gaMyyAA==
X-Received: by 2002:a9f:260b:: with SMTP id 11mr38745138uag.49.1594143019041;
        Tue, 07 Jul 2020 10:30:19 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id r18sm168394vkf.49.2020.07.07.10.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 10:30:18 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>,
        Chethan Tumkur Narayan 
        <chethan.tumkur.narayan@intel.corp-partner.google.com>
Subject: [PATCH v1] Bluetooth: adding BTUSB_VALID_LE_STATES to Intel Controllers
Date:   Tue,  7 Jul 2020 17:30:15 +0000
Message-Id: <20200707173015.543198-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the BTUSB_VALID_LE_STATES to the appropriate Intel
controllers.

Signed-off-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.corp-partner.google.com>

---

 drivers/bluetooth/btusb.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index faa863dd5d0a..ca387531b940 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -339,18 +339,23 @@ static const struct usb_device_id blacklist_table[] = {
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
 	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_NEW |
-						     BTUSB_WIDEBAND_SPEECH },
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_NEW |
-						     BTUSB_WIDEBAND_SPEECH },
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 	{ USB_DEVICE(0x8087, 0x0032), .driver_info = BTUSB_INTEL_NEW |
-						     BTUSB_WIDEBAND_SPEECH},
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL },
 	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_NEW |
-						     BTUSB_WIDEBAND_SPEECH },
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL |
-						     BTUSB_WIDEBAND_SPEECH },
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_NEW |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
-- 
2.27.0.212.ge8ba1cc988-goog

