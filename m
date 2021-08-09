Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84569C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 22:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6967160FDA
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 22:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbhHIWuF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Aug 2021 18:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhHIWuF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Aug 2021 18:50:05 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52423C0613D3
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Aug 2021 15:49:44 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so2338434pjl.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Aug 2021 15:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lRJUx9M9PkpSlRyma5IgNqqGSYHjUDuHJLU3o9RBpa4=;
        b=DtqOjSac15xS2dz3+eCOolSYnXSMljSIBgfkS7CIp6bBW4Ku6xkQBC4t56a5krEtoc
         ZM1N4thXEcKtMjG0iRz4bI89lxWrkReiZvmKBImW7GPiRhRvUb4RSvPVMwhr3LJFKNW4
         gSryCpIL7/J+XXmWrcQPCm2EZ0o0r29+WKD/c51/2GUnnsBFBFrwdUzXIh3LzVyO8EaR
         +JLIH6HfXSsb+zn/xyOwMddfDSbjZqmwObPECaYstBEW02yLz6RaVjQi00uaVYa29gXb
         O0v0DIpBKCVz63em0We2Qz8XB7QPitXXoaajut0dD4NFoshqj0WDPghK0tCqZf5lmo/H
         wr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lRJUx9M9PkpSlRyma5IgNqqGSYHjUDuHJLU3o9RBpa4=;
        b=No4dXHDoH7zF6lDI/CBJIk1s/eVEB8xsgtR3fp++2dvqQDPkXC3X7O7am25sZYufHi
         SkH8AchngrTESI7lw5dLk+7+f8UaMV6YAdlB0rIUZuVrqzc+XpPZwwoDrezuK9ZSyuzv
         xbtnroYSA3ZiaNAepJX0zPacg9dCRFCjrUwWv5rYzrsVsv98EhsxOMDYk6bAc4AhalQ8
         Be0xrRSjqbLxDjrPP0zzUi869bvFWoI35iKTwNn9k4OHzOB1K06QYR6lIrDFaDsk8xZK
         EA6WRaC5Jn1rQjzUbdTEF7oNiOyqlT1cS2xYWKjTM/SNKkqfkQrxP8SH6aAyXRT0ekBc
         T/qQ==
X-Gm-Message-State: AOAM530bUCsZg/K32RCnLPQjradwLkMBPG0xQ86a/bQWqnq2IabICs8E
        E5zhqzOSqg3HtGYpEa6MCvxM4yN7oe4=
X-Google-Smtp-Source: ABdhPJzA9PBNPabh8Jp0Yp+eWQqIsIa9gDTULoeTIC9ciJEG+pbrdqZY2WlEjHD5X2bSNZrBLgIkVA==
X-Received: by 2002:a17:902:6904:b029:fb:42b6:e952 with SMTP id j4-20020a1709026904b02900fb42b6e952mr7682620plk.16.1628549383667;
        Mon, 09 Aug 2021 15:49:43 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n35sm20826891pfv.152.2021.08.09.15.49.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 15:49:43 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 1/5] monitor: Fix median packet size
Date:   Mon,  9 Aug 2021 15:49:38 -0700
Message-Id: <20210809224942.225915-1-luiz.dentz@gmail.com>
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

