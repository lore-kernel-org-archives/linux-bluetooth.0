Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90229C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Dec 2021 00:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238851AbhLHA60 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Dec 2021 19:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238712AbhLHA6Z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Dec 2021 19:58:25 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5FFC061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Dec 2021 16:54:55 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so3155104pjb.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Dec 2021 16:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9A9e1koPlNVL+eyx9T1qletL0N7uiOfsPVaFRftMOF0=;
        b=eu9q5l/RfFFL/vmBHaUgz5w1NchDPgLoFR5V3EW2nvan69FY0d5Pls7ezos9OJajEB
         aztdiK380CjgKuYqZHkzA5Zk/n7U8R3lojrkbc4dfsALwjQaOecdf7O3icYJHbrSwyDx
         qdsqktTPp/KbrhGpzUydhUHlZS8sNLJa0isz4oiBkfZzfVO9mDkYtieuVADk41ZPs2oL
         M8qYG+0r/8fGYX+obkxF/Gz7w9zBnc0m695vX4h/5Uooy1k5QArnSvH3O2Uu8Jlf+JO2
         ElYw97QwxLyc0N0LENaPwj1mWZzY7U54dTAwULCrzcUXtfUX361Sv0iYqm2cox3JggL5
         tCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9A9e1koPlNVL+eyx9T1qletL0N7uiOfsPVaFRftMOF0=;
        b=3L7EQXC4Q2vZjgqAPVPq1vPbqKxuaj9ENy6TpHHRFSK5mWhj+ly6y+SWmHvXkHyyDY
         DB+Wq1XEvODtFebDAcQ7nNUl/DYzaGSiJoCX7Ddb2mPZW8PwP7gqPSXCcEnbp184PRcn
         UZOdSTIWaZlM5d80BJwXR8Pp7z4EwGwtxVNppLGf8s5IlEx7IGCtFbSLaeCazGGmiAPC
         bzABCpJjscKopCk5Qfsk//r4EBytH5TqTPM87xUh3JfhlZUqBzoJIWgu5LKC2BbXy4To
         AixVhifg4TtGiYEyw6Wq0vWzArNwpWnQKXBOShYQf25Inoa3EqzDQRunIzMo2qhu8iTL
         +DuQ==
X-Gm-Message-State: AOAM532hhemMI6ZlElWasKPQhrMvcBXpeBI1cSS6NeEtWU/NUqeB8MEJ
        jl1f3WxBWkjCofYk8hX4slenqDT8onQ=
X-Google-Smtp-Source: ABdhPJx92Nr8xBfrr0xp6ts40CzkTMjtA9t3RCNfMfpo2G+cggsl/ViKJt5RyE5uujWsg0Z7+17/DA==
X-Received: by 2002:a17:90a:4b47:: with SMTP id o7mr3289946pjl.92.1638924894335;
        Tue, 07 Dec 2021 16:54:54 -0800 (PST)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:52cb:f76a:51b5:e541])
        by smtp.gmail.com with ESMTPSA id d195sm604191pga.41.2021.12.07.16.54.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 16:54:53 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 3/5] tools/btgatt-server: Replace random number generation function
Date:   Tue,  7 Dec 2021 16:54:44 -0800
Message-Id: <20211208005446.196637-4-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208005446.196637-1-hj.tedd.an@gmail.com>
References: <20211208005446.196637-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch replaces the rand() function to the l_getrandom() from ELL,
which uses the getrandom() system call.

It was reported by the Coverity scan
  rand() should not be used for security-related applications, because
  linear congruential algorithms are too easy to break
---
 Makefile.tools        | 4 ++--
 tools/btgatt-server.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 63b52c386..45470b767 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -287,8 +287,8 @@ tools_btgatt_client_LDADD = src/libshared-mainloop.la \
 
 tools_btgatt_server_SOURCES = tools/btgatt-server.c src/uuid-helper.c
 tools_btgatt_server_LDADD = src/libshared-mainloop.la \
-						lib/libbluetooth-internal.la
-
+				lib/libbluetooth-internal.la \
+				src/libshared-ell.la $(ell_ldadd)
 tools_rctest_LDADD = lib/libbluetooth-internal.la
 
 tools_l2test_LDADD = lib/libbluetooth-internal.la
diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index 000145a3d..d2a877275 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -20,6 +20,7 @@
 #include <getopt.h>
 #include <unistd.h>
 #include <errno.h>
+#include <ell/ell.h>
 
 #include "lib/bluetooth.h"
 #include "lib/hci.h"
@@ -286,7 +287,7 @@ static bool hr_msrmt_cb(void *user_data)
 	uint32_t cur_ee;
 
 	pdu[0] = 0x06;
-	pdu[1] = 90 + (rand() % 40);
+	pdu[1] = 90 + (l_getrandom_uint32() % 40);
 
 	if (expended_present) {
 		pdu[0] |= 0x08;
-- 
2.25.1

