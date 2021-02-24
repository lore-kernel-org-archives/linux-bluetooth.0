Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DE2C433E9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Feb 2021 13:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 501B164E21
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Feb 2021 13:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbhBXNvj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Feb 2021 08:51:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:54878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235255AbhBXM55 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Feb 2021 07:57:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCB3264ED1;
        Wed, 24 Feb 2021 12:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614171140;
        bh=HQLyC29loMtCBDLAEB96np3plYSEN5xjR+0MObFUs4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DR1SUahGfEC8gGXbU2ubDRGluRWdaHDWE+FRW3X4wE2Dg9BE6yztWNx1UzBQpRrkA
         y6Kq4khR5ZATYOyqNEeo5fPK8fq+12p6DmI26AEutiacXLVabqxCjPhCPfIvDS3ica
         h01go0svJsq+2riR0VnA7iEL9rhUW/RYvuD4UesfLaZt8vumva8fXr4MvcffV22ggw
         0/49B0lFcAEFxj7FlL7qQf2MwjfBFuVPxyA3uKbtVo0NI52nAcu+7s21QnoeppS16i
         DTbztSGaEhsQvN3rLZyq4F7azHrGM9EKdVWzjqy5qWr8+htDYnwh37PyTFRq+GQaVR
         P141orKPcwdMQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Claire Chang <tientzu@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 06/56] Bluetooth: hci_h5: Set HCI_QUIRK_SIMULTANEOUS_DISCOVERY for btrtl
Date:   Wed, 24 Feb 2021 07:51:22 -0500
Message-Id: <20210224125212.482485-6-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210224125212.482485-1-sashal@kernel.org>
References: <20210224125212.482485-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Claire Chang <tientzu@chromium.org>

[ Upstream commit 7f9f2c3f7d99b8ae773459c74ac5e99a0dd46db9 ]

Realtek Bluetooth controllers can do both LE scan and BR/EDR inquiry
at once, need to set HCI_QUIRK_SIMULTANEOUS_DISCOVERY quirk.

Signed-off-by: Claire Chang <tientzu@chromium.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_h5.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 78d635f1d1567..996729e78105a 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -906,6 +906,11 @@ static int h5_btrtl_setup(struct h5 *h5)
 	/* Give the device some time before the hci-core sends it a reset */
 	usleep_range(10000, 20000);
 
+	/* Enable controller to do both LE scan and BR/EDR inquiry
+	 * simultaneously.
+	 */
+	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &h5->hu->hdev->quirks);
+
 out_free:
 	btrtl_free(btrtl_dev);
 
-- 
2.27.0

