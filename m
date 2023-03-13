Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CEEC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Mar 2023 19:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjCMTIo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 15:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjCMTIn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 15:08:43 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A512410A
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 12:08:21 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id a2so14106697plm.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 12:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678734500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5gnBYurJj/sSwz4sdRExHzQWEjr2nz2b5D6grz7/PWs=;
        b=hTm5iEQmf4C1AQ11H2n33134i/VpqOtn9GzLgotwELTbMfwUZnOjFc1tBDDIjE6BcJ
         DSGbOK6uZmsbRIu3Q/3DKr4vdUitrgcHZrnfnExs6wrXzUhKu1BGSwcViIhyZFdbI90p
         hffxUPTmaDXnQdNFTDwQY0hNFNedCMudeDsnQ1qglawWF310UuYNANY/FjUT38O4SWHp
         vr6/t4juW9L02ITLMqTDgX07aHWLxE5G7TgG7s4Jt5OCrkT1MonK6i52u3kVR5e2utYW
         dI8aF+oIWGCi3Ut0NgnMuFaGb4g6iwUa0uirh7sUy+qSvEAIeBZ/ea0KRsI6ArJCDM4L
         ljjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678734500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gnBYurJj/sSwz4sdRExHzQWEjr2nz2b5D6grz7/PWs=;
        b=xC7qD02hwOuOH3JNp3IBusoFoNPMQDXmC7fxinGTI5d9PAa06VqnJ9v3CuP3NfWfTg
         Eb2pSyLR+zqgyVS0EH6Y7PLygmAB83f9+kw7dla5gBdClPRNric2c3/O/cmLQE30zMDe
         h/BJmAUP+85wo6PbVnohMXyPSv9ActXGMSTli2wj84FotxUxsQs0K+Fpn8mg8V6W0E7Y
         VoyJIVJRU0JnQcxlvTOl9FYJNiRAJfR7FUj/DrfLDyrMfp/K3daZNQ2hOC4mBpQhMmsS
         cof+B/S78MUhyEUcNY6N80cm3xd85kxN/E/w01uysLx4wH1EMciEtxNfDMZUBX3LTstL
         TBSg==
X-Gm-Message-State: AO0yUKUixUg77Xwp8XE4rCYae+xub+OpVhvkrhj4MlL9Lxja2DgtWZy6
        SZqP3HbuFwdAuW5V3rKpFZf9M/oQGT4=
X-Google-Smtp-Source: AK7set9roerv9hG5Z55uk53u+yIssNCG7CUajuQ25lndlgkZqn24vO7bCBPLWQxf7q7rZCcrMeA2Lg==
X-Received: by 2002:a17:903:230c:b0:19d:62b:f040 with SMTP id d12-20020a170903230c00b0019d062bf040mr43092158plh.37.1678734499841;
        Mon, 13 Mar 2023 12:08:19 -0700 (PDT)
Received: from zbook.. (97-113-12-200.tukw.qwest.net. [97.113.12.200])
        by smtp.gmail.com with ESMTPSA id ke4-20020a170903340400b0019f3e35194esm228884plb.64.2023.03.13.12.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 12:08:19 -0700 (PDT)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, brian.gix@gmail.com, inga.stotland@intel.com
Subject: [PATCH BlueZ 1/2] mesh: Fix uninitialized memory usage
Date:   Mon, 13 Mar 2023 12:08:07 -0700
Message-Id: <20230313190808.48102-1-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When attempting to cancel an unknown Scan request structure must be
NULL initialized.
---
 mesh/manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/manager.c b/mesh/manager.c
index e16dbc513..0c98721bf 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -709,7 +709,7 @@ static struct l_dbus_message *start_scan_call(struct l_dbus *dbus,
 	req = l_queue_remove_if(scans, by_node_svr, &new_req);
 
 	if (!req)
-		req = l_malloc(sizeof(new_req));
+		req = l_new(struct scan_req, 1);
 
 	if (req->timeout) {
 		l_timeout_remove(req->timeout);
-- 
2.39.2

