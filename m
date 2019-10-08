Return-Path: <SRS0=DWZO=YB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6FDC4360C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Oct 2019 09:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DA3206C2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Oct 2019 09:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Qw8wCGLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbfJHJ6k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Oct 2019 05:58:40 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:40979 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730325AbfJHJ6j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Oct 2019 05:58:39 -0400
Received: by mail-wr1-f42.google.com with SMTP id q9so18640925wrm.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Oct 2019 02:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1kwRTRzQbtkXTMXAtmm6XRsqFOIOoB3YH1a58jUf11I=;
        b=Qw8wCGLq3+ryX4ahmP1aIbiMaxY10d5UXN/Cq9d+5ylNX595J8J/aosvCxcxktZy76
         dhOGFy+CUG/BhM+2FdUMY1AkknhLF27h8EhILFF/GYVr+DXWTwfXqYtnbtKawZ5aCut/
         bmtJ488gvSHmJ5dCpBb86345FafsRyJYvsEqN+m6RLw56S0soBudjTMAby50rSewW8zr
         g/Q+qvX4uLZzs33ZOtzY59ZnHr1eBBhdCtNQqbZV2ntZAqikwdF77Z9z2qgw2HF5/kZb
         OoILAj8x4wJriiS2Mqeh7mIuzhv/FlTdg7992GrZaedevJlFNAMWNyLPWr9RecLC8CUe
         W1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1kwRTRzQbtkXTMXAtmm6XRsqFOIOoB3YH1a58jUf11I=;
        b=ne6JC/xJj26ADoO1ygmTL4Qm8z6t/ws4KrdNloZ/SX58euO0j8bI8xlAb6FK90VJ7r
         hluZKnUnazUiIKommUhHrp8Rxk5j6VvYjgomoTWUg9W1Df2g0XnBmJYH8HA5TBCeH0te
         ITDum/YLQ9lxx6MEqCWq+VEHuw6fmWcOlMYp+gq8l7U4gfnnvcN04CeExVA9/kHR/obT
         bxkiuCcM0p/uEHQSmY/8rh5+0rlQH6NK0+dtntwiBuaGwWUycRe6RXYm9SirowYR/3V+
         U1xK1uqRzojjTNQd1ZF/8yjfibE4KaY190/Ytz8yHxLOL9SigWP09Wa2eCIXPn60jzqE
         BfIQ==
X-Gm-Message-State: APjAAAXqBK9E1SdQpw3J5mrQv5zfdqseBKWaRr8eWuu88/z4Rq3KVF/b
        Dx90aKMdYIbncLUYdR0HBt9qrcBO2qY=
X-Google-Smtp-Source: APXvYqznk2zCYGzOP+qGXfXxEMxX5n1LlgS/VRzISMPtnQk7yzsqV3nHu3gn48OByUdIKm2AUAayfw==
X-Received: by 2002:adf:f712:: with SMTP id r18mr6401424wrp.30.1570528717718;
        Tue, 08 Oct 2019 02:58:37 -0700 (PDT)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa. [81.2.106.35])
        by smtp.gmail.com with ESMTPSA id o19sm3567391wmh.27.2019.10.08.02.58.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 02:58:36 -0700 (PDT)
From:   Ross Burton <ross.burton@intel.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] Makefile.obexd: add missing mkdir in builtin.h generation
Date:   Tue,  8 Oct 2019 10:58:32 +0100
Message-Id: <20191008095832.3473-1-ross.burton@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In parallel out-of-tree builds it's possible that obexd/src/builtin.h is
generated before the target directory has been implicitly created. Solve this by
creating the directory before writing into it.
---
 Makefile.obexd | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.obexd b/Makefile.obexd
index d36874770..de59d297b 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -104,6 +104,7 @@ BUILT_SOURCES += obexd/src/builtin.h
 obexd/src/plugin.$(OBJEXT): obexd/src/builtin.h
 
 obexd/src/builtin.h: obexd/src/genbuiltin $(obexd_builtin_sources)
+	$(AM_V_at)$(MKDIR_P) $(dir $@)
 	$(AM_V_GEN)$(srcdir)/obexd/src/genbuiltin $(obexd_builtin_modules) > $@
 
 CLEANFILES += obexd/src/builtin.h $(builtin_files) obexd/src/obex.service
-- 
2.20.1

