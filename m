Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6ABCC43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 16:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F73218AE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 16:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7H8kykb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbeLSQvu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:51:50 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:38525 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbeLSQvt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Dec 2018 11:51:49 -0500
Received: by mail-wm1-f50.google.com with SMTP id m22so7206134wml.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Dec 2018 08:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=QSO4VB1A78+KP3Ub/YrbRLvnS+ro18Av1SnBfwJdAR0=;
        b=r7H8kykbdKlUeVl4MJ4RlGVH+3v0ySCU7nQ09s9tbdVuWZpSb4gPLvMY+M4L+PuYNh
         XYDPPhnyG5dRw7oJBvuFK3ucBOVdsNRi1NSFhwQDcMH/tAYTQspS8wxrrHWnZjDBmA5J
         EJMvXuOV4yN1+ZLVOuoUIFZZs6Km/1g+B+q5CwlzJhVitLFgpJeV7pP3l4q4hnBrJliO
         3Rd2+4YdHAL7aGl31PrtJg53e1dcucb3GhGJgtLWQSHnlCcsT5ZuQqa12iAezTS2iRRl
         v/WRfzC9Y26Rv/3+BRRi/ADgg+6QAnDRMn9o+gNLGiTth2vq59NDqN+f7acvG+NmDTgr
         KpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=QSO4VB1A78+KP3Ub/YrbRLvnS+ro18Av1SnBfwJdAR0=;
        b=GzG0V0yNqxGZ2WJncnclyZosqGsGV/IWqoXtwautFyhu0kVX47qie2A7AnKbkL6Uw0
         /YY8eW7Qu7f/MAKreE3TIRzM84tAVH6LqMiWMWRJqKeW+TKI/P2Tx+wuDeAC0mQ6qel7
         rMSTFDYzleHE3FEpKHQz1bSea+b0evTUPymWYCczRN5ZvNGrAkwmf5LVsCtvW43070S7
         jToKGFOcQYk8rkV/33+vTGXDg+Ca7e9i9ZrXtgiID2lifoh6u0fp1uY+DUJ3wE0LFRK+
         EMKoCYkvkKAyqfUBUdxG2ILSvSOhUUEL2+dSKyMwLkZiPCXE5ZZSyb8tBrLLeGkuWX2n
         5/3g==
X-Gm-Message-State: AA+aEWYUvEZEzEJWPuGtlXFeMXfl3WYjcxz+OieaQULnw5oTtP5ITesJ
        1TbxqEiAActJ7uXHjJ5Da1HVrEsZst4=
X-Google-Smtp-Source: AFSGD/UIztYblPPjBgrjHgUB2NFJRB5vvyU0vRwS0AQBz7hgXiHpWu25/MnqxaClltzLM8FVs5ovvA==
X-Received: by 2002:a1c:9183:: with SMTP id t125mr7647126wmd.79.1545238306839;
        Wed, 19 Dec 2018 08:51:46 -0800 (PST)
Received: from localhost.localdomain ([2a02:130:501:7::102])
        by smtp.gmail.com with ESMTPSA id w125sm5613853wmb.45.2018.12.19.08.51.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 08:51:45 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/10] avinfo: Show Vendor Specific Data
Date:   Wed, 19 Dec 2018 17:51:01 +0100
Message-Id: <20181219165109.29088-3-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181219165109.29088-1-pali.rohar@gmail.com>
References: <20181219165109.29088-1-pali.rohar@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/avinfo.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/avinfo.c b/tools/avinfo.c
index a7a61b881..1f7c68d4b 100644
--- a/tools/avinfo.c
+++ b/tools/avinfo.c
@@ -228,7 +228,12 @@ static void print_vendor(a2dp_vendor_codec_t *vendor, uint8_t size)
 
 	printf("\n\t\tVendor ID 0x%08x", vendor_id);
 
-	printf("\n\t\tVendor Specific Codec ID 0x%04x\n", codec_id);
+	printf("\n\t\tVendor Specific Codec ID 0x%04x", codec_id);
+
+	printf("\n\t\tVendor Specific Data:");
+	for (i = 6; i < size; ++i)
+		printf(" 0x%.02x", ((unsigned char *)vendor)[i]);
+	printf("\n");
 
 	if (vendor_id == APTX_VENDOR_ID && codec_id == APTX_CODEC_ID)
 		print_aptx((void *) vendor, size);
-- 
2.11.0

