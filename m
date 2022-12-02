Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C12C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Dec 2022 00:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiLBAu5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 19:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiLBAu4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 19:50:56 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23B5BDCD4
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 16:50:55 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id f3so3125276pgc.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Dec 2022 16:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3I4QWhGq5+m0mrFdydgsfIx9xuQMIkAkxU6vd+76M+8=;
        b=XlokXcFQ/Yz9y2MzWNVZKpMrzqUV8yT5Q5EXf59gB51nuiBXzHwMQWVeXewxS6bk08
         NkZDFyvCslN7pSM4DSE3wAb1YpR3McUhYyLMgdHkN/ql/CYODuhUab0etqZu6+SFQFpK
         4EQkTENNEtU0rx7d6yFm9nVbJTGaBJVlhQgCMcOTu5K2NHEN6k0YSq0H3Rvr56t5ysGs
         3PSBo4Qxv4yNC7QbuGQxalaaCm9lXyVzkbLZ07u6+WFHy34QknE475DQ2mwdwitUa55P
         +VW+V0czRKg8Rh54W4YtD2/c+MjFkaoXEBLvMrjd3ppcOj54INpTaczuyus6cJ87cu/H
         FZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3I4QWhGq5+m0mrFdydgsfIx9xuQMIkAkxU6vd+76M+8=;
        b=LpngKEHq9iB9SWuR9aJbKiN9/YE+/HOArTKcejlK4+htsnPfjdADux9XS7+A1xJWTO
         Lz4/WhZnEe4j0uN5jcOOuEs3zRQId1RMwboCfQBFX/BmslwQ79MHkjNdWHTl/s0TVeTK
         ygj/Z09QcsLtNjbK7hLOgQRBj7gU0hjOinvCQr/nA+jPPEqbeonIra/zzRm53UiEyNCu
         OnjAiq2nA1f4uNtXTlFlQKP7JsHb7W6TNTppQs1QW92EqpWv3Lva4TnVqK4XirxWqCPy
         pGzA2YFtFKDgVL+J6essImo6bDyfB0a67uaW9m3a1QphwV/279YN+Ohw99zYIOOBWAlN
         Sdcw==
X-Gm-Message-State: ANoB5pmEXUy4MOwF0dXGn6iSkce+miRNhvyVffoxLGbgKSxA9bYdW1hm
        3nNwVDq9IzGOuyo/565h7ZIJ9wC2o8z3dQ==
X-Google-Smtp-Source: AA0mqf5GGe5cedKhnG226IcIQgdbF3xUa3xeE1WGJ5YdK5agK0Zk1JCSRkS9XcnKq9j1gkhw1BTeJw==
X-Received: by 2002:a63:ea17:0:b0:477:9a46:f57b with SMTP id c23-20020a63ea17000000b004779a46f57bmr43620364pgi.319.1669942254544;
        Thu, 01 Dec 2022 16:50:54 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902684e00b0018971fba556sm4246005pln.139.2022.12.01.16.50.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:50:53 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/8] shared/bap: Fix initiating QoS and Enable procedures as server
Date:   Thu,  1 Dec 2022 16:50:45 -0800
Message-Id: <20221202005051.2401504-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221202005051.2401504-1-luiz.dentz@gmail.com>
References: <20221202005051.2401504-1-luiz.dentz@gmail.com>
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

