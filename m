Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B15AC77B7E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Apr 2023 18:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346487AbjD1Sqw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Apr 2023 14:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346075AbjD1Squ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Apr 2023 14:46:50 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE942128
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 11:46:45 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a686260adcso3239395ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 11:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682707604; x=1685299604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2TxEgwLhiQ41y0of/BgNY+ugH8sfqwBu6KV8WR5vgIE=;
        b=KZKya94pUZBD0K+tRAu0hsjsrWOsfSyJaYHEmzTsUGXJc+geKRbuCu0hv6vSu2rlCd
         LH3bLNiT8sjx52Ew4bphnmfMXBiTA90NFd6VUzDTB86Bp0L4/0MgJIG14OjPPy3Tcv6g
         g8wZKLeBqY6dCs5RXle8ac07lBFHJk8vKfgdIlkkn3BJoJ4oEbd8G8ekqsT966l3uiOn
         70K+gAFr7Zo4VgujLDScj46u6IaCHaKo76v/hlJJwB2L+QrzTeqALup/aOFZCUAwVSQ0
         /eY1TIY4DjSxnPTyFGZumdEKdrElt2WcIA3Ast0mOpK0x3vlV4TDJ2azdlguhC+/Ia+s
         q05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682707604; x=1685299604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2TxEgwLhiQ41y0of/BgNY+ugH8sfqwBu6KV8WR5vgIE=;
        b=TCj9x8C4YjBO2kqznGpikq6wAH29wJLZ5/5qoyoiBnQbTj0++SAr2so/fJdue4BvAT
         Ncd7wfS+zZXKWjEDJumnPtYvztWu0uPrl30FAOl5QAckRqpilvQbWWtZyqnwmonLcuuy
         P2xw6GZx63VMWj+sPJMexAy9sspv9O/mWi6ATpnD7jEnL/tDmoHo5p9xEJuzzPhkS3ng
         sKnUZYvAdJofI2XwgoIbH/knga79UQXfFXPROoxO7kuz3V4WySnSOy5gl0HPW2Qvn41n
         dOHAymexFvLsRq0X08FjhrZVCixsGltpqdcWy/LT29Bbs7w0AKMoyIUZOUc2dOOnvgiM
         K7Eg==
X-Gm-Message-State: AC+VfDxVj3NLqKZ18xJ1UBNqJa1DCALjTxoMJhgww3cxpUj+O+/yD6/J
        dFIiEIih53YHM2B0cLUzyarx1NVzEv0=
X-Google-Smtp-Source: ACHHUZ4F4TFtdZoTWMeLmlnFgTXdeAxxIlJ6f2T/VtyLU2HBB9Kw1q6ChT3Qkl5VeiBbK8zEvsXPrw==
X-Received: by 2002:a17:902:e748:b0:1a9:b637:4332 with SMTP id p8-20020a170902e74800b001a9b6374332mr7075331plf.69.1682707604104;
        Fri, 28 Apr 2023 11:46:44 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id bf9-20020a170902b90900b0019f9fd10f62sm13626366plb.70.2023.04.28.11.46.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 11:46:42 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v4 2/9] shared/bap: Fix crash detaching streams
Date:   Fri, 28 Apr 2023 11:46:33 -0700
Message-Id: <20230428184640.849066-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230428184640.849066-1-luiz.dentz@gmail.com>
References: <20230428184640.849066-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If a stream is being detached but bt_bap reference is already 0 don't
attempt to detach the stream as they would be freed anyway:

Invalid read of size 8
   at 0x19A360: bap_free (bap.c:2576)
   by 0x19A360: bt_bap_unref (bap.c:2735)
   by 0x19A360: bt_bap_unref (bap.c:2727)
   by 0x160E9A: test_teardown (test-bap.c:412)
   by 0x1A8BCA: teardown_callback (tester.c:434)
 Address 0x55e05e0 is 16 bytes inside a block of size 160 free'd
   at 0x48480E4: free (vg_replace_malloc.c:872)
   by 0x1AD5F6: queue_foreach (queue.c:207)
   by 0x19A1C5: bt_bap_detach (bap.c:3879)
   by 0x19A1C5: bt_bap_detach (bap.c:3855)
   by 0x19A33F: bap_free (bap.c:2574)
---
 src/shared/bap.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 5a12a64d292b..bc6177a5ba90 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1168,6 +1168,14 @@ static void bap_stream_set_io(void *data, void *user_data)
 	}
 }
 
+static struct bt_bap *bt_bap_ref_safe(struct bt_bap *bap)
+{
+	if (!bap || !bap->ref_count)
+		return NULL;
+
+	return bt_bap_ref(bap);
+}
+
 static void bap_stream_state_changed(struct bt_bap_stream *stream)
 {
 	struct bt_bap *bap = stream->bap;
@@ -1178,7 +1186,14 @@ static void bap_stream_state_changed(struct bt_bap_stream *stream)
 			bt_bap_stream_statestr(stream->ep->old_state),
 			bt_bap_stream_statestr(stream->ep->state));
 
-	bt_bap_ref(bap);
+	/* Check if ref_count is already 0 which means detaching is in
+	 * progress.
+	 */
+	bap = bt_bap_ref_safe(bap);
+	if (!bap) {
+		bap_stream_detach(stream);
+		return;
+	}
 
 	/* Pre notification updates */
 	switch (stream->ep->state) {
@@ -2730,14 +2745,6 @@ struct bt_bap *bt_bap_ref(struct bt_bap *bap)
 	return bap;
 }
 
-static struct bt_bap *bt_bap_ref_safe(struct bt_bap *bap)
-{
-	if (!bap || !bap->ref_count)
-		return NULL;
-
-	return bt_bap_ref(bap);
-}
-
 void bt_bap_unref(struct bt_bap *bap)
 {
 	if (!bap)
-- 
2.40.0

