Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65840EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Aug 2023 18:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjHCSQg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Aug 2023 14:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjHCSQa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Aug 2023 14:16:30 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D8D30D5
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Aug 2023 11:16:29 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7656652da3cso90145385a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Aug 2023 11:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691086587; x=1691691387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=j3DxfGnE9pko5LgOCrvrs8GTtt8YvXgf0sEuqXG+a4k=;
        b=BYaGJy0GbS/hn6JgqUKZ1Wc6kCCkb1CoMlGvqG+ev/+WVWVuYzdGzdfK0ZLYvIfFTO
         2eOD9H7H7aQOqmzzfm79UnsOQcITUWbHLJ9G38aexHTIXusWwKL1BMmFz3tcrzMhFEpG
         SRS03a7POuL1fwEEhsFBZLi4Kwwlrcvv9CuAAk+0DEkFIL7Pc/J4XjOyQO1Q2ufEOFWV
         mI/pTalQGvKjiyB/4AccEKo25cea6zCZcLanhkrtf7JhumYoGXzAh77Bv0AjcAfIKEtP
         BjzBRxFXxbMxUFR3PtbAafQADnErkpWzVyw86PX//FACFOk7hRgkXQTbuVA7WMgGnVXZ
         v19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691086587; x=1691691387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j3DxfGnE9pko5LgOCrvrs8GTtt8YvXgf0sEuqXG+a4k=;
        b=V835II55n1SWNw5WDscwbuhabO8OG3aro7go4aAP6hDk/Y7MHzrmFpeVXTZl05BC9l
         824uSpR6LtkIMjhNGS4fd73hH1dFbgGt0Fg/O7POLgegcLSCEPhad7NGd0Xtugki2bq1
         AOikPjd5yuytE0EnrRe2vNDvpBf2VPWkNYgHOPQwkB+KhQIskEmLztz/bhONu6oeVDCp
         Fm9eB9Q7kotlTPJNhy1errtzWInkpNo54GDK1fyFrliVIMNxpSNvHE3SVuW7szKT1FjJ
         4I+UrP7FCBdcmzFGvEbR1vAHwhfz9r53EGfZtJ4TZqSScXZptimghC//aZp6Z57Cf6t0
         VD/Q==
X-Gm-Message-State: ABy/qLYnZq4I570aYF5xpegx3B2TqS36jE6Et4Ux+IIgzVCFaaNnXjae
        4f2Uh3TPO4lUsURDuNltawWt3Khl0fU=
X-Google-Smtp-Source: APBJJlECfgz1NAElNABlvUPHZg05troHwXZYG8yqdREL/urNTDm80dhX1YthcONycoPjPvhcIoM0yQ==
X-Received: by 2002:a05:620a:2802:b0:765:a496:8a63 with SMTP id f2-20020a05620a280200b00765a4968a63mr28055417qkp.4.1691086587440;
        Thu, 03 Aug 2023 11:16:27 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id q5-20020a0cf5c5000000b00626362f1bf1sm83358qvm.63.2023.08.03.11.16.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 11:16:26 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_sync: Fix handling of HCI_OP_CREATE_CONN_CANCEL
Date:   Thu,  3 Aug 2023 11:16:23 -0700
Message-ID: <20230803181624.746299-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When sending HCI_OP_CREATE_CONN_CANCEL it shall Wait for
HCI_EV_CONN_COMPLETE, not HCI_EV_CMD_STATUS, when the reason is
anything but HCI_ERROR_REMOTE_POWER_OFF. This reason is used when
suspending or powering off, where we don't want to wait for the peer's
response.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3348a1b0e3f7..420d25cce2b0 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5317,6 +5317,17 @@ static int hci_connect_cancel_sync(struct hci_dev *hdev, struct hci_conn *conn,
 	if (hdev->hci_ver < BLUETOOTH_VER_1_2)
 		return 0;
 
+	/* Wait for HCI_EV_CONN_COMPLETE, not HCI_EV_CMD_STATUS, when the
+	 * reason is anything but HCI_ERROR_REMOTE_POWER_OFF. This reason is
+	 * used when suspending or powering off, where we don't want to wait
+	 * for the peer's response.
+	 */
+	if (reason != HCI_ERROR_REMOTE_POWER_OFF)
+		return __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN_CANCEL,
+						6, &conn->dst,
+						HCI_EV_CONN_COMPLETE,
+						HCI_CMD_TIMEOUT, NULL);
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_CREATE_CONN_CANCEL,
 				     6, &conn->dst, HCI_CMD_TIMEOUT);
 }
-- 
2.41.0

