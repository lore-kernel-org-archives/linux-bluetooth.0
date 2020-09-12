Return-Path: <SRS0=izlr=CV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF546C433E2
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7787621D40
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HF1cdL7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgILGvr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Sep 2020 02:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgILGvl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Sep 2020 02:51:41 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3A8C061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 23:51:39 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u3so2730090pjr.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 23:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2F5IK3qZINJFDEk93oe4o+MOz1G8iOkBit6CICWcYW8=;
        b=HF1cdL7LkzySUoFcS6SEPOOi32SNENwEdE4wRna7j0ZrAVhi7iRfBCF3NK7yNk8I1u
         h3/LNS0vVkcIDsqn2affif8Wa2l9J19NQVXcrHEVOqFpZnCpvP1U4HvBbMl2FFUM+xzg
         8tfT7UhPHFdiDktvo0VdrYpWV4HjhF5YckHp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2F5IK3qZINJFDEk93oe4o+MOz1G8iOkBit6CICWcYW8=;
        b=EDlu1D8IEVjgC1tSQ751kGe0vK1v4Qvc+Aktub1LR5g4ZXZvyftctvXs/aiU5jTT63
         +9oS2seC/J0aSMdKfZ/TCFzA2rQvnp7Uur+y9P0hryaNz/IlGtGBnDvAZDdPcmL1zzFu
         OAK4VjWj2MxOjb2rgyhk9CgNXo8xiJeqAUg4LDbZMYZz6fKzff2cfFrcEivGlNVGzUdv
         X0y12jr+fN3AxCCoXFbljU60YnpeY6bq1vtwbVYGaVtQUPC0OuJgBtypX7JUQ5Y06mR9
         88VyKekRS3ZRSZC13CKzpR0qY1BhlsvxgirmyYjAe81BzLRD9hDcn5PAI086IGDYq7gl
         IBNg==
X-Gm-Message-State: AOAM531tkMADWcLvRu+Mj8sNYxIyWhCdeGfovdNb4RIQwIDqcDJkQKNm
        2lIeeKiAuVUVzr6ZdUKUyQxnHVmS9JKXSA==
X-Google-Smtp-Source: ABdhPJwl/dx7ZLSoOZk+GXtc7pp7Oda0oTb4tfbKaybpgmV2jS5BUSPTzeIXPr02tuDIQGiyWICdMg==
X-Received: by 2002:a17:90a:fc8:: with SMTP id 66mr768684pjz.217.1599893498321;
        Fri, 11 Sep 2020 23:51:38 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id hg16sm3440913pjb.37.2020.09.11.23.51.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 23:51:37 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Manish Mandlik <mmandlik@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v5 1/8] adapter: Remove indirect dependency of headers
Date:   Fri, 11 Sep 2020 23:51:19 -0700
Message-Id: <20200911235104.BlueZ.v5.1.Iaa9dc2a66de5fbfa97627e1dbeb800116d3aa91e@changeid>
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

