Return-Path: <SRS0=8Xmo=2A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582CAC2D0BF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 21:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E00D207FF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 21:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576013477;
	bh=cwMBLvP+bQjJKU19Fc8UeIkvvtMAGhEI2YS6+LSkA4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qimkIgP8Q+b5TOs3LChuTI5c9x5BeIwly/HC8d/utbQt9axT0nU8VxGJO1D3K0Ens
	 AYRLv2ZQu3cPF2YCjlS9M2mEtwazf9w5EJ7HKmtzmHj/DagR4XrF67B5z6GVSZR/Xw
	 tlI5Mq/7QwSJ/qOfIPN+gi+TBY5GQn7HimNJaFwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfLJVbM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:31:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:58310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728219AbfLJVJg (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Dec 2019 16:09:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D725C24696;
        Tue, 10 Dec 2019 21:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012175;
        bh=cwMBLvP+bQjJKU19Fc8UeIkvvtMAGhEI2YS6+LSkA4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vx51UUgKJf5tVdz84/5NsIjQko/aEw+SjKkQyre6iDycN7Dh4RgkXIl9Cmt0GSeg1
         BbVFe0s3r66z8zbMRASO9ACiaSiA2V1L4r4meN/mUNpb7OtIb7vJQG5aWPv+KjjSNQ
         WwcF1HLdRlnYndsNZi0o/Hfd65EWXHh5Le7Gwt/I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefan Wahren <wahrenst@gmx.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 133/350] Bluetooth: hci_bcm: Fix RTS handling during startup
Date:   Tue, 10 Dec 2019 16:03:58 -0500
Message-Id: <20191210210735.9077-94-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Stefan Wahren <wahrenst@gmx.net>

[ Upstream commit 3347a80965b38f096b1d6f995c00c9c9e53d4b8b ]

The RPi 4 uses the hardware handshake lines for CYW43455, but the chip
doesn't react to HCI requests during DT probe. The reason is the inproper
handling of the RTS line during startup. According to the startup
signaling sequence in the CYW43455 datasheet, the hosts RTS line must
be driven after BT_REG_ON and BT_HOST_WAKE.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_bcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 7646636f2d183..0f73f6a686cb7 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -445,9 +445,11 @@ static int bcm_open(struct hci_uart *hu)
 
 out:
 	if (bcm->dev) {
+		hci_uart_set_flow_control(hu, true);
 		hu->init_speed = bcm->dev->init_speed;
 		hu->oper_speed = bcm->dev->oper_speed;
 		err = bcm_gpio_set_power(bcm->dev, true);
+		hci_uart_set_flow_control(hu, false);
 		if (err)
 			goto err_unset_hu;
 	}
-- 
2.20.1

