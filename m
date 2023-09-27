Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509CFE7109E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 21:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjI0Vk0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 17:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjI0VkZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 17:40:25 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF97199
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:40:23 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-493545b4eaeso4529290e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695850821; x=1696455621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kL7JlXE38q5GALyj8tUkwo5gHHH2hpnI7lnYRbb3EXA=;
        b=Wu3MqKlVTQlvDUIGlACnFAbsddojqHS89NAy5n+leuVGupuGt5D3pe6CAc8Vzk/Bw0
         zAvjLDb8hWMhxm+s2V86MujADnmtx43B8M3HCsbn6LwdiqVuCKo3BdY0dxiU8KbdFxyF
         HfOu8L4HhDAqb0ZtdYrx2uu1p32G5B9d0t+5pc/go6kfhD0cjP9RnRVyzo+01f2gmakP
         1f1oF2hhnscuCQ6E0PhgngUDpdGRWJzduq2YEwg6CrGOw3HE+9n8Pk3HGxHX2dFHfdwj
         XMNMlt8L4wXY5i3Uhkf/uEAQlaTmFaNE7/em98P1rgm68uKgoA7Rz5TaNSk7wX2/aQYi
         /Xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695850821; x=1696455621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kL7JlXE38q5GALyj8tUkwo5gHHH2hpnI7lnYRbb3EXA=;
        b=NDeH6kDsASiSl9sqRMf4Ii0CD4h+xGV4aMyuvdIbwypCMremONAuK5hsro5kh8vR4p
         DXu04v59AlJtjhFqif5WESykEzb6ynipgH0nk04WeiAJSmmO2vrX8qlaXA19yn6yoBLx
         JQJzrouUlM6QlqUtmDkNrLgAWvyAClJ5pX5GomNO3dA5/IcDAW86IWUsTVU0IQqTu63y
         VA/R1DtJZ6vzO7UHSaY0J0HNtFJl8V+ErgI82sNVncrUd1w8Y+YVKnagk0OoB/LscthC
         RUH4TC6pUW+PTQH0pAin2PjpmofqXbYeGfcvFuDBro6jufRR40vnQh+PY912YruNP7fi
         4NzQ==
X-Gm-Message-State: AOJu0YxyBUhUPCLtAZkIn854maImw9AAM+ggkRGOikEWHHMshkmJcbT2
        sD3EbUroGdq8lApDkM9BI7/Z+6wVd3p3c4D8
X-Google-Smtp-Source: AGHT+IFq0vDGl8iv5HmaYtki/bRk7J3Ne/U3UrMm5lLJsK+mUIj5e3bR96e4hLSGilwbkxuRRwwduQ==
X-Received: by 2002:a1f:4ec6:0:b0:49a:6776:3cb0 with SMTP id c189-20020a1f4ec6000000b0049a67763cb0mr2410424vkb.9.1695850821563;
        Wed, 27 Sep 2023 14:40:21 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b00672ea40b8a9sm12546004pfe.170.2023.09.27.14.40.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 14:40:19 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 08/12] doc/MediaEndpoint: Move QoS capabilities to its own dict property
Date:   Wed, 27 Sep 2023 14:39:59 -0700
Message-ID: <20230927214003.1873224-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927214003.1873224-1-luiz.dentz@gmail.com>
References: <20230927214003.1873224-1-luiz.dentz@gmail.com>
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

