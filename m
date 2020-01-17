Return-Path: <SRS0=B7Pc=3G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05750C33C9E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 04:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4AD20730
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 04:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hbG8a7Ik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbgAQEY3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jan 2020 23:24:29 -0500
Received: from mail-vk1-f175.google.com ([209.85.221.175]:42541 "EHLO
        mail-vk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgAQEY3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jan 2020 23:24:29 -0500
Received: by mail-vk1-f175.google.com with SMTP id s142so6306570vkd.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2020 20:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o8PIQed1LRe0C3RiazsX+APjSueZMw7ZarM3bcdpyMc=;
        b=hbG8a7Ikc3w7g/lY8AHmPz1XWkA4vqIjw93DLwILSjf89weIQjVIesgvC0Ln2sD0zN
         dCSlYmm8YmuhOJS5qntZIfidlX2lwLpEsc2ZTr2VVcqkikgaIkEZHTvoVOPv5o4/H0K+
         GpqRGj+PVOS+jWpTNqI1bSZm3UBYbPimJDmBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o8PIQed1LRe0C3RiazsX+APjSueZMw7ZarM3bcdpyMc=;
        b=NJ8b74zPQeTVvOnFbBMAFJSiKGnjNHv5WjYlN1idAyqROIzsh7wh6JyVNFAkYPJthK
         xgJPlJ2KqPWyyiyPXi/FYCEk7zacI4/KUmdQndvmWbii4SikCosOJ6yrkNmAn+VgCDJm
         RMM0vC8PfDseW+2ooCYXDTjdFMnhL/bb4fU7FpUcSko646IQLEMQMdmEo+v90al6DY4E
         thGJwT1XSCMj6whNa/pSAPkMxNVUqVbR0jn+HoeH74dfEv35gqz6QmWgxuuYxKgmUA60
         qDfQM+jM/iJMmNknGrt6rzBVRz/85Uh9zOxLF4vL4Mfj3I6okJ1tESDX2R6fMXbiEF/i
         Bs6w==
X-Gm-Message-State: APjAAAVZ7srj49PvGViPxRwuNEmmtNq5Mnv/Yjlh//BFO/i2DpED1wF/
        zYjMqIj1VlWUIiQ7xzWI2UPb+/pGCI0=
X-Google-Smtp-Source: APXvYqwEbajB8knYUSdIRZXX7EJedNp09vQgzNtpRNAS6psUydl/GGQU67bpCRkKQTXocsq3wDJNpA==
X-Received: by 2002:a1f:3ac9:: with SMTP id h192mr19931153vka.55.1579235067848;
        Thu, 16 Jan 2020 20:24:27 -0800 (PST)
Received: from alain.c.googlers.com.com (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id g26sm7080664vkl.16.2020.01.16.20.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 20:24:27 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [Bluez PATCH] Adding missing op_code string conversion.
Date:   Fri, 17 Jan 2020 04:24:21 +0000
Message-Id: <20200117042421.68430-1-alainm@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Adding the missing string conversion for MGMG_OP_SET_BLOCKED_KEYS.
---

 lib/mgmt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 276445d0a..101cf5f95 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -893,6 +893,7 @@ static const char *mgmt_op[] = {
 	"Set Appearance",
 	"Get PHY Configuration",
 	"Set PHY Configuration",
+	"Set Blocked Keys",
 };
 
 static const char *mgmt_ev[] = {
-- 
2.25.0.rc1.283.g88dfdc4193-goog

