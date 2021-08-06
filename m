Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11057C4320A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 21:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E56E761186
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 21:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245257AbhHFVgS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Aug 2021 17:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245261AbhHFVgR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Aug 2021 17:36:17 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2793C061798
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Aug 2021 14:36:00 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d17so8792663plr.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Aug 2021 14:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lRJUx9M9PkpSlRyma5IgNqqGSYHjUDuHJLU3o9RBpa4=;
        b=fmKyw6z0e+MMPb7FaqHpb0eDWT++XynhUxXySWmjgjDD3E9AZSzpUYfuuqXSMd0kGp
         3awyWG9s4ye+JfSElinreK0gZMe8kDseElKFng3wx8mYdAiJTzf6zrQZvB32iPVDiqnt
         nhYb8GGHUxoISeT7D3btM60LFPJGMCMBXXBuTdrsvL/efEF5iq/0HFRESQHJe9RaFmsp
         vBwg9gJLKkaiTR+AwEMxN7+wM3M006XrVpvpe1htHtTmEKiKsuVfqeC2oFAfyXC8N6K2
         u6+CTV5OWXCS4utjOVGs4RgrkkQqWpJVm3koBqxWgfPbVo1z9qwI4CgS5MhZmOH99GNy
         XGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lRJUx9M9PkpSlRyma5IgNqqGSYHjUDuHJLU3o9RBpa4=;
        b=WiFvrusO5LYWn7vNLp77ux+vr3MRdxp1qBAoIHQyqXfyrr18oaxZa/LQLAQLCRRn1b
         5UZ7KrJLNYgEgS3dgyf7QNtUfWU6T+H0hE+A5SlZ5nCCJgR7mLh7/aFgwe6BzoudggLz
         FqLlwiBWR1aC8czE1G3mJSWeOWaLduEFEKStlO9LsbpZpyrBlmAVncVE4OZ3+n9whDcT
         49PatHbIK1fRrE/3SNofoi62jsOIkGbxtoD2mriZjbTsSbnRrxYl0Mxc/ASL5zOpKhqj
         mwXryNJYyPh4KjPizzKDc3SXEP+zidyEfiv08ojO2t5iawkdM0wIWAV6JBlfXlPfrBx9
         uYaA==
X-Gm-Message-State: AOAM5339smFjXgERiDv8uYQdIuCPLRvi7ezumLAYiIobfDdztExh8OuS
        2rRXyujJiolX0SryHljoGKeZmZrc9+A=
X-Google-Smtp-Source: ABdhPJzUCv3FQMyxn+OkAjOWX1Asjfenr0g6qbbSzH7/C/4ZHqdgCZH17QgqnGmr7Ivz43/U5n3RQg==
X-Received: by 2002:a17:90a:6684:: with SMTP id m4mr567002pjj.127.1628285760042;
        Fri, 06 Aug 2021 14:36:00 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h20sm11765201pfn.173.2021.08.06.14.35.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 14:35:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] monitor: Fix median packet size
Date:   Fri,  6 Aug 2021 14:35:55 -0700
Message-Id: <20210806213558.16442-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Calculating the median packet based on the current median + size / 2
does not account for last packet could smaller e.g. opp transfer could
end with just 1 byte which would cut the median in a half, so this
switch to more traditional means of calculating by doing total bytes
sent / num of packets so each an every packet has the same weight.
---
 monitor/analyze.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index 839c2f7e9..5e0957ad1 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -61,6 +61,7 @@ struct hci_conn {
 	unsigned long rx_num;
 	unsigned long tx_num;
 	unsigned long tx_num_comp;
+	size_t tx_bytes;
 	struct timeval last_tx;
 	struct timeval last_tx_comp;
 	struct timeval tx_lat_min;
@@ -99,6 +100,8 @@ static void conn_destroy(void *data)
 		break;
 	}
 
+	conn->tx_pkt_med = conn->tx_bytes / conn->tx_num;
+
 	printf("  Found %s connection with handle %u\n", str, conn->handle);
 	printf("    BD_ADDR %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X\n",
 			conn->bdaddr[5], conn->bdaddr[4], conn->bdaddr[3],
@@ -485,16 +488,12 @@ static void acl_pkt(struct timeval *tv, uint16_t index, bool out,
 	if (out) {
 		conn->tx_num++;
 		conn->last_tx = *tv;
+		conn->tx_bytes += size;
 
 		if (!conn->tx_pkt_min || size < conn->tx_pkt_min)
 			conn->tx_pkt_min = size;
 		if (!conn->tx_pkt_max || size > conn->tx_pkt_max)
 			conn->tx_pkt_max = size;
-		if (conn->tx_pkt_med) {
-			conn->tx_pkt_med += (size + 1);
-			conn->tx_pkt_med /= 2;
-		} else
-			conn->tx_pkt_med = size;
 	} else {
 		conn->rx_num++;
 	}
-- 
2.31.1

