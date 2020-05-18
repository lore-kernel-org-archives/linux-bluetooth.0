Return-Path: <SRS0=JSwD=7A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762A4C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 22:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F7120829
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 22:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O43NZkqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgERW3Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 May 2020 18:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbgERW3P (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 May 2020 18:29:15 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3D3C061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 15:29:15 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ci21so470983pjb.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 15:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Crvasl2cLFymo7AJ0sHBn/fDUJwOc+UocOMVTyWbCD0=;
        b=O43NZkqu3YxlnGNgvbXmbwam6EWzT3cTPEaEz2KCm93h6FZYMT6bgOeJRIxkRunafJ
         L/XDrl6z3wdGxnMWbkim2btSkl0FJyiBxdCIIuK7ziePqLPcrYywwOdjWtSpjG+e2OkX
         KgAkkNcLZV2B9T+/aqkVAGMrcR2ACovvZ0U8AJV03IilEj3pRz+QoD0an7IEWxOwswXb
         k03rv9cwJkVJrvLqWnI+vBQg1EU7kFyYwUK/D0W13GabKIt7SyHPiyORm2K6s2hGXARx
         W0Uc6nEM9Lwv1/PIrnf+s14bCFUi2IaDREXOCMt1T5nL5EZca2WfAzbsV30QYmDkJhfS
         8mcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Crvasl2cLFymo7AJ0sHBn/fDUJwOc+UocOMVTyWbCD0=;
        b=X/7p92DcX2XRnbZZYpFpmqtIvcwYAVxeA7+0PlBUkkEU/7kcsXLrYMZH2ZsHcqUQa9
         1L1yh4PULNhJBh4a/1Ku5OKWzbnq5lw2zUcBD7RsyNYCSijmoOHNyOpP2KDAKzhdTBNa
         P5V4n+/dw3zvAPDTmnC6m+XYARjK2GjL/tpDjUKX2xieqaH6lzvamQbnNUXWKcehR4zE
         Sl/IvsTxpmYRwhaS4s6qY0EbbaRFV1PsrOS1fsjifnGOP6dthcoDEnHshRtnqOfklJX+
         6Gv/XKQnIik258GoUlLdsjxJRxd4KS0jA5CApGu8/8VcpwCmZlSO84CWOhJS5dI7/FGr
         7Kew==
X-Gm-Message-State: AOAM531Tbz+63rkF91CTrMdqUZKxD7MYyVyizXKxMvikRw480/e84UBO
        DHm2598ZDspMse+FZQE8OPUSRSBT
X-Google-Smtp-Source: ABdhPJxfv3g9BCmjcNPFoWgvIBEXk/pLmfAyqVf2xovXr+jzlzjtBkF3ufNMjnqDYe1mrlUUSPjEJQ==
X-Received: by 2002:a17:90a:32e9:: with SMTP id l96mr1729057pjb.76.1589840954748;
        Mon, 18 May 2020 15:29:14 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 5sm8291733pgl.4.2020.05.18.15.29.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 15:29:14 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/4] doc/settings-storage: Update documentation of Endpoints
Date:   Mon, 18 May 2020 15:29:08 -0700
Message-Id: <20200518222908.146911-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200518222908.146911-1-luiz.dentz@gmail.com>
References: <20200518222908.146911-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add documentation of DelayReporting storage as that has been added to
the cache.
---
 doc/settings-storage.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index 5f6d25141..6e67ddc9c 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -225,6 +225,8 @@ Sample Attributes section:
 	LastUsed:<xx>:<xx>	String	LastUsed has two fields which are the
 					local and remote seids as hexadecimal
 					encoded string.
+	DelayReporting:		Bool	DelayReporting indicates remote
+					support Delay Reporting feature.
 
 Info file format
 ================
-- 
2.25.3

