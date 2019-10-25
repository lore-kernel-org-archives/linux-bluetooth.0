Return-Path: <SRS0=fFFM=YS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C582BCA9EA0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Oct 2019 21:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982BB21D7F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Oct 2019 21:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WtyuwJU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfJYVzU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Oct 2019 17:55:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44846 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfJYVzT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Oct 2019 17:55:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id e10so2386505pgd.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2019 14:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rlkBYIHdHiVm55Kah/lon2P3jb1WVYe4P1U5EBDi8UE=;
        b=WtyuwJU37CEXNLKUYTQmqtjGqQNWSVHolhJo6zruKL4mwtV7c8XonHyh3QPksZ1H59
         wE3VYrgCZH3p2L1G9ZXpwqmbdQl1CAHBEf+aCagB+wqdgnIUviwwDy5k4xixtjHLh6qV
         L/U1DWaQ6XgCl0qsaz5ZTBEUFsYZDPiXEkQJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rlkBYIHdHiVm55Kah/lon2P3jb1WVYe4P1U5EBDi8UE=;
        b=gkjWH+3lCXoNRWjiE1NRDaocSSTf1/YY1X9GfZ6ZQUVohxZAs461xu7Sy9a2A30yn2
         xNUnBynBuAgzn+M/Up7FQsVttQiLf6Sy4RU8BC0Lfslgn/83I51ztZSoiPgrts0JhZMj
         JlhtPhDDgAsrrVRmE/ORpd41YAKI6DApay84560Wf3//caZZgIL9ErlCPBDVjogeQKNB
         fAzMEq07+HmfilEQQ0UN4WQOKirKJMPRFufHfVlSgxJuhHiK3YnBNLEvvNMLKhEmYaal
         Hqy/Mq7yxV/eEuVnXxksax3nIXr989adDoCxyj5wl195t+tE5h/QslgGJLdyA2r7hkAd
         J8vw==
X-Gm-Message-State: APjAAAU7U6QvKrBpdsg0zkQWFX18lv7nfrQTWawlkKeunGbRRClgLgwU
        zC3Ly9viEwZWAl75JIGRC/bTpw==
X-Google-Smtp-Source: APXvYqwoTkjLyPk77v5CePu0/mRgUiE+4yRmhCDS53t3VEv9gmWbZnkrtyZKKSrzJT0mhgbVHf9qVA==
X-Received: by 2002:a63:794b:: with SMTP id u72mr6995020pgc.320.1572040518901;
        Fri, 25 Oct 2019 14:55:18 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id y80sm3815110pfc.30.2019.10.25.14.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 14:55:18 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org, dianders@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: hci_bcm: Add compatible string for BCM43540
Date:   Fri, 25 Oct 2019 14:54:26 -0700
Message-Id: <20191025215428.31607-2-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191025215428.31607-1-abhishekpandit@chromium.org>
References: <20191025215428.31607-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The BCM43540 chip is a 802.11 a/b/g/n/ac + Bluetooth 4.1 combo module.
This patch adds a compatible string match to the serdev driver for the
Bluetooth part of the chip.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 drivers/bluetooth/hci_bcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 0f73f6a686cb..0f851c0dde7f 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1424,6 +1424,7 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
 	{ .compatible = "brcm,bcm4345c5" },
 	{ .compatible = "brcm,bcm4330-bt" },
 	{ .compatible = "brcm,bcm43438-bt" },
+	{ .compatible = "brcm,bcm43540-bt" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);
-- 
2.24.0.rc0.303.g954a862665-goog

