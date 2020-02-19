Return-Path: <SRS0=cHq6=4H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20345C34031
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Feb 2020 00:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FC0208E4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Feb 2020 00:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtMuvT9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgBSAgP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:36:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35574 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgBSAgP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Feb 2020 19:36:15 -0500
Received: by mail-pf1-f193.google.com with SMTP id i19so275466pfa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2020 16:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qLc+IK/svMCyoYP1PI6eZ6YUgNngu6dPFpoGFYUhDKE=;
        b=BtMuvT9cmd69kq+Zb7xXgC9oatbRb3D3CubZceYAT+cDnvNy14fMfnAKcjiJLLGY/8
         yo5ikyqnfRvzkt+qDNiZsL/35umhm50zBiiVCh2Izxnhz1apFD+V7Ftte+uO3IW6Wqf+
         dYBPGkpfBtJ4UAj23CH0wi/E/pWUOXXU0zkSg3Sm92trJU3RQe/guVYbz44kDCQ42Fwy
         K2AKjYo+ofJGuCg47KczVf66zW6u8gtvruYApAf9AM1DcvU+EHcp7mb7/HeevTWsI6dp
         XCmzCNepkGNYKgfvSdLoUFuzHSro0NkxRtZLkgZpUk+nkzJsUI5H+cz+YZPfe0l9k1a9
         Jotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qLc+IK/svMCyoYP1PI6eZ6YUgNngu6dPFpoGFYUhDKE=;
        b=IWcD4PQ+XAnYSZIxabgsq+3kttr8v9FDYm+1oE5zZjzbWJmkolKsRTm/lJZxqMDnkk
         S5CbTQ99iIcMPfeHiXteHym7oTkG7Ll6tN4NRkH8QV18YK+ac5VAoAVsiWVF0WgFejnS
         kQbHizEC03+Z0825/3upEG6UGIZknMGVsybDEssf/VQLEI6BXJZd+wyjlgPgAL7GjKbd
         ADka3TG6SkoxjIweJlEFaEJNG5EyMaZb0LO+1d7VwArA81Qjs+aDTrfCOTkAccPQ/4eD
         PSxoY1dHfIsJTps4d0IqKNSCFy73USVY4ex158CMALUT05lIw5hUZzhiscVOELDy8jyx
         eRpA==
X-Gm-Message-State: APjAAAU40pOVw1OCsYa/T8lHT2LAymtUWgXJyh1HEjIyMFXAtm5N1F7t
        7yKYu/nx4mBXi59IcSamG/v92IzAcH0=
X-Google-Smtp-Source: APXvYqziBbTrfcGMpXunx/1LwbCJ+DnJCh8zqsD3nqKsFdcCiylHUR1F0yvUZ+WupBih+oWjgKJNfw==
X-Received: by 2002:a63:ea4b:: with SMTP id l11mr6743939pgk.93.1582072574325;
        Tue, 18 Feb 2020 16:36:14 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.42])
        by smtp.gmail.com with ESMTPSA id v184sm180569pfc.67.2020.02.18.16.36.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 16:36:13 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] lib: Add definition to BT_PHY
Date:   Tue, 18 Feb 2020 16:36:09 -0800
Message-Id: <20200219003612.14599-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the definition to BT_PHY socket options along with the
possible bitfields for the return value.
---
 lib/bluetooth.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 756dce164..d14217eac 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -123,6 +123,24 @@ struct bt_voice {
 #define BT_VOICE_TRANSPARENT			0x0003
 #define BT_VOICE_CVSD_16BIT			0x0060
 
+#define BT_PHY			14
+
+#define BT_PHY_BR_1M_1SLOT	0x00000001
+#define BT_PHY_BR_1M_3SLOT	0x00000002
+#define BT_PHY_BR_1M_5SLOT	0x00000004
+#define BT_PHY_EDR_2M_1SLOT	0x00000008
+#define BT_PHY_EDR_2M_3SLOT	0x00000010
+#define BT_PHY_EDR_2M_5SLOT	0x00000020
+#define BT_PHY_EDR_3M_1SLOT	0x00000040
+#define BT_PHY_EDR_3M_3SLOT	0x00000080
+#define BT_PHY_EDR_3M_5SLOT	0x00000100
+#define BT_PHY_LE_1M_TX		0x00000200
+#define BT_PHY_LE_1M_RX		0x00000400
+#define BT_PHY_LE_2M_TX		0x00000800
+#define BT_PHY_LE_2M_RX		0x00001000
+#define BT_PHY_LE_CODED_TX	0x00002000
+#define BT_PHY_LE_CODED_RX	0x00004000
+
 /* Connection and socket states */
 enum {
 	BT_CONNECTED = 1, /* Equal to TCP_ESTABLISHED to make net code happy */
-- 
2.21.1

