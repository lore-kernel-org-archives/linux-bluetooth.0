Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1B0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 04:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7791460EFD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 04:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbhKPEwq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 23:52:46 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:29079 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343620AbhKPEwT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 23:52:19 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637038131; h=Message-ID: Subject: Cc: To: From: Date:
 Content-Transfer-Encoding: Content-Type: MIME-Version: Sender;
 bh=C6dta68YCuwcmrwbqCnIM+uu0DuHMK2MLotTOPhNpns=; b=Q/dnfGfpMP9PmP4B9fIxtjz5CF85aXRwv384/zwY4hvbgk242VbbfDfQVtKK0tH2yRL8r+gy
 N1T3oJ8u4gvX1/UHmpcjKqQ4fWmFGuomyOADPYDx+Z3pb57NXON7U0BzShIQG5MO4w91SBMU
 /u3NPXf32x8ktnXbhdP3HPvRLhk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI2MTA3ZSIsICJsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 619338334db4233966b20121 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Nov 2021 04:48:51
 GMT
Sender: tjiang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D6E47C43617; Tue, 16 Nov 2021 04:48:50 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tjiang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 16926C43460;
        Tue, 16 Nov 2021 04:48:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 16 Nov 2021 12:48:49 +0800
From:   tjiang@codeaurora.org
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org, mka@chromium.org,
        rjliao@codeaurora.org, zijuhu@codeaurora.org, tjiang@codeaurora.org
Subject: [PATCH v4] Bluetooth: btusb: re-definition for board_id in struct 
 qca_version
Message-ID: <2659a5743ab560b2c89e341fc61d9cc4@codeaurora.org>
X-Sender: tjiang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The board ID should be split into two bytes.
The 1st byte is chip ID, and the 2nd byte is platform ID.
For example, board ID 0x010A, 0x01 is platform ID. 0x0A is chip ID.
we have several platforms, and platform IDs are continuously added.
We would not distinguish different chips if we get these mixed up.
Platform ID:
0x00 is for Mobile
0x01 is for X86
0x02 is for Automotive
0x03 is for Consumer electronic

Signed-off-by: Tim Jiang <tjiang@codeaurora.org>
---
  drivers/bluetooth/btusb.c | 15 +++++++++++++--
  1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 46d892bbde62..c2a48824ab1e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2883,7 +2883,8 @@ struct qca_version {
  	__le32	rom_version;
  	__le32	patch_version;
  	__le32	ram_version;
-	__le16	board_id;
+	__u8	chip_id;
+	__u8	platform_id;
  	__le16	flag;
  	__u8	reserved[4];
  } __packed;
@@ -3072,7 +3073,17 @@ static void btusb_generate_qca_nvm_name(char 
*fwname, size_t max_size,
  	u16 flag = le16_to_cpu(ver->flag);

  	if (((flag >> 8) & 0xff) == QCA_FLAG_MULTI_NVM) {
-		u16 board_id = le16_to_cpu(ver->board_id);
+		/* The board_id should be split into two bytes
+		 * The 1st byte is chip ID, and the 2nd byte is platform ID
+		 * For example, board ID 0x010A, 0x01 is platform ID. 0x0A is chip ID
+		 * Currently we have several platforms, and platform IDs are 
continuously added.
+		 * Platform ID:
+		 * 0x00 is for Mobile
+		 * 0x01 is for X86
+		 * 0x02 is for Automotive
+		 * 0x03 is for Consumer electronic
+		 */
+		u16 board_id = (ver->chip_id << 8) + ver->platform_id;
  		const char *variant;

  		switch (le32_to_cpu(ver->ram_version)) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum, a Linux Foundation Collaborative Project
