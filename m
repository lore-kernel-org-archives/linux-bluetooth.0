Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4D1C3F68F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 17:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38D5214AF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 17:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="QnMLkUlW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgAORJC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 12:09:02 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:45357 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgAORJC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 12:09:02 -0500
Received: by mail-lj1-f179.google.com with SMTP id j26so19377579ljc.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2020 09:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rXtTljHVFhRNlmRbaj9TvjqLgpgtRjEfGp+77E+05tA=;
        b=QnMLkUlWTwHrQBxzmwp/qv+9bHSFV3ebVyHt/ODRfnGJ8j9PcpOF0KUpd/ifdz7BE2
         s47SUB0/phJYYEwFoDW3CGGlVad7BjV6qQakNkpLs8KA8uahHBMIFSd9mKnj7kewHbJO
         gengVRtv8KW+B0REyFm90LlV3fAfadyDj5NLvGhNODRpx4vr5hycE7pubpSs17IqjS//
         ZaDMsacqIZ2CZftT9WFPXPBLes17iFYffWhtyo91HELWk5519aplWHd8n9ilSKjhiMYw
         +RYMb33iixCv9W3urWTXIt4w7d0EvAM1FjZl31PebcnLk6ckMVvwG2lu9GeCNpPHqIvl
         rDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rXtTljHVFhRNlmRbaj9TvjqLgpgtRjEfGp+77E+05tA=;
        b=KRKrS5xNjkWo1k2lL5LmAloB3xYi/mOmFiVU2S6RSCtrcqupOg2acp0fs7QkAKzoAV
         RHkp61KVm+Y1oTBkIgoqVlYRwodoXvG6HlecjyBQiVu8ryJnK1DkbJuifteoA5/hoz6R
         fM39roeQjdEj2tl9UAc2cKRf6OQ3XiguNe0IirpmXkdn85KpMqCvNHJSsCXg6xwUl9iF
         HRIxatB6feGWD4j8qVvJTfvF9uNrNqePmglQDr3VU3Kicw9jYssDmsX6SaPw/JxDRmQE
         /McEvTyfr8f5oDScKrDyAAUPb8jYdF3qsWvMJnA7V/p5GzvfA6vFU5D8gydr1rzLM9rB
         4n3g==
X-Gm-Message-State: APjAAAVSNU2XrASQyCgNuN02KCVMJVUDb49ajwIIXS8/a/Oq3/6umvGt
        N9gY/ymOLvMZAfeMOnJLfCSJUSv2xYp3hw==
X-Google-Smtp-Source: APXvYqwP6cru9UMFgG/ibPudjui8u5jdkyO/56aZLjtgEjzIzObsdGhjw32478oyj+DhafRLWZFi8w==
X-Received: by 2002:a05:651c:111a:: with SMTP id d26mr2482353ljo.153.1579108139999;
        Wed, 15 Jan 2020 09:08:59 -0800 (PST)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id m15sm9685972ljg.4.2020.01.15.09.08.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 09:08:59 -0800 (PST)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/1] mesh: sequence number out of range fix
Date:   Wed, 15 Jan 2020 18:08:30 +0100
Message-Id: <20200115170830.7479-2-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200115170830.7479-1-jakub.witowski@silvair.com>
References: <20200115170830.7479-1-jakub.witowski@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/mesh-config-json.c | 4 ++++
 mesh/net.c              | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 755caab0e..3ee3317d9 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -40,6 +40,7 @@
 #include "mesh/mesh-defs.h"
 #include "mesh/util.h"
 #include "mesh/mesh-config.h"
+#include "mesh/net.h"
 
 /* To prevent local node JSON cache thrashing, minimum update times */
 #define MIN_SEQ_CACHE_TRIGGER	32
@@ -2019,6 +2020,9 @@ bool mesh_config_write_seq_number(struct mesh_config *cfg, uint32_t seq,
 		if (cached < seq + MIN_SEQ_CACHE_VALUE)
 			cached = seq + MIN_SEQ_CACHE_VALUE;
 
+		if (cached >= SEQ_MASK)
+			cached = SEQ_MASK;
+
 		l_debug("Seq Cache: %d -> %d", seq, cached);
 
 		cfg->write_seq = seq;
diff --git a/mesh/net.c b/mesh/net.c
index f0f0dbdbd..10dfd5dd3 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -511,6 +511,9 @@ uint32_t mesh_net_next_seq_num(struct mesh_net *net)
 {
 	uint32_t seq = net->seq_num++;
 
+	if (net->seq_num > SEQ_MASK)
+		net->seq_num = SEQ_MASK;
+
 	node_set_sequence_number(net->node, net->seq_num);
 	return seq;
 }
-- 
2.20.1

