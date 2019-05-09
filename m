Return-Path: <SRS0=Q31N=TJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175D5C04AB2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 May 2019 12:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E225A21479
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 May 2019 12:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfEIMhv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 May 2019 08:37:51 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:42571 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfEIMhu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 May 2019 08:37:50 -0400
Received: from classic.redhat.com (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id ABA7F10001B;
        Thu,  9 May 2019 12:37:48 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Florian Weimer <fweimer@redhat.com>
Subject: [PATCH 3/8] build: Enable BIND_NOW
Date:   Thu,  9 May 2019 14:37:41 +0200
Message-Id: <20190509123746.8396-3-hadess@hadess.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509123746.8396-1-hadess@hadess.net>
References: <20190509123746.8396-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Florian Weimer <fweimer@redhat.com>

Partial RELRO means that the object is GNU_RELRO but not BIND_NOW.  This
reduces the effectiveness of RELRO.  bluez triggers this because it
enables PIE during the build, and rpmdiff takes this as an indicator
that the best possible hardening is desired.

https://bugzilla.redhat.com/show_bug.cgi?id=983161
---
 acinclude.m4 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 7f494cc9d..6ae34b8ae 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -50,7 +50,7 @@ AC_DEFUN([MISC_FLAGS], [
 		if (test "${enableval}" = "yes" &&
 				test "${ac_cv_prog_cc_pie}" = "yes"); then
 			misc_cflags="$misc_cflags -fPIC"
-			misc_ldflags="$misc_ldflags -pie"
+			misc_ldflags="$misc_ldflags -pie -Wl,-z,now"
 		fi
 	])
 	if (test "$enable_coverage" = "yes"); then
-- 
2.21.0

