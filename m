Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37259C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Dec 2022 00:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbiLBAd5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 19:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbiLBAdg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 19:33:36 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568336243
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 16:32:40 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id f9so3085911pgf.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Dec 2022 16:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=z2A1mGuPeyyPUfjZ1N9lAXnz8lVKiPq5Lod9tkhIkLU=;
        b=oaImGuefSqS12cHuuehV/Ebgh5//MYW7e8WU88FLUqZ0PWgq/GU0ilSB8yiu4Qnsva
         LFN4JrU8MndprpUI9mO4m//1GN3aleBegTAyJ4cZjRpicvVQhCV9ejZ7arHQwnCRi2Yy
         cHZhfHZbtgKhI7khkluK8o5O/XZjb68vYobe2Xom0hYNsKZsDyzCXu52LDeXK2PG0dBc
         kZOXs6UispbUybshqg3zyayHDqKYnhNdo/HY9MZR94rzgBLD6kWEQcHUQkFzqwbNR/l5
         9JH85PuS6skshPfTvAhcRuVBPZuttnSxICoYUVSR/3uxl8AEFhdvnuPCKmdCe/fBEDnc
         wHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2A1mGuPeyyPUfjZ1N9lAXnz8lVKiPq5Lod9tkhIkLU=;
        b=UVb9Fu8W1rWWNeqdZF4AX7JzeJ+gKJz+wdHmNwW/B92wiLB1JqN1FNKi/mqDXtd0yg
         BMCEOec1MScb7Ne62h3spJLgl9skLRH7E8jEJTdCH6V3jlYbAho66Hd/kIHzDD4NKjQp
         yhANpqc1SmvchOOULhbiNTBWEegQnn2PXQajvRDbuwEjZBT11NZjZzfw20zOBqBq/4lI
         yoRIuOIGY/SpyFqlfdj2nMkX3dnc7kGggU4cxOzB/Zwm4mweieqdvx3YMr4A8d+DyAeL
         U5cDEdBGlxMIt5x+8KWsd+1GZPBlwDyCOwcgVpcVMTwfh+LkeHiE7KPDINjZ/ZxCQgQR
         TUyA==
X-Gm-Message-State: ANoB5pk3JeFutCzxuAmasYTnFWiLp7ID2rZuT1einaeFMC5rOrrbNnBi
        hSI8s1AaxewOIFrv72x1QxgQHfmRgh6HDQ==
X-Google-Smtp-Source: AA0mqf7NuMrpVwYQlVHn9dHh8jEgsh6LUIQ0cJ+z5tO3opemtCzPrVpE0goHnMGbL1aiH63XXo/7mg==
X-Received: by 2002:a63:fd4c:0:b0:46f:1e8d:d6a8 with SMTP id m12-20020a63fd4c000000b0046f1e8dd6a8mr61204640pgj.248.1669941159211;
        Thu, 01 Dec 2022 16:32:39 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902d2c300b00176b84eb29asm4229467plc.301.2022.12.01.16.32.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:32:38 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-client: Fix not checking valid ranges
Date:   Thu,  1 Dec 2022 16:32:37 -0800
Message-Id: <20221202003237.2371302-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When attempting to update discovery ranges the code shall verify if the
range is still valid (handles != 0x0000 and start < end).
---
 src/shared/gatt-client.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 45b6ed92fde1..cf0d2e2b749d 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1018,6 +1018,20 @@ static bool match_handle_range(const void *data, const void *match_data)
 					(match_range->start <= range->end);
 }
 
+static struct handle_range *range_new(uint16_t start, uint16_t end)
+{
+	struct handle_range *range;
+
+	if (!start || !end || start > end)
+		return NULL;
+
+	range = new0(struct handle_range, 1);
+	range->start = start;
+	range->end = end;
+
+	return range;
+}
+
 static void remove_discov_range(struct discovery_op *op, uint16_t start,
 								uint16_t end)
 {
@@ -1034,16 +1048,18 @@ static void remove_discov_range(struct discovery_op *op, uint16_t start,
 	if ((range->start == start) && (range->end == end)) {
 		queue_remove(op->discov_ranges, range);
 		free(range);
-	} else if (range->start == start)
+	} else if (range->start == start) {
 		range->start = end + 1;
-	else if (range->end == end)
+		if (!range->start || range->start > range->end) {
+			queue_remove(op->discov_ranges, range);
+			free(range);
+		}
+	} else if (range->end == end)
 		range->end = start - 1;
 	else {
-		new_range = new0(struct handle_range, 1);
-		new_range->start = end + 1;
-		new_range->end = range->end;
-
-		queue_push_after(op->discov_ranges, range, new_range);
+		new_range = range_new(end + 1, range->end);
+		if (new_range)
+			queue_push_after(op->discov_ranges, range, new_range);
 
 		range->end = start - 1;
 	}
-- 
2.37.3

