Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563E3C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Nov 2022 22:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiKIW37 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Nov 2022 17:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiKIW34 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Nov 2022 17:29:56 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346EF2EF3B
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Nov 2022 14:29:54 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id x18so138948qki.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Nov 2022 14:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9NUfThJze40JZuD9O7heY1c4LUEd6OwbZ4ARTWE9sGA=;
        b=NgDbz3QnbzBi6zEbg1wMETxK3JARj6Mc+biCrngm1MXbRxIZ55XCXlvrTPHzdw1kTT
         ROuttCm6EFfHGijxz5wXjptc8LSdkD5+bekEXQ1YcBcmhhq4dl51fJZSfuZcnp0KnyWK
         GDJXZFRs8hdpCoHihSwBHv7R/X8BdB03eps6Yw/W0YEhjNrfluQ1VmcKBSR5eRzCoj2a
         arFqWtoChNNHLfeVUw/YXHs94LhZtNjZj/aRM73jmIpzXJd0paKTpTSs+7FQizfQWhQS
         6w/RU0eNFh8urZAHxcCVqrbr/sUzKR0xgCZWyi2Na4ZIiguNQky2JbZlKYFn0Sh6F0Pd
         zcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NUfThJze40JZuD9O7heY1c4LUEd6OwbZ4ARTWE9sGA=;
        b=cJLODHJ+6C5zPSyYKTwCi0rk4dDjtivijQxQBjRRNu7NqxlrYFmzrdXXfDnrATk+pJ
         4HrKlOd0dNJA0yq7qfuE48rj4Gx8+AFudGjPxBbjfTi0ZEThkEQd/TO/7HZ2ev/rAdGl
         csNq3eHYklfidLw8ELBK6did0hfcdPiluKvIfmkMbAiOLF7gDFzMZ8cAbsGmOPfXW5Na
         8/k13yYOjyysPqbC3uUoCS9tebg3rI4HT4EnQ52EVCCUhDi7Ph+ySQGPt485xyMTZLDc
         /8gLYRMoFtg2ansa/KsmF+fVtAE0v9ffxuX7WHari9lRmBNoSG43XuzUL503xmfIfoUP
         /90g==
X-Gm-Message-State: ACrzQf1o7cjco8SCGoESFjjhZa0L3duO7cmdt17PiEGmyRWpROGOZwBm
        qG2BgWfhrZFi+v+S2nQ2qyMdrGNOMDM=
X-Google-Smtp-Source: AMsMyM5+u76PFb/d9C+LUFGmniOARnSEldakW15lNsywtwNG83PoTHuDFPNimJ89vwQGyk3YwzJV4g==
X-Received: by 2002:ae9:f309:0:b0:6fa:8899:5232 with SMTP id p9-20020ae9f309000000b006fa88995232mr22184367qkg.240.1668032992839;
        Wed, 09 Nov 2022 14:29:52 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z9-20020a05622a028900b0039bde72b14asm10518732qtw.92.2022.11.09.14.29.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:29:52 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] shared/bap: Fix crash when canceling requests
Date:   Wed,  9 Nov 2022 14:29:46 -0800
Message-Id: <20221109222947.1137901-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221109222947.1137901-1-luiz.dentz@gmail.com>
References: <20221109222947.1137901-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If bt_bap_unref/bap_free is called while there is an ongoing pending
request it may endup calling into bap_notify_ready which will try to
notify ready callbacks while holding a reference, but in case the
reference is already 0 that means it would switch to 1 and back 0
causing a double free.

To prevent that bap_notify_ready now checks that the reference is not 0
with use of bt_bap_ref_safe.
---
 src/shared/bap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index c3c0d596fe91..1bb982fd080a 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2721,6 +2721,14 @@ struct bt_bap *bt_bap_ref(struct bt_bap *bap)
 	return bap;
 }
 
+static struct bt_bap *bt_bap_ref_safe(struct bt_bap *bap)
+{
+	if (!bap || !bap->ref_count)
+		return NULL;
+
+	return bt_bap_ref(bap);
+}
+
 void bt_bap_unref(struct bt_bap *bap)
 {
 	if (!bap)
@@ -2739,7 +2747,8 @@ static void bap_notify_ready(struct bt_bap *bap)
 	if (!queue_isempty(bap->pending))
 		return;
 
-	bt_bap_ref(bap);
+	if (!bt_bap_ref_safe(bap))
+		return;
 
 	for (entry = queue_get_entries(bap->ready_cbs); entry;
 							entry = entry->next) {
-- 
2.37.3

