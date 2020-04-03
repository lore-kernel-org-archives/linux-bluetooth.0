Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBD7C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 15:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1B52077D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 15:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lzki3dhF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404318AbgDCPd7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:33:59 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35073 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404286AbgDCPd7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 11:33:59 -0400
Received: by mail-vs1-f66.google.com with SMTP id u11so5200054vsg.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2020 08:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hNj1HvQcoQUIk/hf7H2ea/gOxstvKpsPPqgiR8s/sQc=;
        b=lzki3dhFN1Sv4r5Bt3bj8bZDRQNeZcadwqqv2fRsotNsyrCY2rAV62CN4wa7Uk/c91
         5BUE8VVK3o5eaceMnhepKiCtwr+0Cj4zircND8GZxbR3GFMzF0DNbfKqDcFfONKQG0VT
         8oVgkewXCBnqwmvfJb5ZB+Z/IcKUtxq0Os0AI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hNj1HvQcoQUIk/hf7H2ea/gOxstvKpsPPqgiR8s/sQc=;
        b=VQxQU9hJI3eeqk5GGuwM38NDhYqRpyjyBhibg/Rhc3HwvB4XB8F+EwhRxs2qfSebvh
         IXoA7p43bnSapipIE0FeYEnKZd9yE92aP1hsqPorSHRU26odAJNYM3oWRizAOMnIRIsf
         JXVVlJwddB62KWatOQDfEu98jjH4VwPJY/H58VkAzhbywPCKtQ1oT+CsusQJgWM825vx
         eFp3iZ2T/m5SXEY1abVY7pQKiKC7edwmKwgPIAwK8acn1I25kcwK1TaraCap74WkN5xS
         UVYFIJbcimhYK1gqjtiPGQOCduOlVDbbyCrTSRD3IDIFedrLarJQEKXdnV67wFC/sDoK
         58KA==
X-Gm-Message-State: AGi0PuZVFgdE9MkrQQo3NdKvQYf6yX8tw38kfC82YtqENxb5EgsxpuET
        iru4AEwpDTIQlct08YsMhUO2+YTbMl8=
X-Google-Smtp-Source: APiQypLRtqMTtidwLjIu2lXdenf+xwDYXdIbX0RABmeUXRDbsfxtCwQZHTGVduE3rhiCfn9BHt/U2A==
X-Received: by 2002:a67:d60d:: with SMTP id n13mr7379125vsj.230.1585928038056;
        Fri, 03 Apr 2020 08:33:58 -0700 (PDT)
Received: from alain.c.googlers.com.com (57.152.190.35.bc.googleusercontent.com. [35.190.152.57])
        by smtp.gmail.com with ESMTPSA id u82sm2145510vsu.20.2020.04.03.08.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 08:33:57 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [Bluez PATCH v1 2/2] adapter:Enable wideband_speech if supported
Date:   Fri,  3 Apr 2020 15:33:32 +0000
Message-Id: <20200403153331.101846-2-alainm@chromium.org>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
In-Reply-To: <20200403153331.101846-1-alainm@chromium.org>
References: <20200403153331.101846-1-alainm@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change will enable the MGMT_SETTING_WIDEBAND_SPEECH setting and
implement the adapter property to allow higher level profile
implementations to know if the adapter supports and has the feature
enabled.

---

 src/adapter.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 972d88772..02c5f7e1c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3424,6 +3424,15 @@ static DBusMessage *connect_device(DBusConnection *conn,
 	return NULL;
 }
 
+static gboolean property_get_wideband_speech_enabled(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+
+	return property_get_mode(adapter, MGMT_SETTING_WIDEBAND_SPEECH, iter);
+}
+
 static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_ASYNC_METHOD("StartDiscovery", NULL, NULL, start_discovery) },
 	{ GDBUS_METHOD("SetDiscoveryFilter",
@@ -3459,6 +3468,7 @@ static const GDBusPropertyTable adapter_properties[] = {
 	{ "UUIDs", "as", property_get_uuids },
 	{ "Modalias", "s", property_get_modalias, NULL,
 					property_exists_modalias },
+	{ "WidebandSpeechEnabled", "b", property_get_wideband_speech_enabled },
 	{ }
 };
 
@@ -8808,6 +8818,8 @@ static void read_info_complete(uint8_t status, uint16_t length,
 			set_mode(adapter, MGMT_OP_SET_LE, 0x01);
 		if (missing_settings & MGMT_SETTING_BREDR)
 			set_mode(adapter, MGMT_OP_SET_BREDR, 0x01);
+		if (missing_settings & MGMT_SETTING_WIDEBAND_SPEECH)
+			set_mode(adapter, MGMT_OP_SET_WIDEBAND_SPEECH, 0x01);
 		break;
 	case BT_MODE_BREDR:
 		if (!(adapter->supported_settings & MGMT_SETTING_BREDR)) {
@@ -8822,6 +8834,8 @@ static void read_info_complete(uint8_t status, uint16_t length,
 			set_mode(adapter, MGMT_OP_SET_BREDR, 0x01);
 		if (adapter->current_settings & MGMT_SETTING_LE)
 			set_mode(adapter, MGMT_OP_SET_LE, 0x00);
+		if (missing_settings & MGMT_SETTING_WIDEBAND_SPEECH)
+			set_mode(adapter, MGMT_OP_SET_WIDEBAND_SPEECH, 0x01);
 		break;
 	case BT_MODE_LE:
 		if (!(adapter->supported_settings & MGMT_SETTING_LE)) {
-- 
2.26.0.292.g33ef6b2f38-goog

