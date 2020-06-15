Return-Path: <SRS0=u3xs=74=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0496CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 12:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D32542067B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 12:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="xdbZSZy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbgFOMkv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729826AbgFOMkv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jun 2020 08:40:51 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D701C061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 05:40:49 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i3so14441207ljg.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 05:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oBh2qB2QNnYCU+jTYGEX8SHDWip1wTkA62/hnT69HeQ=;
        b=xdbZSZy7snZduRcxFghjwt/uT/d8xwAFufkhVG9syyG0hR09isMM9WrDv76G77r85I
         bd6Optmb0n2OrD1LdvK9MiGAWGhIIFRNDFJ+sp8tOgjAKtAkYulY1gZx/fxW16+XYM4g
         ZQCOOO6FN8g63c8SPphm5U05Z9KK+d73QmwoLQTf0M6rV1YBOSPJBmZyASEavGEf7LGx
         XhF/m5eAtnroTCuUXNYBkCPLdUIYleVq6lnxByXx3nBx14Sm0EhWrcbEnJmcRAiRnsfo
         U5QQqDHNvHBQ0PQsZ6aFGbb7RFQY1H/P8Isu16BDvIYE/CSJtAsrkD7PEF36V3Z0jsjR
         ySTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oBh2qB2QNnYCU+jTYGEX8SHDWip1wTkA62/hnT69HeQ=;
        b=d3SwVed1B/VMktpu1okLmz9rhHEoAXLuC9JiKp1X5QNmn5GGyYspQ5ffmi2b+TTqxi
         BmbuBP2qQ1w78YYKnpW0zXKUsMtRA0C/qg53sIWPFddcLxOPMVuoopulKGZP6plaou9h
         TaLULPgV2dgQAI8qztP+ZR0mXp/0N57tULBxusZp1LEWg2uwLDlUXY7PMWEdwXEZ4d14
         gaFVUslgHZSwp17Y4X5QiCbdq3DK5ZPSE9cGFJ7uuTg5pdpLNFmdBaxNXve27pIxLRq0
         ctgRjtSn/hPJWxgJvWOva4nx3OSgRld5Ygd50FwrYMeYUEIYr3CqBhf0d7qjhELeM13a
         LhNA==
X-Gm-Message-State: AOAM531pNv+FV43mFBx/MwasjkEKBd3BFp+YmqzFrNTkGPCtM45PZFCu
        8EORdKkCRnpT6rB9DUGI0oaBiUS0TUwOPQ==
X-Google-Smtp-Source: ABdhPJzJvmJTJmT55qKYp0YZEKRt4A2VtFIWYzHQcdWU8lo9lNPLGAq639Ks5wB2gdrPHg26CFw65g==
X-Received: by 2002:a05:651c:313:: with SMTP id a19mr12095464ljp.57.1592224847788;
        Mon, 15 Jun 2020 05:40:47 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id e9sm3802000ljn.61.2020.06.15.05.40.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 05:40:47 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Rename IVUpdate import flag to IvUpdate
Date:   Mon, 15 Jun 2020 14:41:08 +0200
Message-Id: <20200615124108.11517-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Name change for consistency with "IvIndex" property.
---
 doc/mesh-api.txt | 2 +-
 mesh/mesh.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 6d905cf48..7fbab32b6 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -190,7 +190,7 @@ Methods:
 		The flags parameter is a dictionary containing provisioning
 		flags. Supported values are:
 
-			boolean IVUpdate
+			boolean IvUpdate
 
 				When true, indicates that the network is in the
 				middle of IV Index Update procedure.
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 4abae4d92..a62cb5390 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -808,7 +808,7 @@ static struct l_dbus_message *import_call(struct l_dbus *dbus,
 							"Bad net index");
 
 	while (l_dbus_message_iter_next_entry(&iter_flags, &key, &var)) {
-		if (!strcmp(key, "IVUpdate") &&
+		if (!strcmp(key, "IvUpdate") &&
 			l_dbus_message_iter_get_variant(&var, "b", &ivu))
 			continue;
 
-- 
2.20.1

