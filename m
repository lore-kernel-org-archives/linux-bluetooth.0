Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD174C2B9F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 05:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CF8B613C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 05:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhEZFOp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 May 2021 01:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhEZFOo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 May 2021 01:14:44 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11131C061756
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 22:13:14 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id q16so36121pls.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 22:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=H2zwyia3p7d2uxe0ZBO4miRasBmJH8+968BsSYNruX4=;
        b=UX5Wv+u1n8fHxMG7kbR+dwhEgLGL764zJzx8iMvpgX3iKdoXKNXhPkv6ChzWcBWtVt
         xydigNLBlb7HX1ycNfalyiUDxSxCOHhg9qLJVP55YFZEwuKjEk0g084lv4E29gVyzokK
         m55XHO0IKJ7yNy3PuWVy3iD0QeQc1HhtgIkZmalL84RbGj5DH8Nmr5Job50CNWqoUWRc
         3OdskZ1kk12y/4hJObiNW5EBDRVV7dtnwu6ZGZHe6b2TbbZvTeRSTX7AQWhkPa+6iimo
         kCte5OknhO8UYq984PY7lrZXoOG7Cev7EgCUDTgBJA8g3LOJjiMZ1H2n2+J7uGMYqXWu
         DypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H2zwyia3p7d2uxe0ZBO4miRasBmJH8+968BsSYNruX4=;
        b=c39k8RF2FSoQzQ8FXxCvCceYvzsQnLuPsT3cmEJI5dKe5S6LaOcJkntGxbrx/KxC6j
         BQWToUN6DNsKZ6e+VlHpg4f4k5oE5n13iytMvVI3IbX9k/hEZZF/oOsFrrp7a1A/Loce
         fFKStnnns7HFWoVVitIN/atNW7oiQmJ8Cv4HPru7NMKNw7ME6NBOHgBIk+6hRZSkBYUE
         7DYMbapX4raWlQIlnISqjQzKcvMtAiiJlsMTsnfmteRoaAQH+TXv47zjOsbzxY+panJp
         yfoytB9ZxLlkPZR8Z+aH716okiKNNK98v4t3bYHdzWEOtelEigapwr/IVGuOTGZBXM81
         5mEw==
X-Gm-Message-State: AOAM5329qeHE8H17sDakwE73UBRdMJhAG+pyQxzlK8X5U46jGXSyLhTG
        OfdHo1CQiIz3DFCTrG3rdlI+hQD5rpIJHA==
X-Google-Smtp-Source: ABdhPJxsf4h8dhEkw47Bo7A3grQU15jRl65ZRME91E+ZA5mR53+x6TLQ0ZFzlstZrKyRluuU0pBTfA==
X-Received: by 2002:a17:90a:aa0a:: with SMTP id k10mr34879994pjq.33.1622005993460;
        Tue, 25 May 2021 22:13:13 -0700 (PDT)
Received: from han1-mobl3.intel.com ([2601:1c0:6a01:d830::e853])
        by smtp.gmail.com with ESMTPSA id h8sm13865944pfv.60.2021.05.25.22.13.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 22:13:13 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH V2 2/4] lib: Align mgmt header with document
Date:   Tue, 25 May 2021 22:13:08 -0700
Message-Id: <20210526051310.423630-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210526051310.423630-1-hj.tedd.an@gmail.com>
References: <20210526051310.423630-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the mgmt header to align with the mgmt api document
(doc/mgmt-api.txt)
---
 lib/mgmt.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index a85f891c5..0a6349321 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -1087,11 +1087,13 @@ static const char *mgmt_op[] = {
 	"Set PHY Configuration",
 	"Set Blocked Keys",
 	"Set Wideband Speech",
-	"Read Security Information",			/* 0x0048 */
+	"Read Controller Capabilities Information",	/* 0x0048 */
 	"Read Experimental Features Information",
 	"Set Experimental Feature",
 	"Read Default System Configuration",
 	"Set Default System Configuration",
+	"Read Default Runtime Configuration",
+	"Set Default Runtime Configuration",
 	"Get Device Flags",
 	"Set Device Flags",				/* 0x0050 */
 	"Read Advertisement Monitor Features",
@@ -1143,6 +1145,8 @@ static const char *mgmt_ev[] = {
 	"Extended Controller Information Changed",
 	"PHY Configuration Changed",
 	"Experimental Feature Changed",
+	"Default System Configuration Changed",		/* 0x0028 */
+	"Default Runtime Configuration Changed",
 	"Device Flags Changed",
 	"Advertisement Monitor Added",			/* 0x002b */
 	"Advertisement Monitor Removed",
@@ -1172,6 +1176,7 @@ static const char *mgmt_status[] = {
 	"Blocked through rfkill",
 	"Already Paired",
 	"Permission Denied",
+	"Connection Not Established",
 };
 
 #ifndef NELEM
-- 
2.26.3

