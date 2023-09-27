Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32D5E82CC0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 21:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjI0VyN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 17:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjI0VyM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 17:54:12 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D43FC
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:54:11 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-352308c0799so3172215ab.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695851650; x=1696456450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kL7JlXE38q5GALyj8tUkwo5gHHH2hpnI7lnYRbb3EXA=;
        b=e3tkaCMrajVvjYtYkKY5KDriIuf7GP+Z4HUcuYE0nhplwaE5ySLMzpFNdypX95X158
         SnhvCB5x+Ym2ghVnptchGN/RmqUUZ/1rfW48OfgpKLIURH9yyXtFZivZi2ye7Y5+ABEh
         wMveLl0neVAXQCxoTvtvUSn1yVQROY+EpYy4G6rGVr4tML+3S8FRXsRIT3hvN2ewUfb4
         ElyC1CssjNdneYAuSRK5+sRNKBWPZ1Qi1sOPUgLpO68vwvDHnDT7cfMra7DvDp/9cfj9
         uYUTYMqIK8Luo9itW5/mtzlwxKHAh41QzB+TDCU/DJxssfChEB1W0+lqA4gb3I7NmBNM
         fDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695851650; x=1696456450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kL7JlXE38q5GALyj8tUkwo5gHHH2hpnI7lnYRbb3EXA=;
        b=U6tuZvZl6+7WulBWuDafwhzxisgA8cnVutwxiNELqrx8nhtfz1dpJ+5KXNpYj1Mugv
         AtaCrdLkAloxuHF3+K1l99h6zDNytDI22mfBHPkCTZN6ot8yMvgHwYobtYgFGsJezA1D
         yf6Z51bjMy4tY3iLcx1W5rtgrZVVp4KNOk7J5/XycwgrVPjkNQNEbQangj/nByYDa4rU
         Zkmx/+A3YvjzyVnPnR4NHJdLNgsqT8gy5yzyxWfsR1zb7WQ2icicwjExRK/83wE+64NG
         vfzTElVgEARR5EUSO1wjgIPia2raRx5S7lMMemzhcXPwoa6V77ZlpEdqK1ORzxTaSFjt
         pLxQ==
X-Gm-Message-State: AOJu0Yy1HzHpldHI7VlfsbPFWc485SOB1l3xn3e05Lt9i7Gt5I6GDbsT
        KZyYQd8G2Ed3vgr4dZsD4ztbNtxWQJFY/rEs
X-Google-Smtp-Source: AGHT+IGd6uAfeJ8R40y7pojpzwDL3rkZ1gQ8yxhB56U350trejibN/S9rVYOYMdRmhqUgaUn9NBXMQ==
X-Received: by 2002:a05:6e02:1b8e:b0:34d:ed17:8476 with SMTP id h14-20020a056e021b8e00b0034ded178476mr4439411ili.10.1695851650062;
        Wed, 27 Sep 2023 14:54:10 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id g15-20020a02cd0f000000b0042bbfe3dc42sm4225331jaq.173.2023.09.27.14.54.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 14:54:08 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 08/12] doc/MediaEndpoint: Move QoS capabilities to its own dict property
Date:   Wed, 27 Sep 2023 14:53:50 -0700
Message-ID: <20230927215354.1874835-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927215354.1874835-1-luiz.dentz@gmail.com>
References: <20230927215354.1874835-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves QoS capabilities to its own dict property just as it was done
for MediaTransport QoS configuration.
---
 doc/org.bluez.MediaEndpoint.rst | 172 ++++++++++++++------------------
 1 file changed, 77 insertions(+), 95 deletions(-)

diff --git a/doc/org.bluez.MediaEndpoint.rst b/doc/org.bluez.MediaEndpoint.rst
index cba8cb3edc6e..0e201ff9dc6a 100644
--- a/doc/org.bluez.MediaEndpoint.rst
+++ b/doc/org.bluez.MediaEndpoint.rst
@@ -41,57 +41,31 @@ void SetConfiguration(object transport, dict properties)
 
 		See Metadata property.
 
-	:uint32 Location [ISO only]:
+	:dict QoS [ISO only]:
 
