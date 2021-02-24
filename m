Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF49C433E9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Feb 2021 13:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC57601FB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Feb 2021 13:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbhBXNyc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Feb 2021 08:54:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:58120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235948AbhBXNIO (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Feb 2021 08:08:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09C7764F98;
        Wed, 24 Feb 2021 12:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614171281;
        bh=9Rq7KWCcCUPnvqijRARGEMCbqCB8cVuoigjXce4svJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NbX0VzMXeVMbU9ValvF+TgLArGIny1setx0oWoMZ0hhjYC/XIO4NtD+eNaz8Ste9M
         YdsWenfzbWc1ra96rA0umyZhu0kE25IcdOGUmbVxHC3PJuI1dKaI1LFYlj9UXjLFy+
         p4Mt5hI9nQN91Y/wJqtYWXge7whaK3pJExYUiAEbzYCvkdTMRuLprYLmWLMwdaJBOc
         kFt2IqRUTqJAZ+M5w9r7w8kmCayzH300VpkOa+mC705lhnEjlT5NAXz0X89jBvTwdj
         cypv6/NVLdKBABi18xxNo0d/9J/e3bo34Qfv6V905up1G6JuuW/QaYRh0F2QWXZNW2
         dbp+k7h6NRe7g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Claire Chang <tientzu@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 05/26] Bluetooth: hci_h5: Set HCI_QUIRK_SIMULTANEOUS_DISCOVERY for btrtl
Date:   Wed, 24 Feb 2021 07:54:13 -0500
Message-Id: <20210224125435.483539-5-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210224125435.483539-1-sashal@kernel.org>
References: <20210224125435.483539-1-sashal@kernel.org>
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
index 7ffeb37e8f202..79b96251de806 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -885,6 +885,11 @@ static int h5_btrtl_setup(struct h5 *h5)
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

