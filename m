Return-Path: <SRS0=McSj=ON=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81878C04EB8
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Dec 2018 20:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456A120850
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Dec 2018 20:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TnyOafyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456A120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbeLDUQg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:16:36 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:47068 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeLDUQe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Dec 2018 15:16:34 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so8754195pfe.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Dec 2018 12:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8f1lTwC+w0tF0lZpXxNLx5u6+ydFj2ElLVSOVkWQ6SE=;
        b=TnyOafyvTNui8N9Y5xf1243DIRXxp2VQ2ZXx3lipW0mrnlrIv0xZeOCIxLmlwto8bQ
         VpTagxAZBcKRh9WPKQI3ONjL3WGfTpwxqnpV2TrS5tXAQH3cEw9JQIaxONJYfGxeHts+
         xQS/SpSFXIyGJWI5y/SFmr6oPCPAtSTJzUnnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8f1lTwC+w0tF0lZpXxNLx5u6+ydFj2ElLVSOVkWQ6SE=;
        b=ukqGry7Tle8+P3uuR5dWsD4BLdvrCE/eQYRhuzMywpP9jnwUgIQxxd9qSLuSLTTbwt
         0id3E57uhC9Mc/TaGwOmn6WhcKpz659S/hner0nHChPZOY9yxd+p53zsxBs1W6Fdtq78
         w0KDtGmSSugpouC52En/Vlo4OjLlDvX2C85Je7txM330ZmkwAPz+oFe1caDM6IZK9Mqz
         P2/cyEpn23T/F6c4EyUcmuYl/vUtjEPlN6sus0RhtWGwZgRm3QNUaohZynd0OObekT15
         k7MOmfs5zuUx57kfOGqcVyl58tlVohehjGYtnfYv7vHTY+6aAYNU3pWUUdPIbBco7KfD
         ISzQ==
X-Gm-Message-State: AA+aEWYpTPX6oRRyCmMq7ICEXqt6LOpx2RUZp4W2hqs9kidmxDFgpQO+
        2QrTTUz6qAeQ896HpSlndnFayQ==
X-Google-Smtp-Source: AFSGD/VBd+IxUbkJrqKau+dSAeQxluUKNMP8FGhV0rd8kbeaxol1lieAoXj9Q0e0v26hkMyJoo4Waw==
X-Received: by 2002:a63:1e17:: with SMTP id e23mr17794171pge.130.1543954594277;
        Tue, 04 Dec 2018 12:16:34 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id b185sm29499593pga.85.2018.12.04.12.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 12:16:33 -0800 (PST)
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
Subject: [PATCH RESEND v2 2/3] Bluetooth: btqcomsmd: use HCI_QUIRK_USE_BDADDR_PROPERTY
Date:   Tue,  4 Dec 2018 12:16:14 -0800
Message-Id: <20181204201615.245574-3-mka@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181204201615.245574-1-mka@chromium.org>
References: <20181204201615.245574-1-mka@chromium.org>
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
index 7df3eed1ef5e9..b3020fab6c8e3 100644
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
2.20.0.rc1.387.gf8505762e3-goog

