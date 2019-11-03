Return-Path: <SRS0=Jrbp=Y3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDFCCA9EB0
	for <linux-bluetooth@archiver.kernel.org>; Sun,  3 Nov 2019 21:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEC621655
	for <linux-bluetooth@archiver.kernel.org>; Sun,  3 Nov 2019 21:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNk+m2eW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfKCV6U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 3 Nov 2019 16:58:20 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43676 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbfKCV6U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 3 Nov 2019 16:58:20 -0500
Received: by mail-lf1-f67.google.com with SMTP id j5so10753035lfh.10
        for <linux-bluetooth@vger.kernel.org>; Sun, 03 Nov 2019 13:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4LoSN4zz48wYQUaxJUvsKmgcngK1miOEYkQqlL7Bdd0=;
        b=tNk+m2eWNPj6zlCOKsVouPfpWajKZMn2x2CTlVh5WBb6tBjCYDQNY2rMf5Kgiq3FH0
         SJDtTrtbEgm2v64gxdgb8IAhSWfpxuyQz6D+3KQQ7Ur3wkxtuIuxNZYh/w2+l9LygYLh
         wDzj2XyRypkVLvIUsm6r9J1lRbTlILBB/JUocmUwBicBuYtQ4V9a/VM9y5eQOIzMcr4j
         FW9hr6a7kVcLQGDt9Pf6o7nZktcbGlNcVN3xC0C9WfD2SttuwhXxkVakCiWBSwRMjPW2
         ABTEe/9m41KSMyM5pVt1LBzLWciNWt4rpLSx8HSB2U1H1NWJwKdyWJfQpFo4FsTTmZBJ
         j0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4LoSN4zz48wYQUaxJUvsKmgcngK1miOEYkQqlL7Bdd0=;
        b=HQnAsv0B+e7sgBELvTFQ4toGEohRny7Rcv7RTL8OkTq2dIj/vToU3VtnMjLPx01POe
         9jEfUZbgbw9A7YClATQa30kQ2/2m8nf6JPM66z9FL86GezEGqQR0TecFtDWtlMBMyQNx
         LjryiJEjvDoPo8WTVX5voFtm9q5QALvUBJL22Hv2p3cVaK94S+6q04gPCfAtrOpkTGRu
         bPduPPGvrEz9e2wV+FXfWPE9IhGbKVOabNPQ8cOhleX+jqYQTOAwU+HD0nkjS4fC5LUz
         95bE6IfRSIdpu7z0fnFNJR2/Hq7ssWxWdZ7scX9Xv4hv0GXmNetOTa18WDBAtpdiVtUh
         9tCg==
X-Gm-Message-State: APjAAAXXaGbMmljA4qxD2e8qlwz0bELeke7GLv3yPuPNvqG2GlmasTHP
        h2u34FKpBJHWwGOLITx5R4X9WJHBMUY=
X-Google-Smtp-Source: APXvYqwHzJf/EuqMt4PjA1MG+LdRagHnrs2H502VvTyKcrkfR+HbkOeCluUhwXT3+2SUn3MK8X0ZgQ==
X-Received: by 2002:a19:746:: with SMTP id 67mr14372791lfh.42.1572818297501;
        Sun, 03 Nov 2019 13:58:17 -0800 (PST)
Received: from vudentzs-t460s.www.huaweimobilewifi.com (83-245-238-236-nat-p.elisa-mobile.fi. [83.245.238.236])
        by smtp.gmail.com with ESMTPSA id g3sm5805104ljj.59.2019.11.03.13.58.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 13:58:16 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix advertising duplicated flags
Date:   Sun,  3 Nov 2019 23:58:15 +0200
Message-Id: <20191103215815.5310-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Instances may have flags set as part of its data in which case the code
should not attempt to add it again otherwise it can cause duplication:

< HCI Command: LE Set Extended Advertising Data (0x08|0x0037) plen 35
        Handle: 0x00
        Operation: Complete extended advertising data (0x03)
        Fragment preference: Minimize fragmentation (0x01)
        Data length: 0x06
        Flags: 0x04
          BR/EDR Not Supported
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_request.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index ba99c292cf04..2a1b64dbf76e 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1273,6 +1273,14 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 
 	instance_flags = get_adv_instance_flags(hdev, instance);
 
+	/* If instance already has the flags set skip adding it once
+	 * again.
+	 */
+	if (adv_instance && eir_get_data(adv_instance->adv_data,
+					 adv_instance->adv_data_len, EIR_FLAGS,
+					 NULL))
+		goto skip_flags;
+
 	/* The Add Advertising command allows userspace to set both the general
 	 * and limited discoverable flags.
 	 */
@@ -1305,6 +1313,7 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 		}
 	}
 
+skip_flags:
 	if (adv_instance) {
 		memcpy(ptr, adv_instance->adv_data,
 		       adv_instance->adv_data_len);
-- 
2.21.0

