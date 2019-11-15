Return-Path: <SRS0=BO69=ZH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A23C432C3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Nov 2019 16:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8626C2072D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Nov 2019 16:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbOi6UE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfKOQvV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:51:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53438 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfKOQvV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Nov 2019 11:51:21 -0500
Received: by mail-wm1-f65.google.com with SMTP id u18so10344402wmc.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2019 08:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l8wbuTdKIm9pPYI+wycygsy1JniaWBVTb/yHf0gyXxA=;
        b=JbOi6UE9LQvr0BEsmtWcta5ccO1vrud8AIMk5/DHSMXNKjF29cBmUTsKYUAkUTPfWY
         zoi7WhtQjBSHT+4PINPd9ig5dE+CNt8bkfwePMBERbLpPMtVEThwVF9egJOMmy9toRCh
         Wxhkc4sXQv1ygPs6KgJs+mdI22vghjf2u6U+fu1hlpRMDv6OdNpS0a/rY11BfxTyf+F9
         Q7W/M5/2etQajYo9Jezn/WYQutDRmSe36QDnee8C/nrdCixCA/fnWRPh6NGC3TOgF7JN
         wWOSEzsul9XgjMJTriSTk06ORoa83NJ+qQmiPOxqFC/b+ub6JqHzVw691Q31OY4ETAqh
         1XIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8wbuTdKIm9pPYI+wycygsy1JniaWBVTb/yHf0gyXxA=;
        b=NnOqztFpCWFAvyyhaERtktAQ1XI87Jw4ulOVVNz+dgX8E9cxioowMEVkxnuWXFODqN
         ui8l+WAJJ8x+kxBnBK/bTTtLBL1ufioxRoXj9V8NXmfB6ZwX6rS1aBE13ImwtnAAeeek
         bS2VFIY11xm5xdSTOWvFnCkogjCPMi6npFE1Cw0K7miVANSyeETYmwqaT4B5lvo4ABq5
         iheSDOadJEDcdqsQq/jNy/XDd51ayi0VK6PclD3R3dqUUlYXX4DCQ5c15DSiV2qAqFph
         1i7ueUuKH6gR2QjPBkZMdcLNahkHpaTCgxV1lFJdU9L67abI//wWeMQqdFW1rxkCy2M+
         po0g==
X-Gm-Message-State: APjAAAWeCp2XbUh+HPHpbL2g6L6nnAOZhrIwvtzDJlbsvKXVRD232Tu2
        XDBfKbUT/8y8MGdLlg5X3yM=
X-Google-Smtp-Source: APXvYqz4Nm2urppwmtOhAgtUXENZ8u+LMnaI01uUxr6LW1JCJdGjkg7no1iRaOaIHPhlHEcFI7tMXg==
X-Received: by 2002:a1c:e0c4:: with SMTP id x187mr16411663wmg.93.1573836678845;
        Fri, 15 Nov 2019 08:51:18 -0800 (PST)
Received: from localhost ([37.238.189.15])
        by smtp.gmail.com with ESMTPSA id u7sm13500103wre.59.2019.11.15.08.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 08:51:18 -0800 (PST)
From:   Mohammad Rasim <mohammad.rasim96@gmail.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Mohammad Rasim <mohammad.rasim96@gmail.com>
Subject: [RFC PATCH 1/2] Add entry for BCM4335A0 UART bluetooth
Date:   Fri, 15 Nov 2019 19:50:26 +0300
Message-Id: <20191115165026.19376-2-mohammad.rasim96@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115165026.19376-1-mohammad.rasim96@gmail.com>
References: <20191115165026.19376-1-mohammad.rasim96@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Signed-off-by: Mohammad Rasim <mohammad.rasim96@gmail.com>
---
 drivers/bluetooth/btbcm.c   | 1 +
 drivers/bluetooth/hci_bcm.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 2d2e6d862068..22464bf8cda3 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -339,6 +339,7 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x220e, "BCM20702A1"  },	/* 001.002.014 */
 	{ 0x4217, "BCM4329B1"   },	/* 002.002.023 */
 	{ 0x6106, "BCM4359C0"	},	/* 003.001.006 */
+	{ 0x4106, "BCM4335A0"	},	/* 002.001.006 */
 	{ }
 };
 
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 7646636f2d18..7b4bb5dbea1d 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1422,6 +1422,7 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
 	{ .compatible = "brcm,bcm4345c5" },
 	{ .compatible = "brcm,bcm4330-bt" },
 	{ .compatible = "brcm,bcm43438-bt" },
+	{ .compatible = "brcm,bcm4335A0" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);
-- 
2.23.0

