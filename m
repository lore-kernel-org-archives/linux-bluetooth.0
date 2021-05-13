Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C993EC433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 23:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A88946143F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 23:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhEMXFi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 May 2021 19:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhEMXFf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 May 2021 19:05:35 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E55EC061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 May 2021 16:04:25 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id v191so23012880pfc.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 May 2021 16:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p16yRm3d4nfAphOhcY+FIH7RlIvQ9SGU1iJ2cb9RupY=;
        b=Hjtgyk8AOkIml5W8Z7gOEZZmDgdJuBTdk+pW2ilXGCUmDfP9q+qanUQSA3O1ws99Aw
         dtzUT8bACZSN9A11fZnKpv7MN7Zx3FtQyvXOSLlwhHPaCtC0/95T+YaEQH5OZd5POZAC
         8NxYajSwSpU878egd0LrNxkJDIYQDv/FmgQynpsP+gRIzxEVOqnJf49T5oUhQx//5k/u
         oWhHYTXtLuGHJcIrrGzQlkTIh7JMBNot6ENj/983EHaLiOehi6jxDJoQNkqFhyn779ht
         zo+OODafZs8Qd84h/0R2RBEporkenXFuJqcNqof48HL9QlPlq0kK6INHkd2aI9VmwQh1
         IGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p16yRm3d4nfAphOhcY+FIH7RlIvQ9SGU1iJ2cb9RupY=;
        b=iE3AmDfeQmbi6de/2qEouMn5WBRKrZtLDNUdadE1zAyXFyA++Etjycv/HEElezZnuE
         3w2tHwTDv0GV7vPKjgh6mf7btkdOugLO5Dmwfk8oCNBJNgKFRxhDC5PqEssDRhElU5UO
         Cb1PVzelSWRA7Htq7h87SP5BaUjz9GMpOtwoaiDpe35b9zhL2bnmktb4JyAlZrA/+XZP
         nBOAZTTSfYsXloWr0b5VQR81jYa50lEoFuIrq6Kzhu5dFbon5R67OE5eB6YQHOyJstK1
         uf84A0txx+6ri8iWaxSl6fsqexsMflNyKYmK/dAihBjVaxIUvKiwsbvY/RDYFhD6n8dq
         ZRzA==
X-Gm-Message-State: AOAM530Pl4PTyENck6MMrjEvng97LFSNGwO2WENz2ZSRwrarDyEdlt3e
        LGifKoBFvPEbpbfL35fspjcxRLe6wCY=
X-Google-Smtp-Source: ABdhPJyKSz2+z5jVACkOWTBJOlHxTu9CpmZ3B9br+ShLc5W0I9ERSo0eUrZNvhKY3KiMMmJzJl1oEg==
X-Received: by 2002:aa7:8e85:0:b029:28f:2620:957e with SMTP id a5-20020aa78e850000b029028f2620957emr43315872pfr.40.1620947063736;
        Thu, 13 May 2021 16:04:23 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y30sm2741163pff.195.2021.05.13.16.04.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 16:04:23 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Use firmware_request_nowarn
Date:   Thu, 13 May 2021 16:04:22 -0700
Message-Id: <20210513230422.2991704-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This replaces the use of request_firmware to firmware_request_nowarn
when firmware is optional (firmware is already operational).

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7f10693eabc6..7db68f443569 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2601,7 +2601,7 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
 	}
 
 	btusb_setup_intel_newgen_get_fw_name(ver, fwname, sizeof(fwname), "sfi");
-	err = request_firmware(&fw, fwname, &hdev->dev);
+	err = firmware_request_nowarn(&fw, fwname, &hdev->dev);
 	if (err < 0) {
 		if (!test_bit(BTUSB_BOOTLOADER, &data->flags)) {
 			/* Firmware has already been loaded */
@@ -2771,7 +2771,7 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 		return -EINVAL;
 	}
 
-	err = request_firmware(&fw, fwname, &hdev->dev);
+	err = firmware_request_nowarn(&fw, fwname, &hdev->dev);
 	if (err < 0) {
 		if (!test_bit(BTUSB_BOOTLOADER, &data->flags)) {
 			/* Firmware has already been loaded */
-- 
2.30.2

