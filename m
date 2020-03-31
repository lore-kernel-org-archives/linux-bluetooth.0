Return-Path: <SRS0=zBKN=5Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E5FC2D0E8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 08:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98453207FF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 08:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="yK4tixCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbgCaI2J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:28:09 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:52702 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgCaI2J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Mar 2020 04:28:09 -0400
Received: by mail-wm1-f48.google.com with SMTP id 11so348888wmi.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2020 01:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vYAMV5v1hwqkVPZnIXGU7A7cDowgkZ7nZYotsfKt4II=;
        b=yK4tixCxMx7HGKQcgtuVtHP4kLnLkyQlh9yq5g/oj35Unmyps6MtheK33qegOFvxEL
         tD7dFn+6tuQrQNzCpHvnXWuFdhRiZFM9/U9bGgAU9w+MJPKEW4ArttBH/ivoLeiTcEPe
         rY8fZXj2XgZgs9wyNpHu/pf1u/dOZK8I9CdLgNXQmgn6EpeJM2Pd73V5GWQw3t8f7ORL
         W4Ai+Xv5CKwHLYVeByEnLB/Am7ilr5YrGnSSqe68CP8cGGCXtHpHyEG9uQwNfXaCuzBj
         hzbpNhdfZlorV594jeBp3KDr/40c/77Dmwy1m/CLbC4VQDVtPNXel1sMlKvZspNWHt55
         ZdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vYAMV5v1hwqkVPZnIXGU7A7cDowgkZ7nZYotsfKt4II=;
        b=fN/kDX3DMKS+EQMFbn58HgIZuukzWoFDbdz8q99fSYiKnldVzCXSDKlRGGMyLYbcfB
         4JKpUbywZdYW15j+i4xK5oWpPDqqsPrTiovkphZ0lZ+z0Eslnf3P6p8RefoaeHw3P/fZ
         kTC2aS8yrit9uP1Cnogrdndx1gO/uy95dxzdiyY+eiv2xC6DL0B7xSGyew4/8Uqz86JH
         STFh+Ak5hzy+o5IJU9zTLAgk5W16aDxoRkvC4OQFh/OKdBCakOQuXVfBluRTfkvPiRgO
         oejS/EYAXtVgOUYQkmOZJPGFTWU4Ae/yHxoOibK9TOlQojaKUxo+jGaPuSggy4d1Qa1Y
         Rr1w==
X-Gm-Message-State: ANhLgQ0+jZRguO7AFMzK0yDiGvLNqWqmYBj4D73bT89L4T7eFqV5VEA0
        qoHtrixFvCTreHrL5IkLDxsxqDGuNolRhg==
X-Google-Smtp-Source: ADFU+vsiTHHCeb4stL1ZCt0/wPcEfjHtQCVHXUqr+wSjfRD/6pvFunSu9B9jHvBGz4cq9pBOAZpoHw==
X-Received: by 2002:a1c:1b14:: with SMTP id b20mr2114754wmb.163.1585643285178;
        Tue, 31 Mar 2020 01:28:05 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id x16sm6172296wrn.71.2020.03.31.01.28.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 01:28:04 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/6] mesh: Clean up naming of provisioning callbacks
Date:   Tue, 31 Mar 2020 10:28:07 +0200
Message-Id: <20200331082810.10856-4-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200331082810.10856-1-michal.lowas-rzechonek@silvair.com>
References: <20200331082810.10856-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/prov-initiator.c | 18 +++++++++---------
 mesh/provision.h      |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index d5bae114a..f2ebff69e 100644
--- a/mesh/prov-initiator.c
+++ b/mesh/prov-initiator.c
@@ -77,10 +77,10 @@ enum int_state {
 #define MAT_SECRET	(MAT_REMOTE_PUBLIC | MAT_LOCAL_PRIVATE)
 
 struct mesh_prov_initiator {
-	mesh_prov_initiator_complete_func_t cmplt;
-	mesh_prov_initiator_data_req_func_t get_prov_data;
+	mesh_prov_initiator_complete_func_t complete_cb;
+	mesh_prov_initiator_data_req_func_t data_req_cb;
 	prov_trans_tx_t trans_tx;
-	void *agent;
+	struct mesh_agent *agent;
 	void *caller_data;
 	void *trans_data;
 	struct mesh_node *node;
@@ -125,7 +125,7 @@ static void int_prov_close(void *user_data, uint8_t reason)
 	struct mesh_prov_node_info info;
 
 	if (reason != PROV_ERR_SUCCESS) {
-		prov->cmplt(prov->caller_data, reason, NULL);
+		prov->complete_cb(prov->caller_data, reason, NULL);
 		initiator_free();
 		return;
 	}
@@ -135,7 +135,7 @@ static void int_prov_close(void *user_data, uint8_t reason)
 	info.unicast = prov->unicast;
 	info.num_ele = prov->conf_inputs.caps.num_ele;
 
-	prov->cmplt(prov->caller_data, PROV_ERR_SUCCESS, &info);
+	prov->complete_cb(prov->caller_data, PROV_ERR_SUCCESS, &info);
 	initiator_free();
 }
 
@@ -738,7 +738,7 @@ static void int_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 			goto failure;
 		}
 
-		if (!prov->get_prov_data(prov->caller_data,
+		if (!prov->data_req_cb(prov->caller_data,
 					prov->conf_inputs.caps.num_ele)) {
 			l_error("Provisioning Failed-Data Get");
 			fail_code[1] = PROV_ERR_CANT_ASSIGN_ADDR;
@@ -819,7 +819,7 @@ bool initiator_start(enum trans_type transport,
 		uint16_t max_ele,
 		uint32_t timeout, /* in seconds from mesh.conf */
 		struct mesh_agent *agent,
-		mesh_prov_initiator_data_req_func_t get_prov_data,
+		mesh_prov_initiator_data_req_func_t data_req_cb,
 		mesh_prov_initiator_complete_func_t complete_cb,
 		void *node, void *caller_data)
 {
@@ -836,8 +836,8 @@ bool initiator_start(enum trans_type transport,
 	prov->to_secs = timeout;
 	prov->node = node;
 	prov->agent = agent;
-	prov->cmplt = complete_cb;
-	prov->get_prov_data = get_prov_data;
+	prov->complete_cb = complete_cb;
+	prov->data_req_cb = data_req_cb;
 	prov->caller_data = caller_data;
 	prov->previous = -1;
 
diff --git a/mesh/provision.h b/mesh/provision.h
index d6f6e0ab0..43f53f935 100644
--- a/mesh/provision.h
+++ b/mesh/provision.h
@@ -120,7 +120,7 @@ bool initiator_start(enum trans_type transport,
 		uint16_t max_ele,
 		uint32_t timeout, /* in seconds from mesh.conf */
 		struct mesh_agent *agent,
-		mesh_prov_initiator_data_req_func_t get_prov_data,
+		mesh_prov_initiator_data_req_func_t data_req_cb,
 		mesh_prov_initiator_complete_func_t complete_cb,
 		void *node, void *caller_data);
 void initiator_prov_data(uint16_t net_idx, uint16_t primary, void *caller_data);
-- 
2.20.1

