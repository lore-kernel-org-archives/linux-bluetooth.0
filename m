Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED9FC07E96
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Jul 2021 11:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 565AF61FBC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Jul 2021 11:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240954AbhGFLtk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Jul 2021 07:49:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237436AbhGFLgK (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Jul 2021 07:36:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93DB061DA2;
        Tue,  6 Jul 2021 11:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625570864;
        bh=dUcqScZ99UmglqjM0SgZlPfZ5qO4WHRNMphFVA1USQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L/0y86ZgQA2zeD1u1lbFh9zjBWLZyoMFeGf+plC+UFoHcQI01HIGK+5Ht8Rk5G6eK
         cXSEzgqkwwR13DfEouFNYkKTyiTMF7mc3I85PYtvvDJxf7ILSmGo4d6o1gKqHSf1zz
         ONRoloQ0thIfEgqF2Qk7uRx5cOfUeKFeNwgLQIW1QPka0FFb+6TVpnip0QT1Ep4bHi
         Rmrp0tsMNs9MB+eZbMiGXL8Sf1OTPhEqSEGp2oe7+he1tZc/ldzdSIkImO4mCaKpgR
         BttjDChhc5OCyVcAkr2V5HWhPzcbZohRBIhuYf7B5AFovXBZq1yuNbo8Cu44jUCTmM
         5ZrXin1rB/xcQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tim Jiang <tjiang@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 52/55] Bluetooth: btusb: fix bt fiwmare downloading failure issue for qca btsoc.
Date:   Tue,  6 Jul 2021 07:26:35 -0400
Message-Id: <20210706112638.2065023-52-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706112638.2065023-1-sashal@kernel.org>
References: <20210706112638.2065023-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tim Jiang <tjiang@codeaurora.org>

[ Upstream commit 4f00bfb372674d586c4a261bfc595cbce101fbb6 ]

This is btsoc timing issue, after host start to downloading bt firmware,
ep2 need time to switch from function acl to function dfu, so host add
20ms delay as workaround.

Signed-off-by: Tim Jiang <tjiang@codeaurora.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1b0adf5c2376..7188f0fb2e05 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2595,6 +2595,11 @@ static int btusb_setup_qca_download_fw(struct hci_dev *hdev,
 	sent += size;
 	count -= size;
 
+	/* ep2 need time to switch from function acl to function dfu,
+	 * so we add 20ms delay here.
+	 */
+	msleep(20);
+
 	while (count) {
 		size = min_t(size_t, count, QCA_DFU_PACKET_LEN);
 
-- 
2.30.2

