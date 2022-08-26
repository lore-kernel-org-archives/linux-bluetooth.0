Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC22C0502A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Aug 2022 23:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345510AbiHZXUu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 19:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345502AbiHZXUp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 19:20:45 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46787BB002
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 16:20:43 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id e19so2916328pju.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 16:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=LtLsDeU6W0S2tsIhTDpRd9Huw05LEotatD+3ogiUrJQ=;
        b=cMB6REfH7JLYAlPC/8lWPdxM/nu0xWrT11nnFPa7xA4is4GCJbeJGf0FN1e+k0ljbp
         /zc8uBsBs8pnvu8JVX/dnPNTZ19heQnMPthR2/oRmlDVm756q1Pjy6fwYnsnxL6ZNm5a
         +TfFljVMP5KnmS9ly+tSyVBQsUSU5rPOdyXqpboOg4UEw1+COgAKAtNAc/v9H3z8Ny+O
         y1PW4UxTY0Rwle0xc7TYZ6gd1WN0SF9JgManBunia40Z0LeuK31vh/xqCSDVl2GJ1OuY
         0wkkbl9bfs25EM1h52jSxagXafyTUrDVrtaOLa4Lx4rnI9KlPhjkjho53rsZBbUo5hhV
         Z9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=LtLsDeU6W0S2tsIhTDpRd9Huw05LEotatD+3ogiUrJQ=;
        b=Q3oJykV8lMnPqhy2HH8NlSsKAYXaZ5epDrXbP50BnUkLqM3uS6D7WViiMPUQNrypzH
         USRrEMyKy5MzZIBxAqOZgyWZ3iYSNB6BgBw5AVWkzMBDYb3MSw+eJ9ofLTeqVeYnlrX8
         +molFa23tYZh1uayd/1NpLx34htU8swGZ8BLHfl78DQIW3Tt4WrGf1w90BVIrC+rzewz
         NSLsnt7ZKZ0A3M4pMyIthDebjz78sZZIYOR6dPenbfzcMgpXGoXROJIFx8/R7Msm9JZL
         vlYtcxZ3benG/h8LbLz0mLmaTAzhrYEhxJUSPsw5L08iZCRSCg9uwQMQumwtIL2ikWHU
         MBXQ==
X-Gm-Message-State: ACgBeo0stBIVkeL9dpdWWVaqNEtkKS+KLSZeUjBkVv0c35wGQ0uT1wh6
        XFsHSO2lSu73uD5OuJk2nlTjJUUvQjs=
X-Google-Smtp-Source: AA6agR4sQ8DGG2z07XEvQZUFlE2S4jB/faAI9JeWLRMPxRv51o/l3D/AQa3hELrJImhViBie4Ro3PQ==
X-Received: by 2002:a17:90b:4b42:b0:1fb:3ea7:da with SMTP id mi2-20020a17090b4b4200b001fb3ea700damr6483493pjb.138.1661556042238;
        Fri, 26 Aug 2022 16:20:42 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n15-20020aa7984f000000b0053645475a6dsm2312338pfq.66.2022.08.26.16.20.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 16:20:41 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 6/9] media-api: Add SelectProperties
Date:   Fri, 26 Aug 2022 16:20:28 -0700
Message-Id: <20220826232031.20391-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220826232031.20391-1-luiz.dentz@gmail.com>
References: <20220826232031.20391-1-luiz.dentz@gmail.com>
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

