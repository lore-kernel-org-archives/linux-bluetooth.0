Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09658C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Apr 2022 21:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbiDFVtS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Apr 2022 17:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbiDFVsy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Apr 2022 17:48:54 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1E717ABAD
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Apr 2022 14:33:59 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 125so4554338iov.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Apr 2022 14:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XHU0Ofs+uuxXDTpWsnrK31V5HiLi6pQC26DPjjOAhME=;
        b=TJmhFV24cRZq2ZkB14qt8d1i9hlSi25lF0aPHcI8hc2ydT85k+5TRYSeds0ZpUn+RE
         xaErsCRvhTzaJarF/bLUETMN3juIh8cCCjWbLrwXB0DG6c7kVlzddcbLdf++WLI6TdiC
         SgN9kYMFZG6bQbSMYCVCdDHKrNW68+Tq+wZ+8SKMAVy9nA7zRWWQ9feSEbpcJiGKZ+or
         bSwd1PxiDbQWmGfRD/NRUR6OHH1FNRRyToZoBk8GuZm24X7DGzlwq/ttu8f1+vDmKTR8
         W+X6JPsXaH5lAAgot2ZGHLw9oqU6AlY1Suhmj8bzuaWy8ZOVKEPfs3OxAQcriuPOYv2l
         oIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XHU0Ofs+uuxXDTpWsnrK31V5HiLi6pQC26DPjjOAhME=;
        b=AseSSy6frRA5ThOc/TlvUp9SLJwWngky2oUOPaAnZkD4knkXg60MryCPzhNr0k3Bzk
         9srdtAnkP0oRnj+bv3lGEtpMfJvEJ8l5wDzruYJ9ysDU4ukIj6WGjsBYylsblDOXMn2s
         rCxzwsIPJOjVr49apJ8f+ESs4mewXG8wfku3FCz6QTtjc4/n4tz6Klxz5BYb2uX+2lZB
         goVabM7BxuD5T467djmid0ybZxctkijPdNLmLf/RQPnSK6KtOSRPq9uQUgWDFZ2cqfQy
         bFeVLpU3/S+xLuXRsBwOwRay27zrMJO1LFTk8ZmCFBgoe+e4ARGy8eNqlRez5u8ZTnvP
         0MBw==
X-Gm-Message-State: AOAM530N+T82rmfsROG9MGuUe2V7Yu47T1znb3FLgrXyY6IZ5O1auefd
        DsGzN7kxCErRqZ12yX/5T9xrYF7xpyY=
X-Google-Smtp-Source: ABdhPJyAaVFz0iORqmBeg61qqJK6wxLLL9Rn1m6mVM1vwth0XnGkJrPbD8tvuF5kyB7NT7ppfJ7sBg==
X-Received: by 2002:a5d:85d2:0:b0:5ed:a17c:a25c with SMTP id e18-20020a5d85d2000000b005eda17ca25cmr5063185ios.85.1649280838685;
        Wed, 06 Apr 2022 14:33:58 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id v12-20020a92cd4c000000b002ca50ef78e4sm4726322ilq.62.2022.04.06.14.33.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 14:33:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] btdev: Fix BIG Create Sync
Date:   Wed,  6 Apr 2022 14:33:55 -0700
Message-Id: <20220406213355.1918220-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406213355.1918220-1-luiz.dentz@gmail.com>
References: <20220406213355.1918220-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes status return to BIG Create Sync command.
---
 emulator/btdev.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 71dbea4be..20d2ed34c 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -6070,15 +6070,19 @@ static int cmd_big_create_sync(struct btdev *dev, const void *data, uint8_t len)
 	/* If the Sync_Handle does not exist, the Controller shall return the
 	 * error code Unknown Advertising Identifier (0x42).
 	 */
-	if (dev->le_pa_sync_handle != le16_to_cpu(cmd->sync_handle))
+	if (dev->le_pa_sync_handle != le16_to_cpu(cmd->sync_handle)) {
 		status = BT_HCI_ERR_UNKNOWN_ADVERTISING_ID;
+		goto done;
+	}
 
 	/* If the Host sends this command with a BIG_Handle that is already
 	 * allocated, the Controller shall return the error code Command
 	 * Disallowed (0x0C).
 	 */
-	if (dev->big_handle == cmd->handle)
+	if (dev->big_handle == cmd->handle) {
 		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		goto done;
+	}
 
 	/* If the Num_BIS parameter is greater than the total number of BISes
 	 * in the BIG, the Controller shall return the error code Unsupported
@@ -6087,12 +6091,10 @@ static int cmd_big_create_sync(struct btdev *dev, const void *data, uint8_t len)
 	if (cmd->num_bis != len - sizeof(*cmd))
 		status = BT_HCI_ERR_UNSUPPORTED_FEATURE;
 
-	if (status)
-		return status;
-
+done:
 	cmd_status(dev, status, BT_HCI_CMD_LE_BIG_CREATE_SYNC);
 
-	return status;
+	return 0;
 }
 
 static int cmd_big_create_sync_complete(struct btdev *dev, const void *data,
@@ -6140,7 +6142,7 @@ static int cmd_big_create_sync_complete(struct btdev *dev, const void *data,
 	pdu.ev.pto = 0x00;
 	pdu.ev.irc = 0x01;
 	pdu.ev.max_pdu = bis->sdu;
-	pdu.ev.interval = bis->latency;
+	pdu.ev.interval = bis->latency / 1.25;
 	pdu.ev.num_bis = cmd->num_bis;
 
 	le_meta_event(dev, BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED, &pdu,
@@ -6873,6 +6875,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 	btdev->iso_mtu = 251;
 	btdev->iso_max_pkt = 1;
 	btdev->le_cig.params.cig_id = 0xff;
+	btdev->big_handle = 0xff;
 
 	btdev->country_code = 0x00;
 
-- 
2.35.1

