Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D3EC4320A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29D52610E9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240408AbhHMMVk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240376AbhHMMVj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:21:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC46C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f64-20020a2538430000b0290593bfc4b046so8977769yba.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hF8RZ+lwlsVO7aNYeX/pFo55jlbe6V8EAjnVo1l7jlA=;
        b=I+ouHjB49XVR13XOL8tvXYOqv+/sfhM6LPeU6zC05BT8/4vB4uKrb+G4FDzFB8Qk7b
         U6Q4xBoTm6givijZxH1BovgGtVRFPEkCCDMS3lMwsK1KppvuL1+v25xuabiVzkkNgEbl
         U5xG9MyY+jYSVvE2mosMVvbonljjAjFYI/sBZMJNo5MJd4jgTtvEWGUmTXKm1RtBTbEJ
         PSjBfvTNYQHvjEMC+s6e6k2n+NOOG6H3SHXrD4yrnWNHbjBOf9gn60jVPmfV3DTPoGjv
         IlDyeHAvC7NNqECgANYiRzd/QxPLdsbsMlWg3+hFL+0h/eI3ck7rGSPWQfjD5C3zivZ9
         w5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hF8RZ+lwlsVO7aNYeX/pFo55jlbe6V8EAjnVo1l7jlA=;
        b=efDb8eadeWaIlFHbvupfEZABMLtScN++aSJ7uyjbql0AF4TC6oZG0phTs56DYYIQC0
         SJK4fyARw4Xi1QDTF3ZMSd/LQ8TNi7DX23cJOus6GnjhPPK3uFBn7pVbs2joZmAgm87T
         DqeyQnfOL8cf7MrZOjuLYSkfWlwFBuzvDW2tWonjqaNeAp+P0hOOBxS1B8GCegDXHPqD
         /nd+rnDC87zu+tIbu4y43JTfPLbhkYlGBD1ITIMcdY3S/1UA9QrxpworY8ePaY2ci6YK
         XanbYKZvl0g71sRnAcZWmEMaDJEnB9rlm52ain++WZbLmifTFyunRB02Kil+HW1jd6g1
         3UUQ==
X-Gm-Message-State: AOAM530lwbtzOT9M8aL5xcftmZpSNO3rsklxrhJdsmY/9qoomt4iYnZH
        Tt3DJVFOJ25fA3skhDqUQY1gmJGDtuW0dZ/Vw5p8USjm74GFukWDeIKY//YDlM4JGQfOCkUscjn
        Rij5qnV5uYgi9SsElCSdW7vjqTQFl6t3AQH4XHqURPiecyffu+NWU7+AKnxX2SYmQJolyTOSxPo
        v3
X-Google-Smtp-Source: ABdhPJxeexE5FOMVMAnlw6j3XKWF2nyy126zcg5xss+T878Y0A93XZa8e1DIx2KI6VbE2c1wadS/zAtwqymL
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a25:c2:: with SMTP id 185mr2869004yba.148.1628857271839;
 Fri, 13 Aug 2021 05:21:11 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:11 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.26.Ifdcbf84befab89586ac37d683227d61e8df73395@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 26/62] tools/parser/smp: Inclusive language changes
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"central" is preferred, as reflected in the BT core spec 5.3.
---

 tools/parser/smp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/parser/smp.c b/tools/parser/smp.c
index a372e5e5ff..733795ac68 100644
--- a/tools/parser/smp.c
+++ b/tools/parser/smp.c
@@ -28,7 +28,7 @@
 #define SMP_CMD_PAIRING_RANDOM	0x04
 #define SMP_CMD_PAIRING_FAILED	0x05
 #define SMP_CMD_ENCRYPT_INFO	0x06
-#define SMP_CMD_MASTER_IDENT	0x07
+#define SMP_CMD_CENTRAL_IDENT	0x07
 #define SMP_CMD_IDENT_INFO	0X08
 #define SMP_CMD_IDENT_ADDR_INFO	0x09
 #define SMP_CMD_SIGN_INFO	0x0a
@@ -78,8 +78,8 @@ static const char *smpcmd2str(uint8_t cmd)
 		return "Pairing Failed";
 	case SMP_CMD_ENCRYPT_INFO:
 		return "Encryption Information";
-	case SMP_CMD_MASTER_IDENT:
-		return "Master Identification";
+	case SMP_CMD_CENTRAL_IDENT:
+		return "Central Identification";
 	case SMP_CMD_IDENT_INFO:
 		return "Identity Information";
 	case SMP_CMD_IDENT_ADDR_INFO:
@@ -221,7 +221,7 @@ static void smp_cmd_encrypt_info_dump(int level, struct frame *frm)
 	printf("\n");
 }
 
-static void smp_cmd_master_ident_dump(int level, struct frame *frm)
+static void smp_cmd_central_ident_dump(int level, struct frame *frm)
 {
 	uint16_t ediv = btohs(htons(p_get_u16(frm)));
 	int i;
@@ -303,8 +303,8 @@ void smp_dump(int level, struct frame *frm)
 	case SMP_CMD_ENCRYPT_INFO:
 		smp_cmd_encrypt_info_dump(level + 1, frm);
 		break;
-	case SMP_CMD_MASTER_IDENT:
-		smp_cmd_master_ident_dump(level + 1, frm);
+	case SMP_CMD_CENTRAL_IDENT:
+		smp_cmd_central_ident_dump(level + 1, frm);
 		break;
 	case SMP_CMD_IDENT_INFO:
 		smp_cmd_ident_info_dump(level + 1, frm);
-- 
2.33.0.rc1.237.g0d66db33f3-goog

