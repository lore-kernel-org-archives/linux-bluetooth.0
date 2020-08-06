Return-Path: <SRS0=ILT4=BQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDC3C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Aug 2020 17:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E729023119
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Aug 2020 17:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Pn1hvLMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbgHFRYn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729324AbgHFREE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Aug 2020 13:04:04 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E0CC0A8888
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2020 07:20:11 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id g6so39320131ljn.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Aug 2020 07:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VoVb4u7m4wnWBugEVb4iq1vaqN0jNSaxwjcJWhpXkDQ=;
        b=Pn1hvLMJv+VVZbn9YCH1Tnv6/jjWzDfjWx37dj0hePvs9jVS+N//KjXP/hviL934Sh
         h7V1ZXJagTRw3tWVtuvpFS8jXZ7PrDPYsQ8N4ez66sMq0RCmybOmF4SZ3LwjSlv6HPK1
         iZjSdErtDgQx5m+kPLFFIfrQNzECqoV+9FUorIpvYpmxpCXLoH/nvYgmTabTcTMoia8T
         Xa8LMax+H0RBKG7Mnc/a7/ykTak2FBk6+sN38IFH0Fp4+a3f9xwJcdu5u/UzLeZ3VaQu
         1BvI0iq4vgrRGRR8zZZPA0ICDLeIdLTXACy3wUcbVVa1pavD1rkyVH7H5cotBKA/bK1v
         iBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VoVb4u7m4wnWBugEVb4iq1vaqN0jNSaxwjcJWhpXkDQ=;
        b=NHXAnt+QtNMBz94iO8ZT1BVjtVp5zSIkKqzdw2CB2DzF2TsJqha0fGVDVwqR5frjDI
         LJfwEy4o8/COzopmrLNasiYx+I9AKEYqKFJ4aIHFPssuIph6vdz35vDYufkbpe+849a7
         Pz/vYeUA1MJlH0qXagEMrk1UEGftGzDCko69Bu14qv3jEqru8mHt/7ZMHtvJIEb9jM4E
         Wdqm/B/4ARFrxUgx0YQbGIt/21WWaahYc+0C+xGjuhWK2rUzDhUsFdBTAPYzAW3jiFfN
         B1krIG7tzmAxooK5GeL0+CBXkoU9dZWxz3NFRH6CBP+F8Fyt2Ov/+mQDZctA6SaPK6B3
         YX4A==
X-Gm-Message-State: AOAM532En9SS+VMlbsm0mCGhVK0NHeG+4WGLDT7MSvK4Gs+OlFV+Qjsg
        Y2XBgRsCb4KRgKTXR97b3DQrABl5AQE=
X-Google-Smtp-Source: ABdhPJxu0Q9CI4y4Hmu25Rl2ZQHS5erbTsqX7b5wHGN/QIQ4lAN0ZkzO2T9YcomCN9/KOzxbEIUrmg==
X-Received: by 2002:a2e:321a:: with SMTP id y26mr3801125ljy.388.1596723608972;
        Thu, 06 Aug 2020 07:20:08 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id j144sm2992562lfj.54.2020.08.06.07.20.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 07:20:08 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Allow deleting non-existing net key
Date:   Thu,  6 Aug 2020 16:21:08 +0200
Message-Id: <20200806142108.32664-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When deleting a non-existing key, first check that it doesn't exist (and
return success), then verify it's not the last key we have.
---
 mesh/net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 7cc75ce42..b044d7fe0 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -789,15 +789,15 @@ int mesh_net_del_key(struct mesh_net *net, uint16_t idx)
 	if (!net)
 		return MESH_STATUS_UNSPECIFIED_ERROR;
 
-	/* Cannot remove primary key */
-	if (l_queue_length(net->subnets) <= 1)
-		return MESH_STATUS_CANNOT_REMOVE;
-
 	subnet = l_queue_find(net->subnets, match_key_index,
 							L_UINT_TO_PTR(idx));
 	if (!subnet)
 		return MESH_STATUS_SUCCESS;
 
+	/* Cannot remove primary key */
+	if (l_queue_length(net->subnets) <= 1)
+		return MESH_STATUS_CANNOT_REMOVE;
+
 	/* Delete associated app keys */
 	appkey_delete_bound_keys(net, idx);
 
-- 
2.20.1

