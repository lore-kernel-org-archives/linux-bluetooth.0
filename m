Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0842C43216
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 21:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 881AD610E9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 21:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhHYVPJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Aug 2021 17:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhHYVPE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Aug 2021 17:15:04 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFEDC0613C1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Aug 2021 14:14:18 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y11so745899pfl.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Aug 2021 14:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=W/kkIUSlU8ACnmI49nXQ5yMykI7bB2fuFZ10QPX9yFM=;
        b=s2NykH3d/h4Jn07ofcTeVPBxgfM5aWrndG72HnhkOdrnsxzrGvODikQGlm2Ul0OxwF
         th3+sHpfUPfkijepiP1hubJ12LQ5Kd1sP7yf3XysXgPZlmFJltDpDKber7yJ5SefkmxS
         UFZNcYKl6bogINRJ/na2xdKLYAuBh+11jY3yua0Tu3wnou1OQrXjCq7NpcTCC0gWP6xg
         JIp+RJlPypmKv+4x76jqzqR4ij72Mi6/anK0Cy4oTYtxVpZaWWKTHGw5FXIxILS4Ge9Q
         0FAXOzUYcgTxdEaBS+u2Ni3iWSU31L0KbkDrLKvxjt1e4vpHnsU8dZ/wWzobkX6PdbHy
         LyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W/kkIUSlU8ACnmI49nXQ5yMykI7bB2fuFZ10QPX9yFM=;
        b=PQNZ6d0TRBOmfN6xCOvC1LOvtiLvs3ZZYpkyVbb6cmM1a5HtI21z6ERUiW58Y0EkwA
         V+AZbml5Vm8inSx36XtWqen3HKV69UL/oGCeiv/6y1FTag3ttkyHLFdugCkOV+GuOjD4
         xFQyq8RSvuccMEWglHOCqWt3ySr9Pbu0N6CwgvczMLkjLDbWQV5NMHY0IHPq9uVL2Y0P
         3280u1XT9ExtUNAyOZRZWhfyKwcYfB9X3jcrwWaFZZMaMjLBLhFXnt7lce9ggbl+meHU
         z3qsADMIQLZ+t7QsqoUSWmEc9ZFQevJm6OfB5TUvaJUJX3AXtvqgTaCmgxK8eRzjOUZy
         tv6w==
X-Gm-Message-State: AOAM531wEhNXpIIea0mjT1gN/zCn/FmgWs7CPMclHv5u+tcZc7rHq/Du
        ONlPoo90trU2fGmVVsQpPWaATRNG1Bw=
X-Google-Smtp-Source: ABdhPJzg2E6PJa4H1OM862oKM6sqMHqedfi2QjCyfZjHkcqh7RR5XynhiYjGgmoD0827KtNUoEwcIg==
X-Received: by 2002:aa7:956d:0:b0:3ef:2ed2:ab28 with SMTP id x13-20020aa7956d000000b003ef2ed2ab28mr414003pfq.34.1629926057304;
        Wed, 25 Aug 2021 14:14:17 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o15sm921812pgr.64.2021.08.25.14.14.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 14:14:16 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] shared/att: Fix attempting to send Exchange MTU on EATT bearer
Date:   Wed, 25 Aug 2021 14:14:14 -0700
Message-Id: <20210825211415.1057804-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210825211415.1057804-1-luiz.dentz@gmail.com>
References: <20210825211415.1057804-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

EATT bearer shall use the L2CAP signalling for negotiating the MTU
size.
---
 src/shared/att.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 665d7f4b8..329497728 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -411,10 +411,17 @@ static struct att_send_op *pick_next_send_op(struct bt_att_chan *chan)
 	 */
 	if (!chan->pending_req) {
 		op = queue_peek_head(att->req_queue);
-		if (op && op->len <= chan->mtu)
+		if (op && op->len <= chan->mtu) {
+			/* Don't send Exchange MTU over EATT */
+			if (op->opcode == BT_ATT_OP_MTU_REQ &&
+					chan->type == BT_ATT_EATT)
+				goto indicate;
+
 			return queue_pop_head(att->req_queue);
+		}
 	}
 
+indicate:
 	/* There is either a request pending or no requests queued. If there is
 	 * no pending indication, pick an operation from the indication queue.
 	 */
-- 
2.31.1

