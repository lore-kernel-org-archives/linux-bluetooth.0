Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D33C61D97
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Jan 2023 20:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjAXU04 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Jan 2023 15:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjAXU0l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Jan 2023 15:26:41 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9944B49A
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 12:26:33 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b10so16311860pjo.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 12:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3S6DymdGfYHRiXCumpLY6fvCt5QsjWexMsLMH4TD6o=;
        b=UjrINS4Fmn9amGn2nHJ8JUZNk3l8tLdHDrXXD4LKTMQRimH3SSaPUyLgW/FL+Kmlrm
         gsA2YyX+Vy2LnYSGOlhyVB2PRfAKo9RG7/yec7LKFPGsjdFat6U+PN5FkyCONv3k2S9K
         6nsBFK4vjj5eUthwrw141kPGhKcNd5lPOBvESXHdpQ+JYzuHV16eZG0y7iuElPSCKZ9h
         GdaYQ3hPfnG5Re6hN82zxLkoOvjwRdV573dwVMiTUhehHnDmTcjjnZfzj4zvcvh3aXWc
         cCLetIRR292rYtVeLWlj8XVQ4wo7SuDxkP7nAjkBYem+TGQRC5CDATqx+D3ah9b2cWwV
         cHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3S6DymdGfYHRiXCumpLY6fvCt5QsjWexMsLMH4TD6o=;
        b=ILZLlzbPax1kQlrAGWKLQmRW/ECOBbrpfQXd6SC2OaMgJVo+ooXSfjAWf1PPK8Mzzq
         Bj6mS2/63STguapbA0Y/XCDGu4B2M1w5mo5iETGWpxHQXNX3Wmc96X0E9z5htHkH/iLR
         Dkzl3X7Yet8LsoPBioE8YX7TMPcpQWdGqHPvvT3I4GLqgPHH+vJw3otFmKYZWD5MgjOf
         y4i3Ez5QZ2j8uPigRr62Y9WubDb9cQUABKhn/4Jwj2lO8qfY8F4s0AlMWmsKcNuRoh9x
         jhZcteb4QKoyV0jx+wHdBHq0wqiOm0OE9P9o2mZB0N8mIe58BlxavPKgeSU0u7YBsc/j
         hOxw==
X-Gm-Message-State: AO0yUKUReiVlsFrLdzKF/8da+OjMcT6EgVnrzaWwXTS+PB0aRf84knW0
        PwAyJ4iSIyfiQx2378DPEIEyrB5Keg3ZPA==
X-Google-Smtp-Source: AK7set+lpU5N3qQCqGri6zK0h6Y9MAj7eZj3e2QbMq5Xc8+XWLf9GZSrVnWfTJDk0/66W0rejLaHJA==
X-Received: by 2002:a17:903:1ca:b0:196:1519:3538 with SMTP id e10-20020a17090301ca00b0019615193538mr4094936plh.57.1674591992882;
        Tue, 24 Jan 2023 12:26:32 -0800 (PST)
Received: from fedora.. (97-126-124-199.tukw.qwest.net. [97.126.124.199])
        by smtp.gmail.com with ESMTPSA id ju21-20020a170903429500b0019600b78487sm2108099plb.33.2023.01.24.12.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 12:26:32 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@gmail.com>
Subject: [PATCH BlueZ v4 13/13] mesh: Remove unused byte swap for ScanBuild
Date:   Tue, 24 Jan 2023 12:26:16 -0800
Message-Id: <20230124202616.310544-14-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230124202616.310544-1-brian.gix@gmail.com>
References: <20230124202616.310544-1-brian.gix@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/crypto.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/mesh/crypto.c b/mesh/crypto.c
index 38dfc5fb5..b712a2654 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -94,13 +94,6 @@ bool mesh_crypto_aes_ccm_encrypt(const uint8_t nonce[13], const uint8_t key[16],
 	result = l_aead_cipher_encrypt(cipher, msg, msg_len, aad, aad_len,
 					nonce, 13, out_msg, msg_len + mic_size);
 
-	if (result && out_mic) {
-		if (mic_size == 4)
-			*(uint32_t *)out_mic = l_get_be32(out_msg + msg_len);
-		else
-			*(uint64_t *)out_mic = l_get_be64(out_msg + msg_len);
-	}
-
 	l_aead_cipher_free(cipher);
 
 	return result;
-- 
2.39.1

