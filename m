Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EB2C636D7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Jan 2023 23:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjA3Xwf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 18:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjA3Xw3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 18:52:29 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A742DE76
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 15:52:28 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id h9so4767096plf.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 15:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtMvIzjwni9e7pW6GiJL02ZOc+4ONpLeTG01hI6pPpI=;
        b=V4HWOnLJNbMQpwq3v9oGI9Fqj7OqCkJhLVHd7M74PifmNjpCsm4rEVBiTODr5IcmKM
         fzcSWNhXNjgQsr/givQGwmlM1lbEOXPV/5WJ/rjOCs0laxhOLbKBblIoiwGuMyx0t5jC
         CTR9WoHSsS7gaqlpplmQa1FeXjIZiGIc5ylSCPb82PzNCsA8gfKGMNqDW7aBlu+RTqm8
         biKcX8jj4FS+oeELCTeOOJfNyCIYsSzqtOd+Wmst1EvND3TdbdkYNICjnEmTx9tsoUUL
         BWjOiCthgq82m26tinNIkO0M8QYp/n2kI6TP//bn+aRq0xa0QKIqh8F5Q2A172z9rxhw
         iIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtMvIzjwni9e7pW6GiJL02ZOc+4ONpLeTG01hI6pPpI=;
        b=qGM4Az+bgTVl5kw4UyDqtFIY2KYzkA+uIi+CV9BvRTqHpt2xF4t+nQZMVaW5ZHJfNd
         6qI+q/nwhuzMyeSwHj0uSwvRIm80/YsUsfgU+Vc6WuUuNxpNnZpdMCcI6JZoS++J4h5M
         2G1sx0RxiPtohdBLAaPdm4x0IkF5dauOQXa5iNdT9Mls8bvk0VgEowIpnOy0DKMFgKGU
         7tbz8bi0wLi4slLjeH9lsp+DpSDwqtnMughOwVLGA294sq2TmhFAfrMzMFCgGnGnDhX1
         AXH+QM3ufqtSc9aKDa7rspOZL4hz2+JswD11n8UPXOYPeg1gf5gTHuzB87cio6wkssgz
         khrw==
X-Gm-Message-State: AO0yUKX0dLRWkm7TPmCrr4RiM47/goKDkfoaGQatArLzPu9/d2512idj
        V11XDCYtMwUfmhtUdBskdYJwgCfeLrGe2w==
X-Google-Smtp-Source: AK7set/YT9a2XnCbzZDBBis7G83aDqtpRZtgTJkGvWzjbud/exYO4l3IjDUtgsX0jCVDJ+ZKkLtLig==
X-Received: by 2002:a17:90b:4f90:b0:22b:e5c3:abe6 with SMTP id qe16-20020a17090b4f9000b0022be5c3abe6mr12259903pjb.4.1675122747040;
        Mon, 30 Jan 2023 15:52:27 -0800 (PST)
Received: from fedora.. (97-126-124-199.tukw.qwest.net. [97.126.124.199])
        by smtp.gmail.com with ESMTPSA id t191-20020a6381c8000000b004e8f7f23c4bsm2663948pgd.76.2023.01.30.15.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 15:52:26 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ v5 11/14] mesh: Switch beaconing net key
Date:   Mon, 30 Jan 2023 15:52:07 -0800
Message-Id: <20230130235210.94385-12-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230130235210.94385-1-brian.gix@gmail.com>
References: <20230130235210.94385-1-brian.gix@gmail.com>
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

