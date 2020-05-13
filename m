Return-Path: <SRS0=PnVy=63=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E661CC2D0F6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 02:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6EB920722
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 02:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gK3dvzuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgEMCJv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 May 2020 22:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbgEMCJo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 May 2020 22:09:44 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1F8C061A0C
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2020 19:09:42 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f15so6208791plr.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2020 19:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zcD9lBfIOsrbGLPLwHavFpU04q9rS7x1jNQUtnqQyIk=;
        b=gK3dvzuSyDVkWgPlzx40qbLhAs0owj9fIDJoyReMIZDN7XH+poriF7uHhlAQ+w+Fef
         DfYQXms3qL1YXiyZFcegyl/miVUznOD7rrVn1aG88QwK6QTyvVR2rQ9JGnEXNfUDGcCG
         FsW+Xj94YC0MRj70Y4eNIEyKrmXxmy0uYMqWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zcD9lBfIOsrbGLPLwHavFpU04q9rS7x1jNQUtnqQyIk=;
        b=OWMw6mTNO2fGkZSRxeaNVXlJKLZHY1HKeXwJQcz9SO8tnxtFFixECty2g2+xIxYQ7q
         5BkE1Ve/btw9DFukN6WTuGbhKaHMztFJYvXbcQb+pLBLc/8BJ2fKszqqAYS/Li9Ia9Wj
         V4Bm9ShWbSO8mItwvJ0P676QgCyexldn2n9io4LRdBsSz2J/hgpUOZs7Xr+dZUS+N8Bg
         fSb6dHmIxaPOPk21Ca4qVaV+nYQsTQIJQ9gcSvu20nEKjG433wGyHE1r+VBlwvaEOSMs
         dqC5xp6T9tlWJiAaoRzYyiNDdxAyXfGpPzCib5WTuVOzTrXIrVw/6bnzwSs8oIADkXKO
         rQPg==
X-Gm-Message-State: AGi0PuZlNJLQCYCO2pzDYLUdUF1SSpi2kA5cIji3D8mUmElXd9ggy2xa
        Rmg29be3FXjxwaRBQ5Dc0yIdNA==
X-Google-Smtp-Source: APiQypKUVISxkbjbdV4dsOfusvVUfRQZvsmwFin9ROrdrs/K1iU7S4CxumWbbsgAW44gvZn353OnYg==
X-Received: by 2002:a17:90b:2388:: with SMTP id mr8mr30064911pjb.97.1589335782204;
        Tue, 12 May 2020 19:09:42 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id x7sm13456749pfj.122.2020.05.12.19.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 19:09:41 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 1/2] Bluetooth: Fix incorrect type for window and interval
Date:   Tue, 12 May 2020 19:09:32 -0700
Message-Id: <20200512190924.1.Ibdf1535b0d4c63aaf337161a333b419d6d32c364@changeid>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20200513020933.102443-1-abhishekpandit@chromium.org>
References: <20200513020933.102443-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The types for window and interval should be uint16, not uint8.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 net/bluetooth/hci_request.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 3f470f0e432c7..f6870e98faab2 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -890,7 +890,7 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 	struct hci_dev *hdev = req->hdev;
 	u8 own_addr_type;
 	u8 filter_policy;
-	u8 window, interval;
+	u16 window, interval;
 
 	if (hdev->scanning_paused) {
 		bt_dev_dbg(hdev, "Scanning is paused for suspend");
-- 
2.26.2.645.ge9eca65c58-goog

