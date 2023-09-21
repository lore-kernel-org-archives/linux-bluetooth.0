Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5788EE7D0A1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Sep 2023 23:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjIUXrt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Sep 2023 19:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIUXrs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Sep 2023 19:47:48 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D068F
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Sep 2023 16:47:42 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bee392fe9dso917224a34.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Sep 2023 16:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695340061; x=1695944861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=O8UvCzpydCqEJ8G9A6NMOVjDAbhJMdAdjKtdbYeGZO0=;
        b=L6/+DU7cgKNTaC4Not7l/nXFhi7chEUpVDjKEPkDlLD+HyvdhF/6wzu9cL8W5VbkVv
         hRf7dOBHq82yxdm6hT0FdttVC1PDbWr/u8eRV5C59OJB0De6cHsgLOC9dra2K5ayU7XB
         DD3rtLlR0Tt4YY5pJbFvvBMGfPcTvNr8Rdslch/VP/AmMAP5ktYw+62da2XRbCJHsK30
         J/Cw05cgOdjl3rqd+bEdsl7aDka6hVY2hv5UJpGY/+C0R3qj+m25HqHF+s1qn/Hnx2xo
         tMSFh0dKHDJ12csRThKsc+QDzm3x4rkLJLrtN4ZBHJ+b+LBCYtX1TRODbW0DSKphuqwh
         /NbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695340061; x=1695944861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O8UvCzpydCqEJ8G9A6NMOVjDAbhJMdAdjKtdbYeGZO0=;
        b=FJLr08HeruH09qHpYASmV/QUgJpdK8hFZe2loXn3Q7Z/mNqcm3vo8+ZypVi/FFgITi
         6XYgPD/Ju/Wjp5NIgpMU8Ee1O/EQxwxtkiGzjg32mcnLigngpjqO8MQVYqcbFaAd8UTR
         Oyn0HUXjIMQxDUTmpZlupwMNOwxLaFlN6h8YLYCb58mDVE3hhENoAcLvm5R/GGXPulhW
         zPZD/F0t21ZtSxo338KUguP6RNG2TMFP047oxi0tymQUCICS5AQZwUdQ/aF4vLrHjX1s
         fwnnQHYyl7g6vasaNxwmHpN7LMsKxj6q6ZpMon0UobWEGj7MCywN86HsmIsQd9MfDw0+
         A0NA==
X-Gm-Message-State: AOJu0YzjG7j4hphgaTsS2l7ox/7OHGCohECbASxFzqBQDB+wWbxin5d4
        hH+yHtTCMn6cB6RR6ACSwzLj6aA+vZo=
X-Google-Smtp-Source: AGHT+IFqV3m4TopTIRdxPLxXwLa8IosMrwzApZh0C+EJGLvlM7NTDazErJqo6gCtiAnrok0o1rswSQ==
X-Received: by 2002:a05:6358:998a:b0:142:d678:f708 with SMTP id j10-20020a056358998a00b00142d678f708mr9640904rwb.19.1695340060952;
        Thu, 21 Sep 2023 16:47:40 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id d18-20020aa78692000000b00690fb385ea9sm1959824pfo.47.2023.09.21.16.47.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 16:47:39 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] media-api: Update to reflect the last code changes
Date:   Thu, 21 Sep 2023 16:47:34 -0700
Message-ID: <20230921234738.929423-1-luiz.dentz@gmail.com>
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

