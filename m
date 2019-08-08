Return-Path: <SRS0=RGGC=WE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA2DC0650F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Aug 2019 06:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52972186A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Aug 2019 06:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KcxK+vRc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KcxK+vRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbfHHGHv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Aug 2019 02:07:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43950 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfHHGHu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Aug 2019 02:07:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B3A8A60710; Thu,  8 Aug 2019 06:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565244469;
        bh=f99Iu+KunGz7J43l+XW9Qq8xhxWIcYZN4f8PSf2tM6E=;
        h=From:To:Cc:Subject:Date:From;
        b=KcxK+vRccIotCGS7X6YuZaivdRb69Xf+jZhJuIVNM4raroEsZjdnmE8Lh+j45p9oT
         54bOYZoc1WQ5y0JvWh5lsf45jnwUP0kiJXgtIEEjbxcZupUTfIXc+LUHMAl+pCklli
         H04SI9iXppLf2oU0holKxIOrSnmt2AwUw6qbQNb8=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6394F6030B;
        Thu,  8 Aug 2019 06:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565244469;
        bh=f99Iu+KunGz7J43l+XW9Qq8xhxWIcYZN4f8PSf2tM6E=;
        h=From:To:Cc:Subject:Date:From;
        b=KcxK+vRccIotCGS7X6YuZaivdRb69Xf+jZhJuIVNM4raroEsZjdnmE8Lh+j45p9oT
         54bOYZoc1WQ5y0JvWh5lsf45jnwUP0kiJXgtIEEjbxcZupUTfIXc+LUHMAl+pCklli
         H04SI9iXppLf2oU0holKxIOrSnmt2AwUw6qbQNb8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6394F6030B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org
Cc:     linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, rjliao@codeaurora.org,
        c_hbandi@codeaurora.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v1] Bluetooth: btqca: Reset download type to default
Date:   Thu,  8 Aug 2019 11:37:37 +0530
Message-Id: <20190808060737.3506-1-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch will reset the download flag to default value
before retrieving the download mode type.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 drivers/bluetooth/btqca.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 2221935fac7e..9fb247c10855 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -140,6 +140,7 @@ static void qca_tlv_check_data(struct rome_config *config,
 	BT_DBG("Length\t\t : %d bytes", length);
 
 	config->dnld_mode = ROME_SKIP_EVT_NONE;
+	config->dnld_type = ROME_SKIP_EVT_NONE;
 
 	switch (config->type) {
 	case TLV_TYPE_PATCH:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

