Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E99C54EAA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Jan 2023 11:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjA0Lh0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Jan 2023 06:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjA0LhV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Jan 2023 06:37:21 -0500
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D55526F
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jan 2023 03:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telink-semi.com;
        s=lgqu2209; t=1674819354;
        bh=t5kqM9Mdc2cjP6dWR/M7Zj+X4nGZ1XKCrufM6XQx7b0=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=M0iK1+NCbZK0w+8C4wZ3a4v9qUC6v/l8jwjpwx+drbsUcePtvWp2nq1J72lPeoUQH
         ljHnYNkH+GOk2WyEIpWLfZVUo2ekYonEE4msVapCXgn5bv1+xW42ftRTwQ7N5d56E4
         deyUObYa7LvYSKCVa72/XC7i/z/EVvLT2zFZS/GM=
X-QQ-mid: bizesmtp91t1674819353tdm2uhgu
Received: from fedora.. ( [85.31.249.147])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 27 Jan 2023 19:35:44 +0800 (CST)
X-QQ-SSF: 0140000000200030D000B00A0000000
X-QQ-FEAT: mRz6/7wsmIiYJWmPRvZI8sCB1m1vLYemnW2T4cKwjQpFZBua/l4zqeHc6S33Y
        Hs6yozdddhlc/Id4ZwojKGLTKW5oaXOLHigZVv+6caP0CCWUosrnHmstW6uu0Xld/3slwag
        zX1ndOCOReIzpwkOIrYFChpaEeebzRsZsMJnz7O7nU7yf/AlGC5+3FOF0IXJG0HG1hU+rJk
        Q+Ux5W6PhkVMM1AAyG0hwMWZuM9AVnEku43newSY0K90nXkk7rjwmcvUBj87FfllUdX62yg
        Ut99UxaJrtzRLTcaSnWuici25iSy9EmlzeypwY6IsBh/U+mYknTcTzryrUdOFoiV/yET8/3
        i9QUsD9ovCpcGHogGKEZLd4GEukjOGcHk69xO90XGHXdnpxI3DNpuc+1FTXLTsnByT/SuBC
        /ELULJ+uKFk=
X-QQ-GoodBg: 2
From:   Marcin Kraglak <marcin.kraglak@telink-semi.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcin Kraglak <marcin.kraglak@telink-semi.com>
Subject: [PATCH 1/2] shared/util: Add CAS, HAS, TMAS and PBAS UUIDs
Date:   Fri, 27 Jan 2023 12:35:02 +0100
Message-Id: <20230127113504.134109-1-marcin.kraglak@telink-semi.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:telink-semi.com:qybglogicsvr:qybglogicsvr7
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add UUIDs for: Common Audio service, Hearing Aid service,
TMAS service and Public Broadcast Announcement service.
---
 src/shared/util.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/shared/util.c b/src/shared/util.c
index 69abfba31..1ff9c56fc 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -447,7 +447,11 @@ static const struct {
 	{ 0x1850, "Published Audio Capabilities"		},
 	{ 0x1851, "Basic Audio Announcement"			},
 	{ 0x1852, "Broadcast Audio Announcement"		},
-	/* 0x1853 to 0x27ff undefined */
+	{ 0x1853, "Common Audio"				},
+	{ 0x1854, "Hearing Aid"					},
+	{ 0x1855, "TMAS"					},
+	{ 0x1856, "Public Broadcast Announcement"		},
+	/* 0x1857 to 0x27ff undefined */
 	{ 0x2800, "Primary Service"				},
 	{ 0x2801, "Secondary Service"				},
 	{ 0x2802, "Include"					},
@@ -681,6 +685,7 @@ static const struct {
 	{ 0x2b29, "Client Supported Features"			},
 	{ 0x2b2A, "Database Hash"				},
 	{ 0x2b3a, "Server Supported Features"			},
+	{ 0x2b51, "TMAP Role"					},
 	{ 0x2b77, "Audio Input State"				},
 	{ 0x2b78, "Gain Settings Attribute"			},
 	{ 0x2b79, "Audio Input Type"				},
@@ -751,6 +756,9 @@ static const struct {
 	{ 0x2bcc, "Source Audio Locations"			},
 	{ 0x2bcd, "Available Audio Contexts"			},
 	{ 0x2bce, "Supported Audio Contexts"			},
+	{ 0x2bda, "Hearing Aid Features"			},
+	{ 0x2bdb, "Hearing Aid Preset Control Point"		},
+	{ 0x2bdc, "Active Preset Index"				},
 	/* vendor defined */
 	{ 0xfeff, "GN Netcom"					},
 	{ 0xfefe, "GN ReSound A/S"				},
-- 
2.39.0

