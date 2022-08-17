Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2B5C2BB41
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Aug 2022 23:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242494AbiHQXmG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Aug 2022 19:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242487AbiHQXmD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Aug 2022 19:42:03 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94958883D5
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Aug 2022 16:42:00 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id j17so43815qtp.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Aug 2022 16:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=LtLsDeU6W0S2tsIhTDpRd9Huw05LEotatD+3ogiUrJQ=;
        b=F5SjWOetbrUhIKHzeTFp3QR8Cn9aWg5wV9xSSkEZwYGVq++S5xiBIFahZQXzKr0dMd
         iLDkaalyooQpaz9xkhLRr+as+32/tVHJtqu5sebo1cABfYWavB1zbrXZFCfHU5aKYWqv
         /Qb5urrAKnHxDsC5zAwEA4+wr34cYk/OwX6ZOtP/1STcObFbhACuFwg1GxyjjZeC0wN1
         M6B8YBza7edGa57lrbfPfSb1CY4aYkI9/w6V3L5N3P+wihh3OTp4p4vgNuuM4v+45plA
         W3GHb3GFUYrsDlB00AC2e9zdvmT3QaMyyrKD9xTKvYMdjQ4r5oDDztUuohjccLjdVsp0
         +Nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=LtLsDeU6W0S2tsIhTDpRd9Huw05LEotatD+3ogiUrJQ=;
        b=lcpwIBgNiejokohPMXHZ1FZBSdE8nEH1ogQ5D9yCkSYGK7bCtLxeeCHhOe5sNUMIzT
         VGcI0aQUOwJzEeExgt+6n9cWUvUAmupsywSgdoZSzkaosebLkQ+ouvtLTcDuFWxmqjk6
         G/w0yPqy5hBkIKeRB/AijdVMxps/JVi/9YgkCICKctRGY823doaZU2O7AkAzhDGaEveL
         m1b2TTt6JQtueBgaXEsJpYIuNj7TEgD6v3ryHjZpEEcvplwF00U6/RKvRwbYwVV0DSmG
         CWah+dBbAY4AiSJS2UKSRJTGRrKFBE69nnJuyHG+zCLO8PUqUeJTqv6tuwaoOkKfPzPe
         qwqg==
X-Gm-Message-State: ACgBeo122+R5DsOqM/7mDR6OUTQuZezekurSIxzErZuVPkTPSJ+DliI0
        KaVdNePhIdJokCrRgG4Xowd0gMtnWkQ5f+9+
X-Google-Smtp-Source: AA6agR4+Km8OY/WO93CjxVY0v35pkpVGGCUNeL+kXptvwNQxkcviWO/BCTZGIPgPfiyy7t9vdTizfA==
X-Received: by 2002:a05:622a:104f:b0:344:5130:409a with SMTP id f15-20020a05622a104f00b003445130409amr560885qte.547.1660779719263;
        Wed, 17 Aug 2022 16:41:59 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r25-20020ae9d619000000b006bb2f555ba4sm189637qkk.41.2022.08.17.16.41.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 16:41:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/9] media-api: Add SelectProperties
Date:   Wed, 17 Aug 2022 16:41:43 -0700
Message-Id: <20220817234146.224081-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220817234146.224081-1-luiz.dentz@gmail.com>
References: <20220817234146.224081-1-luiz.dentz@gmail.com>
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

