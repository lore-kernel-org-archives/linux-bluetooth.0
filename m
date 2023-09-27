Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7BDE7109E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 21:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjI0VyA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 17:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0Vx7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 17:53:59 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2681FB
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:53:57 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-77acb04309dso433508039f.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695851636; x=1696456436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=O8UvCzpydCqEJ8G9A6NMOVjDAbhJMdAdjKtdbYeGZO0=;
        b=VXKMNvCiMcGw/CEme4WvKu+v6dqpZbF5P7C0kAfj+CN9yuAkQgxUtXzJYYYF03FXnO
         4D4hQaOPJsWUVqtlDer3n0aNp/+nlxM2XAYVXgIwc6It3lttbH3hwhgNf9KJdgv6LNEc
         U2xg7QlQJmDoV8xYiHJkLFPAjbeYIW7DSA79okNrJl+8cb2IqbhxqH4hpq2M2pOR8xdM
         dhgOP6KcyUSr3In/IpPePNPFx0VOxUdH95CgrW5gx7eRntcJZa/3Afgwjh5eQLON2IVy
         GlEYz6PkVcr6I+scnjhwQnfz4Nci9x6cCbpCJ7afAIRygvk9xxayYZYqF29agU9MLWPP
         Idlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695851636; x=1696456436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O8UvCzpydCqEJ8G9A6NMOVjDAbhJMdAdjKtdbYeGZO0=;
        b=MljMEhHm83X/wLp/fBUgLSSvA4xevJfvzxQMiJMGaelhTRX/We9XZ4dEMTw4k00AiV
         roYLT+6vcdI0Y9cFP3nmCYNm3HEOQUx+lD/8pK9luW5FnwimTnBeVp5HRp3cJ3N/SWmI
         UoBsN134pIajECRVclx1XvgnR/36VZQ3QGp490WQFnzdvxerKZjj+wKh1CRJ7Hddqw4V
         xZNxmogTrJ7+v8dp0gTeK+KRgnnkQWHKUhI1gUELDgHwZ7p8zUrPjv6PMvnB32XBji8k
         ArlDvq2cxV0JfhTVfH5JKLXqYjA+q3wrJelSaFiR2WbdqQ0W90BCuj3F06o5N0tvu6dk
         RTkA==
X-Gm-Message-State: AOJu0YxSgQ10A+sccIrGCiDxuhfsJLVMfGsCMGxSgx9Uz7IpPyygTfu5
        OZAJbWRFFETuLMFo6X8OrZ8Anwzuxr8hfAMA
X-Google-Smtp-Source: AGHT+IG0vmsetSRWPfrxTW8JRpA+l/cjoAl5KGp6Re/AGdBHXe1TRBF0q8bxI7MC77+aI4NYibFmLA==
X-Received: by 2002:a5e:d60d:0:b0:79f:ca2f:9198 with SMTP id w13-20020a5ed60d000000b0079fca2f9198mr3731161iom.2.1695851636450;
        Wed, 27 Sep 2023 14:53:56 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id g15-20020a02cd0f000000b0042bbfe3dc42sm4225331jaq.173.2023.09.27.14.53.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 14:53:55 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 01/12] media-api: Update to reflect the last code changes
Date:   Wed, 27 Sep 2023 14:53:43 -0700
Message-ID: <20230927215354.1874835-1-luiz.dentz@gmail.com>
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

