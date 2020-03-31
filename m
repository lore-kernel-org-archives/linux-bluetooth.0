Return-Path: <SRS0=zBKN=5Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD14C2D0EE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 12:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32DB20781
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 12:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="tScMjxXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbgCaMJT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Mar 2020 08:09:19 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:45700 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbgCaMJT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Mar 2020 08:09:19 -0400
Received: by mail-lf1-f47.google.com with SMTP id v4so17044832lfo.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2020 05:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=9Sy22lMvpxzpI8o4xfvZVI1l9nlQgjalZ08I2FKQd9Q=;
        b=tScMjxXi0TV+9Ksbn40ZZu/82WiigvCbsLpSsylbU02OXdUgiv+AdD1pjRhB1KBdOD
         q4PLBxdNFkRl0kjRegYzFtwo0W88VB1hOxAdgeN2G1FozO3XwSxEh3ga/BZNMd6N9p12
         uQfDKi2jh4ktOmd9ZHA1Xjas6i+NkUXswGA2ru4GZ6ZjYHoWRJiv8lXFdf9vaUGxGyi1
         cHf8DOAuToyEllJTXNrPbD+0FIAnGfDdZecPPtvIgBaUuSlN1H1VnwlWZmGE3C+axVAv
         Itt45EluaPhSVCXnPxqBS4xc8LOB1u6IJHcxoubRdrf2mbXmNwNZ5oF6dvoR7H+pZu8Z
         Pxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=9Sy22lMvpxzpI8o4xfvZVI1l9nlQgjalZ08I2FKQd9Q=;
        b=NYSfU+m5WzxYACtAE0ZBY7SPid3pHqO+272xTHFu7tbOplSi8lzqiUaEMvk5lHStym
         2ZM3+x0vrs+v0GrF9oRDfTGp5Wifco2vKA2w1lMG6Rnm2m1PFh+dBDWvRRJYf17JTItA
         n6XvnXnFTNLw5pyjWOfYZOqWKyhqqhBt7dOCfwLW70yIcA5OsquyHr9o3nLVv5jp0pJO
         j/vG5IOH28L6r87QCEbeCY/YA894aRmFpJPNRj4mN4t+MJS4PZjPxIgZbU8GI9ne/cIm
         igZaF3pRIR4baBpExVnN6UJun9XKMPb80bJoomYpIUNZlRmQIt5T4nA6qLfnwRkdm1X0
         FaCQ==
X-Gm-Message-State: AGi0PuZ7AivQbDiQtwlGGlH0vTglX6kJFexC7vesaTDss/QxlBS1u6/X
        gvbI2pgjPwrzSb/pOaNCqHduxOcqYO0=
X-Google-Smtp-Source: APiQypJYvUi8ozRzMx9v58mlzeRJsVO6Ibzov/bZV1tfrhrWGSYl01XIxwdcUnzAlIeQ9F1puz0eBQ==
X-Received: by 2002:ac2:46ed:: with SMTP id q13mr11276965lfo.176.1585656556509;
        Tue, 31 Mar 2020 05:09:16 -0700 (PDT)
Received: from pfierek1997.silvair.lan (174.60.citypartner.pl. [195.210.60.174])
        by smtp.gmail.com with ESMTPSA id i190sm9828620lfi.7.2020.03.31.05.09.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 05:09:16 -0700 (PDT)
From:   =?UTF-8?q?Przemys=C5=82aw=20Fierek?= 
        <przemyslaw.fierek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/3] mesh: Remove unused functions: 'mesh_net_sub_list_add' and 'mesh_net_sub_list_del'
Date:   Tue, 31 Mar 2020 14:09:07 +0200
Message-Id: <20200331120908.23215-3-przemyslaw.fierek@silvair.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200331120908.23215-1-przemyslaw.fierek@silvair.com>
References: <20200331120908.23215-1-przemyslaw.fierek@silvair.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/net.c | 27 ---------------------------
 mesh/net.h |  2 --
 2 files changed, 29 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 11a9d84a3..5f49034e4 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2979,33 +2979,6 @@ bool mesh_net_iv_index_update(struct mesh_net *net)
 }
 
 
-
-void mesh_net_sub_list_add(struct mesh_net *net, uint16_t addr)
-{
-	uint8_t msg[11] = { PROXY_OP_FILTER_ADD };
-	uint8_t n = 1;
-
-	l_put_be16(addr, msg + n);
-	n += 2;
-
-	mesh_net_transport_send(net, 0,
-			mesh_net_get_iv_index(net), 0,
-			0, 0, 0, msg, n);
-}
-
-void mesh_net_sub_list_del(struct mesh_net *net, uint16_t addr)
-{
-	uint8_t msg[11] = { PROXY_OP_FILTER_DEL };
-	uint8_t n = 1;
-
-	l_put_be16(addr, msg + n);
-	n += 2;
-
-	mesh_net_transport_send(net, 0,
-			mesh_net_get_iv_index(net), 0,
-			0, 0, 0, msg, n);
-}
-
 bool mesh_net_dst_reg(struct mesh_net *net, uint16_t dst)
 {
 	struct mesh_destination *dest = l_queue_find(net->destinations,
diff --git a/mesh/net.h b/mesh/net.h
index 57585ceff..df4366b59 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -363,8 +363,6 @@ void mesh_net_provisioner_mode_set(struct mesh_net *net, bool mode);
 bool mesh_net_provisioner_mode_get(struct mesh_net *net);
 bool mesh_net_key_list_get(struct mesh_net *net, uint8_t *buf, uint16_t *count);
 uint16_t mesh_net_get_primary_idx(struct mesh_net *net);
-void mesh_net_sub_list_add(struct mesh_net *net, uint16_t addr);
-void mesh_net_sub_list_del(struct mesh_net *net, uint16_t addr);
 uint32_t mesh_net_friend_timeout(struct mesh_net *net, uint16_t addr);
 struct mesh_io *mesh_net_get_io(struct mesh_net *net);
 struct mesh_node *mesh_net_node_get(struct mesh_net *net);
-- 
2.17.1

