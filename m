Return-Path: <SRS0=erFC=OG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0F0C43441
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Nov 2018 09:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95918204FD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Nov 2018 09:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0/xTpRu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95918204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbeK0UfJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:35:09 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39630 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbeK0UfJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Nov 2018 15:35:09 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so19429171ljh.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Nov 2018 01:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=1p6b28GRiaKeSL1uBysX3Z7Zwqkc9d0NPBvvLBp4eR4=;
        b=e0/xTpRuiHP5vkTUjCTF8/4deGz3TNpkSvacDCaSlfrv8Kozb0DHNXdVKqgxQDkPU2
         5/19SffiTEoWzspdHDPC6VPOa+Sn02grPkStWuoewOlJ0ihMtOSrcv/PNb+D1ukskQGh
         JMws+taxD7lfjfmLzjt3tG/deogAmboGyPdarfxr65zYdhlHYevmpLB2spyCkyUEjhTj
         x8/fZrcy7f+iH6NOwp5eJ5CgaFiweJGVT3twEZRqcxu8eJwfL8BrRYpFunPsXSatBKBp
         Dpvb0JXNGG2LNUVWSYSMkggLnXTcuJYfJK4amJ5ojEk2Zrn9qOL+QX0iZ8mA6fWdCVQL
         xX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=1p6b28GRiaKeSL1uBysX3Z7Zwqkc9d0NPBvvLBp4eR4=;
        b=tzse/bbfESK8AN+seuwGPXBmd02nN7QcDCyLIdIHWH1pSqeibOcBc2YsZcdusNjMXW
         ABln5G5xHIrVDjZmx+EG/0egMHlSsk1yqSLzLbRTnczOzE2LG56XsYgS1xOGxgR9icH4
         QNx10JA8Ol1XWj4yfLAK1+Tblwsffuwz8Ufvoew+Gr8dOPsahj2b6EaKvw2oGja8H2lW
         XiRrE1HJnxl8lySvh2cTmHdnPv2NfYQDPDsZgKLj4u2H5bPaeEKoF24jX8XIa0dtRFc7
         QQ59avzMTrJz2kJ7VBBbEgnRe5GAEinB9KYZoACZvYrXueOsa2cAqA10iUXFeczmeSvk
         y4/w==
X-Gm-Message-State: AA+aEWa0URV50b2J03zh4otbOD9cPBvMkpKtYNI37yFVXna3oMWFXvi0
        VPVVrRVX6SDS4/N81e6ejU141K0qJxc=
X-Google-Smtp-Source: AFSGD/XvYN/EZA3HLej9IOcjKYbzQsgTiaL1czHmo/eJqNUFcFb+14syBM/Dvzls6SLegb7sRJQMmg==
X-Received: by 2002:a2e:744:: with SMTP id i4-v6mr19116538ljd.140.1543311468281;
        Tue, 27 Nov 2018 01:37:48 -0800 (PST)
Received: from fedora-28.shared.localdomain (85-76-78-76-nat.elisa-mobile.fi. [85.76.78.76])
        by smtp.gmail.com with ESMTPSA id y1-v6sm472189ljh.39.2018.11.27.01.37.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 01:37:47 -0800 (PST)
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix unnecessary error message for HCI request completion
Date:   Tue, 27 Nov 2018 11:37:46 +0200
Message-Id: <20181127093746.7414-1-johan.hedberg@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Johan Hedberg <johan.hedberg@intel.com>

In case a command which completes in Command Status was sent using the
hci_cmd_send-family of APIs there would be a misleading error in the
hci_get_cmd_complete function, since the code would be trying to fetch
the Command Complete parameters when there are none.

Avoid the misleading error and silently bail out from the function in
case the received event is a command status.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ef9928d7b4fb..ac2826ce162b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5711,6 +5711,12 @@ static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
 		return true;
 	}
 
+	/* Check if request ended in Command Status - no way to retreive
+	 * any extra parameters in this case.
+	 */
+	if (hdr->evt == HCI_EV_CMD_STATUS)
+		return false;
+
 	if (hdr->evt != HCI_EV_CMD_COMPLETE) {
 		bt_dev_err(hdev, "last event is not cmd complete (0x%2.2x)",
 			   hdr->evt);
-- 
2.17.2

