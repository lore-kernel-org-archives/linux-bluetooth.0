Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B65BC43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 23:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5EDE208A9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 23:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jfRasZRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbgIJXP7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 19:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgIJXP6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 19:15:58 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED714C061573
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 16:15:57 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id md22so1833087pjb.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 16:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2F5IK3qZINJFDEk93oe4o+MOz1G8iOkBit6CICWcYW8=;
        b=jfRasZRMcAvd4x1ZNWM1q00IZXvYjePr/UPbQO/ByaYen9gfVeFY3ku86CfOaFK9zO
         1zW+VSnpqxBNcVbmL7i6KkDNLsYLsprwxpt33134exD1lttWz0Pt5hKQmjzU9cggkFrw
         7NC0GbyBtcSXokbtRquCpNmX7j04Zs/qR8xGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2F5IK3qZINJFDEk93oe4o+MOz1G8iOkBit6CICWcYW8=;
        b=dwCglpFW+2D4XQJ6QwVupHX3h9Fy9dex3B+WB7zIg5gwUwC7EWCWEk/8vim0aDrfTR
         Ermpt3DwmvCBWXsRCyjWGUyMsKeSoVAIgxwTbMauRbOjp5Yp+wgGONJYwA4WT7uZZkGi
         +PXFPTGcl9cbVFJKN6gImW/+r0yq1+ks2aw13897jsqyxFIigGemifArAmtBxlhNFYT7
         UBQjISWBjs7op/vn83haoEPHQOS0fbxsSU/c8Stu635R44zEupBImHGAVCxKPLbCb7LY
         ruWk0Wl1AS0p1GJwSED0HnN0fwAgPtfVQ7z12NtAE63yYjoIq2J1wXLLTV9LZnVdLmSb
         Myew==
X-Gm-Message-State: AOAM530P4Yn8A2hWFiORs5juj9ENILwNSST9dQqm7/556WiBZf6ZEzj0
        imOvqB5hovgUIFPDvphJ+gbVCq7VqCpBNQ==
X-Google-Smtp-Source: ABdhPJzpMByzqa+jMtoioFNTdJjgfYt+tVzwWXGSXdO8JiL9GFXv3cn+VNGz7GfgdTg+wV0y3HDKtQ==
X-Received: by 2002:a17:90a:a111:: with SMTP id s17mr2175091pjp.28.1599779757122;
        Thu, 10 Sep 2020 16:15:57 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id k29sm76790pgf.21.2020.09.10.16.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Sep 2020 16:15:56 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Manish Mandlik <mmandlik@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v4 1/8] adapter: Remove indirect dependency of headers
Date:   Thu, 10 Sep 2020 16:15:42 -0700
Message-Id: <20200910161528.BlueZ.v4.1.Iaa9dc2a66de5fbfa97627e1dbeb800116d3aa91e@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Given that adapter.h refers symbols from lib/bluetooth.h and lib/sdp.h,
these two headers should be included directly in adapter.h.

Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
---

(no changes since v1)

 src/adapter.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/adapter.h b/src/adapter.h
index f8ac20261..c70a7b0da 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -26,6 +26,9 @@
 #include <dbus/dbus.h>
 #include <glib.h>
 
+#include <lib/bluetooth.h>
+#include <lib/sdp.h>
+
 #define MAX_NAME_LENGTH		248
 
 /* Invalid SSP passkey value used to indicate negative replies */
-- 
2.26.2

