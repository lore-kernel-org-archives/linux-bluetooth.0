Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773F3C33C9E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 09:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E97D2072A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 09:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Gegj8Eke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbgAHJRC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:17:02 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40151 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbgAHJRC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 04:17:02 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so1640623wmi.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2020 01:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=myKdkenQN+/SWYiYcoyHE4AIxh9xihPryU32v+sp1lM=;
        b=Gegj8EkeimScr7YaxqD/ufCa3qj0JwuFYbm7Y4497gkMv1Dw6q8+WvcSvpTFbO733p
         EE3BUTrZ9s/qwdgT70dVvBuKYRy3idVUIQItZSZzOmi3eunWxhbc8HRcI22d2m91kc/a
         U03tu/PWEctANUJaZyANd28wTj14sQtCdn12xDGzTrtH1VzPtnrHMtsX+ndmyz50aFCF
         MDHv1tBLZsZ8sXF3Uet+tRoKgJL8mkxvfxTZKSIw53asy4wLNTAxhAncRWTmGRAud1+w
         Hir9MUpCGFZi+ZihN+69rSWWzO/lTvWPLkcf27xCG3HShI4rR+CsMucU/IuxcPvcoN1L
         q7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=myKdkenQN+/SWYiYcoyHE4AIxh9xihPryU32v+sp1lM=;
        b=YK6/aUH5EuWjtp/36NYRD/z1Blxv1N35j4nI8wNfnfcrxpqHlEbOzTvGSSVk5AszKG
         fZIqcvyJMjuPYPGB32DxaHgzbLz5+HPJzKyezmQKkAcOkybavGGdgeSnVdsXJD4VLA5J
         h/X6tYt/DxxuYpdOHKvVOsxtfYmMMSjezjy7KoVgySwdY58fkkChgIiCBHikccGev+QT
         ylh2ydLc5voffIEthI911xdFsXmxuRGAnkvq8/MI0wT9CpptoQIQtbHZp7jt/2dP1z/b
         QknL9MBZlWUd5bGdFqqW0QU/3MypLd48kW/T9z4jGze4k6xx2LfOM0EM2zTtKKkPGB1p
         enNA==
X-Gm-Message-State: APjAAAXfkMN8PqxEi27uyV0S078vVCdOiYLPW6RU3O8lxD3eJ3psA/3Z
        9o/OkfvR+X4LjKlwp5HH4j+anh58FGs=
X-Google-Smtp-Source: APXvYqwS1bh172/3GVVtlZ7eI1xetRBJn+6CrwDNnl3zoYviz0910yLzItr9tXodMpjBqB2nTGyBzQ==
X-Received: by 2002:a05:600c:224d:: with SMTP id a13mr2686453wmm.57.1578475019752;
        Wed, 08 Jan 2020 01:16:59 -0800 (PST)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id 18sm2848197wmf.1.2020.01.08.01.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 01:16:59 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Gajda?= <rafal.gajda@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Rafa=C5=82=20Gajda?= <rafal.gajda@silvair.com>
Subject: [PATCH BlueZ] mesh: Fix IV recovery                                                        
Date:   Wed,  8 Jan 2020 10:16:04 +0100
Message-Id: <20200108091604.15185-1-rafal.gajda@silvair.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch fixes saving IV received in SNB to storage.                                              
                                                                                                    
Previously after creating new node with IV 0 (or loading node with                                  
IV > 0 but after long inactivity) first received SNB should update IV                               
(and reset sequence number to 0 if necessary).                                                      
                                                                                                    
The bug would prevent new IV being saved in storage                                                 
which resulted in sequence number being set to 0                                                    
on first SNB received after every daemon reset                                                      
but IV never being updated.                
---
 mesh/net.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 5be95086d..1598933d4 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2706,14 +2706,7 @@ static void update_kr_state(struct mesh_subnet *subnet, bool kr, uint32_t id)
 static void update_iv_ivu_state(struct mesh_net *net, uint32_t iv_index,
 								bool ivu)
 {
-	uint32_t local_iv_index;
-	bool local_ivu;
-
-	/* Save original settings to differentiate what has changed */
-	local_iv_index = net->iv_index;
-	local_ivu = net->iv_update;
-
-	if ((iv_index - ivu) > (local_iv_index - local_ivu)) {
+	if ((iv_index - ivu) > (net->iv_index - net->iv_update)) {
 		/* Don't accept IV_Index changes when performing SAR Out */
 		if (l_queue_length(net->sar_out))
 			return;
@@ -2737,26 +2730,27 @@ static void update_iv_ivu_state(struct mesh_net *net, uint32_t iv_index,
 		}
 	} else if (ivu) {
 		/* Ignore beacons with IVU if they come too soon */
-		if (!local_ivu && net->iv_upd_state == IV_UPD_NORMAL_HOLD) {
+		if (!net->iv_update &&
+				net->iv_upd_state == IV_UPD_NORMAL_HOLD) {
 			l_error("Update attempted too soon");
 			return;
 		}
 
-		if (!local_ivu) {
+		if (!net->iv_update) {
 			l_info("iv_upd_state = IV_UPD_UPDATING");
 			net->iv_upd_state = IV_UPD_UPDATING;
 			net->iv_update_timeout = l_timeout_create(
 					IV_IDX_UPD_MIN, iv_upd_to, net, NULL);
 		}
-	} else if (local_ivu) {
+	} else if (net->iv_update) {
 		l_error("IVU clear attempted too soon");
 		return;
 	}
 
-	if ((iv_index - ivu) > (local_iv_index - local_ivu))
+	if ((iv_index - ivu) > (net->iv_index - net->iv_update))
 		mesh_net_set_seq_num(net, 0);
 
-	if (ivu != net->iv_update || local_iv_index != net->iv_index) {
+	if (ivu != net->iv_update || iv_index != net->iv_index) {
 		struct mesh_config *cfg = node_config_get(net->node);
 
 		mesh_config_write_iv_index(cfg, iv_index, ivu);
-- 
2.22.0

