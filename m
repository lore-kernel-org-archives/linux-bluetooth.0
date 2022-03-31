Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC37C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Mar 2022 22:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242452AbiCaWd6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Mar 2022 18:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbiCaWd5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Mar 2022 18:33:57 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24F21B8FD8
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Mar 2022 15:32:09 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id g21so1185698iom.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Mar 2022 15:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FKivNYBTZ3CLCr56HuQik380Y0Yvvg6812CUyUJMe+A=;
        b=o5372QsF3PJ/qzbTE1ZQpDWY9cpGGi3+YR8wrcDM7Zo78I79SUWsbJeiY398DgHFhV
         yD43kiyttH9U+SXcDKGN3WnbmshZne48FYMeYcsLE8bjEoapztt+JUK8FPn0kmKWGNxO
         qDOri0HXcUiOyKpSIWdTCvQArSBiPVofiMxggOk4wnQR2UhANlu29Do6mqBjvqZx9Kjd
         TKBRuDmaoCwrBL6EAbN/mVWbwFuMsO588vSxMIYIJnp6fZ3wqxlOwmi7FZq6l8Q6AgZM
         deqMdj6zmwa6jciM0IiMURcRQrbGehhpkzA/d1LJ7ImkTDQZjfpIShb332lpfot4+Qua
         UKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FKivNYBTZ3CLCr56HuQik380Y0Yvvg6812CUyUJMe+A=;
        b=2YZFISZdNkjXewilCLlJSuhwwM9ND/a6ZMM/c+6lIo9wWkcbytDFOH0AsXeksLxBp7
         hr1TfIbyp0GaoqLr/87CQ1bPI6iOVYA5dTcpcJVaqwqJQ07ZXmq3ndtAZTSQk+rZqtyd
         0FD+0lu2vQSyIlIWew4GsH/Bwx1bzoGt/M+DbCxIUJcva/19/6CkslavO2+G9DBUt+3j
         Ii3AzQV1kSe3VI/7FJoQyGue3ES4OzgVB2U+pcMHQIFlWy35527VSkAyHAiVPA0eG2ai
         8Vcm7zcBGzmXm3uwRwuzse2vE94zzk456RUGWI22x552K+ibU0I11UQ+PZGcv09FYWpX
         RxQw==
X-Gm-Message-State: AOAM530XmtKB5VEOWZYHrRfjjP8R5BhQfXiN4ZcJnnoJJYv3JcsDLdzb
        EdX4I3ip9Mtj2x+Ug4oY8oUcVjzLj80=
X-Google-Smtp-Source: ABdhPJyDhM51IadKEh9EMepuDCbyFb51XzZp6NgGDxJMJI8EVB0l2J8YT9wRyNmSPZTofXyCVz6OTA==
X-Received: by 2002:a6b:6d0d:0:b0:64c:7a7d:558d with SMTP id a13-20020a6b6d0d000000b0064c7a7d558dmr10892903iod.42.1648765928784;
        Thu, 31 Mar 2022 15:32:08 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r3-20020a92d983000000b002c98eaa72ddsm378407iln.84.2022.03.31.15.32.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 15:32:08 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] btdev: Check parameter for CIG related commands
Date:   Thu, 31 Mar 2022 15:32:07 -0700
Message-Id: <20220331223207.3243206-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This checks if the parameters given to Set CIG Parameters and Remove CIG
are in the valid range.
---
 emulator/btdev.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 7fc848ff9..6f44103a7 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5718,6 +5718,8 @@ static int cmd_set_cig_params(struct btdev *dev, const void *data,
 		uint16_t handle[CIS_SIZE];
 	} __attribute__ ((packed)) rsp;
 	int i = 0;
+	uint32_t interval;
+	uint16_t latency;
 
 	memset(&rsp, 0, sizeof(rsp));
 
@@ -5726,6 +5728,56 @@ static int cmd_set_cig_params(struct btdev *dev, const void *data,
 		goto done;
 	}
 
+	if (cmd->cig_id > 0xef) {
+		rsp.params.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	interval = get_le24(cmd->c_interval);
+	if (interval < 0x0000ff || interval > 0x0fffff) {
+		rsp.params.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	interval = get_le24(cmd->p_interval);
+	if (interval < 0x0000ff || interval > 0x0fffff) {
+		rsp.params.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	if (cmd->sca > 0x07) {
+		rsp.params.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	if (cmd->packing > 0x01) {
+		rsp.params.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	if (cmd->framing > 0x01) {
+		rsp.params.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	latency = cpu_to_le16(cmd->c_latency);
+	if (latency < 0x0005 || latency > 0x0fa0) {
+		rsp.params.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	latency = cpu_to_le16(cmd->p_latency);
+	if (latency < 0x0005 || latency > 0x0fa0) {
+		rsp.params.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	if (dev->le_cig.params.cig_id != 0xff &&
+				dev->le_cig.params.cig_id != cmd->cig_id) {
+		rsp.params.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
 	memcpy(&dev->le_cig, data, len);
 
 	rsp.params.status = BT_HCI_ERR_SUCCESS;
@@ -5849,8 +5901,13 @@ static int cmd_remove_cig(struct btdev *dev, const void *data, uint8_t len)
 	memset(&dev->le_cig, 0, sizeof(dev->le_cig));
 	memset(&rsp, 0, sizeof(rsp));
 
-	rsp.status = BT_HCI_ERR_SUCCESS;
 	rsp.cig_id = cmd->cig_id;
+
+	if (dev->le_cig.params.cig_id == cmd->cig_id)
+		rsp.status = BT_HCI_ERR_SUCCESS;
+	else
+		rsp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+
 	cmd_complete(dev, BT_HCI_CMD_LE_REMOVE_CIG, &rsp, sizeof(rsp));
 
 	return 0;
@@ -6777,6 +6834,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 
 	btdev->iso_mtu = 251;
 	btdev->iso_max_pkt = 1;
+	btdev->le_cig.params.cig_id = 0xff;
 
 	btdev->country_code = 0x00;
 
-- 
2.35.1

