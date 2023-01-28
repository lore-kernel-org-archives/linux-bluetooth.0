Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E008CC38142
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Jan 2023 06:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjA1GiF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 28 Jan 2023 01:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjA1GiE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 28 Jan 2023 01:38:04 -0500
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC7C22001
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jan 2023 22:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telink-semi.com;
        s=lgqu2209; t=1674887873;
        bh=gX4cjsjZmuwHtDQOxKYHFCrhocpSE27EP1elesOhkZk=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=cYnOtlzpr7AzfNcoGOsg0DRJvgRwlX4bBHOTf+LrEGV1xf8jaZOvRTVI9w+md5/e2
         vpE1kKsLP1pcJ15O3uFVbcUw15N4QqJagYe+YaG/7odNmkUlY1NHJTdcU5r67AgA9y
         +am53U49b/efnNdgXXYSBcYFsHj+85YGQN+R5yms=
X-QQ-mid: bizesmtp89t1674887871tn6qq1ry
Received: from fedora.. ( [85.31.249.147])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 28 Jan 2023 14:37:40 +0800 (CST)
X-QQ-SSF: 0140000000200060D000B00A0000000
X-QQ-FEAT: /rrU+puPB7QfzSbtFOx4qjbRlmHVh+GhuvfSZNTy3/nP3/rXAr9UGJBqFvXhi
        27pT8bjXUVXkGEsBxtLjZrvTRIkOjsUkthgPozJ8hBgqCHZ1Pm/+dIWuR7nazjhr+q6x4ky
        VjBXyxVWC2j8cVGVWz6T/+BJi+SDq6Lf6ZwA8eXaLJrtQTfKzSPQaVbbjxsqyTJIjQ9gap4
        0rhFCVZcTlDNfs8B+IGgr+esdzi/JMv0YRF0GL54mPmFHIxvSmZrSkLmUUCjSJfy5OWEMZ+
        0rbtQqiL11UpJTgoIMAfX8DFG75M/bnqe8yDxuRE6seKTyvNd1rb3fNxFGPmYlFi86SeKnw
        VEiLzsZ19R4GiewzzOzKRzPRSH8OsSDiHUDPx04v7QsBnJDKXB/xGYbpCWRIA==
X-QQ-GoodBg: 2
From:   Marcin Kraglak <marcin.kraglak@telink-semi.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcin Kraglak <marcin.kraglak@telink-semi.com>
Subject: [PATCH 1/2] shared/util: Add CAS, HAS, TMAS and PBAS UUIDs
Date:   Sat, 28 Jan 2023 07:37:32 +0100
Message-Id: <20230128063733.18131-1-marcin.kraglak@telink-semi.com>
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
index 69abfba31..2f0ae0e86 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -447,7 +447,11 @@ static const struct {
 	{ 0x1850, "Published Audio Capabilities"		},
 	{ 0x1851, "Basic Audio Announcement"			},
 	{ 0x1852, "Broadcast Audio Announcement"		},
-	/* 0x1853 to 0x27ff undefined */
+	{ 0x1853, "Common Audio"				},
+	{ 0x1854, "Hearing Aid"					},
+	{ 0x1855, "Telephony and Media Audio"			},
+	{ 0x1856, "Public Broadcast Announcement"		},
+	/* 0x1857 to 0x27ff undefined */
 	{ 0x2800, "Primary Service"				},
 	{ 0x2801, "Secondary Service"				},
 	{ 0x2802, "Include"					},
@@ -681,6 +685,7 @@ static const struct {
 	{ 0x2b29, "Client Supported Features"			},
 	{ 0x2b2A, "Database Hash"				},
 	{ 0x2b3a, "Server Supported Features"			},
+	{ 0x2b51, "Telephony and Media Audio Profile Role"	},
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
2.39.1

