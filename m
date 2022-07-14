Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DA7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jul 2022 18:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbiGNSM3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240548AbiGNSM1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Jul 2022 14:12:27 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A709968DD1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jul 2022 11:12:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso3872392pjh.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jul 2022 11:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b4xVFVSEIg+FQbYqtvkofSb1Qt8mWH5Xuxpasnfdit0=;
        b=h5gsb1qEPujbWQrhBNlWZ2UitjQpX0QQDMADPaJevp8aWh9pgabRVNV+SeSyvecfB+
         4hJ2ai4KYAcTYmbVkSaYjqy+lQ4GhD4mCr195YHYppfaz854xtYwnbZEggbGfYCGF3bn
         5QFu3rddlnpQvnkl51EShSVj/PFtK9iBJI0sPXmTnzG2Q9QgXeBD4XNdED3YejWudVeH
         HBc5OKYDq5TNwE5MVUAD71+lgAQ069C8Gz+95JKakBYrigDSQeFF4iFwAvhe5Yu4FvHc
         gWfVTDFzRNpWK9GlVqw9nT8PNWEj8aEPJ7ecCRoZo6WAwitb6wASuTiwKm6sk3zWORwt
         jTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b4xVFVSEIg+FQbYqtvkofSb1Qt8mWH5Xuxpasnfdit0=;
        b=Sr5CfUlcqhD8hTLEwhZIcVnrgcs4z9wCPKzJqT4MidhQbsDtbwwxCsxsMSG/LvWUsL
         PV4dZP48EHTW3/YlNJfy2sqlvl6gDMIQ/jFBKp/9HCmHswU+z9FZNE/R4TfDlTgvNErd
         pMWzl/Kw7oPLSgCK2WIDQJK55E71Afx17gn7R5aF2nZaLu6WrRqxwdvTzRnAXTkYIllo
         QUWAm/u5JDYkaDU2/bMQXoj6qrBKRd/gOkZWDItSeBXphy+jIB7hzy8CCDBM5l4aXuxZ
         Os2vfrdUyEDte6srQ2PEfWIs+BJS/GeGewNILhmYyn+7wWIGe/SqZuFJGhvjqCL7k12x
         ATlw==
X-Gm-Message-State: AJIora+mzJ0tZJEfbOikm/S1Fwuc1ODrN8lU33I82jjzVxZoKtw/KOIp
        +tIMuhoUWHYH6UlO9PE7jliuPumbRDo=
X-Google-Smtp-Source: AGRyM1u3G2ZXZxVpEY2B94qyyhU22Ao3b7DgHi+lMcpYBxzCgANOKXJMusXOFUzQS7o5ZuhP/CSj3w==
X-Received: by 2002:a17:902:b694:b0:16c:29d9:7308 with SMTP id c20-20020a170902b69400b0016c29d97308mr9664222pls.110.1657822345648;
        Thu, 14 Jul 2022 11:12:25 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id l4-20020a170903244400b0016bf24790e4sm1833145pls.21.2022.07.14.11.12.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:12:25 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: hci_sync: Fix not updating privacy_mode
Date:   Thu, 14 Jul 2022 11:12:23 -0700
Message-Id: <20220714181224.3793757-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When programming a new entry into the resolving list it shall default
to network mode since the params may contain the mode programmed when
the device was last added to the resolving list.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=209745
Fixes: 853b70b506a20 ("Bluetooth: hci_sync: Set Privacy Mode when updating the resolving list")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Tested-by: Zhengping Jiang <jiangzp@google.com>
---
v2: Use HCI_NETWORK_PRIVACY instead of 0x00

 net/bluetooth/hci_sync.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ca97378fd81f..256ece5640b7 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1636,6 +1636,9 @@ static int hci_le_add_resolve_list_sync(struct hci_dev *hdev,
 	bacpy(&cp.bdaddr, &params->addr);
 	memcpy(cp.peer_irk, irk->val, 16);
 
+	/* Default privacy mode is always Network */
+	params->privacy_mode = HCI_NETWORK_PRIVACY;
+
 done:
 	if (hci_dev_test_flag(hdev, HCI_PRIVACY))
 		memcpy(cp.local_irk, hdev->irk, 16);
-- 
2.35.3

