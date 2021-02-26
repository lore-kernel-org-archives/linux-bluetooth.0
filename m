Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0435CC433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 13:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9B2864EE2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 13:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhBZNaL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Feb 2021 08:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhBZN37 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Feb 2021 08:29:59 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AFDC06178C
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Feb 2021 05:29:18 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id a17so13355327lfb.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Feb 2021 05:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j7v8LWxA2QcJ39ay6EZNEiDTZBds6bupSMpuibaaHCU=;
        b=G8bhmREy0cIibGCQRJsaMjmtFLDhcbGl5P0nZIsSMUGZX/AE6sMaDf7X82q8NCpTQv
         Z9qMgG6kNUheDvyEjSCdjnw3ToDkWcMJxfVm6g77rd3rXvOh9Wlw3IAD9JT+n8kKlMgm
         AlwwQVN9TmhpWvj7uhad6JR61oRyP7JVqMgTeoQjgZ4COZ+RqLgwQgw/sshq3HNnIxAc
         ECJvJ+z133QOA8UmEu8cjMoVoU9BdOLG7gxnWw2YJVEcmfzkASVeM7qXsR9Oi9eRcn0w
         hlW0fv9RVybtib5IsYJTLuPT7GUiH7OaD4zAU9b2o5FkYSSiJA1976il79uIpnDaMtLQ
         cUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j7v8LWxA2QcJ39ay6EZNEiDTZBds6bupSMpuibaaHCU=;
        b=G+YE04BLV3eFmBF6dsGIvsIOhED8s6W8AYInTpnE3yUU31b5540g1MP3/CJFYW9/Mn
         kBlGB5me9MVHz8UAZzi/eyM5Bpnz6GOgMQOgvRJXVhRIKgbouWUqrCS2Oiw52VZX8uhb
         hVq79Nm3zAbQPswwLqGZ3XbSRM8uiFkAzYqqYnQVPiSJeFM2qT0OV7c7ln6PznkuYK6N
         CqvjHa2yJvFgqw0Ngfpe4PpE6QtUNL+niKac4FE1n+ptHNd9CnVtGNFMbvr1E79YYWJC
         qgSnXKq8EmhhAbeE6zj5RWij6jkmE4jxd5PxZ/1Sc+PAAxUJYfsNnuiFg8KXN+GnwPif
         AsOQ==
X-Gm-Message-State: AOAM531zaWAAHUoUh4sprOuQNkyuZN3FBgd3CWw0O7YmTtYlbrL1d+pd
        11nIBhlZSCGfl6Y/KtKYHmRqhkfgZO70H9zz
X-Google-Smtp-Source: ABdhPJzNvX0EuNPNaATzUZweStfgmwaIMXwJGlSZoScUZ7xinL6lUg0DnFhymeWjAJWLy91E1buGKw==
X-Received: by 2002:ac2:4555:: with SMTP id j21mr1777784lfm.463.1614346156847;
        Fri, 26 Feb 2021 05:29:16 -0800 (PST)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id q3sm1445064lfm.150.2021.02.26.05.29.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 05:29:16 -0800 (PST)
From:   =?UTF-8?q?Przemys=C5=82aw=20Fierek?= 
        <przemyslaw.fierek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Fix infinite loop on IVIndex update
Date:   Fri, 26 Feb 2021 14:27:40 +0100
Message-Id: <20210226132740.56503-1-przemyslaw.fierek@silvair.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch fixes inifinite loop problem caused by recurring call
of the `net_key_beacon_refresh` function.

Problem occurs when at least two nodes are connected to the same
BlueZ instance and they are connected to the same network
(use same network key). Issue is triggered when IVIndex update
process stabilize and one of the nodes receives network beacon
with IVUpdate flag set to 0. Then it processes the "local" beacon
and compose new `snb` (with IVUpdate flag set to 0) attached to
`net_key` instance. After that it calls `net_local_beacon` and
another node processes the new beacon (this node has IVUpdate
flag still set to 1). Note that the `net->ivupdate` has set value 1.
The `update_iv_ivu_state` says that "IVU clear attempted too soon".
The node composes new `snb` with IVUpdate flag set to 1 and writes
it to the `net_key` instance in the `net_key_beacon_refresh`
function. After that it calls `net_local_beacon` which causes
repeat of all process. We are rotating in this loop until end-of-memory.
---
 mesh/net.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 9624cd058..6acd9bc7b 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2609,29 +2609,33 @@ static int key_refresh_finish(struct mesh_net *net, uint16_t idx)
 	return MESH_STATUS_SUCCESS;
 }
 
