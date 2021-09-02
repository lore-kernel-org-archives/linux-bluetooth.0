Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD55C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 20:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F55610A0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 20:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346403AbhIBU3A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 16:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346378AbhIBU27 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 16:28:59 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B676BC061575;
        Thu,  2 Sep 2021 13:28:00 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id h1so5856765ljl.9;
        Thu, 02 Sep 2021 13:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L/XPe5J/UPsh6FybYM/Na2gfn+TiWBfcKQ0DWNm4GDE=;
        b=DRAYiVS6k7GXaomHZuO4boBpJDM/ZklXBMTv2eQWD+k8g6BIEPM0c7rDTIqEN9koLM
         +LjPYm/JhB0aU7D8417a4tXRBphgIiU5Oy6M1xiascEWzQUBnlleihFUeKhBA7gwY9FW
         ZjiFF76QKojm8vaQYhLALPgpF8ctE6ngoKuhNvxkj6JCn4aNkiZXxn4GhSfPQ+iK/LFW
         mjc0kH7ti9wEgPYX7J0XrKDHDaWq+l3aoUzsCgfA1KyP/20g3tIjIq4/9Sd2vWPYYQbP
         yZTrz/KB2qAwyFUQXwfUerdaXNmKxuxO0qAAN2P9OT3kIm5quADsOEn/a/Gycb/6gJs7
         GYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L/XPe5J/UPsh6FybYM/Na2gfn+TiWBfcKQ0DWNm4GDE=;
        b=KT76v/21mWDpv+mo7w3KPk8koYLkoZCSGjX/u6azeU8lIo8BP0RTMNxeQ1qmr8NwYv
         1GOBnabP+daQIZkvGs+h1o7aoxoDXm0HLmELHNhqEp6g1Tomy+59CIZdnhWu+Kgy/LaH
         k9iLfgUBZo12EZasfp9Y2Qf828Y7mh/LeiwiO7wniJCQiKC4XasKAPgKFCYc0EqCfOgG
         Q51VOs5bAgSAPYeYszzT8U8akqkLFr7X4OCI1TK7+LP9BBCs0kFe6fV60h2BLUvEzpe6
         Q88FXcCgl1Tmj+xS8kBmgwD/t3uMBorqulIx18fuARGuGRG7NPZfvxEMVpc8dzfUCQcT
         NavQ==
X-Gm-Message-State: AOAM531AWUyhKwDNAUVDzgpVgtoS3JBnLsYKpw1XLne4DMpIqBrKXb9e
        JHHOFvWOVWcTSD32xFIMvkY=
X-Google-Smtp-Source: ABdhPJwcCXq8s0tHEocKg+g0IBec+6NSz2wfODR1zY7p9BtXuMoQeJ1lR24lw5CzpmTGiX7rddpXFA==
X-Received: by 2002:a2e:9b8e:: with SMTP id z14mr54334lji.411.1630614478802;
        Thu, 02 Sep 2021 13:27:58 -0700 (PDT)
Received: from localhost.localdomain ([46.235.67.70])
        by smtp.gmail.com with ESMTPSA id x6sm290990lfd.208.2021.09.02.13.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 13:27:58 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     apusaka@chromium.org, abhishekpandit@chromium.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+7d41312fe3f123a6f605@syzkaller.appspotmail.com
Subject: [PATCH] Bluetooth: hci: fix GPF in h5_recv
Date:   Thu,  2 Sep 2021 23:27:56 +0300
Message-Id: <20210902202756.25378-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Syzbot hit general protection fault in h5_recv(). The problem was in
missing NULL check.

hu->serdev can be NULL and we cannot blindly pass &serdev->dev
somewhere, since it can cause GPF.

Fixes: d9dd833cf6d2 ("Bluetooth: hci_h5: Add runtime suspend")
Reported-and-tested-by: syzbot+7d41312fe3f123a6f605@syzkaller.appspotmail.com
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/bluetooth/hci_h5.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 0c0dedece59c..eb0099a21288 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -587,9 +587,11 @@ static int h5_recv(struct hci_uart *hu, const void *data, int count)
 		count -= processed;
 	}
 
-	pm_runtime_get(&hu->serdev->dev);
-	pm_runtime_mark_last_busy(&hu->serdev->dev);
-	pm_runtime_put_autosuspend(&hu->serdev->dev);
+	if (hu->serdev) {
+		pm_runtime_get(&hu->serdev->dev);
+		pm_runtime_mark_last_busy(&hu->serdev->dev);
+		pm_runtime_put_autosuspend(&hu->serdev->dev);
+	}
 
 	return 0;
 }
-- 
2.33.0

