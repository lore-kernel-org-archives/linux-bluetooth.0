Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACC1C6FA83
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Sep 2022 21:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiILVnD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Sep 2022 17:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiILVnB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Sep 2022 17:43:01 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22524C61F
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Sep 2022 14:43:00 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q9-20020a17090a178900b0020265d92ae3so13628456pja.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Sep 2022 14:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=D0gGQfO3n93NHdjjAX94lSRbxVz2oHLGRDAcUgu8gcc=;
        b=l/rqiTFOAtREJKzNd3ppVvcuoXapuFD2sWI+2Cw5oX8Bs1wmb6nQ+tjqGHdq00HvFh
         TphbZlDQKeINxqBsTYC6y3dW3y6G0wsiXSn1SdKxxEBb9IxliFUQBTB7eGMKLY8LMkMb
         Aw0szI6ik2HCMqvM4sVp7JiB5pLIQ9LK2jDLTwjUc6GvMM8JMpuRzs8A8dt3jCsjVGAc
         jHXD4zQwWLqkIsaEzeW9ag6qDGYGCeCK99fmTCidfdLXNvjhQUHzJSeh3vDyrFSYslL3
         pIkaEnroHgsmjmADvi+NRKFiSA+0hMVWWrRp/DqCORrF0kDftAOkhhh4+SlnKnxn5NAn
         1Aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=D0gGQfO3n93NHdjjAX94lSRbxVz2oHLGRDAcUgu8gcc=;
        b=Udo2wlRbJsbIo8AOcfxeehvwQkrnnokvz88WAVixTpbmDCLIQd8cV/ZT6OItI/lvhQ
         XG7w6b3PhhX2UjIlsFxQKe4EUYO0Jxmgkgc82UtElHupQ/sZX4hAAXqbzz/k35fwrdqk
         dSDNZzpPN6rENdYC/AmwvF8Sp00l5alQBWtGZJlRK7qKg9AHSTmQfuKWsj2nPOw1e5O2
         NJ+SyY3+yadBeCQeSEHTpxzFFnkV2UgM70DYrARPHb8d9uLcTpm97QvXhiZnEZ5V9Dbu
         Inf7ITI77zAWc/kelC6MRai5ZnbkZC9P/+3fqRJxo451jGPArLtcGHSF7G2PstRHrIqT
         Vpig==
X-Gm-Message-State: ACgBeo1LA9Fa7lBnAg+zx6kK1GuOq2M7rrFnzUAQie641AnC92tRY6BC
        qWYsD37YkTdrIKXSS6VqB3dDqO3hk68=
X-Google-Smtp-Source: AA6agR4tgcxenAI1MSJkf4liSzwD+SLCAEyv/8R7Dn40tzardNrjcRpe0MJihnlsd3MbwYh207dx0A==
X-Received: by 2002:a17:902:ab17:b0:177:e928:8cb2 with SMTP id ik23-20020a170902ab1700b00177e9288cb2mr24804292plb.62.1663018979669;
        Mon, 12 Sep 2022 14:42:59 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s9-20020a170902ea0900b0015e8d4eb26esm6596372plg.184.2022.09.12.14.42.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 14:42:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/bap: Fix attempting to disable stream when it is idle
Date:   Mon, 12 Sep 2022 14:42:57 -0700
Message-Id: <20220912214257.173804-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the stream is already in idle state do not attempt to disable it
again.
---
 src/shared/bap.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index c5f1134d8d8a..7b23a33474bd 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1050,13 +1050,15 @@ static void bap_stream_free(void *data)
 	free(stream);
 }
 
-static void bap_ep_detach(struct bt_bap_endpoint *ep)
+static void bap_stream_detach(struct bt_bap_stream *stream)
 {
-	struct bt_bap_stream *stream = ep->stream;
+	struct bt_bap_endpoint *ep = stream->ep;
 
-	if (!stream)
+	if (!ep)
 		return;
 
+	DBG(stream->bap, "stream %p ep %p", stream, ep);
+
 	queue_remove(stream->bap->streams, stream);
 	bap_stream_clear_cfm(stream);
 
@@ -1281,7 +1283,7 @@ static void bap_stream_state_changed(struct bt_bap_stream *stream)
 	/* Post notification updates */
 	switch (stream->ep->state) {
 	case BT_ASCS_ASE_STATE_IDLE:
-		bap_ep_detach(stream->ep);
+		bap_stream_detach(stream);
 		break;
 	case BT_ASCS_ASE_STATE_QOS:
 		break;
@@ -1838,7 +1840,8 @@ static uint8_t stream_disable(struct bt_bap_stream *stream, struct iovec *rsp)
 {
 	DBG(stream->bap, "stream %p", stream);
 
-	if (!stream || stream->ep->state == BT_BAP_STREAM_STATE_QOS)
+	if (!stream || stream->ep->state == BT_BAP_STREAM_STATE_QOS ||
+			stream->ep->state == BT_BAP_STREAM_STATE_IDLE)
 		return 0;
 
 	ascs_ase_rsp_success(rsp, stream->ep->id);
-- 
2.37.3

