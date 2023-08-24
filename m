Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A02C27C40
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Aug 2023 21:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243028AbjHXVWc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Aug 2023 17:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243694AbjHXVWF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Aug 2023 17:22:05 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369A31FC1
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Aug 2023 14:21:57 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686be3cbea0so982204b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Aug 2023 14:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692912116; x=1693516916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=F7CAkLCjWmlXt0JI6pCukdBsLsITAIY1FAPuhF792QY=;
        b=H1h2b/naBr4ckc3t8Xt1GgSW157LhEnRalEan07Pt0qLMq6lad+TeizswBA69EaksJ
         281Osef56ba9ag6Xjqh+BAgs0/3/jF0xMxlquDwsc6Moz4+vRugn5jvrMKtLKFy+Ru02
         LG3llsV75z2kG165+PYI4rT5XbJezEOZzRA6H+jm0vRQGfy7wpUi/E60qBN2tavE5Kr+
         X9xmX24Lpc0vUdc4w8d+zkKnddCDj5lfT2H34lR4BrzpwWWg3Exhe7tr4BVFOOgAzI/p
         hJnbCAQvQt8pAE95DeEqSIHDxxnFte+tAx18eXHN/x2Vo0m44N/wtSGRjAMce+NMVitb
         /zMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692912116; x=1693516916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F7CAkLCjWmlXt0JI6pCukdBsLsITAIY1FAPuhF792QY=;
        b=AlYoUz+rAfsC1G17iuoG17QdkUw9XvY52aPqeVK/qpLT1sgr2pVLpeXL8n8yOwr5JQ
         lOfbrmmACReJyrcvcwZ48REIW5zI0G/6ZreJqPcX8aOnfyMGFnvqrdNEKsGn7wkAqSvC
         qzxjsRXiisy8qo68WT97KO7QXJJLtTv6U5Os3io0SOmnCwh2qyyJU2S1KqTOYXOXYJts
         fd/5DQBaXKshazcv9wGwoMhPWhCeIwTpMAxj//VmUM6EsT3ZKhYxMJGuj+7O5dXPEuUY
         Vc2eBsI76vMAZbxcuAXpfAD0I5PTmJqPQu8h/zahNDdo6AvJGhwf9XlXqtoZ56zm7Ae1
         duLA==
X-Gm-Message-State: AOJu0YxQ40kl4YxZYue7WCTwye8ic1kOkmcbKMEakVuG86+q9FEkuf8+
        hrjjJPKYEtZtaR91oi8Z2Gjh7mY8m/Q=
X-Google-Smtp-Source: AGHT+IEeoGG+ifKyglnYz23QM4IkcMF0pT0DBb9rsn05FsyZ54VuVoGa6uZyhjGwbCssRfkUZpbMKw==
X-Received: by 2002:a05:6a20:7da9:b0:12c:3973:800d with SMTP id v41-20020a056a207da900b0012c3973800dmr23193068pzj.6.1692912115723;
        Thu, 24 Aug 2023 14:21:55 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id t19-20020a63b253000000b005658d3a46d7sm63568pgo.84.2023.08.24.14.21.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 14:21:54 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ RFC] media-api: Make QoS a single property
Date:   Thu, 24 Aug 2023 14:21:53 -0700
Message-ID: <20230824212153.11050-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves QoS related propertis to a single dictionary.
---
 doc/media-api.txt | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index 3a0ec38e244d..9f2482e73ac1 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -816,42 +816,40 @@ Properties	object Device [readonly]
 			Linked transport objects which the transport is
 			associated with.
 
-		byte CIG [ISO only, optional, experimental]
+		dict QoS [ISO only, optional, experimental]
 
-			Indicates configured QoS CIG.
 			Only present when QoS is configured.
 
-		byte CIS [ISO only, optional, experimental]
+			Possible values for Unicast:
 
-			Indicates configured QoS CIS.
-			Only present when QoS is configured.
+			byte CIG
 
-		uint32 Interval [ISO only, optional, experimental]
+				Indicates configured QoS CIG.
 
-			Indicates configured QoS interval.
-			Only present when QoS is configured.
+			byte CIS
 
-		boolean Framing [ISO only, optional, experimental]
+				Only present when QoS is configured.
 
-			Indicates configured QoS framing.
-			Only present when QoS is configured.
+			uint32 Interval
 
-		byte PHY [ISO only, optional, experimental]
+				Indicates configured QoS interval.
 
-			Indicates configured QoS PHY.
-			Only present when QoS is configured.
+			boolean Framing
 
-		uint16 SDU [ISO only, optional, experimental]
+				Indicates configured QoS framing.
 
-			Indicates configured QoS SDU.
-			Only present when QoS is configured.
+			byte PHY
 
-		byte Retransmissions [ISO only, optional, experimental]
+				Indicates configured QoS PHY.
 
-			Indicates configured QoS retransmissions.
-			Only present when QoS is configured.
+			uint16 SDU
 
-		uint16 Latency [ISO only, optional, experimental]
+				Indicates configured QoS SDU.
 
-			Indicates configured QoS latency.
-			Only present when QoS is configured.
+			byte Retransmissions
+
+				Indicates configured QoS retransmissions.
+
+			uint16 Latency
+
+				Indicates configured QoS latency.
-- 
2.41.0

