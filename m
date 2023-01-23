Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B324C54EED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Jan 2023 23:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjAWX5R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Jan 2023 18:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjAWX5O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Jan 2023 18:57:14 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF7B30EA9
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 15:56:54 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id g23so13069155plq.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 15:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nyLRrRCeQMXGL6cSSpBhFpwFf82XrwNffex770n9JJs=;
        b=dz8pIxmdqS09e6VZt4z1Y9fqJwQefef78BGlyCa+pR0IwOuN2gHgxYpqhX9OUoH+bq
         yXgNPVTbQslf5MP1LzBNvdaOWcbETXzsmB+2/mOHl2ymFbgL0NmlYZbS8yxidGS8NxO2
         fzv0zodiUAi8MWWJ23uUj0VIzoseRB0U6jrE/Tozcs8N4cTC/ijc608lNVT0VvkumMpH
         Bh8FwYNFOgjA+SVZ6shpsSJP7ANk8IsTXnz8M54gT6wTGEkO6VTUex6V1T2423/fU8A9
         PwAtlQc/dXR5n5q35a5X0keROVjeRsic3ota5h6wod74gBecK6k0EDOmxEu4Ud/6jA86
         RBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyLRrRCeQMXGL6cSSpBhFpwFf82XrwNffex770n9JJs=;
        b=VppqaSEOMFv6VwKQM+StG5wskXaG2v1IVDsEtA596sIYawdNdCmF4Y7PdJ4K3KwpyR
         aRqY0AiKtXdtZRypx8tCWHp5LxM2KXTn8oNt4ztUsx+P1TIkGbU5s6QtF8xi1yt07DHC
         aH49R6BwgNbiY1CsgsA0D87HxnltgNYfoLWwp3IHotZfvtTZrj9YKqWLhI/YyqepaQvL
         PW3YC8zVjKXhEBeKHCzMLDPK6FJKOt87OKPxs70rSTthcL7wzwRcw1SPtYCHAOexjO6w
         ZnFAv2g/Rg9ASx71e2V0B4hdNW03WJFlDHq7GzQGH7j8+DfnAJISp+D70uf0sRf/QxTb
         n/4w==
X-Gm-Message-State: AFqh2kqae0xP+66TpRu6zfGz8tyEMoqBRoPqYYspuYmKjiSt8FyPD6Xh
        uUHKrpBDOzKL/Qs7wEFH4vu8QSz2ok8=
X-Google-Smtp-Source: AMrXdXuMmeAJlQAFjQVOZJn5s+0FpzzxnfMi+h/ASlGUZxKKsazPKSQZBb+1Zk/oBXllt+o9FN3VIQ==
X-Received: by 2002:a17:902:e54b:b0:194:7efa:702f with SMTP id n11-20020a170902e54b00b001947efa702fmr34862746plf.53.1674518213809;
        Mon, 23 Jan 2023 15:56:53 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id w14-20020a170902d70e00b001960706141fsm268130ply.149.2023.01.23.15.56.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 15:56:53 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] shared/util: Check arguments on util_memcpy
Date:   Mon, 23 Jan 2023 15:56:47 -0800
Message-Id: <20230123235649.3231488-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230123235649.3231488-1-luiz.dentz@gmail.com>
References: <20230123235649.3231488-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This avoids having to check for !src or !len before calling util_memcpy
since otherwise it can cause runtime errors.
---
 src/shared/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/util.c b/src/shared/util.c
index 69abfba31978..89f1a2623cc8 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -221,7 +221,7 @@ int util_iov_memcmp(const struct iovec *iov1, const struct iovec *iov2)
 
 void util_iov_memcpy(struct iovec *iov, void *src, size_t len)
 {
-	if (!iov)
+	if (!iov || !src || !len)
 		return;
 
 	iov->iov_base = realloc(iov->iov_base, len);
-- 
2.37.3

