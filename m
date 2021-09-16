Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C313C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 19:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16ADF6120E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 19:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346240AbhIPTFT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Sep 2021 15:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244903AbhIPTFQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Sep 2021 15:05:16 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF90C0611A3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 11:40:23 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id e7so7043964pgk.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 11:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=G+ciozaN6airTDXHA52cs3OjEGhZxjMJunBzjqUvUfw=;
        b=lid+R7eN74W1m5mvthuVw1FzYd4O3VM+AgCYb6ISNyWdowLQ0q156rWlALV1m1yefP
         KUMNsMXJy+CTsFkkEeMddxhoOVopgza9cOZGq4bKAk3Z1SWEmtO8uVDdupEOHXziAMgr
         Rv6xCH9gTHpQbeMZ1/gfggVXoj8PGSxeQ3ioDMEhwzaT4aFBAqXiZpcmCks6xUuYzLCM
         ShBpVSdUHJN5E6cQrbSnUQ3+jGGRM1dzeAhmnTltvleTO0TbOZu3bX2CQeO9jDAq1Ybk
         2yvk5T9eQffFCLv+GpnAyrhWGmQnd8tY4of0XPoKOiBoUBqlLIPHIqtowNtekJEZgzF0
         sbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G+ciozaN6airTDXHA52cs3OjEGhZxjMJunBzjqUvUfw=;
        b=CUWdxo9NC2sc0jmJOXWUXUuzNLPVzVV4Dg9boewvWtmcCab5Yy2qmmFoSTzyXJBV2z
         pIQyRMhh+K1PsUJi1T0CXTTIYq0GYRXC0mDtFxUAhQO7/RGLD1S8mOM847cFqal1PqMx
         +BMdFHtUmK9upf7QSd+yODDDtPf7cHTFhmb8iV6IIIqaxGg+6tbkFia0RPrAIzQ4WtuQ
         jnVvlWEX13N/xJoGJDL12wCf2HHWxGAYsHXTw/LH+KzYkD3qitoMoWOHWwgcGv6q6nnf
         rnx/dtgTrul7iVm2mrWSZP7mp2RUR5uaYhFOdT0E1363CbIWfdzxqXqx40k9hMFVCfU+
         JmqA==
X-Gm-Message-State: AOAM530Z82qdaLahM9YrpXhoJhOS/0fSA4EbY8zVwF5XIA2wED0qb7a4
        26/eG+FJvXvmz61gFjagd5gQ35K5TP0=
X-Google-Smtp-Source: ABdhPJwmaClw81f+1PuSl4YKcNlOweZyp9pGPgvLvGjMF0u/BOK/yzDS4psPN9IiSeAoTv4EsKPBfQ==
X-Received: by 2002:a63:334c:: with SMTP id z73mr6346591pgz.160.1631817622940;
        Thu, 16 Sep 2021 11:40:22 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f205sm2766717pfa.92.2021.09.16.11.40.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 11:40:22 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] policy: Use btd_service_is_initiator
Date:   Thu, 16 Sep 2021 11:40:21 -0700
Message-Id: <20210916184021.83775-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210916184021.83775-1-luiz.dentz@gmail.com>
References: <20210916184021.83775-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Instead of using BTD_SERVICE_STATE_CONNECTING use
btd_service_is_initiator to determine if the service initiated the
connection and then proceed to connect other service immediately.
---
 plugins/policy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/plugins/policy.c b/plugins/policy.c
index bf93df096..051db82e1 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -279,7 +279,7 @@ static void sink_cb(struct btd_service *service, btd_service_state_t old_state,
 		/* Check if service initiate the connection then proceed
 		 * immediatelly otherwise set timer
 		 */
-		if (old_state == BTD_SERVICE_STATE_CONNECTING)
+		if (btd_service_is_initiator(service))
 			policy_connect(data, controller);
 		else if (btd_service_get_state(controller) !=
 						BTD_SERVICE_STATE_CONNECTED)
@@ -315,7 +315,7 @@ static void hs_cb(struct btd_service *service, btd_service_state_t old_state,
 		/* Check if service initiate the connection then proceed
 		 * immediately otherwise set timer
 		 */
-		if (old_state == BTD_SERVICE_STATE_CONNECTING)
+		if (btd_service_is_initiator(service))
 			policy_connect(data, sink);
 		else if (btd_service_get_state(sink) !=
 						BTD_SERVICE_STATE_CONNECTED)
@@ -430,7 +430,7 @@ static void source_cb(struct btd_service *service,
 		/* Check if service initiate the connection then proceed
 		 * immediatelly otherwise set timer
 		 */
-		if (old_state == BTD_SERVICE_STATE_CONNECTING)
+		if (btd_service_is_initiator(service))
 			policy_connect(data, target);
 		else if (btd_service_get_state(target) !=
 						BTD_SERVICE_STATE_CONNECTED)
-- 
2.31.1

