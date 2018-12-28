Return-Path: <SRS0=+lf3=PF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731DEC43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 22:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B52D217F9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 22:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbeL1WGc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:06:32 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46820 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbeL1WGH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Dec 2018 17:06:07 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so10934387pfe.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Dec 2018 14:06:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SbxqRj/fMk3eUOSNcypNRN9v+ipX3+vHmPhEQxeAOAs=;
        b=KrRaG9S1IQsnOy8KfUBt/A/tABiXvPtEW/3Q1de1KZC/7H5rqWC3ND0c0hEmDjPDu+
         V9qDKjn9KekT7X3oU//TjHJhntsUtAQu8Es07NHZueV9HaNaQ+DL6ZC6lIIfTr7wqgVX
         cN8x8KHtNZmI1LRDV6WnGfaCdEAP50c0gPGU7eSjSRpq6Ns+PA2nKd83e/DgWNlXpojP
         JBzRlXIghk0Fsy9nJZc6c0Ohsv1aD8qHEvGhMDoQdbwMypWApItsNvGk+MNRKjAo5kwk
         M97zrucZElRbBcRqwSxxrDg9oLhqTAb/jsq4fSN0YJuX5s9lyp1Zfggmgu2gGuioodnF
         PvpQ==
X-Gm-Message-State: AJcUuke/7Bzi4Khd8paujgX3RtZRu2R5Bqpg18ND3APWqNr/jGqjzLSP
        Auv3rUjMoKrOi4S9coU1kYf3/Q==
X-Google-Smtp-Source: ALg8bN70E3e9B6QZU0MiB5HcnonQlfrKt5O8XJQA6dolY5Bz5A5qaQLbWLf/RG3aTr/NyvgwOJeiog==
X-Received: by 2002:a65:4904:: with SMTP id p4mr28016891pgs.384.1546034766952;
        Fri, 28 Dec 2018 14:06:06 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f62sm49333537pgc.67.2018.12.28.14.06.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 14:06:05 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        Dmitry Grinberg <dmitrygr@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 2/3] Bluetooth: btqcomsmd: use HCI_QUIRK_USE_BDADDR_PROPERTY
Date:   Fri, 28 Dec 2018 14:05:45 -0800
Message-Id: <20181228220546.367-3-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20181228220546.367-1-mka@chromium.org>
References: <20181228220546.367-1-mka@chromium.org>
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
Changes in v3:
- none

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
2.20.1.415.g653613c723-goog

