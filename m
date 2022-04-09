Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35C9C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Apr 2022 10:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237227AbiDIKEj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 9 Apr 2022 06:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbiDIKEi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 9 Apr 2022 06:04:38 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1849322FD8C
        for <linux-bluetooth@vger.kernel.org>; Sat,  9 Apr 2022 03:02:14 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id b21so18804502lfb.5
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 Apr 2022 03:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hilmer-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8GJcLDe13JuHpHi3WUYSuWh77KPku0pyG0zFNlLTUlQ=;
        b=tcS0Nazyg2Sj1ddp2TfjJv7iT3rSJnC+/SVBGxG6WZHn+Fk138hYd0qI0jBxB2MsWq
         QKZRbypl/hPQ4dA6OxWZl4gJSQmgmpVgZJgu9rF95zPsrKKXk9Vl9WBR35xjuAPJqNa4
         3Ib1WoldT4Aso7oQm2rXmr2Nn5zozg8nv21+nXP0czxq/cwFXhcqBXHSIqz2lceZQBj1
         ZoCxQw89B4qY6Z9ug82aTHMelZ1VbkCIUsUoTBzpUkz/1v+9L67qscDcUEPoYhIIQa6M
         7KRfavigSId7+7PSSKAZcaiwgsopmBUgLygIcAfNeWTr15I8l4Il6ZB7anGrmnMdwOuK
         J/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8GJcLDe13JuHpHi3WUYSuWh77KPku0pyG0zFNlLTUlQ=;
        b=f6N+gUuNDo73PVu2IPtuu6REbkvgo81ywpbYTsl886KUCxl7IGtDGZQa36+qxf2KiU
         Xj6r2mcv0nI6fXJZrxsgxGgip8VSZgmaAWaBe8CtT9qaolbtu/BrykWnTwqhY9gWAazR
         vnAyaMCp51edN+RTTo/3sB3CFV6kdzd0eaQdhFL8vhdgyJtyCfiNPTNRBtH1TBYt1EsD
         I6lmkDkVoeJ/Pa5u7Zr5M20Yj1ul+05jfWCtyh8za6qd6MQRODWv6ozpGJ6HlUyU57xM
         LHtv7eY6iF2ZVyUon+d8zn2RzihO7puAMhj2VUdgiHGrPkumsse5myHisKVThllmDYKX
         M/3g==
X-Gm-Message-State: AOAM531HK8PkSRlzsAVq6kS7VJARudmhlhh4laVobD0ZvmxzQUVjt4B/
        QABnbtw0bfezLf+B1d6SnFaf7AmkxtLc5xJR
X-Google-Smtp-Source: ABdhPJzi+bdoq8nLYGFgOQ5Ayrr+xtrS7b+fQaM7+KQaBnyRNhsUjBhXABvXNxIvnEw9v3SR7bVr2w==
X-Received: by 2002:a19:7610:0:b0:46b:9365:fa98 with SMTP id c16-20020a197610000000b0046b9365fa98mr1141113lff.100.1649498532056;
        Sat, 09 Apr 2022 03:02:12 -0700 (PDT)
Received: from jakob-nuc.lan ([185.229.152.125])
        by smtp.gmail.com with ESMTPSA id i16-20020a056512319000b0044ae52c6365sm2471759lfe.88.2022.04.09.03.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 03:02:11 -0700 (PDT)
From:   Jakob Hilmer <jakob@hilmer.dk>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jakob hilmer <jakob@hilmer.dk>
Subject: [PATCH BlueZ 1/1] adapter: Fix check of DISCOVERABLE setting
Date:   Sat,  9 Apr 2022 12:01:30 +0200
Message-Id: <20220409100130.9743-2-jakob@hilmer.dk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220409100130.9743-1-jakob@hilmer.dk>
References: <20220409100130.9743-1-jakob@hilmer.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Jakob hilmer <jakob@hilmer.dk>

The test for `DISCOVERABLE` should be done with
`MGMT_SETTING_DISCOVERABLE` instead of `MGMT_OP_SET_DISCOVERABLE`.
---
 src/adapter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 71de9e82b..f1197684e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1993,7 +1993,7 @@ static bool set_discovery_discoverable(struct btd_adapter *adapter, bool enable)
 		return true;
 
 	/* Reset discoverable filter if already set */
-	if (enable && (adapter->current_settings & MGMT_OP_SET_DISCOVERABLE))
+	if (enable && (adapter->current_settings & MGMT_SETTING_DISCOVERABLE))
 		return true;
 
 	adapter->discovery_discoverable = enable;
@@ -2229,7 +2229,7 @@ static int update_discovery_filter(struct btd_adapter *adapter)
 	/* Only attempt to overwrite current discoverable setting when not
 	 * discoverable.
 	 */
-	if (!(adapter->current_settings & MGMT_OP_SET_DISCOVERABLE)) {
+	if (!(adapter->current_settings & MGMT_SETTING_DISCOVERABLE)) {
 		GSList *l;
 
 		for (l = adapter->discovery_list; l; l = g_slist_next(l)) {
-- 
2.25.1

