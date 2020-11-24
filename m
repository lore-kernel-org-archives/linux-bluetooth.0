Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0BBC63798
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 10:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96E162076E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 10:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYm+26JV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbgKXK5k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Nov 2020 05:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgKXK5j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Nov 2020 05:57:39 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1BDC0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 02:57:39 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id 5so10502524plj.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 02:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6KwB5wprQiur/WxMPQsHteI1wbH0MA8gM8qoRzcjyT0=;
        b=iYm+26JV0x7cdD5GPH0g/y4uiPpHhMGPm9J+MPe0hZHUeQMSZMVnjw3nbk/L4Bk9PQ
         UtXRP+yhD9/F681ZNYOqYxHn0x/NtOJdA+gtWexRMTBgrcP2J6owM26QacrNKSCT86Pb
         uzX081hO0OGwzsEKa2rCzJF42FHSasgz93ZgFE36bfq/DWI2O4W20E+iwcRAS2oI8B6c
         GN+klXRWe1W2a15QXHxdomtOsjcdX7rWm+b8XO3irve03n7HAMf7d6ApEk3dEaiKyFiQ
         BoMqRdXc9ITZHKjApjcqXAQiplwgHApnD/3syfLnkH0EHViaj7DCiZ/ZiarQxETwfwSd
         LlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6KwB5wprQiur/WxMPQsHteI1wbH0MA8gM8qoRzcjyT0=;
        b=FDJaWssyv35B9V1GpLSWDqhI1ACw6Hy4hWTRzOsQGkRW8WPhBLx7H4LuqIO9tmBi2C
         6aC+rB8/ewSHT2qjQ1V/YalbLdkBmkPIr1i6zBBS+icwvwuYm0/07O2cd1X7zx5kyYCu
         c01LpbZ9pAi7SySraNaX4MExu61N9Fs4vQjgoO3TICUAW7I1LN5kgeVMmB+GuXLwEgLJ
         7NmnBAi/ptaS7hbVbrjdnUK6sd2bLKSLVCx9B/CM5cd66xo5/F/w3Ek5Sgs2Fz9ZTOA/
         BtR5Xwua9Uorhw+2R+HC7No4YvBXLoKoO8nFWuVtZ1l4jhJq8/t5c6fV+HzJpOkaE2YR
         lvqA==
X-Gm-Message-State: AOAM532yhzcRmSub2TljgZKLvaftkJhEUBDH69FVUnyc7yfxVyxgZGup
        Ixe6JAKEqdMFBZoSQ7fh5iKHnW1EdiU=
X-Google-Smtp-Source: ABdhPJxdmbM0Vj2HtG3yGm1mhvGbUWepgqlF8LHGWCcsYXhe8ZyvukYwKQriGqIkDQ4FIO4AnxcZrQ==
X-Received: by 2002:a17:902:c284:b029:d9:c94a:343 with SMTP id i4-20020a170902c284b02900d9c94a0343mr3581036pld.67.1606215459308;
        Tue, 24 Nov 2020 02:57:39 -0800 (PST)
Received: from localhost ([171.76.82.54])
        by smtp.gmail.com with ESMTPSA id z17sm6388024pfn.73.2020.11.24.02.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 02:57:38 -0800 (PST)
From:   Sanchayan Maity <maitysanchayan@gmail.com>
X-Google-Original-From: Sanchayan Maity <sanchayan@asymptotic.io>
To:     linux-bluetooth@vger.kernel.org
Cc:     arun@asymptotic.io, maitysanchayan@gmail.com,
        Sanchayan Maity <sanchayan@asymptotic.io>
Subject: [RESEND PATCH Bluez 0/1] test: simple-endpoint: Add support for LDAC
Date:   Tue, 24 Nov 2020 16:27:32 +0530
Message-Id: <20201124105733.85025-1-sanchayan@asymptotic.io>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds support for LDAC to the simple endpoint script.

It has been tested with the LDAC plugins in gstreamer which recently got
merged and can be found in the two merge requests below.
https://gitlab.freedesktop.org/gstreamer/gst-plugins-bad/-/merge_requests/1621
https://gitlab.freedesktop.org/gstreamer/gst-plugins-good/-/merge_requests/757

For testing this with upstream, gst-build would be required.
https://gitlab.freedesktop.org/gstreamer/gst-build

Sanchayan Maity (1):
  test: simple-endpoint: Add support for LDAC

 test/simple-endpoint | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

--
2.29.2

