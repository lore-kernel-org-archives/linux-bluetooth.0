Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADA2C27C40
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Aug 2023 05:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239498AbjHXFBF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Aug 2023 01:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239626AbjHXFAu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Aug 2023 01:00:50 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC69110F4
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 22:00:48 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c06f6f98c0so30480845ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 22:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692853247; x=1693458047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=trvNCY00mlRsada941c5rpamIzxZd6X4UrrJy1/Wefw=;
        b=DHMSNB2iJY/bDF5hjK6o9PJszyAYYevyvrtELvyvpIqQMUOm9TsNCIaek7txC7pbKs
         0fYy5sSqRQFbizX2wq0xXfqvuIYh+yZp15JZFGs0Z8F4NNo/rebaBXOs8Kvek2yDtTww
         d1068VqOIXq3Az/cgpwA22xZlvWvbqfeVRDLuqs+jZcCG/9Pa29wdU0XdRXn2n5+Tj5q
         sPlvgtB6fkvh4RoZ8MCTcERfsp7PLV6Lr0B3t9vCVWLYHNSQ6NRNciO7uZrlFmxOahU1
         C8FmHNAO0muVv2jstkE4Q7v+2s9YIeaRPNMaKZF/f1A6xKl5y532qJkw3Wfi1a9ZIux0
         Rmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692853247; x=1693458047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=trvNCY00mlRsada941c5rpamIzxZd6X4UrrJy1/Wefw=;
        b=XxEONCyzJUNPq/Xmlvr40wanhpcNI33XCCdYGyF+j6A1G32fuDAHWD0LzStwtRcIyM
         9LucW8nGUiYPWFFYDJ9L+4wFPld2cclq8CEL4NbMzS+Pn5AauzBk/EmEG1In0aQ4M5Ih
         B3Bpn0Y8cc2+U7+1R77Up9LlpSbL/fm6binaDFReQTEdnnDEmjAMjPQkhEq25NOZ1ITp
         RomCTOCm/RoHcGUZYzaAd0kTGKvW6Z7A1P/XgyNClMjILPtOir0ySAoapOihmPNAZCch
         EamuWxHK1S17T2Gk5NDY9+VZejBK7usnuFpRj6EwCWxg0jXS/4/Z6RzbpadNmS1iizJJ
         9+2g==
X-Gm-Message-State: AOJu0YzC1GcZAG/mC2OeanUUygfvERAkW58ynFZQG+hdd9lDN54e3GHx
        ODMpvn4n3RTxKiwAXywE7iUJYxsumVk=
X-Google-Smtp-Source: AGHT+IFHjiW2gcoeuEmHtsonQ44TUjDu2oW/9yCeFl6VnBrJZ8boUgyQ8KbC50FBy+3irjUcbXff8w==
X-Received: by 2002:a17:902:d2c4:b0:1bf:2893:fe69 with SMTP id n4-20020a170902d2c400b001bf2893fe69mr18442062plc.14.1692853247398;
        Wed, 23 Aug 2023 22:00:47 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id y13-20020a1709027c8d00b001bdbe6c86a9sm11749423pll.225.2023.08.23.22.00.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 22:00:46 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] transport: Fix crash with broadcast properties
Date:   Wed, 23 Aug 2023 22:00:45 -0700
Message-ID: <20230824050045.4019298-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When connecting a BAP unicast stream the followin crash can be observed:

Access not within mapped region at address 0x1D4C0000000A
  at 0x14F759: get_bcode (transport.c:1121)
  by 0x1E02E4: append_property.isra.0 (object.c:498)
  by 0x1E03B9: append_properties (object.c:527)
  by 0x1E2AAB: g_dbus_get_properties (object.c:1811)
  by 0x14B9B6: pac_config (media.c:1130)
---
 profiles/audio/transport.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index f7a29ca83c2d..dd923b03ed9d 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1199,7 +1199,7 @@ static gboolean get_timeout(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static const GDBusPropertyTable bap_properties[] = {
+static const GDBusPropertyTable bap_ucast_properties[] = {
 	{ "Device", "o", get_device },
 	{ "UUID", "s", get_uuid },
 	{ "Codec", "y", get_codec },
@@ -1218,6 +1218,16 @@ static const GDBusPropertyTable bap_properties[] = {
 	{ "Location", "u", get_location },
 	{ "Metadata", "ay", get_metadata },
 	{ "Links", "ao", get_links, NULL, links_exists },
+	{ }
+};
+
+
+static const GDBusPropertyTable bap_bcast_properties[] = {
+	{ "Device", "o", get_device },
+	{ "UUID", "s", get_uuid },
+	{ "Codec", "y", get_codec },
+	{ "Configuration", "ay", get_configuration },
+	{ "State", "s", get_state },
 	{ "BIG", "y", get_big, NULL, qos_exists },
 	{ "BIS", "y", get_bis, NULL, qos_exists },
 	{ "SyncInterval", "y", get_sync_interval, NULL, qos_exists },
@@ -1229,6 +1239,9 @@ static const GDBusPropertyTable bap_properties[] = {
 	{ "SyncCteType", "y", get_sync_cte_type, NULL, qos_exists },
 	{ "MSE", "y", get_mse, NULL, qos_exists },
 	{ "Timeout", "q", get_timeout, NULL, qos_exists },
+	{ "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
+	{ "Location", "u", get_location },
+	{ "Metadata", "ay", get_metadata },
 	{ }
 };
 
@@ -1876,12 +1889,15 @@ struct media_transport *media_transport_create(struct btd_device *device,
 			goto fail;
 		properties = a2dp_properties;
 	} else if (!strcasecmp(uuid, PAC_SINK_UUID) ||
-				!strcasecmp(uuid, PAC_SOURCE_UUID) ||
-				!strcasecmp(uuid, BCAA_SERVICE_UUID) ||
+				!strcasecmp(uuid, PAC_SOURCE_UUID)) {
+		if (media_transport_init_bap(transport, stream) < 0)
+			goto fail;
+		properties = bap_ucast_properties;
+	} else if (!strcasecmp(uuid, BCAA_SERVICE_UUID) ||
 				!strcasecmp(uuid, BAA_SERVICE_UUID)) {
 		if (media_transport_init_bap(transport, stream) < 0)
 			goto fail;
-		properties = bap_properties;
+		properties = bap_bcast_properties;
 	} else
 		goto fail;
 
-- 
2.41.0

