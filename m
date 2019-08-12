Return-Path: <SRS0=fB+o=WI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4620EC31E40
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Aug 2019 12:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B3420663
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Aug 2019 12:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="KaAMOBXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfHLMHG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:07:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38449 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbfHLMHG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Aug 2019 08:07:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id m125so7481517wmm.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Aug 2019 05:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7gIRMi3bptQpoByiRCRWQUNUOAZQICc2FZLHQ6Aw4Ms=;
        b=KaAMOBXbzlPupkH9CJbZWG1bTBAAAURBSfZUKzaUYP0qW/S0smwtJK3NS3xZ/ZMPg6
         Cl6OBXuG8DwAe+Vf3R3pTXoBZaCNcnguBAEUrU02HzRaLPQLv+jcd6Gw+hHIVFvwNi9B
         ECgAiw36U6PcmXMHtNi41c/gmq2cX3t6WOyzzACBsmQSe8iVh1oSSB5b3irIcNDMB0oH
         NHZQ0E3Bl4N7C/LqehgQgrzvFI6CfkSXDFwOey//x0WaTmbmEdcepbeSc2gbsxMrKfZJ
         HwkwupXCnOpk++X4v2Virqg4PtS4RGyPo7GEcUK72lxo9kLoGzB7VtBXPMbbNXOF4hds
         t8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7gIRMi3bptQpoByiRCRWQUNUOAZQICc2FZLHQ6Aw4Ms=;
        b=rz5XMAzcBSQ76tOu5us87qopjctP3EzlcDM1oyu00CHcHAb5XSf5a+acmbxq5cUcx4
         0yTj3N0YdiZ5WIJ9O/vWP3L5qY+qYi2tt9TP+/9apu0QQr0Sja2SlHapLFQBdInFg/A5
         yk9gPBgkpK6mVtdQLZ4YUK05DjHk30Nl/OXhZtSm/zB4MEJRDedD5jIQMBRcvJOaxH+G
         Tx+jpWamhJIcL3LfU+V/yahJLdz+erigvYyt7u1lHQctYDM17h4g7v2A1OSlEefoxpj3
         QNpq/Q4Q3pdSava8807xnDPiJLCdCHIjxQVfW9eiVKa+/w37uFDq2NLMRSNLmbUvss2z
         XfUw==
X-Gm-Message-State: APjAAAXo68xez+9zXLB3VMrbUueSeQESie2noXvxqnI0bPnzSRo3yhJT
        1GJLakDZLKnD+5bJ26dcRESXULWqaLTWXw==
X-Google-Smtp-Source: APXvYqxfvOeT1p3nPgJI9MQnlYIh54bD0WTOUc79iiQXr48Xw3XtOBWYGlAdtDeCrckWYO1pKpGMFg==
X-Received: by 2002:a7b:c157:: with SMTP id z23mr7637907wmi.104.1565611624080;
        Mon, 12 Aug 2019 05:07:04 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id x20sm231717805wrg.10.2019.08.12.05.07.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 05:07:03 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Gajda?= <rafal.gajda@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Remove double initialisation and fix typo in log
Date:   Mon, 12 Aug 2019 14:06:56 +0200
Message-Id: <20190812120656.29494-1-rafal.gajda@silvair.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/node.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index e7e58d9a7..f8b1099e9 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -475,7 +475,6 @@ static bool init_from_storage(struct mesh_config_node *db_node,
 	node->lpn = db_node->modes.lpn;
 
 	node->proxy = db_node->modes.proxy;
-	node->lpn = db_node->modes.lpn;
 	node->friend = db_node->modes.friend;
 	node->relay.mode = db_node->modes.relay.state;
 	node->relay.cnt = db_node->modes.relay.cnt;
@@ -483,7 +482,7 @@ static bool init_from_storage(struct mesh_config_node *db_node,
 	node->beacon = db_node->modes.beacon;
 
 	l_debug("relay %2.2x, proxy %2.2x, lpn %2.2x, friend %2.2x",
-			node->relay.mode, node->proxy, node->friend, node->lpn);
+			node->relay.mode, node->proxy, node->lpn, node->friend);
 	node->ttl = db_node->ttl;
 	node->seq_number = db_node->seq_number;
 
-- 
2.22.0

