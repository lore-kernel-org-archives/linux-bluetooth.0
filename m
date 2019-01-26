Return-Path: <SRS0=qwpb=QC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396A3C282C7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jan 2019 10:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B52217D7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jan 2019 10:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdhbhoNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfAZKY0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:24:26 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40951 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfAZKY0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Jan 2019 05:24:26 -0500
Received: by mail-wm1-f68.google.com with SMTP id f188so8836278wmf.5
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Jan 2019 02:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=IvalRoPZTdyATx+MNsD3J/jQB9ZbptG5LiuC3iQ4D+k=;
        b=VdhbhoNBR7DvXKlaETqxth9iKF4OzxlAbUcC4c7GOMTzzy0sYi6iCZkd4svLdn/5DJ
         MTJfIV7azj78PGRydbiE4lTcSHOU3DqC8Vc32MOp/MSeRQdEZ9iySyOjuD72VmytXqeS
         CaW5QmOk/BlxWtDWmkZKSziN9HhQn8UHX86MWZWpdbvCteZonNACzy3mB/O++AgMQKI9
         4NcFw8zznnCaf02io9uV6MxJihksBAvU6VAXtIDGO3affPVLJr1/bzPNfrhRvQny1k7A
         sgHoiwKYVopP++8Pi5NlS07jHGIBu7g+VCj6dyYaEznS4aElolm2omQloSyULHdar4SL
         mzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=IvalRoPZTdyATx+MNsD3J/jQB9ZbptG5LiuC3iQ4D+k=;
        b=JU2PDro7bGGbYQvwmaQVq/PDR88QeV1E4gkJ7JdS7lt1aNKtgY5zJFgCF8C5DU3/AM
         jUJ9AvDzcEJRZB2azJCZcTC9HrnFXM+i0PBiBqXPUfbCHNIyYtDzThUhzxPfsGkPiAfv
         Hx+s+Akql/IrZggHAbBh8A5Yjhioevm0CmuyLHMP2MYf1UTP1toQgV37jBCO33rPgIN5
         twd/SyJVUWLTXTsRDdoNPO0fXiVwk04ZZV0iGVrNyBUCOo9ItB8QmzOYEaDVS0CDeqOD
         /qu//WHD4EDMskPxSNK7HEYn3xsyOIVGF0wigPdFSXdOx6dXOr/MSmQK+b3juy6ZiiXn
         QnRQ==
X-Gm-Message-State: AJcUukdThixb4LNkGiJQb0eXRUF5FqRP5MFwMBCqzPjS8pQeL2yoOXCJ
        PJFDoHP9rB1pTRtrq3OzUlrIpFLP
X-Google-Smtp-Source: ALg8bN5bxd4eg2rzZGotGwzxY68VyJhWPpBWBcCg0kydyWwcNQjLBPhAjSwwFuwPcw9x94y/7lN8xg==
X-Received: by 2002:a1c:b14:: with SMTP id 20mr10358415wml.103.1548498264220;
        Sat, 26 Jan 2019 02:24:24 -0800 (PST)
Received: from Pali-Latitude.lan ([2001:718:1e03:a01::1ca])
        by smtp.gmail.com with ESMTPSA id l19sm64930390wme.21.2019.01.26.02.24.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 02:24:23 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] avinfo: Fix parsing capabilities
Date:   Sat, 26 Jan 2019 11:24:15 +0100
Message-Id: <20190126102415.23786-1-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Function print_caps() expects capabilities buffer without AVDTP header.
Previously avinfo somehow worked, because AVDTP header looks like
capability header with unknown category which was skipped.
---
 tools/avinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/avinfo.c b/tools/avinfo.c
index 02fc1f233..a3298e8c8 100644
--- a/tools/avinfo.c
+++ b/tools/avinfo.c
@@ -809,7 +809,7 @@ static ssize_t avdtp_get_caps(int sk, int seid)
 		return -1;
 	}
 
-	print_caps(caps, ret);
+	print_caps(caps->caps, ret - sizeof(struct getcap_resp));
 
 	return 0;
 }
-- 
2.11.0

