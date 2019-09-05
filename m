Return-Path: <SRS0=Ti+w=XA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB04C3A5A5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Sep 2019 13:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221E9206CD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Sep 2019 13:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="CIFqZBm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387419AbfIENMt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:12:49 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46953 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731361AbfIENMt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Sep 2019 09:12:49 -0400
Received: by mail-lj1-f194.google.com with SMTP id e17so2382083ljf.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Sep 2019 06:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qOSrrm6rfp92DGtXFs85xVzRon7AaRe5eJWd22ndJOE=;
        b=CIFqZBm7xhasAx1ersYYF3axyDO+kiu1nQrunNQ4ea6DVzqYMBhYEqWJnjuL5cV6J8
         DuMJxESPpdLpOjk+w1WpgRsjty2Fs7ZQHnfU0anrBngtZri+RwyioiyogvKFvMAqheaV
         OI0SZfOlQXpwT+o04ukm7V4IA51gzsSORprj7YIuI3r/cUFU7l5jM8pQY4OdBHuuqoXg
         BgOLUh/dm7a5B0iZChTGuLyKsn5lf53cxbZf3ToDHjrRDwX+GFjqBTv8sOu9IURpDDeU
         TRcTmvP9zgGU+ig2O7i6UcRGvPLjUMkZ/oGigKb/hClkqcPWl7V3n8J3qPYPfs2SB4bf
         yTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qOSrrm6rfp92DGtXFs85xVzRon7AaRe5eJWd22ndJOE=;
        b=nuTWhXncJlcGZ60sU1CU6P2FXhqQSM8rg3DU0uinqv9oCfDN6SUDlltxW8dtYufhPv
         PkRaFNyvTVqhQgkNOdCUnhvIEk+1MTik+JGx0jFxk9QLhutUC+H9/4RULlRDVou6qcvp
         HtU3OfZK8HYtep0uHzjZ5SC/6kUG3WxVgbgahUcnAPe4k+P477RgSQJ4EILxHp9x8qNK
         Y198DpoffKXIE1OcFY5fQgi0CZt9cwcFkwwws9T5ITdJfwXM0BOtDuzvCd21HWnrW9xf
         5M9SRlzO85pW80BwHhTdUvXFUEb4JI6TzmpVkW3bFHNsMXQvDZch38PznZAoxSkenOlV
         EZrw==
X-Gm-Message-State: APjAAAUWr60BdBjRskf40z8BLR5s1fSidTWc78TtQmZXXayt8ofX2vmC
        HtW0GlDw51FGe+Qhx+VXAs6iwPU36NY=
X-Google-Smtp-Source: APXvYqwNkvRPhC5AFrA4oASV/2ONeXODt4J2GQuDsWX9jX8idAizGdpY3OrwicJBDVEK+7uf1g0nfA==
X-Received: by 2002:a2e:990f:: with SMTP id v15mr2096426lji.127.1567689166838;
        Thu, 05 Sep 2019 06:12:46 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id v10sm429794lfi.26.2019.09.05.06.12.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 06:12:45 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Fix IV Recovery procedure when IV Update is in progress
Date:   Thu,  5 Sep 2019 15:12:40 +0200
Message-Id: <20190905131240.24969-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes erroneously cleared sequence number when node performs IV
Recovery procedure on startup in a following scenario:
     - node has IV Index set to <N>
     - node starts in IV_UPD_INIT state
     - node receives a Secure Network Beacon with IV Index <N>+1 and IV
       Update flag set

Upon reception, the node shall:
    - increase its IV Index to <N>+1
    - enter IV_UPD_UPDATING state

This means that the node keeps transmitting messages using IV Index
equal to <N>, therefore it shall not reset its Sequence Number before IV
Update procedure completes.

If, on the other hand, received Secure Network Beacon contains IV Index
<N>+2 (or more), the node shall:
    - increase its IV Index to <N>+2 (or more)
    - enter IV_UPD_UPDATING state
    - reset the Sequence Number to 0
---
 mesh/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/net.c b/mesh/net.c
index 2785039db..b4b390541 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2735,7 +2735,7 @@ static void update_iv_kr_state(struct mesh_subnet *subnet, uint32_t iv_index,
 	}
 
 	if (net->iv_upd_state == IV_UPD_INIT) {
-		if (iv_index > net->iv_index)
+		if (iv_index > net->iv_index + 1)
 			mesh_net_set_seq_num(net, 0);
 		net->iv_index = iv_index;
 
-- 
2.19.1

