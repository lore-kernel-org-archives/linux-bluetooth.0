Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9110ECD4858
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Sep 2023 19:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjIVTXq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Sep 2023 15:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjIVTXp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Sep 2023 15:23:45 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C41A3
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Sep 2023 12:23:39 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79fa5d9f3a2so28041339f.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Sep 2023 12:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695410618; x=1696015418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=O8UvCzpydCqEJ8G9A6NMOVjDAbhJMdAdjKtdbYeGZO0=;
        b=PuAHCCGS8n1/ohZ8r9w5lr0zu09TA36NaZuPahH5FUOoPBGIqQuN6OFY1Lph3IMUqC
         PhLifzb3WYBxVpAA0IqRlq44RsgKTHnWy4BI14gxJdx8LWvt9qHo074j8CdwgZFR/kIv
         TCOgUjOPeVVWYD2zJRQE6jl6waLwGcBxSfAexSpzMwiTMvh/VnB2WZU6Uz/kOhgZXIc+
         dK8cKmHYdXDFwSDYMwG/VSJK8YmR0gLxdlJ9+2SjkVMZljCjw5v0T6/7J3nu4YJeV0aG
         DTvEmkuP3HHXxXVi2ujpaqTjWYdpOQeCjw6zk6a3z7YBI5Q5oU0yQMZzR08tyZ8F3ASp
         WnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695410618; x=1696015418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O8UvCzpydCqEJ8G9A6NMOVjDAbhJMdAdjKtdbYeGZO0=;
        b=GYBXJqleqGvvMeIN5ZSzgWfvuCQXr5h+GQEG5KvxulYkeNvsmQ0vCUMI/iIIKxUnYa
         ORROsoOyZCdXWGCGboerLlEmOM4vvL5+fNNSy8kUSOqccGuP8mVHz3WilJYWTe8rl80Z
         tOiZX9BYAq0ThBtqF42gg3WAjZOq4H65SzAg2PycqKutTQ+F8v/hPwE+uXP9ebRQP0Ip
         JPd4QIfFqTlZOerg/xEW0xH8zgjqX9zFqdw8HngT1pYWhceT+bcZ+NZ6N0see3fexOh8
         pjwpwLzX7dlcA88umjX5R8EHaq1QNKDApKV6ZRs1A1cYE9kiFk5w5yhXX4GtarxJyDT6
         NbZQ==
X-Gm-Message-State: AOJu0YwGfjv4r1HCde1MVQe4Mam6+p1NNplO2owqeDVhKec9QVT2ASHK
        2XvDqsM8O50zgUhHbIZgvOmkIyq04Xc=
X-Google-Smtp-Source: AGHT+IG8X9HSUqu21ERTU4QyFMuo9oIVhR8bfwpw1tHTT5qliW1IlpWHI5rB8PQP/pQHc7NsEppstg==
X-Received: by 2002:a6b:4414:0:b0:791:acd7:233f with SMTP id r20-20020a6b4414000000b00791acd7233fmr290753ioa.15.1695410618299;
        Fri, 22 Sep 2023 12:23:38 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id s5-20020a02cc85000000b0042b6a760c31sm1211519jap.28.2023.09.22.12.23.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 12:23:37 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/6] media-api: Update to reflect the last code changes
Date:   Fri, 22 Sep 2023 12:23:30 -0700
Message-ID: <20230922192335.1060601-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reflect the last code changes adding the missing Broadcast
properties.
---
 doc/media-api.rst | 179 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 138 insertions(+), 41 deletions(-)

diff --git a/doc/media-api.rst b/doc/media-api.rst
index 34bf44e8ffbb..b37ae8f01630 100644
--- a/doc/media-api.rst
+++ b/doc/media-api.rst
@@ -710,28 +710,45 @@ void SetConfiguration(object transport, dict properties)
 	properties:
 
 	:array{byte} Capabilities [Mandatory]:
+
+		See Endpoint.Capabilities property.
+
 	:array{byte} Metadata [ISO only]:
