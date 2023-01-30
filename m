Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C592DC63797
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Jan 2023 23:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjA3Xwf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 18:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjA3Xw3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 18:52:29 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D302FCC0
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 15:52:29 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o13so12644931pjg.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 15:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kq67JBvcPYpoYvZcU66qY6iLONnFTGyUhlXL9Pf7V80=;
        b=bgSKXhXvSQYVO+OYP9JvKbmvC/6bYoY6H5tcFYmd31DF06o8Fw4YstEJuC2tlaix0/
         cfJSC3ADiUfYlQ109ovTS0q0h9QOJORcYtdpYvvqlGboSKoeAOihg0cgJ9bzCkiJ2zDe
         e4PcycOfBbHl/lIFgG1nDfN/UgyYKOd77Uj/NJhkNo2sNOaaqthbZcT8aBuu1LmIJ84k
         TBuJm25Up9dcZI7XKVQZqXWSYFBrXQO0YBf93EytLCbdZhKFrrB3iR9+1RgCPeQWCSjU
         tt4O4n/1kF55dhA0VPKSD5dUxIPB1/DsRFplXl1bcdKmAABzsaz+92/6J8vfD+k84l/s
         OF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kq67JBvcPYpoYvZcU66qY6iLONnFTGyUhlXL9Pf7V80=;
        b=GTMK5JgKMPcSPfr+vn9zi5bvNPN13vF3c9nIscGG3H6aSur5rOfe+akjwG9nc76DTZ
         DTedhI0ePGL+MivD/ekq4gqnoguUG+E0dmnRsZjvWTqn5wl5u2Cz0MyAUGVptlU+QYB6
         u6UlKOc+No5TLklQ00MIu90q0MwueslHfw/Wxj4iQcHSLsip3qgAkMYsuL/xAnL+3uuC
         cHEED42YudF4UKoMy7K8fVcdI/eUh9qVlDE9z6NAbl6myFujX6+nYbvU89wpgftJP/FB
         6eX7RXhmiMZxxiG+dmfj8aFv2AiUlBuB/kJYTbpRPx0Z4M0m7ELjiajmYT4rXHpqUFkF
         V88Q==
X-Gm-Message-State: AO0yUKVDZ0X9ngPBMo625RCoHa+0wnY/n+cbJxCFXw99w3hett40aIh7
        Iq27UdZ3wV5FHEKQmnW+c81YugROh7HBLQ==
X-Google-Smtp-Source: AK7set/sWUYfz/A9yAkCU6bXVhjsKePlCKEaQT8Dk09DQvf/+SGY32SJAns+RwOdvHqG3epI8rCIqg==
X-Received: by 2002:a05:6a20:7faa:b0:bc:30aa:8a6d with SMTP id d42-20020a056a207faa00b000bc30aa8a6dmr18078832pzj.2.1675122748110;
        Mon, 30 Jan 2023 15:52:28 -0800 (PST)
Received: from fedora.. (97-126-124-199.tukw.qwest.net. [97.126.124.199])
        by smtp.gmail.com with ESMTPSA id t191-20020a6381c8000000b004e8f7f23c4bsm2663948pgd.76.2023.01.30.15.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 15:52:27 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com,
        Brian Gix <brian.gix@gmail.com>
Subject: [PATCH BlueZ v5 12/14] mesh: Fix Checksmatch warning
Date:   Mon, 30 Jan 2023 15:52:08 -0800
Message-Id: <20230130235210.94385-13-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230130235210.94385-1-brian.gix@gmail.com>
References: <20230130235210.94385-1-brian.gix@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/crypto.c b/mesh/crypto.c
index 3754cb012..38dfc5fb5 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -1020,7 +1020,7 @@ static const uint8_t crypto_test_result[] = {
 	0x9a, 0x2a, 0xbf, 0x96
 };
 
-bool mesh_crypto_check_avail()
+bool mesh_crypto_check_avail(void)
 {
 	void *cipher;
 	bool result;
-- 
2.39.1

