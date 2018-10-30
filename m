Return-Path: <SRS0=qOEI=NK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FB6C0044C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 00:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDCF2084A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 00:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TYegb46z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDCF2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeJ3Jgc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Oct 2018 05:36:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45310 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbeJ3JgO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Oct 2018 05:36:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id s3-v6so4719992pga.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Oct 2018 17:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HW/Q8BVeJMtf9yQ5kKym3FAHud330282YrV2VBJ/ek4=;
        b=TYegb46zBVmdslU0uGWemO9p5ifDjTAEEgRxNCOOIUktHqeyv9v22z0PFVUeaJAgEv
         mYFuuyGNg9mJCTypLsLy2JYph9Tx5RuIcHh2EnVAAFpy/kDnA8BsHBk9DzkxHvoEH7G1
         TjEPvO6LA2aTxr4lm6+LIk/jveKCnCeh50gAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HW/Q8BVeJMtf9yQ5kKym3FAHud330282YrV2VBJ/ek4=;
        b=RX7fNYULZqivlPpDotaQkDSb3eCyuZQYjZg4FrxKCTRjcrSNhx8IUk++0EvE5iySY+
         wX7bhm43NnGkvpopne/K/13S3uCWRNbIiZNaDc3crwZqYOCr2kkeIgjJDk36biNFXxl2
         +PXG75bjD2/wj0+V3gzTsEvKAtnbiL1wDcoqlnhVybyx7H/WQAEFJ+Kq4S4mM487WriH
         jZs/IF8g0aFquWZljbd4O+ws3qARNc2PeIC0hgHG+TQRRJf/YbfqHDTKxoJ7cxpT4Msp
         slCx2Oe0zhJnbzp+Fsp+pcOFuiTwlb3b8I01LrUBAEO7R8BYcZZH4Un9MThCC1p3I6m4
         BMww==
X-Gm-Message-State: AGRZ1gJChzJvFYipeBdrN6h/K2Cx+MvML3rFQOjOLfLiJvbRUg6SRqAT
        vB8IdHukNxzJR+K/cjEt19/2HA==
X-Google-Smtp-Source: AJdET5dGdq1QdubERIgGqoA+OhTCQ0g6r/liT2cZUEBLRKmr9NRusYjrWYdi7t7lPtNTTOJWlWYpWA==
X-Received: by 2002:a63:6302:: with SMTP id x2mr15885730pgb.183.1540860302096;
        Mon, 29 Oct 2018 17:45:02 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id y1-v6sm24289644pfy.89.2018.10.29.17.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 17:45:01 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        Dmitry Grinberg <dmitrygr@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 2/3] Bluetooth: btqcomsmd: use HCI_QUIRK_USE_BDADDR_PROPERTY
Date:   Mon, 29 Oct 2018 17:44:14 -0700
Message-Id: <20181030004415.237101-3-mka@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181030004415.237101-1-mka@chromium.org>
References: <20181030004415.237101-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use the HCI_QUIRK_USE_BDADDR_PROPERTY quirk to let the HCI
core handle the reading of 'local-bd-address'. With this there
is no need to set HCI_QUIRK_INVALID_BDADDR, the case of a
non-existing or invalid fwnode property is handled by the core
code.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
I couldn't actually test the changes in this driver since I
don't have a device with this controller. Could someone
from Qualcomm help with this?

Changes in v2:
- removed now unused field 'bdaddr' from struct btqcomsmd
- added 'Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>' tag
---
 drivers/bluetooth/btqcomsmd.c | 29 +++--------------------------
 1 file changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
index 7df3eed1ef5e..b3020fab6c8e 100644
--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -28,7 +28,6 @@
 struct btqcomsmd {
 	struct hci_dev *hdev;
 
-	bdaddr_t bdaddr;
 	struct rpmsg_endpoint *acl_channel;
 	struct rpmsg_endpoint *cmd_channel;
 };
@@ -125,23 +124,10 @@ static int btqcomsmd_setup(struct hci_dev *hdev)
 		return PTR_ERR(skb);
 	kfree_skb(skb);
 
-	/* Devices do not have persistent storage for BD address. If no
-	 * BD address has been retrieved during probe, mark the device
-	 * as having an invalid BD address.
+	/* Devices do not have persistent storage for BD address. Retrieve
+	 * it from the firmware node property.
 	 */
-	if (!bacmp(&btq->bdaddr, BDADDR_ANY)) {
-		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
-		return 0;
-	}
-
-	/* When setting a configured BD address fails, mark the device
-	 * as having an invalid BD address.
-	 */
-	err = qca_set_bdaddr_rome(hdev, &btq->bdaddr);
-	if (err) {
-		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
-		return 0;
-	}
+	set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
 
 	return 0;
 }
@@ -169,15 +155,6 @@ static int btqcomsmd_probe(struct platform_device *pdev)
 	if (IS_ERR(btq->cmd_channel))
 		return PTR_ERR(btq->cmd_channel);
 
-	/* The local-bd-address property is usually injected by the
-	 * bootloader which has access to the allocated BD address.
-	 */
-	if (!of_property_read_u8_array(pdev->dev.of_node, "local-bd-address",
-				       (u8 *)&btq->bdaddr, sizeof(bdaddr_t))) {
-		dev_info(&pdev->dev, "BD address %pMR retrieved from device-tree",
-			 &btq->bdaddr);
-	}
-
 	hdev = hci_alloc_dev();
 	if (!hdev)
 		return -ENOMEM;
-- 
2.19.1.568.g152ad8e336-goog

