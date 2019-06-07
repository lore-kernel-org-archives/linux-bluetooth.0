Return-Path: <SRS0=bh0L=UG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB711C28CC3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 09:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77AD4208C3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 09:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="tG40+Sl0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfFGJtx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jun 2019 05:49:53 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35048 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfFGJtx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jun 2019 05:49:53 -0400
Received: by mail-lf1-f66.google.com with SMTP id a25so1134641lfg.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jun 2019 02:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SwaM2tncNThKl0d7z9AMCAupKVf0rcGq1uOqYWEY4kY=;
        b=tG40+Sl02B4FksvRTqBCIZxQRcotm2a1P4Pdy3OyXTQDrY1Cu7ZR4TUnxuyjQDFy0g
         Xg8dKrKIlM66re7EmOE+656cCrpSM7FEIVDtca9goJH7wbKIaVb0zv1Ba73zbumHzy2u
         W6e6IKxkr67u8Xq5+WR76hjbwVSsRMrt1Y1Pp2PnR4/TBdbGcmh28el8IcJfJDOng0Ck
         TAInoPmrNBnjyahMC4eI8oD2xSpsAzeKNKUwMbx+bq3vU+gn/NTxN6xnHaysIzs82idg
         MPOszfO5SSW8g0HURpx944Ucen2harQStb9H8LhHKCV2DN9V7dQltj85CRTqccTEsTyH
         qnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SwaM2tncNThKl0d7z9AMCAupKVf0rcGq1uOqYWEY4kY=;
        b=Hn9iPIi4ZTn0kRn40rgg/lWCODHDs9QA9Ou+rkMf33AT8ACjiLNvQwRsj1IE1BPJJ9
         rgFFdt1ZqPM28bu+Iq+QuejfF+KHiiv4HMnFVzmliQQEWgDb7/9NpLOvQR6xZzjgVG+y
         jxXEIH/HQEiyQ9ZQcL+qO5NiefpxqfGspETvlrE/7tchRHehQLMKlwlrajU+qU1vnE3g
         zOZPvWv2L8JqM/+KV/ef5zuS9JOLTnaKIslmbj213TutdmH2Vfp7A+NreLBVTinlicjN
         GB96aZWpmRor1/XYVuZ9Ck8wORfWPHODbevhbqLa7CKtHVlA5mTMwmNru+z1sSXS2Zo7
         05GA==
X-Gm-Message-State: APjAAAXF5qkPGKxM7t6zfmgye9BSkKjeueA4xr3/BMYMuhtu6520RiLM
        XoXkFRMMhb+2KpiiAo3WAD9tN1Y6ksdPAQ==
X-Google-Smtp-Source: APXvYqweDJwPpVj+NNXuAv9j0T/cbBfu5DTvG1f6X5V1PgJuE2JitCz1Qr1WQAnp7usoGlF15J89Zw==
X-Received: by 2002:a19:671c:: with SMTP id b28mr26124156lfc.164.1559900991511;
        Fri, 07 Jun 2019 02:49:51 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id u13sm322895lfi.4.2019.06.07.02.49.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 02:49:50 -0700 (PDT)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2] mesh: Fix segmentation fault after adding second netkey via NET_KEY_ADD opcode
Date:   Fri,  7 Jun 2019 11:49:46 +0200
Message-Id: <20190607094946.15920-1-jakub.witowski@silvair.com>
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
 mesh/net.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index c7aff9ab4..9a5fa3e5f 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -977,27 +977,28 @@ int mesh_net_del_key(struct mesh_net *net, uint16_t idx)
 	return MESH_STATUS_SUCCESS;
 }
 
-static int add_key(struct mesh_net *net, uint16_t idx, const uint8_t *value)
+static struct mesh_subnet *add_key(struct mesh_net *net, uint16_t idx,
+														const uint8_t *value)
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
@@ -1019,9 +1020,9 @@ int mesh_net_add_key(struct mesh_net *net, uint16_t idx, const uint8_t *value)
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
@@ -2490,7 +2491,7 @@ static void net_rx(void *net_ptr, void *user_data)
 	int8_t rssi = 0;
 
 	key_id = net_key_decrypt(net->iv_index, data->data, data->len,
-								&out, &out_size);
+													&out, &out_size);
 
 	if (!key_id)
 		return;
@@ -3032,8 +3033,8 @@ bool mesh_net_set_key(struct mesh_net *net, uint16_t idx, const uint8_t *key,
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

