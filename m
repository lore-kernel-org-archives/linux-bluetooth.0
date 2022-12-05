Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F12CC47089
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Dec 2022 18:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbiLESj2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Dec 2022 13:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiLESjH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Dec 2022 13:39:07 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D205CE0A6
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Dec 2022 10:32:45 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c7so8851411pfc.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Dec 2022 10:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yi+4zIj3+VIBsmpXYs+CMKx8m73VsncAsRBrZMj0AZw=;
        b=AeRdQ0Qkmnqu/bGHtRAK+wq3htiH9WZqg1Q32ZA3pzLZpxz2CAuOlcLJbmn1+8zfgM
         cyfsjbIAqlFMtl9VPkvHRRARPAe7HASPWlZscQd2LdBlFCKXl1fii5RmwYNME6S6bpEG
         9pINWqhhkRC6IlKhCqqfhEU47ow/EABUg0SCUb+HqtKg+F1N7aO0E7IuQrgQ6zeT1jZQ
         xwozGbCM5rIKbNgPsfHj5Lp7PKZ1cFDgdpLBAOYS+kNo3x9xrAzYKy4KhMZz9jn1xOOH
         1ytsR6hGaqTOs7hJPSuIQ641dBFyW18J9aX9jYRdddk0jrX0llwIO9a3FgOCNW+fHsAl
         0imA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yi+4zIj3+VIBsmpXYs+CMKx8m73VsncAsRBrZMj0AZw=;
        b=G549f/Ubr/lY1fLbGoisY9Hssq0GdDudRwfPi2TUT3623npNBRU6FWwSOAWsHXy9FE
         W7qbhDgKIvKleH7j+/u6pdR1i9NSBrgkaU89rN6UINGh5XFmhphjHHKL9XL1w0Hh0IAY
         ymPz9wUcStUfGrn53gx0VVs0I2OajLMGDNf3CBqdBs7lYXppi/M6sAEqO5xPjfBGEmVy
         oKj+Wsj6uhAvJ+kQcaqaIEGSj0uUquwGfu3Opv/6s6RAr4jZ0hMt4UYHpekDdJ9dh5eD
         1QVdNMbQOLxuSF3v3wtiK+0TUREEkkV4lacTOUfX5nXE+xUXvD/1hAFSEctAxzKWanLU
         6r/Q==
X-Gm-Message-State: ANoB5pklSM/HsBXCywD+P0wXuXyZzrHN8tyPGoqyuVHbV0O9kwp/YRQW
        ECXgWJRrovO55OmG1p4/13okmMn8+B0kV2VN
X-Google-Smtp-Source: AA0mqf7K6xZWBUu/vinYKD5vupmxXLJqNz5vAXk1jTdB15iYzVqMzw2A5dU9bh3GaJFWkEYNAzgK4g==
X-Received: by 2002:a62:d10b:0:b0:575:ad52:ba94 with SMTP id z11-20020a62d10b000000b00575ad52ba94mr30157318pfg.74.1670265164805;
        Mon, 05 Dec 2022 10:32:44 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id l124-20020a622582000000b00573eb4a9a66sm10204079pfl.2.2022.12.05.10.32.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 10:32:44 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] Bluetooth: btusb: Fix existing sparce warning
Date:   Mon,  5 Dec 2022 10:32:35 -0800
Message-Id: <20221205183236.3460924-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221205183236.3460924-1-luiz.dentz@gmail.com>
References: <20221205183236.3460924-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fix the following warnings detect with make W=1 C=1:

drivers/bluetooth/btusb.c:3426:28: warning: cast to restricted __le32

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 422c878a9500..16e043166055 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3423,7 +3423,7 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
 
 	if (ver_rom & ~0xffffU) {
 		rver_rom_high = le16_to_cpu(rver->rom_version_high);
-		rver_rom = le32_to_cpu(rver_rom_high << 16 | rver_rom_low);
+		rver_rom = rver_rom_high << 16 | rver_rom_low;
 	} else {
 		rver_rom = rver_rom_low;
 	}
-- 
2.37.3

