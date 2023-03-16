Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AE8C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 01:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCPBQj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 21:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCPBQh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 21:16:37 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F633D0BF
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 18:16:32 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q23so68365pgt.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 18:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678929392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=du4Qoj4ZuF296NTy3Bf2f3Bt+6gwaSroClSCf0CVxnA=;
        b=CaY0Oof5UMwYVrw4yKake4ydg/jldDWfs5OMx7/rJgOKc/S7U9KxIiLTTNuiir2NEM
         ExulIztyul9XRTtgHGUKZgiR1DjBmsvpoNm9BtLg4EvCxR7pXKMquGr/2As+66Iwa6A+
         BJ4Pxo5FWnGGMjEi0qyDOnwiRKjNZiNfwunr3craLXIQYXGQCbI0vTZ29DjGWIb4wguU
         uGzND3SZMGkSAbVtIX29kYmvRNXy4YDV/6W/09oTAgzhOzxhgj6VvYhE1SwZjbjnE3Oy
         9i0CiZKAQfPcwCgJ1WkiEB0K5jwM5LKkB+hQZy2VtFCvztCV7Fx5P4Jj1gIfPABXhDFq
         gXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678929392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=du4Qoj4ZuF296NTy3Bf2f3Bt+6gwaSroClSCf0CVxnA=;
        b=xwyqFWx2PHCpZTmWEPSa+JfjPTu9zHza8Idhamk9WZe2t733TdBwm8OKEYDIJnjv3r
         NLq4QxLSHMdEujIy7sZfcTmjU6xZooM/i8tmYELnzXm3cauKxTCREBWpQvD2mgA0sllN
         vJU+2sTaAl/9o32kLKLuPZ7B9oi4Ca5vkmiJpwxrWjU4FWKr12j2xp4zdkaLjJAkilfv
         HurbKc5GUJyt3lTc2yErye9XhlVkBuBQVaCBsSBzK5DRPVvp4EfKB9fIgvPbnvxTn+UR
         j6BvqVuFVfHb7QaHQA9thKsY+8RltDSmIlLZikum3gtXDlg4RYxwEZnvLEdPixNQynqj
         C1bw==
X-Gm-Message-State: AO0yUKUDXPY9uHHTMtGEXFK5n8J+dGZRvxas3g5fLuTsTZ5YvdjoAMrM
        +Q+hu7dWkgDzqGsMawUKMs6aeyZqa7U=
X-Google-Smtp-Source: AK7set8aqBXEMwnEo727B76IxDzv8JM1LBQCpDofTwG/AC+aoUROrhgUt2oEmRxzEhxRSrzsVvznvg==
X-Received: by 2002:aa7:9513:0:b0:5a8:b2bf:26ac with SMTP id b19-20020aa79513000000b005a8b2bf26acmr1485301pfp.20.1678929391937;
        Wed, 15 Mar 2023 18:16:31 -0700 (PDT)
Received: from zbook.. (97-113-12-200.tukw.qwest.net. [97.113.12.200])
        by smtp.gmail.com with ESMTPSA id g3-20020a631103000000b00502ecb91940sm3914328pgl.55.2023.03.15.18.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 18:16:31 -0700 (PDT)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, brian.gix@gmail.com, inga.stotland@intel.com
Subject: [PATCH BlueZ v2 3/3] mesh: Don't send Prov Failed on non-existant links
Date:   Wed, 15 Mar 2023 18:16:27 -0700
Message-Id: <20230316011627.27322-3-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230316011627.27322-1-brian.gix@gmail.com>
References: <20230316011627.27322-1-brian.gix@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If remote device does not respond to a Prov Link Open request, then the
callbacks do not get established, and attempting to send Failure
messages on the non-existent link rersult in seg fault.
---
 mesh/remprv-server.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mesh/remprv-server.c b/mesh/remprv-server.c
index 6a9efdd47..927dbab0e 100644
--- a/mesh/remprv-server.c
+++ b/mesh/remprv-server.c
@@ -546,7 +546,7 @@ static bool remprv_srv_pkt(uint16_t src, uint16_t unicast, uint16_t app_idx,
 	bool segmented = false;
 	uint32_t opcode;
 	uint8_t msg[69];
-	uint8_t status;
+	uint8_t old_state, status;
 	uint16_t n;
 
 	if (app_idx != APP_IDX_DEV_LOCAL)
@@ -843,10 +843,12 @@ static bool remprv_srv_pkt(uint16_t src, uint16_t unicast, uint16_t app_idx,
 		if (!prov || prov->node != node || prov->client != src)
 			return true;
 
+		old_state = prov->state;
 		prov->state = PB_REMOTE_STATE_LINK_CLOSING;
 		mesh_io_send_cancel(NULL, &pkt_filter, sizeof(pkt_filter));
 		send_prov_status(prov, PB_REM_ERR_SUCCESS);
-		if (pkt[0] == 0x02) {
+		if (pkt[0] == 0x02 &&
+				old_state >= PB_REMOTE_STATE_LINK_ACTIVE) {
 			msg[0] = PROV_FAILED;
 			msg[1] = PROV_ERR_CANT_ASSIGN_ADDR;
 			if (prov->nppi_proc == RPR_ADV)
-- 
2.39.2

