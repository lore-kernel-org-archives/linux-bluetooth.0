Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6F2EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Jun 2023 20:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjFSUah (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Jun 2023 16:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjFSUag (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Jun 2023 16:30:36 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA089D2
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jun 2023 13:30:35 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-543d32eed7cso1544649a12.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jun 2023 13:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687206634; x=1689798634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cCaOjV86XmCjdxytEUdOthY/SkfDAI0pXNp0TJWsFZ0=;
        b=DGGoL5mHOpRmiDJ8jdtqtFalK1x7xRgjNS0/0nH95QB/qzGzwUHqn0QyuRkxCEQ3ft
         UmqxVY0Hr641d3ATXVwpexPMxxfcaG6XHxibV1x54MCoMTG2BpG4xDF0W5NzgPyMtmlK
         COrAgjq3/wFE38gPO7IW/feSm9ketZhAXAlTxM9jrGy08/VREYxl/2bzHCL7Z4x44mTR
         iCd5/GkeWBAm8FbEEZnrkSe95Mv2gbO64RgEI+uappJjQP7mFKJKK79NPkAFRtv/GeaW
         /Dbb8xNupEr7ZTWAG4SfuLPsZG6IBLutTEZjr99i4EQotoaIfIPpHgCZmCOB+HBvXrYY
         ppLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687206634; x=1689798634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCaOjV86XmCjdxytEUdOthY/SkfDAI0pXNp0TJWsFZ0=;
        b=KEit0AyZkd6MVLpgi6oPFZdTsKfuiTJuckr3lyzIulrR+cWexNnflX87EToyhNKe1C
         RBwG5iyOedQpFHodnOC0tXReoj7bIVXkH0MKsyuevzmZK/L4VPpQ5SMIzR7NDp5ySDob
         fnvDatdwk3aDem4uSviriVp0M34yFZc8bxQQGzStxi7LhKwJIRdWlg007KSIG1mOWscH
         KxWZZOa+RoBGwZOgOwFwvlznOsXZ3zRgE/yT5eyRvWxPzym/CR9gTokoTvhwwHMVo2Nt
         AJUb+o3EOxXaIEYcGROAN7X+shNGxgwhMpgrTzsQfHFJTIW2jB+d6ynLugvDw/w7+KDS
         lMcA==
X-Gm-Message-State: AC+VfDzWcGSGHDKc0Aby4qdkCK+Nqr/GtV0XB4noFsBSx6fwSxmBMPRW
        wqN9ImMYRo9lGSEJNYAIJkHbP/YhQu1UsQ==
X-Google-Smtp-Source: ACHHUZ6JmLqV0g84lgpZnAjSHSZw1G/iivor9g/PlpCBZm1uj37Yn1igw/QMmyk/5JcdCD0So5zNJw==
X-Received: by 2002:a17:902:d4c4:b0:1b5:532e:33a9 with SMTP id o4-20020a170902d4c400b001b5532e33a9mr6496457plg.12.1687206634305;
        Mon, 19 Jun 2023 13:30:34 -0700 (PDT)
Received: from lvondent-mobl3.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id ju18-20020a170903429200b001b045c9ababsm202714plb.264.2023.06.19.13.30.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 13:30:33 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] shared/bap: Add unespecified bit in audio context to PAC records
Date:   Mon, 19 Jun 2023 13:30:28 -0700
Message-Id: <20230619203032.6812-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes sure unespecified bit is properly marked in both audio
contexts since that required by many platforms in order to work properly
and while doing that add proper defines to the defaults values used in
PACS.
---
 src/shared/bap.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 4b31536ee..270f0fd64 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -47,6 +47,14 @@
 
 #define BAP_PROCESS_TIMEOUT 10
 
+#define PACS_SRC_LOCATION 0x00000001
+#define PACS_SNK_LOCATION 0x00000003
+
+#define PACS_SRC_CTXT 0x000f
+#define PACS_SUPPORTED_SRC_CTXT PACS_SRC_CTXT
+#define PACS_SNK_CTXT 0x0fff
+#define PACS_SUPPORTED_SNK_CTXT PACS_SNK_CTXT
+
 struct bt_bap_pac_changed {
 	unsigned int id;
 	bt_bap_pac_func_t added;
@@ -467,12 +475,12 @@ static struct bt_pacs *pacs_new(struct gatt_db *db)
 	pacs = new0(struct bt_pacs, 1);
 
 	/* Set default values */
-	pacs->sink_loc_value = 0x00000003;
-	pacs->source_loc_value = 0x00000001;
-	pacs->sink_context_value = 0x0fff;
-	pacs->source_context_value = 0x000e;
-	pacs->supported_sink_context_value = 0x0fff;
-	pacs->supported_source_context_value = 0x000e;
+	pacs->sink_loc_value = PACS_SNK_LOCATION;
+	pacs->source_loc_value = PACS_SRC_LOCATION;
+	pacs->sink_context_value = PACS_SNK_CTXT;
+	pacs->source_context_value = PACS_SRC_CTXT;
+	pacs->supported_sink_context_value = PACS_SUPPORTED_SNK_CTXT;
+	pacs->supported_source_context_value = PACS_SUPPORTED_SRC_CTXT;
 
 	/* Populate DB with PACS attributes */
 	bt_uuid16_create(&uuid, PACS_UUID);
-- 
2.40.1

