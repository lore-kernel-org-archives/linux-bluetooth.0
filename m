Return-Path: <SRS0=fB+o=WI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC97EC31E40
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Aug 2019 12:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813F920651
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Aug 2019 12:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="OiCPXRde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfHLMId (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:08:33 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43589 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfHLMIc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Aug 2019 08:08:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id h15so4376221ljg.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Aug 2019 05:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PrelaoJ6TnJpyofqhLMulqO3h0BlAQ5EW0e+QZj++2g=;
        b=OiCPXRdeaG94Qr9u9ukwqvx3KBFqWbW4sX74KOqEN0Bf9UJwt+go/99IkXlvRbk4Rk
         uU6nhgFLqGnAEJBtCleI/rc1b1UL2gk+GZX0K6OSofL+GhLZND86GEIV2yrrfAdLprVy
         eqRkYe4H3pg7+VaGKkBpleF/az4WPRW7dtyayunBzNcXuuFDPCWLUPP1waf6OiQqUcxA
         LWnTs/82IN/b8ACPwyUbDffUIy8JuTpd2nEvNKkg76noxflMTp0EXLmoHS0MMGPpONLg
         OeSRkFmKDxL2Z0oC8nIluv7IJ0K8aroy3N6Jyjnxein3FPjP2ABrvmDN0Xwkhl8oAfP7
         rLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PrelaoJ6TnJpyofqhLMulqO3h0BlAQ5EW0e+QZj++2g=;
        b=P15MI761TaP885fF6XAF2+V/iDC7uVQ5ETElp3Njo4fJHRVBC4RP9SnNBotfHLk01g
         XWp1l0D67wrg8VfrBPLK4DGgzut9JhzgEgPWb8OxWF7i4Pf73Rc+851bB5oDnJyJfE4d
         ziCp6UszeC7cr6RLMIcftfSsMO68csA2vexneigacT/PGYwQ+Ax+qmTaDQlb4lHwmtSF
         hhSA/MqZQXvKz3xI/E4uYITmL8LjrtfVgCNm5rZ/NBYQf/U42kDRBKLsNMeibiLW8PNH
         0xqg2Gap5Q1jQJO9Hsnuu7TIs3XGJZNX14FaCPs4bnEApAqU9WkAQpLkuOEz3PsX1XqL
         fj9w==
X-Gm-Message-State: APjAAAXAKimqyjfw6hXVW1iOb6bPhFl6+WUIXyiWYW6pDaJMFN/DYxN6
        WR02RSswTZNhQIxGJ0vf39p863dnof5whQ==
X-Google-Smtp-Source: APXvYqx/RPddfkkJC/tbg7bfL0+cKD35cFp3QUBYWFcLtZk72VII31p7Cw2wwfhD8n8cnEsRkh4yjg==
X-Received: by 2002:a2e:9cc6:: with SMTP id g6mr4102305ljj.22.1565611710464;
        Mon, 12 Aug 2019 05:08:30 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id o3sm19019132lfb.40.2019.08.12.05.08.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 05:08:29 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Gajda?= <rafal.gajda@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Fix model publication get
Date:   Mon, 12 Aug 2019 14:08:25 +0200
Message-Id: <20190812120825.29610-1-rafal.gajda@silvair.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/cfgmod-server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 4447b1cb1..dbed7e03f 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -93,7 +93,7 @@ static bool config_pub_get(struct mesh_node *node, uint16_t net_idx,
 	ele_idx = node_get_element_idx(node, ele_addr);
 
 	if (ele_idx >= 0)
-		pub = mesh_model_pub_get(node, ele_idx, mod_id, &status);
+		pub = mesh_model_pub_get(node, ele_addr, mod_id, &status);
 	else
 		status = MESH_STATUS_INVALID_ADDRESS;
 
-- 
2.22.0

