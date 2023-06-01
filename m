Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9FFC7EE29
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Jun 2023 23:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjFAXd0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Jun 2023 19:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbjFAXdX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Jun 2023 19:33:23 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5431A1
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Jun 2023 16:33:21 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b1806264e9so8811695ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Jun 2023 16:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685662400; x=1688254400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSCV8BxOlg0I7DIlrGZCljWyg/rOkqmB/KoboSuxCjc=;
        b=mPpuwpVjy6uU471KBZDgykTjz90AgdiqN0r+Ql7kCk2iIABvof3/XTuVm/dM0kNiEb
         hC9BqOEADvYiJTB2s0u74mHp/qT+INAtqrT0NiSi7+P+rIwmToAuPovDpSxftW1dvgEW
         HJ0gzRciihl6sFR0OYI7RmfxGhxTHAeExK+8iZUkSM6CCkLu/rShfn2+RyUbM+une/bZ
         PQ02cGIS15vflQzrfWfPKcf4FDVJQCdDPDgpes3/kSfdq5eUbqSk8L7+8Ob0NCN6phby
         6bnMd+W2zYScYFc8hNlS39wH8VoYR0LQeqDhbpC0Mz57QeNnsXmgmPxYqNpphdnx+mlI
         p8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685662400; x=1688254400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSCV8BxOlg0I7DIlrGZCljWyg/rOkqmB/KoboSuxCjc=;
        b=C7p5qwGsSOO8kTdqd1qqhJiX9svxwJ7hn5D+vx9xBHuaTe79XFTM5RnS8cRkVQCWxE
         I8BbKn/PNd3m6TLMbloE7X2v1xUbbK0uORCAHn3Mu+6lanS6dykxbZ8k97n4141xO/oP
         s4vlbXju/yzM4kTllaHK7/yCg49K9kcmGsRkSs1takubdSSBiy7dp+IjMPgxzQiR12MR
         VOfWKPB/jF1MUNU2s2XBjCOyjFZwS5iG8b4sgFrVt3ulxGPckcYyBydpb7k2DxWuouL0
         fOLI7IgPTuSrnC/tGAgp7+OtNwhRrR/Jjg5J6RuqTvlajEAH2dfJ/KIE66uYmQNVgt5t
         99uQ==
X-Gm-Message-State: AC+VfDygNQ/tMOkR4rYCZZdNAjwWxLgwWzfxa6V0psHlier6EkUwxTBs
        FsLXak9wRLJd6S+YiZjicN3y/e8LZEk=
X-Google-Smtp-Source: ACHHUZ4xnPnuzvv8UVfB+iDA2IEuCpci/U2huBHPHL/6KHuEmiueS6GGvCKYXqh1Whtz4UEhPKkwaQ==
X-Received: by 2002:a17:902:8697:b0:1a1:a800:96a7 with SMTP id g23-20020a170902869700b001a1a80096a7mr734364plo.8.1685662400321;
        Thu, 01 Jun 2023 16:33:20 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902a50700b001ab0b2dad2fsm4051420plq.211.2023.06.01.16.33.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 16:33:19 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] shared/bap: Don't overwrite attribute declaration
Date:   Thu,  1 Jun 2023 16:33:17 -0700
Message-Id: <20230601233317.1419030-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601233317.1419030-1-luiz.dentz@gmail.com>
References: <20230601233317.1419030-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The attribute declaration (e.g. characteristic properties) shall not be
overwritten as they are part of the information that is part of the
cache beside the same information is already stored as part of the
bt_bap instance.
---
 src/shared/bap.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 26f41be768e9..86c2634472fb 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -3077,9 +3077,6 @@ static void read_source_pac_loc(bool success, uint8_t att_ecode,
 
 	pacs->source_loc_value = get_le32(value);
 
-	gatt_db_attribute_write(pacs->source_loc, 0, value, length, 0, NULL,
-							NULL, NULL);
-
 	/* Resume reading sinks if supported but for some reason is empty */
 	if (pacs->source && queue_isempty(bap->rdb->sources)) {
 		uint16_t value_handle;
@@ -3113,9 +3110,6 @@ static void read_sink_pac_loc(bool success, uint8_t att_ecode,
 
 	pacs->sink_loc_value = get_le32(value);
 
-	gatt_db_attribute_write(pacs->sink_loc, 0, value, length, 0, NULL,
-							NULL, NULL);
-
 	/* Resume reading sinks if supported but for some reason is empty */
 	if (pacs->sink && queue_isempty(bap->rdb->sinks)) {
 		uint16_t value_handle;
@@ -3149,9 +3143,6 @@ static void read_pac_context(bool success, uint8_t att_ecode,
 
 	pacs->sink_context_value = le16_to_cpu(ctx->snk);
 	pacs->source_context_value = le16_to_cpu(ctx->src);
-
-	gatt_db_attribute_write(pacs->context, 0, value, length, 0, NULL,
-							NULL, NULL);
 }
 
 static void read_pac_supported_context(bool success, uint8_t att_ecode,
@@ -3175,9 +3166,6 @@ static void read_pac_supported_context(bool success, uint8_t att_ecode,
 
 	pacs->supported_sink_context_value = le16_to_cpu(ctx->snk);
 	pacs->supported_source_context_value = le16_to_cpu(ctx->src);
-
-	gatt_db_attribute_write(pacs->supported_context, 0, value, length, 0,
-							NULL, NULL, NULL);
 }
 
 static void foreach_pacs_char(struct gatt_db_attribute *attr, void *user_data)
-- 
2.40.1

