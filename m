Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F27ECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Aug 2022 00:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344959AbiH0AFy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 20:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241925AbiH0AFw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 20:05:52 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B5FE42FA
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 17:05:51 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id v23so2874542plo.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 17:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=LtLsDeU6W0S2tsIhTDpRd9Huw05LEotatD+3ogiUrJQ=;
        b=VGILEG4cZAI/7cdDCdUdSaz4jk+kvfvGlitmYfsK8O1e2FW05tF5Y1pizy3X221Ja5
         q9iwhqwl+XDYv8Ajlw6b/m0DF1KoKJ0KOeJg78JM8TkwEFytZ2mYNxJw1G5JXosaTA6E
         viEPRYPUzVWuIFD4Fh/Dl6klY7WefXbwQVPC9x/myLMO5/vFn5v/N7XzVMuG3ZJrpVAv
         0Mkd3DS8YBRDZchuYk/NkjaCOvBzy7Al5KKQwLZ+84UbRMAB1/+8SrsuRwIzU5pRKnrs
         Mi5DhwnrYWinCik+cMvayVt84CaFrquHV9kK/hub9WTC7sqcuGdgckTS0l9owUhMgTt/
         6Seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=LtLsDeU6W0S2tsIhTDpRd9Huw05LEotatD+3ogiUrJQ=;
        b=Aw2Xyl/xFqbvZH6q3p5gqe3/Wxg8K6qqDZGdywHy6Lg8HCpy2mXdAeNAKFUh9GzWHB
         pM5Ywah6LI0Cp9nLpfzrwD1R2J8tsASy5b0OmEfgLhDAj5diZuh9zPmP2YIoJaaGTA5L
         Iz7esTu/KTwiLQij/KCDC8+D2ob9hKEJ7YjDjNk8C6/RwPUoSsEmFo0TouxZM/Ed6fVg
         A0PJW8jKQaoUBFRJ3tH/9K96K5VrBpwxLb8KGBYnsKg5G4UPgcqupRVrUX2s4b6kZdjL
         OxY8WvPd6/GoP+TRnbaw3fsXWsoUcZVhOGBOE7BRNgk846xD/CdBZJvHZHmFKbzrV8lz
         tM7g==
X-Gm-Message-State: ACgBeo01qfSME1npjLqCZAdzprmEi8VGxvsEc9ney10FmQ6+SS5Wfji/
        qK4ljl72hHeAXQRjAZ6b+IMKQyEerNw=
X-Google-Smtp-Source: AA6agR7t8KQej81PXmEsrjNOHd0pVLUNqi0YUQ0mEZTvBgXoH+YsuPiI4ghEESZS7GSxEbRCq/YZ/Q==
X-Received: by 2002:a17:90b:3d91:b0:1fb:49ed:a5c3 with SMTP id pq17-20020a17090b3d9100b001fb49eda5c3mr6727607pjb.187.1661558751038;
        Fri, 26 Aug 2022 17:05:51 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o1-20020a17090a168100b001fa8b909ef0sm2249487pja.7.2022.08.26.17.05.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 17:05:50 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 06/11] media-api: Add SelectProperties
Date:   Fri, 26 Aug 2022 17:05:35 -0700
Message-Id: <20220827000540.113414-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827000540.113414-1-luiz.dentz@gmail.com>
References: <20220827000540.113414-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds SelectProperties which is a more extensible version of
SelectCapability since it takes a dictionary rather than a byte array
and define new Properties for LE Audio.
---
 doc/media-api.txt | 88 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 1 deletion(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index e98573157c60..9cd211355860 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -24,6 +24,9 @@ Methods		void RegisterEndpoint(object endpoint, dict properties)
 					UUID of the profile which the endpoint
 					is for.
 
+					UUID must be in the list of
+					SupportedUUIDS.
+
 				byte Codec:
 
 					Assigned number of codec that the
@@ -87,6 +90,12 @@ Methods		void RegisterEndpoint(object endpoint, dict properties)
 
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.DoesNotExist
+
+Properties	array{string} SupportedUUIDs [readonly]:
+
+			List of 128-bit UUIDs that represents the supported
+			Endpoint registration.
+
 Media Control hierarchy
 =======================
 
@@ -564,7 +573,18 @@ Methods		void SetConfiguration(object transport, dict properties)
 			endpoint oject which will be configured and the
 			properties must contain the following properties:
 
-				array{byte} Capabilities
+				array{byte} Capabilities [Mandatory]
+				array{byte} Metadata [ISO only]
+				byte CIG [ISO only]
+				byte CIS [ISO only]
+				uint32 Interval [ISO only]
+				bool Framing [ISO only]
+				string PHY [ISO only]
+				uint16 SDU [ISO only]
+				byte Retransmissions [ISO only]
+				uint16 Latency [ISO only]
+				uint32 Delay [ISO only]
+				uint8 TargetLatency [ISO Latency]
 
 		array{byte} SelectConfiguration(array{byte} capabilities)
 
@@ -578,6 +598,19 @@ Methods		void SetConfiguration(object transport, dict properties)
 			configuration since on success the configuration is
 			send back as parameter of SetConfiguration.
 
+		dict SelectProperties(dict properties)
+
+			Select preferable properties from the supported
+			properties. Refer to SetConfiguration for the list of
+			possible properties.
+
+			Returns propeties which can be used to setup
+			a transport.
+
+			Note: There is no need to cache the selected
+			properties since on success the configuration is
+			send back as parameter of SetConfiguration.
+
 		void ClearConfiguration(object transport)
 
 			Clear transport configuration.
@@ -613,6 +646,46 @@ Properties	string UUID [readonly, optional]:
 
 			Indicates if endpoint supports Delay Reporting.
 
+		byte Framing [ISO only]
+
+			Indicates endpoint support framing.
+
+		byte PHY [ISO only]
+
+			Indicates endpoint supported PHY.
+
+		uint16_t MaximumLatency [ISO only]
+
+			Indicates endpoint maximum latency.
+
+		uint32_t MinimumDelay [ISO only]
+
+			Indicates endpoint minimum presentation delay.
+
+		uint32_t MaximumDelay [ISO only]
+
+			Indicates endpoint maximum presentation delay.
+
+		uint32_t PreferredMinimumDelay [ISO only]
+
+			Indicates endpoint preferred minimum presentation delay.
+
+		uint32_t PreferredMinimumDelay [ISO only]
+
+			Indicates endpoint preferred minimum presentation delay.
+
+		uint32 Location [ISO only]
+
+			Indicates endpoint supported locations.
+
+		uint16 SupportedContext [ISO only]
+
+			Indicates endpoint supported audio context.
+
+		uint16 Context [ISO only]
+
+			Indicates endpoint available audio context.
+
 MediaTransport1 hierarchy
 =========================
 
@@ -689,3 +762,16 @@ Properties	object Device [readonly]
 
 			Endpoint object which the transport is associated
 			with.
+
+		uint32 Location [readonly, ISO only, experimental]
+
+			Indicates transport Audio Location.
+
+		array{byte} Metadata [ISO Only, experimental]
+
+			Indicates transport Metadata.
+
+		array{object} Links [readonly, optional, ISO only, experimental]
+
+			Linked transport objects which the transport is
+			associated with.
-- 
2.37.2

