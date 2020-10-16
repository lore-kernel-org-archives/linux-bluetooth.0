Return-Path: <SRS0=5gFq=DX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE6AC433E7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 22:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 496322065D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 22:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="OG+1REu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388868AbgJPWJj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Oct 2020 18:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388807AbgJPWJi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Oct 2020 18:09:38 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE235C061755
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2020 15:09:38 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id x13so2225818pgp.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2020 15:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=kt50QO488Fqz+enFM7SXz9VGDepJqY0UVtwdiBU2L1k=;
        b=OG+1REu9F2CjqMzMFDA0usIIPphkv/KMq7XSVabVvyMXCY/D/Wyd4kJXoH5Y7Q3nEl
         LrjKEC3TTsZcR1fL1lNsQFHYpep1QWqZsqRO84aDJiwftCfR6T3mHSCfMWOpu9IgFnWs
         10X7REqAtFMTxncqNYAOVeCpDUpwXERQGYyyBqFvD377d9R1GrsjBFkkU433ERf+hYKd
         K64KmfMHSchzUoqXz3BixSdB6WjqOFb8DmBVAEBep7aB7Di7x5Ux6kIoIfkGyqFdkU+N
         fHeoTx2mCtfzgQUMjl08uQaaOhH8TdyRZ59AM5fvzVzc79slL/QDcKEqIw+/ihEGIFLe
         mm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=kt50QO488Fqz+enFM7SXz9VGDepJqY0UVtwdiBU2L1k=;
        b=M9/MkD9Djof1fxod3qJjwikFW3jTIPKPDV8onfOf6gf0Zi0yfoAPmvqHjoNO4VJwsG
         j8sNsPHU0kbfupYLxOrqYjt8KgCTUnUpQYDotzUUs6skeNf3cbxh0Jl4Cn+1cXthEljF
         /KOYOy8PfsDQ2U4QgJGkKzic9jEunAE4tWQs3a3NsMbT8du2iherzfieQ2HGiGFXaojv
         d9EwS/3rG2zltprCi2O3GMIMOlq6XWoIjwQKbkfX+bOxcrycFs97Y98p74kRtuh1rC6e
         qBRFvzlwbEslccy5ktO7Pw5XdaTA6TH4Zz6OW1+MsfWGNVLRcat1ZxueVJ1RfWcnSH5q
         fuhQ==
X-Gm-Message-State: AOAM531DJ7stC/R7uXxiRpOn+ASf+GgO6jh4rkk5ohbbN0/bfd7gJQbO
        VFXNmST/RJfU2xS1CU0wdy094E2HyCDgsCnS
X-Google-Smtp-Source: ABdhPJxUe5rMav1Vmdvctks5OhdI0plD8xnMrtEaTcdxHFLzTRdxTJmSQDYZJTi62oT7ElClTSPPvQ==
X-Received: by 2002:a65:628f:: with SMTP id f15mr5119328pgv.168.1602886178086;
        Fri, 16 Oct 2020 15:09:38 -0700 (PDT)
Received: from [192.168.2.14] (216-19-182-159.dyn.novuscom.net. [216.19.182.159])
        by smtp.gmail.com with ESMTPSA id s20sm3463811pfu.112.2020.10.16.15.09.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 15:09:37 -0700 (PDT)
From:   Peter Mullen <omaolaip@tcd.ie>
Subject: [PATCH BlueZ 2/3] policy: Avoid using UUID if field is not set
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-ID: <b8547b16-60b8-766a-6e63-ae96bead9f0c@tcd.ie>
Date:   Fri, 16 Oct 2020 15:09:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
  plugins/policy.c | 26 ++++++++++++++------------
  1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/plugins/policy.c b/plugins/policy.c
index dac1b7a24..e156c0db2 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -635,17 +635,19 @@ static void service_cb(struct btd_service *service,
  	struct btd_profile *profile = btd_service_get_profile(service);
  	struct reconnect_data *reconnect;
  -	if (g_str_equal(profile->remote_uuid, A2DP_SINK_UUID))
-		sink_cb(service, old_state, new_state);
-	else if (g_str_equal(profile->remote_uuid, A2DP_SOURCE_UUID))
-		source_cb(service, old_state, new_state);
-	else if (g_str_equal(profile->remote_uuid, AVRCP_REMOTE_UUID))
-		controller_cb(service, old_state, new_state);
-	else if (g_str_equal(profile->remote_uuid, AVRCP_TARGET_UUID))
-		target_cb(service, old_state, new_state);
-	else if (g_str_equal(profile->remote_uuid, HFP_HS_UUID) ||
-			g_str_equal(profile->remote_uuid, HSP_HS_UUID))
-		hs_cb(service, old_state, new_state);
+	if (profile->remote_uuid) {
+		if (g_str_equal(profile->remote_uuid, A2DP_SINK_UUID))
+			sink_cb(service, old_state, new_state);
+		else if (g_str_equal(profile->remote_uuid, A2DP_SOURCE_UUID))
+			source_cb(service, old_state, new_state);
+		else if (g_str_equal(profile->remote_uuid, AVRCP_REMOTE_UUID))
+			controller_cb(service, old_state, new_state);
+		else if (g_str_equal(profile->remote_uuid, AVRCP_TARGET_UUID))
+			target_cb(service, old_state, new_state);
+		else if (g_str_equal(profile->remote_uuid, HFP_HS_UUID) ||
+				g_str_equal(profile->remote_uuid, HSP_HS_UUID))
+			hs_cb(service, old_state, new_state);
+	}
   	/*
  	 * Return if the reconnection feature is not enabled (all
@@ -687,7 +689,7 @@ static void service_cb(struct btd_service *service,
  	 * be the first profile that's connected so we might have an
  	 * entry but with the reconnect flag set to false.
  	 */
-	if (!reconnect->reconnect)
+	if (!reconnect->reconnect && profile->remote_uuid)
  		reconnect->reconnect = reconnect_match(profile->remote_uuid);
   	DBG("Added %s reconnect %u", profile->name, reconnect->reconnect);
-- 
2.28.0


