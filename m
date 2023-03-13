Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA30AC6FD19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Mar 2023 23:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCMXMD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 19:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjCMXMC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 19:12:02 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816A17C3D0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 16:11:56 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so3212141pjt.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 16:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678749115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5gnBYurJj/sSwz4sdRExHzQWEjr2nz2b5D6grz7/PWs=;
        b=P3n0AIkSyvaLPxw+qkFW9YCqmz/3OVeSEyQPrL6e05VhkrxnMzxOGKS/Xg5AT1kNmT
         yw0XsuQNRTpkLQiaquQgOCk+tGAcyOzbMrpbSc73b/pkGwWcnhZZo/43mCMAaC/Qf6cO
         QIiyInU57XF+lkOdeRdi+3b/foJwiFmvhRyDzqJAhFbWY/cxkXMgXIn/UWVhp39fUNxq
         S0TRWzNSzaEX5qAOekOb7FVJx/v9s+vB8ZyyIb9MpDo8eY+lfSAF33y+jfgVNUqQCIep
         VBKS2OrxAarTSHOH+xrOKNsBHrgovtAZwEghCGE9WYxmqemjTFs78NNhW1ME3fPdvFw1
         riKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678749115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gnBYurJj/sSwz4sdRExHzQWEjr2nz2b5D6grz7/PWs=;
        b=4/1cANW+LDvN9ZqxllQQHDfLJYkElcvYtWsXJzMKFfO+A/E+fsrsXEYIdMAyDPrPSk
         I1KaRzeCthXa5pfOuKzP0x15+9TPHQhbvub/TibxIOIHgEmzaPSsW9GZvbPJHuLW1drr
         ac+nJ9IWkOBbqcsp5tC9Nm63EkwtQelpL5s956JbBpL89BviiuW8pcmfyWExF01eB3Tx
         dqCpsoPgy1VMX/LCa10wSAsXSHTfzH6Dz4sWzzeKicGcPCrwLBND/W6Fz++97mcMe2gw
         gSuC8kiHqtDgFzNGQ+t8Z70xpYv2U7rTY61npzwv3AAWhUtfGGL0QsKYHQXf/8Guz8Wx
         KI+w==
X-Gm-Message-State: AO0yUKXqZVozSIV5HsB5jXyNHewypGCE15DEuizmYiM2g6DCmLUALSHX
        Cngl8Rc8IimtzjN7prk3J9Rfr8L95T4=
X-Google-Smtp-Source: AK7set9UV7igjsrT1Ktzb5E/4qlolmgnwkwDI2nl4A2tv50sPlJ42WRx1Hk4fbXZdiC79EcRU9XQZw==
X-Received: by 2002:a17:902:e54a:b0:19e:8bfe:7d79 with SMTP id n10-20020a170902e54a00b0019e8bfe7d79mr39701800plf.1.1678749115385;
        Mon, 13 Mar 2023 16:11:55 -0700 (PDT)
Received: from zbook.. (97-113-12-200.tukw.qwest.net. [97.113.12.200])
        by smtp.gmail.com with ESMTPSA id kv8-20020a17090328c800b001a04f0ec697sm375350plb.65.2023.03.13.16.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 16:11:54 -0700 (PDT)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, brian.gix@gmail.com, inga.stotland@intel.com
Subject: [PATCH BlueZ v3 1/2] mesh: Fix uninitialized memory usage
Date:   Mon, 13 Mar 2023 16:11:51 -0700
Message-Id: <20230313231152.59147-1-brian.gix@gmail.com>
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

