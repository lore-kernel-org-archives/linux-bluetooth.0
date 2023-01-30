Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92471C636D3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Jan 2023 23:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjA3Xwg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 18:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjA3Xwa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 18:52:30 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B88B2FCDF
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 15:52:29 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id c10-20020a17090a1d0a00b0022e63a94799so2327454pjd.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 15:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3S6DymdGfYHRiXCumpLY6fvCt5QsjWexMsLMH4TD6o=;
        b=Gew8Xe8lQrHUlaNfYaB3YmY+cXblfv6hGS2APWp12quOikPEJXS2PnXYI6VpUYtDrv
         So0Cyozglxl8JJkWyAGeVc04A8WBHFZUpMF3p1PPi2qwNY3H8w9+Qa46+t2/WXQajdMa
         6+sQi2+44Svm535RDtcUc7BjhVJI9ceDAr7MJbKqu2bkmJ+AC8oYuosUTM2d0WrJPN13
         l2UFyI8JITcv/3TPMmQ2an7PAJO8rMT8UGzarlGkSxUZQ6u2WNds8wjAS030Mbb+JmfB
         vvYoeRzJdZrHhI+s2EP/Vb4CZ2YJhDnRE2kGDIbPTIpP7jtdYV6d8UvxKLYbm8E4yDvy
         rQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3S6DymdGfYHRiXCumpLY6fvCt5QsjWexMsLMH4TD6o=;
        b=JVHUSgM/ESK2JJSgQg5bEMWkeVabpFvaZA7m3aBK5soKOubLBH2+5THN952MQwQxzp
         JCVfxXbLpdKceOcPMK2dPb4YZU3n7nsyy3HAhL+NVVhK/GcaelsKTVBtO93wV2hAFgBx
         mR81vBaoFW7Ms+TCahXHRi86IXDmw7bTdWyst/wAjxcIjHJ8v9YNAoqHZkUYCEF7CP63
         T5j247mxdy/fCDy4/we1yRtLOYc9uNVhtWIAUSKttVkFFS0Toa6sEancreGZQBQbgvET
         X79IFrsndbik3cf17GvolbfAbtKYq39sQjfqVv2gDeqvRG6NoMa5e9aemSwMdhuh7nuA
         zRhw==
X-Gm-Message-State: AO0yUKUOkX0rblK2ErtnOiqcjy7rMqA4AueZDKVoCk0aSpfDYpr7fXeC
        gudw7C6VPDg9xxdVeV7+O+t6P34jMkDnIQ==
X-Google-Smtp-Source: AK7set9r0fSti/PHYKevmyqo26CERZNExiQsInfTzWSuHd/nyF4ZNYz2Fq5munXkZAyT+9lzxHXywQ==
X-Received: by 2002:a05:6a21:6d84:b0:be:b106:3191 with SMTP id wl4-20020a056a216d8400b000beb1063191mr3071485pzb.49.1675122749158;
        Mon, 30 Jan 2023 15:52:29 -0800 (PST)
Received: from fedora.. (97-126-124-199.tukw.qwest.net. [97.126.124.199])
        by smtp.gmail.com with ESMTPSA id t191-20020a6381c8000000b004e8f7f23c4bsm2663948pgd.76.2023.01.30.15.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 15:52:28 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com,
        Brian Gix <brian.gix@gmail.com>
Subject: [PATCH BlueZ v5 13/14] mesh: Remove unused byte swap for ScanBuild
Date:   Mon, 30 Jan 2023 15:52:09 -0800
Message-Id: <20230130235210.94385-14-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230130235210.94385-1-brian.gix@gmail.com>
References: <20230130235210.94385-1-brian.gix@gmail.com>
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

