Return-Path: <SRS0=7F+K=5F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18233C4332D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 20:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D261420724
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 20:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWEzWs+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgCTUkl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:40:41 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:43872 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgCTUkl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Mar 2020 16:40:41 -0400
Received: by mail-pg1-f181.google.com with SMTP id u12so3650432pgb.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2020 13:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RDYEdkljvQbqkNc/fQ7kNsnfQG9sSf+HFCSIVIMcAhc=;
        b=VWEzWs+YC0/CijhCVJgesSJbRDHqIx3n+I8pfLvyBV/T901XNNKGSpSxTVWioagmcw
         jz47BaDJPtu2WFdpeG+wp13gjGp3HYaJGxpUAWoV+hXcsxD8LxpZnjHdnHmSO+qkt9Ad
         o3Gnes3x8y9I7INKcBme9CGxXvjzmtEY/x539uUcQmL52/E2TSRaBTs6wR+UF1f8sfL2
         wHX5kqHPxUGW9AonkNao1sYhUez7+Qu9ZDPU5B0vVA5QFa+gjvWyT1ccuvWZAImjAuEH
         MGurV8Memi4XZ1qHtwzgloS3r9X21jFzuumpR94H7Sv8DAKHRk9bjBnye7f/IIiCCwiz
         5Kzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RDYEdkljvQbqkNc/fQ7kNsnfQG9sSf+HFCSIVIMcAhc=;
        b=NVKjNlWB5txSD4vy45XWFNFCR2oM8nzrMxpDxUes506EJDHSFC/GOnfX9YKHHIBm+d
         qoDNEd2sdGk7+7z5jCJ5En7AoPpXAKAv+OReLBoXUiUFZpvPTRhVmCKb95tHyQW5Gg97
         /z4GRsx6XfKcaiyavHrymMq2Cl5fZVgVzEkgrAybkcfdSTXo7dunSqccwqAJo2Vn5hzC
         DGLKi6v2QYmYnO63eZKvEi1uzYavm2t+6m1w2AWvaD62sIGrnL1OaLkDjC1lJuXna7sv
         I9Dl2lLKH7yS/iWNzqJNFcxjcixi3aAFMyrfIt10bs8PsVWmsaHrcC8Ojb3mvJSVDNpd
         An4g==
X-Gm-Message-State: ANhLgQ1D6bz0sKbTCMuOUvGLkBrJApeToP/r76G2BW+RAMUbNEuekdkB
        UcU3JT0PkxhlrdVXgEuJJ93o1MnM
X-Google-Smtp-Source: ADFU+vtn0uNUzvdYmtlt8VoDIq5Pp63XAk9z5axPiqdRdkTlycfJA9AAJ47LZJageolMqcW5MnSXzA==
X-Received: by 2002:a62:fc07:: with SMTP id e7mr12008576pfh.299.1584736839662;
        Fri, 20 Mar 2020 13:40:39 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d5sm6219522pga.36.2020.03.20.13.40.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 13:40:39 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/6] lib: Add definitions for Enhanced Credits Based Mode
Date:   Fri, 20 Mar 2020 13:40:33 -0700
Message-Id: <20200320204038.11799-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 lib/bluetooth.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index d14217eac..4a52ecb78 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -141,6 +141,14 @@ struct bt_voice {
 #define BT_PHY_LE_CODED_TX	0x00002000
 #define BT_PHY_LE_CODED_RX	0x00004000
 
+#define BT_MODE			15
+
+#define BT_MODE_BASIC		0x00
+#define BT_MODE_ERTM		0x01
+#define BT_MODE_STREAMING	0x02
+#define BT_MODE_LE_FLOWCTL	0x03
+#define BT_MODE_EXT_FLOWCTL	0x04
+
 /* Connection and socket states */
 enum {
 	BT_CONNECTED = 1, /* Equal to TCP_ESTABLISHED to make net code happy */
-- 
2.21.1

