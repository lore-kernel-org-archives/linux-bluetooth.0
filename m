Return-Path: <SRS0=//f6=62=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62459C2D0F9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 May 2020 16:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FC3A206B9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 May 2020 16:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589302280;
	bh=j1aLvHb7aipM4ssCnNZsCBHtzkWny6fS3a0Or21Q7uI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qYp44lcKuPU2ck8ieO5l44dsRRgVEWKxhvgtwx67SfyyAFcWyxIBF4Y3+BaT0ErBZ
	 wt4YELj/mJitUIytBn79emGvXDmlQX+M6pZ4FgV6k290g8T8UMBsZfEIAlNho7xxPr
	 UiNwMGB0IxezWmrA7beuzh5tYoFkmMCp79J4u30Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbgELQvT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 May 2020 12:51:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728403AbgELQvT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 May 2020 12:51:19 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E205206B9;
        Tue, 12 May 2020 16:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589302278;
        bh=j1aLvHb7aipM4ssCnNZsCBHtzkWny6fS3a0Or21Q7uI=;
        h=From:To:Cc:Subject:Date:From;
        b=c4kbUkb55a8ClPFeKMQNSOmNl1n3H4FJFm+qRUbfUci7G52AS/hydIv1jtxarRILY
         hBgcmdP0KSkBJhtUKv995eRzLNDLOJ2VYFKHO1ZQuvwEu5Sd6xyzEettfZ8VIHsouM
         HrQJzdbzildCAR0Dq0l8KYn4aKVO/aBIn8p80edI=
Received: by pali.im (Postfix)
        id D6BEC9E7; Tue, 12 May 2020 18:51:15 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] avinfo: Print more A/V capabilities
Date:   Tue, 12 May 2020 18:51:12 +0200
Message-Id: <20200512165112.24006-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/avinfo.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/avinfo.c b/tools/avinfo.c
index e45b50918..576981a5e 100644
--- a/tools/avinfo.c
+++ b/tools/avinfo.c
@@ -65,6 +65,7 @@
 #define AVDTP_HEADER_COMPRESSION	0x05
 #define AVDTP_MULTIPLEXING		0x06
 #define AVDTP_MEDIA_CODEC		0x07
+#define AVDTP_DELAY_REPORTING		0x08
 
 /* SEP types definitions */
 #define AVDTP_SEP_TYPE_SOURCE		0x00
@@ -696,13 +697,33 @@ static void print_caps(void *data, int size)
 
 		switch (cap->category) {
 		case AVDTP_MEDIA_TRANSPORT:
+			printf("\tMedia Transport: Supported\n");
+			break;
 		case AVDTP_REPORTING:
+			printf("\tReporting: Supported\n");
+			break;
+		case AVDTP_DELAY_REPORTING:
+			printf("\tDelay Reporting: Supported\n");
+			break;
 		case AVDTP_RECOVERY:
+		case AVDTP_HEADER_COMPRESSION:
 		case AVDTP_MULTIPLEXING:
-			/* FIXME: Add proper functions */
-			break;
 		default:
-			printf("\tUnknown category: %d\n", cap->category);
+			switch (cap->category) {
+			case AVDTP_RECOVERY:
+				printf("\tRecovery:\n");
+				break;
+			case AVDTP_HEADER_COMPRESSION:
+				printf("\tHeader compression:\n");
+				break;
+			case AVDTP_MULTIPLEXING:
+				printf("\tMultiplexing:\n");
+				break;
+			default:
+				printf("\tUnknown category: %d\n", cap->category);
+				break;
+			}
+			/* FIXME: Add proper functions */
 			printf("\t\tData:");
 			for (i = 0; i < cap->length; ++i)
 				printf(" 0x%.02x",
-- 
2.20.1

