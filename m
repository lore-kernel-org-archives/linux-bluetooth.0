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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F014C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4266F610A4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240473AbhHMMWQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240487AbhHMMWP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:22:15 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC77C0617AE
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:48 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id q11-20020a05620a05abb02903ca17a8eef8so7028633qkq.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vouSkgAMG+DVZeUk2gotEVKBasAFd5Ej/tSVjfE5nKg=;
        b=uDDOJitherBRh+PoXwYXgqBBy/NoRyadOwLkuMM0wDcsNZ/c51aq7mge9X28ZSuJo0
         Lga+fbnjyj4VCSYllHN50sKLitqii44Zj4tWmXwXBiYg6df/JdGA9q2WFUXHvBbY+whu
         q+OYA+SbAxyPEA+UJGNv4wsxNVNQuD6h6LyCAyuVKDrapkLGPnUYeJQH4WZxgM7qN+Vx
         mcEDhIpzVsYekkjaC0CpdsI4b6QEu+W1NfxEcPldjNfNCRnw+iYDSM2RHVwz6EBilfGJ
         +k+62TS0XDjyxJxJLY+TTEqTIKsXAYBGWRj1+wYhasr3CO7M6Dx8Gs8mDLLBcSraEZvb
         jZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vouSkgAMG+DVZeUk2gotEVKBasAFd5Ej/tSVjfE5nKg=;
        b=rTxBDBY67X67sHrcBQb0B8FgCh+021B9oFMM2nF73QrNIlDBeLGsSyWNtqDtB0jb19
         BTfzp3Sgei8fG572PIgMACgeojwAF6P3pIpcvF6j90lSH8qdiFLmIGRR0O59RQziro1Z
         74IOxumF3SoTZW3q9cKrxr08ZUDF1ARCTNukRoVJNVgEpqIZitIvAmVOnV3dIPn3qDll
         w3S2kBO86t8eq+r0rMTb7jQU1AmBYkn9y49AG21oPixsllvVylUoydgr1qwQ9oZW94FV
         IOXKc5f6IGsOEZgHoPxTvKVgVoNXtwXxZCqrrZ1fUBHmvBSK0ZvKh7a3p8ZGpi1u5OQS
         1kPQ==
X-Gm-Message-State: AOAM533KOx/XfynU/CFFiw4zFVrl2EMEUNq7JN/+0czPOx+iAwX581Cl
        POciZhdo2nz50XwiMikIZ7b36aR6UIeU69txYLHhjyPzAzIO2Gc3R43T0NwIxHtsvCnGPpeXQaO
        tLlsWfxhXLOxBuGtwim0UJoVxcGEFAswjYnEY2gI53ceaNeZuta905uCx0JNE/uhlhux4R2UtpL
        m2
X-Google-Smtp-Source: ABdhPJxS/31JnGZEHPZSBkB9NQ1TmgHz8lR7v3byuk8arB32wtGfGg9xW9ZWAglaUqZ7eb5bh98Iz/Kc9dd/
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a05:6214:12a2:: with SMTP id
 w2mr2373982qvu.27.1628857307655; Fri, 13 Aug 2021 05:21:47 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:21 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.36.I8543a76f6c0ff58cf40ad105102597738ad44241@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 36/62] tools/parser/csr: Inclusive language changes
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

"central" and "peripheral" are the preferred terms, as reflected in
the BT core spec 5.3.
---

 tools/parser/csr.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/parser/csr.c b/tools/parser/csr.c
index 36efc46332..bd50b1c760 100644
--- a/tools/parser/csr.c
+++ b/tools/parser/csr.c
@@ -257,7 +257,7 @@ static inline void pskey_dump(int level, struct frame *frm)
 		uint16_dump(level + 1, "MAX_SCOS", frm);
 		break;
 	case 0x000f:
-		uint16_dump(level + 1, "MAX_REMOTE_MASTERS", frm);
+		uint16_dump(level + 1, "MAX_REMOTE_CENTRALS", frm);
 		break;
 	case 0x00da:
 		uint16_dump(level + 1, "ENC_KEY_LMIN", frm);
@@ -546,7 +546,7 @@ static char *frag2str(uint8_t frag)
 void csr_dump(int level, struct frame *frm)
 {
 	uint8_t desc, cid, type;
-	uint16_t handle, master, addr;
+	uint16_t handle, central, addr;
 
 	desc = CSR_U8(frm);
 
@@ -576,12 +576,13 @@ void csr_dump(int level, struct frame *frm)
 				return;
 			case 0x12:
 				handle = CSR_U16(frm);
-				master = CSR_U16(frm);
+				central = CSR_U16(frm);
 				addr = CSR_U16(frm);
 				p_indent(level, frm);
-				printf("FHS: handle %d addr %d (%s)\n", handle,
-					addr, master ? "master" : "slave");
-				if (!master) {
+				printf("FHS: handle %d addr %d (%s)\n",
+					handle, addr,
+					central ? "central" : "peripheral");
+				if (!central) {
 					char addr[18];
 					p_ba2str((bdaddr_t *) frm->ptr, addr);
 					p_indent(level + 1, frm);
-- 
2.33.0.rc1.237.g0d66db33f3-goog

