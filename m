Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA001C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Mar 2023 23:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCKXgt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Mar 2023 18:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCKXgs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Mar 2023 18:36:48 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0E84B82B
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Mar 2023 15:36:47 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id i28so11326519lfv.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Mar 2023 15:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20210112.gappssmtp.com; s=20210112; t=1678577805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g81z2WwGXCb6Pm2OkSQgNSFoEWkIVcP73+B/b6Acslw=;
        b=RpjLCBl8zPFliJFedWwj5fHTAmPvpfXlD/SBHAixgQ59nC0PJf8ojjLEEEfUTuTkcr
         tFjoRIf9arCgwi/FigmQo7p23R8IgzHf0mbeG03dw5XRdwCvdxQrRbzq2nOfiY71vQxd
         SVnliiWJI9HDNCNhNR1N/y05SgHgmf1MZg+pM7bHkdKX6S4MqhWEA6bLYF5PqqX1Xtj/
         sIakkaj2itoH1vtSwhh6gB7VuzA50wbvhypbsFKRtXtYI22cxe0IOKPmU7hMzFqcr1q6
         D+jPEo3ADGItGg8oAtLTOnVXJKufhNtUzaS0uuxvr/H40ko2WHJjTDoGU/ULtDuMwpfr
         XQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678577805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g81z2WwGXCb6Pm2OkSQgNSFoEWkIVcP73+B/b6Acslw=;
        b=iOYvtvFX0unZCFv325Om1AwZRurqAZsusPJALhxL82I6FeTywVsMI0DPLYbao6FDDD
         oYG3Hx6NZLpY3FWcLODYlzQIJ8yG+THECnLyy3qJ5AxpgLS+dD3XswxDbmrCmRJ+etl1
         rIWk0qTrEWUw++V+TYYJGGrEvqXCdMjjeS6P8FZ5tXtsykRbxboOEH1OUhxxlFtzNEaj
         ZFA4duN0b42a2PRNjiguJjQS4D/m5orn/GGndhyxVuY4EFqJGM6x9MwJtxLuyMTjiuRL
         AmvTK1KLM/UK9AAlwRoFVc0HEVlv2QQ6PqkPk5FjjnikSx8DSopbL/rH03EWjDxM03uV
         ZN8g==
X-Gm-Message-State: AO0yUKWjZfcf+qzBxN0A/EnQwBr01E0VpUwp6DCcXKrHz130DbqCSibF
        rdYzQ7sjLoXKdr3nHmfNNp7EHICyrsIydRVtrDY9Pg==
X-Google-Smtp-Source: AK7set+sSpAcUKpFtKH23TB3c0T4TsDAovRLBHwuI4sdNvf6Dkn2MBcOykwG+NfxEKjBsCa/Gp/qJw==
X-Received: by 2002:ac2:51c2:0:b0:4e2:40ba:af44 with SMTP id u2-20020ac251c2000000b004e240baaf44mr9203516lfm.7.1678577805064;
        Sat, 11 Mar 2023 15:36:45 -0800 (PST)
Received: from rymek.. (80.49.185.123.ipv4.supernova.orange.pl. [80.49.185.123])
        by smtp.gmail.com with ESMTPSA id r10-20020a19ac4a000000b004cc800b1f2csm445260lfc.238.2023.03.11.15.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 15:36:44 -0800 (PST)
From:   =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ v2 1/1] btmon: Fix decoding truncated data
Date:   Sun, 12 Mar 2023 00:36:40 +0100
Message-Id: <20230311233640.103858-2-lukasz.rymanowski@codecoup.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311233640.103858-1-lukasz.rymanowski@codecoup.pl>
References: <20230311233640.103858-1-lukasz.rymanowski@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some platforms use different filtering and for this purpose,
some of the ACL/SCO/ISO/SDP data is truncated.

In such a case, included length is smaller than the original size.
Without this fix, btmon stops working after first truncated packet.
---
 src/shared/btsnoop.c | 2 +-
 tools/btsnoop.c      | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/shared/btsnoop.c b/src/shared/btsnoop.c
index 0a68282bc..8b93203b3 100644
--- a/src/shared/btsnoop.c
+++ b/src/shared/btsnoop.c
@@ -513,7 +513,7 @@ bool btsnoop_read_hci(struct btsnoop *btsnoop, struct timeval *tv,
 		return false;
 	}
 
-	toread = be32toh(pkt.size);
+	toread = be32toh(pkt.len);
 	if (toread > BTSNOOP_MAX_PACKET_SIZE) {
 		btsnoop->aborted = true;
 		return false;
diff --git a/tools/btsnoop.c b/tools/btsnoop.c
index a0d6cf356..efaa45db4 100644
--- a/tools/btsnoop.c
+++ b/tools/btsnoop.c
@@ -283,7 +283,7 @@ next_packet:
 	if (len < 0 || len != BTSNOOP_PKT_SIZE)
 		goto close_input;
 
-	toread = be32toh(pkt.size);
+	toread = be32toh(pkt.len);
 	flags = be32toh(pkt.flags);
 
 	opcode = flags & 0x00ff;
@@ -356,7 +356,7 @@ next_packet:
 	if (len < 0 || len != BTSNOOP_PKT_SIZE)
 		goto close_input;
 
-	toread = be32toh(pkt.size);
+	toread = be32toh(pkt.len);
 	flags = be32toh(pkt.flags);
 
 	opcode = flags & 0x00ff;
@@ -433,7 +433,7 @@ next_packet:
 	if (len < 0 || len != BTSNOOP_PKT_SIZE)
 		goto close_input;
 
-	toread = be32toh(pkt.size);
+	toread = be32toh(pkt.len);
 
 	len = read(fd, buf, toread);
 	if (len < 0 || len != (ssize_t) toread) {
-- 
2.34.1

