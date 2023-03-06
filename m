Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B319C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Mar 2023 14:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjCFOww (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Mar 2023 09:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjCFOwk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Mar 2023 09:52:40 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3778630199
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Mar 2023 06:52:25 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id bx12so9071603wrb.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Mar 2023 06:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20210112.gappssmtp.com; s=20210112; t=1678114343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=COiTwkqS4MwGXLAg4AUzZXR93+vUEBpyC8bkm7sltAM=;
        b=KoFr+MAT8/QRevkko2/tk0k8QdBF1ogAaoIPdg9zPjmZPOjYfp2LCPd9pVdB7Rel/G
         TO8UEAK8od/9musKMPrIn/vV2y2nO8uZEIh2ktdjC3RJUlgRPNFNqJCVD+wgd9lY1Z1f
         cQhHgQcLZiX6r4Sw8uDpPK92UpeXh72t6myvmOL5aU2i0O7IFYGO4dI2fUMip2olLD4f
         i5AZ0yHThazKZKUomL/zVL3NkyukyQTg5J4dVMsIsrANZtO2fkN01y1rAS1s+2emCiK0
         T20p21ScmdgqVXQY/ipH8tnfhpp+3BBkPt/vEbhTsT5na04Cxt2LDNH/N3pQ2Wq5cmn2
         qs0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678114343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COiTwkqS4MwGXLAg4AUzZXR93+vUEBpyC8bkm7sltAM=;
        b=irsA/7iupCMZ1xRsUZHUQs8lYT3wYBNU1TI89uJKEeE0N2qSbPMAgjK5u6z8iJBmo4
         i+uBYczrz8UZcBgMIh1oepFxmq29RLPTTFGzR6VBx6tkJgLPE8xflSprWISIbkb1bOZK
         NRmaBvazuNJnnApyppicv9vT6bk8uNd9Rz0O/sde2iies9egCuWcKk/F1/3aIO7Q6IH0
         5EsKq5ozj6IhWBJwUW1j/iTtf0wAUSQcvhqHHs3X8o0MmVMLN+cPf0doa7f6RJihH0gl
         DQ+J7hLCPQo7a3vCevbZr4WT5JTXg18lkTibstivndZ/NpGEyULDp4/QArIzWiAHZ2tj
         N+dQ==
X-Gm-Message-State: AO0yUKUclvRf/opBjjC50SBICX4s4dHgTegxaEhz763EEVKiiPz3IVlT
        kEeDWrnIe7AU60T6I+3sAsLJX5JRpARW8QFZZdPXBA==
X-Google-Smtp-Source: AK7set/a8+ezEBXrbKI2H8+XkvHS6Rj3zfmOZDFnWxWaznjEuQ/PTslu5qpB3J2/05OY7S8kIxBZag==
X-Received: by 2002:a5d:6512:0:b0:2c6:85ef:4086 with SMTP id x18-20020a5d6512000000b002c685ef4086mr6587059wru.32.1678114343263;
        Mon, 06 Mar 2023 06:52:23 -0800 (PST)
Received: from rymek.. ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id q16-20020adfea10000000b002c559def236sm10013786wrm.57.2023.03.06.06.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 06:52:23 -0800 (PST)
From:   =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ] btmon: Fix decoding truncated data
Date:   Mon,  6 Mar 2023 15:52:17 +0100
Message-Id: <20230306145217.7662-1-lukasz.rymanowski@codecoup.pl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some platforms use different filtering and for this purpose,
some of the ACL/SCO/ISO/SDP data are truncated.

In such a case, included lenght is smaller the original size.
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

