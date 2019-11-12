Return-Path: <SRS0=2Kq+=ZE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F71BC43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 14:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E572120656
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 14:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="kMttzkOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfKLOye (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:54:34 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33465 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfKLOye (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Nov 2019 09:54:34 -0500
Received: by mail-lf1-f67.google.com with SMTP id d6so12681601lfc.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2019 06:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s8Qq1ijr+e9R5gPAvVvz71fzXphQW8SpvCMlfr0BT9k=;
        b=kMttzkOLFOCXo0k+TFdHBpL0FJl4llSIt9Mw0+OrOeEv4FReXcT5jjHvU5pEu1/XzQ
         FT8BrcMi5MdyY7aWCKE6QoHFjvYx3Z8YtOXGevZVZAn8YzRUpKzd0n5szGX5F+FfPgHu
         lFuIpAD/nbhdJemLM0VkjXdqSuf4A86Bn01aT6HPlYhwk4y3DISn1d0GG3XuiWulorbU
         1AtVDgUV+M4u3v1yuDABCeu+cIwLrfzO71r0mf+0u7TUqjFTUDXPNPU+PbZWMPpVyyT1
         IeTfQOQOQHo40lRlcCRpot7NuigFpnW5cJdfMd91/+toSEA0GyOv8ltJ+hun9C1PxOyg
         3WCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s8Qq1ijr+e9R5gPAvVvz71fzXphQW8SpvCMlfr0BT9k=;
        b=tbclHd5FbkC3Ky+Ht2JYSM52tP9hHH096moJbDgLM+UwCEzxsXCyx4879nKUpYUZkA
         Wh8LZI536y92biJDSX0olPhizILRYryVDSc4VNKCqyFuCI6uBue17sJvMdMB88B3d/qy
         gWxQGcmzMS4YTKRh0j+8mdcc+Hj/upIJrraHlUCSU1Dk3UsIZjwZ8UpmDraCcF9fv8mk
         WJNou1DmbUGp1assPM2PvvLDaLatWB7u5JD2gtlAubLCoA9ybLXCZODEJJFwU5+J0e4+
         wvNl3sI5C1OGck8jhoSlY8sI3GL59/3AgIqae2Q3GIjUeJ8PT2uPhQNpc1Y5MAs9HmSA
         sWdA==
X-Gm-Message-State: APjAAAUmXcAERZiesLENWKhqOB5s2bXQKcCd6g48zKoUFEz1Kt2Vqm7i
        Fw+Nq4XDkdFKYsZcIj6sgWBw2nnqybXFKA==
X-Google-Smtp-Source: APXvYqxOmyzt7CCKPCX/P0ti1eNm4NCC7+hmkzna6SGSYEimqW2cqfZW8LLPvbCsGUmINYgS6Z9ksA==
X-Received: by 2002:a19:da1a:: with SMTP id r26mr20322883lfg.60.1573570472008;
        Tue, 12 Nov 2019 06:54:32 -0800 (PST)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id x12sm8398361lfq.52.2019.11.12.06.54.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 06:54:31 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Fix ignored return value
Date:   Tue, 12 Nov 2019 15:54:25 +0100
Message-Id: <20191112145425.6318-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes the following build error when compiling in maintainer mode:

mesh/keyring.c: In function ‘finalize’:
mesh/keyring.c:142:8: error: ignoring return value of ‘write’, declared with attribute warn_unused_result [-Werror=unused-result]
  (void)write(fd, &key, sizeof(key));
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
---
 mesh/keyring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mesh/keyring.c b/mesh/keyring.c
index 9fa7d6bd0..fe292b4a7 100644
--- a/mesh/keyring.c
+++ b/mesh/keyring.c
@@ -140,7 +140,8 @@ static void finalize(const char *fpath, uint16_t net_idx)
 	l_debug("Finalize %s", fpath);
 	memcpy(key.old_key, key.new_key, 16);
 	lseek(fd, 0, SEEK_SET);
-	write(fd, &key, sizeof(key));
+	if (write(fd, &key, sizeof(key)) != sizeof(key))
+		goto done;
 
 done:
 	close(fd);
-- 
2.19.1

