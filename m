Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF17C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 14:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15D7D61A8A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 14:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354328AbhJAOTp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Oct 2021 10:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhJAOTm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Oct 2021 10:19:42 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA91C06177E
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Oct 2021 07:17:58 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 138so9215844qko.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Oct 2021 07:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starry.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FSHGA3tXnHvQVeFSiws1NOa8MPZXtIUMcBVyxdzNy1U=;
        b=pDRiGHUEMJLKOwRMzIDYq9lugGZ8f/30ttqQa78BzlcZNQIFd4MltpNOawbhYYI0yt
         Q8AOvWcE9JhULhbm/Cd6D9iRCKhsL8nn6MlnmGAAqVX5gX1AIAu85ff6PlUBJhz9OtTN
         khf6oGGUVLAIvWY51w1P4iBJ3Xmec1AkbMepI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FSHGA3tXnHvQVeFSiws1NOa8MPZXtIUMcBVyxdzNy1U=;
        b=XiZKyF10/r8+Z1ZbXBgTzSZ0Le3ezhL/DBqGda0l6pPRctt4ZjYoDzsz8nSsT784LM
         6VqSM+QNl2+wCX0QHCS4oJWrQt8XpUbYhLB2RazcOh4G+UqKSjiNjhsM2hEe+lPfGFvu
         bjApyxzRIfALusI98pqUP0GGfox3gThVVzSyZWjhHyL8j6WcC3HczERkdW6ERhxFqN8H
         r6ebPTLcW7SLwYZsa0aQAA3KbxqIqePyKYu2CtZIPgf8LAZzgCPfDIkkPj3imIEFHN3n
         h1HmlBDxOsA/tVUjD9LNvCxVp6cYY1maTurDMoe0G8hZVb/P40HDBe+HuzLRtZduJEs3
         58uw==
X-Gm-Message-State: AOAM5322ORoxroH1eb18s13xBzVo2bCAZXe7CN1yJDRBGh29rtOrXmYl
        k8OKgOPYzKPpmuVfwj3T1nJjN15/9vnIXLGt
X-Google-Smtp-Source: ABdhPJyf4roaNzAp8B6hqFhgTbzZvG+ZpXzA6QColgrGdUXwLpqdrTVCcjEFFoXrjBKZh11h26DFDw==
X-Received: by 2002:a37:946:: with SMTP id 67mr9497409qkj.473.1633097877605;
        Fri, 01 Oct 2021 07:17:57 -0700 (PDT)
Received: from MrComputer.nevonetnext (205-201-16-55.starry-inc.net. [205.201.16.55])
        by smtp.gmail.com with ESMTPSA id u12sm3767299qtw.73.2021.10.01.07.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:17:57 -0700 (PDT)
From:   Dagan Martinez <dmartinez@starry.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Dagan Martinez <dmartinez@starry.com>
Subject: [PATCH BlueZ v4 2/2] doc/gatt-api: Add 'X-notify`/`X-indicate`
Date:   Fri,  1 Oct 2021 10:17:19 -0400
Message-Id: <20211001141719.180087-3-dmartinez@starry.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211001141719.180087-1-dmartinez@starry.com>
References: <20211001141719.180087-1-dmartinez@starry.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update docs to reflect the addition of the `X-notify` and `X-indicate`
characteristic flags, which allow a GATT server to restrict CCC write
permissions.
---
 doc/gatt-api.txt | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 120b23d1a..af0aa761d 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -253,7 +253,14 @@ Properties	string UUID [read-only]
 			Defines how the characteristic value can be used. See
 			Core spec "Table 3.5: Characteristic Properties bit
 			field", and "Table 3.8: Characteristic Extended
-			Properties bit field". Allowed values:
+			Properties bit field".
+
+			The "x-notify" and "x-indicate" flags restrict access
+			to notifications and indications by imposing write
+			restrictions on a characteristic's client
+			characteristic configuration descriptor.
+
+			Allowed values:
 
 				"broadcast"
 				"read"
@@ -267,10 +274,16 @@ Properties	string UUID [read-only]
 				"writable-auxiliaries"
 				"encrypt-read"
 				"encrypt-write"
+				"encrypt-notify" (Server only)
+				"encrypt-indicate" (Server only)
 				"encrypt-authenticated-read"
 				"encrypt-authenticated-write"
+				"encrypt-authenticated-notify" (Server only)
+				"encrypt-authenticated-indicate" (Server only)
 				"secure-read" (Server only)
 				"secure-write" (Server only)
+				"secure-notify" (Server only)
+				"secure-indicate" (Server only)
 				"authorize"
 
 		uint16 Handle [read-write, optional] (Server Only)
-- 
2.31.1

