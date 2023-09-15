Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62867CD37AD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Sep 2023 21:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbjIOVok (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Sep 2023 17:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbjIOVoV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Sep 2023 17:44:21 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28EAAC
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 14:44:15 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-573e67cc6eeso2043958a12.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 14:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694814255; x=1695419055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=g0NJ00rM78J2vxfcdjbFQShehsm3IO0jGkw1pwoiSoc=;
        b=P9BasCgZMf3Yj9fCIt0bzvi2Bxqbr/v8EGUAZ5g3kwkNESCOY8HfoD83NLmk2Sd9+y
         2jFsaAp3OQ2pKtjaO+iD11SFvb4/Z7NGCdudvsHUZwR2aSZyO5a/cx0VEY2DJl4TXkUM
         trz7mISC11iIkncSsFILRMXzObj2Tubz6OEDxghV54B7H6zweTDhBbjfPiKPhOGr0Y8c
         WwHcg58dPaum5Y4RijJa6xdQN7bOvmwWGcVqmaeFXqDZRuv50a0kC2/4FiLTG+d+W2x1
         OIaR86CrP4J/keM2k7TIs2sHyszQ+AlZTd4xUasGkEh1az2iOF1GITfNmCAXO2JUXFBI
         f10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694814255; x=1695419055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0NJ00rM78J2vxfcdjbFQShehsm3IO0jGkw1pwoiSoc=;
        b=w6qIj5dPEZi59/PeW7+Nk5sfwNmbZbhex53z088qk9SVGvDl2i5HdTtLagsOJtsiGi
         IUDvZ8fn8P0wmDCsTm186f7vovvy2p5k0D6YTt/LHkDpEGr4rQ5os0QY3eU7jpX2+hBF
         mT+kU2DJElaGLw03OASkqQ1wjcJ3Z6c62ljG4MDRBW2DF6bZtiLD0AxowJNeKWoTPJHy
         pid3cNMrYr/wITkUNtXz3pya5xW3gvdnuym9HtTomr58Nc+wak81SIUWuG05z8apkAmb
         d6qhNrYabuoDrXPan+KSgSKrIateEZMIkGK64djxV96il4KLE53z508cIdbUuXhThXwj
         ZhFQ==
X-Gm-Message-State: AOJu0YwnS+NWmW8aZ48ZqFFtSy7m6rPz0NSpK0/YeCHUHRZZ5oauoN/O
        wA9HlmSd4vdQgsX42/AEQTsGuEUYrFE=
X-Google-Smtp-Source: AGHT+IF49Bj2SUwWo01japPgGN3afjvQ/eBys4qLg4yO5LuxaAVi2QgLRMzw8dmP6SEZhkXE6G72mg==
X-Received: by 2002:a17:90b:1481:b0:26b:1364:e784 with SMTP id js1-20020a17090b148100b0026b1364e784mr2655447pjb.0.1694814254690;
        Fri, 15 Sep 2023 14:44:14 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090b010600b002682523653asm3416226pjz.49.2023.09.15.14.44.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 14:44:13 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_core: Fix build warnings
Date:   Fri, 15 Sep 2023 14:44:12 -0700
Message-ID: <20230915214412.3611547-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following warnings:

net/bluetooth/hci_core.c: In function ‘hci_register_dev’:
net/bluetooth/hci_core.c:2620:54: warning: ‘%d’ directive output may
be truncated writing between 1 and 10 bytes into a region of size 5
[-Wformat-truncation=]
 2620 |         snprintf(hdev->name, sizeof(hdev->name), "hci%d", id);
      |                                                      ^~
net/bluetooth/hci_core.c:2620:50: note: directive argument in the range
[0, 2147483647]
 2620 |         snprintf(hdev->name, sizeof(hdev->name), "hci%d", id);
      |                                                  ^~~~~~~
net/bluetooth/hci_core.c:2620:9: note: ‘snprintf’ output between 5 and
14 bytes into a destination of size 8
 2620 |         snprintf(hdev->name, sizeof(hdev->name), "hci%d", id);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index db4f28d68d71..f4a218e1a52e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2617,7 +2617,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	if (id < 0)
 		return id;
 
-	snprintf(hdev->name, sizeof(hdev->name), "hci%d", id);
+	snprintf(hdev->name, sizeof(hdev->name), "hci%.4u", id % HCI_MAX_ID);
 	hdev->id = id;
 
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
-- 
2.41.0

