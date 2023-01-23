Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D011BC38142
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Jan 2023 19:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjAWTtS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Jan 2023 14:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjAWTtJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Jan 2023 14:49:09 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BAF36476
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 11:48:53 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id jl3so12504942plb.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 11:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtMvIzjwni9e7pW6GiJL02ZOc+4ONpLeTG01hI6pPpI=;
        b=oxoxfFvmOxwXKw6t9QBTXMBKDUQQcHnQuFvKsgWMAt+00syjgXL76P+7FXcKIfBt5u
         dsl52iuYQ/TQHmprD7kL0G4RdT4e514LbVzriMo25rE71etAxsSblIDYksdmFq+o0iVE
         +ierEHOB+gCxsx7qaOvNKhrqO/Lv9o+sySaeZC0mUsxn+DWIIvQ2Ckh3ydKFk9SU/Tjw
         oGyUFU9kwy+aFF0HRr5U+yRZ5QBWw29We8CevyrMBJV7jbAHiMY46rJOHcuqh3usba1V
         pg+iQ37AIpt9Q9W/dtnx17O9sXPyQ8c7PySgxlyr3uCd2I2DHT7sMGFbbttTkZaqFNwI
         SCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtMvIzjwni9e7pW6GiJL02ZOc+4ONpLeTG01hI6pPpI=;
        b=nPTjs/G/oCl1npCsJT6ZAFlcLgDbSVBKHhdfCGTgCCUCnyGlJ+8wBU6b8oSqIVYTS/
         KWVZqVqrNWMe12bvMKiaPv5lR47pdhe71jigTPFeXjiF0yX1ghfhTmKg1JBz1kBKBLU/
         CcgvHIv0KJBe6NgFr/4sDr6a6GxnavTtP+yO3P1dWslVkVY3I2Z+kQzwQ3JBS/+WK3kJ
         wt/ytT/KgUA06lheWt6ZPAUnv3igj4McSrQdypQhMfJBBL7//KslvUti3uAfdMdPblph
         D8tJGXPwl8ZTl2XDKY6Gmb9dKci0FAqDPrK5lSfB062mwOQo9VNGT1bpyd3JN/cqzWfV
         nFPQ==
X-Gm-Message-State: AFqh2ko24DI1lUmc5U1cN6u1nWsfSQlOpMjfantPELpmLJitWTyVBRJp
        XtUPFpDPlV61W96PRqCcNFNZIFhPfsBWug==
X-Google-Smtp-Source: AMrXdXvpAGQXjRGDYD3C0c+2gUdS+eZnrvMAWwtfJYFoATPr+tgEO+esHGw2f8cT2UYbRwcJZapkCQ==
X-Received: by 2002:a17:902:aa05:b0:193:335a:989e with SMTP id be5-20020a170902aa0500b00193335a989emr26833067plb.25.1674503332275;
        Mon, 23 Jan 2023 11:48:52 -0800 (PST)
Received: from fedora.. (97-126-124-199.tukw.qwest.net. [97.126.124.199])
        by smtp.gmail.com with ESMTPSA id jj5-20020a170903048500b0017d97d13b18sm97068plb.65.2023.01.23.11.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 11:48:51 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com
Subject: [PATCH BlueZ v3 11/11] mesh: Switch beaconing net key
Date:   Mon, 23 Jan 2023 11:48:24 -0800
Message-Id: <20230123194824.257351-12-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123194824.257351-1-brian.gix@gmail.com>
References: <20230123194824.257351-1-brian.gix@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

When transitioning from Phase 1 to Phase 2 of a network key and we are
beaconing, we need to halt the beaconing on the old key version, and
begin beaconing on the new key version.
---
 mesh/net.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mesh/net.c b/mesh/net.c
index 81f1e57ee..05ca48326 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2625,6 +2625,13 @@ static int key_refresh_phase_two(struct mesh_net *net, uint16_t idx)
 	if (subnet->kr_phase == KEY_REFRESH_PHASE_TWO)
 		return MESH_STATUS_SUCCESS;
 
+	/* Stop beaconing on old key */
+	if (net->snb_enable)
+		net_key_beacon_disable(subnet->net_key_tx, false);
+
+	if (net->mpb_enable)
+		net_key_beacon_disable(subnet->net_key_tx, true);
+
 	subnet->key_refresh = 1;
 	subnet->net_key_tx = subnet->net_key_upd;
 	/*
@@ -2632,6 +2639,15 @@ static int key_refresh_phase_two(struct mesh_net *net, uint16_t idx)
 	 * it hears beacons from all the nodes
 	 */
 	subnet->kr_phase = KEY_REFRESH_PHASE_TWO;
+
+	/* Start beaconing on new key */
+	if (net->snb_enable)
+		net_key_beacon_enable(subnet->net_key_tx, false, 0);
+
+	if (net->mpb_enable)
+		net_key_beacon_enable(subnet->net_key_tx, true,
+							net->mpb_period);
+
 	refresh_beacon(subnet, net);
 	queue_friend_update(net);
 
-- 
2.39.1

