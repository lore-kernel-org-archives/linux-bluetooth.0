Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF2AC83F11
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Aug 2023 23:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjH1XdR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Aug 2023 19:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjH1Xct (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Aug 2023 19:32:49 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB194E8
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Aug 2023 16:32:43 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79289fefdbeso100142339f.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Aug 2023 16:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693265562; x=1693870362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Poe815WILDMB0+KqUCOBswfAgZvSJpvrPH3qP52BnhI=;
        b=ei21QNxr33sA9uJM/nip4MdgF35NDEjIvWUsZVP+P/zQN243kBA+LRYRCHtHB3k+ES
         HSX4vfY1pLS3/2xKksldCnFrr5Gd2N+a9FV5TUFuVNdNOl7fo0m4Rvbe8pL2lHfXjT75
         pnQlTde7znvJEXuDGflvB4h9LkFQwV+JktAQ3prlQRvpuUTtceiDjB2FL4nwl63m7NhN
         owCzcw3TofBThfg9uMlwKglFgP9tNdBVuvvfPv1nXRgIr8a3R0ZvWTprqmH5SQUX3t7R
         KMA4DKyuhkRbM4U7OhrvdfOxnZVKUHE/Nw8Rz9BfHBejJoMvR80/aXYo2aChItmM18lm
         onWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693265562; x=1693870362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Poe815WILDMB0+KqUCOBswfAgZvSJpvrPH3qP52BnhI=;
        b=gbUtM/pKgHG10HjynUgjEpTeK6/iwQNWTKtKDtEdYYYkll8kOVlQhmMh8p+PB477oA
         CIr7y4DNkR2IROU0MdaHpBW2fdboXTtVb6L0Op14zZzJssQmU88UMeP2eK38peCluvqp
         KHSC3SQog5XxgGx6+YA5W0l5+x8ufFoMygtqYyktSH2QLN8y3f2j4OabpwfvAdgOVCBb
         icfUjEfk0YKdB8dlGK6lh9nXI4drEERXW69gh/IZuaooSUzPvHFXH87sQFG8mdDGtFlk
         BdwCNnhbgWKpfaTirtodqdjERD/lTWQAKjTCw51wuuiWsrZQyWnp4bvV1mHG1Fma51QA
         7RAw==
X-Gm-Message-State: AOJu0Yx96RtO3IFh4Vxt/nXY0jLnIKZO9KdOIGCMvLKNJKxFhDKlOgOt
        EtmIBIZN90i5mD9wprUs2+jymx2QOrU=
X-Google-Smtp-Source: AGHT+IHVvPuXAwB9GqIu0NpfPB3sIvYumvLxFrZpdKsMf32uZa5G/1q+uXIJJKj7PpjCkkBAH4rt0g==
X-Received: by 2002:a5d:8550:0:b0:783:6272:afbb with SMTP id b16-20020a5d8550000000b007836272afbbmr19979789ios.9.1693265562461;
        Mon, 28 Aug 2023 16:32:42 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id k4-20020a02ccc4000000b0042ad6abe0bbsm2819852jaq.20.2023.08.28.16.32.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 16:32:41 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] media-api: Make QoS a single property
Date:   Mon, 28 Aug 2023 16:32:39 -0700
Message-ID: <20230828233239.634106-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves QoS related properties to a single dictionary.
---
 doc/media-api.txt | 78 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 23 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index 3a0ec38e244d..cbcfac85c27b 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -816,42 +816,74 @@ Properties	object Device [readonly]
 			Linked transport objects which the transport is
 			associated with.
 
-		byte CIG [ISO only, optional, experimental]
+		dict QoS [readonly, optional, ISO only, experimental]
 
-			Indicates configured QoS CIG.
 			Only present when QoS is configured.
 
-		byte CIS [ISO only, optional, experimental]
+			Possible values for Unicast:
 
-			Indicates configured QoS CIS.
-			Only present when QoS is configured.
+			byte CIG
 
-		uint32 Interval [ISO only, optional, experimental]
+				Indicates configured CIG.
 
-			Indicates configured QoS interval.
-			Only present when QoS is configured.
+			byte CIS
 
-		boolean Framing [ISO only, optional, experimental]
+				Indicates configured CIS.
 
-			Indicates configured QoS framing.
-			Only present when QoS is configured.
+			uint32 Interval
 
-		byte PHY [ISO only, optional, experimental]
+				Indicates configured ISO interval.
 
-			Indicates configured QoS PHY.
-			Only present when QoS is configured.
+			boolean Framing
 
-		uint16 SDU [ISO only, optional, experimental]
+				Indicates configured framing.
 
-			Indicates configured QoS SDU.
-			Only present when QoS is configured.
+			byte PHY
 
-		byte Retransmissions [ISO only, optional, experimental]
+				Indicates configured PHY.
 
-			Indicates configured QoS retransmissions.
-			Only present when QoS is configured.
+			uint16 SDU
 
-		uint16 Latency [ISO only, optional, experimental]
+				Indicates configured SDU.
 
-			Indicates configured QoS latency.
-			Only present when QoS is configured.
+			byte Retransmissions
+
+				Indicates configured retransmissions.
+
+			uint16 Latency
+
+				Indicates configured transport latency.
+
+			Possible values for Broadcast:
+
+			byte BIG
+
+				Indicates configured QoS BIG.
+
+			byte BIS
+
+				Indicates configured BIS.
+
+			uint32 SyncInterval
+
+				Indicates configured broadcast sync interval.
+
+			uint32 Interval
+
+				Indicates configured ISO interval.
+
+			byte PHY
+
+				Indicates configured PHY.
+
+			uint16 SDU
+
+				Indicates configured maximum SDU.
+
+			byte SyncTimeout
+
+				Indicates configured broadcast sync timeout.
+
+			uint16 Latency
+
+				Indicates configured transport latency.
-- 
2.41.0

