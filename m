Return-Path: <SRS0=obUF=UX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B929C48BE8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jun 2019 06:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E8121537
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jun 2019 06:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="ZjvM1TUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfFXGYg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jun 2019 02:24:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42471 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbfFXGYf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jun 2019 02:24:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so6889223pff.9
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Jun 2019 23:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pbnnd8izcGZKojl0PAuQtOXrWbhGmDWvjwa6KZ4Vaic=;
        b=ZjvM1TUi/T4fCBeNXp+wj0GMAZG9W7FexedmAEwr1vitPQqPi7joKlwvTdV04cadzX
         N8VEemayP0VA1MPMhMCF+AFWWGCgBvqWd/PhyqPUsPbPdAe47lgAhW0+QDNOyTePWMlo
         nExvIHIOD02U8k6fMCrK/z+G3oQhZfHuCyNYNEKuotXFJsNzNiupZ3YKSBU2YzBjGiIi
         rThnJz85t8oA7Jucp6u3j+j/kq6we+WgzdHh/cQI2A2eSMZiTQBP2JYXnlMJjzo28g8S
         aXaIdl0wlQ4BeHDzYvEyFsrY1i9lpNXbbUB7Rv5UY8x8Msj1+FGGvfIYmpPNb4Fntk60
         WhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pbnnd8izcGZKojl0PAuQtOXrWbhGmDWvjwa6KZ4Vaic=;
        b=H4gzGWXzEiKagNzhqfjk107+tBKmnVwI4IG4awPq3Ke5PLfm0j+L1EZnkuSsKvfnET
         L7ufAF8Lrosv1YdLtK+4YING/ny0MonfGXGyy3U0VlDjhOGTfF5LtQg20t94R0hFCq7p
         gBS7iWVpsEXIGdLX2HX+QGsPXq2HOeuZ/m4NLvo2vdu7Av4WgyXU6sbrZ010auhZxqjx
         Wg2H2eSiDTdUeCdj4kcVKBgIZVeI/S9JNmulAoXcJumER8YAaF49PtWK0ESAvssNgHfC
         EF6qs6rvmXXHgpHrwEm5sqtPSzd2MiIeUxHeMJcBZX6yUTFuhp7JN3S1DZsUH30G5sTN
         gUAQ==
X-Gm-Message-State: APjAAAW73LZymREkSllOXrDA9MJ0xZQ9aajmeLSmpZrL3wGutC/UCz/x
        UwAyRWbX7nFcAibR6uFIhF35aQ==
X-Google-Smtp-Source: APXvYqzQQmPP8obThfTh2+jCJaqjHof51Bt4ABhyWSpN/apoVyHKuqn4uUHUbCTA38hKsdrNsLNzww==
X-Received: by 2002:a17:90a:2385:: with SMTP id g5mr23432400pje.12.1561357474818;
        Sun, 23 Jun 2019 23:24:34 -0700 (PDT)
Received: from starnight.endlessm-sf.com (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id r15sm14517333pfc.162.2019.06.23.23.24.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 23 Jun 2019 23:24:34 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Daniel Drake <drake@endlessm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH v2] Bluetooth: btrtl: HCI reset on close for Realtek BT chip
Date:   Mon, 24 Jun 2019 14:21:16 +0800
Message-Id: <20190624062114.20303-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <CAD8Lp44RP+ugBcDYkap3tUL1NSq+knGJbO9A6UAmCtcjPgxTQQ@mail.gmail.com>
References: <CAD8Lp44RP+ugBcDYkap3tUL1NSq+knGJbO9A6UAmCtcjPgxTQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Realtek RTL8822BE BT chip on ASUS X420FA cannot be turned on correctly
after on-off several times. Bluetooth daemon sets BT mode failed when
this issue happens.

bluetoothd[1576]: Failed to set mode: Failed (0x03)

If BT is tunred off, then turned on again, it works correctly again.

According to the vendor driver, the HCI_QUIRK_RESET_ON_CLOSE flag is set
during probing. So, this patch makes Realtek's BT reset on close to fix
this issue.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
v2:
 - According to the vendor driver, it makes "all" Realtek's BT reset on
   close. So, this version makes it the same.
 - Change to the new subject for all Realtek BT chips.

 drivers/bluetooth/btrtl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 208feef63de4..be6d5f7e1e44 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -630,6 +630,10 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 		return PTR_ERR(btrtl_dev);
 
 	ret = btrtl_download_firmware(hdev, btrtl_dev);
+	/* According to the vendor driver, BT must be reset on close to avoid
+	 * firmware crash since kernel v3.7.1.
+	 */
+	set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 
 	btrtl_free(btrtl_dev);
 
-- 
2.22.0

