Return-Path: <SRS0=bMpm=VU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DD7C7618E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Jul 2019 10:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE9422400
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Jul 2019 10:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="RYh4OYNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732888AbfGWKGi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:06:38 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:46360 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731714AbfGWKGh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Jul 2019 06:06:37 -0400
Received: by mail-lf1-f54.google.com with SMTP id z15so24637762lfh.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2019 03:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rToUAP85OIe5spVvqBDv/lObv0OwQt5EsA9YwprX0Bg=;
        b=RYh4OYNP5TH4tVoMOgwZBBOYUEgYqtWAZQdbx55OBCJVEPiCmP8DOmyawKMEw/jasF
         VT0ifxUZKIMKoHLxqNMfSg5W66AR9rw8PsBS1rijXPubXtZQ7ltsLYcqvgQ/0pSa/agt
         JgItL2wtFYrMRv+kmOZHfUtnqdh3mj2R33NXcAAqQb7nQLI2ajRzYe0R0wuR2dsgIFcU
         Hmf/PDO5WF9Cbmefo0u8GZL2vjwj6WiL52BkB8FWsjGioBWkGCsatTxAChlzrsxbnh/y
         JSkOKX1Dn39sx7xbck4ikTQn3AJOna5oRTYg7cC0hJGKucLNzxPHhBFVGcwZSDhQXgcQ
         gtyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rToUAP85OIe5spVvqBDv/lObv0OwQt5EsA9YwprX0Bg=;
        b=XlLp9eX73JZqEpJvcWCGeMgDrZYuoJJpG205qwgKI30zfwiIdbc/iDF1kHuG7TK4UV
         DHUga2XYMxqGoWBar9F5/xZHzsHUIEoZXAdkviQAv0Szig4rVzAdrwZ07wJ1R74VqnaA
         S+PiTg7re9c1mLVPX+9rjVU+Ii+RJVtcUtiyxDg4SDPl9Rt7W9eXbdtFl2FTc8GJLiCF
         QSG91caytK+D85mzJsT2aRrnT5r+aGXGO1onYDKjEeMg+g1TISVAVgs1JPSjwQ5NRPY5
         0q8Fg/pL5DVdOiIJdAq6dA3ABv39p/5fym2QrVcdOJPJewEhV3wpo9EbY/DbiiHNHSwx
         naBw==
X-Gm-Message-State: APjAAAVUPyr2Lvx8o61Gu85PU/9lhvtaHyP+/hOdklhDSve7UMhP84+C
        cw+1bnIofRIAUP1ZVdlg9yPTUg4TEyk=
X-Google-Smtp-Source: APXvYqzNy/xvQTPZTKpsuwTzQ5Ew+SsB5wpPi+wsvMrymsefdR1KGgkTDlkHiDwudVaHAlcnF5YTUw==
X-Received: by 2002:ac2:41d3:: with SMTP id d19mr34639996lfi.127.1563876396273;
        Tue, 23 Jul 2019 03:06:36 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id h129sm6395260lfd.74.2019.07.23.03.06.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 03:06:35 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/5] mesh: Check that config server is present in primary element
Date:   Tue, 23 Jul 2019 12:06:23 +0200
Message-Id: <20190723100623.6957-6-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190723100623.6957-1-michal.lowas-rzechonek@silvair.com>
References: <20190723100623.6957-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This verifies that Config Server model is supported by element #0, and
is not supported by any other element.
---
 mesh/node.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mesh/node.c b/mesh/node.c
index 8ff75c110..fe8cad008 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -899,6 +899,8 @@ uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf, uint16_t sz)
 {
 	uint16_t n, features;
 	uint16_t num_ele = 0;
+	uint8_t *cfgmod_idx = NULL;
+
 	const struct l_queue_entry *ele_entry;
 
 	if (!node || !node->comp || sz < MIN_COMP_SIZE)
@@ -961,6 +963,9 @@ uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf, uint16_t sz)
 			mod_id = mesh_model_get_model_id(
 					(const struct mesh_model *) mod);
 
+			if (mod_id == CONFIG_SRV_MODEL)
+				cfgmod_idx = &ele->idx;
+
 			if ((mod_id & VENDOR_ID_MASK) == VENDOR_ID_MASK) {
 				if (n + 2 > sz)
 					goto element_done;
@@ -1006,6 +1011,9 @@ element_done:
 	if (!num_ele)
 		return 0;
 
+	if (!cfgmod_idx || *cfgmod_idx != PRIMARY_ELE_IDX)
+		return 0;
+
 	return n;
 }
 
-- 
2.19.1

