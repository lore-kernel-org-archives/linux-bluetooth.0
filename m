Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17104C001DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Oct 2023 23:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjJTXHy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Oct 2023 19:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJTXHx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Oct 2023 19:07:53 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52641A8
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 16:07:50 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7a66aa8ebb7so48894739f.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 16:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697843269; x=1698448069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XWqBNAeX6A/2t7F/B2+AP6gAdJuZDGSc/q1r/hSrihM=;
        b=hZESDWyI7S8P7DylkwWad+8+ovJONlcLQTp5SiLasGFZldsy5UwFF/36B/vNSnTyQ3
         /7PKNuZTMjZ00LLQXVM80I2JzWb84bNirikFk2YTu0CXgCxFiR+fX2+DOLIaqHKoFfOz
         QPthlJkccLILjikUmDHDLdn4CPWuXo2bKSGcFsL1jodUg/Su620DzW+eMxzGKDA6am06
         0x0hDo14YoiCD/uEuFDUg2H7Tinq9ABB5yd5/JqmrliQNS2a5YSeZTCaqekIWBNNIxp5
         PFNtHXqGi91suLybFFPqrbtfQkQcL4jw4DJnfRn857hiw53HV0FCoOuNWzVuvT+0X2ye
         bYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697843269; x=1698448069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XWqBNAeX6A/2t7F/B2+AP6gAdJuZDGSc/q1r/hSrihM=;
        b=tlmumsvaPy42bQLwZcoU/D40xH5HvvQYaG0q9HrjaqVwIQCmINE6JQfI9+MHj3JRRI
         A0c7GoofsENWYCNo+ID4aeU1FI7kl5g7vu8tyVu8xd2FxNaN2fqulMaYiB5O7vnR+JSv
         Iu4TYZOYo5PbRKKpYsaAOAJ9xXJZUX38jJaNMCBOV/c73SIFctjZYE5oRgo9kt2etDcN
         jOGegUspPj6AdZBM8jrepjXU90+EKq6DeV1kReo0Atw4dPtjc5n39hugfslh2vrtqrNj
         SWjKGHjzGCknp1As53+WO9sPDZvg8dvQ019v+6eUTe7kTCA1rhCSUh6TIFaPJrSBf8+K
         O0GA==
X-Gm-Message-State: AOJu0YwwmNhW8BpHp79zlRd9t6lC86koid39tLgC/ts00+b6kZKrBv0L
        krY1GvZr8XGrTuqh5pJ7fKdbGNv6Z24rOoBNDqk=
X-Google-Smtp-Source: AGHT+IHxDFc5F3/0F4s6acLs6U5fWHJOl0gSUoPfxXzmMiX4jnDmRtxkz3xdPLUDpBFWnsvF0XjGMw==
X-Received: by 2002:a05:6602:2c52:b0:791:2194:10a3 with SMTP id x18-20020a0566022c5200b00791219410a3mr3767615iov.14.1697843269093;
        Fri, 20 Oct 2023 16:07:49 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id a2-20020a5e8e02000000b0079216d6f219sm855785ion.14.2023.10.20.16.07.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 16:07:47 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] shared/bap: Remove Locations, Support Context and Context defines
Date:   Fri, 20 Oct 2023 16:07:45 -0700
Message-ID: <20231020230746.3084772-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

These values shall come from the upper stack.
---
 src/shared/bap.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 14a62d9241eb..13bbcf7935bd 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -48,14 +48,6 @@
 
 #define BAP_PROCESS_TIMEOUT 10
 
-#define PACS_SRC_LOCATION 0x00000001
-#define PACS_SNK_LOCATION 0x00000003
-
-#define PACS_SRC_CTXT 0x000f
-#define PACS_SUPPORTED_SRC_CTXT PACS_SRC_CTXT
-#define PACS_SNK_CTXT 0x0fff
-#define PACS_SUPPORTED_SNK_CTXT PACS_SNK_CTXT
-
 struct bt_bap_pac_changed {
 	unsigned int id;
 	bt_bap_pac_func_t added;
@@ -475,13 +467,6 @@ static struct bt_pacs *pacs_new(struct gatt_db *db)
 
 	pacs = new0(struct bt_pacs, 1);
 
-	pacs->sink_loc_value = 0;
-	pacs->source_loc_value = 0;
-	pacs->sink_context_value = PACS_SNK_CTXT;
-	pacs->source_context_value = PACS_SRC_CTXT;
-	pacs->supported_sink_context_value = PACS_SUPPORTED_SNK_CTXT;
-	pacs->supported_source_context_value = PACS_SUPPORTED_SRC_CTXT;
-
 	/* Populate DB with PACS attributes */
 	bt_uuid16_create(&uuid, PACS_UUID);
 	pacs->service = gatt_db_add_service(db, &uuid, true, 19);
-- 
2.41.0

