Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5092C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Dec 2021 20:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345408AbhLVUWG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Dec 2021 15:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345404AbhLVUWF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Dec 2021 15:22:05 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6307C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 12:22:05 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so1648323pjf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 12:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zUXLkQIGuZPRq7lrp5Mj2X4hYqr5vbFjctG5OdM8TQE=;
        b=XJI1j4IlrAJaSJq5vTL8GFbcbhy2+9228NqPAwuYF8GUuF1TWgxygW811jUP8ZhEco
         UBcy1cZZCTjaqntMI1CvJYJaPpz3cnc/lNWHW01tIMcV+K60a0LEV5Ko3Mlls7KTA7KU
         wyhwwKH8BMBt6h/DM1qRzmuZq8KmyoZZ+5hHVrNolF8PaJcdmxyf8CpXjrVnnBqSZdiq
         wWduI7cQ+/yBMRmPwPnH5HUufcMK720dOvtVXON+TCdIkmINLwng9HJxBY+wetJsPAJ5
         5K3tMg5imi6SJE1p2uvd8Jj+TQszz/WhVk2/TNw8YOBh+P/yUt1rkbLPMiguyZ+NY5nY
         oxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zUXLkQIGuZPRq7lrp5Mj2X4hYqr5vbFjctG5OdM8TQE=;
        b=BqZkGUc/VN0uCUe1AaRmUAnzSM+beYAJPT/jo87n1qDQcdQkHnUIGxnhcbwQZVYETq
         dx/13g1ystpv4CvHCGzLD3ntHbDwbj8AQDPaNVBp6nY+0x0r72lQALkCM9cSwee2U+QJ
         1WSwhmd1LBnJ+Fp646hWBusZl7toU8H4EdQ4g75WblfcYaR+6p97u/VwQDWZY00Ms7mA
         5vMoXHpTG5V8XRvknPdTb1Z/RPUo2JCC6DTCgH1YVVRZR2jVHf7jw/q+Rj8d1F86U3ml
         Bg52h60Bp66X4Xegw5FA0YX55KOyG2xuieiQKTXRRdX6XcAzA39+mjlldU7DEfRFwDrA
         WhiA==
X-Gm-Message-State: AOAM532wAAyMVz6FtGhZZDd/xQ7BTadSjsdVjAUBYjytmjlB065thY5R
        BuDeROpcWHQFsUyhrOy0giCmb00umHc=
X-Google-Smtp-Source: ABdhPJzXCW2ZWLaYoFyCnAfo/W4AypJNAerI2eeq+09lfk/DOj4d01CHJd0OM8SvpvU+UgujHsjg+w==
X-Received: by 2002:a17:90b:198b:: with SMTP id mv11mr3143957pjb.12.1640204524968;
        Wed, 22 Dec 2021 12:22:04 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x25sm1285266pfu.113.2021.12.22.12.22.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 12:22:04 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 3/6] Bluetooth: hci_sync: Wait for proper events when connecting LE
Date:   Wed, 22 Dec 2021 12:21:58 -0800
Message-Id: <20211222202201.977779-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211222202201.977779-1-luiz.dentz@gmail.com>
References: <20211222202201.977779-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When using HCI_OP_LE_CREATE_CONN wait for HCI_EV_LE_CONN_COMPLETE before
completing it and for HCI_OP_LE_EXT_CREATE_CONN wait for
HCI_EV_LE_ENHANCED_CONN_COMPLETE before resuming advertising.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 334dc5f436a0..8c50a12ba5f5 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5182,8 +5182,10 @@ int hci_le_ext_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn,
 		plen += sizeof(*p);
 	}
 
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_EXT_CREATE_CONN,
-				     plen, data, HCI_CMD_TIMEOUT);
+	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_EXT_CREATE_CONN,
+					plen, data,
+					HCI_EV_LE_ENHANCED_CONN_COMPLETE,
+					HCI_CMD_TIMEOUT, NULL);
 }
 
 int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
@@ -5269,8 +5271,9 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
 	cp.min_ce_len = cpu_to_le16(0x0000);
 	cp.max_ce_len = cpu_to_le16(0x0000);
 
-	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_CREATE_CONN,
-				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	err = __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CREATE_CONN,
+				       sizeof(cp), &cp, HCI_EV_LE_CONN_COMPLETE,
+				       HCI_CMD_TIMEOUT, NULL);
 
 done:
 	hci_resume_advertising_sync(hdev);
-- 
2.33.1

