Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E034C77B7F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 May 2023 20:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjEPU7p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 May 2023 16:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjEPU7n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 May 2023 16:59:43 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5824A76AF
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 13:59:39 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1aaf70676b6so692505ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 13:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684270778; x=1686862778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R8ePO2sjaQnIm9bbBHn0PowqDmPeO6nDpTMp2JxSNYk=;
        b=Zb+GHvgVkFDuFY1YAV5HOyQhoAurv6rRwY3/i6ry5XiXkjvfWGE4u6kvZmX2LCdZYc
         mQn+E2T5SyO+2txlOKOV2dX8CndhRSgtVIuE4ao4neW9IGKP+mRJdJPcxZuNf4pep/XV
         lvvvCtIJW1jwLclb+rOiJg2tBkiiWb+ml9m6eEiyvK7PKD6rfTVGF8b183apX2UTgIx8
         nkjMEMioR8hOKLXgllMi6BoQI0mtvOt+KI76AW+7ggUWtPhisIbdN86Gd9+VlJoflhKd
         ZV4/j8WEguh3BHc3h4kMdfbpXROv3gAFFAJJxym4dYE1dNb8eVBP202dr331mEW82YVq
         cJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684270778; x=1686862778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8ePO2sjaQnIm9bbBHn0PowqDmPeO6nDpTMp2JxSNYk=;
        b=D3FpV1XNHG0rFChoICLelh8bGjhfTOHh+TNB9zu8lxSmxCtZ2wLmn1RDfY6muHvA/B
         N+wZgOAFvns0CW9sMEw8teXD68heBKuOqwA2EZexgGM3E0re9fwIk0CmahDseXreIVN7
         vxSeqtl77SryF1EYqzM/RvU8crTJ6jxsgVW5HVefJq+uV6sWdngiHEgjDobz7yA1rjaS
         kqffe6Ggqs1u8CqG7VBfza5bxQq9pQEUqrimv9TB9h9ErojwytRiJ2hTlWwP7LOVCfI4
         ApDBlTsTY5k/AoHzk3TLuJCd4vKVArRvxGmMazddVhbxmyfjG+zWb7oWiSIO1kWQBK8q
         JBvw==
X-Gm-Message-State: AC+VfDz0PYmDVxI/jpmVH8mRcbqGifDwu0qSWqvtDXYzOJHbHj7SI3O5
        FsVPh558U3fqU5pXUgnC/TZG0+W+MDA=
X-Google-Smtp-Source: ACHHUZ7XSJRqTr4vqNbUQ4LldNTCQJUitLFRjljsKCWgUFNZfT/gC7crziRGuIdiv4gScnnP4YN3iA==
X-Received: by 2002:a17:902:ea11:b0:1ac:9ab8:538f with SMTP id s17-20020a170902ea1100b001ac9ab8538fmr35373964plg.24.1684270777811;
        Tue, 16 May 2023 13:59:37 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id t16-20020a1709028c9000b001acad024c8asm14272237plo.40.2023.05.16.13.59.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:59:36 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 07/10] plugin: Treat -ENOTSUP as -ENOSYS
Date:   Tue, 16 May 2023 13:59:21 -0700
Message-Id: <20230516205924.1040506-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516205924.1040506-1-luiz.dentz@gmail.com>
References: <20230516205924.1040506-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If plugin .init returns -ENOTSUP treat it as the system doesn't
support the driver since that is the error returned by
btd_profile_register when experimental is disabled.
---
 src/plugin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/plugin.c b/src/plugin.c
index dd7b406c857b..80990f8c3c7e 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -186,7 +186,7 @@ start:
 
 		err = plugin->desc->init();
 		if (err < 0) {
-			if (err == -ENOSYS)
+			if (err == -ENOSYS || err == -ENOTSUP)
 				warn("System does not support %s plugin",
 							plugin->desc->name);
 			else
-- 
2.40.1

