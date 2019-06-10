Return-Path: <SRS0=gL6M=UJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801F8C282DD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jun 2019 08:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45311207E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jun 2019 08:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="eCZRJZ47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387974AbfFJIqM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jun 2019 04:46:12 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40957 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387753AbfFJIqM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jun 2019 04:46:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id a9so6035700lff.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2019 01:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=97mC0ujECaK1ek/SEaIvj1B2ByIZ+LViPxrsOGv4wvs=;
        b=eCZRJZ47kVT2RRWZtgYzI9ZfSGpKfo0swuyGb/iib2rYbpgpstVqnn8ZTlQMIVnFkz
         e55noVWNYe9dtcDh0Svuz8KMJpLC7MoCSJvv4AJIEcXJP0jjnaJzq59dY1s2WHSjhlp1
         LQ1xceALoctJg9XX8bjOMWehKSHDCumgTo0e429vrrps/KPr9WKhO8QXD0cB2h8TTUKG
         bGDT4M7jx1O1iP8Uu2pHWunB+NIB316Cs7RYKyKo6Qhb4oQ2xOs33sz+5p6HGLQ/dc7Z
         NxapZND/DcgliqaaIGKaJogcHXi4wKhjlDbvHNI5RjGpdSwxgMPqrr0x+HNv49WhKkgM
         Bb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=97mC0ujECaK1ek/SEaIvj1B2ByIZ+LViPxrsOGv4wvs=;
        b=O3YiHmysf0T4bZvUQ5rlsgYMIbwwxTSduVnYDvLdqgG39WQusZ01pGlZPbPjqfYoan
         1tSusnxABdP4ROjMVrDOKOP0FcR6UnlNZwCJaOLE/Hu0os/XTf5aAQ/o7YeEPlzqr/Xj
         XCQgJHUSmCzlO/E8lkqpNHSjM2+RSRW7cPszpx+jXWf6E8jfvaSYFY/9YTNAh/ph2mCC
         UWWF69slW2Tqo9XgY9uVX9sGaY1oQVrrbw9Ja+SNrnpPDmhMiDpUTDRavnB6sZeQhDwH
         DR2+2I1IUmdzkxB4VWIov/NBAt5hhhmYb7qC+/fB6Npyj3SFz/MQpsp/uCv8Rg6F1HBK
         lDfg==
X-Gm-Message-State: APjAAAUIJsHk5L05nNN+t5Hv6U4/bwjUtnsNsmIx0ynRd8ihE83xdUNP
        /gwE2nXbXW0O71GOxcq0nPK3Hllayul/8w==
X-Google-Smtp-Source: APXvYqwAXS5mXOKJejRt1JUKMk00+8ffnccO9jmlGtT8iqqo6jj9LpInPAY1af9HCx1lmIQbO/HxgQ==
X-Received: by 2002:a19:6703:: with SMTP id b3mr34463412lfc.153.1560156370685;
        Mon, 10 Jun 2019 01:46:10 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id b25sm1861856lff.42.2019.06.10.01.46.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 01:46:10 -0700 (PDT)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v3] mesh: Fix segmentation fault after adding second netkey via NET_KEY_ADD opcode
Date:   Mon, 10 Jun 2019 10:46:05 +0200
Message-Id: <20190610084605.11411-1-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Segmentation fault was caused by passing subnet pointer to the
start_network_beacon() which was NULL
---
 mesh/net.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index c7aff9ab4..fdd38e7ce 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -977,27 +977,28 @@ int mesh_net_del_key(struct mesh_net *net, uint16_t idx)
 	return MESH_STATUS_SUCCESS;
 }
 
-static int add_key(struct mesh_net *net, uint16_t idx, const uint8_t *value)
+static struct mesh_subnet *add_key(struct mesh_net *net, uint16_t idx,
+							const uint8_t *value)
 {
 	struct mesh_subnet *subnet;
 
 	subnet = subnet_new(net, idx);
 	if (!subnet)
-		return MESH_STATUS_INSUFF_RESOURCES;
+		return NULL;
 
 	subnet->net_key_tx = subnet->net_key_cur = net_key_add(value);
 	if (!subnet->net_key_cur) {
 		l_free(subnet);
-		return MESH_STATUS_INSUFF_RESOURCES;
+		return NULL;
 	}
 
 	if (!create_secure_beacon(net, subnet, subnet->snb.beacon + 1) ||
 				!l_queue_push_tail(net->subnets, subnet)) {
 		subnet_free(subnet);
-		return MESH_STATUS_INSUFF_RESOURCES;
+		return NULL;
 	}
 
-	return MESH_STATUS_SUCCESS;
+	return subnet;
 }
 
 /*
@@ -1007,7 +1008,6 @@ static int add_key(struct mesh_net *net, uint16_t idx, const uint8_t *value)
 int mesh_net_add_key(struct mesh_net *net, uint16_t idx, const uint8_t *value)
 {
 	struct mesh_subnet *subnet;
-	int status;
 
 	subnet = l_queue_find(net->subnets, match_key_index,
 							L_UINT_TO_PTR(idx));
@@ -1019,9 +1019,9 @@ int mesh_net_add_key(struct mesh_net *net, uint16_t idx, const uint8_t *value)
 			return MESH_STATUS_IDX_ALREADY_STORED;
 	}
 
-	status = add_key(net, idx, value);
-	if (status != MESH_STATUS_SUCCESS)
-		return status;
+	subnet = add_key(net, idx, value);
+	if (!subnet)
+		return MESH_STATUS_INSUFF_RESOURCES;
 
 	if (!storage_net_key_add(net, idx, value, false)) {
 		l_queue_remove(net->subnets, subnet);
@@ -2490,7 +2490,7 @@ static void net_rx(void *net_ptr, void *user_data)
 	int8_t rssi = 0;
 
 	key_id = net_key_decrypt(net->iv_index, data->data, data->len,
-								&out, &out_size);
+							&out, &out_size);
 
 	if (!key_id)
 		return;
@@ -3017,7 +3017,6 @@ bool mesh_net_set_key(struct mesh_net *net, uint16_t idx, const uint8_t *key,
 					const uint8_t *new_key, uint8_t phase)
 {
 	struct mesh_subnet *subnet;
-	int status;
 
 	subnet = l_queue_find(net->subnets, match_key_index,
 							L_UINT_TO_PTR(idx));
@@ -3032,8 +3031,8 @@ bool mesh_net_set_key(struct mesh_net *net, uint16_t idx, const uint8_t *key,
 	if (phase != KEY_REFRESH_PHASE_NONE && !new_key)
 		return false;
 
-	status = add_key(net, idx, key);
-	if (status != MESH_STATUS_SUCCESS)
+	subnet = add_key(net, idx, key);
+	if (!subnet)
 		return false;
 
 	subnet = l_queue_find(net->subnets, match_key_index,
-- 
2.20.1

