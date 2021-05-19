Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9026FC433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 20:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BFD760FF1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 20:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhESUnQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 May 2021 16:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhESUnO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 May 2021 16:43:14 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE439C06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 13:41:53 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso3440320pjq.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 13:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OhACvNdBs+n93vVxnoMvlbygCpGd8kwb+fVpcr9DEUg=;
        b=BghNe+CMCYfU99Jp/bWyMTSAO9JCJUUtbjLYcHlOEaDYOpGwAukNzXRuhz9beXsHlo
         WKr1djDkqrMatFC8bVwIW4BPUqQhhBF78s4t+27jLcibtIV3+R1txOIBc21s0ho01eLa
         9Ifqyn3PRCbnxVbk4LtxOUQPxtw+DOyuLcSwh6xV8lXzABkGRIgppQLKI6FWBNmxbAFb
         0sZAXpg0F4e1Zw3gwvVvihM59YhG6rqxm2iMs77rtzZWtUs0aKVwnlXeP8YnPeXjL48r
         eey4ecuznmFPFBB0G5MkFauytXjRfLiQ//sm0jPED5sW6tKQRQoEodUUE4Uhav1W+fDO
         +sRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OhACvNdBs+n93vVxnoMvlbygCpGd8kwb+fVpcr9DEUg=;
        b=oJoFLyvS+gLP3/LPfD9XvajRYIPvBToNSa5W9Xx7gHEpGt6ZyQrNxxLBm8Iq7beRtN
         XxPDou60XfAErzAxu4NbhzSfUC6piBo+pszOpAyAOku/2kjUyGDm7rNrKuaqFZ6Au9/k
         b/Z1WvC1/Y7BlkIvyw+DWo8OrYcC02zTGZHCe4G5YmguWTc4sCHmDay+Jz4S5IVIEGFB
         g6wnKNdoZe3VtuVRPqgwgKproXs6iUY9P+kDjXjywwKM5/5rx5HacAHfazl/1gAjx0Km
         q99c9kpfAUTl+HJnznfCPrG5Nyv3YRCBRSfWCc6skeDYTkUpkQanaULJJhS65V93PH/0
         pDBA==
X-Gm-Message-State: AOAM533gsRjig0MvKf6PdmXiUBdHx+RNQgTGpQTv3jq12XVPy/FKfQ8G
        Ixcrq/fnnusDgu/yqbJdwHTov4dF1Bw=
X-Google-Smtp-Source: ABdhPJxg21Jh27qXYn7TyfOb2Y3zV+Z6BG+tmD2ggx2IEyZwgsrTWHx5RArXOKz5lAp8zsaI5J6okg==
X-Received: by 2002:a17:902:dccc:b029:f1:c207:b10b with SMTP id t12-20020a170902dcccb02900f1c207b10bmr1585569pll.41.1621456913008;
        Wed, 19 May 2021 13:41:53 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x184sm219726pgb.36.2021.05.19.13.41.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 13:41:52 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: L2CAP: Fix invalid access if ECRED Reconfigure fails
Date:   Wed, 19 May 2021 13:41:50 -0700
Message-Id: <20210519204151.1087613-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The use of l2cap_chan_del is not safe under a loop using
list_for_each_entry.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7d975cf98c20..f3b70fa348ab 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6248,7 +6248,7 @@ static inline int l2cap_ecred_reconf_rsp(struct l2cap_conn *conn,
 					 struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 					 u8 *data)
 {
-	struct l2cap_chan *chan;
+	struct l2cap_chan *chan, *tmp;
 	struct l2cap_ecred_conn_rsp *rsp = (void *) data;
 	u16 result;
 
@@ -6262,7 +6262,7 @@ static inline int l2cap_ecred_reconf_rsp(struct l2cap_conn *conn,
 	if (!result)
 		return 0;
 
-	list_for_each_entry(chan, &conn->chan_l, list) {
+	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
 		if (chan->ident != cmd->ident)
 			continue;
 
-- 
2.31.1

