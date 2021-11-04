Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85182C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Nov 2021 07:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66FA660FED
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Nov 2021 07:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhKDHE2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Nov 2021 03:04:28 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:47049 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbhKDHEZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Nov 2021 03:04:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636009307; h=Message-ID: Subject: Cc: To: From: Date:
 Content-Transfer-Encoding: Content-Type: MIME-Version: Sender;
 bh=uNpgzCdx9C8sMIcEkNxUqveaCb//Ijd7j9dqD3vKIns=; b=vrEOAGaizX9PgnN1WHEfWT5Pf5wADXwHkVgOgI7+nC+ZDW0U65L4CnQ7w07g0ogLL33wNnyK
 GnlYVggLRg+vP5I++SQEeP3dKPG9AujFXpS857bcQSkr6gvKGm+f6+BoFRmj5sYtBoGULB33
 9T0BGUJl+GO3nXtoqQ58ITr3M0M=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI2MTA3ZSIsICJsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6183855b303715da979a875d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 04 Nov 2021 07:01:47
 GMT
Sender: tjiang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F0314C43460; Thu,  4 Nov 2021 07:01:46 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tjiang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C472CC4338F;
        Thu,  4 Nov 2021 07:01:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 04 Nov 2021 15:01:45 +0800
From:   tjiang@codeaurora.org
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org, mka@chromium.org,
        rjliao@codeaurora.org, zijuhu@codeaurora.org, tjiang@codeaurora.org
Subject: [PATCH v3] Bluetooth: btusb: re-definition for board_id in struct 
 qca_version
Message-ID: <305e41a55a4c117da86f786c374a57dc@codeaurora.org>
X-Sender: tjiang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

As qc btsoc will using big-endian for boardID, so align host with it.

Signed-off-by: Tim Jiang <tjiang@codeaurora.org>
---
  drivers/bluetooth/btusb.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 46d892bbde62..a51b1d641043 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2883,7 +2883,7 @@ struct qca_version {
  	__le32	rom_version;
  	__le32	patch_version;
  	__le32	ram_version;
-	__le16	board_id;
+	__u8	board_id[2];
  	__le16	flag;
  	__u8	reserved[4];
  } __packed;
@@ -3072,7 +3072,7 @@ static void btusb_generate_qca_nvm_name(char 
*fwname, size_t max_size,
  	u16 flag = le16_to_cpu(ver->flag);

  	if (((flag >> 8) & 0xff) == QCA_FLAG_MULTI_NVM) {
-		u16 board_id = le16_to_cpu(ver->board_id);
+		u16 board_id = (ver->board_id[0] << 8) + ver->board_id[1];
  		const char *variant;

  		switch (le32_to_cpu(ver->ram_version)) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum, a Linux Foundation Collaborative Project