-		See Location property.
-
-	:byte Framing [ISO only]:
-
-		See Framing property.
-
-	:byte PHY [ISO only]:
-
-		See PHY property.
-
-	:uint16 MaximumLatency [ISO only]:
-
-		See MaximumLatency property.
-
-	:uint32 MinimumDelay [ISO only]:
-
-		See MinimumDelay property.
-
-	:uint32 MaximumDelay [ISO only]:
-
-		See MaximumDelay property.
-
-	:uint32 PreferredMinimumDelay [ISO only]:
-
-		See PreferredMinimumDelay property.
-
-	:uint32 PreferredMaximumDelay [ISO only]:
-
-		See PreferredMaximumDelay property.
+		See **org.bluez.MediaTransport(5)** QoS property.
 
 array{byte} SelectConfiguration(array{byte} capabilities)
 `````````````````````````````````````````````````````````
 
 	Select preferable configuration from the supported capabilities.
 
-	Returns a configuration which can be used to setup a transport.
+	Returns a configuration which can be used to setup a transport, see
+	**org.bluez.MediaTransport(5)** for possible values.
 
 	Note: There is no need to cache the selected configuration since on
 	success the configuration is send back as parameter of SetConfiguration.
 
-dict SelectProperties(dict properties)
-``````````````````````````````````````
+dict SelectProperties(dict capabilities)
+````````````````````````````````````````
 
-	Select preferable properties from the supported properties:
+	Select configuration from the supported capabilities:
 
 	:object Endpoint [ISO only]:
 	:Refer to SetConfiguration for the list of other possible properties.:
 
-	Returns propeties which can be used to setup a transport.
+	Returns a configuration which can be used to setup a transport, see
+	**org.bluez.MediaTransport(5)** for possible values.
 
 	Note: There is no need to cache the selected properties since on
 	success the configuration is send back as parameter of SetConfiguration.
@@ -154,71 +128,79 @@ bool DelayReporting [readonly, optional]
 
 	Indicates if endpoint supports Delay Reporting.
 
-byte Framing [ISO only]
-```````````````````````
-
-	Indicates endpoint support framing.
-
-byte PHY [ISO only]
-```````````````````
-
-	Indicates endpoint supported PHY.
-
-	Possible values:
-
-	:bit 0:
-
-		LE 1M
-
-	:bit 1:
-
-		LE 2M
-
-	:bit 2:
-
-		LE Coded
-
-byte Retransmissions [ISO only]
-```````````````````````````````
-
-	Indicates endpoint preferred number of retransmissions.
-
-uint16_t MaximumLatency [ISO only]
-``````````````````````````````````
-
-	Indicates endpoint maximum latency.
-
-uint32_t MinimumDelay [ISO only]
-````````````````````````````````
-
-	Indicates endpoint minimum presentation delay.
-
-uint32_t MaximumDelay [ISO only]
-````````````````````````````````
-
-	Indicates endpoint maximum presentation delay.
-
-uint32_t PreferredMinimumDelay [ISO only]
-`````````````````````````````````````````
-
-	Indicates endpoint preferred minimum presentation delay.
-
-uint32_t PreferredMaximumDelay [ISO only]
-`````````````````````````````````````````
-
-	Indicates endpoint preferred maximum presentation delay.
-
-uint32 Location [ISO only]
-``````````````````````````
+uint32 Locations [readonly, optional, ISO only, experimental]
+`````````````````````````````````````````````````````````````
 
 	Indicates endpoint supported locations.
 
-uint16 SupportedContext [ISO only]
-``````````````````````````````````
+uint16 SupportedContext [readonly, optional, ISO only, experimental]
+````````````````````````````````````````````````````````````````````
 
 	Indicates endpoint supported audio context.
 
-uint16 Context [ISO only]
-`````````````````````````
+uint16 Context [readonly, optional, ISO only, experimental]
+```````````````````````````````````````````````````````````
 
 	Indicates endpoint available audio context.
+
+dict QoS [readonly, optional, ISO only, experimental]
+`````````````````````````````````````````````````````
+
+	Indicates QoS capabilities.
+
+	:byte Framing:
+
+		Indicates endpoint support framing.
+
+
+		Possible Values:
+
+		:0x00:
+
+			Unframed PDUs supported.
+
+		:0x01:
+
+			Unframed PDUs not supported.
+
+	:byte PHY:
+
+		Indicates endpoint preferred PHY.
+
+		Possible values:
+
+		:bit 0:
+
+			LE 1M preferred.
+
+		:bit 1:
+
+			LE 2M preferred.
+
+		:bit 2:
+
+			LE Coded preferred.
+
+	:byte Retransmissions:
+
+		Indicates endpoint preferred number of retransmissions.
+
+	:uint16 MaximumLatency:
+
+		Indicates endpoint maximum latency.
+
+	:uint32 MinimumDelay:
+
+		Indicates endpoint minimum presentation delay.
+
+	:uint32 MaximumDelay:
+
+		Indicates endpoint maximum presentation delay.
+
+	:uint32 PreferredMinimumDelay:
+
+		Indicates endpoint preferred minimum presentation delay.
+
+	:uint32 PreferredMaximumDelay:
+
+		Indicates endpoint preferred maximum presentation delay.
-- 
2.41.0

