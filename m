Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA52C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Nov 2022 20:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbiK2UqC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Nov 2022 15:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbiK2UqB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Nov 2022 15:46:01 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E32264AE
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Nov 2022 12:46:00 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q71so14124532pgq.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Nov 2022 12:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3I4QWhGq5+m0mrFdydgsfIx9xuQMIkAkxU6vd+76M+8=;
        b=Yjxv9jEr2dO6GmAjU4TbBNCKWyMq2D/lg9uW0+35Q6e4c5tgesC5ojjtaN2WrPdoRe
         e7X9QzXyV9fLpQmseejIUqtnSMIdo90uT873cYtjxr4NAaFxO8ak9sEBKvt7ErA+rVu3
         wKhqtMDUXYRaPQAqd4jVF+rSqmRJFFZmTjeN1s8AND2A4Or+qzsb/EZ51uhH6HLmYRsk
         8L5b+a/AKvP6jp1v1CjboxsSEGiFlhj3fF0ZYUu8WVN9ggSOtPFlzxBU8evNQY8csJho
         l60XOlJkc9vj9Y3HrX8Ax6K1nV0Dz31LJsnDvL4QrxxSv22t3veo3L+fwtu/p02g0rPc
         Ac/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3I4QWhGq5+m0mrFdydgsfIx9xuQMIkAkxU6vd+76M+8=;
        b=R2GfKRha0n2x5nfiwtFoibH17z5viwxpPs7Ales34JfWTkXGROzYdTqMyBaSqhSx92
         lCaQEU34Fr1UmVgqF3yef8OjG5SVzlQQso0YBlI3JJQknRsOY44NLtbiZSqCBiEr9Ifp
         HsQc8KMpQBqKa1regIAxrhKjvExzuNCOjN7Ocd0uKQ27ISAMx9B+DGxR6CGvTBZVNpMy
         JpFsbcpCVYiloftLNiQobDWFO+m9bgKOM6aR8JF7iAOZKiEEtfBSxa4GgnDQD/lcdTH2
         dg/vIBATin2c6q7PF6WzsFJNkgFzWMxArYx1EaxCYNOj408iiS7c3ZMTmNYVPVs3NkDa
         iSpg==
X-Gm-Message-State: ANoB5pmgpDVgz29FSnWYSK8W+rQf3K1377Q9VXa80FqbbPd4tJFAOa4C
        WXfirjRNISk+v7pJJUO9ho/LCwmxawk2Zg==
X-Google-Smtp-Source: AA0mqf5I6KYsUA5YcCIEqvA19e0FwZCDDL12VP2FH1pqVkIWvMbbFU78C8iZd5oY5EJlYacC0D2bIw==
X-Received: by 2002:a63:2251:0:b0:476:cb2a:b99b with SMTP id t17-20020a632251000000b00476cb2ab99bmr52075953pgm.436.1669754759741;
        Tue, 29 Nov 2022 12:45:59 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b001887e30b9ddsm11216214plr.257.2022.11.29.12.45.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 12:45:58 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] shared/bap: Fix initiating QoS and Enable procedures as server
Date:   Tue, 29 Nov 2022 12:45:53 -0800
Message-Id: <20221129204556.1535821-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221129204556.1535821-1-luiz.dentz@gmail.com>
References: <20221129204556.1535821-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

According to Table 3.2: ASE state machine transition these procedures
can only be initated by clients.
---
 src/shared/bap.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 7a24824a71fc..f4812a4b9f51 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4166,14 +4166,12 @@ unsigned int bt_bap_stream_qos(struct bt_bap_stream *stream,
 	struct bt_ascs_qos qos;
 	struct bt_bap_req *req;
 
-	if (!bap_stream_valid(stream))
+	/* Table 3.2: ASE state machine transition
+	 * Initiating device - client Only
+	 */
+	if (!bap_stream_valid(stream) || !stream->client)
 		return 0;
 
-	if (!stream->client) {
-		stream_qos(stream, data, NULL);
-		return 0;
-	}
-
 	memset(&qos, 0, sizeof(qos));
 
 	/* TODO: Figure out how to pass these values around */
@@ -4259,14 +4257,12 @@ unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
 {
 	int ret;
 
-	if (!bap_stream_valid(stream))
+	/* Table 3.2: ASE state machine transition
+	 * Initiating device - client Only
+	 */
+	if (!bap_stream_valid(stream) || !stream->client)
 		return 0;
 
-	if (!stream->client) {
-		stream_enable(stream, metadata, NULL);
-		return 0;
-	}
-
 	ret = bap_stream_metadata(stream, BT_ASCS_ENABLE, metadata, func,
 								user_data);
 	if (!ret || !enable_links)
-- 
2.37.3

