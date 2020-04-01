Return-Path: <SRS0=i/J9=5R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD2AC2D0F4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 10:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C279F20787
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 10:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Ivine5MD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732156AbgDAKZC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:25:02 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:44736 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732146AbgDAKZC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Apr 2020 06:25:02 -0400
Received: by mail-lf1-f53.google.com with SMTP id 131so641387lfh.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2020 03:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=b63k3DErR/1nXLYBaG+6sS5inCIckcEURx2bMOJ8U6k=;
        b=Ivine5MD3r3VP0TM6ZGEGe/P+M0e+5WQ1STp/dc8yqT50ahfhLMuPDFugooqB8QijO
         yTNF6Y12T3ZxbDss5VEc1misZbW3s/cDdKuUUNnQS7KFK0DIGs4yBIK6TZyshVPKHKVB
         eTiHE5huZiROI139QgS/d7QzexkOnvMc43YVTEcWAzqyro+oBNFqnfRG3rbK4iIlZszL
         Hg4maxwzMC85p0kWNwY86PYc9MHY7RxnapsiSvCh2XQ67Xc4tUsEJIq6wZHW2Fh9SOOc
         4YEIMNxlg0+AWZTONAC19DPE7OswvfADqVi5oe60icJAFH6AOIWLQx7SPiM/VoM/iN0Q
         6Xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b63k3DErR/1nXLYBaG+6sS5inCIckcEURx2bMOJ8U6k=;
        b=ntWbnnME8JTn9cAlPJlk6BYqPkxGuwopJZdVpScBXb9RDyhkKfuMUSlNXO1txlgrs3
         Z1wF9qmQRiSZicQ0KYx4kR4Ld0lHXUVbPwyK3xzawQr6SFbeZmrz4YHSs4K7MfgNy3l7
         nCxcFcaHKeMLUZhAptqL8QhlKS5tpkFfThyS3CMEqqL9KBGSsAcel5/cLxjrIPlms2Gz
         pJPVtaV+iqUpz3TsitLCI0pHzlkY1oBN7/0SDrlFP8Q+kV4BNHM7yFS1NCDmrGNSQLSZ
         3/H7Q5aKAvQRg/JAld69M+LwgXA2YcvSS5LWI7HHg+0e5c5NXcbOz86UR+EqfYxnRkJH
         Rmvg==
X-Gm-Message-State: AGi0PuYLB8s/iuSpQ6iV5sxqay4thxFAQ81jxRJMVkImMISxNEr9UcPj
        w/vLmAH9PEwE4ncn0RHnIjoN/Kt/MMI=
X-Google-Smtp-Source: APiQypKnygG2Ih9iOxRmckaeF4h4vW0J6PWzlsI5c6WhPutD6Lv/cGXDM5bCnSCd7hXp+MDjHCJiNw==
X-Received: by 2002:a05:6512:403:: with SMTP id u3mr2239904lfk.4.1585736698127;
        Wed, 01 Apr 2020 03:24:58 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id r16sm922217ljj.40.2020.04.01.03.24.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 03:24:57 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/6] mesh: Remove unused 'server' argument
Date:   Wed,  1 Apr 2020 12:24:58 +0200
Message-Id: <20200401102502.746-3-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200401102502.746-1-michal.lowas-rzechonek@silvair.com>
References: <20200401102502.746-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/manager.c        | 2 +-
 mesh/prov-initiator.c | 1 -
 mesh/provision.h      | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/mesh/manager.c b/mesh/manager.c
index 0909c7e16..a4c2f2d41 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -256,7 +256,7 @@ static struct l_dbus_message *add_node_call(struct l_dbus *dbus,
 	}
 
 
-	if (!initiator_start(PB_ADV, uuid, 99, 0, 60, add_pending->agent,
+	if (!initiator_start(PB_ADV, uuid, 99, 60, add_pending->agent,
 				add_data_get, add_cmplt, node, add_pending)) {
 		reply = dbus_error(msg, MESH_ERROR_FAILED,
 				"Failed to start provisioning initiator");
diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index 7a767cfb3..d5bae114a 100644
--- a/mesh/prov-initiator.c
+++ b/mesh/prov-initiator.c
@@ -817,7 +817,6 @@ static void int_prov_ack(void *user_data, uint8_t msg_num)
 bool initiator_start(enum trans_type transport,
 		uint8_t uuid[16],
 		uint16_t max_ele,
-		uint16_t server, /* Only valid for PB-Remote */
 		uint32_t timeout, /* in seconds from mesh.conf */
 		struct mesh_agent *agent,
 		mesh_prov_initiator_data_req_func_t get_prov_data,
diff --git a/mesh/provision.h b/mesh/provision.h
index 755d848a0..d6f6e0ab0 100644
--- a/mesh/provision.h
+++ b/mesh/provision.h
@@ -118,7 +118,6 @@ void acceptor_cancel(void *user_data);
 bool initiator_start(enum trans_type transport,
 		uint8_t uuid[16],
 		uint16_t max_ele,
-		uint16_t server, /* Only valid for PB-Remote */
 		uint32_t timeout, /* in seconds from mesh.conf */
 		struct mesh_agent *agent,
 		mesh_prov_initiator_data_req_func_t get_prov_data,
-- 
2.20.1

