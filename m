Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B731FC77B7A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Jun 2023 19:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjFGTpZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jun 2023 15:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFGTpY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jun 2023 15:45:24 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507E1101
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jun 2023 12:45:22 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-650c89c7e4fso8014723b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jun 2023 12:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686167121; x=1688759121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xT3kADPrEvXYhvJJ84lwwdvqcicdAyqwnsVNnVpMXxw=;
        b=dLP7cJo6yp3VPevaayr2z99NvSY3o2yHE9fpgAt6bFMUpq9EByKd9jFY6fu0RDTxaM
         4JQRvDmYsZ5vCY0113a/JiECwKKs0pUFiv83pqg4/5oWnicz/fgOsvMV+ezgxwPIIr1s
         eH5KDktV0hYCnR7YYA3+LDDH4+EdVrQv4EdX3YrvVdUgZxZ2ffTgW7AmfdoNdTtYg/Xn
         B6qIti6vfIJGp+pV9C0xdP+hrkcfVuMXvrxixB4/CwoRU9FOfmQkXaDOMvdvoNk3DTSR
         +V09py3S4aia4L181xgMt+YEj8lStUAMwaXPqp58oUPJammEuvtXQPDiQXu0JN0JXg+2
         VEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686167121; x=1688759121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xT3kADPrEvXYhvJJ84lwwdvqcicdAyqwnsVNnVpMXxw=;
        b=TbtgLOuDSuhNVsPOclBwp8qPaaOJrzqErfV4tuH/toX/KE6RqpW7fJkqVlD+4BEZta
         7yoi79Itz0+bS9AZlH9z8tDkgucY1n0sklmx+SFpRFMEAJ9Mohyoj9/nY5Vu2RHnaDhv
         6DdFmLc5A3/ObqVNn0vF0X3ndhRjE+4AUuO56vOIg6MOCuPJ8hX+p3J3Fw0yK/70IvqS
         cYsq8W7QvaUYDlgTtP+E09WV6JC7EevwYiX+IEA1N2yizqpkkVo5wTZr9sRju4upxMzI
         qGo6/jZCVUlDI00PcSxcxRT+CbnMjSAAtSRMA/sGaVEENAhlHTi+a6lnD5StgcKfQxKA
         svxw==
X-Gm-Message-State: AC+VfDwDx5i4+xMh8bRpOyGM9jNW2Cs+1CtnpIbbIq5Kq9Kv4ntomvVt
        1TZsaaSIDCJLt83NBUFdgsuIRS93mjU=
X-Google-Smtp-Source: ACHHUZ4a3k3XOzEvtOZpDiaP2BUmXDDwscQbTsPVKLwBQN0WtbRuDw6d0AhHZpProXTqluhunzJTaA==
X-Received: by 2002:a05:6a00:8d6:b0:654:ab4:305 with SMTP id s22-20020a056a0008d600b006540ab40305mr8444823pfu.2.1686167120736;
        Wed, 07 Jun 2023 12:45:20 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b00642f1e03dc1sm133807pfb.174.2023.06.07.12.45.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 12:45:19 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: MGMT: Fix marking SCAN_RSP as not connectable
Date:   Wed,  7 Jun 2023 12:45:18 -0700
Message-Id: <20230607194518.2901376-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When receiving a scan response there is no way to know if the remote
device is connectable or not, so when it cannot be merged don't
make any assumption and instead just mark it with a new flag defined as
MGMT_DEV_FOUND_SCAN_RSP so userspace can tell it is a standalone
SCAN_RSP.

Link: https://lore.kernel.org/linux-bluetooth/CABBYNZ+CYMsDSPTxBn09Js3BcdC-x7vZFfyLJ3ppZGGwJKmUTw@mail.gmail.com/
Fixes: c70a7e4cc8d2 ("Bluetooth: Add support for Not Connectable flag for Device Found events")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/mgmt.h |  1 +
 net/bluetooth/hci_event.c    | 15 +++++----------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 7eeec8501846..d382679efd2b 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -981,6 +981,7 @@ struct mgmt_ev_auth_failed {
 #define MGMT_DEV_FOUND_NOT_CONNECTABLE		BIT(2)
 #define MGMT_DEV_FOUND_INITIATED_CONN		BIT(3)
 #define MGMT_DEV_FOUND_NAME_REQUEST_FAILED	BIT(4)
+#define MGMT_DEV_FOUND_SCAN_RSP			BIT(5)
 
 #define MGMT_EV_DEVICE_FOUND		0x0012
 struct mgmt_ev_device_found {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7c199f7361f7..13319757258f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6327,23 +6327,18 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		return;
 	}
 
-	/* When receiving non-connectable or scannable undirected
-	 * advertising reports, this means that the remote device is
-	 * not connectable and then clearly indicate this in the
-	 * device found event.
-	 *
-	 * When receiving a scan response, then there is no way to
+	/* When receiving a scan response, then there is no way to
 	 * know if the remote device is connectable or not. However
 	 * since scan responses are merged with a previously seen
 	 * advertising report, the flags field from that report
 	 * will be used.
 	 *
-	 * In the really unlikely case that a controller get confused
-	 * and just sends a scan response event, then it is marked as
-	 * not connectable as well.
+	 * In the unlikely case that a controller just sends a scan
+	 * response event that doesn't match the pending report, then
+	 * it is marked as a standalone SCAN_RSP.
 	 */
 	if (type == LE_ADV_SCAN_RSP)
-		flags = MGMT_DEV_FOUND_NOT_CONNECTABLE;
+		flags = MGMT_DEV_FOUND_SCAN_RSP;
 
 	/* If there's nothing pending either store the data from this
 	 * event or send an immediate device found event if the data
-- 
2.40.1

