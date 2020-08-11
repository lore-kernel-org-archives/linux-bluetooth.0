Return-Path: <SRS0=5Aiy=BV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB4DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 13:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073C72078E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 13:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="qAopXdLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgHKNiN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Aug 2020 09:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbgHKNiN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Aug 2020 09:38:13 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D728BC06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2020 06:38:12 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id b30so6668292lfj.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2020 06:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCyZYPQarluAYNVjuTSqO+Z2+TU6RV9vTCrq9qlBlfY=;
        b=qAopXdLwEQfbvL/gbWcJKBr5f0NhiW7os3EIIPFK4Vxcf6wUZkj+sUb7dpxPIpy4Ni
         t9rgScCn4ROyFy02sfsNT7jHleK7T6seKkWJ5xDe1l7a3NUzxQiHo8xDklu/oCSltG1K
         o3NljsBErJ1vvdKKqJoFY7K76a0fu8lLvK9hGdldkBzDVH21nLn2KTq/h0xkwlLffj0D
         ndDLZptXvZpSVlzVUn6qeU3oGWPPkeyfwoyVeizZA7oMuB/OwZ2/FofvommeI2NaqiCS
         QHcs9zp4ZFVlUB/GNSU2VA2mKz/VOnSxrheNfBPzdXyaHArRbQpQTQx9pJ3S6wMPL01+
         qCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCyZYPQarluAYNVjuTSqO+Z2+TU6RV9vTCrq9qlBlfY=;
        b=jqOaqTHB65xX6C/2avHcpmmlnWXrO11deH32TPiEwNZ0+epC1cUCUqmlRLMQKah09e
         87GQ+C6MESKQTj5oZLDXyyUP3469wmhS1Jw19e9IqEfLR0SklYb1Z/5m6V9V2yYcAuma
         UkkfYjD1oq2lcD2wEQTNtAHAq9N9oCQk2qS0m05Wl3jhsBgwFqbTJMG4RJB/ryDl/uKR
         qXhbJn2iOIQxk2RPxT95IGIkp+BlVkTiVNcPOAx/+pGrBFF19xyP893m9PwBnaIVyGKC
         6zoAmM7z2NEwAz9CsqMQ0rNEovkj5MO/G5mJF7pzWaR+sitppGgHs4kOm+/NTnQEwWAt
         UK3g==
X-Gm-Message-State: AOAM530FbAy2JuPgtsGzyOCo9peVgoz7Ly7Mo39ApbL6hoRdOftgxNoa
        t5x3xvAND+RcPRA+bNch/FrmX4zcbQ0=
X-Google-Smtp-Source: ABdhPJzW1sWoD5Ql3b4dzjt3MsGzqOWO65E4CECvI7zhooM0z/iqis+1OlMJdrGqO0Ae+kKyO+w57A==
X-Received: by 2002:a19:fc14:: with SMTP id a20mr3310545lfi.0.1597153086267;
        Tue, 11 Aug 2020 06:38:06 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id w11sm11579622lff.62.2020.08.11.06.38.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 06:38:05 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Fix application key binding lookup
Date:   Tue, 11 Aug 2020 15:39:07 +0200
Message-Id: <20200811133907.8249-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Because l_queue_find can't distinguish between entry->data equal to zero
and missing entry, has_binding() fails when we bind app key with index
0, via L_UINT_TO_PTR.

Bug has been introduced in commit 1a2a6debd
---
 mesh/model.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mesh/model.c b/mesh/model.c
index 4eaad31be..7d7f1551a 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -140,7 +140,15 @@ static bool simple_match(const void *a, const void *b)
 
 static bool has_binding(struct l_queue *bindings, uint16_t idx)
 {
-	return l_queue_find(bindings, simple_match, L_UINT_TO_PTR(idx)) != NULL;
+	/* don't use l_queue_find, it can't distinguish between missing entry
+	 * and entry with data equal to NULL */
+	const struct l_queue_entry *entry;
+
+	for (entry = l_queue_get_entries(bindings); entry; entry = entry->next)
+		if (L_PTR_TO_INT(entry->data) == idx)
+			return true;
+
+	return false;
 }
 
 static bool find_virt_by_label(const void *a, const void *b)
-- 
2.20.1

