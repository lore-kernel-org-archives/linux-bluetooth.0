Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026C2C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Dec 2021 19:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241599AbhLMTXn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Dec 2021 14:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242353AbhLMTXk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Dec 2021 14:23:40 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7076C061748
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Dec 2021 11:23:39 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so15409109pja.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Dec 2021 11:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Wthr/D2H4eVeDvnmZp/LJ4QsADlMdM8XxZk8hLPMMs8=;
        b=SYFnQINk9gIRG3LLGvz4sU61iQjzY8NEz/l2PfQeo6SKWlDxTJcYW0LT3Axd//fHzL
         NpkxzwPtBXOUtfaecODVvVoag12WnhWj15oEf5xxaTmTUdOMZeCzJytEJJkQv8iRBoF3
         pKmCcvoLh8A9RoZJDf9nQkNx20uYPG3HneNoyG3Xme9s51prporOq0MzH+PU4Ute3NJe
         X8K1JP07TnkvuWfgLFtcZboS/rOTZeK0KxDD1CqeccWiVOb3Dm1WgQ5rYG5dDmy2HQkE
         zNsXNNIapswOIx9DEerToR0CQvWk32eF0FLdpNEjGHvmB9f8v58J2PbvTxlP2GGxNSlr
         AjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wthr/D2H4eVeDvnmZp/LJ4QsADlMdM8XxZk8hLPMMs8=;
        b=6DijU4xHOYXyriZmK7XOYz2kXfGLE6lZR5Q8beV8hDciwOyBoM+weSGRDBzRmnq4HS
         NA+efGQOFo650XyRuGs5hIYTHA+mvdz2C8/Ct+WxEN0QTT+KvLYBqdQREG9JkFqzJKWf
         v5wmcRfckaHRoANCQ4DlZtIqdsiLNJ/nAsF0U1F5GivmNg0vwbLJNyT+d81blHIgXWd0
         gT6VMrBQ7WhvgECD4QpS4O0ScCwiq1GJLOcAV5m+NSOKQg/LtZElKLOecPcXmCbm84SN
         Y7rjiMhYVWLJZG9gFH1xNQgmGiVQIRRqb9cx4A9OQQii9ugj5TFdxNVs6XGETbax1rp9
         n/YQ==
X-Gm-Message-State: AOAM5317gpmg1HO0Fj+h3ZhQ4SR7pMj57FUEUUXJ5A0QS1ulPwSIPK3d
        +FUEsH/DxdYyHC9WYCUIEq9von2mHFE=
X-Google-Smtp-Source: ABdhPJw/wzjgDHc8LBGTco7p9B5b1Yl9DIyAXi0ilMLO6YZzBUvwEEMnZr4PtvS6P/WEzBfmb5H5AA==
X-Received: by 2002:a17:902:e810:b0:141:d8e9:a8b0 with SMTP id u16-20020a170902e81000b00141d8e9a8b0mr664661plg.9.1639423418977;
        Mon, 13 Dec 2021 11:23:38 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n71sm13512938pfd.50.2021.12.13.11.23.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 11:23:38 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/4] Bluetooth: hci_sync: Wait for proper events when connecting LE
Date:   Mon, 13 Dec 2021 11:23:34 -0800
Message-Id: <20211213192335.2024621-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211213192335.2024621-1-luiz.dentz@gmail.com>
References: <20211213192335.2024621-1-luiz.dentz@gmail.com>
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

