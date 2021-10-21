Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FFCC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 15:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E2860F9F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 15:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhJUPHJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Oct 2021 11:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbhJUPHG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Oct 2021 11:07:06 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEE3C061348
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 08:04:50 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n11so618837plf.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 08:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u00txehjehy8aZv0xc4xgHOSf2UDgmCGAxD+vpPtEOk=;
        b=k2NqHK1MTNYoAqv6j+6mVuBokLsATlO1UNWnJLICuuAEnHY42mjOLqYqDP0V/T4ggJ
         hMqIb588KxLLp+yn1aolNYPz6/g8FHzVW34r82tsUu1qyEm277niWsYHXq1UTrGSth83
         ZoAy02fF1IZjEZMaqV3kqzEGb9co0lUg6Ju8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u00txehjehy8aZv0xc4xgHOSf2UDgmCGAxD+vpPtEOk=;
        b=P47YumTqHU2V95uHxtaDS+vQSd9lxCQa7OZ7YEg89AwxhdUcrn0H8kKbkgSUgBqsSX
         ihvPIdgEhyQMffEFDGyajhpbh0xGDsZm/4rO+8pI4cccWXS2jVw0uZ8Z9j3zdbGkHDpe
         y2FaVI5c40FnHfaYyOEyj+VTGprpAC741ARmXRzkedRf62lNrl73GbNu8XZfOILZphAd
         vr/z1U2Mdb9oVemf1nv/lC6egxd5PCbzWYZi8A/M3qZa0leH8qinurpaexggNzsvgGQ9
         BVsU+A3KS+FulZDaTrwJJzXnBZ8glUoSog3cdJTRchBHrg7OZcbjwbaqFJoJRRrManEo
         MobQ==
X-Gm-Message-State: AOAM530jdoFeVuE8Ck4rOkCuEKihgNiB0dv2TLtMjo7Whm/frt9WTBqY
        +crH2pwVKnrZ5Z3djwIyrvD9JfRaGuldHQ==
X-Google-Smtp-Source: ABdhPJxH9xkPNNnVgCRm8+YuKebqdOk/09jdqx1UHUqPwiBpdTvNGmo+PskYXeXUYKhNABlUhC5Nug==
X-Received: by 2002:a17:90b:1041:: with SMTP id gq1mr7132055pjb.31.1634828689478;
        Thu, 21 Oct 2021 08:04:49 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:acf2:287:fa53:43f4])
        by smtp.gmail.com with ESMTPSA id 21sm9546045pjg.57.2021.10.21.08.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:04:49 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/3] Bluetooth: btusb: enable Mediatek to support AOSP extension
Date:   Thu, 21 Oct 2021 23:04:25 +0800
Message-Id: <20211021230356.v6.3.I257ac5cfaf955d15670479efc311bbab702397f4@changeid>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
In-Reply-To: <20211021230356.v6.1.I139e71adfd3f00b88fe9edb63d013f9cd3e24506@changeid>
References: <20211021230356.v6.1.I139e71adfd3f00b88fe9edb63d013f9cd3e24506@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch enables Mediatek to support the AOSP extension.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>

---

(no changes since v5)

Changes in v5:
- Let the vendor command in aosp_do_open() to determine what
  capabilities are supported.

Changes in v4:
- Call hci_set_aosp_capable in the driver.
- This patch is added in this Series-changes 4.

 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 87b71740fad8..00311ebd7823 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3876,6 +3876,8 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->set_bdaddr = btusb_set_bdaddr_mtk;
 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
 		data->recv_acl = btusb_recv_acl_mtk;
+
+		hci_set_aosp_capable(hdev);
 	}
 
 	if (id->driver_info & BTUSB_SWAVE) {
-- 
2.33.0.1079.g6e70778dc9-goog

