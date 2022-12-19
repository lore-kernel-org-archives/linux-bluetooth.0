Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CFFC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Dec 2022 23:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiLSXtv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Dec 2022 18:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiLSXtt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Dec 2022 18:49:49 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C6362EF
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 15:49:48 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 7so2220096pga.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 15:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LjJAm8zjgdd5gXSrnTXopaA2EFxOOfMU5ePiRT/qcLY=;
        b=XIz5PEA+re2FKyyi62yYhKVaH9vjblF3HPmjV2oukSc4WkX7SBYwLpTdu3HINPNNqd
         fj40bJDPlAZV0FJEBjJIGxpIUgSdpCEILrbRpxFZ/9MRgxDj+/CyygvGMxpaAQd9DKQV
         UJCao/uE3htVlwc4vhJCyIw6xz8uPi3a7B8FY+Tb+mSFcUkfDZnhdedGyUqtmEvs8M8O
         ujPXOysnvQkv8Kx09K9fvJHoBk53DNAkh3qrq0TnFxbDG+bh3vbPS571sz87hMoeQC/d
         Mt1v+muduwqXsC5aS/BtdLyQjt5Ml/gT0G++9/L8H83exRzPZszpnDaRi0JmcBQlYsNh
         /GWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LjJAm8zjgdd5gXSrnTXopaA2EFxOOfMU5ePiRT/qcLY=;
        b=2l706+F2d8llBYpQTFTTEYf9qu1y8KwSDsdoPS8bK74byUSe78nOeHU0cObqMGMqmP
         oNKdpHHboSLD4SEgPE+ki7F4sStvIXUbtmiUPfo12SqPIydLboJUsGIL+oscvijXyys+
         UuTngmq/iS2LUo8V/k2ex1FL9axWFa4jwEUwGQJmveB9WqggEYZe8rU6YKRb+Pt6eL30
         mk/ItJfl658lDKvpUIRjnItauZdehltQk7kD9BmAw7w/zqvalbD3DImR5TLRWbFoVKkX
         SZtmg8V7K5qQcoZaMNA48MN2OVRDB1feUOr3yO8gpvNKnq/tjNm8+QS1WXYozz61M9nW
         cjlQ==
X-Gm-Message-State: AFqh2kqD1IBeYp6oGnB6U7x59kvMVaUXLGIC3PgUCoPQJaGgF5dhZ+0O
        +eyaTA5rO4dvWIsiuSmprnWPPOpaqkaDFg==
X-Google-Smtp-Source: AMrXdXv6DSRodmSWAOMSDIg++B0jencoZtsg0lZR6HtxQtruzKYQVqcyHewz2WFMgZ5q+G7pvabU/w==
X-Received: by 2002:a62:1852:0:b0:56e:664f:a5f5 with SMTP id 79-20020a621852000000b0056e664fa5f5mr11967851pfy.8.1671493787270;
        Mon, 19 Dec 2022 15:49:47 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id c205-20020a624ed6000000b005765013d327sm7184881pfb.182.2022.12.19.15.49.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 15:49:46 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_sync: Fix use HCI_OP_LE_READ_BUFFER_SIZE_V2
Date:   Mon, 19 Dec 2022 15:49:45 -0800
Message-Id: <20221219234945.3733741-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Don't try to use HCI_OP_LE_READ_BUFFER_SIZE_V2 if controller don't
support ISO channels, but in order to check if ISO channels are
supported HCI_OP_LE_READ_LOCAL_FEATURES needs to be done earlier so the
features bits can be checked on hci_le_read_buffer_size_sync.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216817
Fixes: c1631dbc00c1 ("Bluetooth: hci_sync: Fix hci_read_buffer_size_sync")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5220bfd75b00..fcf4a9af3c62 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3572,7 +3572,7 @@ static const struct hci_init_stage hci_init2[] = {
 static int hci_le_read_buffer_size_sync(struct hci_dev *hdev)
 {
 	/* Use Read LE Buffer Size V2 if supported */
-	if (hdev->commands[41] & 0x20)
+	if (iso_capable(hdev) && hdev->commands[41] & 0x20)
 		return __hci_cmd_sync_status(hdev,
 					     HCI_OP_LE_READ_BUFFER_SIZE_V2,
 					     0, NULL, HCI_CMD_TIMEOUT);
@@ -3597,10 +3597,10 @@ static int hci_le_read_supported_states_sync(struct hci_dev *hdev)
 
 /* LE Controller init stage 2 command sequence */
 static const struct hci_init_stage le_init2[] = {
-	/* HCI_OP_LE_READ_BUFFER_SIZE */
-	HCI_INIT(hci_le_read_buffer_size_sync),
 	/* HCI_OP_LE_READ_LOCAL_FEATURES */
 	HCI_INIT(hci_le_read_local_features_sync),
+	/* HCI_OP_LE_READ_BUFFER_SIZE */
+	HCI_INIT(hci_le_read_buffer_size_sync),
 	/* HCI_OP_LE_READ_SUPPORTED_STATES */
 	HCI_INIT(hci_le_read_supported_states_sync),
 	{}
-- 
2.37.3

