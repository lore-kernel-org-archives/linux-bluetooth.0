Return-Path: <SRS0=76SB=XE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9293FC4740A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Sep 2019 19:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DB521D6C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Sep 2019 19:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="IVNtSueW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405488AbfIITZV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Sep 2019 15:25:21 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:40823 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbfIITZU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Sep 2019 15:25:20 -0400
Received: by mail-lf1-f49.google.com with SMTP id u29so11426980lfk.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Sep 2019 12:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U/wXBGUzX0jqWZ1IaMMUMtkYbR0sC01H/tyQ+UFHiPE=;
        b=IVNtSueWxObNSt5UDX2kk5i0NMHMfckpOUhzg7pEylWK6mY75HEVBCdbk85Sb+xtcv
         xvpzHKENqX+c0df3ubzHo76uK+wj1FvtDu1BB0raEIJYPQN0CBYmjqqIGShI34S5BcMi
         W0M3THUreNyQlk0+fEARGWPhYvTajkKNvAJOfOmb7oKnckaLxOUBH5ZyDYqh61iwTTA7
         55YmwgitBVET+/8uSyLowMf32T9jkdmMADrLTMIS/1NpctRdNwa2JI6naxatT8CfV+1w
         E4qgq71spvNRSqxs9Kwf6k3nSIpUyqKUqLVTTu8JNRzQFah+t8U2J51XPKPQ24IlKAJ9
         mopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U/wXBGUzX0jqWZ1IaMMUMtkYbR0sC01H/tyQ+UFHiPE=;
        b=NqqBx3mlILShG5644s2tLLUySNON5WYydDodscNwxyEevN3Oq5SgxTU1QTd73mR2+B
         ek9Gl3x3lUdJse5HGlUS88omr2D5F8CCPRp46e/ZfQuLE4arsHcELI66if5dDkBOHGgE
         jdHZN9UF1TVXSspbHZMO0kgg1IF2NGMWumQdbcqd9i5HGo4xMLrtunApd3bqgjaE5HhF
         UUZ4xlutgTv29hLx6kriz8b0k7jl19+pMaOXNhD3LDIipz8lwGpVid9K3JslR/aODVfR
         K5Yr5jYBJ+OCm9Wlr3ohM9HZYoBXb9OccYlPA6zE/VbcZRj63u6msDyd76nKqZIiZuX+
         Lp4A==
X-Gm-Message-State: APjAAAVdub5CfX3AsCwtkQiF8pppEuFdHQDbMykqNI0n3RZTaI0Sv+nu
        hvNsVuW9g2nEdqROdZkU9c62j592t8M=
X-Google-Smtp-Source: APXvYqwSb61VsM7FoS1QGgln6K8jXrGMv3U3fqzXj8YkaldR8GcUPM7UNvob3YAmAMrG+RvmEVRwcg==
X-Received: by 2002:a19:f11c:: with SMTP id p28mr17292000lfh.44.1568057118374;
        Mon, 09 Sep 2019 12:25:18 -0700 (PDT)
Received: from kynes.internet.domowy (apn-37-248-119-32.dynamic.gprs.plus.pl. [37.248.119.32])
        by smtp.gmail.com with ESMTPSA id c3sm3622904lfi.32.2019.09.09.12.25.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 12:25:17 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] mesh: Fix IV Recovery procedure when IV Update is in progress
Date:   Mon,  9 Sep 2019 21:25:09 +0200
Message-Id: <20190909192509.15007-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch ensures that Sequence Number is reset only when IV Index used
for outgoing messages increases.

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
equal to <N>, therefore it shall *not* reset its Sequence Number before IV
Update procedure completes.

If, on the other hand, SNB contains either:
 - IV Index <N>+2 (regardless of IV Update flag)
 - IV Index <N>+1 and IV Update flag *not* set
the node shall reset the Sequence Number right away.
---
 mesh/net.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 7c4049e0e..ba7bb32fd 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2735,8 +2735,6 @@ static void update_iv_kr_state(struct mesh_subnet *subnet, uint32_t iv_index,
 	}
 
 	if (net->iv_upd_state == IV_UPD_INIT) {
-		if (iv_index > net->iv_index)
-			mesh_net_set_seq_num(net, 0);
 		net->iv_index = iv_index;
 
 		if (iv_update) {
@@ -2757,6 +2755,12 @@ static void update_iv_kr_state(struct mesh_subnet *subnet, uint32_t iv_index,
 		mesh_config_write_iv_index(node_config_get(net->node), iv_index,
 							net->iv_upd_state);
 
+		/* Reset seq num if iv index used for *outgoing* messages has
+		 * just been increased
+		 */
+		if (mesh_net_get_iv_index(net) > local_iv_index)
+			mesh_net_set_seq_num(net, 0);
+
 		/* Figure out the key refresh phase */
 		if (kr_transition) {
 			l_debug("Beacon based KR phase change");
-- 
2.22.0

