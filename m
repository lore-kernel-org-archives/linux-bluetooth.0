Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323B4C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Dec 2021 23:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345170AbhLJXkv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Dec 2021 18:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243792AbhLJXku (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Dec 2021 18:40:50 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8135C061746
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Dec 2021 15:37:14 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso10583858pji.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Dec 2021 15:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Wthr/D2H4eVeDvnmZp/LJ4QsADlMdM8XxZk8hLPMMs8=;
        b=MncqbjyRp8LGa+4qCMgOWDb/sqYrz/L8w7yP/RTIZjvcQrz5OHLZkmWRNKOiliSw+g
         3UuxJ0ph64kRmeHmLimQfpPdvOCXo3wd/v90B69G4TeGg4shDXdjMy/CyyWJdfDbmaIf
         JST/Fp5wf+fLTym32RpN6T0TXufXlO/MCEpYU3ggvjm/v5wNFmZIURYe7HC4NIk8o8eF
         l5XoBmOKDLdzrHLAlhMcK6lMprEyTj//76WwMTZt4rTrXwv7T6w31XYsrAKR+P30FXnJ
         XY2t5Q2oQyuoqoBqxyVk7cJtfNuIdcCJ7I9z5G5OV3ybwElAYyuKXQpdkT0ReFocf9t6
         hONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wthr/D2H4eVeDvnmZp/LJ4QsADlMdM8XxZk8hLPMMs8=;
        b=iNu+kTAxK728m6YFtLahz/pDneblLch1DV9srGb+slajigpHIdlAgQokOCHH7/J1mx
         ObJc/ui4r6i/ddaxtMxMbxLl106HzfFWOqimh2DWtI/OI78HOdUC92iX3BXwQRi2uYkk
         Dyr7fs+rTRPmByTxhQudMQX1GKpwIzvBERRyn4ppySioQV9sgFQXFUGUZXo20OHlMr3/
         L9kFCinNO2v+Kq+0O8Hq0PfgvXh+hiaUsSrULBe3zf6yhqbLo3WaKHOimr7PCr6ws1ft
         agAHJDDmnunZJ3ag+i63801su0Y4zL4uGxn8MARLjxsUA1nhTf9EpPvVOD1bLpY+RhEO
         g5qQ==
X-Gm-Message-State: AOAM5325/rti7YRs73RCq9hCd8SE8JT9/2udGIy099kCDlHlSXqcth26
        n5B5FbEGFvd7bvN0nri79OSfHdsHYXk=
X-Google-Smtp-Source: ABdhPJxZhqwxof4vxCUFCkYm/4nJI1HayFU9LKilxzLH9dFh61lBGz19/J4OrOWkuDADoN+kcn2ZIg==
X-Received: by 2002:a17:90b:224f:: with SMTP id hk15mr28106234pjb.173.1639179434005;
        Fri, 10 Dec 2021 15:37:14 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b1sm3659885pgk.37.2021.12.10.15.37.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 15:37:13 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/4] Bluetooth: hci_sync: Wait for proper events when connecting LE
Date:   Fri, 10 Dec 2021 15:37:09 -0800
Message-Id: <20211210233710.1190040-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211210233710.1190040-1-luiz.dentz@gmail.com>
References: <20211210233710.1190040-1-luiz.dentz@gmail.com>
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
index 917652b67194..28d62273d67c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5157,8 +5157,10 @@ int hci_le_ext_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn,
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
@@ -5244,8 +5246,9 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
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

