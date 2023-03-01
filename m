Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE68C64EC7
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Mar 2023 01:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjCABix (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Feb 2023 20:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCABiw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Feb 2023 20:38:52 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB496EA5
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Feb 2023 17:38:51 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 16so6817756pge.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Feb 2023 17:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OA9iervL+7rtsaNKFx0KRJgwvjRozbQf+1ydxaKazE8=;
        b=bTBCewro6mHwK47123uHXTXY1dxXFRO/qZkfuiriL9Wkwze3F5zVtOqbZsvAc+VV/c
         1msdGBfp7JTuAjn48cDzsxUeDylxj+Rt/Rz4BN9zomgg9xjf5DVlgQG4esqrZMA6Mszl
         Ve4DInsaKQaTww//1yGw0X+w+mbvUtMhzvRn5pebN3RC29u8P8PQu7Im4O7E5hfpq5zp
         S2iOkNypMSNyr/0L8t69yL71O3ODTGK2mg/oT+/Olwas321zpVSBALGdWh/DdL5GVA/N
         nU5hLPt/JH14hz1h++ktGjNvkKDW0oJUGfJLmZO5G2/AIylD3K5E787do32BtiO85gF3
         O5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OA9iervL+7rtsaNKFx0KRJgwvjRozbQf+1ydxaKazE8=;
        b=6AxnY6rcF+grT/lq76ZDO9yiE6gwUujFA+73HkFmNHC3MFzubVEnbhiawXEJVKDZM3
         JT05G/wEw26V27uZVcVSLBjZSpsxFPa34RWoAeLMGPfvTdm+eK0itzqK5dUGveM4UySt
         fpGEamzb/iP8CmfTRNGYdIRtuvafsh1gNIX1fOHPyM226Ys91r7WFGNS+C6BFf5U07WC
         NJXG+BQLWNKvhSlFsFFkO7WCDceT0mnJenHHKO4SGyy5i9KJVadDPS+NQtAftrUi5XGH
         zEf4hlN55AHRculSPQHaanWbpjV3KrmKWcXvHMtPValUHMWf34wNveudAXhyELM3/7G8
         Rh1Q==
X-Gm-Message-State: AO0yUKV72r4n5L8+i+cyCY/M6ij2l7mKS5Cv7xhtEQf1fbne47BwfGvE
        OGOqHWeEE39DVpmoqPfkaq5i9AtYKP0=
X-Google-Smtp-Source: AK7set8xEotOnOtvbAMSA+DlN7ofLaNOgp16kuUKq4wYN12cRtwGtGiKytSgVYoRmThf67ixYrW8Mw==
X-Received: by 2002:a62:1bd2:0:b0:5ab:bf5d:a0d1 with SMTP id b201-20020a621bd2000000b005abbf5da0d1mr3986637pfb.7.1677634730100;
        Tue, 28 Feb 2023 17:38:50 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id c1-20020aa78801000000b005d866d184b5sm6627797pfo.46.2023.02.28.17.38.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 17:38:49 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] media: Fix not checking BREDR support for A2DP
Date:   Tue, 28 Feb 2023 17:38:42 -0800
Message-Id: <20230301013842.718438-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230301013842.718438-1-luiz.dentz@gmail.com>
References: <20230301013842.718438-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

A2DP shall depend on MGMT_SETTING_BREDR setting so the likes of
bluetoothctl -e don't attempt to register A2DP with controller that
are on LE only mode.
---
 profiles/audio/media.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 326e50a0925b..540e91bc6706 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1269,8 +1269,11 @@ static bool endpoint_properties_get(const char *uuid,
 	return true;
 }
 
-static bool endpoint_supported(struct btd_adapter *adapter)
+static bool a2dp_endpoint_supported(struct btd_adapter *adapter)
 {
+	if (!btd_adapter_has_settings(adapter, MGMT_SETTING_BREDR))
+		return false;
+
 	return true;
 }
 
@@ -1291,8 +1294,10 @@ static struct media_endpoint_init {
 	bool (*func)(struct media_endpoint *endpoint, int *err);
 	bool (*supported)(struct btd_adapter *adapter);
 } init_table[] = {
-	{ A2DP_SOURCE_UUID, endpoint_init_a2dp_source, endpoint_supported },
-	{ A2DP_SINK_UUID, endpoint_init_a2dp_sink, endpoint_supported },
+	{ A2DP_SOURCE_UUID, endpoint_init_a2dp_source,
+				a2dp_endpoint_supported },
+	{ A2DP_SINK_UUID, endpoint_init_a2dp_sink,
+				a2dp_endpoint_supported },
 	{ PAC_SINK_UUID, endpoint_init_pac_sink,
 				experimental_endpoint_supported },
 	{ PAC_SOURCE_UUID, endpoint_init_pac_source,
-- 
2.39.2

