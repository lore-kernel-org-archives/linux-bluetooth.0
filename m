Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1862C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Mar 2022 17:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiCaRwF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Mar 2022 13:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiCaRwE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Mar 2022 13:52:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 878BD1BD98C
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Mar 2022 10:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648749014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JSuJ0KGHWnjDqGOnTVD3EjCwphEFh8GGq1J9g6xgbWs=;
        b=g8In2cES9QyiHx9jzhPy2Dkd5Mtm3vXSdUiXfgUu7SDcOLP59V9K9RhU+QXeavpCGPu54R
        dEiQXbsUynGEJkEGktX5lmNSeAaXOek/6cACIc5LLiFwKU4lZFDBh0OzI4B6VQMKhwaCys
        5uXHc4Y9mU3VDgJCTW54X5rHFQcPGa0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-rvQfUVlROHOJZ-Ln95haHA-1; Thu, 31 Mar 2022 13:50:13 -0400
X-MC-Unique: rvQfUVlROHOJZ-Ln95haHA-1
Received: by mail-qk1-f199.google.com with SMTP id 207-20020a3706d8000000b0067b322bef9eso124088qkg.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Mar 2022 10:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JSuJ0KGHWnjDqGOnTVD3EjCwphEFh8GGq1J9g6xgbWs=;
        b=ZvbGjEbfO/0HLyeotNrToPjco56PirKZnIdNcs7/M6wJhyGPfeeoQPKhyF0aYV8L/x
         ozDSYjAzeSiFYKRw0NcFYOAvQg/iptc7pOriwsYN+vWbRIAPadHtyYPXf85FoM/AUCTz
         MBjH7aipiH/VET2c+T4D588QYJMal8ksnlYhQM9YlP8+BP0ZSLuftd0hPxK9ZyVXfDIG
         Fy7ApKdkOOHp4FqfYcmciEZKFX9QuZ0JE6oc0uez4nfYqx4BscEINKRcXaZSZkC7YcrT
         M41eIuintKuKiSTNwCSi9ZzPXgaaBYrQZzyOHj6BENEkXvYVqOOGBGnFudUVexAnYzy3
         lylg==
X-Gm-Message-State: AOAM532P/BsK+n47GqkSmPagolPE21uJZyT44+MpdDEUAAXc2yfgNP9e
        b/pmRvU1C07kZXAa3EFpNeXX8uDiEeumX+7unF+KFXAynYdtyqBC3FB8VicyqEvjVaWtQXAkpSf
        +Rwkqh7hzHRKLd0RG9NytINgCYue3
X-Received: by 2002:a37:410:0:b0:67d:ddd4:77d0 with SMTP id 16-20020a370410000000b0067dddd477d0mr4212814qke.620.1648749012214;
        Thu, 31 Mar 2022 10:50:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfbbQOxw08ZVlf+kgoUIlOJW7iE3h9Xol0V3vdyuqUNuuDJbnMAtg+wW27qkKe+0gSNQo08Q==
X-Received: by 2002:a37:410:0:b0:67d:ddd4:77d0 with SMTP id 16-20020a370410000000b0067dddd477d0mr4212803qke.620.1648749011992;
        Thu, 31 Mar 2022 10:50:11 -0700 (PDT)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id j12-20020ae9c20c000000b0067ec380b320sm13296341qkg.64.2022.03.31.10.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 10:50:11 -0700 (PDT)
From:   trix@redhat.com
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] Bluetooth: btintel: fix btintel_download_firmware stub signature
Date:   Thu, 31 Mar 2022 10:49:59 -0700
Message-Id: <20220331174959.3421978-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tom Rix <trix@redhat.com>

cppcheck returns this warning
btintel.c:1059]: (warning) Function 'btintel_download_firmware'
  argument order different: declaration
  'dev, fw, boot_param, ' definition 'hdev, ver, fw, boot_param'

By inspection, the stub version is missing
'struct intel_version *ver', so add it.

Fixes: ac0565462e33 ("Bluetooth: btintel: Check firmware version before download")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/bluetooth/btintel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index e0060e58573c..66902866a5c1 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -281,6 +281,7 @@ static inline int btintel_read_boot_params(struct hci_dev *hdev,
 }
 
 static inline int btintel_download_firmware(struct hci_dev *dev,
+					    struct intel_version *ver,
 					    const struct firmware *fw,
 					    u32 *boot_param)
 {
-- 
2.26.3