-	:byte CIG [ISO only]:
-	:byte CIS [ISO only]:
-	:uint32 Interval [ISO only]:
-	:bool Framing [ISO only]:
-	:string PHY [ISO only]:
-	:uint16 SDU [ISO only]:
-	:byte Retransmissions [ISO only]:
-	:uint16 Latency [ISO only]:
-	:uint32 Delay [ISO only]:
-	:uint8 TargetLatency [ISO Latency]:
-	:byte BIG [ISO broadcast only]:
-	:byte BIS [ISO broadcast only]:
-	:byte SyncInterval [ISO broadcast only]:
-	:byte Encryption [ISO broadcast only]:
-	:byte Options [ISO broadcast only]:
-	:uint16 Skip [ISO broadcast only]:
-	:uint16 SyncTimeout [ISO broadcast only]:
-	:byte SyncCteType [ISO broadcast only]:
-	:byte MSE [ISO broadcast only]:
-	:uint16 Timeout [ISO broadcast only]:
-	:array{byte} BroadcastCode [ISO broadcast only]:
+
+		See Endpoint.Metadata property.
+
+	:uint32 Location [ISO only]:
+
+		See Endpoint.Location property.
+
+	:byte Framing [ISO only]:
+
+		See Endpoint.Framing property.
+
+	:byte PHY [ISO only]:
+
+		See Endpoint.PHY property.
+
+	:uint16 MaximumLatency [ISO only]:
+
+		See Endpoint.MaximumLatency property.
+
+	:uint32 MinimumDelay [ISO only]:
+
+		See Endpoint.MinimumDelay property.
+
+	:uint32 MaximumDelay [ISO only]:
+
+		See Endpoint.MaximumDelay property.
+
+	:uint32 PreferredMinimumDelay [ISO only]:
+
+		See Endpoint.PreferredMinimumDelay property.
+
+	:uint32 PreferredMaximumDelay [ISO only]:
+
+		See Endpoint.PreferredMaximumDelay property.
+
 
 array{byte} SelectConfiguration(array{byte} capabilities)
 `````````````````````````````````````````````````````````
@@ -984,33 +1001,65 @@ dict QoS [readonly, optional, ISO only, experimental]
 
 		Indicates configured CIG.
 
+		Possible values:
+
+		:0x00 - 0xef:
+
+			Valid ID range.
+
+		:0xff:
+
+			Auto allocate.
+
 	:byte CIS:
 
 		Indicates configured CIS.
 
-	:uint32 Interval:
+		Possible values:
 
-		Indicates configured ISO interval.
+		:0x00 - 0xef:
 
-	:boolean Framing:
+			Valid ID range.
+
+		:0xff:
+
+			Auto allocate.
+
+	:byte Framing:
 
 		Indicates configured framing.
 
-	:byte PHY:
+		Possible values:
 
-		Indicates configured PHY.
+		:0x00:
 
-	:uint16 SDU:
+			Unframed.
 
-		Indicates configured SDU.
+		:0x01:
 
-	:byte Retransmissions:
+			Framed.
 
-		Indicates configured retransmissions.
+	:uint32 PresentationDelay:
 
-	:uint16 Latency:
+		Indicates configured transport presentation delay (us).
 
-		Indicates configured transport latency.
+	:byte TargetLatency:
+
+		Indicates the requested target latency.
+
+		Possible values:
+
+		:0x01:
+
+			Low Latency.
+
+		:0x02:
+
+			Balanced Latency/Reliability.
+
+		:0x03:
+
+			High Reliability.
 
 	Possible values for Broadcast:
 
@@ -1022,26 +1071,74 @@ dict QoS [readonly, optional, ISO only, experimental]
 
 		Indicates configured BIS.
 
-	:uint32 SyncFactor:
+	:byte SyncFactor:
 
-		Indicates configured sync factor.
+		Indicates configured broadcast sync factor.
 
-	:uint32 Interval:
+	:byte Packing:
 
-		Indicates configured ISO interval.
+		Indicates configured packing.
 
-	:byte PHY:
+	:byte Framing:
 
-		Indicates configured PHY.
+		Indicates configured framing.
 
-	:uint16 SDU:
+	:byte Options:
 
-		Indicates configured maximum SDU.
+		Indicates configured broadcast options.
+
+	:uint16 Skip:
+
+		Indicates configured broadcast skip.
 
 	:byte SyncTimeout:
 
 		Indicates configured broadcast sync timeout.
 
+	:byte SyncType:
+
+		Indicates configured broadcast sync CTE type.
+
+	:byte MSE:
+
+		Indicates configured broadcast MSE.
+
+	:uint16 Timeout:
+
+		Indicates configured broadcast timeout.
+
+	Possible values for both Unicast and Broadcast:
+
+	:uint32 Interval:
+
+		Indicates configured ISO interval (us).
+
 	:uint16 Latency:
 
-		Indicates configured transport latency.
+		Indicates configured transport latency (ms).
+
+	:uint16 SDU:
+
+		Indicates configured maximum SDU.
+
+	:byte PHY:
+
+		Indicates configured PHY.
+
+		Possible values:
+
+		:bit 0:
+
+			LE 1M
+
+		:bit 1:
+
+			LE 2M
+
+		:bit 2:
+
+			LE Coded
+
+	:byte Retransmissions:
+
+		Indicates configured retransmissions.
-- 
2.41.0

