Return-Path: <SRS0=ITyu=7V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E822C433E6
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jun 2020 23:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1353920842
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jun 2020 23:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591657673;
	bh=i46RftpKozMzFrPCBibhwcY0IyjVuViuW1HQ66oKYgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yAlO27a8OID7jB94KH492HXm5JvvYur71q0tGG0iWQVrFbjml9HeDU5j8LdhIU2h3
	 fxrl8WG9So/Q1P6XXO6GdsuqpjSZ1KRRKz75iCWupW7m8buLuSQdG2Dig7BA1s8JKs
	 wXAJ0XbFspDo3zqVApq6EEszv4CQkPoRHkV1afhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgFHXHw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:07:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728018AbgFHXHu (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jun 2020 19:07:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2B5020888;
        Mon,  8 Jun 2020 23:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657669;
        bh=i46RftpKozMzFrPCBibhwcY0IyjVuViuW1HQ66oKYgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hz6sPk0StMHKEAqNeGhUiGMl9VyhZZ83r09Y6r8QQIUOazlmgFPp4Yqz2wLks1WZg
         Kvp2GOy2wjWCrr32VbKJOSaVoSdcxC9GStl/dhTKCdhNCnu/hIrlxFdtcqXKnAvFdk
         zlTmHhlzPwFSjTqukUhn8pwatu8Q2iAexUN1bXuA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zijun Hu <zijuhu@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 079/274] Bluetooth: hci_qca: Fix suspend/resume functionality failure
Date:   Mon,  8 Jun 2020 19:02:52 -0400
Message-Id: <20200608230607.3361041-79-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Zijun Hu <zijuhu@codeaurora.org>

[ Upstream commit feac90d756c03b03b83fabe83571bd88ecc96b78 ]

@dev parameter of qca_suspend()/qca_resume() represents
serdev_device, but it is mistook for hci_dev and causes
succedent unexpected memory access.

Fix by taking @dev as serdev_device.

Fixes: 41d5b25fed0 ("Bluetooth: hci_qca: add PM support")
Signed-off-by: Zijun Hu <zijuhu@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_qca.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 439392b1c043..0b1036e5e963 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1953,8 +1953,9 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 
 static int __maybe_unused qca_suspend(struct device *dev)
 {
-	struct hci_dev *hdev = container_of(dev, struct hci_dev, dev);
-	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct serdev_device *serdev = to_serdev_device(dev);
+	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
+	struct hci_uart *hu = &qcadev->serdev_hu;
 	struct qca_data *qca = hu->priv;
 	unsigned long flags;
 	int ret = 0;
@@ -2033,8 +2034,9 @@ static int __maybe_unused qca_suspend(struct device *dev)
 
 static int __maybe_unused qca_resume(struct device *dev)
 {
-	struct hci_dev *hdev = container_of(dev, struct hci_dev, dev);
-	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct serdev_device *serdev = to_serdev_device(dev);
+	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
+	struct hci_uart *hu = &qcadev->serdev_hu;
 	struct qca_data *qca = hu->priv;
 
 	clear_bit(QCA_SUSPENDING, &qca->flags);
-- 
2.25.1

