Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3945C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Jul 2022 00:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiGLAFt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Jul 2022 20:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiGLAFk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Jul 2022 20:05:40 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D47BDF2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 17:05:39 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 9-20020a631449000000b00412b1418c79so2490078pgu.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 17:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1JpwXxBfHL+adQw1k/M4Xx4GgPy74dDIIx1BqOfF6HE=;
        b=qdJg+sV1ZLY12NdCbWtFBRr9HAPtVRoRvyYrjzWV5P4xFPENTKzw4kkMuCxv8lkuUi
         /B5kQ+fqovXQvljejTKCF0jeYXsS2p6J7khkTKAYhg99QjaOx3b7BTUDSe7/sbkdqkWh
         74Ex8ZdqJ3HX6T1LMVG2pzp06jJabgMAmjomYh9tLZ1f+QFtK4B4f7edSEzxie1HMwrP
         lOh9Et7UzZkKXQ9bRards3gFFNzLuIezTHcOGIHFtAnMmpV7FIuuL2ITptWZM27N9ZKQ
         k7OUnqswKWMn0vb8WyzvdOdHOS9/x/eqY2ytET2xYjaJfUMiXFu0lcBXVqmgEHGp2jPN
         SHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1JpwXxBfHL+adQw1k/M4Xx4GgPy74dDIIx1BqOfF6HE=;
        b=HYcDiR8K4pO0+YoLRxhSyxW79KxT5JwdLAgk0L6L4xgEmK/ebjtRoO6p/vddEPqg50
         y3CdAaY04AzbmTJK9bdRSTrfEmm86sgKOHRttPSRetq8VDcCV/sY35UQ40/DctCbTQ5d
         lxwSpcnTOt7XQrN7d1Q5V6J5Np52UOzJUb9LTL4iHYDIjmVqcCXiZ6UPea4Up3Spz970
         q7rNkdzg5KNoLWp2C7L8UgulwoZffiUJ1ndJ/0l2gAq1t9oul27pn8xlH6kmbOYpw9T7
         1mPI5xpWWMFK7AGAWAcwekVK0lO6Hgcmo2GrFTKfxs79YaZmPjhIqmI6yjpuzGpe76X3
         QUag==
X-Gm-Message-State: AJIora+zkta0e2LG0qjpcGAf51bXvAXj93wrS1xSFzlh5dNDS5lgzT6R
        temhVGyBg4YO33px061DXQXI9LTJ3rcVK/LAlFIhMfGCJx6Ewd0FXIAPlVFDZ4pWfHRHMFmn9Iq
        a/ZxLKA7vISzG02El5vYk/rAR7rV2mkGjEXKDqH1bMQbPXPOxiW8DMZgkqNW3vAcEuQkx6cuqOX
        Qk
X-Google-Smtp-Source: AGRyM1uGAR/JbTrCYF7Tx9Cdkawj0T2Adl/a47tKgYYcay8WPmViBUBPkz1Kd7e+gWfuSLW7XDoOkMwdD3/7
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:90a:bc04:b0:1f0:506d:78b9 with SMTP id
 w4-20020a17090abc0400b001f0506d78b9mr1065616pjr.4.1657584338428; Mon, 11 Jul
 2022 17:05:38 -0700 (PDT)
Date:   Mon, 11 Jul 2022 17:05:30 -0700
In-Reply-To: <20220712000530.2531197-1-jiangzp@google.com>
Message-Id: <20220711170515.kernel.v2.1.Ia489394ab4176efa5a39ce8d08bb4c4b7bee23b9@changeid>
Mime-Version: 1.0
References: <20220712000530.2531197-1-jiangzp@google.com>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
Subject: [kernel PATCH v2 1/1] Bluetooth: hci_sync: Fix resuming scan after
 suspend resume
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     Zhengping Jiang <jiangzp@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

After resuming, remove setting scanning_paused to false, because it is
checked and set to false in hci_resume_scan_sync. Also move setting
the value to false before updating passive scan, because the value is
used when resuming passive scan.

Fixes: 3b42055388c30 (Bluetooth: hci_sync: Fix attempting to suspend with
unfiltered passive scan)

Signed-off-by: Zhengping Jiang <jiangzp@google.com>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v2:
- Reduce title length

Changes in v1:
- Fix updating passive scan after suspend resume

 net/bluetooth/hci_sync.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 7cb3100518799..212b0cdb25f5e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5063,13 +5063,13 @@ static int hci_resume_scan_sync(struct hci_dev *hdev)
 	if (!hdev->scanning_paused)
 		return 0;
 
+	hdev->scanning_paused = false;
+
 	hci_update_scan_sync(hdev);
 
 	/* Reset passive scanning to normal */
 	hci_update_passive_scan_sync(hdev);
 
-	hdev->scanning_paused = false;
-
 	return 0;
 }
 
@@ -5088,7 +5088,6 @@ int hci_resume_sync(struct hci_dev *hdev)
 		return 0;
 
 	hdev->suspended = false;
-	hdev->scanning_paused = false;
 
 	/* Restore event mask */
 	hci_set_event_mask_sync(hdev);
-- 
2.37.0.144.g8ac04bfd2-goog

