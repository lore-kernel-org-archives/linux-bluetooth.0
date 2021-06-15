Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A70C48BDF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jun 2021 20:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0707C61246
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jun 2021 20:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhFOUCR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Jun 2021 16:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOUCR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Jun 2021 16:02:17 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC598C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jun 2021 13:00:12 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id c10so7120536uan.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jun 2021 13:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s62CKXgVmpTv3Pbh3kq5p9fmUR9qdyF2LkClO6mrLRI=;
        b=W+CaWvdPpa723VzYoqgwVTatzy6gKZuIOfsDHgY8fK+vxEn+KrAbVbckt5X5NwVnqc
         EziRc5XFIysi9obUDTQi9I55TcsNmmzIl0RtJ0rnNBhwGMsHuXztamHIgZnFdTaUp6VL
         4Xkk98IwT2iPHNUNwH23kWprSBIFhGQghddj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s62CKXgVmpTv3Pbh3kq5p9fmUR9qdyF2LkClO6mrLRI=;
        b=YBjg6vXQc262dhP7sRAO0gLaG79VzLvMC/8fBGxyUe4Mljq3BDBBp8oP0gcP5T+BPA
         0JESgCK/j8IVPcsVotXthw/epoQtSk+u2KJiQHjgUqhHhA5M0MRaB1Y1MXsVY4LO9q/t
         FWGTL+MD6ftpHStRF86lwBS32PIrsQiGRIH7xHUgn9jhTU7guxWYSK6uXrmk9Zitl39R
         IC9AQ1JXEOkYnZ6JSVWqQ8iVXafeXZehAOpn6eRg+ttPoIArb/3dfsvAvVUUaTMsTxjA
         ovWedyGLiEEabLSKgkIXjHm++ns7j0P/XvCWRfSQlnW7LHQjXs8kR7B7nw7QGi2UWrYE
         v5pQ==
X-Gm-Message-State: AOAM533k5HK263B4qzamwlCUzekOs0gSHcmfevHivOr7/6Vbmv9CaJE9
        /BPdK+IR3FzGP7JgDM8p8KJ0dPKiQAjUhw==
X-Google-Smtp-Source: ABdhPJyTdijrMaKokm7sUcneIzZ7ulM/xA7of/ZSigTY769QSZbn+Npuv+BHZrSZdpzYFuNLYuJ4CQ==
X-Received: by 2002:ab0:2841:: with SMTP id c1mr1128522uaq.124.1623787211349;
        Tue, 15 Jun 2021 13:00:11 -0700 (PDT)
Received: from alain.c.googlers.com.com (162.116.74.34.bc.googleusercontent.com. [34.74.116.162])
        by smtp.gmail.com with ESMTPSA id r205sm2753vkr.47.2021.06.15.13.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 13:00:10 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>, Yu Liu <yudiliu@google.com>
Subject: [Bluez PATCH] monitor: Adding missing device found flag in the parser
Date:   Tue, 15 Jun 2021 20:00:05 +0000
Message-Id: <20210615200005.946131-1-alainm@chromium.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

A new flag was added to the kernel implementation of the Device Found
event, but had not been added to the parser leading to an "Unknown device
flag" error in btmon.

Reviewed-by: Yu Liu <yudiliu@google.com>
---

 monitor/packet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 82513a63c..2c3a6cebf 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -12033,6 +12033,7 @@ static const struct bitfield_data mgmt_device_flags_table[] = {
 	{  0, "Confirm Name"	},
 	{  1, "Legacy Pairing"	},
 	{  2, "Not Connectable"	},
+	{  3, "Connection Locally Initiated"	},
 	{ }
 };
 
-- 
2.32.0.272.g935e593368-goog

