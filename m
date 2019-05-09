Return-Path: <SRS0=Q31N=TJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03014C04AB3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 May 2019 12:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D305621479
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 May 2019 12:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfEIMhu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 May 2019 08:37:50 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:41581 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfEIMht (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 May 2019 08:37:49 -0400
Received: from classic.redhat.com (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 2EBA810001A;
        Thu,  9 May 2019 12:37:48 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 2/8] build: Add warnings for non-literal strings
Date:   Thu,  9 May 2019 14:37:40 +0200
Message-Id: <20190509123746.8396-2-hadess@hadess.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509123746.8396-1-hadess@hadess.net>
References: <20190509123746.8396-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 acinclude.m4 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 045138c04..7f494cc9d 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -21,7 +21,7 @@ AC_DEFUN([COMPILER_FLAGS], [
 		with_cflags="$with_cflags -Wredundant-decls"
 		with_cflags="$with_cflags -Wcast-align"
 		with_cflags="$with_cflags -Wswitch-enum"
-		with_cflags="$with_cflags -Wformat -Wformat-security"
+		with_cflags="$with_cflags -Wformat -Wformat-security -Wformat-nonliteral"
 		with_cflags="$with_cflags -DG_DISABLE_DEPRECATED"
 		with_cflags="$with_cflags -DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_28"
 		with_cflags="$with_cflags -DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_32"
-- 
2.21.0

