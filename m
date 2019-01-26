Return-Path: <SRS0=qwpb=QC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BECC282C7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jan 2019 10:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2BD2184C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jan 2019 10:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCQpFeMS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfAZKY7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:24:59 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54991 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfAZKY6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Jan 2019 05:24:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so9035486wmh.4
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Jan 2019 02:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=zvqs4qJ8KKkSpGu0qxifmdwJH0sAvVv7gWT5aw43MSw=;
        b=DCQpFeMSwGSLbAVil4x7ZOt4kSqAZ97BRbxZvFOBhE9dlJLVGrJsa8YuVyCrvOYSTr
         HV/XpSiWVppgozs4oN1qgMIOL9RpxkQVIWxfVb5zZvXeXfRWnG3Gp1PPcHQInkPvNfob
         gwailUR78sex7FLw+FG2mXGmhdpW+ZrRtZuFDoZZYn5fSoC0TnBiYBprWgIFk/Zufz4i
         h9yIWx4Tf8fHyRbJhHvkc27ePqtG1ndNdl4vmnrvP6sFIsHX+gfvRa+hqWKMUES7Gs42
         XMpDlPEryTSGArFQuO8O2Vx+a+vtL+mRMIPeehodS0lTTqc48zm6knOqxyutwqIJLuCW
         QXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=zvqs4qJ8KKkSpGu0qxifmdwJH0sAvVv7gWT5aw43MSw=;
        b=C40LYfYWxQFAHwW/6NoVbKKZgR5fpCIbvXRalrDXd6FgrWyt8QMaI47V6i6ffpip/p
         bFOwuRDYQd4z21SBapLnfhslUJe92ypK7LA7DTuE1hMEkBIjfXiGpiYT288D8sNGNvjN
         hzkJFXtaltD31/tRntJPnDsZA7GCptYUQuRDw6ks5FKEevN9OZ+Zy/L0gcfop8yEHgsa
         qkIpSq6z+U8MM3p7Q3A3383L88mS+XkJFYjHb48xfNV7Q6BxiOuiwzWmWXzRsBt4q+1o
         xWziz15VnX2D9ONO6rAdd0ja0ydvLOT2kP/j/ciyxx2yQdBYNHBdsajbk0ksfZVPZ2cR
         BuJg==
X-Gm-Message-State: AJcUukfOWh2NsyfTZlEiNY7N+dSunBCW0iqIV+06kFJYWLOmL/vWwQDL
        mXegHPhvwnreyrWm3hvcDGyHwCJa
X-Google-Smtp-Source: ALg8bN4GCLk2sWTp7eoAvkDqfpEE0lRTOFHx4y1uMNL1GL2GABA56JXUo8pk7YJQJCyy5B0Q7AhoYA==
X-Received: by 2002:a1c:cbcb:: with SMTP id b194mr9365864wmg.64.1548498296932;
        Sat, 26 Jan 2019 02:24:56 -0800 (PST)
Received: from Pali-Latitude.lan ([2001:718:1e03:a01::1ca])
        by smtp.gmail.com with ESMTPSA id a12sm95939371wrm.45.2019.01.26.02.24.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 02:24:56 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] avinfo: Dump unknown codecs and unknown categories
Date:   Sat, 26 Jan 2019 11:24:50 +0100
Message-Id: <20190126102450.23851-1-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/avinfo.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/avinfo.c b/tools/avinfo.c
index a3298e8c8..42f539f43 100644
--- a/tools/avinfo.c
+++ b/tools/avinfo.c
@@ -648,6 +648,8 @@ static void print_media_codec(
 			struct avdtp_media_codec_capability *cap,
 			uint8_t size)
 {
+	int i;
+
 	if (size < sizeof(*cap)) {
 		printf("\tMedia Codec: Unknown (broken)\n");
 		return;
@@ -668,6 +670,10 @@ static void print_media_codec(
 		break;
 	default:
 		printf("\tMedia Codec: Unknown\n");
+		printf("\t\tCodec Data:");
+		for (i = 0; i < size - 2; ++i)
+			printf(" 0x%.02x", ((unsigned char *)cap->data)[i]);
+		printf("\n");
 	}
 }
 
@@ -699,6 +705,7 @@ static void print_content_protection(
 static void print_caps(void *data, int size)
 {
 	int processed;
+	int i;
 
 	for (processed = 0; processed + 2 < size;) {
 		struct avdtp_service_capability *cap;
@@ -715,9 +722,14 @@ static void print_caps(void *data, int size)
 		case AVDTP_REPORTING:
 		case AVDTP_RECOVERY:
 		case AVDTP_MULTIPLEXING:
-		default:
 			/* FIXME: Add proper functions */
+			break;
+		default:
 			printf("\tUnknown category: %d\n", cap->category);
+			printf("\t\tData:");
+			for (i = 0; i < cap->length; ++i)
+				printf(" 0x%.02x", ((unsigned char *)cap->data)[i]);
+			printf("\n");
 			break;
 		case AVDTP_MEDIA_CODEC:
 			print_media_codec((void *) cap->data, cap->length);
-- 
2.11.0

