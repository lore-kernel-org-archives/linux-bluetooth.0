Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3AEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jul 2022 00:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiGNAWn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jul 2022 20:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiGNAWl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jul 2022 20:22:41 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F34115FC3
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jul 2022 17:22:39 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y141so419479pfb.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jul 2022 17:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CvPxkbMOFRl8cd2zgxoRK3eBdp3uTFiraVv+yOUnTWo=;
        b=kO0/Ztbo8ANkOdq6LIJTmUIrm9ANIYfnUZD53gKF67wb+4k1jBJYmgaAw14epGfusF
         6MYTQj7o+23QLTOE+BX6Ikw1UnkNisgbcp1a+pla57EtGSrBIHB5fhUtAaZfJkb2EXu2
         4OR/QRnFVrdsxRTanOIIQWhqTWXvSNrSSn4iywXeRKaApnAQ1lw0xiK6QvwZnN6jLyxU
         4z5eRy3Ze+NjfezulOB2okti3iZx5LzLt2wdod+g12X70n30enD5HLWBw5JKR7CVKBrT
         3KRJqLPDrUhNTdUwS/T9XBYvnx4+FTE8H4QWEZfT8JcZ5z9VdmvE7agFzq9sgblfEnjm
         DiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CvPxkbMOFRl8cd2zgxoRK3eBdp3uTFiraVv+yOUnTWo=;
        b=gBcMpUWnN5SmQbmypQ/g/4R+rsCsPqBDrCa4BUom8S8a4PCxmo3QYR2cEToXnlsiRN
         CFK5vJ8uEGacgv3AOG24MB7D9NDJm+Lk1S+BHEkTs/CoRpBenDw0Gu9hoWuVALqkIDd1
         2EACyGnAuERhZXwLn0E3BIaTUiow0+Z/9jwwbU+NDKkhaZCgbR1kWdDS4hqdUW7piQBg
         UUtCm/fRouauhy+31T6uWRn/rm4UHseCZahw8pBFu1aG5oixsPHSyLRB2dxKjBOXVr+W
         DC/ozxJhpt6puYThyslQoT6KtrclWrnwPquL55k5Kc8sbaRRZlUOSgtj4aHWrstnhL6K
         m8lg==
X-Gm-Message-State: AJIora96bc0YoBvpMwZfiGN9xLuuFHgcLrH+qgEUtQwlYl+g870ckakV
        YcdTIBzS3h5ILTtqmXgKrU+xJBrWNNo=
X-Google-Smtp-Source: AGRyM1syS8aNJupbd6jAYAaVV53pHgLyQZDynFhb5OW6fjdMz0a90PDzUnrWcO602Sv+zneF7kF18A==
X-Received: by 2002:a05:6a00:cd5:b0:52b:1744:af86 with SMTP id b21-20020a056a000cd500b0052b1744af86mr2664586pfv.19.1657758158352;
        Wed, 13 Jul 2022 17:22:38 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id mm18-20020a17090b359200b001efa35356besm2221893pjb.28.2022.07.13.17.22.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 17:22:37 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_sync: Fix not updating privacy_mode
Date:   Wed, 13 Jul 2022 17:22:35 -0700
Message-Id: <20220714002236.3540353-1-luiz.dentz@gmail.com>
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

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ca97378fd81f..9f44537db348 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1636,6 +1636,9 @@ static int hci_le_add_resolve_list_sync(struct hci_dev *hdev,
 	bacpy(&cp.bdaddr, &params->addr);
 	memcpy(cp.peer_irk, irk->val, 16);
 
+	/* Default privacy mode is always 0x00 (Network) */
+	params->privacy_mode = 0x00;
+
 done:
 	if (hci_dev_test_flag(hdev, HCI_PRIVACY))
 		memcpy(cp.local_irk, hdev->irk, 16);
-- 
2.35.3

