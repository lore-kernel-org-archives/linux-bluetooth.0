Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CA0C54EED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Jan 2023 20:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjAXU07 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Jan 2023 15:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbjAXU0l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Jan 2023 15:26:41 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE60C4B775
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 12:26:32 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so18994973pjq.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 12:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kq67JBvcPYpoYvZcU66qY6iLONnFTGyUhlXL9Pf7V80=;
        b=D8dyuSyN8zlLa4743ktVojZhIs6Mz1/PaFkaLFCB0vfsNtLjUg4dJFoqMNqIgEaO9Z
         ySpIn7sEEOCsJQzrSExzO/KJ0q5jl7CW7yVIHq2Lm7xBJ9gvFTvDohWC9sTSJrLIBU6y
         Q4+UEbtbdOKaHSkAIi+PNadYatWrhR2jf+XYEBJEAFt5FjixL0Z1goyGDjH3fe6Y38gB
         +1rkCD8pHg2Prr3i8lwzqGW/NzRajrQ8uX328/rNzSBb9mgoWczACH10NImQKb8ERVQO
         J10kOWdEsHSil4czzlqAZ+mx05TV3I1ZCpTkMRtBcpSCC4ysdJG/EQAaCNh5vx8At2LR
         zx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kq67JBvcPYpoYvZcU66qY6iLONnFTGyUhlXL9Pf7V80=;
        b=jyXHGckjqtFwa6Uohm7TzVJytQL2rmcQv2FNUetwdq5GbmTUyVrS+EK6TiBTAyHck+
         d/VyGRy8lpCReTftiOec4Be4+qorp+VvrvhoyZ87VVJ/FCeFZRC8L0syDpYIERzcQnIp
         S9yaj5aklwc6w6RP980Nx5qh+/Zivue/vzv6wnsKKhSdVyaVES12DQ+O9/dv/++futfH
         CuCEZD113UbRq8JpTINt/6p8FLDKixRJU5Xes+QzJ1HxzMzMQfItmbgTgCMQI2rthgP9
         MFf0G62d+u7d9kDIpuSaJWgAAlH6ozHUBJrufRv4VpLozEZNJaYaktgIJJZOknJb2lz5
         09Fg==
X-Gm-Message-State: AFqh2krBgF4c0mKKeAckOuMfS6wRE3BvJjSJ4rQO1pOi4O2c35m6EIpp
        ptsNCcDRErc6zqZc00AyamioTGR7Df45CQ==
X-Google-Smtp-Source: AMrXdXt4zvx6J1QDxtUmw5e6pyagf6pxYhf6FtPyh/pms3O/dT/ih9bTqkZ960OMQ9v9jwbrUDCeSg==
X-Received: by 2002:a17:902:e887:b0:193:e89:f5ff with SMTP id w7-20020a170902e88700b001930e89f5ffmr65407013plg.28.1674591991801;
        Tue, 24 Jan 2023 12:26:31 -0800 (PST)
Received: from fedora.. (97-126-124-199.tukw.qwest.net. [97.126.124.199])
        by smtp.gmail.com with ESMTPSA id ju21-20020a170903429500b0019600b78487sm2108099plb.33.2023.01.24.12.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 12:26:31 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@gmail.com>
Subject: [PATCH BlueZ v4 12/13] mesh: Fix Checksmatch warning
Date:   Tue, 24 Jan 2023 12:26:15 -0800
Message-Id: <20230124202616.310544-13-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230124202616.310544-1-brian.gix@gmail.com>
References: <20230124202616.310544-1-brian.gix@gmail.com>
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

