Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135BAC43603
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Dec 2020 03:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1F4622AAA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Dec 2020 03:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgLWDIW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 22:08:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:46328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728296AbgLWCSs (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 21:18:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BE0C233F8;
        Wed, 23 Dec 2020 02:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608689862;
        bh=ajCKYMbnkIdOVdjAjFrhbmX2dU14EdXyW5/KTaq2T7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s58sm+qK67eTOvoBwU2qMv8uK9gAFZ6INbzIYexvPCxXVA/8wZ4mwLodgIdv5yD71
         hlXZvbMb/6yHkkbfq6JBUQIFOS3W7qWt4IcRoKmhw0P9vn/OS3OvRZtGwadpYxhdF9
         Qhbee8Q8XCkdJsycjwQxrPh6HIs1GwEX+XvnWV8BMlF6Cyo0V3KdGey2OebNPzqR3Q
         yd9p5z7OKndY477EbkryQY6yhrOAJLL2itfCpLuDC3tBmTUCfow7Ubf7IxkXUn2itD
         djfBl0q+Y+bgFXJ3d4bwUCECNkEFMis4ZIg2pwO4fJVaRb3Etl2sZcwbjVm5gGgdB3
         g23Qi/yzhiZUQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 058/217] Bluetooth: btqca: Add valid le states quirk
Date:   Tue, 22 Dec 2020 21:13:47 -0500
Message-Id: <20201223021626.2790791-58-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201223021626.2790791-1-sashal@kernel.org>
References: <20201223021626.2790791-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

[ Upstream commit 547801380ec7e6104ea679f599d03c342b4b39a0 ]

WCN3991 supports connectable advertisements so we need to add the valid
le states quirk so the 'central-peripheral' role is exposed in
userspace.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_qca.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 244b8feba5232..2d3f1f179a1e3 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -78,6 +78,7 @@ enum qca_flags {
 
 enum qca_capabilities {
 	QCA_CAP_WIDEBAND_SPEECH = BIT(0),
+	QCA_CAP_VALID_LE_STATES = BIT(1),
 };
 
 /* HCI_IBS transmit side sleep protocol states */
@@ -1780,7 +1781,7 @@ static const struct qca_device_data qca_soc_data_wcn3991 = {
 		{ "vddch0", 450000 },
 	},
 	.num_vregs = 4,
-	.capabilities = QCA_CAP_WIDEBAND_SPEECH,
+	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
 };
 
 static const struct qca_device_data qca_soc_data_wcn3998 = {
@@ -2017,11 +2018,17 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		hdev->shutdown = qca_power_off;
 	}
 
-	/* Wideband speech support must be set per driver since it can't be
-	 * queried via hci.
-	 */
-	if (data && (data->capabilities & QCA_CAP_WIDEBAND_SPEECH))
-		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
+	if (data) {
+		/* Wideband speech support must be set per driver since it can't
+		 * be queried via hci. Same with the valid le states quirk.
+		 */
+		if (data->capabilities & QCA_CAP_WIDEBAND_SPEECH)
+			set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
+				&hdev->quirks);
+
+		if (data->capabilities & QCA_CAP_VALID_LE_STATES)
+			set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
+	}
 
 	return 0;
 }
-- 
2.27.0

