Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F2EE7109E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 21:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjI0VkM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 17:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0VkL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 17:40:11 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77825D6
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:40:09 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3ae2ec1a222so5593929b6e.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695850808; x=1696455608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8UvCzpydCqEJ8G9A6NMOVjDAbhJMdAdjKtdbYeGZO0=;
        b=amDJiviAlyaxG6PFMLmtqsAytwmN8cAU+3tqB2TREzCZRnmaEfWUloGkVUW4koEspf
         nxLvOdJk7gaTMEFCoG109kk64FmpeA/tpKztbNkI+YFmUS65Bu9OfwR6neU+ONI/gr8H
         aBY0nrFVU0AAcXJhdlIulp4CAXHEZxKLNvo4Pwoun0G0xE3GtoLwuhHcYpOqAfXSg3e3
         TfYleSxuYvKjf0NWatR5gOKIQY4v4mFn5YxpX3ByRvFVGARmK4ZRE9DSa5nH8bBfJb3b
         UM5utBl6gnKIa2D58hNaEjKNM/Fu4YvcKrMx0k3SImCSFqka/Lb8HidHRMsI6Bd2oViH
         TB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695850808; x=1696455608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8UvCzpydCqEJ8G9A6NMOVjDAbhJMdAdjKtdbYeGZO0=;
        b=KwJdJFPgVWxP8FJCSM/t/FV4TzdQKW6nMzPJXZGUr4wQsUf28H9iOd9vZ4nvob0nQd
         p8x8ZfjDEAyloyh1YQFksEy9rYH7NkXg2CUVOQZyfZRxuVsxSbJmjph2az2VT7aPEcqu
         n9QqhrTQaIZ/7pgZV0dyDN9xy1XceVH4zTd+UtyReAkrnFF2PgkiO6CGz+ozaRSN52eB
         ekAMpIksgahjcTMImjDf88liqgG6swzR73X92umEvrUpryCdh82YDl66JgzVtAC5m/kX
         0yjfSgwXE7142szcYOmwOqGbn3I1RtMjoUNCTCU6QmXyzb7LUi3kppF9M22RXMWWC9PU
         hJcA==
X-Gm-Message-State: AOJu0Yx4umIAiFz6YLVDA6md0MgkUWm3xhn5UkJXCEbwacw9MQT1L0/7
        IrG44+TVa4sversrBR+7Pavfssai8N99N11f
X-Google-Smtp-Source: AGHT+IFzHV9QgmAfSL3Dt4e1dVZw1dRdGLWPvepeqdLDrSnFTRQ2jlVVSq8FISWgHrBgb0gUtFIeFg==
X-Received: by 2002:aca:1218:0:b0:3a7:6d64:aa68 with SMTP id 24-20020aca1218000000b003a76d64aa68mr3268421ois.18.1695850807962;
        Wed, 27 Sep 2023 14:40:07 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b00672ea40b8a9sm12546004pfe.170.2023.09.27.14.40.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 14:40:06 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 01/12] media-api: Update to reflect the last code changes
Date:   Wed, 27 Sep 2023 14:39:52 -0700
Message-ID: <20230927214003.1873224-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927214003.1873224-1-luiz.dentz@gmail.com>
References: <20230927214003.1873224-1-luiz.dentz@gmail.com>
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