-static void update_kr_state(struct mesh_subnet *subnet, bool kr, uint32_t id)
+static bool update_kr_state(struct mesh_subnet *subnet, bool kr, uint32_t id)
 {
 	/* Figure out the key refresh phase */
 	if (kr) {
 		if (id == subnet->net_key_upd) {
 			l_debug("Beacon based KR phase 2 change");
-			key_refresh_phase_two(subnet->net, subnet->idx);
+			return (key_refresh_phase_two(subnet->net, subnet->idx)
+							== MESH_STATUS_SUCCESS);
 		}
 	} else {
 		if (id == subnet->net_key_upd) {
 			l_debug("Beacon based KR phase 3 change");
-			key_refresh_finish(subnet->net, subnet->idx);
+			return (key_refresh_finish(subnet->net, subnet->idx)
+							== MESH_STATUS_SUCCESS);
 		}
 	}
+
+	return false;
 }
 
-static void update_iv_ivu_state(struct mesh_net *net, uint32_t iv_index,
+static bool update_iv_ivu_state(struct mesh_net *net, uint32_t iv_index,
 								bool ivu)
 {
 	if ((iv_index - ivu) > (net->iv_index - net->iv_update)) {
 		/* Don't accept IV_Index changes when performing SAR Out */
 		if (l_queue_length(net->sar_out))
-			return;
+			return false;
 	}
 
 	/* If first beacon seen, accept without judgement */
@@ -2639,7 +2643,7 @@ static void update_iv_ivu_state(struct mesh_net *net, uint32_t iv_index,
 		if (ivu) {
 			/* Ignore beacons with IVU if IV already updated */
 			if (iv_index == net->iv_index && !net->iv_update)
-				return;
+				return false;
 
 			/*
 			 * Other devices will be accepting old or new iv_index,
@@ -2660,12 +2664,12 @@ static void update_iv_ivu_state(struct mesh_net *net, uint32_t iv_index,
 		if (!net->iv_update &&
 				net->iv_upd_state == IV_UPD_NORMAL_HOLD) {
 			l_error("Update attempted too soon");
-			return;
+			return false;
 		}
 
 		/* Ignore beacons with IVU if IV already updated */
 		if (iv_index == net->iv_index)
-			return;
+			return false;
 
 		if (!net->iv_update) {
 			l_debug("iv_upd_state = IV_UPD_UPDATING");
@@ -2675,7 +2679,7 @@ static void update_iv_ivu_state(struct mesh_net *net, uint32_t iv_index,
 		}
 	} else if (net->iv_update) {
 		l_error("IVU clear attempted too soon");
-		return;
+		return false;
 	}
 
 	if ((iv_index - ivu) > (net->iv_index - net->iv_update))
@@ -2694,10 +2698,12 @@ static void update_iv_ivu_state(struct mesh_net *net, uint32_t iv_index,
 
 	net->iv_index = iv_index;
 	net->iv_update = ivu;
+	return true;
 }
 
 static void process_beacon(void *net_ptr, void *user_data)
 {
+	bool updated = false;
 	struct mesh_net *net = net_ptr;
 	struct net_beacon_data *beacon_data = user_data;
 	uint32_t ivi;
@@ -2731,13 +2737,15 @@ static void process_beacon(void *net_ptr, void *user_data)
 	 */
 	if (net->iv_upd_state == IV_UPD_INIT || ivi != net->iv_index ||
 							ivu != net->iv_update)
-		update_iv_ivu_state(net, ivi, ivu);
+		updated |= update_iv_ivu_state(net, ivi, ivu);
 
 	if (kr != local_kr)
-		update_kr_state(subnet, kr, beacon_data->key_id);
+		updated |= update_kr_state(subnet, kr, beacon_data->key_id);
 
-	net_key_beacon_refresh(beacon_data->key_id, net->iv_index,
-		!!(subnet->kr_phase == KEY_REFRESH_PHASE_TWO), net->iv_update);
+	if (updated)
+		net_key_beacon_refresh(beacon_data->key_id, net->iv_index,
+				!!(subnet->kr_phase == KEY_REFRESH_PHASE_TWO),
+								net->iv_update);
 }
 
 static void beacon_recv(void *user_data, struct mesh_io_recv_info *info,
-- 
2.25.1

